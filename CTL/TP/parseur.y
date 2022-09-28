/* fichier parseur.y */
%{
#include <string.h>
#include <stdio.h>
#include "tpK_tabSYmbol.h"
int currentCtxt=C_GLO;
int currentAdrs=0;

int yyerror();
int yylex();
 
%}


%union {
int ival;
char *str;
char chr;
};
%token<ival> NUMBER 
%token<str> PLUSMINUS OPC IDF 
%token  ND OR IF ELSE WHILE MAIN
%token<str> OPL MULTIPDIV TYPEINT FOR INCR DECR  
%type <ival> expression
%type <str> BOOLEAN decVar

%left PLUSMINUS IDF ','
%left MULTIPDIV 
%left OPL '!'
%left  OPC
%left '(' ')' TYPEINT POINTER

%start prog

%%
prog: ldecVar expression ';' | fonction bloc prog ';';

//prog: decVar fonction main  | main res | main bloc | prog ';'{return 1;};
res:expression {printf("Resultat: %d\n",$1); } // a ameliorer juste pour tester
| ldecVar   | fonction | ldecVar res ;
| for  | bloc  | while  | if  |appel {printf("APPEL");} | affectation  |main 
;
main: TYPEINT MAIN '('')' ;

ldecVar: |decVar ldecVar ;
decVar: TYPEINT suiteDec suiteDec1 ';';
suiteDec: POINTER IDF /*cas POINTEUR */ |IDF {if ( !existe($1)) {ajouterEntree($1,currentCtxt,T_ENT,currentAdrs,0);currentAdrs++;}
                                              else {printf("erreur,multiple declaration\n");return 1;}};
suiteDec1: ',' suiteDec | ;// int x,y;
affectation: IDF '=' expression {if ( !existe($1)) {ajouterEntree($1,currentCtxt,T_ENT,currentAdrs,0);currentAdrs++;}
                                              else {printf("erreur,multiple declaration\n");return 1;}};
| decVar '=' expression   
fonction:TYPEINT IDF '(' args ')'  ;
args: | arg ; //soit vide soit arg pour supprimer le cas de f(,)
arg: TYPEINT IDF | arg ',' arg ;

appel: IDF '(' intArgs ')';
intArgs: | intArg;
intArg: expression ',' intArg | expression;


for: FOR '(' expFor ')';
expFor: decVar ';' BOOLEAN ';' iteration  | decVar ';' IDF OPC NUMBER ';' iteration  ;  // a ameliorer 
iteration: IDF INCR | IDF DECR | IDF PLUSMINUS NUMBER ;

bloc:'{' instructions '}'{currentCtxt=C_LOC; printf("%d",currentCtxt);};
instructions : {printf("vide");}|expression | for | decVar | fonction | while |if| appel |affectation;

while: WHILE '(' BOOLEAN ')' bloc ;
if:IF '(' BOOLEAN ')' bloc  | if ELSE bloc ;


BOOLEAN:   expression  OPC expression  {
     $$=(char*)malloc(sizeof(char) * 1024);
    if(!strcmp("<",$2)) {
        if($1<$3) strcpy($$,"TRUE");
        else strcpy($$,"FALSE");
        }
    else if(!strcmp(">",$2)) {
        if($1>$3) strcpy($$,"TRUE");
        else strcpy($$,"FALSE");
      }
    else if(!strcmp("<=",$2)) {
        if($1<=$3) strcpy($$,"TRUE");
        else strcpy($$,"FALSE");
        }
   else if(!strcmp(">=",$2)) {
        if($1>=$3) strcpy($$,"TRUE");
        else strcpy($$,"FALSE");
        }
    else if(!strcmp("==",$2)) {
        if($1==$3) strcpy($$,"TRUE");
        else strcpy($$,"FALSE");
        }
    }
| expression OPL expression {
  $$=(char*)malloc(sizeof(char) * 1024);
    if(!strcmp("&&",$2)) {if($1 && $3) strcpy($$,"TRUE"); else strcpy($$,"false");  }
    else if (!strcmp("||",$2)) {{if($1 || $3) strcpy($$,"TRUE"); else strcpy($$,"false");  }}
    }
| expression '!' expression {if($1 != $3) strcpy($$,"TRUE"); else strcpy($$,"false");  }
;
 
expression:BOOLEAN {if(strcpy($1,"TRUE")) $$=1;  else $$=0; }|
expression PLUSMINUS expression {
    if(!strcmp("+",$2)) {
        $$ = $1 + $3;
       
    }
    else{
        $$ = $1 - $3; 
    }
    }
|expression MULTIPDIV expression {
    if(!strcmp("*",$2)){
        $$ = $1 * $3;
    }
    else{
        $$ = $1 / $3; 
    }
    }
| '(' expression ')' {$$=$2;}
| NUMBER  {$$ = $1;} //affecter number a expression
;

/*
IDFS: IDF | IDF ',' IDFS;
DECV: TYPEINT IDFS ',';
DECVS : DECV IDFS | ;
*/
%%


int yyerror(void)
{ fprintf(stderr, "erreur de syntaxe\n");
 return 1;
}



