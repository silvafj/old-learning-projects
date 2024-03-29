/*
                              FILE INFORMATION
 ----------------------------------------------------------------------------
 - FILE            : SEQUENC.C                                              -
 - MODULE          : Main module                                            -
 - PROGRAM         : Sequenciador                                           -
 - DESCRIPTION     : This program sends values to the output port           -
 - VERSION         : 1.0.0                                                  -
 - AUTHOR          : Fernando J.A. Silva (aka ^Magico^)                     -
 - DATE            : 13th October, 1998                                     -
 ----------------------------------------------------------------------------

*/
#ifndef	__Sequenc_
#define	__Sequenc_

// Include Standard libraries
#include <stdio.h>
#include <keys.h>

// Define Program information
char sequenc_version[20] = "Sequenciador v1.0.0";
unsigned main_velocidade;

// Define FILE variables.
FILE *sequenc; // Target file

void print_main_menu()
  {
  cprintf("A様様様様様様様様様様様様� S E Q U E N C I A D O R 様様様様様様様様様様様様様様A");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                           1 - Executar sequ�ncia                             �");
  cprintf("�                                                                              �");
  cprintf("�                           2 - Criar nova sequ�ncia                           �");
  cprintf("�                                                                              �");
  cprintf("�                           3 - Sair                                           �");
  cprintf("�                                                                              �");
  cprintf("�                    ( Pressione a tecla da op��o correspondente )             �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("V様様様様様様様様様様様様様様様� V1.0.0 様様様様様様様様様様様様様様様様様様様�V");
  } // print_main_menu()

int isbin1(char binstr[10],int pos)
  {
  if (binstr[pos] == '1')
  return(1);
  else return(0);
  } // isbin1

void print_screen_leds(int valor)
  {
  char bin_str[10];

  gotoxy(30,21);
  cprintf("o o o o o o o o");
  itoa(valor,bin_str,2);
//  if (isbin1(bin_str,0) == 1)
  if (bin_str[7] == '1')
    {
    gotoxy(30,21);
    cprintf("*");
    }
//  if (isbin1(bin_str,1) == 1)
  if (bin_str[6] == '1')
    {
    gotoxy(32,21);
    cprintf("*");
    }
//  if (isbin1(bin_str,2) == 1)
  if (bin_str[5] == '1')
    {
    gotoxy(34,21);
    cprintf("*");
    }
//  if (isbin1(bin_str,3) == 1)
  if (bin_str[4] == '1')
    {
    gotoxy(36,21);
    cprintf("*");
    }
//  if (isbin1(bin_str,4) == 1)
  if (bin_str[3] == '1')
    {
    gotoxy(38,21);
    cprintf("*");
    }
//  if (isbin1(bin_str,5) == 1)
  if (bin_str[2] == '1')
    {
    gotoxy(40,21);
    cprintf("*");
    }
//  if (isbin1(bin_str,6) == 1)
  if (bin_str[1] == '1')
    {
    gotoxy(42,21);
    cprintf("*");
    }
//  if (isbin1(bin_str,7) == 1)
  if (bin_str[0] == '1')
    {
    gotoxy(44,21);
    cprintf("*");
    }
  } // print_screen_leds


void print_executar_menu()
  {
  int old_x,old_y;
  char nome[15];
  char exe_seq[15];
  char str[15];
  int movimentos;
  int retardo;
  int movimento;
  int novox, novoy;
  int i;
  int valores[50];
  int retardos[50];
  int tecla;
  int sair;
  int temp;

  cprintf("A様様様様様様様様様様様様様 Sequ�ncias existentes 様様様様様様様様様様様様様様�A");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("V様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様V");
  old_x = wherex();
  old_y = wherey();
  novox = 3;
  novoy = 2;
  rewind(sequenc);
  while ((fgets(nome, sizeof(nome), sequenc)) != NULL)
    {
    if (strncmp(nome,"#", 1) == 0)
      {
      gotoxy(novox,novoy);
      cprintf("%s\n",nome);
      novoy++;
      }
    }
  gotoxy(10,23);
  cprintf("Introduza o nome da sequ�ncia para executar : ");
  scanf("%s",exe_seq);
  gotoxy(old_x,old_y);
  ////////  EXECUTAR //////////
  rewind(sequenc);
  while ((fgets(nome, sizeof(nome), sequenc)) != NULL)
    {
    if (strstr(nome,exe_seq) != NULL)
      {
      fgets(str, sizeof(str), sequenc);
      movimentos = atoi(str);
      for(i=1;i<=movimentos;i++)
        {
        fgets(str, sizeof(str), sequenc);
        sscanf(str,"%X",&movimento);
        fgets(str, sizeof(str), sequenc);
        sscanf(str,"%d",&retardo);
        valores[i] = movimento;
        retardos[i] = retardo;
        }
      }
    }
  cprintf("A様様様様様様様様様様様様様       Executando      様様様様様様様様様様様様様様�A");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                  Aqui pode mudar a velocidade de andamento.                  �");
  cprintf("�                  Para isso basta utilizar as teclas:                         �");
  cprintf("�                       1 - Para aumentar                                      �");
  cprintf("�                       2 - Para diminuir                                      �");
  cprintf("�                       3 - Para sair da sequ�ncia                             �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                A velocidade actual �                                         �");
  cprintf("�                                                                              �");
  cprintf("�                ( Valor mais alto torna sequ�ncia mais lenta)                 �");
  cprintf("�   O valor especificado � o tempo em milisegundos que existir� de retardo.    �");
  cprintf("�                                                                              �");
  cprintf("�                   ----===[ 1000 msec = 1 sec ]===----                        �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("V様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様V");
  old_x = wherex();
  old_y = wherey();
  gotoxy(30,2);
  cprintf("%s",exe_seq);
  sair = 0;
  i = 1;
  while (sair == 0)
    {
    if (kbhit() != 0) tecla = getxkey();
    switch(tecla)
      {
      case 49 : {
                main_velocidade=main_velocidade+50;
                gotoxy(40,12);
                cprintf("%u  ",main_velocidade);
                tecla = 0;
                break;
                } // tecla '1'
      case 50 : {
                if (main_velocidade > 50) main_velocidade=main_velocidade-50;
                gotoxy(40,12);
                cprintf("%u  ",main_velocidade);
                tecla = 0;
                break;
                } // tecla '2'
      case 51 : {
                sair = 1;
                tecla = 0;
                break;
                } // tecla '3'
      } // switch...
    temp = valores[i];
    outportb(0x378,valores[i]);
//    print_screen_leds(valores[i]);
    temp = retardos[i];
    usleep((temp+main_velocidade)*1000);
    if (i<=movimentos) i++;
    else i = 1;
    }
  gotoxy(old_x,old_y);
  } // print_executar_menu()

void print_criar_menu()
  {
  int old_x,old_y;
  char nome[9];
  int movimentos;
  int retardo;
  int movimento;
  int i;

  cprintf("A様様様様様様様様様様様様様   Criando Sequ�ncias  様様様様様様様様様様様様様様�A");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("�                                                                              �");
  cprintf("V様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様V");
  old_x = wherex();
  old_y = wherey();
  gotoxy(5,3);
  cprintf("Introduza o nome da sequ�ncia (max 8 letras) : ");
  scanf("%s", nome);
  gotoxy(5,5);
  cprintf("Agora vai ser criada a sequ�ncia.");
  gotoxy(5,6);
  cprintf("Qual o valor de movimentos da sequ�ncia (max 50) : ");
  scanf("%d",&movimentos);
  fprintf(sequenc,"#%s\n",nome);
  fprintf(sequenc,"%d\n",movimentos);
  for(i=1;i<=movimentos;i++)
    {
    gotoxy(5,7);
    cprintf("Movimento %d (em hex) :             ");
    gotoxy(5,8);
    cprintf("Retardo (em msec) :                ");
    gotoxy(28,7);
    scanf("%X",&movimento);
    gotoxy(25,8);
    scanf("%d",&retardo);
    fprintf(sequenc,"%X\n",movimento);
    fprintf(sequenc,"%d\n",retardo);
    }
  gotoxy(old_x,old_y);
  } // print_criar_menu()
  

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
  int tecla;
  
  main_velocidade = 500 ;
  // Clear the screen
  clrscr();
  // Print some information
  cprintf("%s makes sequencing lights on the parallel port\n\r",sequenc_version);
  cprintf("(C) 1998 Fernando J.A. Silva <magico@GalaxyCorp.com>\n\r");
  cprintf("\n\r");
  cprintf("Thanks to : Casainho e a todos os chatos...\n\r");
  cprintf("\n\r");
  cprintf("Announcements : \n\r");
  cprintf("    - Compre software 'pirata'\n\r");
  cprintf("    - Use Micro Programa Janelas 98\n\r");
  cprintf("    - Fa�a da disciplina de F�sica a sua favorita\n\r");
  cprintf("    - E a de Sistemas Digitais tamb�m... :)))) \n\r");
  cprintf("    - E 'coma' muitas gajas nos anivers�rios dos amigos\n\r");
  cprintf("\n\r");
  cprintf("Initializing program...\n\r");
  if (argc<=1)
    {
    cprintf("\n\r");
    cprintf("Initializing motherboard... wait 1 second\n\r");
    sleep(1);
    cprintf("\n\r");
    cprintf("Initializing parallel port... wait 2 second\n\r");
    sleep(2);
    cprintf("\n\r");
    cprintf("Initializing soundboard... wait 1 second\n\r");
    sleep(1);
    cprintf("\n\r");
    cprintf("And FINALLY trying to initializing PLACA 3D RIVA TNT 128... wait...\n\r");
    sleep(2);
    cprintf(" wait...\n\r");
    sleep(1);
    cprintf(" wait...\n\r");
    sleep(2);
    cprintf(" wait...\n\r");
    sleep(1);
    cprintf("No 3D RIVA TNT 128 card found... so isn't necessary... continuing the program\n\r");
    }
  sleep(3);
  // Clear the screen
  clrscr();
  print_main_menu();
  while ((tecla = getxkey()) != 51 ) // tecla 51 = '3'
    {
    switch(tecla)
      {
      case 49 : {
                // Create the target file and open it for reading.
                // Force the file to be open in text mode.
                sequenc = fopen("SEQUENC.DAT","rt");
                print_executar_menu();
                fclose(sequenc);
                print_main_menu();
                break;
                } // tecla '1'
      case 50 : {
                // Create the target file and open it for writing at it's end.
                // Force the file to be open in text mode.
                sequenc = fopen("SEQUENC.DAT","at");
                print_criar_menu();
                fclose(sequenc);
                print_main_menu();
                break;
                } // tecla '2'
      } // switch...
    }
  return 0;
  }
#endif