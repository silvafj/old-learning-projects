PROGRAM Codigo;

   USES
       crt;

   CONST
        escolhe_numero:ARRAY[0..9] of STRING[1] =('0',
                                                  '1',
                                                  '2',
                                                  '3',
                                                  '4',
                                                  '5',
                                                  '6',
                                                  '7',
                                                  '8',
                                                  '9');

   VAR
       sequencia:STRING;
       tentativa:INTEGER;
       palpite:STRING;
       f,n:INTEGER;
       ast:INTEGER;
       dollar:INTEGER;
       saida:STRING;

   BEGIN
     Clrscr;
     Randomize;
     tentativa:=0;
     sequencia:='';
     for f:=1 to 4 do
       BEGIN
         sequencia:=sequencia+escolhe_numero[Random(9)];
       END;
     repeat
       repeat
         gotoxy(1,1);
         write('Introduza o seu palpite         *   $');
         gotoxy(1,tentativa+2);
         readln(palpite);
         if length(palpite) <> 4 then
           begin
             gotoxy(1,tentativa+2);
             write('                                   ');
           end;
       until length(palpite) = 4;
       ast:=0;
       for f:=1 to 4 do
         begin
           if sequencia[f] = palpite[f] then ast:=ast+1;
         end;
       dollar:=0;
       for f:=1 to 4 do
         begin
           for n:=1 to 4 do
             begin
               if sequencia[f] = palpite[n] then dollar:=dollar+1;
             end;
         end;
       gotoxy(33,tentativa+2);
       write(ast);
       gotoxy(37,tentativa+2);
       write(dollar);
       tentativa:=tentativa+1;
     until (tentativa=15) or (sequencia=palpite);
     if sequencia=palpite then
       begin
         gotoxy(35,20);
         write('BINGO !!!! ');
         gotoxy(30,21);
         write('O c¢digo ‚ : '+sequencia);
         gotoxy(25,22);
         write('E descobriu … ',+tentativa,' tentativa.');
       end
     else
       begin
         gotoxy(40,16);
         write('N„o acertou no c¢digo que era :'+sequencia);
       end;
     readln;
   END.