PROGRAM as_notas_dos_alunos;

    USES
        TP,CRT,DOS;

    CONST
        nomearq = 'alunos.dat';

    TYPE
        registro = RECORD
        aluno    : STRING[50];
        materia  : ARRAY[1..3,1..10] OF BYTE;
        classe   : STRING[5];
    END;

    VAR
        arq : FILE OF registro;
        reg : registro;
        fim : BOOLEAN;

PROCEDURE NORM;
BEGIN
     REGS.AH:=$01;
     REGS.CH:=$06;
     REGS.CL:=$07;
     INTR($10,REGS);
END;

PROCEDURE OFF;
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

  (* Rotina de in¡cio do programa, nesta fazemos a inicializa‡„o das *)
                     (* var veis do programa *)

PROCEDURE inicio;

    BEGIN
      clrscr;
      fim:=false;
      abre_arq(nomearq);
    END;

               (* Fun‡„o que apenas retorna Sim ou N„o *)

FUNCTION s_n:CHAR;

    VAR
      ch:CHAR;

    BEGIN
      repeat
          ch:=upcase(readkey);
      until ch in ['S','N'];
      s_n:=ch;
    END;

                (* Rotina de exibi‡„o das mat‚rias *)

PROCEDURE materias(bimestre:BYTE);

    CONST
      m:ARRAY[1..10] of STRING[10]= ('Matem tica',
                                     'Portuguˆs',
                                     'F¡sica',
                                     'Qu¡mica',
                                     'Biologia',
                                     'Inglˆs',
                                     'Geografia',
                                     'Hist¢ria',
                                     'Ed.F¡sica',
                                     'SDG');

    VAR
      ind  : BYTE;
      aux  : STRING;
      erro : INTEGER;
      n    : BYTE;

    BEGIN
      for ind:=1 to 10 do
         begin
           gotoxy(5,11+ind);
           write(m[ind]);
         end;
      if reg.materia[bimestre,1] <= 20
         then
           for ind := 1 to 10 do
              begin
                gotoxy(18,11 + ind);
                write(reg.materia[bimestre,ind]);
              end;
      for ind:=1 to 10 do
         begin
           repeat
               gotoxy(18,11+ind);
               clreol;
               readln(aux);
               val(aux,reg.materia[bimestre,ind],erro );
           until (erro=0) and (reg.materia[bimestre,ind] <= 20);
         end;
      write(arq,reg);
    END;

    (* Rotina de exibi‡„o das informa‡”es b sicas sobre os alunos *)

PROCEDURE mascara(nt:BOOLEAN);

    VAR
      mes  : BYTE;
      erro : INTEGER;
      aux  : STRING[3];

    BEGIN
      clrscr;
      gotoxy(5,4);
      write('Aluno nr§ ',FILEPOS(arq)+1);
      gotoxy(5,6);
      write('Nome do aluno.:');
      gotoxy(5,8);
      write('Classe........:');
      if nt
           then
              begin
                gotoxy(22,6);
                write(reg.aluno);
                gotoxy(22,8);
                write(reg.classe);
                repeat
                   gotoxy(40,10);
                   write('Qual o per¡odo para lan‡amento.: ');
                   clreol;
                   readln(aux);
                   val(aux,mes,erro);
                until (erro=0) and (mes > 0) and (mes <= 3);
                materias(mes);
              end;
    END;

           (* Rotina para capturar o n£mero do aluno *)

PROCEDURE pega_numero;

    VAR
      nu   : LONGINT;
      aux  : STRING[6];
      erro : INTEGER;
      ch   : CHAR;

    BEGIN
      repeat
          clrscr;
          gotoxy(5,3);
          write('Digite o n£mero do aluno.:');
          clreol;
          readln(aux);
          val(aux,nu,erro);
      until (erro=0) and (nu > 0) and (nu - 1 < FILESIZE(arq));
      seek(arq,nu-1);
      read(arq,reg);
      seek(arq,filepos(arq)-1);
    END;

             (* Rotina de inclus„o de alunos novos *)

PROCEDURE inclusao;

    VAR
      ch      : CHAR;
      mat,bim : BYTE;

    BEGIN
      repeat
         seek(arq,filesize(arq));
         mascara(false);
         gotoxy(25,6);
         readln(reg.aluno);
         gotoxy(22,8);
         readln(reg.classe);
         for bim:=1 to 3 do
            for mat:=1 to 10 do
               reg.materia[bim,mat]:=255;
         write(arq,reg);
         gotoxy(10,25);
         write('Deseja nova inclus„o S/N');
         ch:=s_n;
      until ch='N';
    END;

               (* Rotina de inclus„o de notas bimestrais *)

PROCEDURE n_bim;

    VAR
      ch : CHAR;

    BEGIN
      repeat
         pega_numero;
         mascara(true);
         gotoxy(10,25);
         write('Deseja incluir novas notas S/N');
         ch:=s_n;
      until ch='N';
    END;

                       (* Rotina de altera‡„o *)

PROCEDURE altera;

    VAR
      ch      : CHAR;
      reg_aux : registro;

    BEGIN
      repeat
          pega_numero;
          reg_aux:=reg;
          mascara(false);
          gotoxy(22,6);
          write(reg.aluno);
          gotoxy(22,8);
          write(reg.classe);
          gotoxy(22,6);
          readln(reg.aluno);
          if reg.aluno = ''
              then
                 reg.aluno:=reg_aux.aluno;
          gotoxy(22,8);
          readln(reg.classe);
          if reg.classe=''
              then
                 reg.classe :=reg_aux.classe;
          gotoxy(10,25);
          write('Deseja alterar mais algum S/N');
          ch:=s_n;
      until ch='N';
      write(arq,reg);
    END;

                  (* Rotina de listagem dos alunos *)

PROCEDURE relacao;

    VAR
       linha : BYTE;

    BEGIN
       clrscr;
       seek(arq,0);
       while not eof(arq) do
           begin
              clrscr;
              linha:=4;
              gotoxy(16,1);
              write('  R E L A € Ž O   D O S   A L U N O S');
              writeln;
              writeln(' Nr§         N o m e                Classe');
              writeln;
              while not eof(arq) and (linha < 20) do
                  begin
                     read(arq,reg);
                     gotoxy(1,linha);
                     write(filepos(arq):3);
                     gotoxy(7,linha);
                     write(reg.aluno);
                     gotoxy(37,linha);
                     write(reg.classe);
                     linha:=linha+1;
                  end;
              gotoxy(15,25);
              write('Tecle algo para continuar');
              repeat until readkey <> #0;
           end;
    END;

            (* Rotina de exibi‡„o das notas por mat‚ria *)

PROCEDURE notas;

    CONST
      m:ARRAY[1..10] of STRING[10]= ('Matem tica',
                                     'Portuguˆs',
                                     'F¡sica',
                                     'Qu¡mica',
                                     'Biologia',
                                     'Inglˆs',
                                     'Geografia',
                                     'Hist¢ria',
                                     'Ed.F¡sica',
                                     'SDG');

    VAR
      ind,bimestre : BYTE;

    BEGIN
      for ind:=1 to 10 do
         begin
            gotoxy(5,11 + ind);
            write(m[ind]);
         end;
      for ind:=1 to 10 do
         for bimestre:=1 to 3 do
            begin
               gotoxy(16+bimestre*4,11+ind);
               if reg.materia[bimestre,ind] <= 20 then
               write(reg.materia[bimestre,ind]);
            end;
    END;

            (* Rotina de listagem das notas dos alunos *)

PROCEDURE lista;

    VAR
       linha : BYTE;
       ch    : CHAR;

    BEGIN
       repeat
           pega_numero;
           mascara(false);
           gotoxy(16,1);
           write('R E L A € Ž O   D A S   N O T A S');
           gotoxy(22,6);
           write(reg.aluno);
           gotoxy(22,8);
           write(reg.classe);
           gotoxy(22,6);
           notas;
           gotoxy(10,25);
           write('Deseja listar mais algum S/N');
           ch:=s_n;
       until ch='N';
    END;

            (* Rotina de op‡”es para escolha das tarefas *)

PROCEDURE menu;

    TYPE
       opc = SET OF CHAR;

    VAR
       ch : CHAR;
       op : opc;

    BEGIN
       op:=['I','N','A','R','L','F'];
       clrscr;
       fillscr(1,1,80,25,1);
       gotoxy(26,3);
       write('M E N U   D E   O P € ™ E S');
       gotoxy(26,6);
       write('( I ) - Inclus„o de Alunos');
       gotoxy(26,8);
       write('( N ) - Notas bimestrais');
       gotoxy(26,10);
       write('( A ) - Altera‡„o');
       gotoxy(26,12);
       write('( R ) - Rela‡„o dos alunos');
       gotoxy(26,14);
       write('( L ) - Listagem das notas');
       gotoxy(26,16);
       write('( F ) - Fim');
       textcolor(2);
       gotoxy(26,6);
       write('( I ) ');
       gotoxy(26,8);
       write('( N ) ');
       gotoxy(26,10);
       write('( A ) ');
       gotoxy(26,12);
       write('( R ) ');
       gotoxy(26,14);
       write('( L ) ');
       gotoxy(26,16);
       write('( F ) ');
       textcolor(7);
       gotoxy(38,25);
       write('Programado por : Fernando Silva --- @1995');
       repeat
          gotoxy(38,19);
          ch:=upcase(readkey);
          if not (ch in op)
             then
                write(#7);
       until ch in op;
       case ch of
                'I':inclusao;
                'N':n_bim;
                'A':altera;
                'L':lista;
                'R':relacao;
                'F':fim:=true;
       end;
    END;

    (* Rotina de finaliza‡„o do programa, fecha o arquivo e limpa a tela *)

PROCEDURE final;

    BEGIN
        clrscr;
        darker(1,1,80,25,7,0);
        close(arq);
    END;

                    (*Programa principal *)

         BEGIN

            off;
            inicio;
            repeat
                menu;
            until fim;
            final;
            norm;
         END.











