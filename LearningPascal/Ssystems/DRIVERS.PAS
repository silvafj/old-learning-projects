

          {******************************************************}
          {* Program : ---------------------------------------- *}
          {* Unit    : Drivers                                  *}
          {* Version : 1.0                                      *}
          {* Comment : Unit for suport drivers initialization   *}
          {* Programed by : Fernando Jorge Almeida Silva        *}
          {* Programed under : Borland Pascal 7.0               *}
          {* Address : Juncal - Assequins 3750 µgueda  PORTUGAL *}
          {* Phone   : ( 034 ) 602800                           *}
          {******************************************************}

             {************************************************}
             {*         Copyrigth (c) 1995-97  by            *}
             {*         Bullion MultiSoft Company            *}
             {************************************************}





 UNIT Drivers;

   INTERFACE

     PROCEDURE EgaVgaDriver;

   IMPLEMENTATION

     PROCEDURE EgaVgaDriver; EXTERNAL;
       {$L EGAVGA.OBJ }

 BEGIN

 END.
