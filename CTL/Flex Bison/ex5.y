// Simplest version of calculator

%{
     #include<stdio.h>
%}

/* declare tokens that will be used later*/
%token NUMBER
%token ADD SUB MUL DIV ABS
%token EOL
%token OP CP /* Add Closing and opening parenthesis*/

%%
calclist: /* nothing */ matches at beginning of input
     | calclist exp EOL { printf("= %d\n", $1); } EOL is end of an expression
     ;
exp: factor default $$ = $1
     | exp ADD factor { $$ = $1 + $3; }
     | exp SUB factor { $$ = $1 - $3; }
     ;
factor: term default $$ = $1
     | factor MUL term { $$ = $1 * $3; }
     | factor DIV term { $$ = $1 / $3; }
     ;
term: NUMBER default $$ = $1
     | ABS term { $$ = $2 >= 0? $2 : - $2; }
     ;
term: NUMBER 
     | ABS term { $$ = $2 >=0 ? $2: -$2}
     | OP exp CP { $$ = $2;}
%%

main(int argc, char **argv){
     yyparse();
     }

yyerror(char *s){
     fprintf(stderr, "error: %s\n", s);
     }


/*
     combining flex and bison together.

     add # include "fb1-5.tab.h" in the declaration section 

     makefile
      fb1-5:   fb1-5.l fb1-5.y
               bison -d fb1-5.y
               flex fb1-5.l
               gcc -o $@ fb1-5.tab.c lex.yy.c -lfl

*/


