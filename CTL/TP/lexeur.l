/* fichier lexeur.l */
%{
/* fichier dans lequel est defini la macro constante NOMBRE */
#include "parseur.tab.h"

%}
%option noyywrap
tab [ \t]+
toline \n
digit [0-9]
integer digit+
idf [_a-zA-Z][_a-zA-Z0-9]*



%%
int {return TYPEINT;}
main {return MAIN;}
for {return FOR;}
while {return WHILE;}
"*"|"**" {yylval.str=strdup(yytext);return POINTER;}
if {return IF;}
else {return ELSE;}
"++" {yylval.str=strdup(yytext);return INCR;}
"--" {yylval.str=strdup(yytext);return DECR;}
[0-9]+ {yylval.ival=atoi(yytext);return NUMBER;}
"+"|"-" {yylval.str=strdup(yytext);return PLUSMINUS;}
"*"|"/" {yylval.str=strdup(yytext);return MULTIPDIV;}
"&&"|"||" {yylval.str=strdup(yytext);return OPL;}
"<"|">"|"<="|">="|"==" {yylval.str=strdup(yytext);return OPC;}
{idf} {yylval.str=strdup(yytext);return IDF;}
[ \t\n]+ {;} /* ignore les blancs et tabulations */ 
. {return yytext[0];}


%%
/*[+-] {yylval.chr=yytext+'0'; return PLUSMINUS;}
['*''/'] {yylval.chr=strdup(yytext);return MULTDIV;}
*/
