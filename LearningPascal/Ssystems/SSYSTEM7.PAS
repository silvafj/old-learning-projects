UNIT SSYSTEM7;

INTERFACE
 USES
    CRT,GRAPH,SSYSTEM1,SSYSTEM2,SSYSTEM3,SSYSTEM4,SSYSTEM5,SSYSTEM6;

  PROCEDURE CommandTable;

IMPLEMENTATION

{*****}
  PROCEDURE CommandTable;
   { This procedure commands all keys and functions }

    PROCEDURE DoFunctionNumber(Number:INTEGER);
     { This procedure corresponds a number to the function }

      BEGIN
        CASE Number OF
{ F1 }    1:BEGIN
              Funcao:=1;
              DesignFirstScreen(Quadrado,TRUE);
            END;
{ F2 }    2:BEGIN
              IF VerifyTableForDiagrama THEN
                BEGIN
                  Funcao:=3;
                  DesignDiagramScreen;
                END
               ELSE
                BEGIN
                  SetColor(4);
                  SetTextJustify(1,1);
                  SetTextStyle(5,0,1);
                  OutTextXY(500,210,'Erro !!!!');
                  OutTextXY(500,230,'"'+Erro+'"');
                  OutTextXY(500,250,'Pressione Enter');
                  REPEAT
                    Tecla:=ReadNewKey;
                  UNTIL Tecla=13;
                  SetColor(0);
                  OutTextXY(500,210,'Erro !!!!');
                  OutTextXY(500,230,'"'+Erro+'"');
                  OutTextXY(500,250,'Pressione Enter');
                END;
            END;
{ F3 }    3:BEGIN
              IF VerifyTableForTabelas THEN
                BEGIN
                  Ecra:=1;
                  Funcao:=5;
                  DesignTabelasScreen;
                END
               ELSE
                BEGIN
                  SetColor(4);
                  SetTextJustify(1,1);
                  SetTextStyle(5,0,1);
                  OutTextXY(500,210,'Erro !!!!');
                  OutTextXY(500,230,'"'+Erro+'"');
                  OutTextXY(500,250,'Pressione Enter');
                  REPEAT
                    Tecla:=ReadNewKey;
                  UNTIL Tecla=13;
                  SetColor(0);
                  OutTextXY(500,210,'Erro !!!!');
                  OutTextXY(500,230,'"'+Erro+'"');
                  OutTextXY(500,250,'Pressione Enter');
                END;
            END;
{ F4 }    4:BEGIN
              IF VerifyTableForCircuito THEN
                BEGIN
                  Funcao:=6;
                  DesignCircuitoScreen;
                END
               ELSE
                BEGIN
                  SetColor(4);
                  SetTextJustify(1,1);
                  SetTextStyle(5,0,1);
                  OutTextXY(500,210,'Erro !!!!');
                  OutTextXY(500,230,'"'+Erro+'"');
                  OutTextXY(500,250,'Pressione Enter');
                  REPEAT
                    Tecla:=ReadNewKey;
                  UNTIL Tecla=13;
                  SetColor(0);
                  OutTextXY(500,210,'Erro !!!!');
                  OutTextXY(500,230,'"'+Erro+'"');
                  OutTextXY(500,250,'Pressione Enter');
                END;
            END;
          5:BEGIN
              DesignTabelasScreen;
            END;
          6:BEGIN
              DesignTabelasScreen2;
            END;
          7:BEGIN
              DesignTabelasScreen3;
            END;
          8:BEGIN
              DesignTabelasScreen4;
            END;
        END; { End Case Number }
      END; { DoFunctionNumber }

    BEGIN
      Repeat
      Tecla:=ReadNewKey;
      CASE Funcao OF
        1:BEGIN  { Inits the case of introducing function }
            CASE Quadrado OF
              1:BEGIN  { Inits the case of square number one }
                  CASE Tecla OF
              {Cima}72:BEGIN
                       END;
            {Esquer}75:BEGIN
                         DesignSquareNumber(1,TRUE);
                         Quadrado:=1;
                       END;
            {Direit}77:BEGIN
                         DesignSquareNumber(1,FALSE);
                         DesignSquareNumber(2,TRUE);
                         Quadrado:=2;
                       END;
             {Baixo}80:BEGIN
                         DesignSquareNumber(1,FALSE);
                         DesignSquareNumber(5,TRUE);
                         Quadrado:=5;
                       END;
             {Enter}13:BEGIN
                         InsertSquareNumber(1);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         {F1 Tabela}59:BEGIN
                         Funcao:=1;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
        {F3 Tabelas}61:BEGIN
                         DoFunctionNumber(3);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
{F9 Caracteristicas}67:BEGIN
                         Funcao:=2;
                         DesignCaracteristicasScreen;
                       END;
                  END; { End case tecla }
                END; { End square number one }
              2:BEGIN  { Inits the case of square number two }
                  CASE Tecla OF
              {Cima}72:BEGIN
                       END;
            {Esquer}75:BEGIN
                         DesignSquareNumber(2,FALSE);
                         DesignSquareNumber(1,TRUE);
                         Quadrado:=1;
                       END;
            {Direit}77:BEGIN
                         DesignSquareNumber(2,FALSE);
                         DesignSquareNumber(3,TRUE);
                         Quadrado:=3;
                       END;
             {Baixo}80:BEGIN
                         DesignSquareNumber(2,FALSE);
                         DesignSquareNumber(6,TRUE);
                         Quadrado:=6;
                       END;
             {Enter}13:BEGIN
                         InsertSquareNumber(2);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         {F1 Tabela}59:BEGIN
                         Funcao:=1;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
        {F3 Tabelas}61:BEGIN
                         DoFunctionNumber(3);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
{F9 Caracteristicas}67:BEGIN
                         Funcao:=2;
                         DesignCaracteristicasScreen;
                       END;
                  END; { End case tecla }
                END; { End square number two }
              3:BEGIN  { Inits the case of square number three }
                  CASE Tecla OF
              {Cima}72:BEGIN
                       END;
            {Esquer}75:BEGIN
                         DesignSquareNumber(3,FALSE);
                         DesignSquareNumber(2,TRUE);
                         Quadrado:=2;
                       END;
            {Direit}77:BEGIN
                         DesignSquareNumber(3,FALSE);
                         DesignSquareNumber(4,TRUE);
                         Quadrado:=4;
                       END;
             {Baixo}80:BEGIN
                         DesignSquareNumber(3,FALSE);
                         DesignSquareNumber(7,TRUE);
                         Quadrado:=7;
                       END;
             {Enter}13:BEGIN
                         InsertSquareNumber(3);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         {F1 Tabela}59:BEGIN
                         Funcao:=1;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
        {F3 Tabelas}61:BEGIN
                         DoFunctionNumber(3);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
{F9 Caracteristicas}67:BEGIN
                         Funcao:=2;
                         DesignCaracteristicasScreen;
                       END;
                  END; { End case tecla }
                END; { End square number three }
              4:BEGIN  { Inits the case of square number four }
                  CASE Tecla OF
              {Cima}72:BEGIN
                       END;
            {Esquer}75:BEGIN
                         DesignSquareNumber(4,FALSE);
                         DesignSquareNumber(3,TRUE);
                         Quadrado:=3;
                       END;
            {Direit}77:BEGIN
                         DesignSquareNumber(4,TRUE);
                         Quadrado:=4;
                       END;
             {Baixo}80:BEGIN
                         DesignSquareNumber(4,FALSE);
                         DesignSquareNumber(8,TRUE);
                         Quadrado:=8;
                       END;
             {Enter}13:BEGIN
                         InsertSquareNumber(4);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         {F1 Tabela}59:BEGIN
                         Funcao:=1;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
        {F3 Tabelas}61:BEGIN
                         DoFunctionNumber(3);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
{F9 Caracteristicas}67:BEGIN
                         Funcao:=2;
                         DesignCaracteristicasScreen;
                       END;
                  END; { End case tecla }
                END; { End square number four }
              5:BEGIN  { Inits the case of square number five }
                  CASE Tecla OF
              {Cima}72:BEGIN
                         DesignSquareNumber(5,FALSE);
                         DesignSquareNumber(1,TRUE);
                         Quadrado:=1;
                       END;
            {Esquer}75:BEGIN
                         DesignSquareNumber(5,TRUE);
                         Quadrado:=5;
                       END;
            {Direit}77:BEGIN
                         DesignSquareNumber(5,FALSE);
                         DesignSquareNumber(6,TRUE);
                         Quadrado:=6;
                       END;
             {Baixo}80:BEGIN
                         DesignSquareNumber(5,FALSE);
                         DesignSquareNumber(9,TRUE);
                         Quadrado:=9;
                       END;
             {Enter}13:BEGIN
                         InsertSquareNumber(5);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         {F1 Tabela}59:BEGIN
                         Funcao:=1;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
        {F3 Tabelas}61:BEGIN
                         DoFunctionNumber(3);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
{F9 Caracteristicas}67:BEGIN
                         Funcao:=2;
                         DesignCaracteristicasScreen;
                       END;
                  END; { End case tecla }
                END; { End square number five }
              6:BEGIN  { Inits the case of square number six }
                  CASE Tecla OF
              {Cima}72:BEGIN
                         DesignSquareNumber(6,FALSE);
                         DesignSquareNumber(2,TRUE);
                         Quadrado:=2;
                       END;
            {Esquer}75:BEGIN
                         DesignSquareNumber(6,FALSE);
                         DesignSquareNumber(5,TRUE);
                         Quadrado:=5;
                       END;
            {Direit}77:BEGIN
                         DesignSquareNumber(6,FALSE);
                         DesignSquareNumber(7,TRUE);
                         Quadrado:=7;
                       END;
             {Baixo}80:BEGIN
                         DesignSquareNumber(6,FALSE);
                         DesignSquareNumber(10,TRUE);
                         Quadrado:=10;
                       END;
             {Enter}13:BEGIN
                         InsertSquareNumber(6);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         {F1 Tabela}59:BEGIN
                         Funcao:=1;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
        {F3 Tabelas}61:BEGIN
                         DoFunctionNumber(3);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
{F9 Caracteristicas}67:BEGIN
                         Funcao:=2;
                         DesignCaracteristicasScreen;
                       END;
                  END; { End case tecla }
                END; { End square number six }
              7:BEGIN  { Inits the case of square number 7 }
                  CASE Tecla OF
              {Cima}72:BEGIN
                         DesignSquareNumber(7,FALSE);
                         DesignSquareNumber(3,TRUE);
                         Quadrado:=3;
                       END;
            {Esquer}75:BEGIN
                         DesignSquareNumber(7,FALSE);
                         DesignSquareNumber(6,TRUE);
                         Quadrado:=6;
                       END;
            {Direit}77:BEGIN
                         DesignSquareNumber(7,FALSE);
                         DesignSquareNumber(8,TRUE);
                         Quadrado:=8;
                       END;
             {Baixo}80:BEGIN
                         DesignSquareNumber(7,FALSE);
                         DesignSquareNumber(11,TRUE);
                         Quadrado:=11;
                       END;
             {Enter}13:BEGIN
                         InsertSquareNumber(7);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         {F1 Tabela}59:BEGIN
                         Funcao:=1;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
        {F3 Tabelas}61:BEGIN
                         DoFunctionNumber(3);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
{F9 Caracteristicas}67:BEGIN
                         Funcao:=2;
                         DesignCaracteristicasScreen;
                       END;
                  END; { End case tecla }
                END; { End square number 7 }
              8:BEGIN  { Inits the case of square number 8 }
                  CASE Tecla OF
              {Cima}72:BEGIN
                         DesignSquareNumber(8,FALSE);
                         DesignSquareNumber(4,TRUE);
                         Quadrado:=4;
                       END;
            {Esquer}75:BEGIN
                         DesignSquareNumber(8,FALSE);
                         DesignSquareNumber(7,TRUE);
                         Quadrado:=7;
                       END;
            {Direit}77:BEGIN
                         DesignSquareNumber(8,TRUE);
                         Quadrado:=8;
                       END;
             {Baixo}80:BEGIN
                         DesignSquareNumber(8,FALSE);
                         DesignSquareNumber(12,TRUE);
                         Quadrado:=12;
                       END;
             {Enter}13:BEGIN
                         InsertSquareNumber(8);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         {F1 Tabela}59:BEGIN
                         Funcao:=1;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
        {F3 Tabelas}61:BEGIN
                         DoFunctionNumber(3);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
{F9 Caracteristicas}67:BEGIN
                         Funcao:=2;
                         DesignCaracteristicasScreen;
                       END;
                  END; { End case tecla }
                END; { End square number 8 }
              9:BEGIN  { Inits the case of square number 9 }
                  CASE Tecla OF
              {Cima}72:BEGIN
                         DesignSquareNumber(9,FALSE);
                         DesignSquareNumber(5,TRUE);
                         Quadrado:=5;
                       END;
            {Esquer}75:BEGIN
                         DesignSquareNumber(9,TRUE);
                         Quadrado:=9;
                       END;
            {Direit}77:BEGIN
                         DesignSquareNumber(9,FALSE);
                         DesignSquareNumber(10,TRUE);
                         Quadrado:=10;
                       END;
             {Baixo}80:BEGIN
                         DesignSquareNumber(9,FALSE);
                         DesignSquareNumber(13,TRUE);
                         Quadrado:=13;
                       END;
             {Enter}13:BEGIN
                         InsertSquareNumber(9);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         {F1 Tabela}59:BEGIN
                         Funcao:=1;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
        {F3 Tabelas}61:BEGIN
                         DoFunctionNumber(3);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
{F9 Caracteristicas}67:BEGIN
                         Funcao:=2;
                         DesignCaracteristicasScreen;
                       END;
                  END; { End case tecla }
                END; { End square number 9 }
             10:BEGIN  { Inits the case of square number 10 }
                  CASE Tecla OF
              {Cima}72:BEGIN
                         DesignSquareNumber(10,FALSE);
                         DesignSquareNumber(6,TRUE);
                         Quadrado:=6;
                       END;
            {Esquer}75:BEGIN
                         DesignSquareNumber(10,FALSE);
                         DesignSquareNumber(9,TRUE);
                         Quadrado:=9;
                       END;
            {Direit}77:BEGIN
                         DesignSquareNumber(10,FALSE);
                         DesignSquareNumber(11,TRUE);
                         Quadrado:=11;
                       END;
             {Baixo}80:BEGIN
                         DesignSquareNumber(10,FALSE);
                         DesignSquareNumber(14,TRUE);
                         Quadrado:=14;
                       END;
             {Enter}13:BEGIN
                         InsertSquareNumber(10);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         {F1 Tabela}59:BEGIN
                         Funcao:=1;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
        {F3 Tabelas}61:BEGIN
                         DoFunctionNumber(3);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
{F9 Caracteristicas}67:BEGIN
                         Funcao:=2;
                         DesignCaracteristicasScreen;
                       END;
                  END; { End case tecla }
                END; { End square number 10 }
             11:BEGIN  { Inits the case of square number 11 }
                  CASE Tecla OF
              {Cima}72:BEGIN
                         DesignSquareNumber(11,FALSE);
                         DesignSquareNumber(7,TRUE);
                         Quadrado:=7;
                       END;
            {Esquer}75:BEGIN
                         DesignSquareNumber(11,FALSE);
                         DesignSquareNumber(10,TRUE);
                         Quadrado:=10;
                       END;
            {Direit}77:BEGIN
                         DesignSquareNumber(11,FALSE);
                         DesignSquareNumber(12,TRUE);
                         Quadrado:=12;
                       END;
             {Baixo}80:BEGIN
                         DesignSquareNumber(11,FALSE);
                         DesignSquareNumber(15,TRUE);
                         Quadrado:=15;
                       END;
             {Enter}13:BEGIN
                         InsertSquareNumber(11);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         {F1 Tabela}59:BEGIN
                         Funcao:=1;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
        {F3 Tabelas}61:BEGIN
                         DoFunctionNumber(3);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
{F9 Caracteristicas}67:BEGIN
                         Funcao:=2;
                         DesignCaracteristicasScreen;
                       END;
                  END; { End case tecla }
                END; { End square number 11 }
             12:BEGIN  { Inits the case of square number 12 }
                  CASE Tecla OF
              {Cima}72:BEGIN
                         DesignSquareNumber(12,FALSE);
                         DesignSquareNumber(8,TRUE);
                         Quadrado:=8;
                       END;
            {Esquer}75:BEGIN
                         DesignSquareNumber(12,FALSE);
                         DesignSquareNumber(11,TRUE);
                         Quadrado:=11;
                       END;
            {Direit}77:BEGIN
                         DesignSquareNumber(12,TRUE);
                         Quadrado:=12;
                       END;
             {Baixo}80:BEGIN
                         DesignSquareNumber(12,FALSE);
                         DesignSquareNumber(16,TRUE);
                         Quadrado:=16;
                       END;
             {Enter}13:BEGIN
                         InsertSquareNumber(12);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         {F1 Tabela}59:BEGIN
                         Funcao:=1;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
        {F3 Tabelas}61:BEGIN
                         DoFunctionNumber(3);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
{F9 Caracteristicas}67:BEGIN
                         Funcao:=2;
                         DesignCaracteristicasScreen;
                       END;
                  END; { End case tecla }
                END; { End square number 12 }
             13:BEGIN  { Inits the case of square number 13 }
                  CASE Tecla OF
              {Cima}72:BEGIN
                         DesignSquareNumber(13,FALSE);
                         DesignSquareNumber(9,TRUE);
                         Quadrado:=9;
                       END;
            {Esquer}75:BEGIN
                         DesignSquareNumber(13,TRUE);
                         Quadrado:=13;
                       END;
            {Direit}77:BEGIN
                         DesignSquareNumber(13,FALSE);
                         DesignSquareNumber(14,TRUE);
                         Quadrado:=14;
                       END;
             {Baixo}80:BEGIN
                         DesignSquareNumber(13,FALSE);
                         DesignSquareNumber(17,TRUE);
                         Quadrado:=17;
                       END;
             {Enter}13:BEGIN
                         InsertSquareNumber(13);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         {F1 Tabela}59:BEGIN
                         Funcao:=1;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
        {F3 Tabelas}61:BEGIN
                         DoFunctionNumber(3);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
{F9 Caracteristicas}67:BEGIN
                         Funcao:=2;
                         DesignCaracteristicasScreen;
                       END;
                  END; { End case tecla }
                END; { End square number 13 }
             14:BEGIN  { Inits the case of square number 14 }
                  CASE Tecla OF
              {Cima}72:BEGIN
                         DesignSquareNumber(14,FALSE);
                         DesignSquareNumber(10,TRUE);
                         Quadrado:=10;
                       END;
            {Esquer}75:BEGIN
                         DesignSquareNumber(14,FALSE);
                         DesignSquareNumber(13,TRUE);
                         Quadrado:=13;
                       END;
            {Direit}77:BEGIN
                         DesignSquareNumber(14,FALSE);
                         DesignSquareNumber(15,TRUE);
                         Quadrado:=15;
                       END;
             {Baixo}80:BEGIN
                         DesignSquareNumber(14,FALSE);
                         DesignSquareNumber(18,TRUE);
                         Quadrado:=18;
                       END;
             {Enter}13:BEGIN
                         InsertSquareNumber(14);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         {F1 Tabela}59:BEGIN
                         Funcao:=1;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
        {F3 Tabelas}61:BEGIN
                         DoFunctionNumber(3);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
{F9 Caracteristicas}67:BEGIN
                         Funcao:=2;
                         DesignCaracteristicasScreen;
                       END;
                  END; { End case tecla }
                END; { End square number 14 }
             15:BEGIN  { Inits the case of square number 15 }
                  CASE Tecla OF
              {Cima}72:BEGIN
                         DesignSquareNumber(15,FALSE);
                         DesignSquareNumber(11,TRUE);
                         Quadrado:=11;
                       END;
            {Esquer}75:BEGIN
                         DesignSquareNumber(15,FALSE);
                         DesignSquareNumber(14,TRUE);
                         Quadrado:=14;
                       END;
            {Direit}77:BEGIN
                         DesignSquareNumber(15,FALSE);
                         DesignSquareNumber(16,TRUE);
                         Quadrado:=16;
                       END;
             {Baixo}80:BEGIN
                         DesignSquareNumber(15,FALSE);
                         DesignSquareNumber(19,TRUE);
                         Quadrado:=19;
                       END;
             {Enter}13:BEGIN
                         InsertSquareNumber(15);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         {F1 Tabela}59:BEGIN
                         Funcao:=1;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
        {F3 Tabelas}61:BEGIN
                         DoFunctionNumber(3);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
{F9 Caracteristicas}67:BEGIN
                         Funcao:=2;
                         DesignCaracteristicasScreen;
                       END;
                  END; { End case tecla }
                END; { End square number 15 }
             16:BEGIN  { Inits the case of square number 16 }
                  CASE Tecla OF
              {Cima}72:BEGIN
                         DesignSquareNumber(16,FALSE);
                         DesignSquareNumber(12,TRUE);
                         Quadrado:=12;
                       END;
            {Esquer}75:BEGIN
                         DesignSquareNumber(16,FALSE);
                         DesignSquareNumber(15,TRUE);
                         Quadrado:=15;
                       END;
            {Direit}77:BEGIN
                         DesignSquareNumber(16,TRUE);
                         Quadrado:=16;
                       END;
             {Baixo}80:BEGIN
                         DesignSquareNumber(16,FALSE);
                         DesignSquareNumber(20,TRUE);
                         Quadrado:=20;
                       END;
             {Enter}13:BEGIN
                         InsertSquareNumber(16);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         {F1 Tabela}59:BEGIN
                         Funcao:=1;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
        {F3 Tabelas}61:BEGIN
                         DoFunctionNumber(3);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
{F9 Caracteristicas}67:BEGIN
                         Funcao:=2;
                         DesignCaracteristicasScreen;
                       END;
                  END; { End case tecla }
                END; { End square number 16 }
             17:BEGIN  { Inits the case of square number 17 }
                  CASE Tecla OF
              {Cima}72:BEGIN
                         DesignSquareNumber(17,FALSE);
                         DesignSquareNumber(13,TRUE);
                         Quadrado:=13;
                       END;
            {Esquer}75:BEGIN
                         DesignSquareNumber(17,TRUE);
                         Quadrado:=17;
                       END;
            {Direit}77:BEGIN
                         DesignSquareNumber(17,FALSE);
                         DesignSquareNumber(18,TRUE);
                         Quadrado:=18;
                       END;
             {Baixo}80:BEGIN
                         DesignSquareNumber(17,FALSE);
                         DesignSquareNumber(21,TRUE);
                         Quadrado:=21;
                       END;
             {Enter}13:BEGIN
                         InsertSquareNumber(17);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         {F1 Tabela}59:BEGIN
                         Funcao:=1;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
        {F3 Tabelas}61:BEGIN
                         DoFunctionNumber(3);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
{F9 Caracteristicas}67:BEGIN
                         Funcao:=2;
                         DesignCaracteristicasScreen;
                       END;
                  END; { End case tecla }
                END; { End square number 17 }
             18:BEGIN  { Inits the case of square number 18 }
                  CASE Tecla OF
              {Cima}72:BEGIN
                         DesignSquareNumber(18,FALSE);
                         DesignSquareNumber(14,TRUE);
                         Quadrado:=14;
                       END;
            {Esquer}75:BEGIN
                         DesignSquareNumber(18,FALSE);
                         DesignSquareNumber(17,TRUE);
                         Quadrado:=17;
                       END;
            {Direit}77:BEGIN
                         DesignSquareNumber(18,FALSE);
                         DesignSquareNumber(19,TRUE);
                         Quadrado:=19;
                       END;
             {Baixo}80:BEGIN
                         DesignSquareNumber(18,FALSE);
                         DesignSquareNumber(22,TRUE);
                         Quadrado:=22;
                       END;
             {Enter}13:BEGIN
                         InsertSquareNumber(18);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         {F1 Tabela}59:BEGIN
                         Funcao:=1;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
        {F3 Tabelas}61:BEGIN
                         DoFunctionNumber(3);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
{F9 Caracteristicas}67:BEGIN
                         Funcao:=2;
                         DesignCaracteristicasScreen;
                       END;
                  END; { End case tecla }
                END; { End square number 18 }
             19:BEGIN  { Inits the case of square number 19 }
                  CASE Tecla OF
              {Cima}72:BEGIN
                         DesignSquareNumber(19,FALSE);
                         DesignSquareNumber(15,TRUE);
                         Quadrado:=15;
                       END;
            {Esquer}75:BEGIN
                         DesignSquareNumber(19,FALSE);
                         DesignSquareNumber(18,TRUE);
                         Quadrado:=18;
                       END;
            {Direit}77:BEGIN
                         DesignSquareNumber(19,FALSE);
                         DesignSquareNumber(20,TRUE);
                         Quadrado:=20;
                       END;
             {Baixo}80:BEGIN
                         DesignSquareNumber(19,FALSE);
                         DesignSquareNumber(23,TRUE);
                         Quadrado:=23;
                       END;
             {Enter}13:BEGIN
                         InsertSquareNumber(19);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         {F1 Tabela}59:BEGIN
                         Funcao:=1;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
        {F3 Tabelas}61:BEGIN
                         DoFunctionNumber(3);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
{F9 Caracteristicas}67:BEGIN
                         Funcao:=2;
                         DesignCaracteristicasScreen;
                       END;
                  END; { End case tecla }
                END; { End square number 19 }
             20:BEGIN  { Inits the case of square number 20 }
                  CASE Tecla OF
              {Cima}72:BEGIN
                         DesignSquareNumber(20,FALSE);
                         DesignSquareNumber(16,TRUE);
                         Quadrado:=16;
                       END;
            {Esquer}75:BEGIN
                         DesignSquareNumber(20,FALSE);
                         DesignSquareNumber(19,TRUE);
                         Quadrado:=19;
                       END;
            {Direit}77:BEGIN
                         DesignSquareNumber(20,TRUE);
                         Quadrado:=20;
                       END;
             {Baixo}80:BEGIN
                         DesignSquareNumber(20,FALSE);
                         DesignSquareNumber(24,TRUE);
                         Quadrado:=24;
                       END;
             {Enter}13:BEGIN
                         InsertSquareNumber(20);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         {F1 Tabela}59:BEGIN
                         Funcao:=1;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
        {F3 Tabelas}61:BEGIN
                         DoFunctionNumber(3);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
{F9 Caracteristicas}67:BEGIN
                         Funcao:=2;
                         DesignCaracteristicasScreen;
                       END;
                  END; { End case tecla }
                END; { End square number 20 }
             21:BEGIN  { Inits the case of square number 21 }
                  CASE Tecla OF
              {Cima}72:BEGIN
                         DesignSquareNumber(21,FALSE);
                         DesignSquareNumber(17,TRUE);
                         Quadrado:=17;
                       END;
            {Esquer}75:BEGIN
                         DesignSquareNumber(21,TRUE);
                         Quadrado:=21;
                       END;
            {Direit}77:BEGIN
                         DesignSquareNumber(21,FALSE);
                         DesignSquareNumber(22,TRUE);
                         Quadrado:=22;
                       END;
             {Baixo}80:BEGIN
                         DesignSquareNumber(21,FALSE);
                         DesignSquareNumber(25,TRUE);
                         Quadrado:=25;
                       END;
             {Enter}13:BEGIN
                         InsertSquareNumber(21);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         {F1 Tabela}59:BEGIN
                         Funcao:=1;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
        {F3 Tabelas}61:BEGIN
                         DoFunctionNumber(3);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
{F9 Caracteristicas}67:BEGIN
                         Funcao:=2;
                         DesignCaracteristicasScreen;
                       END;
                  END; { End case tecla }
                END; { End square number 21 }
             22:BEGIN  { Inits the case of square number 22 }
                  CASE Tecla OF
              {Cima}72:BEGIN
                         DesignSquareNumber(22,FALSE);
                         DesignSquareNumber(18,TRUE);
                         Quadrado:=18;
                       END;
            {Esquer}75:BEGIN
                         DesignSquareNumber(22,FALSE);
                         DesignSquareNumber(21,TRUE);
                         Quadrado:=21;
                       END;
            {Direit}77:BEGIN
                         DesignSquareNumber(22,FALSE);
                         DesignSquareNumber(23,TRUE);
                         Quadrado:=23;
                       END;
             {Baixo}80:BEGIN
                         DesignSquareNumber(22,FALSE);
                         DesignSquareNumber(26,TRUE);
                         Quadrado:=26;
                       END;
             {Enter}13:BEGIN
                         InsertSquareNumber(22);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         {F1 Tabela}59:BEGIN
                         Funcao:=1;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
        {F3 Tabelas}61:BEGIN
                         DoFunctionNumber(3);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
{F9 Caracteristicas}67:BEGIN
                         Funcao:=2;
                         DesignCaracteristicasScreen;
                       END;
                  END; { End case tecla }
                END; { End square number 22 }
             23:BEGIN  { Inits the case of square number 23 }
                  CASE Tecla OF
              {Cima}72:BEGIN
                         DesignSquareNumber(23,FALSE);
                         DesignSquareNumber(19,TRUE);
                         Quadrado:=19;
                       END;
            {Esquer}75:BEGIN
                         DesignSquareNumber(23,FALSE);
                         DesignSquareNumber(22,TRUE);
                         Quadrado:=22;
                       END;
            {Direit}77:BEGIN
                         DesignSquareNumber(23,FALSE);
                         DesignSquareNumber(24,TRUE);
                         Quadrado:=24;
                       END;
             {Baixo}80:BEGIN
                         DesignSquareNumber(23,FALSE);
                         DesignSquareNumber(27,TRUE);
                         Quadrado:=27;
                       END;
             {Enter}13:BEGIN
                         InsertSquareNumber(23);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         {F1 Tabela}59:BEGIN
                         Funcao:=1;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
        {F3 Tabelas}61:BEGIN
                         DoFunctionNumber(3);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
{F9 Caracteristicas}67:BEGIN
                         Funcao:=2;
                         DesignCaracteristicasScreen;
                       END;
                  END; { End case tecla }
                END; { End square number 13 }
             24:BEGIN  { Inits the case of square number 24 }
                  CASE Tecla OF
              {Cima}72:BEGIN
                         DesignSquareNumber(24,FALSE);
                         DesignSquareNumber(20,TRUE);
                         Quadrado:=20;
                       END;
            {Esquer}75:BEGIN
                         DesignSquareNumber(24,FALSE);
                         DesignSquareNumber(23,TRUE);
                         Quadrado:=23;
                       END;
            {Direit}77:BEGIN
                         DesignSquareNumber(24,TRUE);
                         Quadrado:=24;
                       END;
             {Baixo}80:BEGIN
                         DesignSquareNumber(24,FALSE);
                         DesignSquareNumber(28,TRUE);
                         Quadrado:=28;
                       END;
             {Enter}13:BEGIN
                         InsertSquareNumber(24);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         {F1 Tabela}59:BEGIN
                         Funcao:=1;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
        {F3 Tabelas}61:BEGIN
                         DoFunctionNumber(3);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
{F9 Caracteristicas}67:BEGIN
                         Funcao:=2;
                         DesignCaracteristicasScreen;
                       END;
                  END; { End case tecla }
                END; { End square number 24 }
             25:BEGIN  { Inits the case of square number 25 }
                  CASE Tecla OF
              {Cima}72:BEGIN
                         DesignSquareNumber(25,FALSE);
                         DesignSquareNumber(21,TRUE);
                         Quadrado:=21;
                       END;
            {Esquer}75:BEGIN
                         DesignSquareNumber(25,TRUE);
                         Quadrado:=25;
                       END;
            {Direit}77:BEGIN
                         DesignSquareNumber(25,FALSE);
                         DesignSquareNumber(26,TRUE);
                         Quadrado:=26;
                       END;
             {Baixo}80:BEGIN
                         DesignSquareNumber(25,FALSE);
                         DesignSquareNumber(29,TRUE);
                         Quadrado:=29;
                       END;
             {Enter}13:BEGIN
                         InsertSquareNumber(25);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         {F1 Tabela}59:BEGIN
                         Funcao:=1;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
        {F3 Tabelas}61:BEGIN
                         DoFunctionNumber(3);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
{F9 Caracteristicas}67:BEGIN
                         Funcao:=2;
                         DesignCaracteristicasScreen;
                       END;
                  END; { End case tecla }
                END; { End square number 25 }
             26:BEGIN  { Inits the case of square number 26 }
                  CASE Tecla OF
              {Cima}72:BEGIN
                         DesignSquareNumber(26,FALSE);
                         DesignSquareNumber(22,TRUE);
                         Quadrado:=22;
                       END;
            {Esquer}75:BEGIN
                         DesignSquareNumber(26,FALSE);
                         DesignSquareNumber(25,TRUE);
                         Quadrado:=25;
                       END;
            {Direit}77:BEGIN
                         DesignSquareNumber(26,FALSE);
                         DesignSquareNumber(27,TRUE);
                         Quadrado:=27;
                       END;
             {Baixo}80:BEGIN
                         DesignSquareNumber(26,FALSE);
                         DesignSquareNumber(30,TRUE);
                         Quadrado:=30;
                       END;
             {Enter}13:BEGIN
                         InsertSquareNumber(26);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         {F1 Tabela}59:BEGIN
                         Funcao:=1;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
        {F3 Tabelas}61:BEGIN
                         DoFunctionNumber(3);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
{F9 Caracteristicas}67:BEGIN
                         Funcao:=2;
                         DesignCaracteristicasScreen;
                       END;
                  END; { End case tecla }
                END; { End square number 26 }
             27:BEGIN  { Inits the case of square number 27 }
                  CASE Tecla OF
              {Cima}72:BEGIN
                         DesignSquareNumber(27,FALSE);
                         DesignSquareNumber(23,TRUE);
                         Quadrado:=23;
                       END;
            {Esquer}75:BEGIN
                         DesignSquareNumber(27,FALSE);
                         DesignSquareNumber(26,TRUE);
                         Quadrado:=26;
                       END;
            {Direit}77:BEGIN
                         DesignSquareNumber(27,FALSE);
                         DesignSquareNumber(28,TRUE);
                         Quadrado:=28;
                       END;
             {Baixo}80:BEGIN
                         DesignSquareNumber(27,FALSE);
                         DesignSquareNumber(31,TRUE);
                         Quadrado:=31;
                       END;
             {Enter}13:BEGIN
                         InsertSquareNumber(27);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         {F1 Tabela}59:BEGIN
                         Funcao:=1;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
        {F3 Tabelas}61:BEGIN
                         DoFunctionNumber(3);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
{F9 Caracteristicas}67:BEGIN
                         Funcao:=2;
                         DesignCaracteristicasScreen;
                       END;
                  END; { End case tecla }
                END; { End square number 27 }
             28:BEGIN  { Inits the case of square number 28 }
                  CASE Tecla OF
              {Cima}72:BEGIN
                         DesignSquareNumber(28,FALSE);
                         DesignSquareNumber(24,TRUE);
                         Quadrado:=24;
                       END;
            {Esquer}75:BEGIN
                         DesignSquareNumber(28,FALSE);
                         DesignSquareNumber(27,TRUE);
                         Quadrado:=27;
                       END;
            {Direit}77:BEGIN
                         DesignSquareNumber(28,TRUE);
                         Quadrado:=28;
                       END;
             {Baixo}80:BEGIN
                         DesignSquareNumber(28,FALSE);
                         DesignSquareNumber(32,TRUE);
                         Quadrado:=32;
                       END;
             {Enter}13:BEGIN
                         InsertSquareNumber(28);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         {F1 Tabela}59:BEGIN
                         Funcao:=1;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
        {F3 Tabelas}61:BEGIN
                         DoFunctionNumber(3);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
{F9 Caracteristicas}67:BEGIN
                         Funcao:=2;
                         DesignCaracteristicasScreen;
                       END;
                  END; { End case tecla }
                END; { End square number 28 }
             29:BEGIN  { Inits the case of square number 29 }
                  CASE Tecla OF
              {Cima}72:BEGIN
                         DesignSquareNumber(29,FALSE);
                         DesignSquareNumber(25,TRUE);
                         Quadrado:=25;
                       END;
            {Esquer}75:BEGIN
                         DesignSquareNumber(29,TRUE);
                         Quadrado:=29;
                       END;
            {Direit}77:BEGIN
                         DesignSquareNumber(29,FALSE);
                         DesignSquareNumber(30,TRUE);
                         Quadrado:=30;
                       END;
             {Baixo}80:BEGIN
                         DesignSquareNumber(29,TRUE);
                         Quadrado:=29;
                       END;
             {Enter}13:BEGIN
                         InsertSquareNumber(29);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         {F1 Tabela}59:BEGIN
                         Funcao:=1;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
        {F3 Tabelas}61:BEGIN
                         DoFunctionNumber(3);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
{F9 Caracteristicas}67:BEGIN
                         Funcao:=2;
                         DesignCaracteristicasScreen;
                       END;
                  END; { End case tecla }
                END; { End square number 29 }
             30:BEGIN  { Inits the case of square number 30 }
                  CASE Tecla OF
              {Cima}72:BEGIN
                         DesignSquareNumber(30,FALSE);
                         DesignSquareNumber(26,TRUE);
                         Quadrado:=26;
                       END;
            {Esquer}75:BEGIN
                         DesignSquareNumber(30,FALSE);
                         DesignSquareNumber(29,TRUE);
                         Quadrado:=29;
                       END;
            {Direit}77:BEGIN
                         DesignSquareNumber(30,FALSE);
                         DesignSquareNumber(31,TRUE);
                         Quadrado:=31;
                       END;
             {Baixo}80:BEGIN
                         DesignSquareNumber(30,TRUE);
                         Quadrado:=30;
                       END;
             {Enter}13:BEGIN
                         InsertSquareNumber(30);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         {F1 Tabela}59:BEGIN
                         Funcao:=1;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
        {F3 Tabelas}61:BEGIN
                         DoFunctionNumber(3);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
{F9 Caracteristicas}67:BEGIN
                         Funcao:=2;
                         DesignCaracteristicasScreen;
                       END;
                  END; { End case tecla }
                END; { End square number 30 }
             31:BEGIN  { Inits the case of square number 31 }
                  CASE Tecla OF
              {Cima}72:BEGIN
                         DesignSquareNumber(31,FALSE);
                         DesignSquareNumber(27,TRUE);
                         Quadrado:=27;
                       END;
            {Esquer}75:BEGIN
                         DesignSquareNumber(31,FALSE);
                         DesignSquareNumber(30,TRUE);
                         Quadrado:=30;
                       END;
            {Direit}77:BEGIN
                         DesignSquareNumber(31,FALSE);
                         DesignSquareNumber(32,TRUE);
                         Quadrado:=32;
                       END;
             {Baixo}80:BEGIN
                         DesignSquareNumber(31,TRUE);
                         Quadrado:=31;
                       END;
             {Enter}13:BEGIN
                         InsertSquareNumber(31);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         {F1 Tabela}59:BEGIN
                         Funcao:=1;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
        {F3 Tabelas}61:BEGIN
                         DoFunctionNumber(3);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
{F9 Caracteristicas}67:BEGIN
                         Funcao:=2;
                         DesignCaracteristicasScreen;
                       END;
                  END; { End case tecla }
                END; { End square number 31 }
             32:BEGIN  { Inits the case of square number 32 }
                  CASE Tecla OF
              {Cima}72:BEGIN
                         DesignSquareNumber(32,FALSE);
                         DesignSquareNumber(28,TRUE);
                         Quadrado:=28;
                       END;
            {Esquer}75:BEGIN
                         DesignSquareNumber(32,FALSE);
                         DesignSquareNumber(31,TRUE);
                         Quadrado:=31;
                       END;
            {Direit}77:BEGIN
                         DesignSquareNumber(32,TRUE);
                         Quadrado:=32;
                       END;
             {Baixo}80:BEGIN
                         DesignSquareNumber(32,TRUE);
                         Quadrado:=32;
                       END;
             {Enter}13:BEGIN
                         InsertSquareNumber(32);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         {F1 Tabela}59:BEGIN
                         Funcao:=1;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
        {F3 Tabelas}61:BEGIN
                         DoFunctionNumber(3);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
{F9 Caracteristicas}67:BEGIN
                         Funcao:=2;
                         DesignCaracteristicasScreen;
                       END;
                  END; { End case tecla }
                END; { End square number 32 }
            END; { End case quadrado }
          END; { End introducing function }
        2:BEGIN  { Inits the case of caracteristicas function }
            CASE Tecla OF
         { 1 }49:BEGIN
                   Biestavel:=1;
                   SetColor(14);
                   SetTextStyle(6,0,1);
                   OutTextXY(80,325,'JK');
                   SetColor(7);
                   SetTextStyle(6,0,1);
                   OutTextXY(80,345,'SR');
                   SetTextStyle(6,0,1);
                   OutTextXY(80,365,'D');
                   SetTextStyle(6,0,1);
                   OutTextXY(80,385,'T');
                 END;
         { 2 }50:BEGIN
                   Biestavel:=2;
                   SetColor(14);
                   SetTextStyle(6,0,1);
                   OutTextXY(80,345,'SR');
                   SetColor(7);
                   SetTextStyle(6,0,1);
                   OutTextXY(80,325,'JK');
                   SetTextStyle(6,0,1);
                   OutTextXY(80,365,'D');
                   SetTextStyle(6,0,1);
                   OutTextXY(80,385,'T');
                 END;
         { 3 }51:BEGIN
                   Biestavel:=3;
                   SetColor(14);
                   SetTextStyle(6,0,1);
                   OutTextXY(80,365,'D');
                   SetColor(7);
                   SetTextStyle(6,0,1);
                   OutTextXY(80,325,'JK');
                   SetTextStyle(6,0,1);
                   OutTextXY(80,345,'SR');
                   SetTextStyle(6,0,1);
                   OutTextXY(80,385,'T');
                 END;
         { 4 }52:BEGIN
                   Biestavel:=4;
                   SetColor(14);
                   SetTextStyle(6,0,1);
                   OutTextXY(80,385,'T');
                   SetColor(7);
                   SetTextStyle(6,0,1);
                   OutTextXY(80,325,'JK');
                   SetTextStyle(6,0,1);
                   OutTextXY(80,345,'SR');
                   SetTextStyle(6,0,1);
                   OutTextXY(80,365,'D');
                 END;
      { F9 }  67:BEGIN
                   Funcao:=1;
                   DesignFirstScreen(Quadrado,TRUE);
                 END;
            END; { End case tecla }
          END; { End caracteristicas function }
        3:BEGIN  { Inits the case of diagrama de estados function }
            CASE Tecla OF
  {F1 Tabela} 59:BEGIN
                   DoFunctionNumber(1);
                 END;
{F2 Diagrama} 60:BEGIN
                   Funcao:=3;
                 END;
  {F3 Tabelas}61:BEGIN
                   DoFunctionNumber(3);
                 END;
 {F4 Circuito}62:BEGIN
                   DoFunctionNumber(4);
                 END;
   {F9 Simula}67:BEGIN
                   Funcao:=4;
                   DesignSimulacao;
                 END;
       { Esc }27:BEGIN
                   Finish:=TRUE;
                 END;
            END; { End case tecla }
          END; { End diagrama de estados function }
        4:BEGIN  { Inits the case of simulacao of diagrama de estados }
            CASE Tecla OF
         { 0 }48:BEGIN
                   VAL(EstActual,EstActualN,Error);
                   IF Tabela_Estados_Letras[EstActualN,1]<>'' THEN
                     BEGIN
                       CircActual:=Converte(EstActual);
                       VAL(CircActual,CircActualN,Error);
                       DesignCircle(CircActualN,15);
                       EstActual:=QueEstadoEsta(EstActual,1);
                       CircActual:=Converte(EstActual);
                       VAL(CircActual,CircActualN,Error);
                       DesignCircle(CircActualN,9);
                     END;
                 END;
         { 1 }49:BEGIN
                   VAL(EstActual,EstActualN,Error);
                   IF Tabela_Estados_Letras[EstActualN,2]<>'' THEN
                     BEGIN
                       CircActual:=Converte(EstActual);
                       VAL(CircActual,CircActualN,Error);
                       DesignCircle(CircActualN,15);
                       EstActual:=QueEstadoEsta(EstActual,2);
                       CircActual:=Converte(EstActual);
                       VAL(CircActual,CircActualN,Error);
                       DesignCircle(CircActualN,9);
                     END;
                 END;
         { 2 }50:BEGIN
                   VAL(EstActual,EstActualN,Error);
                   IF Tabela_Estados_Letras[EstActualN,3]<>'' THEN
                     BEGIN
                       CircActual:=Converte(EstActual);
                       VAL(CircActual,CircActualN,Error);
                       DesignCircle(CircActualN,15);
                       EstActual:=QueEstadoEsta(EstActual,3);
                       CircActual:=Converte(EstActual);
                       VAL(CircActual,CircActualN,Error);
                       DesignCircle(CircActualN,9);
                     END;
                 END;
         { 3 }51:BEGIN
                   VAL(EstActual,EstActualN,Error);
                   IF Tabela_Estados_Letras[EstActualN,4]<>'' THEN
                     BEGIN
                       CircActual:=Converte(EstActual);
                       VAL(CircActual,CircActualN,Error);
                       DesignCircle(CircActualN,15);
                       EstActual:=QueEstadoEsta(EstActual,4);
                       CircActual:=Converte(EstActual);
                       VAL(CircActual,CircActualN,Error);
                       DesignCircle(CircActualN,9);
                     END;
                 END;
   {F9 Simula}67:BEGIN
                   Funcao:=3;
                   DesignDiagramScreen;
                 END;
            END; { End case tecla }
          END; { End simulacao }
        5:BEGIN  { Inits the case of tabelas de estados function }
            CASE Ecra OF
              1:BEGIN
                  CASE Tecla OF
        {F1 Tabela} 59:BEGIN
                         DoFunctionNumber(1);
                       END;
       {F3 Tabelas} 61:BEGIN
                         Funcao:=5;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         { Direita }77:BEGIN
                         Ecra:=Ecra+1;
                         DoFunctionNumber(4+Ecra);
                       END;
        { Esquerda }75:BEGIN
                         Ecra:=EcraMax;
                         DoFunctionNumber(4+Ecra);
                       END;
                  END; { End Case tecla }
                END; { End case ecra number 1 }
              2:BEGIN
                  CASE Tecla OF
        {F1 Tabela} 59:BEGIN
                         DoFunctionNumber(1);
                       END;
       {F3 Tabelas} 61:BEGIN
                         Funcao:=5;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         { Direita }77:BEGIN
                         Ecra:=Ecra+1;
                         IF Ecra=EcraMax+1 THEN Ecra:=1;
                         DoFunctionNumber(4+Ecra);
                       END;
        { Esquerda }75:BEGIN
                         Ecra:=Ecra-1;
                         DoFunctionNumber(4+Ecra);
                       END;
                  END; { End Case tecla }
                END; { End case ecra number 2 }
              3:BEGIN
                  CASE Tecla OF
        {F1 Tabela} 59:BEGIN
                         DoFunctionNumber(1);
                       END;
       {F3 Tabelas} 61:BEGIN
                         Funcao:=5;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         { Direita }77:BEGIN
                         Ecra:=Ecra+1;
                         IF Ecra=EcraMax+1 THEN Ecra:=1;
                         DoFunctionNumber(4+Ecra);
                       END;
        { Esquerda }75:BEGIN
                         Ecra:=Ecra-1;
                         DoFunctionNumber(4+Ecra);
                       END;
                  END; { End Case tecla }
                END; { End case ecra number 3 }
              4:BEGIN
                  CASE Tecla OF
        {F1 Tabela} 59:BEGIN
                         DoFunctionNumber(1);
                       END;
       {F3 Tabelas} 61:BEGIN
                         Funcao:=5;
                       END;
       {F2 Diagrama}60:BEGIN
                         DoFunctionNumber(2);
                       END;
       {F4 Circuito}62:BEGIN
                         DoFunctionNumber(4);
                       END;
             { Esc }27:BEGIN
                         Finish:=TRUE;
                       END;
         { Direita }77:BEGIN
                         Ecra:=Ecra+1;
                         IF Ecra=EcraMax+1 THEN Ecra:=1;
                         DoFunctionNumber(4+Ecra);
                       END;
        { Esquerda }75:BEGIN
                         Ecra:=Ecra-1;
                         DoFunctionNumber(4+Ecra);
                       END;
                  END; { End Case tecla }
                END; { End case ecra number 4 }
              END; { End case ecra }
          END; { End tabelas de estados function }
        6:BEGIN  { Inits the case of circuito function }
            CASE Tecla OF
  {F1 Tabela} 59:BEGIN
                   DoFunctionNumber(1);
                 END;
{F4 Circuito} 62:BEGIN
                   Funcao:=6;
                 END;
 {F2 Diagrama}60:BEGIN
                   DoFunctionNumber(2);
                 END;
  {F3 Tabelas}61:BEGIN
                   DoFunctionNumber(3);
                 END;
       { Esc }27:BEGIN
                   Finish:=TRUE;
                 END;
            END; { End case tecla }
          END; { End circuito function }
      END; { End case funcao }
      Until Finish;
    END; { CommandTable}
END.