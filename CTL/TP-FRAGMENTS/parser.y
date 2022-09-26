%{
    #include <stdio.h>
%}

/* TOKENS*/

%token ADD MINUS MUL
%token NUMBER
%token EOF

%%
lk: {printf(" nothing to do");}
    | lk exp EOF {printf("the result is: %d",$2);}
    ;

exp: factor {$$ = $1;}
    | exp ADD factor {$$ = $1+$3;}
    | exp MINUS factor {$$ = $1-$3;}
    ;

factor: term {$$ = $1;}
    | factor MUL factor {$$ = $1 * $3;}
    ;

term: NUMBER {$$ = $1;}
    ;
%%


void yyerror(char* s){
	printf ("Error %s\n",s);
}

int yywrap(){
return 1;
} 
 
