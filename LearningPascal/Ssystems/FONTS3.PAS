

          {******************************************************}
          {* Program : ---------------------------------------- *}
          {* Unit    : Fonts3                                   *}
          {* Version : 1.0                                      *}
          {* Comment : Unit for suport fonts initialization     *}
          {* Programed by : Fernando Jorge Almeida Silva        *}
          {* Programed under : Borland Pascal 7.0               *}
          {* Address : Juncal - Assequins 3750 µgueda  PORTUGAL *}
          {* Phone   : ( 034 ) 602800                           *}
          {******************************************************}
             {************************************************}
             {*         Copyrigth (c) 1995-97  by            *}
             {*         Bullion MultiSoft Company            *}
             {************************************************}



 UNIT Fonts3;

   INTERFACE

     PROCEDURE SimpFont;
     PROCEDURE TscrFont;

   IMPLEMENTATION

     PROCEDURE SimpFont; EXTERNAL;
       {$L SIMP.OBJ }

     PROCEDURE TscrFont; EXTERNAL;
       {$L TSCR.OBJ }

 BEGIN

 END.

