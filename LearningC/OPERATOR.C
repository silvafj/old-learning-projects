/* OPERATOR.C                                                              */
/* Made on 13th of January of 1998                                         */

#include <stdio.h>

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/* Funá∆o getnum                                                           */
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
int getnum(void)
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
  int x,y;

  printf("Digite dois n£meros inteiros\n");
  x = getnum();
  y = getnum();

  printf("O valor da divis∆o inteira de %d por %d Ç : %d\n", x ,y ,x / y);
  printf("O resto da divis∆o Ç %d\n",x % y);
  return 0;
  } /* End Main Program */
