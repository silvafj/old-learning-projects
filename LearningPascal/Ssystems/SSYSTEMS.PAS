



          {******************************************************}
          {* Program : Sequencial Systems                       *}
          {* Version : 1.0 Beta                                 *}
          {* Programed by : Fernando J.A. Silva                 *}
          {* Programed under : Borland Pascal 7.0               *}
          {* Address : Juncal - Assequins 3750 µgueda  PORTUGAL *}
          {* Programming duration : from 11/96 to 03/97         *}
          {******************************************************}
             {************************************************}
             {*            Sequencial Systems                *}
             {*               Version 1.0                    *}
             {*         Copyrigth (c) 1995-97  by            *}
             {*         Bullion MultiSoft Company            *}
             {************************************************}






 PROGRAM Sequencial_Systems;

  USES
    CRT,GRAPHICS,
    SSYSTEM1, { Variaveis and types }
    SSYSTEM2, { Graphical utilites and terminating function   }
    SSYSTEM3, { Tabela de Estados e caracteristicas functions }
    SSYSTEM4, { Diagrama functions }
    SSYSTEM5, { Tabelas functions }
    SSYSTEM6, { Circuito functions}
    SSYSTEM7; { Main commands}

   {*********************************************************************}
   {*                          MAIN PROGRAM                             *}
   {*********************************************************************}

  BEGIN
    CheckBreak:=FALSE; { Not verifies Ctrl+Break }
    Modo:=2;     { Declares 640*480 mode }
    InitGraphMode(16);  { Inits 16 colors mode }
    Funcao:=1;   { Funcao to execute number 1 }
    Quadrado:=1;  { Quadrado number 1 }
    Ecra:=1;  { Ecra number 1 }
    EcraMax:=0;  { Max Number of ecra }
    Finish:=FALSE; { The program is not terminated }
    Estados:=0;   { The estados are 0 }
    StrLetras:='';   { String empty }
    StrNumeros:='';   { String empty }
    StrCirculos:='';    { String empty }
    Biestavel:=1;  { Biest vel JK }
    Erro:='';     { No errors }
    InitTable;    { Inits the table with specified elements }
    DesignFirstScreen(1,TRUE); { Designs the first screen }
    CommandTable;   { Initiate the CommandTable with all keys}
    Terminate;  { Finish's the program }
  END.