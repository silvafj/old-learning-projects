/* MAGICO5.C                                                                */
/* Programa do n£mero m†gico - melhoramento 5                               */
/* Made on 17th of January of 1998                                          */
/* By Fernando JA Silva  ( ^Magico^ )				            */

#include <stdio.h>

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/* Funá∆o getnum                                                           */
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
int getnum()
  {
  char s[80];

  fflush(stdin);
  gets(s);
  return(atoi(s)); /* converte para inteiro */
  } /* End function getnum */

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*                             MAIN PROGRAM                                */
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
int main(void)
{
char option;
int  magic;

do
  {
  printf("1. Define um novo numero magico\n");
  printf("2. Jogo\n");
  printf("3. Fim\n");
  do
    {
    printf("Introduza a sua opá∆o : ");
    option = getchar();
    fflush(stdin);
    }
  while (option < '1' || option > '3');
  switch(option)
    {
    case '1' : magic = next_magic();
               break;
    case '2' : play(magic);
               break;
    case '3' : printf("Tchau!!!\n");
               break;
    }
  }
while (option != '3');
return 0;
}

/* Funá∆o "next_magic" */
/* ê utilizado para introduzir um novo numero m†gico para tentar adivinhar */
int next_magic()
{
printf("Entre com um novo mumero magico : ");
return(getnum());
}

/* Funá∆o "play" */
/* Esta Ç a funá∆o que realiza o jogo, recebe como parametro um valor inteiro */
int play(m)
int m;
{
register int t;
         int x;

for (t = 0;t < 10;t++)
  {
  printf("Adivinhe o numero : ");
  x = getnum();
  if (x == m)
    {
    printf("** CERTO **");
    return 0;
    }
  else
    if (x < m) printf("Muito baixo.\n");
    else printf("Muito Alto.\n");
  }
printf("Vocà esgotou o numero de tentativas...");
printf("Tente novamente.\n");
}
