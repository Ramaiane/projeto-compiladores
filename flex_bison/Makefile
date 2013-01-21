BISON=bison
FLEX=flex
GCC = gcc
compiler: parser.tab.h parser.tab.c lex.yy.c
	$(GCC) parser.tab.c lex.yy.c -lfl -o compiler
 
parser.tab.c parser.tab.h: parser.y
	$(BISON) -d parser.y
 
lex.yy.c: scanner.l
	$(FLEX) scanner.l
 
clean:
	rm -f lex.yy.c parser.tab.c parser.tab.h compiler *~
