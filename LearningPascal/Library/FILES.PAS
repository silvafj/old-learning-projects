
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
Unit Files;

{ ************************      INTERFACE      ******************************}
{                         *********************                              }
INTERFACE

  Type
    Dir_Type = Record
                 TopX       : byte; { The X location }
                 TopY       : Byte; { The Y location }
                 Attrib     : byte; { File attributes }
                 BoxType    : byte; { Box Type 0:blank 1:single 2:double }
                 BoxFCol    : byte;
                 BoxBCol    : byte;
                 InfFCol    : byte;
                 InfBCol    : byte;
                 InfBoxBCol : byte;
                 InfBoxFCol : byte;
                 PathFCol   : byte;
                 PathBCol   : byte;
                 InBoxBCol  : byte;
                 InBoxFCol  : byte;
                 DirFCol    : byte;
                 InBoxHiFCol     : byte;
                 InBoxHiBCol     : byte;
                 DetailsInfFCol  : byte;
                 DetailsInfBCol  : byte;
                 DetailsFCol     : byte;
                 DetailsBCol     : byte;
                 AllowEsc        : boolean;
                 ShowDetails     : boolean;
                 DisplayInfo     : boolean;
                 RestoreScreen   : boolean;
                 AllowHelp       : boolean;
                 AllowDetails    : boolean;
                 AllowZoom       : boolean;
                 ZoomLine        : byte;
                 AllowSort       : boolean;
                 InitSort        : byte;
                 Asc             : byte;
                 AllowCD         : boolean;
                 SelectDir       : boolean;
                 AllowInput      : boolean;
               End;

  Var
    DirDisplay : Dir_Type;
    NoMemory : boolean;

{ Public Rotines }
  FUNCTION ExistFile(FileName : String) : Boolean;
  FUNCTION  CopyFile(SourceFile, TargetFile:String): Byte;
  FUNCTION  FileSize(Filename:String): Longint;
  PROCEDURE DefaultSettings;
  FUNCTION DisplayDirectory(DIRFULLFileName: String;var Retcode:integer): String;

{ ************************    IMPLEMENTATION   ******************************}
{                         *********************                              }
IMPLEMENTATION

  Uses
    DOS,Math,StrsUse,Keyboard,Screen,ReadStr;

  Const
    DHelpKey = kb_F1;                     {Alter these keys if desired.       }
    DHelpStr:string[2] = 'F1';        {Note: to disable these keys, set   }
    DJumpParentKey = kb_Alt_B;
    DJumpParentStr: string[5] = 'Alt-B';
    DChangeDirKey = kb_Alt_C;
    DChangeDirStr: string[5] = 'Alt-C';
    DSortOrderKey = kb_Alt_O;
    DSortOrderStr: string[5] = 'Alt-O';
    DSortSizeKey = kb_Alt_S;
    DSortSizeStr: string[5] = 'Alt-S';
    DSortNameKey = kb_Alt_N;
    DSortNameStr: string[5] = 'Alt-N';
    DSortExtKey = kb_Alt_E;
    DSortExtStr: string[5] = 'Alt-E';
    DSortTimeKey = kb_Alt_T;
    DSortTimeStr: string[5] = 'Alt-T';
    DSortDOSKey = kb_Alt_D;
    DSortDOSStr: string[5] = 'Alt-D';
    DSortDos  = 1;
    DSortName = 2;
    DSortExt  = 3;
    DSortSize = 4;
    DSortTime = 5;
    Ascending = 1;
    Descending = 2;

  Var
    IOUnitSaveScreenGroup : ScreenPtr;

{----------------------------------------------------------------------------}
{                                                                            }
{ ExistFile                                                                  }
{          - Description : Checks if a file exists                           }
{          - Input       : Filename --> The file to check                    }
{          - Return      : True if the file exists                           }
{----------------------------------------------------------------------------}
FUNCTION ExistFile(FileName : String) : Boolean;

  Var
    DirInf: SearchRec;

  Begin
    FindFirst(Filename,AnyFile,DirInf);
    ExistFile := (DOSError = 0);
  End;  { ExistFile }

{----------------------------------------------------------------------------}
{                                                                            }
{ CopyFile                                                                   }
{          - Description : Copies a specified file to other place            }
{          - Input       : SourceFile --> The file to copy                   }
{                          TargetFile --> The file is copied to here         }
{          - Return      : 0 - successful                                    }
{                          1 - source and target the same                    }
{                          2 - cannot open source                            }
{                          3 - unable to create target                       }
{                          4 - error during copy                             }
{                                                                            }
{----------------------------------------------------------------------------}
FUNCTION CopyFile(SourceFile, TargetFile:string): byte;

  Var
    Source, Target : File;
    BRead, Bwrite : Word;
    FileBuf  : Array [1..2048] OF char;
    Error : Boolean;

  Begin
    Error := False;
    IF SourceFile = TargetFile Then   { The source and the target are the same }
      Begin
        CopyFile := 1;
        Error := True;
      End;
    IF ExistFile(SourceFile) Then
      Begin
        Assign(Source,SourceFile);
        FileMode := 0;  { I just want to read the source file }
        {$I-}
        Reset(Source,1);
        {$I+}
        Assign(Target,TargetFile);
        FileMode := 1;  { I just want to write the target file}
        {$I-}
        Rewrite(Target,1);
        {$I+}
        IF IOResult <> 0 Then
          Begin
            CopyFile := 3;
            Error := True;
          End;
        IF Not Error Then
          Begin
            Repeat
              BlockRead(Source,FileBuf,SizeOf(FileBuf),BRead);
              BlockWrite(Target,FileBuf,Bread,BWrite);
            Until (Bread = 0) OR (Bread <> BWrite);
            Close(Source);
            Close(Target);
            IF Bread <> Bwrite Then CopyFile := 4
            Else CopyFile := 0;
          End;
      End
    Else CopyFile := 2;
  End; { CopyFile }

{----------------------------------------------------------------------------}
{                                                                            }
{ FileSize                                                                   }
{          - Description : Determine the size of a file                      }
{          - Input       : FileName --> The file to check size               }
{          - Return      : -1 --> If the file was not found                  }
{                          Other value --> The file size                     }
{----------------------------------------------------------------------------}
FUNCTION FileSize( FileName : String ) : Longint;

  Var
    F : File OF byte;

  Begin
    IF ExistFile(FileName) Then
      Begin
        Assign(F,FileName);
        FileMode := 0;  { I just want to read }
        {$I-}
        Reset(F);
        {$I+}
        IF IOResult = 0 Then
          Begin
            FileSize := System.FileSize(F);
            Close(F);
          End
      End
    Else FileSize := -1;
  End; { FileSize }

{----------------------------------------------------------------------------}
{                                                                            }
{ DefaultSettings                                                            }
{          - Description : Init default values                               }
{          - Input       : ----                                              }
{          - Return      : ----                                              }
{----------------------------------------------------------------------------}
PROCEDURE DefaultSettings;

  Begin
    With  DirDisplay  DO
      Begin
        TopX    := 14;
        TopY    := 7;
        AllowEsc := true;
        Attrib := Readonly + Directory + Archive;
        BoxType := 1;
        ShowDetails := true;
        DisplayInfo := true;
        AllowHelp := true;
        AllowZoom   := true;
        ZoomLine := 25;
        AllowSort := true;
        InitSort := DSortDOS;     {sort in DOS order}
        AllowInput := True;
        AllowCD := true;
        SelectDir := false;
        RestoreSCreen := True;
        AllowDetails := true;
        Asc := 1;
        BoxFCol := 15;
        BoxBCol := 7;
        InfFCol := 15;
        InfBCol := 7;
        InfBoxBCol :=7;
        InfBoxFCol :=0;
        PathBCol := 1;
        PathFCol := 15;
        InBoxBCol:= 3;
        InBoxFCol:= 0;
        DirFCol := 0;
        InBoxHiFcol := 15;
        InBoxHiBcol := 2;
        DetailsInfFCol := 15;
        DetailsInfBCol := 1;
        DetailsFCol := 3;
        DetailsBCol := 1;
      End; { with }
  End;  { IODefaultSettings }

{----------------------------------------------------------------------------}
{                                                                            }
{ DisplayDirectory                                                           }
{          - Description : Initializes a window with the files of the current}
{                          directory                                         }
{          - Input       : DirFullFileName --> what you want to display      }
{          - Return      : RetCode --> Input/OutPut variavel that returns    }
{                          the returned operation code                       }
{                                                    0  -  filechosen        }
{                                                    1  -  user escaped      }
{                                                    2  -  not enough memory }
{                                                    3  -  no files matching }
{                                                    99 -  unexpected error  }
{                          Return the chosen file                            }
{----------------------------------------------------------------------------}
FUNCTION DisplayDirectory( DIRFULLFilename: String; Var Retcode : Integer): String;
{
      X1                                                X2
 Y1 > ЩЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЛ
      К Name                                             К
      К лллллллллллллллллллллллллллллллллллллллллллллллл К
      К Path                                             К
      К File                       Drive                 К
      К лллллллллллллллллллллллА   ллллллллллллллллллллА К
      К лллллллллллллллллллллллА   ллллллллллллллллллллА К
      К лллллллллллллллллллллллА   ллллллллллллллллллллА К
      К лллллллллллллллллллллллА                         К
      К лллллллллллллллллллллллВ   ллOpenлл   ллCancelлл К
      К лллллллллллллллллллллллА                         К
      К лллллллллллллллллллллллА    ллл No Details ллл   К
      К                                                  К
 Y2 > К ФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФ К
      К File:ллллллллллллллллллллллллллллллллллллллллллл К                                                К
      К Type:ллллллллллллллллллллллллллллллллллллллллллл К
      К Size:ллллллллллллллллллллллллллллллллллллллллллл К
      К Creation:ллллллллллллллллллллллллллллллллллллллл К
      К Modified:ллллллллллллллллллллллллллллллллллллллл К
      К Acessed:лллллллллллллллллллллллллллллллллллллллл К
      К Attributes:ллллллллллллллллллллллллллллллллллллл К
 Y3 > ШЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭМ

}
  Type
    FRptr = ^FR;
    FR = Record   { This Record keep all files information }
           Name : string[8];
           Ext  : string[3];
           Size : longint;
           Time : longint;
           Attr : byte;
           Fn : integer;
           PrevFR: FRptr;
           NextFR : FRptr;
         End;

  Const
    OKCode = 0;           {ret codes}
    EscCode = 1;
    MemCode = 2;
    NofilesCode = 3;
    UnKnownCode = 99;
    ReadMsg = 'Reading files';
    SortMsg = 'Sorting files';
    NoneMsg = 'No files ... ';

  Var
    X1,X2,Y1,Y2,Y3 : byte;{box dimensions}
    StartDir : String;      {default directory}
    TopFn : integer;           {file number of top file in the display}
    BotFn : integer;           {file number of bottom file in the display}
    HiFn  : integer;           {file number of hilighted file}
    ShowingDetails : Boolean;  { Show details window }
    PathName : String;      {the path section of filename}
    FileMask : String;
    FirstFile : FRptr;
    List_End : FRptr;
    ChosenFile: String;
    TotalFiles: word;
    TotalDirs : word;
    TotalBytes: LongInt;
    Ftemp : FRPtr;
    HeapTop : Pointer; { Variavel to keep the initial state of the Heap }
    DirTop : pointer;
    SortOrder : byte;  { 1-DOS, 2-Name, 3-Ext, 4-Size, 5-Time }
    SortAsc : Boolean; { Make .....}

 { **** Internal Rotines **** }
 { **** ~~~~~~~~~~~~~~~~ **** }
  FUNCTION Subdirectory(B : byte):boolean;
  { Check if exists a subdirectory }
    Begin
      Subdirectory := ((B and Directory) = Directory);
    End; { Internal Function SubDirectory }

{ --- }
  FUNCTION FileAttribs(B:byte):String;
  { Returns a String with the file attributes }
    Var
      S : String;

    Begin
      S := '    ';
      IF ((B AND ReadOnly) = Readonly) Then S[1] := 'R';
      IF ((B AND Hidden) = Hidden) Then S[2] := 'H';
      IF ((B AND SysFile) = SysFile) Then S[3] := 'S';
      IF ((B AND Archive) = Archive) Then S[4] := 'A';
      FileAttribs := S;
    End; { Internal Function FileAttribs }

{ --- }
   FUNCTION LongFileDesc(F:FRptr):String;
   {  }
     Var
       DT : Datetime;
       S  : String;

     Begin
         with F^ do
           begin
             If Ext = '' then S := Padleft(Name,12,' ')
             else S :=  Padleft(Name+'.'+Ext,12,' ');                 {start with name}
             If Subdirectory(Attr) then S := PadLeft(Name+'\',12,' ') {add file size }
           end; {with F^}
         LongFileDesc:=S;
     end;

{ --- }
  PROCEDURE PutDetails(F:FRptr);
  { Put the information in the details box }
    Var
      DT : Datetime;
      S  : String;

    Begin
      IF ShowingDetails Then
        Begin
          With F^ do
            Begin
              UnPackTime(Time,DT);
              With DT do
                begin
                  If Ext = '' then S := Padleft(Name,25,' ')
                  else S := Padleft(Name+'.'+Ext,25,' '); {start with name}
                  FastWrite(X1+8,Y2+1,Attribute(dirdisplay.DetailsFCol,dirdisplay.DetailsBCol),S);
                  S:='';
                  If Subdirectory(Attr) then
                    begin
                      S := PadLeft('File Folder',25,' ');
                      FastWrite(X1+8,Y2+2,Attribute(dirdisplay.DetailsFCol,dirdisplay.DetailsBCol),S);
                      S := PadLeft('',25,' ');{add file size}
                      FastWrite(X1+8,Y2+3,Attribute(dirdisplay.DetailsFCol,dirdisplay.DetailsBCol),S);
                    end
                  else
                    begin
                      S := PadLeft('File',25,' ');
                      FastWrite(X1+8,Y2+2,Attribute(dirdisplay.DetailsFCol,dirdisplay.DetailsBCol),S);
                      S := PadLeft(Num2Str(Size)+' bytes',25,' ');{add file size}
                      FastWrite(X1+8,Y2+3,Attribute(dirdisplay.DetailsFCol,dirdisplay.DetailsBCol),S);
                    end;
                     S :='';
                     Case Month of                               {add month}
                     1 : S := S + 'Jan ';
                     2 : S := S + 'Feb ';
                     3 : S := S + 'Mar ';
                     4 : S := S + 'Apr ';
                     5 : S := S + 'May ';
                     6 : S := S + 'Jun ';
                     7 : S := S + 'Jul ';
                     8 : S := S + 'Aug ';
                     9 : S := S + 'Sep ';
                     10: S := S + 'Oct ';
                     11: S := S + 'Nov ';
                     12: S := S + 'Dec ';
                     end;
                     S :=   S                                   {add the day,year}
                          + PadLeft(Num2Str(Day),2,'0')
                          + ','
                          + Num2Str(Year)
                          + '    ';
                     If Hour > 12 then                          {add a/p time}
                        S :=  S
                             +PadLeft(Num2Str(Hour-12),2,' ')
                             +':'
                             +PadLeft(Num2Str(Min),2,'0')
                             +'p'
                     else
                        S :=  S
                              +PadLeft(Num2Str(Hour),2,' ')
                              +':'
                              +PadLeft(Num2Str(Min),2,'0')
                              +'a';
{                        S := S + '  '+FileAttribs(Attr);}
                    FastWrite(X1+11,Y2+4,Attribute(dirdisplay.DetailsFCol,dirdisplay.DetailsBCol),S);
                 end;   {with DT}
             end; {with F^}
         end;
     end; { Internal Rotine PutDetails }

{ --- }
    Function PathSlash(S : String):String;
    begin
        If S[length(S)] <> '\' then S := S + '\'
        Else S:='C:\';
        PathSlash := S;
    end;  {Sub Func PathSlash}

{ --- }
    Function PathNoSlash(S : String):String;
    begin
        If S[length(S)] = '\' then
           Delete(S,length(S),1);
        PathNoSlash := S;
    end;  {Sub Func PathSlash}

{ --- }
    Function PathParent(S : String):String;
    var P1 : byte;
    begin
        S := PathNoSlash(S);
        P1 := LastPos('\',S);
        PathParent := copy(S,1,P1);
    end;

{ --- }
    Function PathChild(S : String):String;
    begin
        PathChild := PathSlash(PathName + S);
    end;

{ --- }
  PROCEDURE ExtractPathMask;
  { This will separate all information contained in the DIRFULLFileName }
    Var
      P1,P2 : byte;

    Begin
      P1 := LastPos('\',DIRFULLFileName);
      P2 := Pos(':',DIRFULLFilename);
      IF (P1 = 0) AND (P2 = 0) Then
        Begin
          FileMask := DIRFULLFileName;
          PathName := PathSlash(StartDir);
          Exit;
        End;
      IF P1 = Length(DIRFULLFileName) Then
        Begin
          FileMask := '*.*';
          PathName := DIRFULLFileName;
          Exit;
        End;
      IF (P1 = 0) AND (P2 = 2) Then   { x:filename.ext}
        Begin
          Filemask := copy(DIRFULLFileName,3,length(DIRFULLFileName));
          {$I-}
          GetDir(ord(upcase(DIRFULLFileName[1]))-64,PathName);
          {$I-}
          IF IOResult <> 0 Then PathName := PathSlash(StartDir)
          Else PathName := PathSlash(PathName);
          Exit;
        End;
      Filemask := copy(DIRFULLFileName,succ(P1),12);
      PathName := copy(DIRFULLFileName,1,P1);
    End; { Internal Rotine ExtractPathMask }

{ --- }
  PROCEDURE LoadFiles(Mask:String;Attrib:byte);
  { Load the files to the record }
    Var
      Finfo : SearchRec;
      Recsize : word;

   {**}
    PROCEDURE PushOnHeap(F:FrPtr);
    { Keep on Heap the found file }
      Var
        P : byte;

      Begin
        With F^ DO
          Begin
            Attr := Finfo.Attr;
            Time := Finfo.Time;
            Size := Finfo.Size;
            IF FInfo.Name = '..' Then
              Begin
                Name := '..';
                Ext := '';
              End
            Else
              Begin
                P := pos('.',Finfo.Name);
                IF P = 0 Then
                  Begin
                    Name := Finfo.Name;
                    Ext := '';
                  End
                Else
                  Begin
                    Name := copy(FInfo.Name,1, pred(P));
                    Ext := copy(Finfo.Name,succ(P),3);
                  End;
              End;
            Fn := succ(TotalFiles);
            NextFR := nil;
            PrevFr := nil;
            TotalBytes := TotalBytes + Size;
          End;
          Inc(TotalFiles);
          IF Finfo.Attr = Directory Then Inc(TotalDirs);
      End;  { Internal Rotine PushOnHeap from Internal Rotine LoadFiles }

   {**}
    PROCEDURE AllocHeap;
    { Allocate the asked Heap }
      Begin
        IF ((Attrib = Directory) AND (FInfo.Attr <> Directory) ) Then Exit;  {if only looking for directory entries}
        IF (Finfo.Name <> '.') AND (DosError = 0) Then
          Begin
            IF (TotalFiles = 0) Then
              Begin
                PushOnHeap(FirstFile);
                FirstFile^.PrevFR := nil;
                Ftemp :=  FirstFile;
                List_End := FirstFile;
              End
            Else
              Begin
                GetMem(Ftemp^.NextFR,Recsize);
                PushOnHeap(FTemp^.NextFr);
                FTemp := Ftemp^.NextFR;
                FTemp^.PrevFR := List_End;
                List_End := Ftemp;
              End; {If TotalFiles = 0}
          End; { If name <> '.'}
      End; { Internal Rotine AllocHeap from Internal Rotine LoadFiles }

    Begin  { Internal Rotine LoadFiles }
      RecSize := Sizeof(FirstFile^);
      IF MaxAvail < 2 * Recsize Then
        Begin
          NoMemory := true;
          Exit;
        End;
      Fastwrite(X1+5,Y1+5,attribute(DirDisplay.InBoxFcol+blink,DirDisplay.InBoxBCol),ReadMsg);
      FindFirst(PathName+Mask,Attrib,Finfo);
      IF DosError <> 0 Then Exit;
      IF TotalFiles = 0 Then
        Begin
          GetMem(FirstFile,RecSize);
          GetMem(List_End,RecSize);
        End;
      AllocHeap;
      While (DosError = 0) AND (NoMemory = false) DO
        Begin
          IF MaxAvail < RecSize Then NoMemory := true
          Else
            Begin
              FindNext(Finfo);
              AllocHeap;
            End; {If MaxAvail}
        End; {while}
      Fastwrite(X1+5,Y1+5,attribute(DirDisplay.InBoxBcol+blink,DirDisplay.InBoxBCol),ReadMsg);
    End; { Internal Rotine Loadfiles }

{ --- }
  PROCEDURE CalculateBoxDimensions;
  { This will calculate the box dimensions }

    Const
      BoxWidth = 52;
      BoxHeight = 14;
      DetailsHeight = 8;

    Begin
      With DirDisplay DO
        Begin
          IF (TopX < 1) OR (TopX > 80) Then X1 := 14
          Else
            Begin
              IF TopX <= (80 - BoxWidth) Then X1 := TopX
              Else X1 := 80 - Boxwidth; { move box left until it fits }
            End;
          X2 := X1 + Boxwidth;
          IF (TopY < 1) OR (TopY > 25 - 2) Then Y1 := 2
          Else Y1 := TopY;
          IF ShowingDetails Then Y1:= 2;
          Y2 := Y1 + BoxHeight;
          Y3 := Y2 + DetailsHeight;
          IF Y1 + BoxHeight + DetailsHeight < 25 - 2 Then
            Begin
              Y3 := 24;
              Y2 := 17;
              Y1 := 3;
            End;
        End;
    End;  { Internal Rotine CalculateBoxDimensions }

{ --- }
  PROCEDURE DisplayBox;
  { This creates the box }

    Var
      LChar, Rchar : Char;
      Col, I : Integer;
      Line : Char;

    Begin
      With DirDisplay DO
        Begin
          Box(X1,Y1,X2,Y2,BoxFcol,BoxBcol,2,True,'Open a File');
          Shadow(X1,Y1,X2,Y2);
          IF ShowingDetails Then
            Begin
              Box(X1,Y1,X2,Y3,BoxFcol,BoxBcol,2,True,'Open a File');
              Shadow(X1,Y1,X2,Y3);
              Horizontal(succ(X1),Y2,Pred(X2),BoxFCol,BoxBcol,'Ф');
              Box(X1+2,Y1+15,X2-2,Y3-1,DetailsInfFCol,DetailsInfBCol,0,False,'');
              FastWrite(X1+2,Y1+15,Attribute(DetailsInfFCol,DetailsInfBCol),'File:');
              FastWrite(X1+2,Y1+16,Attribute(DetailsInfFCol,DetailsInfBCol),'Type:');
              FastWrite(X1+2,Y1+17,Attribute(DetailsInfFCol,DetailsInfBCol),'Size:');
              FastWrite(X1+2,Y1+18,Attribute(DetailsInfFCol,DetailsInfBCol),'Created:');
              FastWrite(X1+2,Y1+19,Attribute(DetailsInfFCol,DetailsInfBCol),'Modified:');
              FastWrite(X1+2,Y1+20,Attribute(DetailsInfFCol,DetailsInfBCol),'Acessed:');
              FastWrite(X1+2,Y1+21,Attribute(DetailsInfFCol,DetailsInfBCol),'Attributes:');
            End;
        End;
      With DirDisplay DO
        Begin
          FastWrite(X1+2,Y1+1,Attribute(InfFCol,InfBCol),'Name');
          FastWrite(X1+2,Y1+2,Attribute(PathFCol,PathBCol),Replicate(49,' '));
          FastWrite(X1+2,Y1+4,Attribute(InfBoxFCol,InfBoxBCol),'Files');
          Box(X1+2,Y1+5,X1+25,Y1+13,InBoxFCol,InBoxBCol,0,False,'');
          FastWrite(X1+28,Y1+4,Attribute(InfBoxFCol,InfBoxBCol),'Directories');
          Box(X1+28,Y1+5,X1+50,Y1+9,InBoxFCol,InBoxBCol,0,False,'');
        End;
    End;  { Internal Rotine DisplayBox }

{ --- }
  PROCEDURE DisplayPath;
  { Displays the path information }
    Var
      I,BeginPos,SecondPos:byte;
      S1,S2:String;

    Begin
      Fastwrite(X1+2,Y1+2,attribute(DirDisplay.PathFcol,DirDisplay.PathBCol),FileMask);
      ClearText(X1+2,Y1+3,X1+50,Y1+3,DirDisplay.BoxFcol,DirDisplay.BoxBCol,' ');
      IF Length(PathName) <= 50 Then Fastwrite(X1+2,Y1+3,attribute(DirDisplay.BoxFcol,DirDisplay.BoxBCol),PathName)
      Else
        Begin
          I:=0;
          S2:=PathName;
          While Length(S2) > 50 DO
            Begin
              Inc(I);
              BeginPos:=FindCharPos('\',1,S2);
              SecondPos:=FindCharPos('\',I+1,S2);
              S1:=Copy(S2,BeginPos+1,SecondPos-BeginPos-1);
              S2:=ChangeString(S2,S1,'..');
            End;
          Fastwrite(X1+2,Y1+3,attribute(DirDisplay.BoxFcol,DirDisplay.BoxBCol),S2);
        End;
    End;  { Internal Rotine DisplayPath }

{ --- }
  PROCEDURE FillInfo;
  { Put all Information in their places }

    Begin
      DisplayPath;
    end;  {sub proc Fillinfo}

{ --- }
    Function FilePointer(Fn:word): FRptr;
    {MODIFY to go from current pointer - for speed}
    var
      P : FRptr;
      I : integer;
    begin
        If  SortAsc then
        begin
            P := FirstFile;
            If Fn > 1 then
               For I := 2 to Fn do
                   P := P^.NextFr;
        end
        else {Descending}
        begin
            P := List_End;
            If Fn > 1 then
               For I := 2 to Fn do
                   P := P^.PrevFr;
        end;
        FilePointer := P;
    end;  {sub proc filepointer}

{ --- }
  FUNCTION Y_Coord(Fn : word):byte;
  { Calculate the Y coordenate to the next filename }
    Begin
         Y_Coord := Succ(Y1 + 4 + (Fn-TopFn)) ;
    End; { Internal Rotine Y_Coord }

{ --- }
  FUNCTION TopLine:Boolean;

    Begin
      TopLine := (HiFn <= 1);
    End;

{ --- }
  FUNCTION BottomLine:Boolean;

    Begin
      BottomLine := (HiFn + 1 > TotalFiles);
    End;

{ --- }
  PROCEDURE LoLightFile(Fn:word);
  { Writes all unselected files }
    Const
      YCoord = 0;

    Var
      C : byte;
      F : FRptr;

    Begin
      IF (Fn < TopFn) OR (Fn > BotFn ) Then Exit; {file not in display area}
      F := Filepointer(Fn);
      IF Subdirectory(F^.Attr) Then
        Begin
          C := attribute(DirDisplay.DirFcol,DirDisplay.InBoxBCol);
{          Fastwrite(X1+28,Y_Coord(Fn),C,' '+LongFileDesc(F)+'           ');}
        End
      Else
          C := attribute(DirDisplay.InBoxFCol,DirDisplay.InBoxBCol);
          Fastwrite(X1+2,Y_Coord(Fn),C,' '+LongFileDesc(F)+'           ');
    End; { Internal Rotine LoLightFile }

{ --- }
  PROCEDURE HiLightFile(Fn:word);
  { Writes the selected file }
    Var
      F : FRptr;

    Begin
      IF (Fn < TopFn) OR (Fn > BotFn) Then Exit; {file not in display area}
      F := Filepointer(Fn);
{      IF Subdirectory(F^.Attr) Then
        Begin
          Fastwrite(X1+28,Y_Coord(Fn),attribute(DirDisplay.InBoxHiFcol,DirDisplay.InBoxHiBCol),
                    ' '+LongFileDesc(F)+'           ');
        End
      Else}
      Fastwrite(X1+2,Y_Coord(Fn),attribute(DirDisplay.InBoxHiFcol,DirDisplay.InBoxHiBCol),
                +' '+LongFileDesc(F)+'           ');
      IF ShowingDetails Then PutDetails(F);
    End; { Internal Rotine HiLightFile }

{ --- }
  FUNCTION File_Name(Fn : word):String;

    Var
      F : FRPtr;
      Fname : String;

    Begin
      F := FilePointer(Fn);
      Fname := F^.Name;
      IF F^.Ext <> '' Then Fname := Fname+'.'+F^.Ext;
      File_Name := Fname;
    End;{ Internal Rotine File_Name}

{ --- }
  PROCEDURE DisplayFiles;

    Var
      I : integer;

    Begin
      For I := TopFn to BotFn Do
        If (I <> HiFn) and (I <= TotalFiles) then LolightFile(I);
      HiLightFile(HiFn);
    End; { Internal Rotine DisplayFiles }

{ --- }
  PROCEDURE ScrollDown;
  { Make the filenames scrolling down in the window }
    Begin
      Inc(TopFn);
      Inc(BotFn);
      DisplayFiles;
    End; { Internal Rotine ScrollDown}

{ --- }
  PROCEDURE ScrollUp;
  { Make the Filenames scrolling up in the window }
    Begin
      Dec(TopFn);
      Dec(BotFn);
      DisplayFiles;
    End; { Internal Rotine ScrollUp}

{ --- }
  FUNCTION Larger(Ptr1,Ptr2: FRptr) : boolean;

    Var
      N1,N2 : string[8];
      E1,E2 : string[8];

    Begin
      Case SortOrder OF
        DSortDos   : Larger := (Ptr1^.Fn > Ptr2^.Fn);
        DSortNAME  : Begin
                       IF Ptr1^.Name = Ptr2^.Name Then Larger := Ptr1^.Ext > Ptr2^.Ext
                       Else Larger := Ptr1^.Name > Ptr2^.Name;
                     End;
        DSortEXT   : Begin
                       IF Ptr1^.Ext = Ptr2^.Ext Then Larger := Ptr1^.Name > Ptr2^.Name
                       Else Larger := Ptr1^.Ext > Ptr2^.Ext;
                     End;
        DSortSIZE  : Larger := (Ptr1^.Size > Ptr2^.Size);
        DSortTIME  : Larger := (Ptr1^.Time > Ptr2^.Time);
        Else Larger := False;
      End; {Case}
    End; { Internal Rotine Larger }

{ --- }
  PROCEDURE SwapIt(Var Ptr1,Ptr2: FRPtr);

    Var
      Temp : FR;
      Size : integer;

    Begin
      Temp := Ptr2^;
      Size := sizeof(Temp) - 8;
      Move(Ptr1^,Ptr2^,Size);
      Move(Temp,Ptr1^,Size);
    End;  { Internal Rotine SwapIt }

{ --- }
  PROCEDURE ShellSort;
  { Creates a list of files with a shell sort }
    Var
      I,J,Delta : longint;
      Swapped : boolean;
      Ptr1,Ptr2 : FRPtr;

    Begin
      Delta := TotalFiles div 2;
      Repeat
        Repeat
          Swapped := false;
          Ptr1 := FirstFile;
          Ptr2 := Ptr1;
          For I := 1 TO Delta DO Ptr2 := Ptr2^.NextFr;
          For I := 1 TO TotalFiles - Delta DO
            Begin
              IF I > 1 Then
                Begin
                  Ptr1 := Ptr1^.NextFr;
                  Ptr2 := Ptr2^.NextFr;
                End;
              IF Larger(Ptr1,Ptr2) Then
                Begin
                  SwapIt(Ptr1,Ptr2);
                  Swapped := true;
                End;
            End;
        Until (not Swapped);
        Delta := delta div 2;
      Until Delta = 0;
    End; { Internal Rotine ShellSort }

{ --- }
  PROCEDURE ReSort;

    Begin
      ClearText(X1+2,Y1+5,X1+25,Y1+13,DirDisplay.InBoxFcol,DirDisplay.InBoxBCol,' ');
      Fastwrite(X1+2,Y1+5,attribute(DirDisplay.InBoxFcol+blink,DirDisplay.InBoxBCol),SortMsg);
      ShellSort;
      TopFn := 1;
      HiFn := 1;
      BotFn := 9;
      DisplayFiles;
    End; { Internal Rotine ReSort }

{ --- }
  PROCEDURE DisplayNewDirectory;
  { Make the box and display the information }

    Var
      A : Byte;

    Begin
      A := DirDisplay.Attrib AND (AnyFile - VolumeID);
      DisplayBox;
      TotalFiles := 0;
      TotalBytes := 0;
      TotalDirs  := 0;
      Mark(DirTop);
      IF DirDisplay.AllowCd OR DirDisplay.SelectDir Then
        Begin
          IF Subdirectory(A) Then
            Begin
              LoadFiles('*.*',Directory); { load directory details first }
              Loadfiles(Filemask,A and (anyfile - Directory));  {then load other files with mask}
            End
            Else LoadFiles(Filemask,A and (Anyfile - Directory));
        End
      Else LoadFiles(Filemask,A and (anyfile - Directory)); { automatically removed directory type files }
      FillInfo;
      IF SortOrder <> DSortDOS Then ShellSort;
      IF TotalFiles = 0 Then Fastwrite(X1+5,Y1+6,attribute(DirDisplay.InBoxFcol,DirDisplay.InBoxBCol),NoneMsg)
      Else DisplayFiles;
    End;  { Internal Rotine DisplayNewDirectory }

{ --- }
  PROCEDURE ShowHelpScreen;
  { Shows a help screen to the user }
    Const
      Width = 70;
      Height = 14 + 8;

    Var
      Str : String;
      S  : word;
      Sc : pointer;
      X,Y : byte;
      key : word;
      ChH : char;

    Begin
      X := 5;
      Y := Y1;
      StorePage(IOUnitSaveScreenGroup,1,1,80,25,2);
      Box(X,Y,X+width,Y+Height,DirDisplay.BoxFCol,DirDisplay.BoxBCol,1,False,'');
      Case SortOrder of
        DSortDos  : Str := ' DOS';
        DSortName : Str := ' NAME';
        DSortExt  : Str := ' EXT';
        DSortSize : Str := ' SIZE';
        DSortTime : Str := ' TIME';
        end; {case}
        If SortAsc then
           Str := Str +' in ASCENDING order'
        else
           Str := Str +' in DESCENDING order';
        Str := ' Current: '+Str;
        If DirDisplay.AllowSort then
        begin
            Fastwrite(X+4,Y+2,attribute(DirDisplay.infFCol,DirDisplay.BoxBCol),DSortDOSStr);
            Fastwrite(X+7+length(DSortDOSStr),Y+2,
                      attribute(DirDisplay.BoxFCol,DirDisplay.BoxBCol),
                      'sort in native DOS order');
            Fastwrite(X+4,Y+3,attribute(DirDisplay.infFCol,DirDisplay.BoxBCol),DSortNameStr);
            Fastwrite(X+7+length(DSortNameStr),Y+3,
                      attribute(DirDisplay.BoxFCol,DirDisplay.BoxBCol),
                      'sort alphabetically by file Name');
            Fastwrite(X+4,Y+4,attribute(DirDisplay.infFCol,DirDisplay.BoxBCol),DSortExtStr);
            Fastwrite(X+7+length(DSortExtStr),Y+4,
                      attribute(DirDisplay.BoxFCol,DirDisplay.BoxBCol),
                      'sort alphabetically by file Extension');
            Fastwrite(X+4,Y+5,attribute(DirDisplay.infFCol,DirDisplay.BoxBCol),DSortSizeStr);
            Fastwrite(X+7+length(DSortSizeStr),Y+5,
                      attribute(DirDisplay.BoxFCol,DirDisplay.BoxBCol),
                      'sort by file Size');
            Fastwrite(X+4,Y+6,attribute(DirDisplay.infFCol,DirDisplay.BoxBCol),DSortTimeStr);
            Fastwrite(X+7+length(DSortTimeStr),Y+6,
                      attribute(DirDisplay.BoxFCol,DirDisplay.BoxBCol),
                      'sort by date/Time of file');
            Fastwrite(X+4,Y+7,attribute(DirDisplay.infFCol,DirDisplay.BoxBCol),DSortOrderStr);
            Fastwrite(X+7+length(DSortOrderStr),Y+7,
                      attribute(DirDisplay.BoxFCol,DirDisplay.BoxBCol),
                      'sort in ascending or descending Order');
        end;
        If DirDisplay.AllowZoom then
        begin
        end;
        If DirDisplay.AllowCD then
        begin
            Fastwrite(X+4,Y+11,attribute(DirDisplay.infFCol,DirDisplay.BoxBCol),DChangeDirStr);
            Fastwrite(X+7+length(DChangeDirStr),Y+11,
                      attribute(DirDisplay.BoxFCol,DirDisplay.BoxBCol),
                      'change to new drive/directory');
            Fastwrite(X+4,Y+12,attribute(DirDisplay.infFCol,DirDisplay.BoxBCol),DJumpParentSTr);
            Fastwrite(X+7+length(DJumpParentStr),Y+12,
                      attribute(DirDisplay.BoxFCol,DirDisplay.BoxBCol),
                      'backup to parent directory');
        end;

        key := getscancodew;
        ChH := upcase(GetChar(key));
        RestorePage(IOUnitSaveScreenGroup,2);
    end;

{ --- }
  PROCEDURE ProcessKeys;
  { The name tells everything }

    Var
      Key : Word;
      Letter : Char;
      Finished : Boolean;

    Begin
      Finished := False;
        Repeat
          Key := GetScanCodeW;
          Letter := GetChar(Key);
          Case Key OF
            kb_esc : Begin
                       IF DirDisplay.AllowEsc Then
                         Begin
                           Finished := true;
                           Retcode := EscCode;
                           ChosenFile := '';
                         End;
                     End; { kb_Esc }
            kb_down,
            kb_pad_down : Begin
                            IF Not BottomLine Then
                              Begin
                                LoLightFile(HiFn);
                                Inc(HiFn);
                                IF HiFn <= BotFn Then HiLightFile(HiFn)
                                Else ScrollDown;
                              End;
                          End; { kb_pad_down }
             kb_up,
             kb_pad_up :  Begin
                            IF Not TopLine Then
                              Begin
                                LoLightFile(HiFn);
                                Dec(Hifn);
                                IF HiFn >= TopFn Then HiLightFile(HiFn)
                                Else ScrollUp;
                              End;
                          End; { kb_pad_up }
             kb_right,
             kb_pad_right : Begin
{               If HiFn < TotalFiles then
                    begin
                        LolightFile(HiFn);
                        Inc(HiFn);
                        If HiFn > BotFn then
                           ScrollDown
                        else
                           HiLightFile(HiFn);
                    end;                     }
                            End; { kb_right }
             kb_left,
             kb_pad_left :  Begin
{              If HiFn > 1 then
                    begin
                        LolightFile(HiFn);
                        Dec(HiFn);
                        If HiFn < TopFn then
                           ScrollUp
                        else
                           HiLightFile(HiFn);
                    end;}
                            End;
             kb_home,
             kb_pad_home :  Begin
                              LoLightFile(HiFn);
                              HiFn := TopFn;
                              HiLightFile(HiFn);
                            End; { kb_pad_home }
             kb_end,
             kb_pad_end :   Begin
                              LoLightFile(HiFn);
                              HiFn := BotFn;
                              HiLightFile(HiFn);
                            End; { kb_pad_end }
             kb_PgUp,
             kb_Pad_PgUp :  Begin
                              TopFn := TopFn - 9;
                              BotFn := BotFn - 9;
                              IF TopFn < 1 Then
                                Begin
                                  BotFn := BotFn + (1 - TopFn);
                                  TopFn := 1;
                                End;
                              LoLightFile(HiFn);
                              HiFn := TopFn;
                              HiLightFile(HiFn);
                              DisplayFiles;
                            End;  { kb_pad_PgUp }
             kb_PgDown,
             kb_Pad_PgDown : Begin
                               TopFn := TopFn + 9;
                               BotFn := BotFn + 9;
                               IF BotFn > TotalFiles Then
                                 Begin
                                   TopFn := TopFn - (BotFn - TotalFiles);
                                   BotFn := TotalFiles;
                                 End;
                               LoLightFile(HiFn);
                               HiFn := BotFn;
                               HiLightFile(HiFn);
                               DisplayFiles;
                             End; { kb_pad_PgDown }
             kb_Alt_D : Begin
                          IF DirDisplay.AllowDetails Then
                            Begin
                              ShowingDetails := Not ShowingDetails;
                              RestorePage(IOUnitSaveScreenGroup,1);
                              CalculateBoxDimensions;
                              DisplayBox;
                              FillInfo;
                              DisplayFiles;
                            End;
                        End; { kb_Alt_D }
    DSortOrderKey : Begin
                      IF DirDisplay.AllowSort then
                        Begin
                          SortAsc := not SortAsc;
                          TopFn := 1;
                          HiFn := 1;
                          BotFn := 9;
                          DisplayFiles;
                        End;
                    End; { DSortOrderKey }
    DSortNameKey  : Begin
                      IF DirDisplay.AllowSort AND (SortOrder <> DSortName) Then
                        Begin
                          SortOrder := DSortName;
                          ReSort;
                        End;
                    End; { DSortNameKey }
    DSortExtKey   : Begin
                      IF DirDisplay.AllowSort AND (SortOrder <> DSortExt) Then
                        Begin
                          SortOrder := DSortExt;
                          ReSort;
                        End;
                    End; { DSortExtKey }
    DSortSizeKey  : Begin
                      IF DirDisplay.AllowSort AND (SortOrder <> DSortSize) Then
                        Begin
                          SortOrder := DSortSize;
                          ReSort;
                        End;
                    End; { DSortSizeKey }
    DSortTimeKey  : Begin
                      IF DirDisplay.AllowSort AND (SortOrder <> DSortTime) Then
                        Begin
                          SortOrder := DSortTime;
                          ReSort;
                        End;
                    End; { DSortTimeKey }
    DSortDOSKey   : Begin
                      IF DirDisplay.AllowSort AND (SortOrder <> DSortDOS) Then
                        Begin
                          SortOrder := DSortDOS;
                          ReSort;
                        End;
                    End; { DSortDOSKey }
    DHelpKey      : Begin
                      If DirDisplay.AllowHelp Then ShowHelpScreen;
                    End; { DHelpKey }
    DJumpParentKey: Begin
                      IF DirDisplay.AllowCD AND (length(PathName) > 3) Then
                        Begin
                          PathName := PathParent(PathName);
                          Release(DirTop);
                          DisplayNewDirectory;
                        End;
                    End; { DJumpParentKey }
    DChangeDirKey : begin
                      ReadUpCaseString(X1+2,Y1+2,49,255,'',0,FileMask);
                      TopFn := 1;
                      HiFn := 1;
                      BotFn := 9;
                      DisplayNewDirectory;
                    end;
    Kb_Enter : Begin
                 IF SubDirectory(FilePointer(HiFn)^.Attr) Then
                   Begin
                     IF File_Name(HiFn) = '..' Then PathName := PathParent(PathName)
                     Else PathName := PathChild(File_Name(HiFn));
                     IF (DirDisplay.SelectDir = false) Then
                       Begin
                         TopFn:=1;
                         BotFn:=9;
                         HiFn:=1;
                         Release(DirTop);
                         DisplayNewDirectory;
                       End
                     Else                      {return the Directory}
                       Begin
                         Finished := true;
                         ChosenFile := PathNoSlash(PathName);
                       End;
                   End
                 Else
                   Begin
                     Finished := true;
                     ChosenFile := PathName+File_Name(HiFn);
                   End;
               End; { Enter }
    end;
        Until Finished;
    end; {sub proc Process_Keys}

 { **** End Of Internal Rotines **** }
 { **** ~~~~~~~~~~~~~~~~~~~~~~~ **** }

   Begin  { Main Rotine DisplayDirectory }
     Mark(HeapTop); { Keep the actual state of the Heap }
     NoMemory := False; { There is memory. For now!!! }
     ShowingDetails := DirDisplay.ShowDetails; { Show details window ? }
     SortAsc := DirDisplay.Asc = 1;
     SortOrder := DirDisplay.InitSort; { How it will be sorted }
     TopFn:=1;
     BotFn:=9;
     HiFn:=1;
     StorePage(IOUnitSaveScreenGroup,1,1,80,25,1); { Store the first Page }
     {$I-}
     GetDir(0,StartDir); { The actual directory }
     {$I+}
     IF IOResult <> 0 Then
       Begin
         Retcode := UnknownCode;
         Exit;
       End;
     Retcode := OKCode; { Assume it will succeed! }
     ExtractPathMask;
     CalculateBoxDimensions;
     DisplayNewDirectory;
     ProcessKeys;
     IF DirDisplay.RestoreScreen Then RestorePage(IOUnitSaveScreenGroup,1)
     Else Begin End;
     ReleasePages(IOUnitSaveScreenGroup);
     DisplayDirectory := ChosenFile;
   End; { DisplayDirectory }

{ ************************        MAIN         ******************************}
{                         *********************                              }

  Begin
    DefaultSettings;
  End.
