{$A+} { Align Data Switch }
{$B-} { Boolean Evaluation Switch }
{$D-} { Debug Information Switch }
{$E-} { Emulation Switch - this doesn't affect a unit only a program }
{$F+} { Force Far Calls Switch }
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
Unit Menus;

{ ************************      INTERFACE      ******************************}
{                         *********************                              }
INTERFACE

  Const
    Max_Topics = 120;   { The maximum number of topics in the array }
    Max_Width  = 30;   { The maximum width of a topic }

  Type
    { This array will contain all topics corresponding to all menus }
    Topics_Array = Array [1..Max_Topics] OF String [Max_Width];
    { This array will contain all information about colors and positions }
    { of the menus }
    MenuType = Record
                 X1,Y1  : Byte;    { Up corner coordenates             }
                 X2     : Byte;
                 FCol   : Byte;    { Normal option foreground color    }
                 BCol   : Byte;    { Normal option background color    }
                 CCol   : Byte;    { Color of the highlighted char     }
                 MBCol  : Byte;    { Highlight bgnd col for main pick  }
                                   { when sub-menu displayed           }
                 HFCol  : Byte;    { Highlighted option foreground     }
                 HFLetCol  : Byte;    { Highlighted option foreground of }
                                      { the highlighted letter           }
                 HBCol  : Byte;    { Highlighted option background     }
                 BorCol : Byte;    { Border foreground color           }
                 Gap    : Byte;    { Gap between Picks                 }
                 RemoveMenu : Boolean; { Clear screen on exit          }
                 AlwaysDown : Boolean; { If the SubMenu should be down }
                 MainIsHigh : Boolean;
                 ExitEsc    : Boolean;
                 Style      : Byte;
                 Shadow     : Boolean;
                 ExecuteExtRotine : Boolean;
                 Rotine     : Procedure;
               End;

  Var
    MenuTopics : Topics_Array;  { Default variavel to work with topics_array }
    MenuDisplay   : MenuType;   { Variavel that works with MenuDisplay       }

{ Public Rotines }
  PROCEDURE DefaultSettings;
  FUNCTION PullMenu(HighLight : Boolean):Byte;

{ ************************    IMPLEMENTATION   ******************************}
{                         *********************                              }
IMPLEMENTATION

  Uses
    Math,StrsUse,Screen,Keyboard;

  Const
    Max_MainTopics = 15; { The max number of main topics }
    Max_SubTopics  = 20; { The max number of sub topics  }
    MainInd = '\';       { Symbol that indicates main menu description }
    SpaceInd = '-SPACE-';
    HighLetInd = '+';

  Type
    MenuDetails = Record
                    SubText :  Array [1..Max_SubTopics] OF String [Max_Width];
                    SubHighLetter : Array [1..Max_SubTopics] OF Byte;
                    ReturnCode : Array [1..Max_SubTopics] OF Byte;
                    MainText : String[Max_Width];
                    MainHighLetter : Byte;
                    Total : Byte;
                    Width : Byte;
                    LastPick : Byte;
                  End;

  Var
    FinalMenu  : Array [1..Max_MainTopics] OF MenuDetails;
    Tot_main : byte;              {total number of main picks}
    Main_Wid : byte;              {width of main menu box}
    Finished,                     {has user selected menu option}
    Down     : boolean;           {indicates if sub-menu displayed}
    X1, Y1, X2, Y2 : byte;        {lower menu borders}
    Cap,Count      : byte;        {used to check if letter pressed = first char}
    I              : integer;
    LJoinchar,           {border submenu upper left char}
    RJoinchar,           {border submenu upper right char}
    Spacechar:Char;           {border submenu bottom left char}
    APickM, ApickS: Byte;
    MenusUnitSaveScreenGroup : ScreenPtr;

{----------------------------------------------------------------------------}
{                                                                            }
{ DefaultSettings                                                            }
{                 - Description : Initializes the default settings           }
{                 - Input       : ----                                       }
{                 - Return      : ----                                       }
{----------------------------------------------------------------------------}
PROCEDURE DefaultSettings;

  Begin
    With MenuDisplay DO
      Begin
        X1     := 1;
        Y1     := 1;
        X2     := 80;
        FCol   := 0;
        BCol   := 7;
        CCol   := 4;
        MBCol  := 2;
        HFCol  := 0;
        HFLetCol := 4;
        HBCol  := 2;
        BorCol := 0;
        Gap    := 2;
        RemoveMenu := False;
        AlwaysDown := False;
        MainIsHigh := False;
        ExitEsc    := True;
        Style      := 1; { Single Line }
        Shadow     := TRUE;
        ExecuteExtRotine := False;
      End;
  End; { DefaultSettings }

{----------------------------------------------------------------------------}
{                                                                            }
{ DisplayError                                                               }
{              - Description : Write in the screen the error description     }
{              - Input       : No --> The number of the error                }
{              - Return      : ----                                          }
{----------------------------------------------------------------------------}
PROCEDURE DisplayError(No : Byte);

  Var
    S : String[100];

  Begin
    Case No OF
        1 : S := 'Error in position '+Num2Str(I)+' -- Menu definiton must start with a Main ("\") description';
        2 : S := 'Error in position '+Num2Str(I)+' -- Main menu definition must be at least 1 character';
        3 : S := 'Error in position '+Num2Str(I)+' -- Too many main menu picks.';
        4 : S := 'Error in position '+Num2Str(I)+' -- Too many sub-menu picks.';
        5 : S := 'Error in position '+Num2Str(I)+' -- No end of menu indicator found';
        6 : S := 'Error in position '+Num2Str(I)+' -- Must be at least one sub-menus';
        7 : S := 'Error in position '+Num2Str(I)+' -- Main menu will not fit in 80 characters';
        8 : S := 'Error in position '+Num2Str(I)+' -- No memory to save screen';
        9 : S := 'Error in position '+Num2Str(I)+' -- Can''t put two followed spaces';
       10 : S := 'Error in position '+Num2Str(I)+' -- A space can''t be in first or last positions';
       11 : S := 'Error in position '+Num2Str(I)+' -- There are picks with the same highlight letter';
       12 : S := 'Error in position '+Num2Str(I)+' -- No highlight letter defined';
       13 : S := 'Error in position '+Num2Str(I)+' -- To many highlight indicators';
       14 : S := 'The choosed style doesn''t exist';
       15 : S := 'Error in position '+Num2Str(I)+' -- You are using the same main menu highletter before';
       16 : S := 'Error in position '+Num2Str(I)+' -- You are using in a sub menu a highletter that you used before';
    End;
    BkColor:= 0 ;
    Write(1,1,15,S);
    Halt;
  End; { DisplayError }

{----------------------------------------------------------------------------}
{                                                                            }
{ ReturnHighLight                                                            }
{                  - Description : Returns a position of the high letter     }
{                  - Input       : Str --> Input string                      }
{                  - Return      : Position --> The position of the letter   }
{                                  And the converted string                  }
{----------------------------------------------------------------------------}
FUNCTION ReturnHighLight(Str:String; Var Position:Byte):String;

  Var
    A : Byte;
    CleanedStr : String;

  Begin
    Position:=0; { Init value }
    Position:=Pos(HighLetInd,Str);   { Detect the HighLet Indicator }
    IF Position=0 Then DisplayError(12); { No HighLetInd then error }
    Delete(Str,Position,1); { Delete the HighLet Indicator }
    ReturnHighLight:=Str;  { Return the ®cleaned¯ string }
    CleanedStr:=Str;
    FOR A:=1 TO Length(CleanedStr) DO
      IF CleanedStr[A]=HighLetInd Then DisplayError(13);
  End; { ReturnHighLight }

{----------------------------------------------------------------------------}
{                                                                            }
{ LoadMenuParameters                                                         }
{                    - Description : Converts the user topics_array in a     }
{                                    ®machine¯ array                         }
{                    - Input       : Definition --> The user topics_array    }
{                    - Return      : ----                                    }
{----------------------------------------------------------------------------}
PROCEDURE LoadMenuParameters(Definition: Topics_Array);

  Var
    Main, Sub, Widest : Integer;
    Instr : String[30];
    Finished : Boolean;
    Pos : Byte;
    Code : Byte;

PROCEDURE CheckHigh(Where:Byte);

  Var
    A:Integer;

  Begin
    Case Where OF
      0: Begin    { Check Main }
           FOR A:=1 TO Main DO
             IF ( A <> Main ) AND
                (FinalMenu[A].MainText[FinalMenu[A].MainHighLetter]=FinalMenu[Main].MainText[FinalMenu[Main].MainHighLetter])
                Then DisplayError(15);
         End;
      1: Begin    { Check Sub  }
           FOR A:=1 TO Sub DO
             IF ( A <> Sub ) AND
                (FinalMenu[Main].SubText[A][FinalMenu[Main].SubHighLetter[A]]
                =FinalMenu[Main].SubText[Sub][FinalMenu[Main].SubHighLetter[Sub]])
                Then DisplayError(16);
         End;
    End;
  End;  { CheckHigh }

  Begin
    FillChar(FinalMenu,Sizeof(FinalMenu),#0);  { Empty the FinalMenu array }
    Tot_main := 0; { None Main until now }
    IF Definition[1][1] <> '\' Then DisplayError(1); { If the topic number...}
    { ...isn't a main topic then return error }
    Main:= 0;  { None Main until now }
    Sub:=0;  { None Sub until now }
    Code := 0; { Code is 0 }
    Widest := 0;  { None Widest until now }
    I := 0;  { Initiate value }
    Finished := False;  { Not finished. It's begining!!!! }
    While (I < Max_Topics) AND (Finished=False) DO
      Begin
        Inc(I);
        IF Definition[I] <> '' Then
          Begin
            Instr := Definition[I];
            IF Instr[1] = MainInd Then  { Is a main topic ? }
              Begin   { Yes !!!!!!! }
                IF Main <> 0 Then    { Update values for last sub menu }
                  Begin
                    FinalMenu[Main].Total := Sub;
                    FinalMenu[Main].Width := Widest;
                    IF (FinalMenu[Main].SubText[Sub] = '-') Then DisplayError(10);
                    { Doesn't authorize a space in the end of a submenu }
                  End;
                IF Instr = Mainind + Mainind Then   {must have loaded all data}
                  Begin                         {note number of main menu }
                    Tot_main := Main;           {picks and exit}
                    Finished := true;           { Finished }
                  End
                Else
                  Begin
                    Delete(Instr,1,1); { Delete the '\' character }
                    IF Length(Instr) <= 1 Then DisplayError(2);
                    { Doesn't authorize a Main menu without letters }
                    Inc(Main);
                    IF Main > Max_maintopics Then DisplayError(3);
                    { Doesn't authorize more mains than that we said }
                    IF Not Finished Then { Isn't finished then }
                      Begin
                        FinalMenu[Main].MainText := ReturnHighLight(Instr,Pos);
                        { Returns the string and position of the highletter }
                        FinalMenu[Main].MainHighLetter := Pos;
                        { The position of the HighLetter }
                        CheckHigh(0);
                      End;
                    Sub := 0;                      {reset values for next sub heading}
                    Widest := 0;
                  End;
              End
             Else   { No !!!!!! Not a main menu heading}
              Begin
                Inc(Sub);
                IF Sub > Max_SubTopics Then DisplayError(4);
                { There are to many sub_topics then error 4 }
                IF UpCaseString(Instr)=SpaceInd Then
                 { If is a Space Indicator then }
                  Begin
                    FinalMenu[Main].SubText[Sub] := '-';
                    FinalMenu[Main].ReturnCode[Sub] := 0;
                  End
                Else  { Isn't a space indicator }
                  Begin
                    Inc(Code);
                    FinalMenu[Main].SubText[Sub] := ReturnHighLight(Instr,Pos);
                    FinalMenu[Main].SubHighLetter[Sub] := Pos;
                    FinalMenu[Main].ReturnCode[Sub] := Code;
                    CheckHigh(1);
                  End;
                IF (FinalMenu[Main].SubText[Sub] = '-') AND (FinalMenu[Main].SubText[Sub-1]='-') Then DisplayError(9);
                { Do not allow join spaces }
                IF (FinalMenu[Main].SubText[Sub] = '-') AND (Sub=1) Then DisplayError(10);
                { And doesn't authorize a space in the begining of a submenu }
                IF Length(Instr) > widest Then Widest := Length(Instr);
                { Actualize the width }
              End;
            End; { IF main heading }
      End; { while }
      IF Tot_main = 0 Then DisplayError(5);
      IF Tot_main < 1 Then DisplayError(6);
  End; { LoadMenuParameters }

{----------------------------------------------------------------------------}
{                                                                            }
{ DisplayMainPicks                                                           }
{                  - Description : Displays main heading for menu pick       }
{                  - Input       : No  --> The number of the pick            }
{                                  HighLight --> If false do normal picks    }
{                                                If true select pick         }
{                  - Return      : ----                                      }
{----------------------------------------------------------------------------}
PROCEDURE DisplayMainPicks(No : Byte; HighLight : Boolean);

  Var
    ChT : Char;
    X, I, B : byte;

  Begin
    X := 1;
    IF No = 1 THEN    { If is the first main topic then }
      X := X + MenuDisplay.X1 + MenuDisplay.Gap - 1
   Else    { If is other topic do }
     Begin
       For I := 1 TO No - 1 DO
         X := X + Length(FinalMenu[I].MainText) + MenuDisplay.Gap;
           X := X + MenuDisplay.X1  + MenuDisplay.Gap - 1;
       End;
       IF HighLight THEN  { If is a highlighted topic then }
         Begin
           Fastwrite(X-1,MenuDisplay.Y1,Attribute(MenuDisplay.HFCol,MenuDisplay.MBCol),
                     ' '+Finalmenu[No].MainText+' ');
           Cht:=FinalMenu[No].MainText[FinalMenu[No].MainHighLetter];
           Fastwrite(X+FinalMenu[No].MainHighLetter-1,MenuDisplay.Y1,Attribute(MenuDisplay.HFLetCol,MenuDisplay.MBCol),
                     Cht);
         End
      Else  { If is a normal topic }
        Begin
          Cht:=FinalMenu[No].MainText[FinalMenu[No].MainHighLetter];
          { See what is the Highlighted letter }
          Fastwrite(X-1,MenuDisplay.Y1,Attribute(MenuDisplay.FCol,MenuDisplay.BCol),
                    ' '+Finalmenu[No].MainText+' ');
          { Write the topic }
          FastWrite(X+FinalMenu[No].MainHighLetter-1,MenuDisplay.Y1,
                    Attribute(MenuDisplay.CCol,MenuDisplay.BCol),Cht);
          { And the highlighted letter }
        End;
  End; { DisplayMainPicks }

{----------------------------------------------------------------------------}
{                                                                            }
{ DisplayMainMenu                                                            }
{                  - Description : Draws the main menu                       }
{                  - Input       : ----                                      }
{                  - Return      : ----                                      }
{----------------------------------------------------------------------------}
PROCEDURE DisplayMainMenu(HighLight : Boolean);

  Var
    I : Byte;
    XValue:Byte;

  Begin
    { Draw the box }
    Main_Wid := Succ(MenuDisplay.Gap) ;   {determine the width of the main menu}
    For I := 1 TO Tot_Main DO
      Main_Wid := Main_Wid + MenuDisplay.Gap + Length(FinalMenu[I].Maintext);
      { Write every topics }
    IF Main_Wid + MenuDisplay.X1 - 1 > 80 Then DisplayError(7);
    IF MenuDisplay.X1 + Main_Wid < MenuDisplay.X2 Then XValue:= MenuDisplay.X2
    Else XValue:= MenuDisplay.X1 + Main_Wid;
    Box(MenuDisplay.X1,MenuDisplay.Y1,XValue,MenuDisplay.Y1,
         MenuDisplay.BorCol,MenuDisplay.BCol,0 { Barra Limpa },False,'');
    { Write the Picks }
    For I := 1 TO Tot_Main DO
      DisplayMainPicks(I,FALSE);
    IF HighLight Then DisplayMainPicks(APickM,TRUE);
  End;  { DisplayMainMenu }

{----------------------------------------------------------------------------}
{                                                                            }
{ DisplaySubPicks                                                            }
{                - Description : Displays a sub Pick                         }
{                - Input       : No --> The number of the SubPick to display }
{                                HighColor --> If false do normal color picks}
{                                              If true do high color picks   }
{                - Return      : ----                                        }
{----------------------------------------------------------------------------}
PROCEDURE DisplaySubPicks(No : Byte; HighColor : Boolean);

  Var
    ChT : Char;
    B : Byte;
    Str : String;

  Begin
    Str := FinalMenu[APickM].SubText[No]+Replicate(FinalMenu[APickM].Width-Length(FinalMenu[APickM].SubText[No]),' ');
    { This is the sub topic to write }
    IF HighColor Then   { Is it highlighted? Yes!}
      IF FinalMenu[APickM].SubText[No]='-' Then
        { Is a space then }
        FastWrite(X1+1, Succ(MenuDisplay.Y1) + No ,
                  Attribute(MenuDisplay.HFCol,MenuDisplay.HBCol),
                  LJoinChar+Replicate(FinalMenu[APickM].Width+2,SpaceChar)+RJoinChar)
      Else  { Is a normal topic }
        Begin
          FastWrite(X1 + 2, Succ(MenuDisplay.Y1) + No ,
                    Attribute(MenuDisplay.HFCol,MenuDisplay.HBCol),' '+Str+' ');
          ChT := FinalMenu[APickM].SubText[No][FinalMenu[APickM].SubHighLetter[No]];
          FastWrite(X1 + 2+FinalMenu[APickM].SubHighLetter[No], Succ(MenuDisplay.Y1) + No,
                    Attribute(MenuDisplay.HFLetCol,MenuDisplay.HBCol),Cht);
        End
    Else   { Isn't highlighted }
      Begin
      IF FinalMenu[APickM].SubText[No]='-' Then
        { Is a space }
        FastWrite(X1+1, Succ(MenuDisplay.Y1) + No ,
                  Attribute(MenuDisplay.FCol,MenuDisplay.BCol),
                  LJoinChar+Replicate(FinalMenu[APickM].Width+2,SpaceChar)+RJoinChar)
      Else  { No! It's a normal topic }
        FastWrite(X1 + 2, Succ(MenuDisplay.Y1) + No ,
                  Attribute(MenuDisplay.FCol,MenuDisplay.BCol),
                  ' '+Str+' ');
      IF FinalMenu[APickM].SubText[No] <> '-' Then
        { And if isn't a space then highlight the corresponding letter }
        Begin
          ChT := FinalMenu[APickM].SubText[No][FinalMenu[APickM].SubHighLetter[No]];
          { This is the highcolor letter }
          FastWrite(X1+2+FinalMenu[APickM].SubHighLetter[No],Succ(MenuDisplay.Y1) + No ,
                    Attribute(MenuDisplay.CCol,MenuDisplay.BCol),Cht);
        End;
      End;
  End; { DisplaySubPick }

{----------------------------------------------------------------------------}
{                                                                            }
{ DisplaySubMenu                                                             }
{                - Description : Displays a sub Menu                         }
{                - Input       : No --> The number of the SubMenu to display }
{                - Return      : ----                                        }
{----------------------------------------------------------------------------}
PROCEDURE DisplaySubMenu(No :byte);

  Var
    BotLine : String;
    I : Byte;

  Begin
    IF (Finalmenu[APickM].Total = 0) Then Exit { No submenus in this main }
    Else
      Down := True; { Down the submenu }
    X1 := MenuDisplay.X1 - 1 ;      {determine box coords of sub menu}
    IF No <> 1 Then
      Begin
        For I := 1 TO Pred(No) DO
          X1 := X1 + MenuDisplay.Gap + Length(FinalMenu[I].Maintext);
        X1 := Pred(X1) + MenuDisplay.Gap;
      End
     Else
       X1 := X1 + 1;
       X2 := X1 + Finalmenu[No].width + 5;
       IF X2 > 80 Then
       Begin
           X1 := 80 - (X2 - X1);
           X2 := 80;
       End;
       Y1 := Succ(MenuDisplay.Y1);
       Y2 := Y1 + 1 + Finalmenu[No].total;
       IF MenuDisplay.Shadow Then Shadow(X1,Y1,X2,Y2);
       Box(X1,Y1,X2,Y2,MenuDisplay.BorCol,MenuDisplay.BCol,0{ Caixa Limpa },False,'');
       Box(X1+1,Y1,X2-1,Y2,MenuDisplay.BorCol,MenuDisplay.BCol,MenuDisplay.Style,False,'');
       For I := 1 TO FinalMenu[APickM].total DO
         DisplaySubPicks(I,False);
       APickS := FinalMenu[APickM].LastPick;
       IF NOT (APickS IN [1..FinalMenu[APickM].Total]) Then APickS := 1;
       DisplaySubPicks(APickS,TRUE);
  End;  { DisplaySubMenu }

{----------------------------------------------------------------------------}
{                                                                            }
{ RemoveSubMenu                                                              }
{               - Description : Removes a actual poped up sub menu and       }
{                               actualizes the Lastpick value                }
{               - Input       : ----                                         }
{               - Return      : ----                                         }
{----------------------------------------------------------------------------}
PROCEDURE RemoveSubMenu;

  Begin
    FinalMenu[APickM].LastPick := APickS;
    RestorePage(MenusUnitSaveScreenGroup,2);
  End;  { RemoveSubMenu }

{----------------------------------------------------------------------------}
{                                                                            }
{ PullMenu                                                                   }
{          - Description : This is the main rotine to do all menus...        }
{          - Input       : ----                                              }
{          - Return      : PickM --> The Main Menu choosed                   }
{                          PickS --> The Sub Pick choosed                    }
{----------------------------------------------------------------------------}
FUNCTION PullMenu(HighLight : Boolean):Byte;

  VAR
    ChM: Word;          {keypressed character}
    ChT: Char;
    CheckKey:Word;
    OldX, OldY: Byte;
    ChML: Byte;
    OldCursorStatus: Boolean;
    LetterKey:Byte;
    A,B : Byte;


  PROCEDURE Equal;
   { This rotine is equal to some cases, so it's just to don't join to much  }
   { lines to the program                                                    }

    Begin
      Count := 0;
      Down := False;
      Repeat
        Inc(count);
        ChT := Finalmenu[Count].MainText[FinalMenu[Count].MainHighLetter];
        IF UpCase(ChT)='A' Then CheckKey:=kb_a;
        IF UpCase(ChT)='B' Then CheckKey:=kb_b;
        IF UpCase(ChT)='C' Then CheckKey:=kb_c;
        IF UpCase(ChT)='D' Then CheckKey:=kb_d;
        IF UpCase(ChT)='E' Then CheckKey:=kb_e;
        IF UpCase(ChT)='F' Then CheckKey:=kb_f;
        IF UpCase(ChT)='G' Then CheckKey:=kb_g;
        IF UpCase(ChT)='H' Then CheckKey:=kb_h;
        IF UpCase(ChT)='I' Then CheckKey:=kb_i;
        IF UpCase(ChT)='J' Then CheckKey:=kb_j;
        IF UpCase(ChT)='K' Then CheckKey:=kb_k;
        IF UpCase(ChT)='L' Then CheckKey:=kb_l;
        IF UpCase(ChT)='M' Then CheckKey:=kb_m;
        IF UpCase(ChT)='N' Then CheckKey:=kb_n;
        IF UpCase(ChT)='O' Then CheckKey:=kb_o;
        IF UpCase(ChT)='P' Then CheckKey:=kb_p;
        IF UpCase(ChT)='Q' Then CheckKey:=kb_q;
        IF UpCase(ChT)='R' Then CheckKey:=kb_r;
        IF UpCase(ChT)='S' Then CheckKey:=kb_s;
        IF UpCase(ChT)='T' Then CheckKey:=kb_t;
        IF UpCase(ChT)='U' Then CheckKey:=kb_u;
        IF UpCase(ChT)='V' Then CheckKey:=kb_v;
        IF UpCase(ChT)='W' Then CheckKey:=kb_w;
        IF UpCase(ChT)='X' Then CheckKey:=kb_x;
        IF UpCase(ChT)='Y' Then CheckKey:=kb_y;
        IF UpCase(ChT)='Z' Then CheckKey:=kb_z;
        IF (CheckKey AND $FF00) = (ChM AND $FF00) Then
        Begin
          MenuDisplay.MainIsHigh := True;
          RemoveSubMenu;
          APickM := Count;
          Down := True;
          DisplayMainPicks(APickM,True);
          DisplaySubMenu(APickM);
          IF Not (APickS IN [1..Finalmenu[APickM].Total]) Then
            APickS := 1;
        End;
      Until (Down) OR (Count = Tot_Main);
    End; { Equal }

  Begin  { Main PullMenu }
    OldX:=WhereX;
    OldY:=WhereY;
    Finished := False;
    OldCursorStatus:=CursorIsOn;
    CursorOn(False);
    IF MenuDisplay.Style=0 Then
      Begin
        LJoinChar:=' ';
        RJoinChar:=' ';
        SpaceChar:='Ä';
      End;
    IF MenuDisplay.Style=1 Then
      Begin
        LJoinChar:='Ã';
        RJoinChar:='´';
        SpaceChar:='Ä';
      End;
    IF MenuDisplay.Style=2 Then
      Begin
        LJoinChar:='Ì';
        RJoinChar:='¹';
        SpaceChar:='Í';
      End;
    IF (MenuDisplay.Style < 0) OR (MenuDisplay.Style > 2) Then DisplayError(14);
    InitPages(MenusUnitSaveScreenGroup,2);
    StorePage(MenusUnitSaveScreenGroup,1,1,80,25,1);
    LoadMenuParameters(MenuTopics);
    IF ( APickM < 1 ) Then APickM := 1;
    DisplayMainMenu(False);
    StorePage(MenusUnitSaveScreenGroup,1,1,80,25,2);
    DisplayMainMenu(HighLight);
    MenuDisplay.MainIsHigh:=HighLight;
    For I := 1 TO Tot_Main DO Finalmenu[I].LastPick := 1;
    FinalMenu[APickM].LastPick := APickS;
    IF HighLight AND (APickS <> 0) Then
      Begin
        DisplaySubMenu(APickM);
        Down := True;
      End
    Else
      Down := False;
    Repeat
      While Not Keypressed Do
        Begin
          IF MenuDisplay.ExecuteExtRotine Then MenuDisplay.Rotine;
        End;
      ChM := GetScanCodeW;
      LetterKey := ChM AND $00FF;
      Case ChM of
        kb_F10 : Begin
                   IF Not MenuDisplay.MainIsHigh Then
                     Begin
                       MenuDisplay.MainIsHigh:=True;
                       DisplayMainPicks(APickM,True);
                     End
                   Else
                     Begin
                       IF Down Then
                         Begin
                           IF Not MenuDisplay.AlwaysDown Then
                             Begin
                               Down := False;
                               RemoveSubMenu;
                               DisplayMainmenu(True);
                             End;
                         End;
                     End;
                 End; { F10 }
        kb_Esc : Begin
                   IF Not MenuDisplay.ExitEsc Then
                     Begin
                       IF Down Then
                         Begin
                           IF Not MenuDisplay.AlwaysDown Then
                             Begin
                               Down := false;
                               RemoveSubMenu;
                               DisplayMainmenu(True);
                             End;
                         End
                       Else
                         Begin
                           MenuDisplay.MainIsHigh := False;
                           Finished := True;
                           PullMenu := 0;
                           APickM := 0;
                           APickS := 0;
                         End;
                     End
                   Else
                     Begin
                       MenuDisplay.MainIsHigh := False;
                       Finished:=True;
                       PullMenu := 0;
                       APickM := 0;
                       APickS := 0;
                     End;
                 End; { Esc }
        kb_Enter,
        kb_Pad_Enter : Begin
                        IF MenuDisplay.MainIsHigh Then
                          Begin
                            IF Down OR (Finalmenu[APickM].Total = 0) Then
                              Begin
                                Finished := true;
                                IF Finalmenu[APickM].Total = 0 Then APickS := 0;
                              End
                            Else
                              Begin
                                Down := true;
                                DisplayMainPicks(APickM,False);
                                DisplaySubMenu(APickM);
                              End;
                          End;
                      End; { Enter }
        kb_Right,
        kb_Pad_Right : Begin
                        IF MenuDisplay.MainIsHigh Then
                          Begin
                            Displaymainpicks(APickM,False);  {clear highlight}
                            RemoveSubMenu;
                            IF APickM < ToT_main Then APickM := Succ(APickM)
                            Else APickM := 1;
                            DisplayMainPicks(APickM,True);
                            IF Down Then DisplaySubMenu(APickM);
                          End;
                      End;  { Cursor Right }
        kb_Left,
        kb_Pad_Left : Begin
                       IF MenuDisplay.MainIsHigh Then
                         Begin
                           Displaymainpicks(APickM,False);  {clear highlight}
                           RemoveSubMenu;
                           IF APickM > 1 Then APickM := Pred(APickM)
                           Else APickM := Tot_Main;
                           DisplayMainPicks(APickM,True);
                           IF Down Then DisplaySubMenu(APickM);
                         End;
                    End;  { Cursor Left }
        kb_Down,
        kb_Pad_Down : Begin
                       IF MenuDisplay.MainIsHigh Then
                         Begin
                           IF (Finalmenu[APickM].Total <> 0) Then
                             Begin
                               IF Not Down Then
                                 Begin
                                   Down := true;
                                   DisplayMainPicks(APickM,False);
                                   DisplaySubMenu(APickM);
                                 End
                               Else
                                 Begin
                                   DisplaySubPicks(APickS,False);
                                   IF APickS < Finalmenu[APickM].Total Then
                                   APickS := succ(APickS)
                                   Else APickS := 1;
                                   IF Finalmenu[APickM].SubText[APickS]='-' Then
                                     APickS := Succ(APickS);
                                   DisplaySubPicks(APickS,True);
                                 End;
                             End;
                         End;
                    End;  { Cursor Down }
        kb_Up,
        kb_Pad_Up : Begin
                     IF MenuDisplay.MainIsHigh Then
                       Begin
                         IF (Finalmenu[APickM].Total <> 0) Then
                           Begin
                             IF down Then
                               Begin
                                 DisplaySubPicks(APickS,False);
                                 IF APickS <> 1  Then APickS := pred(APickS)
                                 Else APickS := Finalmenu[APickM].Total;
                                 IF Finalmenu[APickM].SubText[APickS]='-' Then
                                   APickS := Pred(APickS);
                                 DisplaySubPicks(APickS,True);
                               End;
                           End;
                       End;
                   End; { Cursor Up }
        kb_End,
        kb_Pad_End : Begin
                      IF MenuDisplay.MainIsHigh Then
                        Begin
                          IF (Finalmenu[APickM].Total <> 0) Then
                            Begin
                              IF Down Then
                                Begin
                                  DisplaySubPicks(APickS,False);
                                  APickS := Finalmenu[APickM].Total;
                                  DisplaySubPicks(APickS,True);
                                End
                              Else
                                Begin
                                  Displaymainpicks(APickM,False);  {clear highlight}
                                  APickM := ToT_Main;
                                  Displaymainpicks(APickM,True);
                                End;
                            End
                          Else
                            Begin
                              Displaymainpicks(APickM,False);  {clear highlight}
                              APickM := ToT_Main;
                              Displaymainpicks(APickM,True);
                              IF Down Then
                                Begin
                                  DisplayMainPicks(APickM,False);
                                  DisplaySubMenu(APickM);
                                End;
                            End; { second "if" }
                        End; { first "If" }
                    End; { End }
        kb_Home,
        kb_Pad_Home : Begin
                       IF MenuDisplay.MainIsHigh Then
                         Begin
                           IF (Finalmenu[APickM].Total <> 0) Then
                             Begin
                               IF Down Then
                                 Begin
                                   DisplaySubPicks(APickS,False);
                                   APickS := 1;
                                   DisplaySubPicks(APickS,True);
                                 End
                               Else
                                 Begin
                                   Displaymainpicks(APickM,False);  {clear highlight}
                                   APickM := 1;
                                   Displaymainpicks(APickM,True);
                                 End;
                             End
                           Else
                             Begin
                               Displaymainpicks(APickM,False);  {clear highlight}
                               APickM := 1;
                               Displaymainpicks(APickM,True);
                               IF Down Then
                                 Begin
                                   DisplayMainPicks(APickM,False);
                                   DisplaySubMenu(APickM);
                                 End;
                             End;  { second "if }
                         End; { first "if" }
                     End; { Home }
        kb_Alt_A   : Begin
                       Equal;
                     End; { Alt+A }
        kb_Alt_B   : Begin
                       Equal;
                     End; { Alt+B }
        kb_Alt_C   : Begin
                       Equal;
                     End; { Alt+C }
        kb_Alt_D   : Begin
                       Equal;
                     End; { Alt+D }
        kb_Alt_E   : Begin
                       Equal;
                     End; { Alt+E }
        kb_Alt_F   : Begin
                       Equal;
                     End; { Alt+F }
        kb_Alt_G   : Begin
                       Equal;
                     End; { Alt+G }
        kb_Alt_H   : Begin
                       Equal;
                     End; { Alt+H }
        kb_Alt_I   : Begin
                       Equal;
                     End; { Alt+I }
        kb_Alt_J   : Begin
                       Equal;
                    End; { Alt+J }
        kb_Alt_K   : Begin
                       Equal;
                     End; { Alt+K }
        kb_Alt_L   : Begin
                       Equal;
                     End; { Alt+L }
        kb_Alt_M   : Begin
                       Equal;
                     End; { Alt+M }
        kb_Alt_N   : Begin
                       Equal;
                     End; { Alt+N }
        kb_Alt_O   : Begin
                       Equal;
                     End; { Alt+O }
        kb_Alt_P   : Begin
                       Equal;
                     End; { Alt+P }
        kb_Alt_Q   : Begin
                       Equal;
                     End; { Alt+Q }
        kb_Alt_R   : Begin
                       Equal;
                     End; { Alt+R }
        kb_Alt_S   : Begin
                       Equal;
                     End; { Alt+S }
        kb_Alt_T   : Begin
                       Equal;
                     End; { Alt+T }
        kb_Alt_U   : Begin
                       Equal;
                     End; { Alt+U }
        kb_Alt_V   : Begin
                       Equal;
                     End; { Alt+V }
        kb_Alt_W   : Begin
                       Equal;
                     End; { Alt+W }
        kb_Alt_X   : Begin
                       Equal;
                     End; { Alt+X }
        kb_Alt_Y   : Begin
                       Equal;
                     End; { Alt+Y }
        kb_Alt_Z   : Begin
                       Equal;
                     End; { Alt+Z }
      End; { Case ChM }
      Case LetterKey of
        65..90,
        97..122 : Begin
                    IF Down Then
                      Begin
                        Count := 0;
                        Repeat
                          Inc(Count);
                          ChT := Finalmenu[APickM].SubText[Count][FinalMenu[APickM].SubHighLetter[Count]];
                          IF UpCase(ChT)  = Upcase(Char(LetterKey)) Then
                            Begin
                              Finished := True;
                              DisplaySubPicks(APickS,False);
                              APickS := Count;
                              DisplaySubPicks(APickS,True);
                            End;
                        Until (Finished) OR (Count = Finalmenu[APickM].Total);
                      End;
                  End;
      End; { Case LetterKey }
      PullMenu := FinalMenu[APickM].ReturnCode[APickS];
    Until Finished;
    IF MenuDisplay.RemoveMenu Then RestorePage(MenusUnitSaveScreenGroup,1)
    Else RestorePage(MenusUnitSaveScreenGroup,2);
    ReleasePages(MenusUnitSaveScreenGroup);
    GotoXY(OldX,OldY);
    CursorOn(OldCursorStatus);
    ReleasePages(MenusUnitSaveScreenGroup);
  End;  { Pull Menu }

{ ************************        MAIN         ******************************}
{                         *********************                              }

Begin
  DefaultSettings;
End.
