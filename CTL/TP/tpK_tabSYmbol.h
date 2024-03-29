#ifndef TPK_TABSYMBOL_H_
#define TPK_TABSYMBOL_H_

#include <stdio.h>  /* fprintf */
#include <stdlib.h> /* EXIT_SUCCESS */
#include <string.h> /* strcmp */

/* constantes --> .h */
#define SIZE_INIT_TSYMB 50 /* tailles */
#define INCREMENT_SIZE_TSYMB 25
#define C_GLO 0 /* contextes */
#define C_LOC 1
#define C_FON 2
#define C_ARG 3
#define T_ENT 0 /* types */
#define T_TAB 2

typedef struct
{                  /* selon cm-table-symboles.pdf */
    char *identif; /* en général un léxème */
    int classe;    /* C_FONCTION, ou contexte de variable : C_GLOBAL, C_LOCAL, C_ARG */
    int type;      /* source K augmenté de tableaux : T_ENTIER, T_TABLEAU */
    int adresse;
    int complement; /* ex.: nombre d'argument d'une fonction */
} ENTREE_TSYMB;

/* prototypes --> .h */
void creerTSymb(void);
void agrandirTSymb(void);
int erreurFatale(char *message);
void ajouterEntree(char *identif, int classe, int type, int adresse, int complement);
int existe(char *id);
void afficheTSymb(void);

#endif
