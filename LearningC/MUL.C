/* MUL.C							           */
/* Made on 12th of January of 1998                                         */

#include <stdio.h>

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/* Funá∆o mul								   */
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
int mul(x,y)
  int x,y; /* aqui x e y s∆o declaradas como vari†veis inteiras */

  {
  return(x * y); /* retorna o produto dos argumentos */
  }

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*                             MAIN PROGRAM                                */
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
int main(void)
  {
  int x,y,j,k,p;

  x = 1;
  y = 2;
  p = mul(x,y);     /* o resultado ser† 2 */
  printf("%d\n",p); /* imprime p em decimal com printf */

  j = 234;
  k = 10;
  p = mul(j,k); /* o resultado ser† 2340 */
  printf("%d\n",p);

  return 0;
  }
