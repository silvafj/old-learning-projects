{$A+} { Align Data Switch }
{$B-} { Boolean Evaluation Switch }
{$D-} { Debug Information Switch }
{$E-} { Emulation Switch - this doesn't affect a unit only a program }
{$F-} { Force Far Calls Switch }
{$G+} { Generate 80286 Code Switch }
{$I-} { Input/Output-Checking Switch }
{$I Defines.INC} { This file is used to define some conditionals according   }
{ with user preferences.                                                     }
{$L-} { Local Symbol Information Switch }
{$N+} { Numeric Coprocessor Switch }
{$Q-} { Overflow Checking Switch }
{$R-} { Range-Checking Switch }
{$S-} { Stack-Overflow Checking Switch }
{$V-} { Var-String Checking Switch }
{$Y+} { Symbol Reference Information Switch - just afect the Unit size, and }
      { it's very good when you run BP, because you can go directly to the  }
      { line where the source begins! Study, to know more!!!                }
Unit HardWare;

{ ************************      INTERFACE      ******************************}
{                         *********************                              }
INTERFACE

  Type
    { Processor }
    FeaturesRec = Record
                    FPU, { Floating-Point Unit on-chip }
                    VME, { Virtual Mode Extension }
                    DE,  { Debugging extension }
                    PSE, { Page Size Extension }
                    TSC, { Time Stamp Counter }
                    MSR, { Model Specific Registers }
                    PAE, { Physical Address Extension }
                    MCE, { Machine Check Extension }
                    CX8, { CMPXCHG8B Instruction Supported }
                    APIC,{ On-Chip APIC Hardware Supported }
                    SEP, { Fast System Call }
                    MTRR,{ Memory Type Range Registers }
                    PGE, { Page Global Enable }
                    MCA, { Machine Check Architecture }
                    CMOV,{ Conditional Move Instruction Supported }
                    MMX:Boolean; { Intel Architecture MMX tecnology supported }
                  End;

    CPURec = Record
               CPU_Type_Value:Byte;
               CPU_Family_Value:Byte;
               CPU_Model_Value:Byte;
               CPU_Stepping_Value:Byte;
               CPU_Type_Name:String[44];
               CPU_Family_Name:String[55];
               CPU_Model_Name:String[72];
               CPU_Stepping_Name:String[2];
               FPU_Type_Value:Byte;
               FPU_Type_Name:String[44];
               VendorString:String[20];
               Intel_CPU:Boolean;
               Cyrix_CPU:Boolean;
               AMD_CPU:Boolean;
               CpuID_Supported:Boolean;
               MaxLevelFunction:Longint;
               SupportExtendedFunctions:Boolean;
               StandardFeaturesReg:longint;
               IsV86:Boolean;
               Features:FeaturesRec;
             End;

    { BIOS }
    ConfigROM = Record
                  NumberOfBytes:Word;
                  Model:Byte;
                  SubModel:Byte;
                  BIOSRevision:Byte;
                  Features1:byte;
                  Features2:byte;
                  Features3:byte;
                  Features4:byte;
                  Features5:byte;
                  Award:string;
                End;

    { CMOS }
    CMOSRec = Record
                Found     : Boolean;  { was a CMOS found to exist }
                CmosDate  : String[30]; { the date found in CMOS }
                CmosTime  : String[30]; { the time found in CMOS }
                VideoType : String[10]; { Type of video found in CMOS }
                Coproc    : Boolean;  { does CMOS report a math coprocessor }
                FloppyA   : String[12]; { type of floppy drive for A }
                FloppyB   : String[12]; { Type of floppy drive for B }
                Hard0     : Byte;     { Type of hard drive for drive 0 }
                Hard1     : Byte;     { Type of hard drive for Drive 1 }
                ConvenRam : Word;     { amount of conventional ram indicated }
                ExtendRam : Word;     { amount of extended Ram indicated }
                CheckSum  : Boolean;  { Did checksum pass }
              End; { CMOS Rec }
  { ....... }
       bpbRec=record
                 bytesPerSect:word;
                 sectsPerClust:byte;
                 reservedSects:word;
                 numOfFats:byte;
                 numOfRootEntries:word;
                 totalSects:word;
                 mediaDescriptorByte:byte;
                 sectsPerFat:word;
               end;

       bootRec=record
                  jump:String[9];
                  oem:String[8];
                  bpb:bpbRec;
                  sectsPerTrack:word;
                  numOfHeads:word;
                  numOfHiddenSects:word;
                  dummy:String[27];
                  serialNumber:String[9];  {offset 27H}
                  volumeId:String[30];     {offset 2BH}
{                  bootStrapCode:array[0..461] of byte;}
                end;

    CardType = (None,MDA,CGA,EGAMono,EGAColor,
                VGAMono,VGAColor,MCGAMono,MCGAColor);


  Var
    CPU:CPURec;
    ROM:ConfigROM;
    CMOS : CMOSRec;   { variable to hold CMOS data }
    Boot : BootRec;

{ Public rotines }
PROCEDURE GetCPUInformation;
FUNCTION FloppyDiskInstalled(Var Number:Byte):Boolean;
FUNCTION VideoCard(Var InstMem:Integer): CardType;
FUNCTION CoProcessorInstalled:Boolean;
FUNCTION PSInstalled:Boolean;
FUNCTION InitialVideoMode:Byte;
FUNCTION DMAInstalled:Boolean;
FUNCTION SerialPorts:Byte;
FUNCTION GamePortInstalled:Boolean;
FUNCTION InternalModemInstalled:Boolean;
FUNCTION ParallelPorts:Byte;
Function GetConfiguration:Byte;
FUNCTION BIOSDate:String;
Procedure GetCMos;
Function lerSector(drive,pista,face,primSect,numSects:byte):boolean;
Function LocalAnsiDetected : Boolean;
Function RunningUnderMSWindows : boolean;

{ ************************    IMPLEMENTATION   ******************************}
{                         *********************                              }
IMPLEMENTATION

  Uses
    Dos,Math;

    Type
    ConfigROMTableREC=Record
                     NumberOfBytes:Word;
                     Model:Byte;
                     SubModel:Byte;
                     BIOSRevision:Byte;
                     Features1:byte;
                     Features2:byte;
                     Features3:byte;
                     Features4:byte;
                     Features5:byte;
                     Award:string;
                   End;
    ConfigROMTablePtr=^ConfigROMTableREC;

       bpb_rec=record
                 bytesPerSect:word;
                 sectsPerClust:byte;
                 reservedSects:word;
                 numOfFats:byte;
                 numOfRootEntries:word;
                 totalSects:word;
                 mediaDescriptorByte:byte;
                 sectsPerFat:word;
               end;

       boot_rec=record
                  jump:array[0..2] of byte;
                  oem:array[0..7] of byte;
                  bpb:bpb_rec;
                  sectsPerTrack:word;
                  numOfHeads:word;
                  numOfHiddenSects:word;
                  dummy:array[0..8] of byte;
                  serialNumber:array[0..3] of byte;  {offset 27H}
                  volumeId:array[0..10] of byte;     {offset 2BH}
                  bootStrapCode:array[0..461] of byte;
                end;

  Const
    FPU_FLAG       =0; { Floating-Point Unit on-chip }
    VME_FLAG       =1; { Virtual Mode Extension }
    DE_FLAG        =2; { Debugging extension }
    PSE_FLAG       =3; { Page Size Extension }
    TSC_FLAG       =4; { Time Stamp Counter }
    MSR_FLAG       =5; { Model Specific Registers }
    PAE_FLAG       =6; { Physical Address Extension }
    MCE_FLAG       =7; { Machine Check Extension }
    CX8_FLAG       =8; { CMPXCHG8B Instruction Supported }
    APIC_FLAG      =9; { On-Chip APIC Hardware Supported }
    SEP_FLAG       =11; { Fast System Call }
    MTRR_FLAG      =12; { Memory Type Range Registers }
    PGE_FLAG       =13; { Page Global Enable }
    MCA_FLAG       =14; { Machine Check Architecture }
    CMOV_FLAG      =15; { Conditional Move Instruction Supported }
    MMX_FLAG       =23; { Intel Architecture MMX tecnology supported }

    CPUTypeIntel: Array [0..2] OF String[44] =('Original OEM Processor',
                                               'OverDrive(TM) Upgrade Processor',
                                               'Upgrade processor in a dual processor system');

    CPUFamilyIntel: Array [0..6] OF String[27] =('8086',
                                                 '80186',
                                                 '80286',
                                                 '80386',
                                                 '80486',
                                                 'Intel Pentium(TM) processor',
                                                 'Intel P6(TM) processor');

    CPUModelIntel0: Array [4..6,0..8] OF String[72] =(('Genuine Intel486(TM) DX processor',
{                          ^^^^ ^^^^     }             'Genuine Intel486(TM) DX processor',
{                           |    Model   }             'Genuine Intel486(TM) SX processor',
{	                    Family       }             'Genuine IntelDX2(TM) or Intel487(TM) or IntelDX2 Overdrive(TM) processor',
	                                               'Genuine Intel486(TM) SL processor',
	                                               'Genuine IntelSX2(TM) processor',
	                                               'Genuine Write-Back Enhanced IntelDX2(TM) processor',
	                                               'Genuine IntelDX4(TM) processor',
                                                       'Genuine IntelDX4(TM) Overdrive(TM) processor'),
                                                      ('Unknown Genuine Intel processor',
                                                       'Genuine Intel Pentium(TM) Processores 60 and 66 MHz ',
                                                       'Genuine Intel Pentium(TM) Processores 75 - 200 MHz',
                                                       'Unknown Genuine Intel processor',
                                                       'Unknown Genuine Intel processor',
                                                       'Unknown Genuine Intel processor',
                                                       'Genuine Intel Pentium with MMX(TM) tecnology 166 and 200 MHz',
                                                       'Unknown Genuine Intel processor',
                                                       'Unknown Genuine Intel processor'),
                                                      ('Unknown Genuine Intel processor',
                                                       'Genuine Intel Pentium Pro Processor',
                                                       'Genuine Intel Pentium II Processor',
                                                       'Unknown Genuine Intel processor',
                                                       'Unknown Genuine Intel processor',
                                                       'Unknown Genuine Intel processor',
                                                       'Unknown Genuine Intel processor',
                                                       'Unknown Genuine Intel processor',
                                                       'Unknown Genuine Intel processor'));

    CPUFamilyCyrix: Array [0..6] OF String[20] =('',
                                                 '',
                                                 '',
                                                 '',
                                                 '',
                                                 'Cyrix 6x86 processor',
                                                 'Cyrix m2 processor');

  { values of constants for CMOS }
  DayName: array[0..7] of string[9] = ('Sunday', 'Monday', 'Tuesday',
                                       'Wednesday', 'Thursday', 'Friday',
                                       'Saturday', 'Sunday');
  MonthName: array[0..12] of string[9] = ('???', 'January', 'February', 'March',
                                          'April', 'May', 'June', 'July',
                                          'August', 'September', 'October',
                                          'November', 'December');
  ScreenName: array[0..3] of string[10] = ('EGA/VGA', 'CGA 40col',
                                           'CGA 80col', 'Monochrome');
  FloppyName: array[0..5] of string[11] = ('none', '5.25" 360K',
                                           '5.25" 1.2M', '3.5"  720K',
                                           '3.5"  1.44M', '3.5"  2.88M');
  CMOSport : Byte = $70; { port to access the CMOS }

  Var
    Regs:Registers;
    CPU_Family:Byte;
    FPU_Type : Byte;
    Reg_EAX,Reg_EBX,Reg_ECX,Reg_EDX:Longint;
    HardWareBitsField : Longint;


{$L CPUProcs.OBJ}
  FUNCTION  _is_cpuid_supported:byte;FAR;EXTERNAL;
  PROCEDURE _Execute_Function_and_get_Regs(Number:longint);FAR;EXTERNAL;
  PROCEDURE _Old_Intel_CPU_Check; FAR;EXTERNAL;
  FUNCTION  _is_Cyrix:Byte; FAR;EXTERNAL;
  PROCEDURE _Get_Fpu_Type; FAR;EXTERNAL;
  FUNCTION  _isv86:Byte;FAR;EXTERNAL;
{  PROCEDURE gethardwareBitsField; EXTERNAL;}

{----------------------------------------------------------------------------}
{                                                                            }
{ VideoCard                                                                  }
{           - Description : Detects what type of card the system has         }
{           - Input       : InstMem --> Here you should put a variavel name  }
{                           so you can return the value to that variavel     }
{           - Return      : The name of the card type of the array CardType  }
{                           And the value of installed memory                }
{----------------------------------------------------------------------------}
FUNCTION VideoCard(Var InstMem:Integer): CardType;

  Var
    Code : Byte;

  Begin
    Regs.AH := $1A;      { Use function $1A of the... }
    Regs.AL := $00;
    Intr($10, Regs);     { ... interrupt $10 }
    IF Regs.AL = $1A THEN
      Begin
        Case Regs.BL OF
          $00 : VideoCard := None;
          $01 : VideoCard := MDA;
          $02 : VideoCard := CGA;
          $04 : VideoCard := EGAColor;
          $05 : VideoCard := EGAMono;
          $07 : VideoCard := VGAMono;
          $08 : VideoCard := VGAColor;
          $0A,
          $0C : VideoCard := MCGAColor;
          $0B : VideoCard := MCGAMono;
         ELSE
           VideoCard := CGA
        End;
      End
    ELSE
      Begin
        Regs.AH := $12;         { Use another Function $12  }
        Regs.BL := $10;         { Return EGA info }
        Intr($10, Regs);        { Call Interrup $10 Video Functions }
        IF Regs.BX <> $10 THEN  { BX unchanged means EGA is not present }
          BEGIN
            Regs.AH := $12;      { Call another time }
            Regs.BL := $10;
            Intr($10, Regs);
            IF Regs.BH = 0 THEN
              VideoCard := EGAColor
            ELSE
              VideoCard := EGAMono;
          End
        ELSE
          Begin
            Intr($11, Regs);     (* Equipment determination service *)
            Code := (Regs.AL AND $30) SHR 4;
            IF (Code = 3) THEN
              VideoCard := MDA
            ELSE
              VideoCard := CGA
          End;
      End;
    Regs.AH := $12;      { Call once again $12... }
    Regs.BL := $10;
    Intr($10, Regs);
    InstMem:=(Regs.BL+1)*64;  { ...to check the video mem }
  End; { VideoCard }


{ CPU } { CPU } { CPU } { CPU }
{ CPU } { CPU } { CPU } { CPU }
{ CPU } { CPU } { CPU } { CPU }
PROCEDURE ExecuteFunction(Level:longint; VAR RegEAX,RegEBX,RegECX,RegEDX:Longint);
  Begin
    RegEAX:=0;
    RegEBX:=0;
    RegECX:=0;
    RegEDX:=0;
    _Execute_Function_And_Get_Regs(Level);
    RegEAX:=Reg_EAX;
    RegEBX:=Reg_EBX;
    RegECX:=Reg_ECX;
    RegEDX:=Reg_EDX;
  End;

PROCEDURE GetCPUInformation;

  Var
    TempStr:String;
    RegEAX,RegEBX,RegECX,RegEDX:Longint;
    ValueBX:Longint;
    ValueDX:Longint;
    ValueCX:Longint;
    Cpu_Signature:longint;

  Begin
    FillChar(CPU,Sizeof(CPU),#0);  { Empty the CPURec array }
    CPU.CPUID_Supported:=_is_cpuid_supported=1;
    IF CPU.CPUID_Supported Then { If support the new way of detecting the CPU }
      Begin
        TempStr:='';
        ExecuteFunction(0,RegEAX,RegEBX,RegECX,RegEDX);
        CPU.MaxLevelFunction:=RegEAX;
        CPU.SupportExtendedFunctions:=CPU.MaxLevelFunction > 1;
        ValueBX:=RegEBX AND $FFFF;
        TempStr:=Char(lo(ValueBX))+Char(hi(ValueBX));
        ValueBX:=RegEBX SHR 16 AND $FFFF;
        TempStr:=TempStr+Char(lo(ValueBX))+Char(hi(ValueBX));
        ValueDX:=RegEDX AND $FFFF;
        TempStr:=TempStr+Char(lo(ValueDX))+Char(hi(ValueDX));
        ValueDX:=RegEDX SHR 16 AND $FFFF;
        TempStr:=TempStr+Char(lo(ValueDX))+Char(hi(ValueDX));
        ValueCX:=RegECX AND $FFFF;
        TempStr:=TempStr+Char(lo(ValueCX))+Char(hi(ValueCX));
        ValueCX:=RegECX SHR 16 AND $FFFF;
        TempStr:=TempStr+Char(lo(ValueCX))+Char(hi(ValueCX));
        CPU.VendorString:=TempStr;
        IF CPU.VendorString='GenuineIntel' Then CPU.Intel_CPU := True;
        IF CPU.VendorString='CyrixInstead' Then CPU.Cyrix_CPU := True;
        IF CPU.VendorString='AuthenticAMD' Then CPU.AMD_CPU := True;
        IF CPU.MaxLevelFunction>0 Then
          Begin
            ExecuteFunction(1,Cpu_Signature,RegEAX,RegEAX,CPU.StandardFeaturesReg);
            CPU.CPU_Type_Value := cpu_signature shr 11 and $F;
            CPU.CPU_Family_Value := cpu_signature shr 8 and $F;
            CPU.CPU_Model_Value := cpu_signature shr 4 and $F;
            CPU.CPU_Stepping_Value := cpu_signature AND $F;
          End;
        IF (CPU.Intel_CPU OR CPU.Cyrix_CPU) AND CPU.SupportExtendedFunctions Then
          Begin
            ExecuteFunction(2,Cpu_Signature,RegEAX,RegEAX,CPU.StandardFeaturesReg);
          End;
        _Get_Fpu_Type;
        CPU.IsV86:=_IsV86=1;
        CPU.FPU_Type_Value:=FPU_Type;
        IF CPU.intel_CPU Then
          Begin
	    CPU.CPU_Type_Name:=CpuTypeIntel[cpu.Cpu_Type_Value];
	    CPU.CPU_Family_Name:=CPUFamilyIntel[cpu.CPU_Family_Value];
	    CPU.CPU_Model_Name:=CPUModelIntel0[cpu.CPU_Family_Value,cpu.CPU_Model_Value];
	    CPU.CPU_Stepping_Name:=DelLeftZeros(Long2Hex(CPU.CPU_Stepping_Value));
          End;
            CPU.Features.FPU:=TestBit(FPU_FLAG,CPU.StandardFeaturesReg,1);
            CPU.Features.VME:=TestBit(VME_FLAG,CPU.StandardFeaturesReg,1);
            CPU.Features.DE:=TestBit(DE_FLAG,CPU.StandardFeaturesReg,1);
            CPU.Features.PSE:=TestBit(PSE_FLAG,CPU.StandardFeaturesReg,1);
            CPU.Features.TSC:=TestBit(TSC_FLAG,CPU.StandardFeaturesReg,1);
            CPU.Features.MSR:=TestBit(MSR_FLAG,CPU.StandardFeaturesReg,1);
            CPU.Features.PAE:=TestBit(PAE_FLAG,CPU.StandardFeaturesReg,1);
            CPU.Features.MCE:=TestBit(MCE_FLAG,CPU.StandardFeaturesReg,1);
            CPU.Features.CX8:=TestBit(CX8_FLAG,CPU.StandardFeaturesReg,1);
            CPU.Features.APIC:=TestBit(APIC_FLAG,CPU.StandardFeaturesReg,1);
            CPU.Features.SEP:=TestBit(SEP_FLAG,CPU.StandardFeaturesReg,1);
            CPU.Features.MTRR:=TestBit(MTRR_FLAG,CPU.StandardFeaturesReg,1);
            CPU.Features.PGE:=TestBit(PGE_FLAG,CPU.StandardFeaturesReg,1);
            CPU.Features.MCA:=TestBit(MCA_FLAG,CPU.StandardFeaturesReg,1);
            CPU.Features.CMOV:=TestBit(CMOV_FLAG,CPU.StandardFeaturesReg,1);
            CPU.Features.MMX:=TestBit(MMX_FLAG,CPU.StandardFeaturesReg,1);
      End
    Else { If doesn't support the new CPUID checking function, we have to }
      Begin  { use old ways to check the CPU }
        _Old_Intel_CPU_Check;
        CPU.CPU_Family_Value:=CPU_Family;
        CPU.FPU_Type_Value:=FPU_Type;
        Case CPU_family OF
          0: Begin
               CPU.CPU_Family_Name:='8086/8088 processor';
	       if (CPU.fpu_type_Value=1) Then CPU.fpu_type_Name:='8087 math coprocessor';
             End;
          2: Begin
               CPU.CPU_Family_Name:='80286 processor';
	       if (CPU.fpu_type_Value=1) Then CPU.fpu_type_Name:='80287 math coprocessor';
             End;
          3: Begin
               CPU.CPU_Family_Name:='80386/8088 processor';
	       if (CPU.fpu_type_Value=2) Then CPU.fpu_type_Name:='80287 math coprocessor'
               else CPU.fpu_type_Name:='80387 math coprocessor';
             End;
	  4: Begin
	      if (CPU.fpu_type_Value=1) Then CPU.CPU_Family_Name:='80486DX, 80486DX2 processor or 80487SX math coprocessor'
	      else cpu.cpu_Family_Name:='80486SX processor';
             End;
          else CPU.CPU_Family_Name:='unknown processor';
        End;
      End;
  End;  { GetCPUInformation }

{ BIOS }{ BIOS }{ BIOS }{ BIOS }{ BIOS }
{ BIOS }{ BIOS }{ BIOS }{ BIOS }{ BIOS }
{ BIOS }{ BIOS }{ BIOS }{ BIOS }{ BIOS }
{ BIOS }{ BIOS }{ BIOS }{ BIOS }{ BIOS }
FUNCTION FloppyDiskInstalled(Var Number:Byte):Boolean;

  Begin
    FloppyDiskInstalled:=False;
    IF TestBit(0,HardWareBitsField,1) Then
      Begin
        FloppyDiskInstalled:=True;
        Number := ((HardWareBitsField SHR 6) AND $3) + 1;
      End
    Else Number:=0;
  End;

FUNCTION CoProcessorInstalled:Boolean;

  Begin
    CoProcessorInstalled:=False;
    IF TestBit(1,HardWareBitsField,1) Then CoProcessorInstalled:=True;
  End;

FUNCTION PSInstalled:Boolean;

  Begin
    PSInstalled:=TestBit(2,HardWareBitsField,1);
  End;

FUNCTION InitialVideoMode:Byte;

  Begin
    InitialVideoMode := 0;
    InitialVideoMode := (HardWareBitsField SHR 4) AND $3;
  End;

FUNCTION DMAInstalled:Boolean;

  Begin
    DMAInstalled:=TestBit(8,HardWareBitsField,1);
  End;

FUNCTION SerialPorts:Byte;

  Begin
    SerialPorts:=0;
    SerialPorts := (HardWareBitsField SHR 9) AND $7;
  End;

FUNCTION GamePortInstalled:Boolean;

  Begin
    GamePortInstalled:=TestBit(12,HardWareBitsField,1);
  End;

FUNCTION InternalModemInstalled:Boolean;

  Begin
    InternalModemInstalled:=TestBit(13,HardWareBitsField,1);
  End;

FUNCTION ParallelPorts:Byte;

  Begin
    ParallelPorts:=0;
    ParallelPorts:=(HardWareBitsField SHR 13) AND $3 ;
  End;

Function GetConfiguration:Byte;
{
  0 sucesso
  1 BIOS doesn't support call
  2 unsupported function
}
  Var
    buffer:ConfigROMTablePTR;
    Regs:Registers;

  Begin
    GetConfiguration:=0;
    Regs.AH := $C0;              { funcao C0h do INT 15h - Get Configuration }
    Intr($15,Regs);                { chama o BIOS }
    IF (Regs.Flags AND FCarry)<>0 Then GetConfiguration:=1;
    IF Regs.AH<>0 Then GetConfiguration:=2
    Else GetConfiguration:=0;
    buffer:=PTR(Regs.ES,Regs.BX);
    ROM.NumberOfBytes:=Buffer^.NumberOfBytes;
    ROM.Model:=Buffer^.Model;
    ROM.SubModel:=Buffer^.SubModel;
    ROM.BIOSRevision:=Buffer^.BIOSRevision;
    ROM.Features1:=Buffer^.Features1;
    ROM.Features2:=Buffer^.Features2;
    ROM.Features3:=Buffer^.Features3;
    ROM.Features4:=Buffer^.Features4;
    ROM.Features5:=Buffer^.Features5;
    ROM.Award:=Buffer^.Award;
  End;

FUNCTION BIOSDate:String;
  Var
     A:Byte;
     TempStr:String;

  Begin
     TempStr:='';
     FOR A:=0 TO 8 DO Tempstr:=TempStr+(CHR(MEM[$F000:$FFF5+A]));
     BIOSDate:=TempStr;
  End;

{ CMOS }{ CMOS }{ CMOS }{ CMOS }{ CMOS }
{ CMOS }{ CMOS }{ CMOS }{ CMOS }{ CMOS }
{ CMOS }{ CMOS }{ CMOS }{ CMOS }{ CMOS }
{ CMOS }{ CMOS }{ CMOS }{ CMOS }{ CMOS }

function nocarry : boolean;
{ returns the status of the carry flag }
begin
  nocarry:=regs.flags and fcarry = $0000
end; {nocarry}

{---------------------------------------------------------------------------}

Function ByteToWord(ByteA, ByteB : byte) : word;
begin
   ByteToWord := Word(ByteB) shl 8 + ByteA
end; {cbw}

{---------------------------------------------------------------------------}

Function BitIsSet(CheckWord : Word; AndValue : Word) : Boolean;
{ returns true if the bit(s) indicated in AndValue are set in CheckByte }
BEGIN
  BitIsSet := CheckWord AND AndValue = AndValue;
end;

{---------------------------------------------------------------------------}

Function ReadCMOS(addr: byte): byte;
{ read a value from the CMOS }
Begin
  if CMOSport = $70 then
  begin
    inline($FA);
    Port[CMOSport] := addr;
    readCMOS := Port[CMOSport + 1];
    inline($FB)
  end
end; {readCMOS}

{---------------------------------------------------------------------------}

function addzero(b: byte): string;
var
  c2: string[2];
begin
  Str(b:0, c2);
  if b < 10 then
    c2:='0' + c2;
  addzero:=c2
end; {addzero}

{---------------------------------------------------------------------------}

Function ChangeBCD(b: byte): byte;
{ change a BCD into a byte structure }
Begin
  ChangeBCD:=(b and $0F) + ((b shr 4) * 10)
end; {ChangeBCD}

{---------------------------------------------------------------------------}

Function GetCMOSDate : String;
{ gets the date found in the CMOS and returns it in string format }
VAR
  Date,
  Century,
  Year,
  Month : Byte;
  WorkStr : String[30];
BEGIN
  WorkStr := '';
  date    := ChangeBCD(readCMOS(7));
  century := ChangeBCD(readCMOS($32));
  year    := ChangeBCD(readCMOS(9));
  month   := ChangeBCD(readCMOS(8));
  WorkStr := DayName[readCMOS(6)]+', ';
  {case country.DateFormat of
    0, 3..255 :}
      WorkStr := WorkStr + Monthname[month]+' '+Num2Str(date)+', '+Num2Str(century)+addzero(year);
 {   1 :
      WorkStr := WorkStr + Long2Str(date)+', '+Monthname[month]+' '+Long2Str(century)+addzero(Year);
    2 :
      WorkStr := WorkStr + Long2Str(century)+addzero(Year)+', '+Monthname[month]+' '+Long2Str(date);
  end; {case}
  GetCMosDate := workStr;
end; { GetCMOSDate }

{---------------------------------------------------------------------------}

Function GetCmosTime : String;
{ returns the time as found in the CMOS }
VAR
  CH : Char;
  Hour,
  Min,
  Sec  : Byte;
  WorkStr : String[30];
  IsPM    : Boolean;
BEGIN
  workStr := '';
  hour := ChangeBCD(readCMOS(4));
  min := ChangeBCD(readCMOS(2));
  sec := ChangeBCD(readCMOS(0));
  IsPm := false;
  case hour of
        0: hour := 12;
        1..11: hour := hour;
        12: IsPM := true;
        13..23: begin
                  IsPM := true;
                  hour := hour - 12
                end;
  end; {case}
  WorkStr := WorkStr + AddZero(hour)+':'+addzero(min)+':'+addzero(sec);
  if IsPM then
    workStr := WorkStr + ' PM'
  Else
    WorkStr := WorkStr + ' AM';
  GetCMOSTime := WorkStr;
end; { GetCmosTime }

{---------------------------------------------------------------------------}

Function GetCmosCheckSum : Boolean;
{ performs checksum on CMOS and returns true if ok }
VAR
  CheckSum1,
  CheckSum2 : word;
  Count     : Byte;
BEGIN
  checksum1 := 0;
  for count := $10 to $2D do
    Inc(checksum1, readCMOS(count));
  checksum2 := (word(256) * readCMOS($2E)) + readCMOS($2F);
  if checksum1 = checksum2 then
    GetCmosCheckSum := true
  else
    GetCmosCheckSum := false;
end; { GetCmosCheckSum }

{---------------------------------------------------------------------------}

Procedure GetCMos;
{ gets the cmos record if it exist }
VAR
  Floppy : Byte;

BEGIN
  FillChar(CMOS, SizeOf(CMos), 0);
  regs.AH:=$C0;
  Intr($15, regs);
  if nocarry or (Mem[$F000:$FFFE] <= $FC) then
  With CMOS DO
  begin
    Found := true;
    CMOSDate := GetCMOSDate;
    CMOSTime := GetCmosTime;
    VideoType := ScreenName[(readCMOS($14) shr 4) and 3];
    CoProc := BitIsSet(readCMOS($14), 2);
    Floppy := readCMOS($10);
    if (Floppy shr 4) < 5 then
      FloppyA := FloppyName[floppy shr 4]
    else
      FloppyA := 'Unknown '+ Long2Hex(floppy shr 4);
    if (floppy and $0F) < 5 then
      FloppyB := FloppyName[floppy and $0F]
    else
      FloppyB := 'Unknown '+ Long2Hex(floppy and $0F);
    Hard0 := readCMOS($12);
    Hard0 := Hard0 shr 4;
    Hard1 := ReadCmos($12);
    Hard1 := Hard1 and $0F;
    if Hard0 = $F then
      Hard0 := readCMOS($19)
    Else Hard0 := $FF; { error }
    if Hard1 = $F then
      Hard1 := readCMOS($1A)
    Else Hard1 := $FF;
    ConvenRam := word(256) * readCMOS($16) + readCMOS($15); { value in K }
    ExtendRam := word(256) * readCMOS($18) + readCMOS($17); { value in K }
    CheckSum := GetCmosCheckSum;
  end
  else
    CMOS.Found := false;
end;
{ DRIVE A }{ DRIVE A }{ DRIVE A }{ DRIVE A }{ DRIVE A }
{ DRIVE A }{ DRIVE A }{ DRIVE A }{ DRIVE A }{ DRIVE A }
{ DRIVE A }{ DRIVE A }{ DRIVE A }{ DRIVE A }{ DRIVE A }
{ DRIVE A }{ DRIVE A }{ DRIVE A }{ DRIVE A }{ DRIVE A }
  function resetFdc(drive:byte):boolean;
    var r:registers;
    begin
      r.ah := 0;                { funcao 00h do INT 13h - reset floppy disk system }
      r.dl := drive;
      intr($13,r);              { chama o BIOS }
      if (r.flags and fcarry)<>0 then
        resetFdc:=false         { houve erro }
      else resetFdc:=true;      { nao houve erro }
    end;


  function lerStatus:boolean;
    var r:registers;
    begin
      r.ah := 1;                { funcao 01h do INT 13h - get floppy disk system status }
      intr($13,r);              { chama o BIOS }
      if r.ah=0 then
        lerStatus:=true
      else
        lerStatus:=false;
    end;

  function lerSector(drive,pista,face,primSect,numSects:byte):boolean;
    var res:boolean;
        buf:Pointer;
        f:integer;
        bootSect:boot_rec;

    begin
      buf:=@bootsect;
      regs.ah := 2;                { funcao 02h do INT 13h - read floppy disk }
      regs.dl := drive;            { drive: 0=A 1=B 80h=C 81h=D ... }
      regs.ch := pista;            { pista 0..}
      regs.dh := face;             { face 0 ou 1 }
      regs.cl := primSect;         { primeiro sector 1.. }
      regs.al := numSects;         { numero de sectores a ler }
      regs.es := seg(buf^);        { posiciona ES:BX no endere‡o do buffer }
      regs.bx := ofs(buf^);        { para onde vao ser lidos os sectores }
      Intr($13,regs);              { chama o BIOS }
      if (regs.flags and fcarry)<>0 then lerSector:=false        { houve erro }
      else
        begin
      lerSector:=true;     { nao houve erro }
      Boot.BPB.bytesPerSect:=BootSect.BPB.BytesPerSect;
      Boot.BPB.SectsPerClust:=BootSect.BPB.SectsPerClust;
      Boot.BPB.ReservedSects:=BootSect.BPB.ReservedSects;
      Boot.BPB.NumOfFats:=BootSect.BPB.NumOfFats;
      Boot.BPB.NumOfRootEntries:=BootSect.BPB.NumOfRootEntries;
      Boot.BPB.TotalSects:=BootSect.BPB.TotalSects;
      Boot.BPB.MediaDescriptorByte:=BootSect.BPB.MediaDescriptorByte;
      Boot.BPB.SectsPerFAT:=BootSect.BPB.SectsPerFAT;
      for f:=0 to 2 do Boot.Jump:=Boot.Jump + Num2Str(BootSect.jump[f]);
      for f:=0 to 7 do Boot.OEM:=Boot.OEM + Chr(BootSect.OEM[f]);
      Boot.SectsPerTrack:=BootSect.SectsPerTrack;
      Boot.NumOfHeads:=BootSect.NumOfHeads;
      Boot.NumOfHiddenSects:=BootSect.NumOfHiddenSects;
      for f:=3 downto 0 do Boot.SerialNumber:=Boot.SerialNumber + Num2Str(BootSect.SerialNumber[f]);
        {neste ponto, os bytes podem ser mostrados em hexadecimal, como
        faz o DOS}
      for f:=0 to 10 do Boot.VolumeID := Boot.VolumeID + chr(BootSect.volumeId[f]);
      end;
    end;

{
STEVE CONNET

determine whether ansi.sys is installed
}

Function LocalAnsiDetected : Boolean;
Var
  Dummy : Byte;
begin
  Asm
    mov ah,1ah                { detect ANSI.SYS device driver }
    mov al,00h
    int 2fh
    mov dummy,al
  end;
  LocalAnsiDetected := Dummy = $FF;
end;

Function RunningUnderMSWindows : boolean; assembler;
Asm
  MOV AX,1600h
  INT 2Fh
End; { RunningUnderMSWindows }


begin
{  GetCMOS;}
  HardWareBitsField:=0;
{  GetHardWareBitsField;}
end.