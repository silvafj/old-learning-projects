
;*********************************************************************

	public	gethardwareBitsField
gethardwareBitsField	proc

	.486
        push    eax
        push    ebx
        push    ecx
        push    edx
        Int     11h

        mov     HardWareBitsField, eax

        pop    edx
        pop    ecx
        pop    ebx
        pop    eax

	ret
gethardwareBitsField    endp

	end
