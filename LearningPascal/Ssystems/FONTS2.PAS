

          {******************************************************}
          {* Program : ---------------------------------------- *}
          {* Unit    : Fonts2                                  *}
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




 UNIT Fonts2;

   INTERFACE

     PROCEDURE BoldFont;
     PROCEDURE EuroFont;
     PROCEDURE LComFont;
     PROCEDURE ScriFont;

   IMPLEMENTATION

     PROCEDURE BoldFont; EXTERNAL;
       {$L BOLD.OBJ }

     PROCEDURE EuroFont; EXTERNAL;
       {$L EURO.OBJ }

     PROCEDURE LComFont; EXTERNAL;
       {$L LCOM.OBJ }

     PROCEDURE ScriFont; EXTERNAL;
       {$L SCRI.OBJ }

 BEGIN

 END.