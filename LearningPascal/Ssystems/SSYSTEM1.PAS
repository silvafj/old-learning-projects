
  UNIT SSYSTEM1;

    INTERFACE

  USES
     CRT,GRAPH,GRAPHICS;

{** Tipos **}
  TYPE
     Esta = 1..8;
     Entr  = 1..4;
     Tab_Est_Let  = ARRAY [Esta,Entr] OF STRING[1];
     Tab_Est_Sai  = ARRAY [Esta,Entr] OF STRING[1];
     Tab_Est_Bin4 = ARRAY [1..4,1..4] OF STRING[2];
     Tab_Est_Bin8 = ARRAY [1..4,1..4] OF STRING[3];
     Tab_Sim_Bin1 = ARRAY [1..4,1..4] OF STRING[1];
     Tab_Sim_Bin2 = ARRAY [1..4,1..4] OF STRING[1];
     Tab_Sim_Bin3 = ARRAY [1..4,1..4] OF STRING[1];
     Tab_Sim_Bin4 = ARRAY [1..4,1..4] OF STRING[1];
     Tab_Sim_Bin5 = ARRAY [1..4,1..4] OF STRING[1];
     Tab_Sim_Bin6 = ARRAY [1..4,1..4] OF STRING[1];

{** Vari veis **}
  VAR
     Tabela_Estados_Letras : Tab_Est_Let;
     Tabela_Estados_Saidas : Tab_Est_Sai;
     Tabela_Estados_Bin4   : Tab_Est_Bin4;
     Tabela_Estados_Bin8   : Tab_Est_Bin8;
     Tabela_Simplif_Bin1   : Tab_Sim_Bin1;
     Tabela_Simplif_Bin2   : Tab_Sim_Bin2;
     Tabela_Simplif_Bin3   : Tab_Sim_Bin3;
     Tabela_Simplif_Bin4   : Tab_Sim_Bin4;
     Tabela_Simplif_Bin5   : Tab_Sim_Bin5;
     Tabela_Simplif_Bin6   : Tab_Sim_Bin6;
     Finish:BOOLEAN;
     A,B:INTEGER;
     Funcao:BYTE;
     Quadrado:BYTE;
     Tecla:BYTE;
     Ecra:BYTE;
     EcraMax:BYTE;
     StrLetras:STRING;
     StrNumeros:STRING;
     StrCirculos:STRING;
     Estados:BYTE;
     Biestavel:BYTE; { 1-JK; 2-SR; 3-D; 4-T }
     TipoCircuito:STRING;
     Erro:STRING;
     VEst1,VEst2,VEst3,VEst4:STRING;
     VIn1,VIn2,VIn3,VIn4:STRING;
     CircActual,EstActual:STRING;
     CircActualN,EstActualN:INTEGER;
     Error:INTEGER;
    IMPLEMENTATION

END.