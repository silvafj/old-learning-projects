Unit DPMI; { DPMI Unit }

{ ************************      INTERFACE      ******************************}
{                         *********************                              }
INTERFACE

  Type
    tDpmiRegs  = Record
                   edi,
                   esi,
                   ebp,
                   reserved,
                   ebx,
                   edx,
                   ecx,
                   eax : dword;
                   flags    : word;
                   es,
                   ds,
                   fs,
                   gs,
                   ip,
                   cs,
                   sp,
                   ss : word;
                 End;

  Var
    dpmiinstalled:boolean;

{ -_-_-_-_-_-_-_-_-_-_-_-_-_-_ Public rotines -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-}

  procedure callint(intnr:byte;var dpmiregs:tdpmiregs);
  function  checkdpmi:boolean;
  function  InitDpmi:boolean;

{ ************************    IMPLEMENTATION   ******************************}
{                         *********************                              }
IMPLEMENTATION

  Uses
    DOS,Math;

{ ======================== Unit                  =========================== }
{ ========================      Internal         =========================== }
{ ========================               Rotines =========================== }
{                         ***********************                            }

  procedure dumpdpmiregs(dpmiregs:tdpmiregs);
  begin
    write  ('EAX = ',dhex(dpmiregs.eax),'   EBX = ',dhex(dpmiregs.ebx),'      ');
    writeln('ECX = ',dhex(dpmiregs.ecx),'   EDX = ',dhex(dpmiregs.edx));
    write  ('ESI = ',dhex(dpmiregs.esi),'   EDI = ',dhex(dpmiregs.edi),'      ');
    writeln('EBP = ',dhex(dpmiregs.ebp),' FLAGS = ',whex(dpmiregs.flags));
    write  (' CS =      ',whex(dpmiregs.cs),'    IP =      ',whex(dpmiregs.ip),'      ');
    writeln(' DS =      ',whex(dpmiregs.ds),'    ES =      ',whex(dpmiregs.es));
    write  (' FS =      ',whex(dpmiregs.fs),'    GS =      ',whex(dpmiregs.gs),'      ');
    writeln(' SS =      ',whex(dpmiregs.ss),'    SP =      ',whex(dpmiregs.sp));
{    readkey;}
  end;
{
  procedure callint(intnr:byte;var dpmiregs:tdpmiregs);
  begin
    dpmiregs.sp:=0;
    dpmiregs.ss:=0;
    writeln('  ## callint to             : ',bhex(intnr));
    writeln('  ## registers before call  : ');
    dumpdpmiregs(dpmiregs);
    asm
    mov    eax,$00000300
    xor    ebx,ebx
    mov    bl,intnr
    xor    ecx,ecx
    mov    edi,dpmiregs
    int    31h
    end;
    writeln('  ## registers after call   : ');
    dumpdpmiregs(dpmiregs);
  end;
}
  procedure callint(intnr:byte;var dpmiregs:tdpmiregs);code;
  asm
    mov    eax,$00000300
    xor    ebx,ebx
    mov    bl,byte ptr [intnr]
    xor    ecx,ecx
    mov    edi,[dpmiregs]
    mov    dword ptr [edi+44],$00000000
    int    31h
    ret    8
  end;

  function  checkdpmi:boolean;
    var
      w:word;
  begin
    asm
      push   ebp
      push   ds es
      mov    ax,$1686
      int    $2f
      mov    w,ax
      pop    es ds
      pop    ebp
      push   ebp
      push   ds es
      mov    ax,$1687
      int    $2f
      and    w,ax
      pop    es ds
      pop    ebp
    end;
    checkdpmi:=w=0;
  end;

function  Initdpmi:boolean;

  var
    PMode_Entry_Seg,PMode_Entry_Off : word;
    w : word;

  begin
    asm
      mov     w,0
      mov     ax, 1687h
      int     2Fh
      test    ax, ax
      jnz     @Cant_Enter_PMode
      mov     [PMode_Entry_Seg], es
      mov     [PMode_Entry_Off], di

      test    si, si
      jz      @Enter_PMode_Now
      mov     bx, si
      mov     ah, 48h
      int     21h
      jc      @Cant_Enter_PMode
      mov     es, ax

     @Enter_PMode_Now:
      xor     ax, ax
      call    DWORD PTR [PMode_Entry_Off]
      jc      @Cant_Enter_PMode
      mov     w,0
      jmp     @Init

    @Cant_Enter_PMode:
      mov     w,1

    @Init:
    end;
    Initdpmi:=w=0;
  end;

Begin
  dpmiinstalled := checkdpmi;
End.