PROGRAM biblioteca_de_disquetes;

USES
    CRT,DOS,TP;

                  (* Constantes do programa *)

    CONST
        nomearq = 'bibdisk.dat';

                   (*  Tipos do programa  *)

    TYPE
        registro         = RECORD
        nome             : STRING[11];
        numero_de_serie  : STRING[9];
        conteudo1        : STRING[30];
        conteudo2        : STRING[30];
        conteudo3        : STRING[30];
        conteudo4        : STRING[30];
        conteudo5        : STRING[30];
        conteudo6        : STRING[30];
        conteudo7        : STRING[30];
        conteudo8        : STRING[30];
        conteudo9        : STRING[30];
        conteudo10       : STRING[30];
        conteudo11       : STRING[30];
        conteudo12       : STRING[30];
        conteudo13       : STRING[30];
        conteudo14       : STRING[30];
        conteudo15       : STRING[30];
        diferentes       : INTEGER;
        livres           : REAL;
    END;

                  (* Vari veis do programa *)

    VAR
        arq : FILE OF registro;
        reg       : registro;
        fim       : BOOLEAN;
        a         : INTEGER;

               (*  Procedures declaradas mais … frente  *)

PROCEDURE Inicializa_2_2;FORWARD;
PROCEDURE menu_procurar;FORWARD;

                (* Procedure que coloca o cursor normal *)

PROCEDURE norm;

BEGIN
     REGS.AH:=$01;
     REGS.CH:=$06;
     REGS.CL:=$07;
     INTR($10,REGS);
END;

                  (* Procedure que apaga o cursor *)

PROCEDURE off;

BEGIN
     REGS.AH:=$01;
     REGS.CH:=$70;
     REGS.CL:=$00;
     INTR($10,REGS);
END;

  (* Rotina de abertura de arquivos, se arquivo n„o existe, cria um novo *)
                         (* deixando-o aberto *)

PROCEDURE abre_arq(n_arq:STRING);

    BEGIN
      assign(arq,n_arq);
      {$I-}
      reset(arq);
      {$I+}
      if ioresult <> 0
        then
          rewrite(arq);
    END;

          (* Rotina de exibi‡„o das informa‡”es sobre as disk *)

PROCEDURE mascara;

    BEGIN
      textcolor(14);
      gotoxy(5,5);
      write('Disk nr§ ',FILEPOS(arq)+1);
      gotoxy(5,6);
      write('Nome da disk ..................: ');
      gotoxy(5,7);
      write('N£mero de s‚rie ...............: ');
      gotoxy(5,8);
      write('Bytes livres ..................: ');
      gotoxy(5,9);
      write('N§ de conte£dos diferentes ....: ');
    END;

           (* Rotina para capturar o n£mero da disk *)

PROCEDURE pega_numero;

    VAR
      nu   : LONGINT;
      aux  : STRING[6];
      erro : INTEGER;

    BEGIN
      norm;
      repeat
          writexy('Digite o n£mero da disk .: ',5,5);
          readln(aux);
          val(aux,nu,erro);
      until (erro=0) and (nu > 0) and (nu - 1 < FILESIZE(arq));
      seek(arq,nu-1);
      read(arq,reg);
      seek(arq,filepos(arq)-1);
      off;
    END;

             (* Rotina de inclus„o de novas disk *)

PROCEDURE inserir;

  VAR
     a,e : INTEGER;
     diferentes  : STRING[6];
     erro : INTEGER;


  LABEL
       1;

    BEGIN
       Inicializa_2('Bibliodisk  V1.0','1995');
       norm;
       seek(arq,filesize(arq));
       mascara;
       gotoxy(38,6);
       readln(reg.nome);
       gotoxy(38,7);
       readln(reg.numero_de_serie);
       gotoxy(38,8);
       readln(reg.livres);
       repeat
          gotoxy(38,9);
          write('     ');
          readln(diferentes);
          val(diferentes,reg.diferentes,erro);
       until (erro=0) and (reg.diferentes > 0) and (reg.diferentes <= 15);
       e := 0;
       textcolor(14);
       gotoxy(5,11);
       write('Conte£do ',1,' ...................: ');
       textcolor(15);
       gotoxy(38,11);
       readln(reg.conteudo1);
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,12);
       write('Conte£do ',2,' ...................: ');
       textcolor(15);
       gotoxy(38,12);
       readln(reg.conteudo2);
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,13);
       write('Conte£do ',3,' ...................: ');
       textcolor(15);
       gotoxy(38,13);
       readln(reg.conteudo3);
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,14);
       write('Conte£do ',4,' ...................: ');
       textcolor(15);
       gotoxy(38,14);
       readln(reg.conteudo4);
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,15);
       write('Conte£do ',5,' ...................: ');
       textcolor(15);
       gotoxy(38,15);
       readln(reg.conteudo5);
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,16);
       write('Conte£do ',6,' ...................: ');
       textcolor(15);
       gotoxy(38,16);
       readln(reg.conteudo6);
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,17);
       write('Conte£do ',7,' ...................: ');
       textcolor(15);
       gotoxy(38,17);
       readln(reg.conteudo7);
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,18);
       write('Conte£do ',8,' ...................: ');
       textcolor(15);
       gotoxy(38,18);
       readln(reg.conteudo8);
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,19);
       write('Conte£do ',9,' ...................: ');
       textcolor(15);
       gotoxy(38,19);
       readln(reg.conteudo9);
       e := e + 1;
       if e = reg.diferentes then goto 1;
       Inicializa_2('Bibliodisk  V1.0','1995');
       textcolor(14);
       gotoxy(5,10);
       write('Conte£do ',10,' ...................: ');
       textcolor(15);
       gotoxy(38,10);
       readln(reg.conteudo10);
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,11);
       write('Conte£do ',11,' ...................: ');
       textcolor(15);
       gotoxy(38,11);
       readln(reg.conteudo11);
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,12);
       write('Conte£do ',12,' ...................: ');
       textcolor(15);
       gotoxy(38,12);
       readln(reg.conteudo12);
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,13);
       write('Conte£do ',13,' ...................: ');
       textcolor(15);
       gotoxy(38,13);
       readln(reg.conteudo13);
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,14);
       write('Conte£do ',14,' ...................: ');
       textcolor(15);
       gotoxy(38,14);
       readln(reg.conteudo14);
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,15);
       write('Conte£do ',15,' ...................: ');
       textcolor(15);
       gotoxy(38,15);
       readln(reg.conteudo15);
       e := e + 1;
       if e = reg.diferentes then goto 1;

      1:
       begin
          write(arq,reg);
          off;
          Inicializa_2_2;
       end;
    END;

                       (* Rotina de altera‡„o *)

PROCEDURE modificar;

    VAR
      reg_aux  : registro;
      ch       : CHAR;
      a,e      : INTEGER;

    LABEL
       1;

 BEGIN
      Inicializa_2('Bibliodisk  V1.0','1995');
      pega_numero;
      norm;
      Inicializa_2('Bibliodisk  V1.0','1995');
      reg_aux := reg;
      mascara;
      gotoxy(38,6);
      write(reg.nome);
      gotoxy(38,7);
      write(reg.numero_de_serie);
      gotoxy(38,8);
      write(reg.livres:9:0);
      gotoxy(38,9);
      write(reg.diferentes);
      gotoxy(38,6);
      readln(reg.nome);
      if reg.nome = ''
          then
             reg.nome:=reg_aux.nome;
      gotoxy(38,7);
      readln(reg.numero_de_serie);
      if reg.numero_de_serie=''
          then
             reg.numero_de_serie :=reg_aux.numero_de_serie;
      gotoxy(38,8);
      ch := upcase(readkey);
      if ch = #13
       then
         begin
           gotoxy(38,9);
           ch := upcase(readkey);
           if ch = #13
            then
              begin
                 goto 1;
              end
            else
              gotoxy(38,9);
              readln(reg.diferentes);
       e := 0;
       textcolor(14);
       gotoxy(5,11);
       write('Conte£do ',1,' ...................: ',+reg.conteudo1);
       textcolor(15);
       gotoxy(37,11);
       readln(reg.conteudo1);
                  if reg.conteudo1=''
                     then
                       reg.conteudo1 := reg_aux.conteudo1;
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,12);
       write('Conte£do ',2,' ...................: ',+reg.conteudo2);
       textcolor(15);
       gotoxy(37,12);
       readln(reg.conteudo2);
                  if reg.conteudo2=''
                     then
                       reg.conteudo2 := reg_aux.conteudo2;
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,13);
       write('Conte£do ',3,' ...................: ',+reg.conteudo3);
       textcolor(15);
       gotoxy(37,13);
       readln(reg.conteudo3);
                  if reg.conteudo3=''
                     then
                       reg.conteudo3 := reg_aux.conteudo3;
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,14);
       write('Conte£do ',4,' ...................: ',+reg.conteudo4);
       textcolor(15);
       gotoxy(37,14);
       readln(reg.conteudo4);
                  if reg.conteudo4=''
                     then
                       reg.conteudo4 := reg_aux.conteudo4;
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,15);
       write('Conte£do ',5,' ...................: ',+reg.conteudo5);
       textcolor(15);
       gotoxy(37,15);
       readln(reg.conteudo5);
                  if reg.conteudo5=''
                     then
                       reg.conteudo5 := reg_aux.conteudo5;
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,16);
       write('Conte£do ',6,' ...................: ',+reg.conteudo6);
       textcolor(15);
       gotoxy(37,16);
       readln(reg.conteudo6);
                  if reg.conteudo6=''
                     then
                       reg.conteudo6 := reg_aux.conteudo6;
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,17);
       write('Conte£do ',7,' ...................: ',+reg.conteudo7);
       textcolor(15);
       gotoxy(37,17);
       readln(reg.conteudo7);
                  if reg.conteudo7=''
                     then
                       reg.conteudo7 := reg_aux.conteudo7;
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,18);
       write('Conte£do ',8,' ...................: ',+reg.conteudo8);
       textcolor(15);
       gotoxy(37,18);
       readln(reg.conteudo8);
                  if reg.conteudo8=''
                     then
                       reg.conteudo8 := reg_aux.conteudo8;
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,19);
       write('Conte£do ',9,' ...................: ',+reg.conteudo9);
       textcolor(15);
       gotoxy(37,19);
       readln(reg.conteudo9);
                  if reg.conteudo9=''
                     then
                       reg.conteudo9 := reg_aux.conteudo9;
       e := e + 1;
       if e = reg.diferentes then goto 1;
       Inicializa_2('Bibliodisk  V1.0','1995');
       textcolor(14);
       gotoxy(5,10);
       write('Conte£do ',10,' ...................: ',+reg.conteudo10);
       textcolor(15);
       gotoxy(37,10);
       readln(reg.conteudo10);
                  if reg.conteudo10=''
                     then
                       reg.conteudo10 := reg_aux.conteudo10;
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,11);
       write('Conte£do ',11,' ...................: ',+reg.conteudo11);
       textcolor(15);
       gotoxy(37,11);
       readln(reg.conteudo11);
                  if reg.conteudo11=''
                     then
                       reg.conteudo11 := reg_aux.conteudo11;
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,12);
       write('Conte£do ',12,' ...................: ',+reg.conteudo12);
       textcolor(15);
       gotoxy(37,12);
       readln(reg.conteudo12);
                  if reg.conteudo12=''
                     then
                       reg.conteudo12 := reg_aux.conteudo12;
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,13);
       write('Conte£do ',13,' ...................: ',+reg.conteudo13);
       textcolor(15);
       gotoxy(37,13);
       readln(reg.conteudo13);
                  if reg.conteudo13=''
                     then
                       reg.conteudo13 := reg_aux.conteudo13;
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,14);
       write('Conte£do ',14,' ...................: ',+reg.conteudo14);
       textcolor(15);
       gotoxy(37,14);
       readln(reg.conteudo14);
                  if reg.conteudo14=''
                     then
                       reg.conteudo14 := reg_aux.conteudo14;
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,15);
       write('Conte£do ',15,' ...................: ',+reg.conteudo15);
       textcolor(15);
       gotoxy(37,15);
       readln(reg.conteudo15);
                  if reg.conteudo15=''
                     then
                       reg.conteudo15 := reg_aux.conteudo15;
       e := e + 1;
       if e = reg.diferentes then goto 1
      else
      gotoxy(38,8);
      readln(reg.livres);
      gotoxy(38,9);
      ch := upcase(readkey);
      if ch = #13
       then
         begin
            goto 1;
         end
       else
         gotoxy(38,9);
         readln(reg.diferentes);
       e := 0;
       textcolor(14);
       gotoxy(5,10);
       write('Conte£do ',1,' ...................: ',+reg.conteudo1);
       textcolor(15);
       gotoxy(37,10);
       readln(reg.conteudo1);
                  if reg.conteudo1=''
                     then
                       reg.conteudo1 := reg_aux.conteudo1;
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,11);
       write('Conte£do ',2,' ...................: ',+reg.conteudo2);
       textcolor(15);
       gotoxy(37,11);
       readln(reg.conteudo2);
                  if reg.conteudo2=''
                     then
                       reg.conteudo2 := reg_aux.conteudo2;
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,13);
       write('Conte£do ',3,' ...................: ',+reg.conteudo3);
       textcolor(15);
       gotoxy(37,13);
       readln(reg.conteudo3);
                  if reg.conteudo3=''
                     then
                       reg.conteudo3 := reg_aux.conteudo3;
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,14);
       write('Conte£do ',4,' ...................: ',+reg.conteudo4);
       textcolor(15);
       gotoxy(37,14);
       readln(reg.conteudo4);
                  if reg.conteudo4=''
                     then
                       reg.conteudo4 := reg_aux.conteudo4;
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,15);
       write('Conte£do ',5,' ...................: ',+reg.conteudo5);
       textcolor(15);
       gotoxy(37,15);
       readln(reg.conteudo5);
                  if reg.conteudo5=''
                     then
                       reg.conteudo5 := reg_aux.conteudo5;
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,16);
       write('Conte£do ',6,' ...................: ',+reg.conteudo6);
       textcolor(15);
       gotoxy(37,16);
       readln(reg.conteudo6);
                  if reg.conteudo6=''
                     then
                       reg.conteudo6 := reg_aux.conteudo6;
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,17);
       write('Conte£do ',7,' ...................: ',+reg.conteudo7);
       textcolor(15);
       gotoxy(37,17);
       readln(reg.conteudo7);
                  if reg.conteudo7=''
                     then
                       reg.conteudo7 := reg_aux.conteudo7;
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,18);
       write('Conte£do ',8,' ...................: ',+reg.conteudo8);
       textcolor(15);
       gotoxy(37,18);
       readln(reg.conteudo8);
                  if reg.conteudo8=''
                     then
                       reg.conteudo8 := reg_aux.conteudo8;
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,19);
       write('Conte£do ',9,' ...................: ',+reg.conteudo9);
       textcolor(15);
       gotoxy(37,19);
       readln(reg.conteudo9);
                  if reg.conteudo9=''
                     then
                       reg.conteudo9 := reg_aux.conteudo9;
       e := e + 1;
       if e = reg.diferentes then goto 1;
       Inicializa_2('Bibliodisk  V1.0','1995');
       textcolor(14);
       gotoxy(5,10);
       write('Conte£do ',10,' ...................: ',+reg.conteudo10);
       textcolor(15);
       gotoxy(37,10);
       readln(reg.conteudo10);
                  if reg.conteudo10=''
                     then
                       reg.conteudo10 := reg_aux.conteudo10;
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,11);
       write('Conte£do ',11,' ...................: ',+reg.conteudo11);
       textcolor(15);
       gotoxy(37,11);
       readln(reg.conteudo11);
                  if reg.conteudo11=''
                     then
                       reg.conteudo11 := reg_aux.conteudo11;
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,12);
       write('Conte£do ',12,' ...................: ',+reg.conteudo12);
       textcolor(15);
       gotoxy(37,12);
       readln(reg.conteudo12);
                  if reg.conteudo12=''
                     then
                       reg.conteudo12 := reg_aux.conteudo12;
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,13);
       write('Conte£do ',13,' ...................: ',+reg.conteudo13);
       textcolor(15);
       gotoxy(37,13);
       readln(reg.conteudo13);
                  if reg.conteudo13=''
                     then
                       reg.conteudo13 := reg_aux.conteudo13;
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,14);
       write('Conte£do ',14,' ...................: ',+reg.conteudo14);
       textcolor(15);
       gotoxy(37,14);
       readln(reg.conteudo14);
                  if reg.conteudo14=''
                     then
                       reg.conteudo14 := reg_aux.conteudo14;
       e := e + 1;
       if e = reg.diferentes then goto 1;
       textcolor(14);
       gotoxy(5,15);
       write('Conte£do ',15,' ...................: ',+reg.conteudo15);
       textcolor(15);
       gotoxy(37,15);
       readln(reg.conteudo15);
                  if reg.conteudo15=''
                     then
                       reg.conteudo15 := reg_aux.conteudo15;
       e := e + 1;
       if e = reg.diferentes then goto 1;
      end;

    1:
      begin
         write(arq,reg);
         off;
         Inicializa_2_2;
      end;
 END;

                  (* Rotina de listagem das disk *)

PROCEDURE listar;

    VAR
       painel : BYTE;
       e      : INTEGER;

    LABEL
        1;

    BEGIN
       Inicializa_2('Bibliodisk  V1.0','1995');
       seek(arq,0);
       while not eof(arq) do
           begin
             Inicializa_2('Bibliodisk  V1.0','1995');
             horizontal(3,8,75,'Í');
             horizontal(3,19,75,'Í');
             writexy('Ì',3,8);
             for a:= 1 to 5 do
                begin
                   writexy('º',15,3+a);
                end;
             for a:= 1 to 5 do
                begin
                   writexy('º',45,3+a);
                end;
             writexy('Ì',3,19);
             writexy('¹',78,8);
             writexy('¹',78,19);
             writexy('Ë',15,4);
             writexy('Ë',45,4);
             writexy('Ê',45,8);
             writexy('Ê',15,8);
             textcolor(14);
             writexy('N§',6,6);
             writexy('Nome : ',17,6);
             writexy('N§ de s‚rie : ',47,6);
             writexy('Conte£do : ',6,9);
             writexy('Bytes livres : ',6,20);
             painel := 0;
             while not eof(arq) and (painel < 1) do
                 begin
                    read(arq,reg);
                    textcolor(15);
                    gotoxy(9,6);
                    write(filepos(arq):3);
                    gotoxy(17,7);
                    write(reg.nome);
                    gotoxy(61,6);
                    write(reg.numero_de_serie);
                    e := 0;
                    writexy(+reg.conteudo1,17,9);
                    e := e + 1;
                    if e = reg.diferentes then goto 1;
                    writexy(+reg.conteudo2,17,10);
                    e := e + 1;
                    if e = reg.diferentes then goto 1;
                    writexy(+reg.conteudo3,17,11);
                    e := e + 1;
                    if e = reg.diferentes then goto 1;
                    writexy(+reg.conteudo4,17,12);
                    e := e + 1;
                    if e = reg.diferentes then goto 1;
                    writexy(+reg.conteudo5,17,13);
                    e := e + 1;
                    if e = reg.diferentes then goto 1;
                    writexy(+reg.conteudo6,17,14);
                    e := e + 1;
                    if e = reg.diferentes then goto 1;
                    writexy(+reg.conteudo7,17,15);
                    e := e + 1;
                    if e = reg.diferentes then goto 1;
                    writexy(+reg.conteudo8,17,16);
                    e := e + 1;
                    if e = reg.diferentes then goto 1;
                    writexy(+reg.conteudo9,17,17);
                    e := e + 1;
                    if e = reg.diferentes then goto 1;
                    writexy(+reg.conteudo10,17,18);
                    e := e + 1;
                    if e = reg.diferentes then goto 1;
                    writexy(+reg.conteudo11,48,9);
                    e := e + 1;
                    if e = reg.diferentes then goto 1;
                    writexy(+reg.conteudo12,48,10);
                    e := e + 1;
                    if e = reg.diferentes then goto 1;
                    writexy(+reg.conteudo13,48,11);
                    e := e + 1;
                    if e = reg.diferentes then goto 1;
                    writexy(+reg.conteudo14,48,12);
                    e := e + 1;
                    if e = reg.diferentes then goto 1;
                    writexy(+reg.conteudo15,48,13);
                    e := e + 1;
                    if e = reg.diferentes then goto 1;
                 1:
                   begin
                    gotoxy(21,20);
                    write(reg.livres:9:0);
                    painel := painel + 1;
                   end;
                 end;
             gotoxy(50,2);
             write('Tecle algo para continuar');
             repeat until readkey <> #0;
          end;
        Inicializa_2_2;
   END;

                 (* Rotina de procura de conte£do *)

PROCEDURE procura_conteudo;

    VAR
       a,b,i,e,f        : INTEGER;
       quero_conteudo   : STRING[30];

    LABEL
        1,2;

    BEGIN
       Inicializa_2('Bibliodisk  V1.0','1995');
       writexy('Qual o conte£do que procuras',25,6);
       norm;
       gotoxy(20,7);
       readln(quero_conteudo);
       for a := 1 to Length(quero_conteudo) do
       quero_conteudo[a] := UpCase(quero_conteudo[a]);
       off;
       seek(arq,0);
       while not eof(arq) do
           begin
             Inicializa_2('Bibliodisk  V1.0','1995');
             textcolor(14);
             i := 0;
             while not eof(arq) and ( i < 14) do
                 begin
                    read(arq,reg);
                    e := 0;
                    for a := 1 to Length(reg.conteudo1) do
                    reg.conteudo1[a] := UpCase(reg.conteudo1[a]);
                    e := e + 1;
                    if e = reg.diferentes then goto 1;
                    for a := 1 to Length(reg.conteudo2) do
                    reg.conteudo2[a] := UpCase(reg.conteudo2[a]);
                    e := e + 1;
                    if e = reg.diferentes then goto 1;
                    for a := 1 to Length(reg.conteudo3) do
                    reg.conteudo3[a] := UpCase(reg.conteudo3[a]);
                    e := e + 1;
                    if e = reg.diferentes then goto 1;
                    for a := 1 to Length(reg.conteudo4) do
                    reg.conteudo4[a] := UpCase(reg.conteudo4[a]);
                    e := e + 1;
                    if e = reg.diferentes then goto 1;
                    for a := 1 to Length(reg.conteudo5) do
                    reg.conteudo5[a] := UpCase(reg.conteudo5[a]);
                    e := e + 1;
                    if e = reg.diferentes then goto 1;
                    for a := 1 to Length(reg.conteudo6) do
                    reg.conteudo6[a] := UpCase(reg.conteudo6[a]);
                    e := e + 1;
                    if e = reg.diferentes then goto 1;
                    for a := 1 to Length(reg.conteudo7) do
                    reg.conteudo7[a] := UpCase(reg.conteudo7[a]);
                    e := e + 1;
                    if e = reg.diferentes then goto 1;
                    for a := 1 to Length(reg.conteudo8) do
                    reg.conteudo8[a] := UpCase(reg.conteudo8[a]);
                    e := e + 1;
                    if e = reg.diferentes then goto 1;
                    for a := 1 to Length(reg.conteudo9) do
                    reg.conteudo9[a] := UpCase(reg.conteudo9[a]);
                    e := e + 1;
                    if e = reg.diferentes then goto 1;
                    for a := 1 to Length(reg.conteudo10) do
                    reg.conteudo10[a] := UpCase(reg.conteudo10[a]);
                    e := e + 1;
                    if e = reg.diferentes then goto 1;
                    for a := 1 to Length(reg.conteudo11) do
                    reg.conteudo11[a] := UpCase(reg.conteudo11[a]);
                    e := e + 1;
                    if e = reg.diferentes then goto 1;
                    for a := 1 to Length(reg.conteudo12) do
                    reg.conteudo12[a] := UpCase(reg.conteudo12[a]);
                    e := e + 1;
                    if e = reg.diferentes then goto 1;
                    for a := 1 to Length(reg.conteudo13) do
                    reg.conteudo13[a] := UpCase(reg.conteudo13[a]);
                    e := e + 1;
                    if e = reg.diferentes then goto 1;
                    for a := 1 to Length(reg.conteudo14) do
                    reg.conteudo14[a] := UpCase(reg.conteudo14[a]);
                    e := e + 1;
                    if e = reg.diferentes then goto 1;
                    for a := 1 to Length(reg.conteudo15) do
                    reg.conteudo15[a] := UpCase(reg.conteudo15[a]);
                    e := e + 1;
                    if e = reg.diferentes then goto 1;

                  1:
                    f := 0;
                    if POS(quero_conteudo,reg.conteudo1) > 0
                       then
                          begin
                            gotoxy(6,6+i);
                            write('Conte£do encontrado na disk',filepos(arq):3);
                            i := i + 1;
                          end;
                    f := f + 1;
                    if f = reg.diferentes then goto 2;
                    if POS(quero_conteudo,reg.conteudo2) > 0
                       then
                          begin
                            gotoxy(6,6+i);
                            write('Conte£do encontrado na disk',filepos(arq):3);
                            i := i + 1;
                          end;
                     f := f + 1;
                     if f = reg.diferentes then goto 2;
                    if POS(quero_conteudo,reg.conteudo3) > 0
                       then
                          begin
                            gotoxy(6,6+i);
                            write('Conte£do encontrado na disk',filepos(arq):3);
                            i := i + 1;
                          end;
                     f := f + 1;
                     if f = reg.diferentes then goto 2;
                    if POS(quero_conteudo,reg.conteudo4) > 0
                       then
                          begin
                            gotoxy(6,6+i);
                            write('Conte£do encontrado na disk',filepos(arq):3);
                            i := i + 1;
                          end;
                     f := f + 1;
                     if f = reg.diferentes then goto 2;
                    if POS(quero_conteudo,reg.conteudo5) > 0
                       then
                          begin
                            gotoxy(6,6+i);
                            write('Conte£do encontrado na disk',filepos(arq):3);
                            i := i + 1;
                          end;
                     f := f + 1;
                     if f = reg.diferentes then goto 2;
                    if POS(quero_conteudo,reg.conteudo6) > 0
                       then
                          begin
                            gotoxy(6,6+i);
                            write('Conte£do encontrado na disk',filepos(arq):3);
                            i := i + 1;
                          end;
                     f := f + 1;
                     if f = reg.diferentes then goto 2;
                    if POS(quero_conteudo,reg.conteudo7) > 0
                       then
                          begin
                            gotoxy(6,6+i);
                            write('Conte£do encontrado na disk',filepos(arq):3);
                            i := i + 1;
                          end;
                     f := f + 1;
                     if f = reg.diferentes then goto 2;
                    if POS(quero_conteudo,reg.conteudo8) > 0
                       then
                          begin
                            gotoxy(6,6+i);
                            write('Conte£do encontrado na disk',filepos(arq):3);
                            i := i + 1;
                          end;
                     f := f + 1;
                     if f = reg.diferentes then goto 2;
                    if POS(quero_conteudo,reg.conteudo9) > 0
                       then
                          begin
                            gotoxy(6,6+i);
                            write('Conte£do encontrado na disk',filepos(arq):3);
                            i := i + 1;
                          end;
                     f := f + 1;
                     if f = reg.diferentes then goto 2;
                    if POS(quero_conteudo,reg.conteudo10) > 0
                       then
                          begin
                            gotoxy(6,6+i);
                            write('Conte£do encontrado na disk',filepos(arq):3);
                            i := i + 1;
                          end;
                     f := f + 1;
                     if f = reg.diferentes then goto 2;
                    if POS(quero_conteudo,reg.conteudo11) > 0
                       then
                          begin
                            gotoxy(6,6+i);
                            write('Conte£do encontrado na disk',filepos(arq):3);
                            i := i + 1;
                          end;
                     f := f + 1;
                     if f = reg.diferentes then goto 2;
                    if POS(quero_conteudo,reg.conteudo12) > 0
                       then
                          begin
                            gotoxy(6,6+i);
                            write('Conte£do encontrado na disk',filepos(arq):3);
                            i := i + 1;
                          end;
                     f := f + 1;
                     if f = reg.diferentes then goto 2;
                    if POS(quero_conteudo,reg.conteudo13) > 0
                       then
                          begin
                            gotoxy(6,6+i);
                            write('Conte£do encontrado na disk',filepos(arq):3);
                            i := i + 1;
                          end;
                     f := f + 1;
                     if f = reg.diferentes then goto 2;
                    if POS(quero_conteudo,reg.conteudo14) > 0
                       then
                          begin
                            gotoxy(6,6+i);
                            write('Conte£do encontrado na disk',filepos(arq):3);
                            i := i + 1;
                          end;
                     f := f + 1;
                     if f = reg.diferentes then goto 2;
                    if POS(quero_conteudo,reg.conteudo15) > 0
                       then
                          begin
                            gotoxy(6,6+i);
                            write('Conte£do encontrado na disk',filepos(arq):3);
                            i := i + 1;
                          end;
                     f := f + 1;
                     if f = reg.diferentes then goto 2;
           2:
             end;
             gotoxy(50,2);
             write('Tecle algo para continuar');
             repeat until readkey <> #0;
          end;
             menu_procurar;
   END;


                 (* Rotina de procura de bytes livres *)

PROCEDURE procura_bytes_livres;

    VAR
       a           : INTEGER;
       quero_valor : REAL;

    BEGIN
       Inicializa_2('Bibliodisk  V1.0','1995');
       writexy('Qual o valor de bytes livres que necessitas',17,6);
       norm;
       gotoxy(32,7);
       readln(quero_valor);
       off;
       seek(arq,0);
       while not eof(arq) do
           begin
             Inicializa_2('Bibliodisk  V1.0','1995');
             textcolor(14);
             a := 0;
             while not eof(arq)  do
                 begin
                    read(arq,reg);
                    if reg.livres >= quero_valor
                       then
                          begin
                            gotoxy(6,6+a);
                            write('Valor superior encontrado na disk',filepos(arq):3);
                            a := a + 1;
                          end;
                 end;
             gotoxy(50,2);
             write('Tecle algo para continuar');
             repeat until readkey <> #0;
          end;
        menu_procurar;
   END;

                  (* Rotina de procura por n£mero *)

PROCEDURE procura_numero;

    VAR
      e : INTEGER;

    LABEL
        1;

    BEGIN
       Inicializa_2('Bibliodisk  V1.0','1995');
       pega_numero;
       Inicializa_2('Bibliodisk  V1.0','1995');
       horizontal(3,8,75,'Í');
       horizontal(3,19,75,'Í');
       writexy('Ì',3,8);
       for a:= 1 to 5 do
          begin
             writexy('º',15,3+a);
          end;
       for a:= 1 to 5 do
         begin
            writexy('º',45,3+a);
        end;
       writexy('Ì',3,19);
       writexy('¹',78,8);
       writexy('¹',78,19);
       writexy('Ë',15,4);
       writexy('Ë',45,4);
       writexy('Ê',45,8);
       writexy('Ê',15,8);
       textcolor(14);
       writexy('N§',6,6);
       writexy('Nome : ',17,6);
       writexy('N§ de s‚rie : ',47,6);
       writexy('Conte£do : ',6,9);
       writexy('Bytes livres : ',6,20);
       read(arq,reg);
       textcolor(15);
       gotoxy(9,6);
       write(filepos(arq):3);
       gotoxy(17,7);
       write(reg.nome);
       gotoxy(61,6);
       write(reg.numero_de_serie);
       e := 0;
       writexy(+reg.conteudo1,17,9);
       e := e + 1;
       if e = reg.diferentes then goto 1;
       writexy(+reg.conteudo2,17,10);
       e := e + 1;
       if e = reg.diferentes then goto 1;
       writexy(+reg.conteudo3,17,11);
       e := e + 1;
       if e = reg.diferentes then goto 1;
       writexy(+reg.conteudo4,17,12);
       e := e + 1;
       if e = reg.diferentes then goto 1;
       writexy(+reg.conteudo5,17,13);
       e := e + 1;
       if e = reg.diferentes then goto 1;
       writexy(+reg.conteudo6,17,14);
       e := e + 1;
       if e = reg.diferentes then goto 1;
       writexy(+reg.conteudo7,17,15);
       e := e + 1;
       if e = reg.diferentes then goto 1;
       writexy(+reg.conteudo8,17,16);
       e := e + 1;
       if e = reg.diferentes then goto 1;
       writexy(+reg.conteudo9,17,17);
       e := e + 1;
       if e = reg.diferentes then goto 1;
       writexy(+reg.conteudo10,17,18);
       e := e + 1;
       if e = reg.diferentes then goto 1;
       writexy(+reg.conteudo11,48,9);
       e := e + 1;
       if e = reg.diferentes then goto 1;
       writexy(+reg.conteudo12,48,10);
       e := e + 1;
       if e = reg.diferentes then goto 1;
       writexy(+reg.conteudo13,48,11);
       e := e + 1;
       if e = reg.diferentes then goto 1;
       writexy(+reg.conteudo14,48,12);
       e := e + 1;
       if e = reg.diferentes then goto 1;
       writexy(+reg.conteudo15,48,13);
       e := e + 1;
       if e = reg.diferentes then goto 1;

     1:
       begin
         gotoxy(21,20);
         write(reg.livres:9:0);
         gotoxy(50,2);
         write('Tecle algo para continuar');
         repeat until readkey <> #0;
         menu_procurar;
       end;
   END;

PROCEDURE finaliza;

BEGIN
   close(arq);
   clrscr;
   darker(1,1,80,25,7,0);
   norm;
   halt;
END;

PROCEDURE Inicializa_1_1;

   TYPE
       opc = SET OF CHAR;

   VAR
      a:INTEGER;
      op:opc;

BEGIN
   op := ['I','P','M','L','S'];
   off;
   Inicializa_1('Bibliodisk  V1.0','1995');
   textcolor(15);
   writexy('DISQUETES ==>',5,6);
   textcolor(8);
   writexy('Inserir',33,8);
   writexy('Procurar',33,10);
   writexy('Modificar',33,12);
   writexy('Listar',33,14);
   writexy('Sair',33,16);
   textcolor(12);
   writexy('I',33,8);
   writexy('P',33,10);
   writexy('M',33,12);
   writexy('L',33,14);
   writexy('S',33,16);
   repeat
       ch := upcase(readkey);
       if not (ch in op)
         then
            write(#7);
   until ch in op;
   case ch of
             'I' : inserir;
             'P' : menu_procurar;
             'M' : modificar;
             'L' : listar;
             'S' : finaliza;
   end;
END;

PROCEDURE Inicializa_2_2;

   TYPE
       opc = SET OF CHAR;

   VAR
      a:INTEGER;
      op:opc;

BEGIN
   op := ['I','P','M','L','S'];
   off;
   Inicializa_2('Bibliodisk  V1.0','1995');
   textcolor(15);
   writexy('DISQUETES ==>',5,6);
   textcolor(8);
   writexy('Inserir',33,8);
   writexy('Procurar',33,10);
   writexy('Modificar',33,12);
   writexy('Listar',33,14);
   writexy('Sair',33,16);
   textcolor(12);
   writexy('I',33,8);
   writexy('P',33,10);
   writexy('M',33,12);
   writexy('L',33,14);
   writexy('S',33,16);
   repeat
       ch := upcase(readkey);
       if not (ch in op)
         then
            write(#7);
   until ch in op;
   case ch of
             'I' : inserir;
             'P' : menu_procurar;
             'M' : modificar;
             'L' : listar;
             'S' : finaliza;
   end;
END;

PROCEDURE menu_procurar;

   TYPE
       opc = SET OF CHAR;

   VAR
      a:INTEGER;
      op:opc;

BEGIN
   op := ['C','B','N','S'];
   off;
   Inicializa_2('Bibliodisk  V1.0','1995');
   textcolor(15);
   writexy('DISQUETES ==>',5,6);
   textcolor(8);
   writexy('Conte£do',33,8);
   writexy('Bytes livres',33,10);
   writexy('N£mero',33,12);
   writexy('Sair',33,14);
   textcolor(12);
   writexy('C',33,8);
   writexy('B',33,10);
   writexy('N',33,12);
   writexy('S',33,14);
   repeat
       ch := upcase(readkey);
       if not (ch in op)
         then
            write(#7);
   until ch in op;
   case ch of
             'C' : procura_conteudo;
             'B' : procura_bytes_livres;
             'N' : procura_numero;
             'S' : Inicializa_2_2;
   end;
END;



BEGIN
  abre_arq(nomearq);
  Inicializa_1_1;


END.