/*
                              FILE INFORMATION
 ----------------------------------------------------------------------------
 - FICHEIRO        : VBE.C                                                  -
 - DESCRI€ÇO       : VBE 2.0 Interface Routines                             -
 - AUTOR           : Fernando J.A. Silva (aka ^Magico^)                     -
 - DATA            : Feb 27 1998                                            -
 - MODULE VERSION  : 0.2                                                    -
 - MODULE LANGUAGE : C                                                      -
 - MODULE COMPILER : DJGPP 2.01                                             -
 ----------------------------------------------------------------------------
 - HISTORIAL                                                                -    
 - ~~~~~~~~~                                                                -
 - Feb 09 1998   v.0.1  + VersÆo Inicial                                    -
 - Feb 27 1998   v.0.2  + Simplifica‡Æo das rotinas essenciais              -
 -                      + Interface de informacao ao utilizador melhorada   -        
 -                                                                          -
 ----------------------------------------------------------------------------
 - CONTACTOS                                                                -
 - ~~~~~~~~~                                                                -
 - E-Mail : bfe2333@mail.telepac.pt                                         -
 - IRC    : irc.telepac.pt                                                  -
 -          irc.ua.pt                                                       -
 -          irc.ualg.pt                                                     -
 -          irc.rccn.pt                                                     -
 -                                                                          -
 ----------------------------------------------------------------------------
 - AGRADECIMENTOS                                                           -
 - ~~~~~~~~~~~~~~                                                           -
 - Toth -- foi pela LIB dele que eu aprendi o b sico da VBE2, e tb como     -
 -         utilizar determinadas rotinas do "go32" para poder usar o PMode  -
 -         ao m ximo!!!                                                     -
 -                                                                          -
 ----------------------------------------------------------------------------

*/

#ifndef __VBE20_C
#define __VBE20_C

#include <go32.h>
#include <dpmi.h>
#include <sys/nearptr.h>
#include <stdlib.h>
#include <conio.h>
#include <crt0.h>
//#include "vbe20.h"
int _crt0_startup_flags = _CRT0_FLAG_NEARPTR | _CRT0_FLAG_NONMOVE_SBRK;
/**/
#define BYTE unsigned char
#define WORD unsigned short

#define MASK_LINEAR(addr)     (addr & 0x000FFFFF)
#define RM_TO_LINEAR(addr)    (((addr & 0xFFFF0000) >> 12) + (addr & 0xFFFF))
#define RM_OFFSET(addr)       (MASK_LINEAR(addr) & 0xFFFF)
#define RM_SEGMENT(addr)      ((MASK_LINEAR(addr) & 0xFFFF0000) >> 4)

// Mode attributes flags

#define VBEMODE_CAPS_AVAILABLE	(1<<0)	// Mode is available
#define	VBEMODE_CAPS_TTYOUTPUT	(1<<2)	// TTY output is available
#define	VBEMODE_CAPS_COLORMODE	(1<<3)	// Color video mode
#define	VBEMODE_CAPS_GRAPHMODE	(1<<4)	// Graphics mode
#define	VBEMODE_CAPS_NONVGA	(1<<5)	// Non-VGA mode
#define	VBEMODE_CAPS_NONBANKED	(1<<6)	// Banked frame buffer not supported
#define	VBEMODE_CAPS_LINEAR	(1<<7)	// Linear frame buffer is supported

// Mode memory models

#define	VBEMODE_MODEL_TEXT	(0)	// Text mode
#define	VBEMODE_MODEL_CGA	(1)	// CGA mode
#define	VBEMODE_MODEL_HERCULES	(2)	// Hercules graphics mode
#define	VBEMODE_MODEL_PLANAR	(3)	// VGA planar style mode
#define	VBEMODE_MODEL_PACKED	(4)	// Packed pixel mode
#define	VBEMODE_MODEL_MODEX	(5)	// ModeX (unchained 4, 256 color)
#define	VBEMODE_MODEL_RGB	(6)	// Direct color RGB
#define	VBEMODE_MODEL_YUV	(7)	// Direct color YUV



// para sair >>>
#define MAX_MODES 1024
#define MAX_YRES  1024
// para sair <<<

#define PACKED __attribute__((packed))

// Vbe information block
typedef struct vbe_info_block
{ 
   unsigned char  VesaSignature[4]     PACKED; // 'VBE2' 4 byte signature
   unsigned short VesaVersion          PACKED; // VBE version number
   unsigned long  OemStringPtr         PACKED; // Pointer to OEM string
   unsigned char  Capabilities[4]      PACKED; // Capabilities of video card
   unsigned long  VideoModePtr         PACKED; // Pointer to supported modes
   unsigned short TotalMemory          PACKED; // Number of 64kb memory blocks
   unsigned short OemSoftwareRev       PACKED; // OEM Software revision number
   unsigned long  OemVendorNamePtr     PACKED; // Pointer to Vendor Name string
   unsigned long  OemProductNamePtr    PACKED; // Pointer to Product Name string
   unsigned long  OemProductRevPtr     PACKED; // Pointer to Product Revision str
   unsigned char  Reserved[222]        PACKED; // Pad to 256 byte block size
   unsigned char  OemData[256]         PACKED; // Scratch pad for OEM data
} vbe_info_block;

// VBE mode information block
typedef struct mode_info_block
{
   // Mandatory information for all VBE revisions:

   unsigned short ModeAttributes       PACKED; // mode attributes
   unsigned char  WinAAttributes       PACKED; // window A attributes
   unsigned char  WinBAttributes       PACKED; // window B attributes
   unsigned short WinGranularity       PACKED; // window granularity
   unsigned short WinSize              PACKED; // window size
   unsigned short WinASegment          PACKED; // window A start segment
   unsigned short WinBSegment          PACKED; // window B start segment
   unsigned long  WinFuncPtr           PACKED; // pointer to window function
   unsigned short BytesPerScanLine     PACKED; // bytes per scan line

   // Mandatory information for VBE 1.2 and above:

   unsigned short XResolution          PACKED; // horizontal resolution in pixels or chars
   unsigned short YResolution          PACKED; // vertical resolution in pixels or chars
   unsigned char  XCharSize            PACKED; // character cell width in pixels
   unsigned char  YCharSize            PACKED; // character cell height in pixels
   unsigned char  NumberOfPlanes       PACKED; // number of memory planes
   unsigned char  BitsPerPixel         PACKED; // bits per pixel
   unsigned char  NumberOfBanks        PACKED; // number of banks
   unsigned char  MemoryModel          PACKED; // memory model type
   unsigned char  BankSize             PACKED; // bank size in KB
   unsigned char  NumberOfImagePages   PACKED; // number of images
   unsigned char  Reserved_page        PACKED; // reserved for page function

   // Direct Color fields (required for direct/6 and YUV/7 memory models)

   unsigned char  RedMaskSize          PACKED; // size of direct color red mask in bits
   unsigned char  RedFieldPosition     PACKED; // bit position of lsb of red mask
   unsigned char  GreenMaskSize        PACKED; // size of direct color green mask in bits
   unsigned char  GreenFieldPosition   PACKED; // bit position of lsb of green mask
   unsigned char  BlueMaskSize         PACKED; // size of direct color blue mask in bits
   unsigned char  BlueFieldPosition    PACKED; // bit position of lsb of blue mask
   unsigned char  RsvdMaskSize         PACKED; // size of direct color reserved mask in bits
   unsigned char  RsvdFieldPosition    PACKED; // bit position of lsb of reserved mask
   unsigned char  DirectColorModeInfo  PACKED; // direct color mode attributes

   // Mandatory information for VBE 2.0 and above:

   unsigned long  PhysBasePtr          PACKED; // physical address for flat frame buffer
   unsigned long  OffScreenMemOffset   PACKED; // pointer to start of off screen memory
   unsigned short OffScreenMemSize     PACKED; // amount of off screen memory in 1k units
   unsigned char  Reserved[206]        PACKED; 
} mode_info_block;
/**/

unsigned int linear_address;  // Video Memory Offset
unsigned long screen_mem;
int screen_width;
int screen_height;
unsigned long line_mul;
unsigned char color_depth;
unsigned char nbanks;
unsigned char *vidptr;
unsigned char *buffptr;


long offsets[MAX_YRES]; //para sair
__dpmi_meminfo meminfo;

//para sair >>
void update_offsets()
  {
    WORD i;

    for(i=0;i<screen_height-1;i++)
       offsets[i]=i*line_mul;
   }
//para sair <<

/*
*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*
|                                                                           *
*  Rotina    : vbe_detect()                                                 |
|  Descri‡Æo : Esta rotina vai detectar se VBE 2.0 existe                   *
*  Input     : ----                                                         |
|  Return    : Retorna um pointer para a estrutura onde est  a informa‡Æo   *
*              sobre a VBE 2.0 ou NULL no caso de ter occorido erros.       |
|                                                                           *
*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*
*/
vbe_info_block *vbe_detect()
  {
  static vbe_info_block vbe_info;
  __dpmi_regs regs;

  //  necess rio existir um buffer para a transferˆncia de dados entre
  // o RMode e o PMode atrav‚s do DPMI.
  // Caso esse buffer seja inferior ao valor que n¢s necessitamos, entÆo
  // a opera‡Æo nÆo se efectua.
  if (sizeof(vbe_info_block) > _go32_info_block.size_of_transfer_buffer)
    return NULL;
  // Em primeiro lugar precisamos de um sitio onde colocar a nossa informa‡Æo
  // A rotina "dosmemput" serve para isso.
  // Conv‚m saber mais sobre esta rotina, pois ela d  para fazer muito mais...
  dosmemput(&vbe_info, sizeof(vbe_info_block), __tb);
  // Para que a placa retorne a informa‡Æo da VBE 2.0 ‚ obrigat¢rio que a
  // estrutura que estamos a utilizar para receber os dados recebidos
  // tenha o valor "VB2" na VesaSignature.
  dosmemput("VBE2", 4, __tb);
  // Vamos utilizar agora a fun‡Æo "Get VBE Information".
  regs.x.ax = 0x4F00;
  // Segmento e...
  regs.x.es = RM_SEGMENT(__tb);
  // Offset do buffer para onde ser  colocada a informa‡Æo
  //  preciso notar que "__tb" tem de ser convertido de PMode para RMode
  // para poder ser chamado.
  regs.x.di = RM_OFFSET(__tb);
  // E utilizamos a rotina "__dpmi_int" para simular uma interrup‡Æo.
  //  necess rio lembrar que estamos a trabalhar em PMode e NÇO podemos
  // utilizar as interrup‡äes como se costumam utilizar no RMode.
  //  necess rio chamar SEMPRE uma interrup‡Æo atrav‚s da fun‡Æo AX = 0x0300
  // da DPMI INT = 0x31
  __dpmi_int(0x10, &regs);
  // Se "regs.h.ah" tiver um valor diferente de 0, entÆo ‚ porque algum erro
  // ocorreu. O valor a¡ existente corresponde a um determinado erro.
  // No nosso caso interessa-nos unicamente retornar NULL, para identificar
  // somente a ocorrˆncia de um erro geral.
  if (regs.h.ah) return NULL;
  // Depois de termos utilizado a fun‡Æo que n¢s d  a informa‡Æo acerca da
  // VBE, e a coloca num buffer, ‚ necess rio agora colocar essa informa‡Æo
  // na nossa estrutura (aquela que vamos utilizar).
  dosmemget(__tb, sizeof(vbe_info_block), &vbe_info);
  // Se VesaSignature nÆo contem o valor "VESA" ‚ porque algum erro ocorreu
  if (strncmp(vbe_info.VesaSignature, "VESA",2) != 0) return NULL;
  // Agora s¢ falta fazer a conversÆo dos pointers, retornados na estrutura,
  // de RMode para o famoso Linear Offset do PMode
  vbe_info.OemStringPtr = RM_TO_LINEAR(vbe_info.OemStringPtr);
  vbe_info.OemVendorNamePtr = RM_TO_LINEAR(vbe_info.OemVendorNamePtr);
  vbe_info.OemProductNamePtr = RM_TO_LINEAR(vbe_info.OemProductNamePtr);
  vbe_info.OemProductRevPtr = RM_TO_LINEAR(vbe_info.OemProductRevPtr);
  // E retornamos a informa‡Æo...
  return &vbe_info;
  } // vbe_detect()

/*
*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*
|                                                                           *
*  Rotina    : vbe_get_mode_info()                                          |
|  Descri‡Æo : Esta rotina vai detectar o modo pedido                       *
*  Input     : ----                                                         |
|  Return    : Retorna um pointer para a estrutura onde est  a informa‡Æo   *
*              sobre o modo ou NULL no caso de ter occorido erros.          |
|                                                                           *
*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*
*/
mode_info_block *vbe_get_mode_info(int mode)
  {
  static mode_info_block mode_info;
  __dpmi_regs regs;

  //  necess rio existir um buffer para a transferˆncia de dados entre
  // o RMode e o PMode atrav‚s do DPMI.
  // Caso esse buffer seja inferior ao valor que n¢s necessitamos, entÆo
  // a opera‡Æo nÆo se efectua.
  if (sizeof(mode_info_block) > _go32_info_block.size_of_transfer_buffer)
    return NULL;
  // Vamos utilizar agora a fun‡Æo "Get VBE Mode Information".
  regs.x.ax = 0x4F01;
  // O modo
  regs.x.cx = mode;
  // Segmento e...
  regs.x.es = RM_SEGMENT(__tb);
  // Offset do buffer para onde ser  colocada a informa‡Æo
  //  preciso notar que "__tb" tem de ser convertido de PMode para RMode
  // para poder ser chamado.
  regs.x.di = RM_OFFSET(__tb);
  // E utilizamos a rotina "__dpmi_int" para simular uma interrup‡Æo.
  //  necess rio lembrar que estamos a trabalhar em PMode e NÇO podemos
  // utilizar as interrup‡äes como se costumam utilizar no RMode.
  //  necess rio chamar SEMPRE uma interrup‡Æo atrav‚s da fun‡Æo AX = 0x0300
  // da DPMI INT = 0x31
  __dpmi_int(0x10, &regs);
  // Se "regs.h.ah" tiver um valor diferente de 0, entÆo ‚ porque algum erro
  // ocorreu.
  if (regs.h.ah) return NULL;
  // Depois de termos utilizado a fun‡Æo que n¢s d  a informa‡Æo acerca da
  // VBE, e a coloca num buffer, ‚ necess rio agora colocar essa informa‡Æo
  // na nossa estrutura (aquela que vamos utilizar).
  dosmemget(__tb, sizeof(mode_info_block), &mode_info);
  // E retornamos a informa‡Æo...
  return &mode_info;
  } // vbe_get_mode_info()

/*
*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*
|                                                                           *
*  Rotina    : vbe_set_mode(int mode)                                       |
|  Descri‡Æo : Esta rotina iniciar o modo pretendido                        *
*  Input     : int mode --> valor do modo que queremos inicializar          |
|  Return    : Retorna 0 se nenhum erro ocorrer.                            *
*              Caso contr rio retorna -1.                                   |
|                                                                           *
*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*
*/
int vbe_set_mode(int mode)
  {
  __dpmi_regs regs;
  mode_info_block *mode_info;
  // Video descriptor, ‚ necess rio quando se faz o mapeamento do
  // Linear Address
  short video_ds = 0;

  // Primeiro queremos saber toda a informa‡Æo sobre o modo.
  mode_info = vbe_get_mode_info(mode);
  // Vamos mapear a mem¢ria de video para Linear Address.
  // No caso de inicializarmos outro modo depois de j  termos iniciado um
  // anterior, libertamos a mem¢ria do anterior para mapearmos a do novo modo.
  if (linear_address==meminfo.address)
  __dpmi_free_physical_address_mapping(&meminfo);
  // Introduzimos os valores correspondentes na estrutura que vai ser
  // utilizada pela fun‡Æo de mapeamento.
  // O tamanho do nosso linear address
  meminfo.size = screen_mem;
  // O physical address a ser mapeado
  meminfo.address = mode_info->PhysBasePtr;
  // Se a fun‡Æo de mapeamento retornar -1, algum erro ocorreu. Caso contr rio
  // o nosso linear address passa a ser o anterior, mas j  mapeado.
  if (__dpmi_physical_address_mapping(&meminfo)==-1) return -1;
    linear_address = meminfo.address;
  // Agora vamos inicializar o modo
  // Vamos utilizar a fun‡Æo "Set VBE Mode"
  regs.x.ax=0x4F02;
  // Introduzimos o modo, mas com uma particularidade.  que para podermos
  // utilizar o LFB, ‚ necess rio que o bit 14 esteja colocado a "1", por isso
  // ‚ que existe este "OR" aritm‚tico do "modo" com o valor 4000 hexadecimal
  regs.x.bx=mode | 0x4000;
  // E utilizamos a rotina "__dpmi_int" para simular uma interrup‡Æo.
  //  necess rio lembrar que estamos a trabalhar em PMode e NÇO podemos
  // utilizar as interrup‡äes como se costumam utilizar no RMode.
  //  necess rio chamar SEMPRE uma interrup‡Æo atrav‚s da fun‡Æo AX = 0x0300
  // da DPMI INT = 0x31
  __dpmi_int(0x10,&regs);
  // Se "regs.h.ah" tiver um valor diferente de 0, entÆo ‚ porque algum erro
  // ocorreu.
  if(regs.h.ah) return -1;
  // Vamos alocar 1 descriptor para o nosso linear_address
  video_ds=__dpmi_allocate_ldt_descriptors(1);
  // O base address
  __dpmi_set_segment_base_address(video_ds,linear_address);
  // E limite m ximo
  __dpmi_set_segment_limit(video_ds,screen_mem|0xfff);
  // Esta ‚ uma rotina tendo em conta a parte gr fica. Ela cria uma tabela
  // de valores para os quais se pode "escrever" um pixel. Isto faz com que
  // a macro "putpixel" e "getpixel" funcionem muito mais rapidamente do que
  // se fossem rotinas comuns. No entanto existe ainda um pequeno problema:
  // esta rotina s¢ consegue criar a tabela para modos de 256 cores!!!
  update_offsets();
  // Ora bem... s¢ falta criarmos o verdadeiro pointer, sim, verdadeiro
  // porque ser  aquele que iremos utilizar para escrevermos no nosso
  // linear address.
  vidptr=(char *)(linear_address + __djgpp_conventional_base);
  // Tamb‚m teremos um buffer para esse linear address
  if(buffptr!=NULL) free(buffptr);
  // Se nÆo o tivermos entÆo saimos...
  if((buffptr=malloc(screen_mem))==NULL) return -1;
  // Tamb‚m interressa saber o numero de bancos de mem¢ria.
  nbanks = mode_info->NumberOfBanks;
  // Retorna 0 se tudo correu bem.
  return 0;
  } // vbe_set_mode()

/*
*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*
|                                                                           *
*  Rotina    : vbe_close()                                                  |
|  Descri‡Æo : Esta rotina finaliza o modo VBE actual                       *
*  Input     : ----                                                         |
|  Return    : ----                                                         *
*                                                                           |
|                                                                           *
*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*
*/
void vbe_close()
  {
  __dpmi_regs regs;

  // Vamos iniciar o modo de texto 80*25
  regs.x.ax = 0x3;
  // E utilizamos a rotina "__dpmi_int" para simular uma interrup‡Æo.
  //  necess rio lembrar que estamos a trabalhar em PMode e NÇO podemos
  // utilizar as interrup‡äes como se costumam utilizar no RMode.
  //  necess rio chamar SEMPRE uma interrup‡Æo atrav‚s da fun‡Æo AX = 0x0300
  // da DPMI INT = 0x31
  __dpmi_int(0x10,&regs);
  // Liberta a mem¢ria mapeada pela fun‡Æo "__dpmi_physical_address_mapping"
  __dpmi_free_physical_address_mapping(&meminfo);
  // E libertamos o nosso "buffer"
  free(buffptr);
  } // vbe_close()

/*
*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*
|                                                                           *
*  Rotina    : vbe_search_mode(int xres, int yres, unsigned char bpp)       |
|  Descri‡Æo : Esta rotina procura um modo correspondente aos valores dados *
*  Input     : int xres --> Resolu‡Æo X                                     |
|              int yres --> Resolu‡Æo Y                                     *
*              unsigned char bpp --> numero de bits da cor                  |
|  Return    : Retorna -1 em caso de erro ou se nÆo encontrar um modo.      *
*              Caso contr rio retorna o valor do modo.                      |
|                                                                           *
*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*
*/
int vbe_search_mode(int xres, int yres, unsigned char bpp)
  {
  vbe_info_block *vbe_info;
  mode_info_block *mode_info;
  unsigned short mode_list[MAX_MODES], vesa_mode = 0;
  unsigned long addr;
  static WORD n_modes;
  int i;

  // Detectamos a VBE
  vbe_info=vbe_detect();

  _farsetsel(_dos_ds);
  i = 0;
  // Convertemos um pointer RMode para Linear
  addr = RM_TO_LINEAR(vbe_info->VideoModePtr);
  // Come‡amos a procurar todos os modos at‚ o valor ser 0xFFFF e guardamos
  // o valor dos modos num vector.
  while(_farnspeekw(addr) != 0xFFFF)
    {
    mode_list[i] = _farnspeekw(addr);
    i++;
    addr+=2;
    }
  if (!i) return -1;
  n_modes = i - 1;

  // Vamos encontrar o modo, percorrendo a lista e verificando os nossos dados
  // com os do modo.
  for (i=0; i<n_modes; i++)
    {
    if ((mode_info=vbe_get_mode_info(mode_list[i])) != NULL)
      if ((mode_info->ModeAttributes &     1) &&  // O modo existe
          (mode_info->ModeAttributes &     8) &&  //  a cores
          (mode_info->ModeAttributes &    16) &&  //  gr fico
	  (mode_info->ModeAttributes &  0x80) &&  // O LFB existe
	  (mode_info->XResolution    == xres) &&
	  (mode_info->YResolution    == yres) &&
	  (mode_info->NumberOfPlanes ==    1) &&
	  (mode_info->BitsPerPixel   ==  bpp) &&
	  (((mode_info->MemoryModel  ==    4) && (bpp == 8)) ||
           ((mode_info->MemoryModel   ==    6))))
      {
      vesa_mode=mode_list[i];
      i=n_modes;
       }
    }
  // Retornamos o valor do modo
  return vesa_mode;
  } // vbe_search_mode()

/*
*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*
|                                                                           *
*  Rotina    : vbe_init()                                                   |
|  Descri‡Æo : Esta rotina inicia o modulo, verificando todos os dados e    *
*              informando no caso de erros e de sucessos. Muito simples e   |
|              muito pr tico.                                               *
*  Input     : ----                                                         |
|  Return    : Retorna -1 em caso de erro.                                  *
*              Caso contr rio retorna 0.                                    |
|                                                                           *
*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*
*/
int vbe_init(int xres, int yres, BYTE bpp)
  {
  // variaveis de controle
  vbe_info_block *vbe_info;
  mode_info_block *mode_info;
  int vbe_mode = 0;
  int error = 0;

  // Mostra as informacoes sobre o modulo a iniciar
  textcolor(2);
  cprintf("VBE Interface Routines Module v.0.2 (Fev 27 1998)\n\r");
  cprintf("Copyright (c) 1997-1998 by ^Magico^\n\r");

  // Comeca por verificar a existencia da VBE
  textcolor(15);
  cprintf("  þ VESA Bios Extensions : ");
  vbe_info = vbe_detect(); // detecta a VBE e copia a informacao para uma
                           // struct apontada por vbe_info
  if (vbe_info == NULL)
    {
    textcolor(12);
    cprintf("NOT Detected\n\r");
    return(-1);
    }
  else
    {
    textcolor(9);
    cprintf("Detected\n\r");
    }
  vbe_mode = vbe_search_mode(xres,yres,bpp);
  textcolor(15);
  cprintf("  þ Version : ");
  if (vbe_info->VesaVersion < 0x0200)
    {
    textcolor(12);
    cprintf("%d.%d\n\r",vbe_info->VesaVersion >> 8, vbe_info->VesaVersion & 0x00FF);
    cprintf("This module only works with VBE 2.0 or higher\n\r");
    return(-1);
    }
  textcolor(9);
  cprintf("%d.%d\n\r",vbe_info->VesaVersion >> 8, vbe_info->VesaVersion & 0x00FF);
  textcolor(15);
  cprintf("  þ Memory : ");
  textcolor(9);
  cprintf("%dk\n\r",vbe_info->TotalMemory * 64);
  textcolor(15);
  cprintf("  þ LFB Mode %dx%d ",xres,yres);
  switch(bpp)
    {
    case 4  : cprintf("16 Colors : ");
              break;
    case 8  : cprintf("256 Colors : ");
              break;
    case 15 : cprintf("32k Colors : ");
              break;
    case 16 : cprintf("64k Colors : ");
              break;
    case 24 : cprintf("High Color : ");
              break;
    case 32 : cprintf("True Color : ");
              break;
    }
  if (vbe_mode == -1)
    {
    textcolor(12);
    cprintf("NOT supported\n\r");
    return(-1);
    }
  else
    {
    textcolor(9);
    cprintf("Supported\n\r");
    }
  mode_info = vbe_get_mode_info(vbe_mode);
  // Set Envoriment Vars
  screen_height = yres;
  screen_width  = xres;
  color_depth   = bpp;
  line_mul  	 = mode_info->BytesPerScanLine;
  screen_mem    = line_mul * yres;
  delay(500);
  error = vbe_set_mode(vbe_mode);
  if (error!=0)
    {
    vbe_close();
    cprintf("Aborting... some errors occured\n\r");
    }
  return 0;
  } // vbe_init()




//***************************************************************************
set_palette(int entry,int r,int g,int b)
{
   outportb(0x3c8,(BYTE)entry);
   outportb(0x3c9,(BYTE)r);
   outportb(0x3c9,(BYTE)g);
   outportb(0x3c9,(BYTE)b);
}

//***************************************************************************
/**/
#define putpixel(x,y,col,where)  (where)[offsets[y] + x] = (col)
#define getpixel(x,y,where)      (where)[offsets[y] + x]
/**/
/*void putpixel(WORD x, WORD y, BYTE col, unsigned where)
	{
	 __asm__("movb %%al, (%%edi)"::"D" (where + offsets[y] + x), "a" (col));
	}*/

#endif //__VBE20_C

