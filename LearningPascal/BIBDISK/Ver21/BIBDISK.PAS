{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{|  PROGRAMA            => Bibdisk  V2.0                                   |}
{*  PROGRAMADO EM       => Turbo Pascal 7.0                                *}
{|  AUTOR               => Fernando Jorge de Almeida da Silva              |}
{*  ENDERE€O            => Juncal - Assequins 3750 †gueda                  *}
{|  TELEFONE            => (034) 602800                                    |}
{*  DATA DA PROGRAMA€ŽO => Janeiro/96                                     *}
{|  FUN€ŽO DO PROGRAMA  => Programa Principal                              |}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
PROGRAM bibdisk_v2_1;
{$M 8192,0,0}
{$S-}
USES
    CRT,DOS,TP_BIB;

{===========================> Constantes do programa <=======================}

CONST
     Datafile='BIBDISK.DAT';
     Tempfile='BIBDISK.TMP';

{===================================> Tipos <================================}

TYPE
    registro = RECORD
    total:STRING[10];
    usada:STRING[10];
    livre:STRING[10];
    nomevol:STRING[11];
    numserie:STRING[9];
    data:STRING[10];
    hora:STRING[5];
    conteudo1,conteudo2,conteudo3,conteudo4,conteudo5,conteudo6,
    conteudo7,conteudo8,conteudo9,conteudo10 : STRING[12]

  END;

{============================> Vari veis do programa <=======================}

VAR
   arq : FILE OF registro;
   reg : registro;
   h:TEXT;
   s,t:STRING;
   contador : integer;
   use : LONGINT;
   testa : STRING;

{=====================> Procedures declaradas mais … frente <================}

PROCEDURE Menu_Principal;FORWARD;
PROCEDURE Menu_procurar;FORWARD;

{=================> Abre o arquivo de dados e mantem-no aberto <=============}

PROCEDURE Abre_arq(n_arq:STRING);

    BEGIN
      assign(arq,n_arq);
      {$I-}
      reset(arq);
      {$I+}
      if ioresult <> 0
        then
          rewrite(arq);
    END;

{=========================> Escreve os itens pedidos <=======================}

PROCEDURE mascara;

    BEGIN
      textcolor(14);
      gotoxy(4,4);
      write('Disk nr§ ',FILEPOS(arq)+1);
      writexy('Nome de volume da disquete .......:',4,5);
      writexy('N£mero de s‚rie da disquete ......:',4,6);
      writexy('Disquete criada em ...............:',4,7);
      writexy('‘s ...............................:',4,8);
      writexy('Espa‡o total (bytes) .............:',4,9);
      writexy('Espa‡o usado (bytes) .............:',4,10);
      writexy('Espa‡o livre (bytes) .............:',4,11);
      writexy('Conte£dos ........................:',4,12);
    END;

{======================> Desloca-se para a posi‡„o desejada <================}

PROCEDURE pega_numero;

    VAR
      nu   : LONGINT;
      aux  : STRING[6];
      erro : INTEGER;

    BEGIN
      norm;
      textcolor(15);
      repeat
          writexy('Digite o n£mero da disquete .: ',5,5);
          clreol;
          readln(aux);
          val(aux,nu,erro);
      until (erro=0) and (nu > 0) and (nu - 1 < FILESIZE(arq));
      seek(arq,nu-1);
      read(arq,reg);
      seek(arq,filepos(arq)-1);
      textcolor(14);
      off;
    END;

{==========================> Insere nova disquete <==========================}

PROCEDURE Inserir;

BEGIN
     Textcolor(14);
     Inicia('Bibdisk  V2.0','   Jan.  1996');
     textcolor(12 + 128);
     Centra(2,'Introduza a disquete na drive A');
     delay(1500);
     textcolor(1);
     Centra(2,'Introduza a disquete na drive A');
     seek(arq,filesize(arq));
     mascara;
     textcolor(12 + 128);
     Centra(2,'Aguarde...');
     Execute('VOL A:>'+Tempfile);
     Assign(H,Tempfile);
     Reset(H);
     Readln(H,S);
     Readln(H,S);
     testa:=copy(S,2,1);
     If testa='O' then
       begin
         Reg.nomevol:=copy(S,26,11);
         Readln(H,S);
         Reg.numserie:=copy(S,32,9);
         Close(H);
         Execute('Del '+Tempfile);
       end
     else
       begin
         Reg.nomevol:=copy(S,23,11);
         Readln(H,S);
         Reg.numserie:=copy(S,26,9);
         Close(H);
         Execute('Del '+Tempfile);
       end;
     Execute('CHKDSK A:>'+Tempfile);
     Assign(H,Tempfile);
     Reset(H);
     Readln(H,S);
     Readln(H,S);
     testa:=copy(S,30,1);
     If testa='-' then
       begin
         Reg.data:=copy(S,28,10);
         Reg.hora:=copy(S,39,5);
       end
     else
       begin
         Reg.data:=copy(S,30,10);
         Reg.hora:=copy(S,41,5);
       end;
     use := disksize(1) - diskfree(1);
     Str(disksize(1),reg.total);
     Str(diskfree(1),reg.livre);
     Str(use,reg.usada);
     Close(H);
     Execute('Del '+Tempfile);
     textcolor(1);
     Centra(2,'Aguarde...');
     Textcolor(15);
     writexy(reg.nomevol,40,5);
     writexy(reg.numserie,40,6);
     writexy(reg.data,40,7);
     writexy(reg.hora,40,8);
     writexy(reg.total,40,9);
     writexy(reg.usada,40,10);
     writexy(reg.livre,40,11);
     textcolor(12 + 128);
     Centra(2,'Procurando direct¢rios...');
     Execute('DIR A: /AD /OG /B >'+Tempfile);
     Assign(H,Tempfile);
     Reset(H);
        Readln(H,S);
        reg.conteudo1 := Copy(s,1,12);
        Readln(H,S);
        reg.conteudo2 := Copy(s,1,12);
        Readln(H,S);
        reg.conteudo3 := Copy(s,1,12);
        Readln(H,S);
        reg.conteudo4 := Copy(s,1,12);
        Readln(H,S);
        reg.conteudo5 := Copy(s,1,12);
        Readln(H,S);
        reg.conteudo6 := Copy(s,1,12);
        Readln(H,S);
        reg.conteudo7 := Copy(s,1,12);
        Readln(H,S);
        reg.conteudo8 := Copy(s,1,12);
        Readln(H,S);
        reg.conteudo9 := Copy(s,1,12);
        Readln(H,S);
        reg.conteudo10 := Copy(s,1,12);
        textcolor(15);
        writexy(reg.conteudo1,40,12);
        writexy(reg.conteudo2,40,13);
        writexy(reg.conteudo3,40,14);
        writexy(reg.conteudo4,40,15);
        writexy(reg.conteudo5,40,16);
        writexy(reg.conteudo6,40,17);
        writexy(reg.conteudo7,40,18);
        writexy(reg.conteudo8,40,19);
        writexy(reg.conteudo9,40,20);
        writexy(reg.conteudo10,40,21);
     Close(H);
     Execute('Del '+Tempfile);
     write(arq,reg);
     textcolor(1);
     Centra(2,'Procurando direct¢rios...');
     textcolor(12 +128);
     Centra(2,'Pressione ENTER');
     repeat
       ch := upcase(readkey);
     until ch in [#13];
     textcolor(1);
     Centra(2,'Pressione ENTER');
     Menu_Principal;
END;

{=============================> Actualiza disquete <=========================}

PROCEDURE Actualizar;

    VAR
      nu   : LONGINT;
      aux  : STRING[6];
      erro : INTEGER;

BEGIN
     Inicia('Bibdisk  V2.1','   Jan.  1996');
     repeat
         norm;
         textcolor(14);
         writexy('Digite o n£mero da disquete a actualizar .: ',5,5);
         clreol;
         ch := upcase(readkey);
         if ch = #27 then Menu_principal;
         norm;
         textcolor(15);
         readln(aux);
         val(aux,nu,erro);
     until (erro=0) and (nu > 0) and (nu - 1 < FILESIZE(arq));
     seek(arq,nu-1);
     read(arq,reg);
     seek(arq,filepos(arq)-1);
     textcolor(14);
     off;
     Textcolor(14);
     Inicia('Bibdisk  V2.1','   Jan.  1996');
     mascara;
     textcolor(12 + 128);
     Centra(2,'Introduza a disquete na drive A');
     delay(1500);
     textcolor(1);
     Centra(2,'Introduza a disquete na drive A');
     textcolor(12 + 128);
     Centra(2,'Aguarde... Actualizando');
     Execute('VOL A:>'+Tempfile);
     Assign(H,Tempfile);
     Reset(H);
     Readln(H,S);
     Readln(H,S);
     testa:=copy(S,2,1);
     If testa='O' then
       begin
         if copy(s,26,11) <> reg.nomevol then
           begin
             textcolor(1);
             Centra(2,'Aguarde... Actualizando');
             textcolor(12 + 128);
             Centra(2,'nome do volume n„o correspondente');
             delay(1500);
             textcolor(1);
             Centra(2,'nome do volume n„o correspondente');
             menu_principal;
           end
         else
               readln(h,s);
               if copy(s,32,9) <> reg.numserie then
                 begin
                   textcolor(1);
                   Centra(2,'Aguarde... Actualizando');
                   textcolor(12 + 128);
                   Centra(2,'numero de serie n„o correspondente');
                   delay(1500);
                   textcolor(1);
                   Centra(2,'numero de serie n„o correspondente');
                   menu_principal;
                 end
               else
                 use := disksize(1) - diskfree(1);
                 Str(disksize(1),reg.total);
                 Str(diskfree(1),reg.livre);
                 Str(use,reg.usada);
                 Close(H);
                 Execute('Del '+Tempfile);
                 Textcolor(15);
                 writexy(reg.nomevol,40,5);
                 writexy(reg.numserie,40,6);
                 writexy(reg.data,40,7);
                 writexy(reg.hora,40,8);
                 writexy(reg.total,40,9);
                 writexy(reg.usada,40,10);
                 writexy(reg.livre,40,11);
                 Execute('DIR A: /AD /OG /B >'+Tempfile);
                 Assign(H,Tempfile);
                 Reset(H);
                 Readln(H,S);
                 reg.conteudo1 := Copy(s,1,12);
                 Readln(H,S);
                 reg.conteudo2 := Copy(s,1,12);
                 Readln(H,S);
                 reg.conteudo3 := Copy(s,1,12);
                 Readln(H,S);
                 reg.conteudo4 := Copy(s,1,12);
                 Readln(H,S);
                 reg.conteudo5 := Copy(s,1,12);
                 Readln(H,S);
                 reg.conteudo6 := Copy(s,1,12);
                 Readln(H,S);
                 reg.conteudo7 := Copy(s,1,12);
                 Readln(H,S);
                 reg.conteudo8 := Copy(s,1,12);
                 Readln(H,S);
                 reg.conteudo9 := Copy(s,1,12);
                 Readln(H,S);
                 reg.conteudo10 := Copy(s,1,12);
                 textcolor(15);
                 writexy(reg.conteudo1,40,12);
                 writexy(reg.conteudo2,40,13);
                 writexy(reg.conteudo3,40,14);
                 writexy(reg.conteudo4,40,15);
                 writexy(reg.conteudo5,40,16);
                 writexy(reg.conteudo6,40,17);
                 writexy(reg.conteudo7,40,18);
                 writexy(reg.conteudo8,40,19);
                 writexy(reg.conteudo9,40,20);
                 writexy(reg.conteudo10,40,21);
                 Close(H);
                 Execute('Del '+Tempfile);
                 write(arq,reg);
                 textcolor(1);
                 Centra(2,'Aguarde... Actualizando');
                 textcolor(12 +128);
                 Centra(1,'Actualiza‡„o conclu¡da');
                 Centra(2,'Pressione ENTER');
                 repeat
                   ch := upcase(readkey);
                 until ch in [#13];
                 textcolor(1);
                 Centra(1,'Actualiza‡„o conclu¡da');
                 Centra(2,'Pressione ENTER');
                 Menu_Principal;
           end
         else begin
         if copy(s,23,11) <> reg.nomevol then
           begin
             textcolor(1);
             Centra(2,'Aguarde... Actualizando');
             textcolor(12 + 128);
             Centra(2,'nome do volume n„o correspondente');
             delay(1500);
             textcolor(1);
             Centra(2,'nome do volume n„o correspondente');
             menu_principal;
           end
         else
               readln(h,s);
               if copy(s,26,9) <> reg.numserie then
                 begin
                   textcolor(1);
                   Centra(2,'Aguarde... Actualizando');
                   textcolor(12 + 128);
                   Centra(2,'numero de serie n„o correspondente');
                   delay(1500);
                   textcolor(1);
                   Centra(2,'numero de serie n„o correspondente');
                   menu_principal;
                 end
               else
                 use := disksize(1) - diskfree(1);
                 Str(disksize(1),reg.total);
                 Str(diskfree(1),reg.livre);
                 Str(use,reg.usada);
                 Close(H);
                 Execute('Del '+Tempfile);
                 Textcolor(15);
                 writexy(reg.nomevol,40,5);
                 writexy(reg.numserie,40,6);
                 writexy(reg.data,40,7);
                 writexy(reg.hora,40,8);
                 writexy(reg.total,40,9);
                 writexy(reg.usada,40,10);
                 writexy(reg.livre,40,11);
                 Execute('DIR A: /AD /OG /B >'+Tempfile);
                 Assign(H,Tempfile);
                 Reset(H);
                 Readln(H,S);
                 reg.conteudo1 := Copy(s,1,12);
                 Readln(H,S);
                 reg.conteudo2 := Copy(s,1,12);
                 Readln(H,S);
                 reg.conteudo3 := Copy(s,1,12);
                 Readln(H,S);
                 reg.conteudo4 := Copy(s,1,12);
                 Readln(H,S);
                 reg.conteudo5 := Copy(s,1,12);
                 Readln(H,S);
                 reg.conteudo6 := Copy(s,1,12);
                 Readln(H,S);
                 reg.conteudo7 := Copy(s,1,12);
                 Readln(H,S);
                 reg.conteudo8 := Copy(s,1,12);
                 Readln(H,S);
                 reg.conteudo9 := Copy(s,1,12);
                 Readln(H,S);
                 reg.conteudo10 := Copy(s,1,12);
                 textcolor(15);
                 writexy(reg.conteudo1,40,12);
                 writexy(reg.conteudo2,40,13);
                 writexy(reg.conteudo3,40,14);
                 writexy(reg.conteudo4,40,15);
                 writexy(reg.conteudo5,40,16);
                 writexy(reg.conteudo6,40,17);
                 writexy(reg.conteudo7,40,18);
                 writexy(reg.conteudo8,40,19);
                 writexy(reg.conteudo9,40,20);
                 writexy(reg.conteudo10,40,21);
                 Close(H);
                 Execute('Del '+Tempfile);
                 write(arq,reg);
                 textcolor(1);
                 Centra(2,'Aguarde... Actualizando');
                 textcolor(12 +128);
                 Centra(1,'Actualiza‡„o conclu¡da');
                 Centra(2,'Pressione ENTER');
                 repeat
                   ch := upcase(readkey);
                 until ch in [#13];
                 textcolor(1);
                 Centra(1,'Actualiza‡„o conclu¡da');
                 Centra(2,'Pressione ENTER');
                 Menu_Principal;
           end;
END;

{============================> Substitui disquete <==========================}

PROCEDURE Substituir;

    VAR
      nu   : LONGINT;
      aux  : STRING[6];
      erro : INTEGER;

BEGIN
     Inicia('Bibdisk  V2.1','   Jan.  1996');
     repeat
         norm;
         textcolor(14);
         writexy('Digite o n£mero da disquete a substituir .: ',5,5);
         clreol;
         ch := upcase(readkey);
         if ch = #27 then Menu_principal;
         norm;
         textcolor(15);
         readln(aux);
         val(aux,nu,erro);
     until (erro=0) and (nu > 0) and (nu - 1 < FILESIZE(arq));
     seek(arq,nu-1);
     read(arq,reg);
     seek(arq,filepos(arq)-1);
     textcolor(14);
     off;
     Textcolor(14);
     Inicia('Bibdisk  V2.1','   Jan.  1996');
     mascara;
     textcolor(12 + 128);
     Centra(2,'Introduza a disquete na drive A');
     delay(1500);
     textcolor(1);
     Centra(2,'Introduza a disquete na drive A');
     textcolor(12 + 128);
     Centra(2,'Aguarde... Substituindo');
     Execute('VOL A:>'+Tempfile);
     Assign(H,Tempfile);
     Reset(H);
     Readln(H,S);
     Readln(H,S);
     testa:=copy(S,2,1);
     If testa='O' then
       begin
         Reg.nomevol:=copy(S,26,11);
         Readln(H,S);
         Reg.numserie:=copy(S,32,9);
         Close(H);
         Execute('Del '+Tempfile);
       end
     else
       begin
         Reg.nomevol:=copy(S,23,11);
         Readln(H,S);
         Reg.numserie:=copy(S,26,9);
         Close(H);
         Execute('Del '+Tempfile);
       end;
     Execute('CHKDSK A:>'+Tempfile);
     Assign(H,Tempfile);
     Reset(H);
     Readln(H,S);
     Readln(H,S);
     testa:=copy(S,30,1);
     If testa='-' then
       begin
        Reg.data:=copy(S,28,10);
        Reg.hora:=copy(S,39,5);
       end
     else
       begin
        Reg.data:=copy(S,30,10);
        Reg.hora:=copy(S,41,5);
       end;
     use := disksize(1) - diskfree(1);
     Str(disksize(1),reg.total);
     Str(diskfree(1),reg.livre);
     Str(use,reg.usada);
     Close(H);
     Execute('Del '+Tempfile);
     Textcolor(15);
     writexy(reg.nomevol,40,5);
     writexy(reg.numserie,40,6);
     writexy(reg.data,40,7);
     writexy(reg.hora,40,8);
     writexy(reg.total,40,9);
     writexy(reg.usada,40,10);
     writexy(reg.livre,40,11);
     Execute('DIR A: /AD /OG /B >'+Tempfile);
     Assign(H,Tempfile);
     Reset(H);
     Readln(H,S);
     reg.conteudo1 := Copy(s,1,12);
     Readln(H,S);
     reg.conteudo2 := Copy(s,1,12);
     Readln(H,S);
     reg.conteudo3 := Copy(s,1,12);
     Readln(H,S);
     reg.conteudo4 := Copy(s,1,12);
     Readln(H,S);
     reg.conteudo5 := Copy(s,1,12);
     Readln(H,S);
     reg.conteudo6 := Copy(s,1,12);
     Readln(H,S);
     reg.conteudo7 := Copy(s,1,12);
     Readln(H,S);
     reg.conteudo8 := Copy(s,1,12);
     Readln(H,S);
     reg.conteudo9 := Copy(s,1,12);
     Readln(H,S);
     reg.conteudo10 := Copy(s,1,12);
     textcolor(15);
     writexy(reg.conteudo1,40,12);
     writexy(reg.conteudo2,40,13);
     writexy(reg.conteudo3,40,14);
     writexy(reg.conteudo4,40,15);
     writexy(reg.conteudo5,40,16);
     writexy(reg.conteudo6,40,17);
     writexy(reg.conteudo7,40,18);
     writexy(reg.conteudo8,40,19);
     writexy(reg.conteudo9,40,20);
     writexy(reg.conteudo10,40,21);
     Close(H);
     Execute('Del '+Tempfile);
     write(arq,reg);
     textcolor(1);
     Centra(2,'Aguarde... Substituindo');
     textcolor(12 +128);
     Centra(1,'Substitui‡„o conclu¡da');
     Centra(2,'Pressione ENTER');
     repeat
       ch := upcase(readkey);
     until ch in [#13];
     textcolor(1);
     Centra(1,'Substitui‡„o conclu¡da');
     Centra(2,'Pressione ENTER');
     Menu_Principal;
END;

{====================> Lista o conte£do do ficheiro de dados <===============}

PROCEDURE Listar;

    VAR
       painel : BYTE;
       r:LONGINT;

BEGIN
     Textcolor(14);
     Inicia('Bibdisk  V2.1','   Jan.  1996');
     writexy('      ',1,24);
     vertical(1,3,3,0,'³');
     vertical(7,3,21,0,'³');
     vertical(39,3,21,0,'º');
     vertical(41,3,21,0,'º');
     vertical(40,4,19,0,'°');
     horizontal(1,6,37,'Ä');
     horizontal(7,9,32,'Ä');
     horizontal(7,12,32,'Ä');
     horizontal(7,15,32,'Ä');
     horizontal(7,18,32,'Ä');
     horizontal(7,21,32,'Ä');
     writexy('Ú',1,3);
     writexy('À',1,6);
     writexy('Â',7,3);
     writexy('Å',7,6);
     writexy('Ã',7,9);
     writexy('Ã',7,12);
     writexy('Ã',7,15);
     writexy('Ã',7,18);
     writexy('Ã',7,21);
     writexy('À',7,24);
     writexy('Ò',39,3);
     writexy('Ò',41,3);
     writexy('Ð',41,24);
     writexy('Ð',39,24);
     writexy('¶',39,6);
     writexy('¶',39,9);
     writexy('¶',39,12);
     writexy('¶',39,15);
     writexy('¶',39,18);
     writexy('¶',39,21);
     r:=0;
     repeat
     seek(arq,r);
     {$I-}
     read(arq,reg);
     {$I+}
     if ioresult<>0 then Menu_Principal;
     with reg do
    BEGIN
     textcolor(14);
     writexy('N§',4,4);
     writexy('Nome da disquete',15,4);
     writexy('N§ de s‚rie',17,7);
     writexy('Criada em',18,10);
     writexy('…s',22,13);
     writexy('Espa‡o total (em bytes)',12,16);
     writexy('Espa‡o usado (em bytes)',12,19);
     writexy('Espa‡o livre (em bytes)',12,22);
     writexy('CONTE–DOS',55,4);
     horizontal(55,5,8,'Í');
     textcolor(1);
     horizontal(2,5,4,' ');
     horizontal(8,5,30,' ');
     horizontal(8,8,30,' ');
     horizontal(8,11,30,' ');
     horizontal(8,14,30,' ');
     horizontal(8,17,30,' ');
     horizontal(8,20,30,' ');
     horizontal(8,23,30,' ');
     horizontal(48,9,30,' ');
     horizontal(48,10,30,' ');
     horizontal(48,11,30,' ');
     horizontal(48,12,30,' ');
     horizontal(48,13,30,' ');
     horizontal(48,14,30,' ');
     horizontal(48,15,30,' ');
     horizontal(48,16,30,' ');
     horizontal(48,17,30,' ');
     horizontal(48,18,30,' ');
     textcolor(15);
     gotoxy(2,5);
     write(filepos(arq):3);
     writexy(reg.nomevol,18,5);
     writexy(reg.numserie,18,8);
     writexy(reg.data,17,11);
     writexy(reg.hora,21,14);
     writexy(reg.total,20,17);
     writexy(reg.usada,20,20);
     writexy(reg.livre,20,23);
     writexy(reg.conteudo1,48,9);
     writexy(reg.conteudo2,48,10);
     writexy(reg.conteudo3,48,11);
     writexy(reg.conteudo4,48,12);
     writexy(reg.conteudo5,48,13);
     writexy(reg.conteudo6,48,14);
     writexy(reg.conteudo7,48,15);
     writexy(reg.conteudo8,48,16);
     writexy(reg.conteudo9,48,17);
     writexy(reg.conteudo10,48,18);
     end;
           REPEAT
                 CH:=READKEY;
           UNTIL CH IN [#0,#27];
           CASE CH OF
                #0:BEGIN
                        REPEAT
                              CH:=READKEY;
                        UNTIL CH IN [#72,#80];
                        CASE CH OF
                             #72:IF R=0 THEN R:=FILESIZE(arq)-1
                                        ELSE R:=R-1;
                             #80:IF R=FILESIZE(arq)-1 THEN R:=0
                                                    ELSE R:=R+1;
                        END;
                   END;
           END;
     UNTIL CH=#27;
     Menu_Principal;
END;

{======================> Rotina de procura de conte£do <=====================}

PROCEDURE procura_conteudo;

    VAR
       a,b,i,e,f        : INTEGER;
       quero_conteudo   : STRING[30];

    BEGIN
       Inicia('Bibdisk  V2.1','   Jan.  1996');
       writexy('Qual o conte£do de procura',25,6);
       norm;
       gotoxy(20,7);
       readln(quero_conteudo);
       for a := 1 to Length(quero_conteudo) do
       quero_conteudo[a] := UpCase(quero_conteudo[a]);
       off;
       seek(arq,0);
       while not eof(arq) do
           begin
             textcolor(14);
             Inicia('Bibdisk  V2.1','   Jan.  1996');
             i := 0;
             while not eof(arq) and ( i < 14) do
                 begin
                    read(arq,reg);
                    for a := 1 to Length(reg.conteudo1) do
                    reg.conteudo1[a] := UpCase(reg.conteudo1[a]);
                    for a := 1 to Length(reg.conteudo2) do
                    reg.conteudo2[a] := UpCase(reg.conteudo2[a]);
                    for a := 1 to Length(reg.conteudo3) do
                    reg.conteudo3[a] := UpCase(reg.conteudo3[a]);
                    for a := 1 to Length(reg.conteudo4) do
                    reg.conteudo4[a] := UpCase(reg.conteudo4[a]);
                    for a := 1 to Length(reg.conteudo5) do
                    reg.conteudo5[a] := UpCase(reg.conteudo5[a]);
                    for a := 1 to Length(reg.conteudo6) do
                    reg.conteudo6[a] := UpCase(reg.conteudo6[a]);
                    for a := 1 to Length(reg.conteudo7) do
                    reg.conteudo7[a] := UpCase(reg.conteudo7[a]);
                    for a := 1 to Length(reg.conteudo8) do
                    reg.conteudo8[a] := UpCase(reg.conteudo8[a]);
                    for a := 1 to Length(reg.conteudo9) do
                    reg.conteudo9[a] := UpCase(reg.conteudo9[a]);
                    for a := 1 to Length(reg.conteudo10) do
                    reg.conteudo10[a] := UpCase(reg.conteudo10[a]);
                    if POS(quero_conteudo,reg.conteudo1) > 0
                       then
                          begin
                            gotoxy(6,6+i);
                            write('Conte£do encontrado na disk',filepos(arq):3);
                            i := i + 1;
                          end;
                    if POS(quero_conteudo,reg.conteudo2) > 0
                       then
                          begin
                            gotoxy(6,6+i);
                            write('Conte£do encontrado na disk',filepos(arq):3);
                            i := i + 1;
                          end;
                    if POS(quero_conteudo,reg.conteudo3) > 0
                       then
                          begin
                            gotoxy(6,6+i);
                            write('Conte£do encontrado na disk',filepos(arq):3);
                            i := i + 1;
                          end;
                    if POS(quero_conteudo,reg.conteudo4) > 0
                       then
                          begin
                            gotoxy(6,6+i);
                            write('Conte£do encontrado na disk',filepos(arq):3);
                            i := i + 1;
                          end;
                    if POS(quero_conteudo,reg.conteudo5) > 0
                       then
                          begin
                            gotoxy(6,6+i);
                            write('Conte£do encontrado na disk',filepos(arq):3);
                            i := i + 1;
                          end;
                    if POS(quero_conteudo,reg.conteudo6) > 0
                       then
                          begin
                            gotoxy(6,6+i);
                            write('Conte£do encontrado na disk',filepos(arq):3);
                            i := i + 1;
                          end;
                    if POS(quero_conteudo,reg.conteudo7) > 0
                       then
                          begin
                            gotoxy(6,6+i);
                            write('Conte£do encontrado na disk',filepos(arq):3);
                            i := i + 1;
                          end;
                    if POS(quero_conteudo,reg.conteudo8) > 0
                       then
                          begin
                            gotoxy(6,6+i);
                            write('Conte£do encontrado na disk',filepos(arq):3);
                            i := i + 1;
                          end;
                    if POS(quero_conteudo,reg.conteudo9) > 0
                       then
                          begin
                            gotoxy(6,6+i);
                            write('Conte£do encontrado na disk',filepos(arq):3);
                            i := i + 1;
                          end;
                    if POS(quero_conteudo,reg.conteudo10) > 0
                       then
                          begin
                            gotoxy(6,6+i);
                            write('Conte£do encontrado na disk',filepos(arq):3);
                            i := i + 1;
                          end;
                 end;
             textcolor(12);
             Centra(2,'Tecle algo para continuar');
             repeat until readkey <> #0;
           end;
             menu_procurar;
   END;


{=====================> Rotina de procura de bytes livres <==================}

PROCEDURE procura_bytes_livres;

    VAR
       a,e         : INTEGER;
       quero_valor : REAL;
       livres:REAL;
       erro:INTEGER;

    BEGIN
       Inicia('Bibdisk  V2.1','   Jan.  1996');
       writexy('Qual o valor de bytes livres que necessitas',17,6);
       norm;
       gotoxy(32,7);
       readln(quero_valor);
       off;
       seek(arq,0);
       while not eof(arq) do
           begin
             Inicia('Bibdisk  V2.1','   Jan.  1996');
             textcolor(14);
             e := 0;
             a := 0;
             while not eof(arq)  and (e < 14) do
                 begin
                    read(arq,reg);
                    val(reg.livre,livres,erro);
                    if livres >= quero_valor
                       then
                          begin
                            gotoxy(6,6+a);
                            write('Valor superior encontrado na disk',filepos(arq):3);
                            a := a + 1;
                            e := e + 1;
                          end;
                 end;
             textcolor(12);
             Centra(2,'Tecle algo para continuar');
             repeat until readkey <> #0;
          end;
        menu_procurar;
   END;

{========================> Rotina de procura por n£mero <====================}

PROCEDURE procura_numero;

    VAR
      e : INTEGER;

    BEGIN
       Inicia('Bibdisk  V2.1','   Jan.  1996');
       pega_numero;
       Inicia('Bibdisk  V2.1','   Jan.  1996');
       writexy('      ',1,24);
       vertical(1,3,3,0,'³');
       vertical(7,3,21,0,'³');
       vertical(39,3,21,0,'º');
       vertical(41,3,21,0,'º');
       vertical(40,4,19,0,'°');
       horizontal(1,6,37,'Ä');
       horizontal(7,9,32,'Ä');
       horizontal(7,12,32,'Ä');
       horizontal(7,15,32,'Ä');
       horizontal(7,18,32,'Ä');
       horizontal(7,21,32,'Ä');
       writexy('Ú',1,3);
       writexy('À',1,6);
       writexy('Â',7,3);
       writexy('Å',7,6);
       writexy('Ã',7,9);
       writexy('Ã',7,12);
       writexy('Ã',7,15);
       writexy('Ã',7,18);
       writexy('Ã',7,21);
       writexy('À',7,24);
       writexy('Ò',39,3);
       writexy('Ò',41,3);
       writexy('Ð',41,24);
       writexy('Ð',39,24);
       writexy('¶',39,6);
       writexy('¶',39,9);
       writexy('¶',39,12);
       writexy('¶',39,15);
       writexy('¶',39,18);
       writexy('¶',39,21);
       read(arq,reg);
       textcolor(14);
       writexy('N§',4,4);
       writexy('Nome da disquete',15,4);
       writexy('N§ de s‚rie',17,7);
       writexy('Criada em',18,10);
       writexy('…s',22,13);
       writexy('Espa‡o total (em bytes)',12,16);
       writexy('Espa‡o usado (em bytes)',12,19);
       writexy('Espa‡o livre (em bytes)',12,22);
       writexy('CONTE–DOS',55,4);
       horizontal(55,5,8,'Í');
       textcolor(15);
       gotoxy(2,5);
       write(filepos(arq):3);
       writexy(reg.nomevol,18,5);
       writexy(reg.numserie,18,8);
       writexy(reg.data,17,11);
       writexy(reg.hora,21,14);
       writexy(reg.total,20,17);
       writexy(reg.usada,20,20);
       writexy(reg.livre,20,23);
       writexy(reg.conteudo1,48,9);
       writexy(reg.conteudo2,48,10);
       writexy(reg.conteudo3,48,11);
       writexy(reg.conteudo4,48,12);
       writexy(reg.conteudo5,48,13);
       writexy(reg.conteudo6,48,14);
       writexy(reg.conteudo7,48,15);
       writexy(reg.conteudo8,48,16);
       writexy(reg.conteudo9,48,17);
       writexy(reg.conteudo10,48,18);
       textcolor(12);
       Centra(2,'Tecle algo para continuar');
       repeat until readkey <> #0;
       menu_procurar;
   END;


{===========================> Finaliza o programa <==========================}

PROCEDURE Finalizar;

 BEGIN
   close(arq);
   clrscr;
   darker(1,1,80,25,7,0);
   norm;
   halt;
 END;

{============================> Menu Procurar <===============================}

PROCEDURE Menu_procurar;

 TYPE
     opc = SET OF CHAR;

 VAR
    op:opc;

 BEGIN
   op := ['C','B','N','S'];
   Inicia('Bibdisk  V2.1','   Jan.  1996');
   Off;
   textcolor(7);
   Centra(7,'Conte£do');
   Centra(9,'Bytes livres');
   Centra(11,'N£mero');
   Centra(13,'Sair');
   textcolor(12);
   writexy('C',36,7);
   writexy('B',34,9);
   writexy('N',37,11);
   writexy('S',38,13);
   repeat
       ch := upcase(readkey);
       if not (ch in op)
         then
            write(#7);
   until ch in op;
   case ch of
             'C' : Procura_conteudo;
             'B' : Procura_bytes_livres;
             'N' : Procura_numero;
             'S' : Menu_principal;
   end;
 END;

{============================> Menu Principal <==============================}

PROCEDURE Menu_principal;

 TYPE
     opc = SET OF CHAR;

 VAR
    op:opc;

 BEGIN
   op := ['I','D','S','P','L','A','F'];
   Inicia('Bibdisk  V2.1','   Jan.  1996');
   Off;
   textcolor(7);
   Centra(7,'Inserir Nova Disquete');
   Centra(9,'Actualizar Disquete ');
   Centra(11,'Substituir Disquete ');
   Centra(13,'Procurar Disquete ');
   Centra(15,'Listar Disquetes  ');
   Centra(17,'Finalizar');
   textcolor(12);
   writexy('I',29,7);
   writexy('D',41,9);
   writexy('S',30,11);
   writexy('P',31,13);
   writexy('L',31,15);
   writexy('F',35,17);
   repeat
       ch := upcase(readkey);
       if not (ch in op)
         then
            write(#7);
   until ch in op;
   case ch of
             'I' : Inserir;
             'D' : Actualizar;
             'S' : Substituir;
             'P' : Menu_procurar;
             'L' : Listar;
             'F' : Finalizar;
   end;
 END;




{============================> Corpo do programa <===========================}

BEGIN
 Abre_arq(Datafile);
 Menu_principal;
END.