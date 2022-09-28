#include <stdio.h>
#include <stdlib.h>

#include "tpK_tabSYmbol.h"

int yyparse();
int main(void)
{
    creerTSymb();

    if (yyparse())
        fprintf(stderr, "Successful parsing.\n");
    else
        fprintf(stderr, "error found.\n");
    afficheTSymb();
    return 0;
}
