/* MAGICO6.C                                                                */
/* Programa do n£mero m gico - melhoramento 6                               */
/* Made on 17th of January of 1998                                          */
/* By Fernando JA Silva  ( ^Magico^ )				            */

#include <stdio.h>
#include <conio.h>

  /* Variaveis globais */

  int mcount; /* Esta vari vel global ira indexar o vector de               */
              /* numeros m gicos m[..]                                      */
  int m[10];  /* vector de numeros m gicos                                  */

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  */
/* Fun‡Æo getnum                                                            */
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  */
int getnum()
  {
  char s[80];

  fflush(stdin);
  gets(s);
  return(atoi(s)); /* converte para inteiro */
  } /* End function getnum */

/* Fun‡Æo "init_magic" */
/* Inicializa o numero m gico */
int init_magic()
{
mcount = 0;
m[0] = 23;
m[1] = 123;
m[2] = 17;
m[3] = 076;
m[4] = 1998;
m[5] = 2000;
m[6] = 234;
m[7] = 999;
m[8] = 1000;
m[9] = 7;
printf("Numeros m gicos inicializados...\n");
return(m[mcount]);
}

/* Fun‡Æo "next_magic" */
/*  utilizado para introduzir um novo numero m gico para tentar adivinhar */
int next_magic()
{
mcount++;
if (mcount > 9) mcount = 0;
printf("Outro numero m gico inicializado...\n");
clrscr();
return(m[mcount]);
}

/* Fun‡Æo "play" */
/* Esta ‚ a fun‡Æo que realiza o jogo, recebe como parametro um valor inteiro */
int play(m)
int m;
{
register int t;
         int x;
         int tentativas = 10;

clrscr();
for (t = 0;t < tentativas;t++)
  {
  printf("Adivinhe o numero : ");
  x = getnum();
  if (x == m)
    {
    printf("** CERTO **\n");
    clrscr();
    return 0;
    }
  else
    if (x < m) printf("Muito baixo.\n");
    else printf("Muito Alto.\n");
    printf("Vocˆ tem %d tentativas possiveis\n",tentativas - t - 1);
  }
printf("Vocˆ esgotou o numero de tentativas...");
printf("Tente novamente.\n");
clrscr();
}

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  */
/*                             MAIN PROGRAM                                 */
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  */
int main(void)
{
int  option;
int  magic;

magic = init_magic();
clrscr();
do
  {
  printf("Jogo do n£mero m gico\n");
  printf("\n");
  printf("1. Define um novo numero magico\n");
  printf("2. Jogo\n");
  printf("3. Fim\n");
  printf("\n");
  do
    {
    gotoxy(1,7);
    printf("Introduza a sua op‡Æo : ");
    option = getnum();
    }
  while (option < 1 || option > 3);
  switch(option)
    {
    case 1 : magic = next_magic();
             break;
    case 2 : play(magic);
             break;
    case 3 : printf("Tchau!!!\n");
             break;
    }
  }
while (option != 3);
return 0;
}
