/*
                          INFORMA€ÇO DO FICHEIRO
 ----------------------------------------------------------------------------
 - FICHEIRO       : STARS.C                                                 -
 - DESCRI€ÇO      : Este programa cria um campo de estrelas do tipo         -
 -                  Parallax/Multi-Layered                                  -
 - VERSAO         : 0.1                                                     -
 - PROGRAMADOR    : Fernando J.A. Silva (aka ^Magico^)                      -
 - DATA           : 14th April, 1998                                        -
 ----------------------------------------------------------------------------
 - AGRADECIMENTOS                                                           -
 - ~~~~~~~~~~~~~~                                                           -
 - Bernie Pallek -- foi pelo tutorial que ele fez que eu aprendi o          -
 -                  essencial sobre este tipo de efeito                     -
 -                                                                          -
 ----------------------------------------------------------------------------

*/
#ifndef __STARFIELD_
#define __STARFIELD_

#include <stdio.h>
#include <conio.h>
#include <go32.h>
#include "vbe20.c"

// Constantes
int max_stars = 300; // Este valor pode-se aumentar para criar um efeito de
                     // intensidade no campo de estrelas
long star_color[3] = {8, 7, 15}; // vector contendo o valor das 3 cores que
                                 // vÆo ser usadas para criar o efeito de
                                 // distƒncia at‚ 3 niveis
float x_inc = -2;  // estes dois valores vÆo controlar a velocidade, o sentido
float y_inc = 0;  // e a direc‡Æo para onde se movem as estrelas

// Estruturas
struct star_rec
  {
  int x,y,z;
  };

struct star_rec stars[300]; // Este valor deve ser mudado de acordo com a
                            // constante max_stars
// Variaveis de opera‡Æo
int max_x,max_y;


/** ** ** ** ** ** ** ** ** ** **  init_stars
** ** ** ** **/
void init_stars()
  {
  int i;

  //  Vai inicializar a estrutura 'stars' com valores randomizados
  for(i=0;i<=max_stars;i++)
    {
    stars[i].x = ((int)rand()%max_x); // valor de 0 a max_x
    stars[i].y = ((int)rand()%max_y); // valor de 0 a max_y
    stars[i].z = ((int)rand()%3);     // valor de 0 a 3
    } // for...
  } // init_stars

/** ** ** ** ** ** ** ** ** ** **  move_stars
** ** ** ** **/
void move_stars()
  {
  int i;

  // vai fazer as opera‡äes necess rias na estrutura 'stars' de modo
  // a que dˆ origem ao "movimento"
  for(i=0;i<=max_stars;i++)
    {
    // Apaga o pixel actual
    putpixel(stars[i].x, stars[i].y, 0,vidptr);
    // Quanto maior for o valor 'stars[i].z' significa que ‚ o pixel que
    // t  mais perto de n¢s e sendo assim vai ser o que se vai mover mais
    // depressa.
    stars[i].x = (int)(stars[i].x + x_inc * (stars[i].z + 1));
    // Reinicializa o valor 'x' caso este ultrapasse os limites
    if (stars[i].x < 0) stars[i].x = stars[i].x + max_x;
    if (stars[i].x > max_x) stars[i].x = stars[i].x - max_x;
    // O esquema anterior repete-se para a posi‡Æo 'y'
    stars[i].y = (int)(stars[i].y + y_inc * (stars[i].z + 1));
    if (stars[i].y < 0) stars[i].y = stars[i].y + max_y;
    if (stars[i].y > max_y) stars[i].y = stars[i].y - max_y;
    // Bem, basta colocar o pixel no ecran tendo em aten‡Æo a posi‡Æo
    // X, Y e a cor respectiva...
    putpixel(stars[i].x, stars[i].y, star_color[stars[i].z],vidptr);
    } // for...
  } // move_stars

/** ** ** ** ** ** ** ** ** ** **  retrace
** ** ** ** **/
void retrace()
  {
  while ((inportl(0x3DA) & 8) != 8);
  while ((inportl(0x3DA) & 8) == 8);
  } // retrace
/*
 * ** ** ** ** ** ** ** ** ** ** ** * MAIN * ** ** ** ** ** ** ** ** ** ** ***
 * ** ** ** **                                                 ** ** ** ** ***
*/
main()
  {
  clrscr(); // limpa o ecran
  _go32_want_ctrl_break(1); // set Ctrl-Break check TRUE
  vbe_init(800,600,8); // inicia vbe
  // Inicializa as variaveis
  max_x = screen_width;
  max_y = screen_height;
  // Inicia as estruturas
  init_stars();
  // Inicia a malha
  while (!_go32_was_ctrl_break_hit()) // if Ctrl-Break nao foi pressionada
    {
    move_stars();
    retrace();
    }
  vbe_close(); // fecha a vbe e coloca o ecran normal
  } // main
#endif
