/* MAGICO1.C                                                                */
/* Programa do n£mero m gico - melhoramento 1                               */
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
if (guess == magic) printf("** CERTO **\n");
else printf("... Errado ...\n");
return 0;
}
