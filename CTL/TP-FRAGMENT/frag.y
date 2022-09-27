/* simplest version of calculator */
%{
#include <stdio.h>
%}
/* declare tokens */
%token NUMBER
%token ADD SUB MUL DIV ABS
%token EQUAL LESS LESSEQUAL AND OR NON
%token EOL
%token OP CP
%%
calclist: /* nothing */ 
| calclist exp EOL { printf("Result =%d\n",$2); }
;
exp: factor  {$$ = $1;}
| exp ADD factor { $$ = $1 + $3; }
| exp SUB factor { $$ = $1 - $3; }
| exp EQUAL exp  { $$ = $1==$3? 0:-1; }
| exp LESS exp  { $$ = $1<$3? 0:-1; }
| exp LESSEQUAL exp  { $$ = $1<=$3? 0:-1; }
| exp AND exp  { $$ = ($1== 0 && $3==0)? 0:-1; }
| exp OR exp  { $$ = ($1== 0 || $3== 0)? 0:-1; }
;
factor: term   {$$ = $1;}
| factor MUL term { $$ = $1 * $3; }
| factor DIV term { $$ = $1 / $3; }
;
term: NUMBER   {$$ = $1;}
| ABS term { $$ = $2 >= 0? $2 : - $2; }
| OP exp CP { $$ = $2; }
;
%%
main(int argc, char **argv)
{
yyparse();
}
yyerror(char *s)
{
fprintf(stderr, "error: %s\n", s);
}