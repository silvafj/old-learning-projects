                                                                              (*
         BUILD Version 1.0 -- Builds all the units of this library
         Copyright 1995-1997 by Fernando J.A. Silva   ( ^Magico^ )

        |>>>                                                      |>>>
        |                     |>>>          |>>>                  |
        *                     |             |                     *
       / \                    *             *                    / \
      /___\                 _/ \           / \_                 /___\
      [   ]                |/   \_________/   \|                [   ]
      [ I ]                /     \       /     \                [ I ]
      [   ]_ _ _          /       \     /       \          _ _ _[   ]
      [   ] U U |        {#########}   {#########}        | U U [   ]
      [   ]====/          \=======/     \=======/          \====[   ]
      [   ]    |           |   I |_ _ _ _| I   |           |    [   ]
      [___]    |_ _ _ _ _ _|     | U U U |     |_ _ _ _ _ _|    [___]
      \===/  I | U U U U U |     |=======|     | U U U U U | I  \===/
       \=/     |===========| I   | + W + |   I |===========|     \=/
        |  I   |           |     |_______|     |           |   I  |
        |      |           |     |||||||||     |           |      |
        |      |           |   I ||vvvvv|| I   |           |      |
    _-_-|______|-----------|_____||     ||_____|-----------|______|-_-_
       /________\         /______||     ||______\         /________\
      |__________|-------|________\_____/________|-------|__________|

[ This castle came from STEVEN.SULLIVAN@OFFICE.WANG.COM (Steven M Sullivan)  ]
[ and is from Steve's castle collection. By the way I think that was made by ]
[ Jeffrey T. Crites. I don't have sure about that and I don't know him, but  ]
[ if he was the creator of this castle, I think that he is a very artistic   ]
[ guy! Don't you agree with me ???!!!                                        ]

 By the way, when you build all the units (I hope that you know how to build
 all units from this program!!!), check the units for knowledge, they have
 many comments, and good rotines to make good programs. And if you are a very
 attentive and informed guy, you will discover that some rotines that exist
 here, are very optimized rotines based on SWAG (Do you know SWAG, don't
 you ? ) rotines. Of course that I didn't copy the rotines (ok, except one),
 I don't like to copy others programs, I like to learn with them and try to
 do better by myself (ok, if you think that I copy their ideas, you are
 probably rigth, but only their ideas!!!!).

 After this you still don't know me! My name is Fernando J.A. Silva and I'm
 Portuguese (Do you know Portugal? If you don't know if Portugal exists, you
 shouldn't be alive, because you should know that was Portugal that
 discovered Brazil and the maritime passage for India), I'm 18 years old,
 and if you want contact me, to ask something or just talk, you can do that
 for the e-mail bfe2333@mail.telepac.pt or by the ICQ number #1197830 and I'm
 usually in the IRC (irc.telepac.pt or diemen.nl.eu.udernet.org) under the
 nickname "^Magico^" (If you want to know what that means you have just to
 study some portuguese or ask me!!!).

 Finally, if you think that my english is a big piece of confused sentences
 (I don't say bad words), it's better you stop rigth now and don't read my
 programming comments, because I don't want to teach you bad english!!!!!!!
                                                                              *)

{$A+} { Align Data Switch }
{$B-} { Boolean Evaluation Switch }
{$D-} { Debug Information Switch }
{$E-} { Emulation Switch - this doesn't affect a unit only a program }
{$F-} { Force Far Calls Switch }
{$G+} { Generate 80286 Code Switch }
{$I-} { Input/Output-Checking Switch }
{$I Defines.INC} { This file is used to define some conditionals according   }
{ with user preferences.                                                     }
{$L-} { Local Symbol Information Switch }
{$N+} { Numeric Coprocessor Switch }
{$Q-} { Overflow Checking Switch }
{$R-} { Range-Checking Switch }
{$S-} { Stack-Overflow Checking Switch }
{$V-} { Var-String Checking Switch }
{$Y+} { Symbol Reference Information Switch - just afect the Unit size, and }
      { it's very good when you run BP, because you can go directly to the  }
      { line where the source begins! Study, to know more!!!                }
{$M 1024,0,0}
Program BuildUnits;

  Uses
    Math,    { - This Unit controls all the mathematics operations,          }
             { like convertions, numbers calculations, trigonometry, etc     }
    StrsUse, { - This Uunit controls all the strings manipulation, like      }
             { convertions, estetic manipulation, etc                        }
    Files,   { - This Unit is used to do DOS files operations and to do a    }
             { text window to choice files                                   }
    Screen,  { - Make all operations with the screen: write strings, boxes,  }
             { Screen Saving rotines, fades, etc                             }
    Keyboard,{ - Make all keyboard operations: read keys                     }
    Menus,   { - Make all menus operations: This make a PullDown Menu like   }
             { the Borland Pascal(TM) one. I said like, not equal, of course }
             { that you can make it equal, I do it all the time              }
    ReadStr, { - Make all strings reading operations, that is, this is to    }
             { read input informations                                       }
    Windows, { - Make all Windows operations                                 }
    HardWare,{ - Make all system detections, like Processor, Video, Disks    }
    Xms,     { - If you want to use XMS, you have just to use this unit      }
    Ems,     { - Or probably you want to use EMS????                         }
    CDROM,   { - To access the CD-ROM to play a Audio CD or to access files  }
             { this unit is recommend                                        }
    Vesa,    { - Using VESA is a very smart idea                             }
    Tsr;     { - Do you want to make TSR programs ?                          }

  Begin
    { Now, I don't want to do no more things! You have the demo programs, so }
    { it's your time to work!!!!                                             }
    { Just one more thing, all this units depend of the ohers! You can see   }
    { that in the next unit map:                                             }

    {                  MAP                                                   }
    {                      MAP                                               }
    {                            MAP                                         }
  End.