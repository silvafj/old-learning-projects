/* GET.C                                                                   */
/* Made on 13th of January of 1998                                         */
/* Using DJGPP 2                                                           */

#include <stdio.h> /* Includes standard libraries */

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/*                             MAIN PROGRAM                                */
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
int main(void)
  {
  char string[80]; /* define um vector de oitenta caracteres */

  gets(string); /* utiliza a rotina da biblioteca C paara ler uma s‚rie de */
                /* caracteres do teclado                                   */
  printf(string); /* imprime a s‚rie de caracteres                         */

  /* agora imprime os trˆs primeiros caracteres                            */

  printf("\n%c%c%c\n",string[0],string[1],string[2]);
  return 0;
  } /* End Main Program */
