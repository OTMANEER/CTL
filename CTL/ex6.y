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

%%