Jumps
     TITLE	CPUProcs
     DOSSEG
     .model	small

CPU_ID	MACRO
	db	0fh		; Hardcoded CPUID instruction
	db	0a2h
ENDM

.data
        EXTRN   CPU_Family:Byte
 	EXTRN   fpu_type : Byte
        EXTRN   Reg_EAX:Dword
        EXTRN   Reg_EBX:Dword
        EXTRN   Reg_ECX:Dword
        EXTRN   Reg_EDX:Dword

                fp_status	dw	0

	.code

public  _is_cpuid_supported
public  _Execute_Function_and_get_Regs
public	_Old_Intel_CPU_Check
public  _is_cyrix
public	_get_fpu_type
public _isv86

;**************************************************************************
;       Function:	int is_cpuid_supported ()
;
;       Purpose:        Check for existence of CPUID instruction.
;                       If exists execute CPUID with eax==0.
;
;       Inputs:         none
;
;       Output:
;
;       Returns:        0 - no CPUID instruction supported
;                       1 - CPUID instruction supported
;**************************************************************************

_is_cpuid_supported        proc	far
.386
	push	bp
	mov	bp, sp
        sub     sp, 40

        push    eax
        push    ebx

        pushfd                  ; get extended flags
        pop     eax
        mov     ebx, eax        ; save current flags

        xor     eax, 200000h    ; toggle bit 21
        push    eax             ; put new flags on stack
        popfd                   ; flags updated now in flags

        pushfd                  ; get extended flags
        pop     eax
        xor     eax, ebx        ; if bit 21 r/w then eax <> 0

        pop     ebx
        pop     eax

        je      no_cpuid        ; can't toggle id bit (21) no cpuid here

        mov     ax, 1           ; cpuid supported

        jmp     done_cpuid_sup

no_cpuid:
        mov     ax, 0           ; cpuid not supported

done_cpuid_sup:
        mov     sp, bp
        pop     bp
	ret
_is_cpuid_supported        endp




;*********************************************************************
_Execute_Function_and_get_Regs  proc far
ARG   Function:dword
.486
		push	bp
		mov	bp,sp

	        mov	eax,function		; set up for CPUID instruction
	        CPU_ID			; get and save vendor ID

                mov     Reg_EAX,eax
                mov     Reg_EBX,ebx
                mov     Reg_ECX,ecx
                mov     Reg_EDX,edx

                mov     sp,bp
		pop	bp
		ret
_Execute_Function_and_get_Regs   endp

;*********************************************************************

_Old_Intel_cpu_Check	proc far

;	This procedure determines the type of processor in a system
;	and sets the _cpu_type variable with the appropriate
;	value.  If the CPUID instruction is available, it is used
;	to determine more specific details about the processor.
;	All registers are used by this procedure, none are preserved.
;	To avoid AC faults, the AM bit in CR0 must not be set.

;	Intel 8086 processor check
;	Bits 12-15 of the FLAGS register are always set on the
;	8086 processor.

	.8086
check_8086:
	pushf			; push original FLAGS
	pop	ax		; get original FLAGS
	mov	cx, ax		; save original FLAGS
	and	ax, 0fffh	; clear bits 12-15 in FLAGS
	push	ax		; save new FLAGS value on stack
	popf			; replace current FLAGS value
	pushf			; get new FLAGS
	pop	ax		; store new FLAGS in AX
	and	ax, 0f000h	; if bits 12-15 are set, then
	cmp	ax, 0f000h	;   processor is an 8086/8088
	mov	cpu_Family, 0	; turn on 8086/8088 flag
	je	end_cpu_type	; jump if processor is 8086/8088

;	Intel 286 processor check
;	Bits 12-15 of the FLAGS register are always clear on the
;	Intel 286 processor in real-address mode.

	.286
check_80286:
	or	cx, 0f000h	; try to set bits 12-15
	push	cx		; save new FLAGS value on stack
	popf			; replace current FLAGS value
	pushf			; get new FLAGS
	pop	ax		; store new FLAGS in AX
	and	ax, 0f000h	; if bits 12-15 are clear
	mov	cpu_family, 2	; processor=80286, turn on 80286 flag
	jz	end_cpu_type	; if no bits set, processor is 80286

;	Intel386 processor check
;	The AC bit, bit #18, is a new bit introduced in the EFLAGS
;	register on the Intel486 processor to generate alignment
;	faults.
;	This bit cannot be set on the Intel386 processor.

	.386			; it is safe to use 386 instructions
check_80386:
	pushfd			; push original EFLAGS
	pop	eax		; get original EFLAGS
	mov	ecx, eax	; save original EFLAGS
	xor	eax, 40000h	; flip AC bit in EFLAGS
	push	eax		; save new EFLAGS value on stack
	popfd			; replace current EFLAGS value
	pushfd			; get new EFLAGS
	pop	eax		; store new EFLAGS in EAX
	xor	eax, ecx	; can't toggle AC bit, processor=80386
	mov	cpu_family, 3	; turn on 80386 processor flag
	jz	end_cpu_type	; jump if 80386 processor

	push	ecx
	popfd			; restore AC bit in EFLAGS first

;	Intel486 processor check
;	Checking for ability to set/clear ID flag (Bit 21) in EFLAGS
;	which indicates the presence of a processor with the CPUID
;	instruction.

	.486
check_80486:
	mov	cpu_family, 4	; turn on 80486 processor flag
	mov	eax, ecx	; get original EFLAGS
	xor	eax, 200000h	; flip ID bit in EFLAGS
	push	eax		; save new EFLAGS value on stack
	popfd			; replace current EFLAGS value
	pushfd			; get new EFLAGS
	pop	eax		; store new EFLAGS in EAX
	xor	eax, ecx	; can't toggle ID bit,
	je	end_cpu_type	; processor=80486

;	Execute CPUID instruction to determine vendor, family,
;	model, stepping and features.  For the purpose of this
;	code, only the initial set of CPUID information is saved.

	.8086
end_cpu_type:
	ret
_Old_Intel_Cpu_check	endp

;**************************************************************************
;       Function:	int iscyrix ()
;
;       Purpose:        Determine if Cyrix CPU is present
;       Technique:      Cyrix CPUs do not change flags where flags change
;                        in an undefined manner on other CPUs
;       Inputs:         none
;       Output:         ax == 1 Cyrix present, 0 if not
;**************************************************************************
_is_cyrix   proc	far
           .486
           xor   ax, ax         ; clear ax
           sahf                 ; clear flags, bit 1 is always 1 in flags
           mov   ax, 5
           mov   bx, 2
           div   bl             ; do an operation that does not change flags
           lahf                 ; get flags
           cmp   ah, 2          ; check for change in flags
           jne   not_cyrix      ; flags changed not Cyrix
           mov   ax, 1          ; TRUE Cyrix CPU
           jmp   done_is_cyrix

not_cyrix:
           mov  ax, 0           ; FALSE NON-Cyrix CPU
done_is_cyrix:
           ret
_is_cyrix   endp

;*********************************************************************

_get_fpu_type	proc far

;	This procedure determines the type of FPU in a system
;	and sets the _fpu_type variable with the appropriate value.
;	All registers are used by this procedure, none are preserved.

;	Coprocessor check
;	The algorithm is to determine whether the floating-point
;	status and control words are present.  If not, no
;	coprocessor exists.  If the status and control words can
;	be saved, the correct coprocessor is then determined
;	depending on the processor type.  The Intel386 processor can
;	work with either an Intel287 NDP or an Intel387 NDP.
;	The infinity of the coprocessor must be checked to determine
;	the correct coprocessor type.

	fninit			; reset FP status word
	mov	fp_status, 5a5ah; initialize temp word to non-zero
	fnstsw	fp_status	; save FP status word
	mov	ax, fp_status	; check FP status word
	cmp	al, 0		; was correct status written
	mov	fpu_type, 0	; no FPU present
	jne	end_fpu_type

check_control_word:
	fnstcw	fp_status	; save FP control word
	mov	ax, fp_status	; check FP control word
	and	ax, 103fh	; selected parts to examine
	cmp	ax, 3fh		; was control word correct
	mov	fpu_type, 0
	jne	end_fpu_type	; incorrect control word, no FPU
	mov	fpu_type, 1

;	80287/80387 check for the Intel386 processor

check_infinity:
	cmp	cpu_family, 3
	jne	end_fpu_type
	fld1			; must use default control from FNINIT
	fldz			; form infinity
	fdiv			; 8087/Intel287 NDP say +inf = -inf
	fld	st		; form negative infinity
	fchs			; Intel387 NDP says +inf <> -inf
	fcompp			; see if they are the same
	fstsw	fp_status	; look at status from FCOMPP
	mov	ax, fp_status
	mov	fpu_type, 2	; store Intel287 NDP for FPU type
	sahf			; see if infinities matched
	jz	end_fpu_type	; jump if 8087 or Intel287 is present
	mov	fpu_type, 3	; store Intel387 NDP for FPU type
end_fpu_type:
	ret
_get_fpu_type	endp

;**************************************************************************
;       Function:	isv86()
;
;       Purpose:        Determine if CPU is in REAL or V86
;       Technique:      Check PE bit.  If set then assume V86.
;                       *** Note ***  This technique only works
;                                     for distinguishing V86 vs REAL.
;                                     IT does not hold for anything else!
;       Inputs:         none
;       Output:         ax == 1 in V86 mode, else 0
;**************************************************************************

_isv86 proc far
        .486P
        smsw    ax
        test    al, 1
        jz      no_v86
        mov     ax, 1
        jmp     done

no_v86:
        mov     ax, 0
done:
        ret
_isv86 endp
end