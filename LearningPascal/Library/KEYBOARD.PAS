                                                                               (*
                                                  /
                                       __       //
                                       -\= \=\ //
                                     --=_\=---//=--
                                   -_==/  \/ //\/--
                                    ==/   /O   O\==--
                       _ _ _ _     /_/    \  ]  /--
                      /\ ( (- \    /       ] ] ]==-
                     (\ _\_\_\-\__/     \  (,_,)--
                    (\_/                 \     \-
                    \/      /       (   ( \  ] /)
                    /      (         \   \_ \./ )
                    (       \         \      )  \
                    (       /\_ _ _ _ /---/ /\_  \
                     \     / \     / ____/ /   \  \
                      (   /   )   / /  /__ )   (  )
                      (  )   / __/ '---`       / /
                      \  /   \ \             _/ /
                      ] ]     )_\_         /__\/
                      /_\     ]___\
                     (___)

[ This beautiful unicorn came from: ferch@ucs.ubc.ca (Les Ferch)             ]
[ Probably the best unicorn I've seen so far.                                ]
                                                                               *)
{$A+} { Align Data Switch }
{$B-} { Boolean Evaluation Switch }
{$D-} { Debug Information Switch }
{$E-} { Emulation Switch - this doesn't affect a unit only a program }
{$F+} { Force Far Calls Switch }
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

Unit Keyboard;

{ ************************      INTERFACE      ******************************}
{                         *********************                              }
INTERFACE

{$IFNDEF NoStandardKeyboard}
  Const
{ Keyboard Letters תתתתתתתתתתתתתתתתתתת}{   Key          Function             }
    kb_a                  = $1E61;     {   a                                 }
    kb_Shift_a            = $1E41;     {   A                                 }
    kb_Ctrl_a             = $1E01;     {   ^A      SOH - Start Of Header     }
    kb_Alt_a              = $1E00;     {   ALT+A                             }

    kb_b                  = $3062;     {   b                                 }
    kb_Shift_b            = $3042;     {   B                                 }
    kb_Ctrl_b             = $3002;     {   ^B      STX - Start Of Text       }
    kb_Alt_b              = $3000;     {   ALT+B                             }

    kb_c                  = $2E63;     {   c                                 }
    kb_Shift_c            = $2E43;     {   C                                 }
    kb_Ctrl_c             = $2E03;     {   ^C      ETX - End Of Text         }
    kb_Alt_c              = $2E00;     {   ALT+C                             }

    kb_d                  = $2064;     {   d                                 }
    kb_Shift_d            = $2044;     {   D                                 }
    kb_Ctrl_d             = $2004;     {   ^D      EOT - End Of Transmission }
    kb_Alt_d              = $2000;     {   ALT+D                             }

    kb_e                  = $1265;     {   e                                 }
    kb_Shift_e            = $1245;     {   E                                 }
    kb_Ctrl_e             = $1205;     {   ^E      ENQ - Enquire             }
    kb_Alt_e              = $1200;     {   ALT+E                             }

    kb_f                  = $2166;     {   f                                 }
    kb_Shift_f            = $2146;     {   F                                 }
    kb_Ctrl_f             = $2106;     {   ^F      ACK - Acknowledge         }
    kb_Alt_f              = $2100;     {   ALT+F                             }

    kb_g                  = $2267;     {   g                                 }
    kb_Shift_g            = $2247;     {   G                                 }
    kb_Ctrl_g             = $2207;     {   ^G      BELL - Bell               }
    kb_Alt_g              = $2200;     {   ALT+G                             }

    kb_h                  = $2368;     {   h                                 }
    kb_Shift_h            = $2348;     {   H                                 }
    kb_Ctrl_h             = $2308;     {   ^H      BS - BackSpace            }
    kb_Alt_h              = $2300;     {   ALT+H                             }

    kb_i                  = $1769;     {   i                                 }
    kb_Shift_i            = $1749;     {   I                                 }
    kb_Ctrl_i             = $1709;     {   ^I      HT - Horizontal Tab       }
    kb_Alt_i              = $1700;     {   ALT+I                             }

    kb_j                  = $246A;     {   j                                 }
    kb_Shift_j            = $244A;     {   J                                 }
    kb_Ctrl_j             = $240A;     {   ^J      LF - Line Feed            }
    kb_Alt_j              = $2400;     {   ALT+J                             }

    kb_k                  = $256B;     {   k                                 }
    kb_Shift_k            = $254B;     {   K                                 }
    kb_Ctrl_k             = $250B;     {   ^K      VT - Vertical Tab         }
    kb_Alt_k              = $2500;     {   ALT+K                             }

    kb_l                  = $266C;     {   l                                 }
    kb_Shift_l            = $264C;     {   L                                 }
    kb_Ctrl_l             = $260C;     {   ^L      FF - Form Feed (new page) }
    kb_Alt_l              = $2600;     {   ALT+L                             }

    kb_m                  = $326D;     {   m                                 }
    kb_Shift_m            = $324D;     {   M                                 }
    kb_Ctrl_m             = $320D;     {   ^M      CR - Carriage Return      }
    kb_Alt_m              = $3200;     {   ALT+M                             }

    kb_n                  = $316E;     {   n                                 }
    kb_Shift_n            = $314E;     {   N                                 }
    kb_Ctrl_n             = $310E;     {   ^N      SO - Shift Out (numbers)  }
    kb_Alt_n              = $3100;     {   ALT+N                             }

    kb_o                  = $186F;     {   o                                 }
    kb_Shift_o            = $184F;     {   O                                 }
    kb_Ctrl_o             = $180F;     {   ^O      SI - Shift In (letters)   }
    kb_Alt_o              = $1800;     {   ALT+O                             }

    kb_p                  = $1970;     {   p                                 }
    kb_Shift_p            = $1950;     {   P                                 }
    kb_Ctrl_p             = $1910;     {   ^P      DEL - Delete              }
    kb_Alt_p              = $1900;     {   ALT+P                             }

    kb_q                  = $1071;     {   q                                 }
    kb_Shift_q            = $1051;     {   Q                                 }
    kb_Ctrl_q             = $1011;     {   ^Q      DC1 - Device Control 1    }
    kb_Alt_q              = $1000;     {   ALT+Q                             }

    kb_r                  = $1372;     {   r                                 }
    kb_Shift_r            = $1352;     {   R                                 }
    kb_Ctrl_r             = $1312;     {   ^R      DC2 - Device Control 2    }
    kb_Alt_r              = $1300;     {   ALT+R                             }

    kb_s                  = $1F73;     {   s                                 }
    kb_Shift_s            = $1F53;     {   S                                 }
    kb_Ctrl_s             = $1F13;     {   ^S      DC3 - Device Control 3    }
    kb_Alt_s              = $1F00;     {   ALT+S                             }

    kb_t                  = $1474;     {   t                                 }
    kb_Shift_t            = $1454;     {   T                                 }
    kb_Ctrl_t             = $1414;     {   ^T      DC4 - Device Control 4    }
    kb_Alt_t              = $1400;     {   ALT+T                             }

    kb_u                  = $1675;     {   u                                 }
    kb_Shift_u            = $1655;     {   U                                 }
    kb_Ctrl_u             = $1615;     {   ^U      NAK - Negative Acknowlegde}
    kb_Alt_u              = $1600;     {   ALT+U                             }

    kb_v                  = $2F76;     {   v                                 }
    kb_Shift_v            = $2F56;     {   V                                 }
    kb_Ctrl_v             = $2F16;     {   ^V      SYN - Syncronize          }
    kb_Alt_v              = $2F00;     {   ALT+V                             }

    kb_w                  = $1177;     {   w                                 }
    kb_Shift_w            = $1157;     {   W                                 }
    kb_Ctrl_w             = $1117;     {   ^W      ETB - End of Text Block   }
    kb_Alt_w              = $1100;     {   ALT+W                             }

    kb_x                  = $2D78;     {   x                                 }
    kb_Shift_x            = $2D58;     {   X                                 }
    kb_Ctrl_x             = $2D18;     {   ^X      CAN - Cancel              }
    kb_Alt_x              = $2D00;     {   ALT+X                             }

    kb_y                  = $1579;     {   y                                 }
    kb_Shift_y            = $1559;     {   Y                                 }
    kb_Ctrl_y             = $1519;     {   ^Y      EM - End of Medium        }
    kb_Alt_y              = $1500;     {   ALT+Y                             }

    kb_z                  = $2C7A;     {   z                                 }
    kb_Shift_z            = $2C5A;     {   Z                                 }
    kb_Ctrl_z             = $2C1A;     {   ^Z      SUB - Substitute          }
    kb_Alt_z              = $2C00;     {   ALT+Z                             }

{ Keyboard Numbers תתתתתתתתתתתתתתתתתתת}{   Key         Location              }
    kb_1                  = $0231;     {   1       Keyboard Number           }
    kb_Pad_1              = $4F31;     {   1       Pad Number                }
    kb_Alt_1              = $7800;     {   ALT+1   Keyboard Number           }

    kb_2                  = $0332;     {   2        Keyboard Number          }
    kb_Pad_2              = $5032;     {   2        Pad Number               }
    kb_Alt_2              = $7900;     {   ALT+2    Keyboard Number          }
    kb_Ctrl_2             = $0300;     {   ^1 (NUL) Keyboard Number          }

    kb_3                  = $0433;     {   3        Keyboard Number          }
    kb_Pad_3              = $5133;     {   3        Pad Number               }
    kb_Alt_3              = $7A00;     {   ALT+3    Keyboard Number          }

    kb_4                  = $0534;     {   4        Keyboard Number          }
    kb_Pad_4              = $4B34;     {   4        Pad Number               }
    kb_Alt_4              = $7B00;     {   ALT+4    Keyboard Number          }

    kb_5                  = $0635;     {   5        Keyboard Number          }
    kb_Pad_5              = $4C35;     {   5        Pad Number               }
    kb_Alt_5              = $7C00;     {   ALT+5    Keyboard Number          }

    kb_6                  = $0736;     {   6        Keyboard Number          }
    kb_Pad_6              = $4D36;     {   6        Pad Number               }
    kb_Ctrl_6             = $071E;     {   ^6 (RS)  Keyboard Number          }
    kb_Alt_6              = $7D00;     {   ALT+6    Keyboard Number          }

    kb_7                  = $0837;     {   7        Keyboard Number          }
    kb_Pad_7              = $4737;     {   7        Pad Number               }
    kb_Alt_7              = $7E00;     {   ALT+7    Keyboard Number          }

    kb_8                  = $0938;     {   8        Keyboard Number          }
    kb_Pad_8              = $4838;     {   8        Pad Number               }
    kb_Ctrl_8             = $091B;     {   ^8       Keyboard Number          }
    kb_Alt_8              = $7F00;     {   ALT+8    Keyboard Number          }

    kb_9                  = $0A39;     {   9        Keyboard Number          }
    kb_Pad_9              = $4939;     {   9        Pad Number               }
    kb_Ctrl_9             = $0A1D;     {   ^9       Keyboard Number          }
    kb_Alt_9              = $8000;     {   ALT+9    Keyboard Number          }

    kb_0                  = $0B30;     {   0        Keyboard Number          }
    kb_Pad_0              = $5230;     {   0        Pad Number               }
    kb_Alt_0              = $8100;     {   ALT+0    Keyboard Number          }

{ Keyboard Characters תתתתתתתתתתתתתתת}{   Key         Location               }
    kb_Less               = $563C;    {    <        Keyboard                 }
    kb_Great              = $563E;    {    >        Keyboard                 }

    kb_Minus              = $352D;    {    -        Keyboard                 }
    kb_Ctrl_Minus         = $351F;    {    ^-       Keyboard                 }
    kb_Alt_Minus          = $3500;    {    ALT+-    Keyboard                 }
    kb_Pad_Minus          = $4A2D;    {    -        Pad                      }
    kb_Ctrl_Pad_Minus     = $8E00;    {    ^-       Pad                      }
    kb_Alt_Pad_Minus      = $4A00;    {    ALT+-    Pad                      }

    kb_Plus               = $1A2B;    {    +        Keyboard                 }
    kb_Pad_Plus           = $4E2B;    {    +        Pad                      }
    kb_Alt_Pad_Plus       = $4E00;    {    ALT++    Pad                      }
    kb_Ctrl_Pad_Plus      = $9000;    {    ^+       Pad                      }

    kb_Equal              = $0B3D;    {    =        Keyboard                 }

    kb_Pad_Slash          = $E02F;    {    /        Pad                      }
    kb_Alt_Pad_Slash      = $A400;    {    Alt+/    Pad                      }
    kb_Ctrl_Pad_Slash     = $9500;    {    ^/       Pad                      }

    kb_BackSlash          = $295C;    {    \        Keyboard                 }
    kb_Ctrl_BackSlash     = $291C;    {    ^\  ( FS - File Separator ) Keyb. }
    kb_Alt_BackSlash      = $2900;    {    \        Keyboard                 }

    kb_OpenBracket        = $095B;    {    [        Keyboard                 }

    kb_CloseBracket       = $0A5D;    {    ]        Keyboard                 }

    kb_OpenParenthesis    = $0928;    {    (        Keyboard                 }

    kb_CloseParenthesis   = $0A29;    {    )        Keyboard                 }

    kb_OpenBrace          = $087B;    (*   {        Keyboard                *)

    kb_CloseBrace         = $0B7D;    (*   }        Keyboard                *)

    kb_Apostrophe         = $0C27;    {    '        Keyboard                 }
    kb_Grave              = $0060;    {    `        Keyboard                 }

    kb_Quote              = $0322;    {    "        Keyboard                 }

    kb_Tilde              = $007E;    {    ~        Keyboard                 }

    kb_Cater              = $005E;    {    ^        Keyboard                 }

    kb_Semicolon          = $333B;    {    ;        Keyboard                 }

    kb_Comma              = $332C;    {    ,        Keyboard                 }

    kb_Colon              = $343A;    {    :        Keyboard                 }

    kb_Period             = $342E;    {    .        Keyboard                 }
    kb_Alt_Period         = $3400;    {    Alt+.    Keyboard                 }
    kb_Pad_Period         = $532E;    {    .        Pad                      }
    kb_Ctrl_Pad_Period    = $9300;    {    ^.       Pad                      }

    kb_Asterisk           = $1A2A;    {    *        Keyboard                 }
    kb_Pad_Asterisk       = $372A;    {    *        Pad                      }
    kb_Ctrl_Pad_Asterisk  = $9600;    {    ^*       Pad                      }

    kb_ExclamationPoint   = $0221;    {    !        Keyboard                 }

    kb_QuestionMark       = $0C3F;    {    ?        Keyboard                 }

    kb_NumberSign         = $0423;    {    #        Keyboard                 }

    kb_Dollar             = $0524;    {    $        Keyboard                 }

    kb_Percent            = $0625;    {    %        Keyboard                 }

    kb_AmpersAnd          = $0726;    {    &        Keyboard                 }

    kb_At                 = $0340;    {    @        Keyboard                 }

    kb_UnitSeparator      = $355F;    {    _        Keyboard                 }

    kb_Vertical           = $297C;    {    |        Keyboard                 }

    kb_Space              = $3920;    {    SPACE BAR    Keyboard             }

{ Keyboard Functions  תתתתתתתתתתתתתתת}{   Key                                }
    kb_F1                  = $3B00;   {    F1                                }
    kb_Shift_F1            = $5400;   {    SHIFT+F1                          }
    kb_Ctrl_F1             = $5E00;   {    ^F1                               }
    kb_Alt_F1              = $6800;   {    ALT+F1                            }

    kb_F2                  = $3C00;   {    F2                                }
    kb_Shift_F2            = $5500;   {    SHIFT+F2                          }
    kb_Ctrl_F2             = $5F00;   {    ^F2                               }
    kb_Alt_F2              = $6900;   {    ALT+F2                            }

    kb_F3                  = $3D00;   {    F3                                }
    kb_Shift_F3            = $5600;   {    SHIFT+F3                          }
    kb_Ctrl_F3             = $6000;   {    ^F3                               }
    kb_Alt_F3              = $6A00;   {    ALT+F3                            }

    kb_F4                  = $3E00;   {    F4                                }
    kb_Shift_F4            = $5700;   {    SHIFT+F4                          }
    kb_Ctrl_F4             = $6100;   {    ^F4                               }
    kb_Alt_F4              = $6B00;   {    ALT F4                            }

    kb_F5                  = $3F00;   {    F5                                }
    kb_Shift_F5            = $5800;   {    SHIFT+F5                          }
    kb_Ctrl_F5             = $6200;   {    ^F5                               }
    kb_Alt_F5              = $6C00;   {    ALT+F5                            }

    kb_F6                  = $4000;   {    F6                                }
    kb_Shift_F6            = $5900;   {    SHIFT+F6                          }
    kb_Ctrl_F6             = $6300;   {    ^F6                               }
    kb_Alt_F6              = $6D00;   {    ALT+F6                            }

    kb_F7                  = $4100;   {    F7                                }
    kb_Shift_F7            = $5A00;   {    SHIFT+F7                          }
    kb_Ctrl_F7             = $6400;   {    ^F7                               }
    kb_Alt_F7              = $6E00;   {    ALT+F7                            }

    kb_F8                  = $4200;   {    F8                                }
    kb_Shift_F8            = $5B00;   {    SHIFT+F8                          }
    kb_Ctrl_F8             = $6500;   {    ^F8                               }
    kb_Alt_F8              = $6F00;   {    ALT+F8                            }

    kb_F9                  = $4300;   {    F9                                }
    kb_Shift_F9            = $5C00;   {    SHIFT+F9                          }
    kb_Ctrl_F9             = $6600;   {    ^F9                               }
    kb_Alt_F9              = $7000;   {    ALT+F9                            }

    kb_F10                 = $4400;   {    F10                               }
    kb_Shift_F10           = $5D00;   {    SHIFT+F10                         }
    kb_Ctrl_F10            = $6700;   {    ^F10                              }
    kb_Alt_F10             = $7100;   {    ALT+F10                           }

    kb_F11                 = $8500;   {    F11                               }
    kb_Shift_F11           = $8700;   {    SHIFT+F11                         }
    kb_Ctrl_F11            = $8900;   {    ^F11                              }
    kb_Alt_F11             = $8B00;   {    ALT+F11                           }

    kb_F12                 = $8600;   {    F12                               }
    kb_Shift_F12           = $8800;   {    SHIFT+F12                         }
    kb_Ctrl_F12            = $8A00;   {    ^F12                              }
    kb_Alt_F12             = $8C00;   {    ALT+F12                           }

{ Keyboard Cursors  תתתתתתתתתתתתתתתתת}{   Key           Location             }
    kb_Up                  = $48E0;   {    UP           Keyboard             }
    kb_Ctrl_Up             = $8DE0;   {    ^UP          Keyboard             }
    kb_Alt_Up              = $9800;   {    ALT+UP       Keyboard             }
    kb_Pad_Up              = $4800;   {    UP           Pad                  }
    kb_Ctrl_Pad_Up         = $8D00;   {    ^UP          Pad                  }

    kb_Down                = $50E0;   {    DOWN         Keyboard             }
    kb_Ctrl_Down           = $91E0;   {    ^DOWN        Keyboard             }
    kb_Alt_Down            = $A000;   {    ALT+DOWN     Keyboard             }
    kb_Pad_Down            = $5000;   {    DOWN         Pad                  }
    kb_Ctrl_Pad_Down       = $9100;   {    ^DOWN        Pad                  }

    kb_Left                = $4BE0;   {    LEFT         Keyboard             }
    kb_Ctrl_Left           = $73E0;   {    ^LEFT        Keyboard             }
    kb_Alt_Left            = $9B00;   {    ALT+LEFT     Keyboard             }
    kb_Pad_Left            = $4B00;   {    LEFT         Pad                  }
    kb_Ctrl_Pad_Left       = $7300;   {    ^LEFT        Pad                  }

    kb_Right               = $4DE0;   {    RIGHT        Keyboard             }
    kb_Ctrl_Right          = $74E0;   {    ^RIGHT       Keyboard             }
    kb_Alt_Right           = $9D00;   {    ALT+RIGHT    Keyboard             }
    kb_Pad_Right           = $4D00;   {    RIGHT        Pad                  }
    kb_Ctrl_Pad_Right      = $7400;   {    ^RIGHT       Pad                  }

    kb_Home                = $47E0;   {    HOME         Keyboard             }
    kb_Ctrl_Home           = $77E0;   {    ^HOME        Keyboard             }
    kb_Alt_Home            = $9700;   {    ALT+HOME     Keyboard             }
    kb_Pad_Home            = $4700;   {    HOME         Pad                  }
    kb_Ctrl_Pad_Home       = $7700;   {    ^HOME        Pad                  }

    kb_End                 = $4FE0;   {    END          Keyboard             }
    kb_Ctrl_End            = $75E0;   {    ^END         Keyboard             }
    kb_Alt_End             = $9F00;   {    ALT+END      Keyboard             }
    kb_Pad_End             = $4F00;   {    END          Pad                  }
    kb_Ctrl_Pad_End        = $7500;   {    ^END         Pad                  }

    kb_PgUp                = $49E0;   {    PGUP         Keyboard             }
    kb_Ctrl_PgUp           = $84E0;   {    ^PGUP        Keyboard             }
    kb_Alt_PgUp            = $9900;   {    ALT+PGUP     Keyboard             }
    kb_Pad_PgUp            = $4900;   {    PGUP         Pad                  }
    kb_Ctrl_Pad_PgUp       = $8400;   {    ^PGUP        Pad                  }

    kb_PgDown              = $51E0;   {    PGDOWN       Keyboard             }
    kb_Ctrl_PgDown         = $76E0;   {    ^PGDOWN      Keyboard             }
    kb_Alt_PgDown          = $A100;   {    ALT+PGDOWN   Keyboard             }
    kb_Pad_PgDown          = $5100;   {    PGDOWN       Pad                  }
    kb_Ctrl_Pad_PgDown     = $7600;   {    ^PGDOWN      Pad                  }

{ Keyboard Control  תתתתתתתתתתתתתתתתת}{   Key           Location             }
    kb_Esc                 = $011B;   {    ESC          Keyboard             }
    kb_Alt_Esc             = $0100;   {    ALT+ESC      Keyboard             }

    kb_Enter               = $1C0D;   {    RETURN       Keyboard             }
    kb_Alt_Enter           = $1C00;   {    ALT+ENTER    Keyboard             }
    kb_Ctrl_Enter          = $1C0A;   {    ^ENTER       Keyboard             }
    kb_Pad_Enter           = $E00D;   {    RETURN       Pad                  }
    kb_Ctrl_Pad_Enter      = $E00A;   {    ^ENTER       Pad                  }
    kb_Alt_Pad_Enter       = $A600;   {    ALT+ENTER    Pad                  }

    kb_BackSpace           = $0E08;   {    BACKSPACE     Keyboard            }
    kb_Ctrl_Backspace      = $0E7F;   {    ^BACKSPACE    Keyboard            }
    kb_Alt_Backspace       = $0E00;   {    ALT+BACKSPACE Keyboard            }

    kb_Tab                 = $0F09;   {    TAB           Keyboard            }
    kb_Shift_Tab           = $0F00;   {    SHIFT+TAB     Keyboard            }
    kb_Ctrl_Tab            = $9400;   {    ^TAB          Keyboard            }
    kb_Alt_Tab             = $A500;   {    ALT+TAB       Keyboard            }

    kb_Ins                 = $52E0;   {    INSERT        Keyboard            }
    kb_Alt_Ins             = $A200;   {    ALT+INSERT    Keyboard            }
    kb_Ctrl_Ins            = $92E0;   {    ^INSERT       Keyboard            }

    kb_Del                 = $53E0;   {    DELETE        Keyboard            }
    kb_Alt_Del             = $A300;   {    ALT+DELETE    Keyboard            }
    kb_Ctrl_Del            = $93E0;   {    ^DELETE       Keyboard            }
    kb_Pad_Del             = $5300;   {    DELETE        Pad                 }


    kb_Ctrl_PrtSc          = $7200;   {    ^PRTSC        Keyboard            }

    kb_Ctrl_Break          = $0000;   {    ^BREAK        Keyboard            }
{$ENDIF}

  Var
    Error : Byte;
    { arrays that record keyboard status }
{$IFNDEF NoGamesKeyboard}
    KeyDown,
    Wasdown: Array[0..127] OF Boolean;
{$ENDIF}

{ -_-_-_-_-_-_-_-_-_-_-_-_-_-_ Public rotines -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-}

{$IFNDEF NoStandardKeyboard}
{ Keyboard Status Rotines }
  PROCEDURE CapsLockOn(Enable : Boolean);
  PROCEDURE NumLockOn(Enable : Boolean);
  PROCEDURE ScrollLockOn(Enable : Boolean);
  FUNCTION  CapsIsOn : Boolean;
  FUNCTION  IsEnhancedKeyBoard : Boolean;
  FUNCTION  InsertIsOn : Boolean;
  FUNCTION  LAltIsPressed : Boolean;
  FUNCTION  LCtrlIsPressed : Boolean;
  FUNCTION  LeftShiftIsPressed : Boolean;
  FUNCTION  NumLockIsOn : Boolean;
  FUNCTION  RAltIsPressed : Boolean;
  FUNCTION  RCtrlIsPressed : Boolean;
  FUNCTION  RightShiftIsPressed : Boolean;
  FUNCTION  ScrollIsOn : Boolean;

{ Keyboard Reading Keys Rotines }
  PROCEDURE ClearKeybBuffer;
  FUNCTION  GetChar(Key : Word) : Char;
  FUNCTION  GetScanCodeW : Word;
  FUNCTION  KeyPressed : Boolean;
{$ENDIF}
{$IFNDEF NoGamesKeyboard}
{ Keyboard Reading Multiple Keys Rotines }
  PROCEDURE ClearWasDownArray;
  PROCEDURE InitNewKeyInt;
  PROCEDURE SetOldKeyInt;
  FUNCTION  ScanOf(CharToScan : Char): Byte;
{$ENDIF}

{ ************************    IMPLEMENTATION   ******************************}
{                         *********************                              }
IMPLEMENTATION

  Uses
    Dos,Screen;

  Var
    OldKbdInt : Pointer;

{$IFNDEF NoInternalChecking }
{----------------------------------------------------------------------------}
{                                                                            }
{ DisplayError                                                               }
{              - Description : Write in the screen the error description     }
{              - Input       : No --> The number of the error                }
{              - Return      : ----                                          }
{----------------------------------------------------------------------------}
{ Hey, check the screen unit for more information!!! I just have to say that }
{ this unit will NOT work if you don't have a enhanced keyboard!!!           }
PROCEDURE DisplayError(No : Byte);

  Var
    S : String[100];

  Begin
    Case No OF
        1 : S := 'Your keyboard is not an enhanced keyboard';
    End;
    BkColor:= 0 ;
    Write(1,1,15,S);
    Halt;
  End; { DisplayError }
{$ENDIF}

{ ======================== Unit                  =========================== }
{ ========================      Internal         =========================== }
{ ========================               Rotines =========================== }
{                         ***********************                            }

{$IFNDEF NoGamesKeyboard}
{----------------------------------------------------------------------------}
{ PROCEDURE (Internal)                                                       }
{ Sti                                                                        }
{            - Description : Set Interrupt Flag                              }
{            - Input       : ----                                            }
{            - Return      : ----                                            }
{----------------------------------------------------------------------------}
PROCEDURE Sti;
  InLine($FB); { STI: Set Interrupt Flag }

{----------------------------------------------------------------------------}
{ PROCEDURE (Internal)                                                       }
{ Cli                                                                        }
{            - Description : Clear Interrupt Flag                            }
{            - Input       : ----                                            }
{            - Return      : ----                                            }
{----------------------------------------------------------------------------}
PROCEDURE Cli;
  InLine($FA); { CLI: Clear Interrupt Flag -- Not Used }

{----------------------------------------------------------------------------}
{ PROCEDURE (Internal)                                                       }
{ CallOldInt                                                                 }
{            - Description : Calls old interrupt routine so that your        }
{                            programs don't deprive the computer of any vital}
{                            functions                                       }
{            - Input       : Sub --> Old Interrupt Pointer                   }
{            - Return      : ----                                            }
{----------------------------------------------------------------------------}
PROCEDURE CallOldInt(Sub : Pointer);

  Begin
    InLine($9C/         { PUSHF }
         $ff/$5e/$06)   { CALL DWORD PTR [BP+6] }
  End; { CallOldInt Internal Rotine }

{----------------------------------------------------------------------------}
{ PROCEDURE (Internal)                                                       }
{ NewKbdInt                                                                  }
{            - Description : New Keyboard Interrupt                          }
{            - Input       : ----                                            }
{            - Return      : ----                                            }
{----------------------------------------------------------------------------}
PROCEDURE NewKbdInt; Interrupt;

  Begin
    KeyDown[Port[$60] MOD 128] := (Port[$60] < 128); { Key is down if value  }
    { of 60h is less than 128 -- record current status                       }
    IF Port[$60] < 128 Then WasDown[Port[$60]] := True; { Update WASDOWN if  }
    { the key is currently depressed                                         }
    CallOldInt(OldKbdInt); { Call old interrupt                              }
    Mem[$0040:$001A] := Mem[$0040:$001C];{ Clear keyboard buffer: the buffer }
    { is a ring buffer, where the computer keeps track of the location of the}
    { next character in the buffer end the final character in the buffer.    }
    { To clear the buffer, set the two equal to each other.                  }
    Sti;
  End; { NewKbdInt Internal Rotine }
{$ENDIF}

{ ========================= Keyboard                 ======================= }
{ =========================          Status          ======================= }
{ =========================                 Rotines  ======================= }
{                          **************************                        }

{$IFNDEF NoStandardKeyboard}
{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ CapsLockOn                                                                 }
{           - Description : Sets the CapsLock On/Off                         }
{           - Input       : Enable --> If True is set On                     }
{                                      If False is set Off                   }
{           - Return      : ----                                             }
{----------------------------------------------------------------------------}
PROCEDURE CapsLockOn(Enable : Boolean);

  Begin
    IF Enable Then {    Turn on Bit          }
      Mem[Seg0040:$17] := Mem[Seg0040:$17] OR $40
    Else        {  Turn it Off          }
      Mem[Seg0040:$17] := Mem[Seg0040:$17] AND $BF;
  End;  { CapsLockOn }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ NumLockOn                                                                  }
{           - Description : Sets the NumLock On/Off                          }
{           - Input       : Enable --> If True is set On                     }
{                                      If False is set Off                   }
{           - Return      : ----                                             }
{----------------------------------------------------------------------------}
PROCEDURE NumLockOn(Enable : Boolean);

  Begin
    IF Enable Then   {  Turn on Bit 5        }
      Mem[Seg0040:$17] := Mem[Seg0040:$17] OR $20
    Else             {  Turn it Off 5        }
      Mem[Seg0040:$17] := Mem[Seg0040:$17] AND $DF;
  End;  { NumLockOn }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ ScrollLockOn                                                               }
{           - Description : Sets the ScrollLock On/Off                       }
{           - Input       : Enable --> If True is set On                     }
{                                      If False is set Off                   }
{           - Return      : ----                                             }
{----------------------------------------------------------------------------}
PROCEDURE ScrollLockOn(Enable : Boolean);

  Begin
    IF Enable Then       {  Turn on Bit          }
      Mem[Seg0040:$17] := Mem[Seg0040:$17] OR $10
    Else               {  Turn it Off          }
      Mem[Seg0040:$17] := Mem[Seg0040:$17] AND $EF;
  End;  { ScrollLockOn }

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ CapsIsOn                                                                     }
{        - Description : Routine to determine if Caps Lock is on             }
{        - Input       : ----                                                }
{        - Return      : The status of Caps                                  }
{----------------------------------------------------------------------------}
FUNCTION CapsIsOn : Boolean;

  Begin  { Test the keyboard status bit for Caps.}
    CapsIsOn := (Mem[Seg0040:$0017] AND $40) <> 0;
  End;   { CapsIsOn }

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ IsEnhancedKeyboard                                                         }
{                    - Description : Check if is a enhanced keyboard         }
{                    - Input       : ----                                    }
{                    - Return      : True if is an enhanced keyboard         }
{----------------------------------------------------------------------------}
FUNCTION IsEnhancedKeyBoard : Boolean;
  Begin
    IsEnhancedKeyBoard := (Mem[Seg0040:$96] AND $10) = $10;
    {  Test Bit 4 }
  End;  { IsEnhancedKeyBoard }

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ InsertIsOn                                                                   }
{           - Description : Routine to determine if Insert is on             }
{           - Input       : ----                                             }
{           - Return      : The status of Insert                             }
{----------------------------------------------------------------------------}
FUNCTION InsertIsOn : Boolean;

  Begin  { Test keyboard status bit for insert.  }
    InsertIsOn := (Mem[Seg0040:$0017] AND $80) <> 0;
  End; { InsertIsOn }

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ LAltIsPressed                                                              }
{           - Description : Routine to determine if Left ALT key is being    }
{                           held down                                        }
{           - Input       : ----                                             }
{           - Return      : The status of Left ALT Key                       }
{----------------------------------------------------------------------------}
FUNCTION LAltIsPressed : BOOLEAN;

  Begin   { Test keyboard status bit for Left ALT.     }
    LAltIsPressed := (Mem[Seg0040:$0018] AND $02) <> 0;
  End;  { LAltIsPressed }

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ LCrtlIsPressed                                                             }
{             - Description : Routine to determine if Left Crtl key is being }
{                             held down                                      }
{             - Input       : ----                                           }
{             - Return      : The status of Left Crtl Key                    }
{----------------------------------------------------------------------------}
FUNCTION LCtrlIsPressed : Boolean;

  Begin   { Test keyboard status bit for Left Ctrl.    }
    LCtrlIsPressed := (Mem[Seg0040:$0018] AND $01) <> 0;
  End; { LCtrlIsPressed }
{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ LeftShiftIsPressed                                                           }
{                  - Description : Routine to determine if Left Sift key is  }
{                                  being held down                           }
{                  - Input       : ----                                      }
{                  - Return      : The status of Left Shift                  }
{----------------------------------------------------------------------------}
FUNCTION LeftShiftIsPressed : Boolean;

  Begin  { Test keyboard status bit for L_Shift. }
    LeftShiftIsPressed := (Mem[Seg0040:$0017] AND $02) <>  0;
  End;  { LeftShiftIsPressed }

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ NumLockIsOn                                                                  }
{           - Description : Routine to determine if Num Lock is on           }
{           - Input       : ----                                             }
{           - Return      : The status of NumLock                            }
{----------------------------------------------------------------------------}
FUNCTION NumLockIsOn : Boolean;

  Begin  { Test keyboard status bit for NumLock. }
    NumLockIsOn := (Mem[Seg0040:$0017] AND $20) <>0
  End;  { NumLockIsOn }

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ RAltIsPressed                                                              }
{           - Description : Routine to determine if Right ALT key is being   }
{                           held  down                                       }
{           - Input       : ----                                             }
{           - Return      : The status of Right ALT Key                      }
{----------------------------------------------------------------------------}
FUNCTION RAltIsPressed :BOOLEAN;

  Var
    Regs : Registers;

  Begin  { Test keyboard status bit for Right Alt    }
    Regs.AH := $12;
    Intr($16,Regs);
    RAltIsPressed := (Regs.AH AND $08) <> 0;
  End;  { RAltIsPressed }

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ RCrtlIsPressed                                                             }
{             - Description : Routine to determine if Right Crtl key is being}
{                             held down                                      }
{             - Input       : ----                                           }
{             - Return      : The status of Right Crtl Key                   }
{----------------------------------------------------------------------------}
FUNCTION RCtrlIsPressed :Boolean;

  Var
    Regs : Registers;

  Begin   { Test keyboard status bit for Right Ctrl    }
    Regs.AH := $12;
    Intr($16,Regs);
    RCtrlIsPressed := (Regs.AH AND $04) <> 0;
  End; { RCtrlIsPressed }


{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ RightShiftIsPressed                                                          }
{                  - Description : Routine to determine if Right Sift key is }
{                                  being held down                           }
{                  - Input       : ----                                      }
{                  - Return      : The status of Right Shift                 }
{----------------------------------------------------------------------------}
FUNCTION RightShiftIsPressed : Boolean;

  Begin  { Test keyboard status bit for R_Shift. }
    RightShiftIsPressed := (Mem[Seg0040:$0017] AND $1) <> 0;
  End;  { RightShiftIsPressed }

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ ScrollIsOn                                                                   }
{           - Description : Routine to determine if Scroll is on             }
{           - Input       : ----                                             }
{           - Return      : The status of Scroll                             }
{----------------------------------------------------------------------------}
FUNCTION ScrollIsOn :Boolean;

  Begin  { Test keyboard status bit for S_Lock.  }
    ScrollIsOn := (Mem[Seg0040:$0017] AND $10) <> 0;
  End;  { ScrollIsOn }

{ ====================== Keyboard                      ===================== }
{ ======================          Reading              ===================== }
{ ======================                  Keys         ===================== }
{ ======================                       Rotines ===================== }
{                       *******************************                      }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ ClearKeybBuffer                                                            }
{        - Description : Clears the keyboard buffer                          }
{        - Input       : ----                                                }
{        - Return      : ----                                                }
{----------------------------------------------------------------------------}
PROCEDURE ClearKeybBuffer;

  Const
     KeybHead : ^Integer = Ptr($40,$1A);
     KeybTail : ^Integer = Ptr($40,$1C);

  Var
    FpKeyHead, FpKeyTail : Pointer;

  Begin
    InLine($FA);
    FpKeyHead := KeybHead;
    FpKeyTail := KeybTail;
    Integer(FpKeyHead^) := Integer(FpKeyTail^);
    InLine($FB);
  End; { ClearKeyBuffer }

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ GetChar                                                                    }
{        - Description : This Function returns the Character of a pressed key}
{        - Input       : ----                                                }
{        - Return      : The Character                                       }
{----------------------------------------------------------------------------}
FUNCTION GetChar(Key : Word) : Char;

  Var
    LowValue : Word;

  Begin
    LowValue := Key AND $00FF;
    GetChar := Chr(LowValue);
  End;  { GetChar }

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ GetScanCodeW                                                               }
{              - Description : This Function returns the WORD scancode of a  }
{                              key                                           }
{              - Input       : ----                                          }
{              - Return      : The scancode word                             }
{----------------------------------------------------------------------------}
FUNCTION GetScanCodeW : Word;

  Var
    ScanCode : Word;

  Begin
    Asm
      CALL IsEnhancedKeyBoard   { Test for an Enhanced keyboard.        }
      CMP  AL,1                 { If AL=1 THEN Enhanced Keyboard= TRUE. }
      JE   @Enhanced            { If it was TRUE then Get Enhanced key. }
      MOV  AH,0                 { If not TRUE get normal key.           }
      JMP  @ReadKeyb
     @Enhanced:
      MOV  AH,$10               { Function to get key from enhanced board }
     @ReadKeyb:
      INT $16                   { Call Int keyboard INT.                }
      MOV ScanCode,AX           { into ScanCode                         }
                                { The high-Byte is the "scan code"    }
                                { The low-Byte is the ASCII Character }
    End;
    GetScanCodeW := ScanCode;
  End;  { GetScanCodeW }

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ KeyPressed                                                                 }
{            - Description : Function to determine if a key was pressed.     }
{                            This routine also detects F11 and F12           }
{            - Input       : ----                                            }
{            - Return      : True if a Key was pressed                       }
{----------------------------------------------------------------------------}
FUNCTION KeyPressed : Boolean; Assembler;

  Asm
    MOV  AH,$11    { Function to check for Enhanced key.   }
    INT  $16       { Call keyboard INT.                    }
    JZ   @NoKey    { If ZF not set then nothing pressed.   }
    MOV  AL,1      { Otherwise return TRUE.                }
    JMP  @Exit     { Now goto Exit.                        }
   @NoKey:
    MOV  AL,0      { Return a FALSE result.                }
   @Exit:
  End;  { KeyPressed }
{$ENDIF}

{ ================= Keyboard                               ================= }
{ =================          Reading                       ================= }
{ =================                  Multiple              ================= }
{ =================                           Keys         ================= }
{ =================                                Rotines ================= }
{                  ****************************************                  }

{$IFNDEF NoGamesKeyboard}
{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ ClearWasDownArray                                                          }
{            - Description : Set all values in WASDOWN to "False"            }
{            - Input       : ----                                            }
{            - Return      : ----                                            }
{----------------------------------------------------------------------------}
PROCEDURE ClearWasDownArray;

  Begin
    FillChar(WasDown,SizeOf(WasDown),False);
  End; { ClearWasDownArray }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ InitNewKeyInt                                                              }
{            - Description : Set new keyboard interrupt                      }
{            - Input       : ----                                            }
{            - Return      : ----                                            }
{----------------------------------------------------------------------------}
PROCEDURE InitNewKeyInt;

  Begin
    FillChar(KeyDown,SizeOf(KeyDown),False);
    FillChar(WasDown,SizeOf(WasDown),False);
    GetIntVec($09, OldKbdInt); { Record location of old keyboard int         }
    SetIntVec($09, Addr(NewKbdInt)); { This line installs the new interrupt  }
    Sti;
  End; { InitNewKeyInt }

{----------------------------------------------------------------------------}
{ PROCEDURE                                                                  }
{ SetOldKeyInt                                                               }
{            - Description : Reset old interrupt                             }
{            - Input       : ----                                            }
{            - Return      : ----                                            }
{----------------------------------------------------------------------------}
PROCEDURE SetOldKeyInt;

  Begin
    SetIntVec($09, OldKbdInt);
    Sti;
  End; { SetOldKeyInt }

{----------------------------------------------------------------------------}
{ FUNCTION                                                                   }
{ ScanOF                                                                     }
{            - Description : Return scan code corresponding to a character   }
{            - Input       : CharToScan --> Character to check               }
{            - Return      : The byte value of the char                      }
{----------------------------------------------------------------------------}
FUNCTION ScanOF(CharToScan : Char) : Byte;

  Var
    TempByte : Byte;

  Begin
    TempByte := 0;
    Case UpCase(CharToScan) OF
      '!', '1': TempByte := $02;
      '@', '2': TempByte := $03;
      '#', '3': TempByte := $04;
      '$', '4': TempByte := $05;
      '%', '5': TempByte := $06;
      '^', '6': TempByte := $07;
      '&', '7': TempByte := $08;
      '*', '8': TempByte := $09;
      '(', '9': TempByte := $0a;
      ')', '0': TempByte := $0b;
      '_', '-': TempByte := $0c;
      '+', '=': TempByte := $0d;
      'A': TempByte := $1e;
      'S': TempByte := $1f;
      'D': TempByte := $20;
      'F': TempByte := $21;
      'G': TempByte := $22;
      'H': TempByte := $23;
      'J': TempByte := $24;
      'K': TempByte := $25;
      'L': TempByte := $26;
      ':', ';': TempByte := $27;
      '"', '''': TempByte := $28;
      '~', '`': TempByte := $29;
      ' ': TempByte := $39;
      'Q': TempByte := $10;
      'W': TempByte := $11;
      'E': TempByte := $12;
      'R': TempByte := $13;
      'T': TempByte := $14;
      'Y': TempByte := $15;
      'U': TempByte := $16;
      'I': TempByte := $17;
      'O': TempByte := $18;
      'P': TempByte := $19;
      '{', '[': TempByte := $1a;
      '}', ']': TempByte := $1b;
      '|', '\': TempByte := $2b;
      'Z': TempByte := $2c;
      'X': TempByte := $2d;
      'C': TempByte := $2e;
      'V': TempByte := $2f;
      'B': TempByte := $30;
      'N': TempByte := $31;
      'M': TempByte := $32;
      '<', ',': TempByte := $33;
      '>', '.': TempByte := $34;
      '?', '/': TempByte := $35
    End;
    ScanOF := TempByte;
  End; { ScanOF }
{$ENDIF}

{ ************************        MAIN         ******************************}
{                         *********************                              }
  Begin { Run the unit to prepare some default values }
    Error := 0;
    {$IFNDEF NoStandardKeyboard}
    IF Not IsEnhancedKeyboard Then
    {$IFNDEF NoInternalChecking }
    DisplayError(1);
    {$ELSE}
    Error := 2;
    {$ENDIF}
    {$ENDIF}
  End. { End Everything }

{ Well, for now the only thing I have to do is write the list of the guys and}
{ places I look to write this unit. In each unit is the list of the people   }
{ that made the original sources where I look to make the respective unit.   }
{ So, to this unit I read the next people sources and books:                 }

{ From SWAG:                                                                 }
{           - SwagTeam                                                       }
{           -                                                                }
{           -                                                                }
{           -                                                                }
{           -                                                                }
{           -                                                                }
{           -                                                                }
{           -                                                                }
{           -                                                                }
{           -                                                                }
{           -                                                                }
{           -                                                                }
{           -                                                                }
{           -                                                                }
{           -                                                                }


