// Simplest version of calculator

%{
     #include<stdio.h>
%}

/* declare tokens*/
%token NUMBER
%token ADD SUB MUL DIV ABS
%token EOL

%%
calclist: 
%%