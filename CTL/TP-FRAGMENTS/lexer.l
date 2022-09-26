/* Premiere partie du lexeur*/

%{
    #include "parser.tab.h"
    
    /* déclaration du langage C*/
%}

%%
"+"     { return ADD;}
"-"     { return MINUS;}
"*"     { return MUL;}
[0-9]+  { return NUMBER;}
\n      { return EOF;}
%%
