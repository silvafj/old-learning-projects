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
Program Vesa_Demo_1; { Checking Modes Demo }

Uses
   Crt,Math, Screen, Vesa, Keyboard;

PROCEDURE InformModes;

  Var
    A : Byte;
    Mode : Word;
    ch : word;

  Begin
    For A:=1 TO 32 DO
      Begin
        ClrScr;
        CursorOn(False);
        Mode := VesaInfo.List^[A];
        FastWrite(1,1,Attribute(12,1)+128,'Mode $'+long2hex(mode)+' Information');
        system.writeln;
        GetVESAModeInfo(mode);
        With VesaMode DO
          Begin
            system.writeln('Mode Attributes     : ',Attr);
            system.writeln('Window A attributes : ',WinA);
            system.writeln('Window B attributes : ',WinB);
            system.writeln('Window granularity in K bytes : ',Gran);
            system.writeln('Size of window in K bytes : ',WinSiz);
            system.writeln('Segment address of window A : ',SegA);
            system.writeln('Segment address of window B : ',SegB);
            system.writeln('Number of bytes per line : ',Bytes);
            system.writeln('Number of horizontal pixels : ',Width);
            system.writeln('Number of vertical pixels : ',Height);
            system.writeln('Width of character cell : ',CharW);
            system.writeln('Height of character cell : ',CharH);
            system.writeln('Number of memory planes : ',Planes);
            system.writeln('Number of bits per pixel : ',Bits);
            system.writeln('Number of banks        (not used) : ',nBanks);
            system.writeln('Memory model type : ',Model);
            system.writeln('Size of bank           (not used) : ',Banks);
            system.writeln('Number of image pages : ',Pages);
            system.writeln('The following are for 15,16,24,32 bit colour modes : ',Reserved);
            system.writeln('Size of Red mask in bits : ',RedMaskSize);
            system.writeln('Bit position of LSB of Red mask : ',RedFieldPos);
            system.writeln('Size of Green mask in bits : ',GreenMaskSize);
            system.writeln('Bit position of LSB of Green mask : ',GreenFieldPos);
            FastWrite(1,25,Attribute(10,0),'Press F1 key to continue...');
            repeat
              ch := getscancodew;
              IF ch=kb_f10 Then Exit;
            until ch=kb_f1;
            ClrScr;
            CursorOn(False);
            FastWrite(1,1,Attribute(12,1)+128,'Mode $'+long2hex(mode)+' Information (continuation)');
            system.writeln;
            system.writeln('Size of Blue mask in bits : ',BlueMaskSize);
            system.writeln('Bit position of LSB of Blue mask : ',BlueFieldPos);
            system.writeln('Size of Reserved mask in bits : ',RsvdMaskSize);
            system.writeln('Bit pos. of LSB of Reserved mask : ',RsvdFieldPos);
            system.writeln('Direct Colour mode attributes : ',DirColModeInf);
            FastWrite(1,25,Attribute(10,0),'Press F2 key to next mode... F10 to exit');
            repeat
              ch := getscancodew;
              IF ch=kb_f10 Then Exit;
            until ch=kb_f2;
          end;
      end;
  end;

PROCEDURE GeneralInformations;

  Var
    A : byte;
    ch : word;

  Begin
    ClrScr;
    CursorOn(False);
    WriteCenterText(40,1,Attribute(12,1)+128,'General Informations');
    IF IsVESA Then
      Begin
        FastWrite(1,2,Attribute(3,0),'VESA Installed : ');
        FastWrite(18,2,Attribute(7,0),'YES');
        GetVesaInfo;
        FastWrite(1,3,Attribute(3,0),'VESA Signature : ');
        FOR A := 1 TO 4 DO FastWrite(18 + A,3,Attribute(7,0),Char(VesaInfo.Signature[A]));
        FastWrite(1,4,Attribute(3,0),'VESA Version : ');
        FastWrite(16,4,Attribute(7,0),Num2Str(Hi(VesaInfo.Version))+'.'+Num2Str(Lo(VesaInfo.Version)));
        FastWrite(1,5,Attribute(3,0),'VESA OEM Name : ');
        GotoXY(17,5);
        TextColor(7);
        System.Write(VesaInfo.OEMName);
        FastWrite(1,6,Attribute(3,0),'VESA Capabilities : ');
        FastWrite(21,6,Attribute(7,0),Num2Str(VesaInfo.Capabilities));
        FastWrite(1,6,Attribute(3,0),'VESA Capabilities : ');
        FastWrite(21,6,Attribute(7,0),Num2Str(VesaInfo.Capabilities));
        FastWrite(1,7,Attribute(3,0),'VESA Memory : ');
        FastWrite(15,7,Attribute(7,0),Num2Str(VesaInfo.TotalMemory*64)+'k');
        IF Hi(VesaInfo.Version)=2 Then
          Begin
            FastWrite(1,8,Attribute(3,0),'OEM Software Version : ');
            FastWrite(24,8,Attribute(7,0),Num2Str(Hi(VesaInfo.OEMSoftVersion))+'.'+Num2Str(Low(VesaInfo.OEMSoftVersion)));
            FastWrite(1,9,Attribute(3,0),'Vendor Name : ');
            GotoXY(15,9);
            System.write(VesaInfo.Vendor);      { Pointer to Vendor Name }
            FastWrite(1,10,Attribute(3,0),'Product Name : ');
            GotoXY(16,10);
            System.write(VesaInfo.Product);     { Pointer to product name }
            FastWrite(1,11,Attribute(3,0),'Product Revision : ');
            GotoXY(20,11);
            System.write(VesaInfo.revision);    { Pointer to product revision string }
            FastWrite(1,12,Attribute(3,0),'VESA Modes Available : ');
            A := 0;
            Repeat
              Inc(A);
              IF A >= 18 Then FastWrite(40,A-6,Attribute(7,0),'$'+Long2Hex(VesaInfo.List^[A])+' ')
              Else FastWrite(24,11+A,Attribute(7,0),'$'+Long2Hex(VesaInfo.List^[A])+' ');
            Until A = 32;
          End
        Else
          Begin
            FastWrite(1,8,Attribute(3,0),'VESA Modes Available : ');
            A := 0;
            Repeat
              Inc(A);
              IF A >= 18 Then FastWrite(40,A-10,Attribute(7,0),'$'+Long2Hex(VesaInfo.List^[A])+' ')
              Else FastWrite(24,7+A,Attribute(7,0),'$'+Long2Hex(VesaInfo.List^[A])+' ');
            Until A = 32;
         End;
      End
    Else
      FastWrite(1,1,Attribute(3,0)+128,'VESA NOT Installed');
    FastWrite(50,25,Attribute(10,0),'Press Esc key to continue...');
    Repeat
      ch := getscancodew;
    Until ch=kb_esc;
  End; { General Informations }

Begin
  ClrScr;
  GeneralInformations;
  InformModes;
  CursorOn(True);
end.