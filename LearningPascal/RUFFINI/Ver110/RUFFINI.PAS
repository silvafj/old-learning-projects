PROGRAM ruffini;
USES
  CRT,TP;

VAR
   a,b,c,d,e,f,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y:REAL;
   aa,bb,cc,dd,ee,ff,hg,ii,jj,kk,ll,mm,nn,oo,pp:REAL;
   z,g:INTEGER;
   ch:CHAR;

LABEL
      1;

(* Function que transforma um n£mero inteiro numa string com um determinado *)
(* tamanho *)

FUNCTION InToStr(num:LONGINT;tam:INTEGER):STRING;

 VAR
   s:STRING;

BEGIN
 STR(num,s);
 IF length(s) < tam THEN
   BEGIN
     MOVE(s[1], s[succ(tam - length(s))],length(s));
     FILLCHAR(s[1],tam - length(s),'0');
   end;
 s[0]:=char(tam);
 intostr:=s;
END;


                       (* Programa Principal *)

 BEGIN
   REPEAT
      CLRSCR;
      fillscr(1,1,80,25,1);
      textcolor(15);
      writexy('Ruffini    Vers„o 1.10',5,2);
      writexy('Fernando Jorge Almeida Silva',5,25);
      printxy('Geral Inc.',175,62,25,FALSE);
      for z:= 1 to 24 do
         begin
             textcolor(15);
             writexy('@',74,1+z);
             delay(30);
             textcolor(1);
             writexy('@',74,1+z);
             delay(30);
         end;
      textcolor(15);
      writexy('@',74,25);
      printxy('1995',250,75,25,FALSE);
      textcolor(14);
      horizontal(3,4,75,'Í');
      horizontal(3,23,75,'Í');
      writexy('É',3,4);
      for z:= 1 to 18 do
         begin
             writexy('º',3,4+z);
         end;
      writexy('È',3,23);
      writexy('»',78,4);
      for z:= 1 to 18 do
         begin
             writexy('º',78,4+z);
         end;
      writexy('¼',78,23);
      WRITEXY('R U F F I N I',30,5);
      WRITEXY('Utilizando o m‚todo de Ruffini pode-se calcular os zeros em equa‡”es',7,7);
      WRITEXY('at‚ ao 5§ grau',28,8);
      WRITEXY('Caso o valor num‚rico do grau seja zero introduza zero', 13,9);
      TEXTCOLOR(12+128);
      WRITEXY('Para sair pressione Ctrl+Break ',22,11);
      TEXTCOLOR(15);
      WRITEXY('Introduza o valor num‚rico do mon¢mio de grau 5 : ',14,13);
      READLN(a);
      WRITEXY('Introduza o valor num‚rico do mon¢mio de grau 4 : ',14,14);
      READLN(b);
      WRITEXY('Introduza o valor num‚rico do mon¢mio de grau 3 : ',14,15);
      READLN(c);
      WRITEXY('Introduza o valor num‚rico do mon¢mio de grau 2 : ',14,16);
      READLN(d);
      WRITEXY('Introduza o valor num‚rico do mon¢mio de grau 1 : ',14,17);
      READLN(e);
      WRITEXY('Introduza o valor num‚rico do mon¢mio de grau 0 : ',14,18);
      READLN(f);

  IF (a<>0) THEN BEGIN
      CLRSCR;
      GOTOXY(11,5);
      WRITE(+a:6:2);
      GOTOXY(21,5);
      WRITE(+b:6:2);
      GOTOXY(31,5);
      WRITE(+c:6:2);
      GOTOXY(41,5);
      WRITE(+d:6:2);
      GOTOXY(51,5);
      WRITE(+e:6:2);
      GOTOXY(61,5);
      WRITE(+f:6:2);
      FOR z:=1 TO 10 DO
      WRITEXY('³',10,3+z);
      FOR z:=1 TO 78 DO
      WRITEXY('Ä',1+z,10);
      WRITEXY('Å',10,10);
      FOR g:=-1000 TO 1000 DO
        BEGIN
          GOTOXY(1,9);
          WRITE(+intostr(g,5));
          GOTOXY(11,11);
          WRITE(+a:6:2);
          h:=a*g;
          GOTOXY(21,9);
          WRITE(+h:6:2);
          i:=b+h;
          GOTOXY(21,11);
          WRITE(+i:6:2);
          j:=i*g;
          GOTOXY(31,9);
          WRITE(+j:6:2);
          k:=c+j;
          GOTOXY(31,11);
          WRITE(+k:6:2);
          l:=k*g;
          GOTOXY(41,9);
          WRITE(+l:6:2);
          m:=d+l;
          GOTOXY(41,11);
          WRITE(+m:6:2);
          n:=m*g;
          GOTOXY(51,9);
          WRITE(+n:6:2);
          o:=e+n;
          GOTOXY(51,11);
          WRITE(+o:6:2);
          p:=o*g;
          GOTOXY(61,9);
          WRITE(+p:6:2);
          q:=f+p;
          GOTOXY(61,11);
          WRITE(+q:6:2);
            IF q=0 THEN
                 BEGIN
                     WRITELN('');
                     WRITELN('');
                     WRITE('Zeros:'+intostr(g,2));
                     delay(1000);
      FOR z:=1 TO 10 DO
      WRITEXY('³',10,11+z);
      FOR z:=1 TO 78 DO
      WRITEXY('Ä',1+z,17);
      WRITEXY('Å',10,17);
      FOR g:=-1000 TO 1000 DO
        BEGIN
          GOTOXY(1,16);
          WRITE(+intostr(g,5));
          GOTOXY(11,18);
          WRITE(+a:6:2);
          r:=a*g;
          GOTOXY(21,16);
          WRITE(+r:6:2);
          s:=i+r;
          GOTOXY(21,18);
          WRITE(+s:6:2);
          t:=s*g;
          GOTOXY(31,16);
          WRITE(+t:6:2);
          u:=k+t;
          GOTOXY(31,18);
          WRITE(+u:6:2);
          v:=u*g;
          GOTOXY(41,16);
          WRITE(+v:6:2);
          w:=m+v;
          GOTOXY(41,18);
          WRITE(+w:6:2);
          x:=w*g;
          GOTOXY(51,16);
          WRITE(+x:6:2);
          y:=o+x;
          GOTOXY(51,18);
          WRITE(+y:6:2);
            IF y=0 THEN
                 BEGIN
                     WRITELN('');
                     WRITELN('');
                     WRITE('Zeros : '+intostr(g,2));
                     delay(1000);
      CLRSCR;
      FOR z:=1 TO 10 DO
      WRITEXY('³',10,3+z);
      FOR z:=1 TO 78 DO
      WRITEXY('Ä',1+z,10);
      WRITEXY('Å',10,10);
      FOR g:=-1000 TO 1000 DO
        BEGIN
          GOTOXY(1,9);
          WRITE(+intostr(g,5));
          GOTOXY(11,11);
          WRITE(+a:6:2);
          aa:=a*g;
          GOTOXY(21,9);
          WRITE(+aa:6:2);
          bb:=aa+s;
          GOTOXY(21,11);
          WRITE(+bb:6:2);
          cc:=bb*g;
          GOTOXY(31,9);
          WRITE(+cc:6:2);
          dd:=cc+u;
          GOTOXY(31,11);
          WRITE(+dd:6:2);
          ee:=dd*g;
          GOTOXY(41,9);
          WRITE(+ee:6:2);
          ff:=ee+w;
          GOTOXY(41,11);
          WRITE(+ff:6:2);
            IF ff=0 THEN
                 BEGIN
                     WRITELN('');
                     WRITELN('');
                     WRITE('Zeros : '+intostr(g,2));
                     delay(1000);
                     GOTOXY(10,20);
                     FOR z:=1 TO 20 DO
                     WRITEXY('Ä',10+z,20);
                     o:=-bb;
                     p:=(SQR(o))-(4*a*dd);
                     IF p<0 THEN
                       BEGIN
                         WRITEXY('N„o tem zeros na f¢rmula resolvente',1,23);
                         GOTO 1;
                       END;
                     q:=SQRT(p);
                     r:=o+q;
                     GOTOXY(10,19);
                     WRITE(+o:6:2,'+',+q:6:2);
                     s:=2*a;
                     GOTOXY(10,21);
                     WRITE(+s:6:2);
                     t:=r/s;
                     GOTOXY(40,20);
                     WRITE('Zeros : ',+t:6:2);
                     DELAY(2000);

                     GOTOXY(10,20);
                     FOR z:=1 TO 20 DO
                     WRITEXY('Ä',10+z,20);
                     o:=-bb;
                     p:=(SQR(o))-(4*a*dd);
                     IF p<0 THEN
                       BEGIN
                         WRITEXY('N„o tem zeros na f¢rmula resolvente',1,23);
                         GOTO 1;
                       END;
                     q:=SQRT(p);
                     r:=o-q;
                     GOTOXY(10,19);
                     WRITE(+o:6:2,'-',+q:6:2);
                     s:=2*a;
                     GOTOXY(10,21);
                     WRITE(+s:6:2);
                     t:=r/s;
                     GOTOXY(40,20);
                     WRITE('Zeros : ',+t:6:2);
                     DELAY(1000);
                     GOTO 1;
                 END;
        END;
                 END;
        END;
                 END;
        END;
  END;


  IF (a=0) AND (b<>0) THEN BEGIN
      CLRSCR;
      GOTOXY(11,5);
      WRITE(+b:6:2);
      GOTOXY(21,5);
      WRITE(+c:6:2);
      GOTOXY(31,5);
      WRITE(+d:6:2);
      GOTOXY(41,5);
      WRITE(+e:6:2);
      GOTOXY(51,5);
      WRITE(+f:6:2);
      FOR z:=1 TO 10 DO
      WRITEXY('³',10,3+z);
      FOR z:=1 TO 78 DO
      WRITEXY('Ä',1+z,10);
      WRITEXY('Å',10,10);
      FOR g:=-1000 TO 1000 DO
        BEGIN
          GOTOXY(1,9);
          WRITE(+intostr(g,5));
          GOTOXY(11,11);
          WRITE(+b:6:2);
          h:=b*g;
          GOTOXY(21,9);
          WRITE(+h:6:2);
          i:=c+h;
          GOTOXY(21,11);
          WRITE(+i:6:2);
          j:=i*g;
          GOTOXY(31,9);
          WRITE(+j:6:2);
          k:=d+j;
          GOTOXY(31,11);
          WRITE(+k:6:2);
          l:=k*g;
          GOTOXY(41,9);
          WRITE(+l:6:2);
          m:=e+l;
          GOTOXY(41,11);
          WRITE(+m:6:2);
          n:=m*g;
          GOTOXY(51,9);
          WRITE(+n:6:2);
          o:=f+n;
          GOTOXY(51,11);
          WRITE(+o:6:2);
            IF o=0 THEN
                 BEGIN
                     WRITELN('');
                     WRITELN('');
                     WRITE('Zeros:'+intostr(g,2));
                     delay(1000);
      FOR z:=1 TO 10 DO
      WRITEXY('³',10,11+z);
      FOR z:=1 TO 78 DO
      WRITEXY('Ä',1+z,17);
      WRITEXY('Å',10,17);
      FOR g:=-1000 TO 1000 DO
        BEGIN
          GOTOXY(1,16);
          WRITE(+intostr(g,5));
          GOTOXY(11,18);
          WRITE(+b:6:2);
          p:=b*g;
          GOTOXY(21,16);
          WRITE(+p:6:2);
          q:=i+p;
          GOTOXY(21,18);
          WRITE(+q:6:2);
          r:=q*g;
          GOTOXY(31,16);
          WRITE(+r:6:2);
          s:=k+r;
          GOTOXY(31,18);
          WRITE(+s:6:2);
          t:=s*g;
          GOTOXY(41,16);
          WRITE(+t:6:2);
          u:=m+t;
          GOTOXY(41,18);
          WRITE(+u:6:2);
            IF u=0 THEN
                 BEGIN
                     WRITELN('');
                     WRITELN('');
                     WRITE('Zeros:'+intostr(g,2));
                     delay(2000);
                     CLRSCR;
                     GOTOXY(10,20);
                     FOR z:=1 TO 20 DO
                     WRITEXY('Ä',10+z,20);
                     o:=-q;
                     p:=(SQR(o))-(4*b*s);
                     IF p<0 THEN
                       BEGIN
                         WRITEXY('N„o tem zeros na f¢rmula resolvente',1,23);
                         GOTO 1;
                       END;
                     q:=SQRT(p);
                     r:=o+q;
                     GOTOXY(10,19);
                     WRITE(+o:6:2,'+',+q:6:2);
                     s:=2*b;
                     GOTOXY(10,21);
                     WRITE(+s:6:2);
                     t:=r/s;
                     GOTOXY(40,20);
                     WRITE('Zeros : ',+t:6:2);
                     DELAY(2000);

                     GOTOXY(10,20);
                     FOR z:=1 TO 20 DO
                     WRITEXY('Ä',10+z,20);
                     o:=-q;
                     p:=(SQR(o))-(4*b*s);
                     IF p<0 THEN
                       BEGIN
                         WRITEXY('N„o tem zeros na f¢rmula resolvente',1,23);
                         GOTO 1;
                       END;
                     q:=SQRT(p);
                     r:=o-q;
                     GOTOXY(10,19);
                     WRITE(+o:6:2,'-',+q:6:2);
                     s:=2*b;
                     GOTOXY(10,21);
                     WRITE(+s:6:2);
                     t:=r/s;
                     GOTOXY(40,20);
                     WRITE('Zeros : ',+t:6:2);
                     DELAY(1000);
                     GOTO 1;

                 END;
        END;
                 END;
        END;
  END;

  IF (a=0) AND (b=0) AND (c<>0) THEN BEGIN
      CLRSCR;
      GOTOXY(11,5);
      WRITE(+c:6:2);
      GOTOXY(21,5);
      WRITE(+d:6:2);
      GOTOXY(31,5);
      WRITE(+e:6:2);
      GOTOXY(41,5);
      WRITE(+f:6:2);
      FOR z:=1 TO 10 DO
      WRITEXY('³',10,3+z);
      FOR z:=1 TO 78 DO
      WRITEXY('Ä',1+z,10);
      WRITEXY('Å',10,10);
      FOR g:=-1000 TO 1000 DO
        BEGIN
          GOTOXY(1,9);
          WRITE(+intostr(g,5));
          GOTOXY(11,11);
          WRITE(+c:6:2);
          h:=c*g;
          GOTOXY(21,9);
          WRITE(+h:6:2);
          i:=d+h;
          GOTOXY(21,11);
          WRITE(+i:6:2);
          j:=i*g;
          GOTOXY(31,9);
          WRITE(+j:6:2);
          k:=e+j;
          GOTOXY(31,11);
          WRITE(+k:6:2);
          l:=k*g;
          GOTOXY(41,9);
          WRITE(+l:6:2);
          m:=f+l;
          GOTOXY(41,11);
          WRITE(+m:6:2);
            IF m=0 THEN
                 BEGIN
                     WRITELN('');
                     WRITELN('');
                     WRITELN('');
                     WRITE('Zeros :  '+intostr(g,2));
                     delay(1000);
                     GOTOXY(10,20);
                     FOR z:=1 TO 20 DO
                     WRITEXY('Ä',10+z,20);
                     o:=-i;
                     p:=(SQR(o))-(4*c*k);
                     IF p<0 THEN
                       BEGIN
                         WRITEXY('N„o tem zeros na f¢rmula resolvente',1,23);
                         GOTO 1;
                       END;
                     q:=SQRT(p);
                     r:=o+q;
                     GOTOXY(10,19);
                     WRITE(+o:6:2,'+',+q:6:2);
                     s:=2*c;
                     GOTOXY(10,21);
                     WRITE(+s:6:2);
                     t:=r/s;
                     GOTOXY(40,20);
                     WRITE('Zeros : ',+t:6:2);
                     DELAY(2000);

                     GOTOXY(10,20);
                     FOR z:=1 TO 20 DO
                     WRITEXY('Ä',10+z,20);
                     o:=-i;
                     p:=(SQR(o))-(4*c*k);
                     IF p<0 THEN
                       BEGIN
                         WRITEXY('N„o tem zeros na f¢rmula resolvente',1,23);
                         GOTO 1;
                       END;
                     q:=SQRT(p);
                     r:=o-q;
                     GOTOXY(10,19);
                     WRITE(+o:6:2,'-',+q:6:2);
                     s:=2*c;
                     GOTOXY(10,21);
                     WRITE(+s:6:2);
                     t:=r/s;
                     GOTOXY(40,20);
                     WRITE('Zeros : ',+t:6:2);
                     DELAY(1000);
                 END;
        END;
  END;
 1:
  TEXTCOLOR(12+128);
  WRITEXY('Pressione ENTER',15,25);
  DELAY(1000);
  READLN;
 UNTIL ch = #27;
END.
