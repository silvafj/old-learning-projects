#ifndef	__Int2Txi_
#define	__Int2Txi_

// Include Standard libraries
#include <stdio.h>
#include <string.h>

// Define Program information
char convertions_version[20] = "Convertions v0.1.0";


/*
*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*
|                                                                           *
*  Rotine      : print_help_options()                                       |
|  Description : Prints the basic commands to the screen                    *
*  Input       : location --> where is the current program                  |
|  Return      : ----                                                       *
*                                                                           |
*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*
*/
void print_help_options(char *location)
  {
  fprintf(stdout,"\n");
  fprintf(stdout,"%s converts decimal system to hexdecimal and vice-versus\n",convertions_version);
  fprintf(stdout,"(C) 1998 Fernando J.A. Silva <magico@GalaxyCorp.com>\n");
  fprintf(stdout,"\n");
  fprintf(stdout,"usage: %s [options] value\n",location);
  fprintf(stdout,"\n");
  fprintf(stdout,"options :\n");
  fprintf(stdout,"  -d converts decimal to hexdecimal\n");
  fprintf(stdout,"  -h converts hexdecimal to decimal\n");
  fprintf(stdout,"  -i display software license\n");
  fprintf(stdout,"value :\n");
  fprintf(stdout,"  this value should be an decimal or an hexdecimal number\n");
  fprintf(stdout,"\n");
  fprintf(stdout,"S¢ quero dizer que demorei 2 horas e meia a fazer isto,\n");
  fprintf(stdout,"e que demorei este tempo todo devido a uma pequena coisa...\n");
  fprintf(stdout,"O facto de ser HORRIVEL trabalhar com strings em C!!!!\n");
  fprintf(stdout,"Pode ser muito fixe para trabalhar com numeros, mas com strings\n");
  fprintf(stdout,"s¢ h  uma boa linguagem VIVA O PASCAL!!! heheh Good luck Cremax...\n");
  } // print_help_options()

/*
*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*
|                                                                           *
*  Rotine      : print_software_license()                                   |
|  Description : self explained                                             *
*  Input       : ----                                                       |
|  Return      : ----                                                       *
*                                                                           |
*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*
*/
void print_software_license()
  {
  clrscr();
  fprintf(stdout,"\n");
  fprintf(stdout,"%s converts decimal system to hexdecimal and vice-versus\n",convertions_version);
  fprintf(stdout,"(C) 1998 Fernando J.A. Silva <magico@GalaxyCorp.com>\n");
  fprintf(stdout,"\n");
  fprintf(stdout,"    Int2Txi is free software; you can redistribute it and/or\n");
  fprintf(stdout,"    modify them under the terms of the GNU General Public License as\n");
  fprintf(stdout,"    published by the Free Software Foundation; either version 2 of\n");
  fprintf(stdout,"    the License, or (at your option) any later version.\n");
  fprintf(stdout,"\n");
  fprintf(stdout,"    This program is distributed in the hope that it will be useful,\n");
  fprintf(stdout,"    but WITHOUT ANY WARRANTY; without even the implied warranty of\n");
  fprintf(stdout,"    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\n");
  fprintf(stdout,"    GNU General Public License for more details.\n");
  fprintf(stdout,"\n");
  fprintf(stdout,"    You should have received a copy of the GNU General Public License\n");
  fprintf(stdout,"    along with this program; see the file COPYING.\n");
  fprintf(stdout,"    If not, write to the Free Software Foundation, Inc.,\n");
  fprintf(stdout,"    59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.\n");
  fprintf(stdout,"\n");
  fprintf(stdout,"    If you dont have nothing to do make a visit to:\n");
  fprintf(stdout,"    http://members.xoom.com/ptcoders/\n");
  fprintf(stdout,"\n");
  } // print_software_license()


int power(int base,int ind)
  {
  int valor;
  int i;
  
  if (ind == 0) return(1);
  valor = base;
  for(i=1;i<ind;i++)
    valor = valor * base;
  return(valor);
  } // power

/*
*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*
|                                                                           *
*  Rotine      : hex2dec                                                    |
|  Description : Converts a hexdecimal string to a decimal number           *
*  Input       : hexnum --> hexdecimal string                               |
|  Return      : the decimal number                                         *
*                                                                           |
*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*
*/
int hex2dec(char hex_num[15])
  {
  int valor,tamanho,ind;
  char inv_hex_num[15]; // the real hex num is the inverted hex_num that we
                        // receive as parameter
  int let_num;

  tamanho = strlen(hex_num);
  inv_hex_num[0] = hex_num[tamanho-1];
  inv_hex_num[1] = hex_num[tamanho-2];
  inv_hex_num[2] = hex_num[tamanho-3];
  inv_hex_num[3] = hex_num[tamanho-4];
  inv_hex_num[4] = hex_num[tamanho-5];
  inv_hex_num[5] = hex_num[tamanho-6];
  inv_hex_num[6] = hex_num[tamanho-7];
  inv_hex_num[7] = hex_num[tamanho-8];
  inv_hex_num[8] = hex_num[tamanho-9];
  inv_hex_num[9] = hex_num[tamanho-10];
  inv_hex_num[10] = hex_num[tamanho-11];
  inv_hex_num[11] = hex_num[tamanho-12];
  inv_hex_num[12] = hex_num[tamanho-13];
  inv_hex_num[13] = hex_num[tamanho-14];
  inv_hex_num[14] = hex_num[tamanho-15];
  inv_hex_num[15] = hex_num[tamanho-16];
  inv_hex_num[tamanho] = '\0';
  tamanho = strlen(inv_hex_num);
  valor = 0;
  for(ind=0;ind<tamanho;ind++)
    {
    if (inv_hex_num[ind] == '0') let_num = 0; if (inv_hex_num[ind] == '1') let_num = 1;
    if (inv_hex_num[ind] == '2') let_num = 2; if (inv_hex_num[ind] == '3') let_num = 3;
    if (inv_hex_num[ind] == '4') let_num = 4; if (inv_hex_num[ind] == '5') let_num = 5;
    if (inv_hex_num[ind] == '6') let_num = 6; if (inv_hex_num[ind] == '7') let_num = 7;
    if (inv_hex_num[ind] == '8') let_num = 8; if (inv_hex_num[ind] == '9') let_num = 9;
    if (inv_hex_num[ind] == 'A') let_num = 10; if (inv_hex_num[ind] == 'B') let_num = 11;
    if (inv_hex_num[ind] == 'C') let_num = 12; if (inv_hex_num[ind] == 'D') let_num = 13;
    if (inv_hex_num[ind] == 'E') let_num = 14; if (inv_hex_num[ind] == 'F') let_num = 15;
    valor = valor + (let_num * power(16,ind));
    }
  return(valor);
  } // hex2dec

/*
*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*
|                                                                           *
*  Rotine      : main()                                                     |
|  Description : Main Program                                               *
*  Input       : ----                                                       |
|  Return      : ----                                                       *
*                                                                           |
*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*
*/
int main(int argc,char *argv[])
  {
  int c,ind;
  extern char *optarg;
  extern int optind, opterr;
  extern char optopt;
  int valor;
  char hex_str[33];
     
  if (argc <= 1)
    {
    print_help_options(argv[0]);
    return(1);
    }
  else
    {
    opterr = 0;
    while ((c=getopt(argc, argv, "id:h:")) != -1)
       {
       switch (c)
         {
         case 'i': {
                   print_software_license();
                   return 0;
                   }
         case 'd': {
                   // Verify if it's a number if not return 0 (if we think
                   // better this can be a bug, because if we put 0 as a
                   // number it will return 0, so I've to fix this standart
                   // rotine with one mine, next time)
                   valor = atoi(optarg);
                   if (valor == 0)
                     {
                     printf("%s is not a valid decimal value",optarg);
                     return(0);
                     }
                   else
                     {
                     printf("Decimal : %d\n",valor);
                     // Convert dec2hex using a function from DJGPP C Lib
                     itoa(valor, hex_str, 16);
                     // Make a Upper string, just to make this more beautifull
                     strupr(hex_str);
// I'm calculating all things to print the next string to the display in
// hexdecimal notation...
                     printf("Hexdecimal : %s\n",hex_str);
// But we can be smarter and use a very easy thing that exists on the
// Standart C Lib, that is using printf with the option X to represent
// hex numbers ;)))
     //              printf("Hexdecimal : %X\n",valor);
                     }
                   return(0);
                   }
         case 'h': {
                   for(ind=0;ind<strlen(optarg);ind++)
                     {
                     if ((optarg[ind]=='0') || (optarg[ind]=='1') ||
                         (optarg[ind]=='2') || (optarg[ind]=='3') ||
                         (optarg[ind]=='4') || (optarg[ind]=='5') ||
                         (optarg[ind]=='6') || (optarg[ind]=='7') ||
                         (optarg[ind]=='8') || (optarg[ind]=='9') ||
                         (optarg[ind]=='A') || (optarg[ind]=='a') ||
                         (optarg[ind]=='B') || (optarg[ind]=='b') ||
                         (optarg[ind]=='C') || (optarg[ind]=='c') ||
                         (optarg[ind]=='D') || (optarg[ind]=='d') ||
                         (optarg[ind]=='E') || (optarg[ind]=='e') ||
                         (optarg[ind]=='F') || (optarg[ind]=='f'))
                       { // do nothing
                       }
                     else
                       {
                       printf("%s is not a valid hexdecimal value",optarg);
                       return(0);
                       }
                     }
                   strupr(optarg);
                   printf("Hexdecimal : %s\n",optarg);
                   /// CONVERT
                   printf("Decimal : %d",hex2dec(optarg));
                   return(0);
                   }
         case '?': {
                   print_help_options(argv[0]);
                   return(1);
                   }
         }  // switch
       } // while
    } // else
  } // main
#endif

