

          {******************************************************}
          {* Program : ---------------------------------------- *}
          {* Unit    : Graphics                                 *}
          {* Version : 1.0                                      *}
          {* Comment : Unit for suport graphical initialization,*}
          {*           and some graphical rotines               *}
          {* Programed by : Fernando Jorge Almeida Silva        *}
          {* Programed under : Borland Pascal 7.0               *}
          {* Address : Juncal - Assequins 3750 µgueda  PORTUGAL *}
          {* Phone   : ( 034 ) 602800                           *}
          {******************************************************}
             {************************************************}
             {*         Copyrigth (c) 1995-97  by            *}
             {*         Bullion MultiSoft Company            *}
             {************************************************}



 UNIT Graphics;

   INTERFACE

     USES
       Crt,
       Graph,
       Drivers,
       Fonts1,
       Fonts2,
       Fonts3;

     VAR
        Modo, MaxColor:INTEGER;
        Bolded, Europe, Lcomand, Script, Simplex, Tscrew : INTEGER;

     PROCEDURE InitGraphMode(Colors:INTEGER);


   IMPLEMENTATION

{**********}
  PROCEDURE Abort(Msg : STRING);

    BEGIN

    END; { Abort }

{**********}
{    SVGA320x200x256		0	 320x200x256 Standard VGA  }
{    SVGA640x400x256		1	 640x400x256 Svga/VESA     }
{    SVGA640x480x256		2	 640x480x256 Svga/VESA     }
{    SVGA800x600x256		3	 800x600x256 Svga/VESA     }
{    SVGA1024x768x256	        4	 1024x768x256 Svga/VESA    }
{$F+}
  FUNCTION DetectVGA256(Mode:INTEGER):INTEGER; { detecta o modo pretendido }

    VAR
      Gd, Gm:INTEGER;

    BEGIN
      DetectGraph(Gd,Gm);
      IF (Gd=VGA) OR (Gd=MCGA) THEN
        BEGIN
          Gm:=Modo;
          DetectVGA256:=Gm;
        END
       ELSE
         DetectVGA256:=grError;
    END; { DetectVGA256 }
{$F-}


{**********}
  PROCEDURE InitGraphMode(Colors:INTEGER);

    VAR
       Gd, Gm, ErrorCode: INTEGER;
       AutoDetectPointer:POINTER;

    BEGIN
      DirectVideo := FALSE;
      IF RegisterBGIfont(@GothFont) < 0 THEN Abort('');
      IF RegisterBGIfont(@SansFont) < 0 THEN Abort('');
      IF RegisterBGIfont(@LittFont) < 0 THEN Abort('');
      IF RegisterBGIfont(@TripFont) < 0 THEN Abort('');
      IF RegisterBGIfont(@BoldFont) < 0 THEN Abort('');
      IF RegisterBGIfont(@EuroFont) < 0 THEN Abort('');
      IF RegisterBGIfont(@LcomFont) < 0 THEN Abort('');
      IF RegisterBGIfont(@ScriFont) < 0 THEN Abort('');
      IF RegisterBGIfont(@SimpFont) < 0 THEN Abort('');
      IF RegisterBGIfont(@TscrFont) < 0 THEN Abort('');
      Bolded := InstallUserFont('BOLD');
      Europe := InstallUserFont('EURO');
      Lcomand := InstallUserFont('LCOM');
      Script := InstallUserFont('SCRI');
      Simplex := InstallUserFont('SIMP');
      Tscrew := InstallUserFont('TSCR');
      IF Colors=16 THEN
        BEGIN
          IF RegisterBGIdriver(@EGAVGADriver) < 0 THEN Abort('');
          Gd := Detect;
          InitGraph(Gd, Gm, '');
          SetGraphMode(Modo);
          MaxColor:=16;
          ErrorCode:=GraphResult;
          IF GraphResult <> grOk THEN
            BEGIN
              Writeln('Graphics error:', GraphErrorMsg(ErrorCode));
              Halt;
            END;
        END;
      IF Colors=256 THEN
        BEGIN
          AutoDetectPointer:=@DetectVGA256;
          Gd:=InstallUserDriver('SVGA256',AutoDetectPointer);
          Gd:=Detect;
          Gm:=Modo;
          InitGraph(Gd,Gm,'');
          MaxColor:=256;
          ErrorCode:=GraphResult;
          IF GraphResult <> grOk THEN
            BEGIN
              Writeln('Graphics error:', GraphErrorMsg(ErrorCode));
              Halt;
            END;
        END;
    END; { InitGraphMode }


  BEGIN
    Modo:=2;
  END.
