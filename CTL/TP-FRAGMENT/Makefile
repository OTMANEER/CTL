a.out :   frag.l frag.y
		bison -d frag.y
		flex frag.l
		cc -o $@ frag.tab.c lex.yy.c -lfl