/* POINTERS.C                                                               */
/* Made on 15th of January of 1998                                          */
/* By Fernando JA Silva  ( ^Magico^ )				            */

#include <stdio.h>

int main()
{
int target,source; /* duas vari veis inteiras */
int *m; /* ponteiro para uma vari vel inteira */

source = 10;
printf("Source : %d\n",source);
m = &source; /* ponteiro "m", aponta para a posi‡Æo de mem¢ria onde se */
             /* localiza o valor da vari vel "source"                  */
target = *m; /* a vari vel "target" vai receber o valor guardado na    */
             /* posi‡Æo de mem¢ria apontada pelo ponteiro "m"          */
printf("Target : %d\n",target);
return 0;
}
