%option noyywrap nodefault yylineno case-insensitive

/*the symbol table start here*/
%{
    struct symbol{
        char *name;
        struct ref * reflist;
    };
    struct ref{
        struct ref * next;
        char *filename;
        int flag;
        int lineno;
    };

    /* simple symbol table of fixed size*/
    #define NHASH 9997
    struct symbol symtab[NHASH];
    struct symbol *lookup(char*);
    void addref(int, char*, char*, int);

    char  *curfilename; /* name of the current input*/
%}

%%
    // Rules for concordance generator  
    // SKIP COMMON WORDS FOR THE MOMENT AND FOCUS ON WHAT IS IMPORTANT FOR US TODAY.


    a       |
    an      |
    and     |
    are     |
    as      |
    at      |
    be      |
    but     |
    for     |
    in      |
    is      |
    it      |
    of      |
    on      |
    or      |
    that    |
    the     |
    this    |
    to  /* ignore */
    [a-z]+(\'(s|t))?    { addref(yylineno, curfilename, yytext, 0); }
    .|\n    /* ignore everything else */
    %%
%%