/* MAGICO2.C                                                                */
/* Programa do n£mero m gico - melhoramento 2                               */
/* Made on 17th of January of 1998                                          */
/* By Fernando JA Silva  ( ^Magico^ )				            */

#include <stdio.h>

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/* Fun‡Æo getnum                                                           */
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
int getnum()
  {
  char s[80];

  gets(s);
  return(atoi(s)); /* converte para inteiro */
  } /* End function getnum */

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*                             MAIN PROGRAM                                */
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
int main(void)
{
int magic = 123; /* numero m gico */
int guess;

guess = getnum(); /* ler um inteiro do teclado */
if (guess == magic)
  {
  printf("** CERTO **\n");
  printf("%d ‚ o n£mero m gico\n",magic);
  }
else
  {
  printf("... Errado ...\n");
  if (guess > magic) printf("Muito Alto.\n");
  else printf("Muito Baixo.\n");
  }
return 0;
}
