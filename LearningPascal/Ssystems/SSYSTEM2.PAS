UNIT SSYSTEM2;

INTERFACE
 USES
    CRT,GRAPH,SSYSTEM1;

 FUNCTION ReadNewKey:BYTE;
 PROCEDURE WriteXY(X,Y:INTEGER;Text:STRING);
 PROCEDURE FillArea(X1,Y1,X2,Y2,Color:INTEGER;Mold:WORD);
 PROCEDURE Terminate;
 PROCEDURE InitTable;
 function RKey: char; { Indica o valor em char da tecla pressionada }
 procedure WW(X,Y: integer; txt: string; bc: byte);
 function RStrU(X,Y: integer;bc,size: byte;str,txt: string;var sda: byte;tt: boolean): string;

IMPLEMENTATION

{*****}
  FUNCTION ReadNewKey:BYTE;
   { Indicates the char value of the Key }

    VAR
      Ch1,Ch2: CHAR;
      Continua: BOOLEAN;

    BEGIN
      Continua:= FALSE;
      Ch1:=ReadKey;
      IF Ch1 = #0 THEN
        BEGIN
          Continua:=TRUE;
          Ch2:=ReadKey;
        END;
      ReadNewKey:=ORD(Ch1);
      IF Continua THEN ReadNewKey:=ORD(Ch2);
    END; { ReadNewKey }

{*****}
 PROCEDURE WriteXY(X,Y:INTEGER;Text:STRING);
  { Write something in the XY position }

   BEGIN
     GotoXY(X,Y);
     Write(Text);
   END; { WriteXY }

{*****}
 PROCEDURE FillArea(X1,Y1,X2,Y2,Color:INTEGER;Mold:WORD);
  { Fills a area with a color and mold defined by the user }

   BEGIN
     SetFillStyle(Mold,Color);
     SetColor(Color);
     Rectangle(X1,Y1,X2,Y2);
     FloodFill(X1+1,Y1+1,Color);
   END; { FillArea }

{*****}
  PROCEDURE Terminate;
   { Finish's the program }

    BEGIN
      CloseGraph;
      TextColor(3);
      WriteXY(20,08,'*****************************************');
      WriteXY(20,09,'*        Sequencial Systems V1.0        *');
      WriteXY(20,10,'*        Copyright (c) 1995-1997        *');
      WriteXY(20,11,'*       Bullion MultiSoft Company       *');
      WriteXY(20,12,'*****************************************');
      WriteXY(20,14,'*****************************************');
      WriteXY(20,15,'*         Fernando J. A. Silva          *');
      WriteXY(20,16,'*            12§F 1996-1997             *');
      WriteXY(20,17,'*****************************************');
      WriteLn;
      WriteLn;
      WriteLn;
      WriteLn;
      WriteLn;
    END; { Terminate }

{*****}
  PROCEDURE InitTable;
   { Inits a determinated table of contents }

    BEGIN
      FOR A:=1 TO 8 DO   { Set an empty table of LETRAS }
        BEGIN
          FOR B:=1 TO 4 DO
            BEGIN
              Tabela_Estados_Letras[A,B]:='';
            END;
        END;
      FOR A:=1 TO 8 DO   { Set an empty table of SAIDAS }
        BEGIN
          FOR B:=1 TO 4 DO
            BEGIN
              Tabela_Estados_Saidas[A,B]:='';
            END;
        END;
      FOR A:=1 TO 4 DO   { Set an empty table of Binario4 }
        BEGIN
          FOR B:=1 TO 4 DO
            BEGIN
              Tabela_Estados_Bin4[A,B]:='';
            END;
        END;
      FOR A:=1 TO 4 DO   { Set an empty table of Binario8 }
        BEGIN
          FOR B:=1 TO 4 DO
            BEGIN
              Tabela_Estados_Bin8[A,B]:='';
            END;
        END;
    END; { InitTable }

{***********************************************}
{ As fun‡äes seguintes nÆo sÆo originais minhas }
{ Servem apenas para leitura de strings         }
{***********************************************}

function RKey: char; { Indica o valor em char da tecla pressionada }
var ch1,ch2: char;
    d: boolean;
begin
  d:= False;
  ch1:= readkey;
  if ch1 = #0 then begin D:= True; ch2:= readkey; end;
  RKey:= ch1;
  if d then RKey:= chr(ord(ch2)+128);
end;


procedure WW(X,Y: integer; txt: string; bc: byte);
begin
  setcolor(bc);
  Outtextxy(x+1,y+1,txt);
  setcolor(9);
  Outtextxy(x,y,txt);
end;

function RStrU(X,Y: integer;bc,size: byte;str,txt: string;var sda: byte;tt: boolean): string;
Label 1,2,3,4,5,6,7;
var CStr: string;
    cc: char;
    cou,uoc: byte;
    fcou: integer;
    cur: boolean;
begin
  if tt then goto 7;
  CStr:= str;
  settextstyle(0,0,0);
  settextjustify(0,1);
  WW(X,Y,txt,bc);
  setfillstyle(1,9);
  bar(x+textwidth(txt)+8,y-6,x+(textwidth(txt)+8)+(size*8)+12,y+5);
  setcolor(10);
  rectangle(x+textwidth(txt)+8,y-6,x+(textwidth(txt)+8)+(size*8)+12,y+5);
  setcolor(bc);
  line(x+textwidth(txt)+8+1,y+6,x+(textwidth(txt)+8)+(size*8)+12+1,y+6);
  line(x+(textwidth(txt)+8)+(size*8)+12+1,y-5,x+(textwidth(txt)+8)+(size*8)+12+1,y+6);
  setcolor(10);
  outtextxy(x+(textwidth(txt)+8)+2,y,CStr);
  if not tt then goto 6;
7:CStr:= str;
  cou:= length(CStr);
  cur:= True;
1:setcolor(10);
  outtextxy(x+(textwidth(txt)+8)+2,y,CStr);
5:repeat
    if KeyPressed then goto 3;
    setcolor(10);
    outtextxy((x+(textwidth(txt)+8)+2)+(8*cou),y+1,'_');
    if KeyPressed then goto 2;
    delay(150);
2:  setcolor(9);
    outtextxy((x+(textwidth(txt)+8)+2)+(8*cou),y+1,'_');
    if KeyPressed then goto 3;
    delay(150);
  until KeyPressed;
3:cc:= RKey;
  if Ord(cc) in [32..142,144..174] then
     begin
       if cou = size then goto 4;
       setcolor(9);
       outtextxy(x+(textwidth(txt)+8)+2,y,CStr);
       if cur then
          begin
            insert(UpCase(cc),CStr,cou+1);
            CStr:= copy(CStr,1,size);
          end
       else
          begin
            CStr:= copy(CStr,0,cou)+UpCase(cc)+copy(CStr,cou+2,size);
            CStr:= copy(CStr,1,size);
          end;
       cou:= cou + 1;
       goto 1;
     end
  else begin
         case Ord(cc) of
              13: goto 4;
              8:  begin
                    if (length(CStr) = 0) or (cou = 0) then goto 5;
                    setcolor(9);
                    outtextxy(x+(textwidth(txt)+8)+2,y,CStr);
                    delete(CStr,cou,1);
                    cou:= cou - 1;
                    goto 1;
                  end;
              203: begin
                    if (length(CStr) = 0) or (cou = 0) then goto 5;
                    cou:= cou - 1;
                    goto 1;
                   end;
              205: begin
                     if (length(CStr)+1 > size) or (cou >= length(CStr)) then goto 5;
                     cou:= cou + 1;
                     goto 1;
                     end;
              199: begin
                     cou:= 0;
                     goto 5;
                   end;
              207: begin
                     cou:= length(CStr);
                     goto 5;
                   end;
              210: begin
                     if cur then
                        begin
                          cur:= False;
                          setcolor(10);
                          outtextxy(x+(textwidth(txt)+8)+4+(8*size),y,'I');
                        end
                     else
                        begin
                          cur:= True;
                          setcolor(9);
                          outtextxy(x+(textwidth(txt)+8)+2+(8*size),y,'Û');
                        end;
                     goto 5;
                   end;
              211: begin
                     if (length(CStr) = 0) or (cou = length(CStr)) then goto 5;
                     setcolor(9);
                     outtextxy(x+(textwidth(txt)+8)+2,y,CStr);
                     delete(CStr,cou+1,1);
                     goto 1;
                   end
         else     goto 4;
         end;
       end;
4:setcolor(9);
  outtextxy(x+(textwidth(txt)+8)+2+(8*size),y,'Û');
  Sda:= Ord(cc);
6:RStrU:= CStr;
end;

END.