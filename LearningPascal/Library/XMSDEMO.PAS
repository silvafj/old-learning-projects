{---------------------------- CUT HERE FOR DEMO -------------------}
{***********************************************************************}
PROGRAM XMSDemo1;            { Demonstration of the XMS Unit.           }
                             { Last Updated Dec 10/93, Greg Estabrooks. }
USES CRT,                    { IMPORT Clrscr,Writeln.                   }
     XMS;                    { IMPORT XMSDriver,XMSVer,XMSGetFreeMem,   }
                             { XMSGetLargeBlock,XMSGetMem,XMSMove,      }
                             { XMSError,XMSMovStruct,XMSFreeMem.        }
VAR
   XMSHandle  :WORD;            { Holds the handle of our XMS Area.     }
   MovInf     :XMSMovStruct;    { Move Structure for Moving XMS Blocks. }
BEGIN
  Clrscr;                       { Clear away any screen clutter.        }
  IF XMSDriver THEN             { If XMS Driver installed do demo.      }
  BEGIN
    Write('XMS Driver Version ');   { Show Version Installed.           }
    Writeln(HI(XMSVer),'.',LO(XMSVer),'.',XMSRev,' Installed');
    Writeln('Total Free XMS Memory : ',XMSGetFreeMem,'k');
    Writeln('Largest Free XMS Block: ',XMSGetLargeBlock,'k');
    Writeln;

    Writeln('Attempting to Allocate 16k of XMS');
    XMSHandle := XMSGetMem(16); { Attempt to allocate 16k of XMS.       }
    Writeln('ErrorCode Returned : ',XMSError);
    Writeln('Current free XMS Memory : ',XMSGetFreeMem);
    Writeln;

    Writeln('Saving Screen to XMS.');
    WITH MovInf DO
      BEGIN
        Amount := 4000;         { Length of the Video Screen.           }
        SourceHandle := 0;      { If SourceHandle is 0 then SourceOffset}
                                { Is Interpereted as a SEGMENT:OFFSET   }
                                { into conventional memory.             }
        SourceOffset := PtrToLong(Ptr($B800,0));
        DestHandle := XMSHandle;{ Destination is our XMS block.         }
        DestOffset := 0;
      END;
    XMSMoveBlock(MovInf);
    Writeln('Press <ENTER> to continue.');
    Readln;

    Clrscr;
    Writeln('Press <ENTER> to Restore Screen.');
    Readln;

    WITH MovInf DO
      BEGIN
        Amount := 4000;         { Length of the Video Screen.           }
        SourceHandle := XMSHandle;
        SourceOffset := 0;
        DestHandle := 0;
        DestOffset := PtrToLong(Ptr($B800,0));;
      END;
    XMSMoveBlock(MovInf);
    GotoXY(1,11);
    XMSFreeMem(XMSHandle);      { Free allocate XMS.                    }
    Writeln('Ending Free XMS Memory : ',XMSGetFreeMem,'k');
  END
  ELSE
    Writeln('XMS Driver not Installed!',^G);
  Readln;
END.{XMSDemo1}
{***********************************************************************}

