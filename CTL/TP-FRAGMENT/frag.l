/* this scanner will recognize tokens used in the Calculator*/
/* this program  will return tokens that can be used by the PARSER */

/*part of C definition ==> this definition can be done automatically by the parser in the .h file*/

%{
    #include "frag.tab.h"
    int yylval;
%}

%%
"+" { return ADD; }
"-" { return SUB; }
"*" { return MUL; }
"/" { return DIV; }
"|" { return ABS; }
"==" {return EQUAL;}
"<" { return LESS;}
"<=" { return LESSEQUAL;}
"!" { return NON;}
"&&" { return AND;}
"||" { return OR;}
"(" { return OP; }
")" { return CP; }
"//".* /* ignore comments */
[0-9]+ { yylval = atoi(yytext); return NUMBER; }
";" { return EOL; }
[ \t] { /* ignore whitespaces*/ }
. { return EOL;}
%% 