Uses
   Crt,StrsUse,Screen,Keyboard,Windows;

Var
  B,C,D,E,F,G,H:Integer;
  A:LongInt;
  Page:ScreenPtr;

Begin
  ClrScr;
(*  Randomize;
  IF Not InitWindows(144) Then system.write('NÆo h  mem¢ria disponivel');
  Box(1,1,80,25,10,3,2,True,'Testing 1');
  A:=1{-2147483647};
  While Not Keypressed DO
    Begin
      Repeat
        B:=Random(80);
        C:=Random(25);
        D:=Random(80);
        E:=Random(25);
        F:=Random(15);
        G:=Random(7);
        H:=Random(3);
      Until ((B>0) AND (C>0) AND (B<D) AND (C<E) AND (F<>G) AND (D-B > Length('Testing '+Num2Str(A))+4));
      OpenWindow(B,C,D,E,F,G,H,'Window #'+Num2Str(A),A);
      {Delay(100);}
      GotoXY(1,1);
      system.write(A);
      Inc(A);
    End;*)
  Box(1,1,80,25,10,3,1,False,'');
  OpenWindow(10,5,60,15,10,3,2,'Testing this 1st Window',1);
  delay(1000);
  OpenWindow(5,5,40,10,11,4,2,'Testing this 1st Window',2);
  delay(1000);
  OpenWindow(20,10,80,20,12,5,2,'Testing this 1st Window',3);
  delay(1000);
  OpenWindow(30,20,60,25,13,6,2,'Testing this 1st Window',4);
  Delay(2000);
  CloseWindow(1);
  delay(1000);
  CloseWindow(2);
  delay(1000);
  CloseWindow(3);
  delay(1000);
  CloseWindow(4);
  delay(1000);
{  StorePage(Page,20,10,70,20,1);
  Box(20,10,70,20,15,4,1,False,'');
  Delay(1000);
  StorePage(Page,20,10,70,20,2);
  Box(20,10,70,20,15,3,1,False,'');
  Delay(1000);
  StorePage(Page,10,5,70,15,3);
  Box(10,5,70,15,10,2,1,False,'');
  Delay(1000);
  StorePage(Page,5,10,70,20,4);
  Box(50,10,70,20,15,1,1,False,'');
  Delay(1000);
  RestorePage(Page,4);
  Delay(1000);
  RestorePage(Page,3);
  Delay(1000);
  RestorePage(Page,2);
  Delay(1000);
  RestorePage(Page,1);
  Delay(1000);}
  Repeat Until Keypressed;
End.