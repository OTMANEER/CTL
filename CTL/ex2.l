// English to american dictionary;

%%
     "colour" { printf("color"); }
     "flavour" { printf("flavor"); }
     "clever" { printf("smart"); }
     "smart" { printf("elegant"); }
     "conservative" { printf("liberal"); } 
     . { printf("%s", yytext); } // if does not exist then just print whatever
%%