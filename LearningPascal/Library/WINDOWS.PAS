
Unit Windows;

{ ************************      INTERFACE      ******************************}
{                         *********************                              }
INTERFACE

{ Public Rotines }
  FUNCTION InitWindows(Number:Longint):Boolean;
  PROCEDURE OpenWindow(X1,Y1,X2,Y2,F,B,LineType:byte;Name:String;Identifier:Longint);
  PROCEDURE ActivateWindow(Identifier:Longint);
  PROCEDURE MoveWindow(X1,Y1,X2,Y2,Identifier:Longint);
  PROCEDURE CloseWindow(Identifier:Longint);

{ ************************    IMPLEMENTATION   ******************************}
{                         *********************                              }
IMPLEMENTATION

  Uses
    Keyboard,Screen;

  Type
    WindowPtr = ^WindowRec ;             { Pointer to the Window Record    }
    WindowRec = Record                   { Screen Record containing :      }
                  Id          :  Longint;    { The identification,             }
                  X1,Y1,X2,Y2 :  Byte;    { The Window coordenates          }
                  Next        :  WindowPtr;  { the pointer to the next reg  }
                End;

  Var
    WindowsUnitSaveScreenGroup : ScreenPtr;
    WindowList : WindowRec;
    WindowSaveList : WindowPtr;

{----------------------------------------------------------------------------}
{                                                                            }
{ DisplayError                                                               }
{              - Description : Display a programming error and then halts    }
{                              program                                       }
{              - Input       : No --> The number of the error                }
{              - Return      : ----                                          }
{----------------------------------------------------------------------------}
PROCEDURE DisplayError(No : byte);

  Var
    Msg : String;

  Begin
    Case No OF
      1 :  Msg := 'Max screens exceeded';
      2 :  Msg := 'Max Windows Exceeded';
    End;
    BkColor:= 0 ;
    Write(1,1,15,Msg);
    Halt;
  End; { DisplayError }

{----------------------------------------------------------------------------}
{                                                                            }
{ InitWindows                                                                }
{              - Description : Init a defined number of diferent windows     }
{              - Input       : Number --> The number of windows              }
{              - Return      : False if no memory available to create windows}
{----------------------------------------------------------------------------}
FUNCTION InitWindows(Number:Longint):Boolean;

  Begin
    InitWindows:=False;
    IF InitPages(WindowsUnitSaveScreenGroup,10) Then InitWindows:=True;
  End; { InitWindows }

PROCEDURE OpenWindow(X1,Y1,X2,Y2,F,B,LineType:byte;Name:String;Identifier:Longint);

  Var
    WorkRec : WindowRec;
    XS : Byte;

  Begin
    XS:=X2+2;
    IF X2=80 Then XS:=80;
    IF X2=79 Then XS:=79;
    StorePage(WindowsUnitSaveScreenGroup,X1,Y1,XS,Y2+1,Identifier);
    Box(X1,Y1,X2,Y2,F,B,LineType,True,Name);
    Shadow(X1,Y1,X2,Y2);
    WorkRec.X1 := X1;
    WorkRec.Y1 := Y1;
    WorkRec.X2 := X2;
    WorkRec.Y2 := Y2;
    WorkRec.ID := Identifier;
    IF WindowSaveList = NIL Then
      Begin
       New(WindowSaveList);
       Workrec.Next := NIL;
       WindowSaveList^ := workrec;
      End;
  End; { OpenWindow }

PROCEDURE ActivateWindow(Identifier:Longint);
  Begin
  End; { ActivateWindow }

PROCEDURE MoveWindow(X1,Y1,X2,Y2,Identifier:Longint);
  Begin
  End; { MoveWindow }

PROCEDURE CloseWindow(Identifier:Longint);
  Begin
    RestorePage(WindowsUnitSaveScreenGroup,Identifier);
  End; { CloseWindow }

(*
{+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}
{                                                                     }
{     V I S I B L E    a n d    V I R T U A L  P R O C E D U R E S    }
{                                                                     }
{+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}
Procedure PartSave (X1,Y1,X2,Y2:byte; VAR Dest);
{transfers data from active virtual screen to Dest}
var
   I,width : byte;
   ScreenAdr: integer;
begin
    width := succ(X2- X1);
    For I :=  Y1 to Y2 do
    begin
     ScreenAdr := Vofs + Pred(I)*160 + Pred(X1)*2;
     MoveFromScreen(Mem[Vseg:ScreenAdr],
                    Mem[seg(Dest):ofs(dest)+(I-Y1)*width*2],
                    width);
    end;
end;

Procedure PartRestore (X1,Y1,X2,Y2:byte; VAR Source);
{restores data from Source and transfers to active virtual screen}
var
   I,width : byte;
   ScreenAdr: integer;
begin
    width := succ(X2- X1);
    For I :=  Y1 to Y2 do
    begin
     ScreenAdr := Vofs + Pred(I)*160 + Pred(X1)*2;
     MoveToScreen(Mem[Seg(Source):ofs(Source)+(I-Y1)*width*2],
                  Mem[Vseg:ScreenAdr],
                  width);
    end;
end;

Procedure FillScreen(X1,Y1,X2,Y2:byte; F,B:byte; C:char);
var
   I : integer;
   S : string;
begin
    W_error := 0;
    Attrib(X1,Y1,X2,Y2,F,B);
    S := Replicate(Succ(X2-x1),C);
    For I := Y1 to Y2 do
        PlainWrite(X1,I,S);
end;

Procedure GetScreenWord(X,Y:byte;var Attr:byte; var Ch : char);
{updates vars Attr and Ch with attribute and character bytes in screen
 location (X,Y) of the active screen}
Type
    ScreenWordRec = record
                         Attr : byte;
                         Ch   : char;
                    end;
var
   ScreenAdr: integer;
   SW : ScreenWordRec;
begin
    ScreenAdr := Vofs + Pred(Y)*160 + Pred(X)*2;
    MoveFromScreen(Mem[Vseg:ScreenAdr],mem[seg(SW):ofs(SW)],1);
    Attr := SW.Attr;
    Ch   := SW.Ch;
end;

Function GetScreenChar(X,Y:byte):char;
var
   A : byte;
   C : char;
begin
    GetScreenWord(X,Y,A,C);
    GetScreenChar := C;
end;

Function GetScreenAttr(X,Y:byte):byte;
var
   A : byte;
   C : char;
begin
    GetScreenWord(X,Y,A,C);
    GetScreenAttr := A;
end;

Procedure GetScreenStr(X1,X2,Y:byte;var  St:string);
var
   I : integer;
begin
    St := '';
    For I := X1 to X2 do
        St := St + GetScreenChar(I,Y);
end;

{++++++++++++++++++++++++++++++++++++++++++++++}
{                                              }
{         C U R S O R    R O U T I N E S       }
{                                              }
{++++++++++++++++++++++++++++++++++++++++++++++}

Procedure GotoXY(X,Y : byte);
{intercepts normal Turbo GotoXY procedure, in case a virtual screen
 is active.
}
begin
    If VSeg = BaseOfScreen then
       CRT.GotoXY(X,Y)
    else
       with Screen[ActiveVScreen]^ do
       begin
           CursorX := X;
           CursorY := Y;
       end; {with}
end;  {proc GotoXY}

Function WhereX: byte;
{intercepts normal Turbo WhereX procedure, in case a virtual screen
 is active.
}
begin
    If VSeg = BaseOfScreen then
       WhereX := CRT.WhereX
    else
       with Screen[ActiveVScreen]^ do
           WhereX := CursorX;
end; {of func WhereX}

Function WhereY: byte;
{intercepts normal Turbo WhereX procedure, in case a virtual screen
 is active.
}
begin
    If VSeg = BaseOfScreen then
       WhereY := CRT.WhereY
    else
       with Screen[ActiveVScreen]^ do
           WhereY := CursorY;
end; {of func WhereY}

Procedure FindCursor(var X,Y,Top,Bot:byte);
var
   Reg : registers;
begin
  If VSeg = BaseOfScreen then    {visible screen is active}
  begin
      Reg.Ax := $0F00;              {get page in Bx}
      Intr($10,Reg);
      Reg.Ax := $0300;
      Intr($10,Reg);
      With Reg do
      begin
        X := lo(Dx) + 1;
        Y := hi(Dx) + 1;
        Top := Hi(Cx) and $0F;
        Bot := Lo(Cx) and $0F;
      end;
  end
  else                            {virtual screen active}
     with Screen[ActiveVScreen]^ do
     begin
         X := CursorX;
         Y := CursorY;
         Top := ScanTop;
         Bot := ScanBot;
     end;
end;

Procedure PosCursor(X,Y: integer);
var Reg : registers;
begin
    If VSeg = BaseOfScreen then    {visible screen is active}
    begin
        Reg.Ax := $0F00;              {get page in Bx}
        Intr($10,Reg);
        with Reg do
        begin
          Ax := $0200;
          Dx := ((Y-1) shl 8) or ((X-1) and $00FF);
        end;
        Intr($10,Reg);
    end
    else                           {virtual screen active}
       with Screen[ActiveVScreen]^ do
       begin
           CursorX := X;
           CursorY := Y;
       end;
end;

Procedure SizeCursor(Top,Bot:byte);
var Reg : registers;
begin
    If VSeg = BaseOfScreen then    {visible screen is active}
       with Reg do
       begin
         ax := 1 shl 8;
         cx := Top shl 8 + Bot;
         INTR($10,Reg);
       end
    else                           {virtual screen active}
       with Screen[ActiveVScreen]^ do
       begin
           ScanTop := Top;
           ScanBot := Bot;
       end;
end;

Procedure HalfCursor;
begin
    If BaseOfScreen = MonoAdr then
       SizeCursor(8,13)
    else
       SizeCursor(4,7);
end; {Proc HalfCursor}

Procedure Fullcursor;
begin
    If BaseOfScreen = MonoAdr then
       SizeCursor(0,13)
    else
       SizeCursor(0,7);
end;

Procedure OnCursor;
begin
    If BaseOfScreen = MonoAdr then
       SizeCursor(12,13)
    else
       SizeCursor(6,7);
end;

Procedure OffCursor;
begin
    Sizecursor(14,0);
end;

{++++++++++++++++++++++++++++++++++++++++++++++++++++}
{                                                    }
{   S C R E E N   S A V I N G  R O U T I N E S       }
{                                                    }
{++++++++++++++++++++++++++++++++++++++++++++++++++++}

Procedure DisposeScreen(Page:byte);
{Free memory and set pointer to nil}
begin
    If Screen[Page] = nil then
    begin
       WinTTT_Error(6);
       exit;
    end
    else
       W_error := 0;
    FreeMem(Screen[Page]^.ScreenPtr,Screen[Page]^.SavedLines*160);
    Freemem(Screen[Page],SizeOf(Screen[Page]^));
    Screen[page] := nil;
    If ActiveVscreen = Page then
       Activate_Visible_Screen;
    dec(ScreenCounter);
end;

Procedure SaveScreen(Page:byte);
{Save screen display and cursor details}
begin
    If (Page > Max_Screens) then
    begin
      WinTTT_Error(1);
      exit;
    end;
    If ((Screen[Page] <> nil) and (DisplayLines <> Screen[Page]^.SavedLines)) then
        DisposeScreen(Page);
    If Screen[Page] = nil then            {need to allocate memory}
    begin
        If MaxAvail < SizeOf(Screen[Page]^) then
        begin
            WinTTT_Error(3);
            exit;
        end;
        GetMem(Screen[Page],SizeOf(Screen[Page]^));
        If MaxAvail < DisplayLines*160 then     {do check in two parts 'cos Maxavail is not same as MemAvail}
        begin
            WinTTT_Error(3);
            Freemem(Screen[Page],SizeOf(Screen[Page]^));
            Screen[Page] := nil;
            exit;
        end;
        GetMem(Screen[Page]^.ScreenPtr,DisplayLines*160);
        Inc(ScreenCounter);
    end;
    With Screen[Page]^ do
    begin
       FindCursor(CursorX,CursorY,ScanTop,ScanBot);     {Save Cursor posn. and shape}
       SavedLines := DisplayLines;
       MoveFromScreen(Mem[BaseOfScreen:0],Screen[Page]^.ScreenPtr^,DisplayLines*80);
    end;
    W_error := 0;
end;

Procedure RestoreScreen(Page:byte);
{Display a screen that was previously saved}
begin
    If Screen[Page] = nil then
    begin
       WinTTT_Error(7);
       exit;
    end
    else
       W_error := 0;
    With Screen[Page]^ do
    begin
        MoveToScreen(ScreenPtr^,mem[BaseOfScreen:0], 80*SavedLines);
        PosCursor(CursorX,CursorY);
        SizeCursor(ScanTop,ScanBot);
    end;
end;  {Proc RestoreScreen}


Procedure PartRestoreScreen(Page,X1,Y1,X2,Y2,X,Y:byte);
{Move from heap to screen, part of saved screen}
Var
   I,width     : byte;
   ScreenAdr,
   PageAdr     : integer;
begin
    If Screen[Page] = nil then
    begin
       WinTTT_Error(7);
       exit;
    end
    else
       W_error := 0;
    Width := succ(X2- X1);
    For I :=  Y1 to Y2 do
    begin
        ScreenAdr := pred(Y+I-Y1)*160 + Pred(X)*2;
        PageAdr   := Pred(I)*160 + Pred(X1)*2;
        MoveToScreen(Mem[Seg(Screen[Page]^.ScreenPtr^):ofs(Screen[Page]^.ScreenPtr^)+PageAdr],
                     Mem[BaseOfScreen:ScreenAdr],
                     width);
    end;
end;

Procedure SlideRestoreScreen(Page:byte;Way:Direction);
{Display a screen that was previously saved, with fancy slide}
Var I : byte;
begin
    If Screen[Page] = nil then
    begin
       WinTTT_Error(7);
       exit;
    end
    else
       W_error := 0;
    Case Way of
    Up    : begin
                For I := DisplayLines downto 1 do
                begin
                    PartRestoreScreen(Page,
                                      1,1,80,succ(DisplayLines -I),
                                      1,I);
                    Delay(50);
                end;
            end;
    Down  : begin
                For I := 1 to DisplayLines do
                begin
                    PartRestoreScreen(Page,
                                      1,succ(DisplayLines -I),80,DisplayLines,
                                      1,1);
                    Delay(50);  {savor the moment!}
                end;
            end;
    Left  : begin
                For I := 1 to 80 do
                begin
                    PartRestoreScreen(Page,
                                      1,1,I,DisplayLines,
                                      succ(80-I),1);
                end;
            end;
    Right : begin
                For I := 80 downto 1 do
                begin
                    PartRestoreScreen(Page,
                                      I,1,80,DisplayLines,
                                      1,1);
                end;
            end;
    end; {case}
    PosCursor(Screen[Page]^.CursorX,Screen[Page]^.CursorY);
    SizeCursor(Screen[Page]^.ScanTop,Screen[Page]^.ScanBot);
end;   {Proc SlideRestoreScreen}


Procedure PartSlideRestoreScreen(Page:byte;Way:Direction;X1,Y1,X2,Y2:byte);
{Display a screen that was previously saved, with fancy slide}
Var I : byte;
begin
    If Screen[Page] = nil then
    begin
       WinTTT_Error(7);
       exit;
    end
    else
       W_error := 0;
    Case Way of
    Up    : begin
                For I := Y2 downto Y1 do
                begin
                    PartRestoreScreen(Page,
                                      X1,Y1,X2,Y1+Y2-I,
                                      X1,I);
                    Delay(50);
                end;
            end;
    Down  : begin
                For I := Y1 to Y2 do
                begin
                    PartRestoreScreen(Page,
                                      X1,Y1+Y2 -I,X2,Y2,
                                      X1,Y1);
                    Delay(50);  {savor the moment!}
                end;
            end;
    Left  : begin
                For I := X1 to X2 do
                begin
                    PartRestoreScreen(Page,
                                      X1,Y1,I,Y2,
                                      X1+X2-I,Y1);
                end;
            end;
    Right : begin
                For I := X2 downto X1 do
                begin
                    PartRestoreScreen(Page,
                                      I,Y1,X2,Y2,
                                      X1,Y1);
                end;
            end;
    end; {case}
end;   {Proc PartSlideRestoreScreen}


{++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}
{                                                                              }
{     V I R T U A L    S C R E E N    S P E C I F I C   P R O C E D U R E S    }
{                                                                              }
{++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}

Procedure Clear_Vscreen(page:byte);
var
   Tseg, Tofs : word;
begin
    If Screen[Page] = nil then
    begin
       WinTTT_Error(8);
       exit;
    end
    else
       W_error := 0;
    Tseg := Vseg;
    Tofs := Vofs;
    Vseg := Seg(Screen[Page]^.ScreenPtr^);
    Vofs := Ofs(Screen[Page]^.ScreenPtr^);
    ClearText(1,1,80,Screen[Page]^.SavedLines,yellow,black);
    Vseg := Tseg;
    Vofs := Tofs;
end;

Procedure CreateScreen(Page:byte;Lines:byte);
begin
    W_error := 0;
    If (Page > Max_Screens) then
    begin
       WinTTT_Error(1);
       exit;
    end;
    If ((Screen[Page] <> nil) and (Lines <> Screen[Page]^.SavedLines)) then
        DisposeScreen(Page);
    If Screen[Page] = nil then            {need to allocate memory}
    begin
        If MaxAvail < SizeOf(Screen[Page]^) then
        begin
            WinTTT_Error(3);
            exit;
        end;
        GetMem(Screen[Page],SizeOf(Screen[Page]^));
        If MaxAvail < Lines*160 then     {do check in two parts 'cos Maxavail is not same as MemAvail}
        begin
            WinTTT_Error(3);
            Freemem(Screen[Page],SizeOf(Screen[Page]^));
            Screen[Page] := nil;
            exit;
        end;
        GetMem(Screen[Page]^.ScreenPtr,Lines*160);
        Inc(ScreenCounter);
    end;
    With Screen[Page]^ do
    begin
        If BaseOfScreen = $B000 then
        begin
            ScanTop := 12;
            ScanBot := 13;
        end
        else
        begin
            ScanTop := 6;
            ScanBot := 7;
        end;
        CursorX := 1;
        CursorY := 1;
        SavedLines := Lines;
        Clear_Vscreen(Page);
    end;
end;

Procedure Activate_Visible_Screen;
begin
    VSeg := BaseOfScreen;
    VOfs := 0;
    ActiveVscreen := 0;
end;

Procedure Activate_Virtual_Screen(Page:byte);
{Page zero signifies the visible screen}
begin
    If Screen[Page] = nil then
       WinTTT_Error(4)
    else
    begin
       W_error := 0;
       If Page = 0 then
          Activate_Visible_Screen
       else
       begin
           VSeg := Seg(Screen[Page]^.ScreenPtr^);
           VOfs := Ofs(Screen[Page]^.ScreenPtr^);
           ActiveVScreen := page;
       end;
    end;
end;

{++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}
{                                                                              }
{     V I S I B L E    S C R E E N    S P E C I F I C   P R O C E D U R E S    }
{                                                                              }
{++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}

Procedure SetCondensedLines;
begin
    If EGAVGASystem then
    begin
        W_Error := 0;
        TextMode(Lo(LastMode)+Font8x8);
        DisplayLines := succ(Hi(WindMax));
    end
    else
        W_Error := 12;
end;  {proc SetCondensedDisplay}

Procedure Set25Lines;
begin
    TextMode(Lo(LastMode));
    DisplayLines := succ(Hi(WindMax));
end;


Procedure CopyScreenBlock(X1,Y1,X2,Y2,X,Y:byte);
{copies text and attributes from one part of screen to another}
Var
   S : word;
   SPtr : pointer;
begin
    W_error := 0;
    S := succ(Y2-Y1)*succ(X2-X1)*2;
    If Maxavail < S then
       WinTTT_Error(9)
    else
    begin
        GetMem(SPtr,S);
        PartSave(X1,Y1,X2,Y2,SPtr^);
        PartRestore(X,Y,X+X2-X1,Y+Y2-Y1,SPtr^);
        FreeMem(Sptr,S);
    end;
end; {CopyScreenBlock}

Procedure MoveScreenBlock(X1,Y1,X2,Y2,X,Y:byte);
{Moves text and attributes from one part of screen to another,
 replacing with Replace_Char}
const
  Replace_Char = ' ';
Var
   S : word;
   SPtr : pointer;
   I : Integer;
   ST : string;
begin
    W_error := 0;
    S := succ(Y2-Y1)*succ(X2-X1)*2;
    If Maxavail < S then
       WinTTT_Error(9)
    else
    begin
        GetMem(SPtr,S);
        PartSave(X1,Y1,X2,Y2,SPtr^);
        St := Replicate(succ(X2-X1),Replace_Char);
        For I := Y1 to Y2 do
            PlainWrite(X1,I,St);
        PartRestore(X,Y,X+X2-X1,Y+Y2-Y1,SPtr^);
        FreeMem(Sptr,S);
    end;
end; {Proc MoveScreenBlock}

Procedure Scroll(Way:direction;X1,Y1,X2,Y2:byte);
{used for screen scrolling, uses Copy & Plainwrite for speed}
const
  Replace_Char = ' ';
var
  I : integer;
begin
    W_error := 0;
    Case Way of
    Up   : begin
               CopyScreenBlock(X1,succ(Y1),X2,Y2,X1,Y1);
               PlainWrite(X1,Y2,replicate(succ(X2-X1),Replace_Char));
           end;
    Down : begin
               CopyScreenBlock(X1,Y1,X2,pred(Y2),X1,succ(Y1));
               PlainWrite(X1,Y1,replicate(succ(X2-X1),Replace_Char));
           end;
    Left : begin
               CopyScreenBlock(succ(X1),Y1,X2,Y2,X1,Y1);
               For I := Y1 to Y2 do
                   PlainWrite(X2,1,Replace_Char);
           end;
    Right: begin
               CopyScreenBlock(X1,Y1,pred(X2),Y2,succ(X1),Y1);
               For I := Y1 to Y2 do
                   PlainWrite(X1,1,Replace_Char);
           end;
    end; {case}
end;

procedure CreateWin(x1,y1,x2,y2,F,B,boxtype:integer);
{called by MkWin and GrowMkWin}
begin
    If WindowCounter >= Max_Windows then
    begin
       WinTTT_Error(2);
       exit;
    end;
    If MaxAvail < sizeOf(Win[WindowCounter]^) then
    begin
       WinTTT_Error(3);
       exit;
    end
    else
       W_error := 0;
    Inc(WindowCounter);
    GetMem(Win[WindowCounter],sizeof(Win[WindowCounter]^));    {allocate space}
    If (BoxType in [5..9]) and (X1 > 1) then     {is there a drop shadow}
    begin
        X1 := pred(X1);    {increase dimensions for the box}
        Y2 := succ(Y2);
    end;
    If MaxAvail < succ(Y2-Y1)*succ(X2-X1)*2 then
    begin
       WinTTT_Error(3);
       exit;
    end;
    GetMem(Win[WindowCounter]^.ScreenPtr,succ(Y2-Y1)*succ(X2-X1)*2);
    PartSave(X1,Y1,X2,Y2,Win[WindowCounter]^.ScreenPtr^);
    with Win[WindowCounter]^ do
    begin
      Coord[1] := X1;
      Coord[2] := Y1;
      Coord[3] := X2;
      Coord[4] := Y2;
      FindCursor(CursorX,CursorY,ScanTop,ScanBot);
    end;  {with}
end; {Proc CreateWin}

procedure mkwin(x1,y1,x2,y2,F,B,boxtype:integer);
{Main procedure for creating window}
var I : integer;
begin
    If ActiveVscreen <> 0 then
    begin
        W_error := 10;
        exit;
    end
    else
        W_error := 0;
    CreateWin(X1,Y1,X2,Y2,F,B,Boxtype);
    If (BoxType in [5..9]) and (X1 > 1) then
       FBox(x1,y1,x2,y2,F,B,boxtype-shadow)
    else
       FBox(x1,y1,x2,y2,F,B,boxtype);
    If (BoxType in [5..9]) and (X1 > 1) then     {is there a drop shadow}
    begin
        For I := succ(Y1) to succ(Y2) do
            WriteAt(pred(X1),I,Shadcolor,black,chr(219));
        WriteAt(X1,succ(Y2),Shadcolor,black,
                replicate(X2-succ(X1),chr(219)));
    end;
end;

procedure GrowMKwin(x1,y1,x2,y2,F,B,boxtype:integer);
{same as MKwin but window explodes}
var I : integer;
begin
    If ActiveVscreen <> 0 then
    begin
        W_error := 10;
        exit;
    end
    else
        W_error := 0;
    CreateWin(X1,Y1,X2,Y2,F,B,Boxtype);
    If (BoxType in [5..9]) and (X1 > 1) then
       GrowFBox(x1,y1,x2,y2,F,B,boxtype-shadow)
    else
       GrowFBox(x1,y1,x2,y2,F,B,boxtype);
    If (BoxType in [5..9]) and (X1 > 1) then     {is there a drop shadow}
    begin
        For I := succ(Y1) to succ(Y2) do
            WriteAt(pred(X1),I,Shadcolor,black,chr(219));
        WriteAt(X1,succ(Y2),Shadcolor,black,
                replicate(X2-succ(X1),chr(219)));
    end;
end;

Procedure RmWin;
begin
    If ActiveVscreen <> 0 then
    begin
        W_error := 10;
        exit;
    end
    else
        W_error := 0;
    If WindowCounter > 0 then
    begin
        with  Win[WindowCounter]^ do
        begin
            PartRestore(Coord[1],Coord[2],Coord[3],Coord[4],ScreenPtr^);
            PosCursor(CursorX,CursorY);
            SizeCursor(ScanTop,ScanBot);
            FreeMem(ScreenPtr,succ(Coord[4]-coord[2])*succ(coord[3]-coord[1])*2);
            FreeMem(Win[WindowCounter],sizeof(Win[WindowCounter]^));
        end; {with}
        Dec(WindowCounter);
    end;
end;

procedure TempMessageCh(X,Y,F,B:integer;St:string;var Ch : char);
var
 CX,CY,CT,CB,I,locC:integer;
 SavedLine : array[1..160] of byte;
begin
    If ActiveVscreen <> 0 then
    begin
        W_error := 11;
        exit;
    end
    else
        W_error := 0;
    PartSave(X,Y,pred(X)+length(St),Y,SavedLine);
    WriteAT(X,Y,F,B,St);
    Ch := GetKey;
    PartRestore(X,Y,pred(X)+length(St),Y,SavedLine);
end;

Procedure TempMessage(X,Y,F,B:integer;St:string);
var Ch : char;
begin
    TempMessageCH(X,Y,F,B,ST,Ch);
end;

Procedure TempMessageBoxCh(X1,Y1,F,B,BoxType:integer;St:string;var Ch : char);
begin
    If ActiveVscreen <> 0 then
    begin
        W_error := 11;
        exit;
    end
    else
        W_error := 0;
    MkWin(X1,Y1,succ(X1)+length(St),Y1+2,F,B,Boxtype);
    WriteAt(succ(X1),Succ(Y1),F,B,St);
    Ch := getKey;
    Rmwin;
end;

Procedure TempMessageBox(X1,Y1,F,B,BoxType:integer;St:string);
var Ch : char;
begin
    TempMessageBoxCh(X1,Y1,F,B,Boxtype,St,Ch);
end;

{++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}

Procedure InitWinTTT;
{set Pointers to nil for validity checking}
Var
  I : integer;
  X,Y : byte;
begin
    For I := 1 to Max_Screens do
        Screen[I] := nil;
    StartMode := LastMode;           { record the initial state of screen when program was executed}
    DisplayLines := succ(Hi(WindMax));
    FindCursor(X,Y,StartTop,StartBot);
end;


Procedure Reset_StartUp_Mode;
{resets monitor mode and cursor settings to the state they
 were in at program startup}
begin
    TextMode(StartMode);
    SizeCursor(StartTop,StartBot);
end; {proc StartUp_Mode}
*)

begin
  WindowSaveList := NIL;
  (*    InitWinTTT;
    W_error := 0;
    W_fatal := false;   {don't terminate program if fatal error}
    Shadcolor := darkgray;*)
end.
