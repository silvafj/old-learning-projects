

          {******************************************************}
          {* Program : ---------------------------------------- *}
          {* Unit    : Fonts1                                   *}
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




 UNIT Fonts1;

   INTERFACE

     PROCEDURE GothFont;
     PROCEDURE SansFont;
     PROCEDURE LittFont;
     PROCEDURE TripFont;

   IMPLEMENTATION

     PROCEDURE GothFont; EXTERNAL;
       {$L GOTH.OBJ }

     PROCEDURE SansFont; EXTERNAL;
       {$L SANS.OBJ }

     PROCEDURE LittFont; EXTERNAL;
       {$L LITT.OBJ }

     PROCEDURE TripFont; EXTERNAL;
       {$L TRIP.OBJ }

 BEGIN

 END.
