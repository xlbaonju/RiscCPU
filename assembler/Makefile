all : ../bas
../bas : lex.yy.c y.tab.c y.tab.h
	gcc -o $@ $^
lex.yy.c : assembler.l
	lex $^
y.tab.c y.tab.h	:assembler.y
	yacc -d $^
clean :
	rm lex.yy.c y.tab.c y.tab.h ../bas ../binary

