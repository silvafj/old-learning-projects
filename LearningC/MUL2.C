/* MUL2.C                                                                  */
/* Made on 12th of January of 1998                                         */

#include <stdio.h>

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/* Funá∆o mul								   */
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
int mul(x,y)
  int x,y; /* aqui x e y s∆o declaradas como vari†veis inteiras */

  {
  return(x * y); /* retorna o produto dos argumentos */
  } /* End function mul */

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/* Funá∆o getnum                                                           */
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
  int a,b,c;

  printf("Digite dois n£meros\n");
  a = getnum();
  b = getnum();
  c = mul(a,b);
  printf("%d * %d = %d\n",a,b,c); /* imprime "a" "b" "c" em decimal com printf */
  return 0;
  } /* End Main Program */
