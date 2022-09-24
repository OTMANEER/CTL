%{
int chars = 0;
int words = 0;
int lines = 0;
%}
%%
[a-zA-Z]+ { words++; chars += strlen(yytext); }
\n { chars++; lines++; }
. { chars++; }
%%
void main(int argc, char **argv)
{
yylex();
printf("%8d%8d%8d\n", lines, words, chars);
}


/*
     to execute the following code please use this:

          flex fb1.l
          gcc lex.yy.c -lfl
          ./a.exe
*/