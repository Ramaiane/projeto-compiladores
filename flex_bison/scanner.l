%{
#include <stdio.h>
#include <stdlib.h>
#include "parser.tab.h"

#define YY_DECL extern int yylex()

int lnumber = 0;

%}
/* Definições */
WHITESPACE [ \r\t]+
DIGITS [0-9]+
ANY_CHAR . 
 
%% /* Regras */
 
\n             {lnumber++;}
{WHITESPACE} /* Ignorar espaços, quebras de linha, tabs... */ ;

\/\*([^\*]|\*[^/])*\*\/  /* Ignorar comentários */;
\/\/.*  /* Ignorar comentários de c plus plus*/;
 

"int" { return INTEGER; }
"long" { return LONG; }
"short" { return SHORT; }
"double" { return DOUBLE; }
"float" { return FLOAT; }
"void" { return VOID; }
"char" { return CHAR; }
"if" { return IF; }
">=" { return BE_CMP; }
"<=" { return SE_CMP; }
"==" { return EQUAL_CMP; } 
"!=" { return DIFF_CMP; } 
"<" { return '<'; } 
">" { return '>'; } 
"=" { return '='; }
";" { return ';'; }
"(" { return '('; }
")" { return ')'; }
"{" { return '{'; }
"}" { return '}'; }
"\"" { return '"'; }

[a-zA-Z_]+[a-zA-Z0-9]* { return ID; }
"\"".*"\"" { return STRING; }
{DIGITS} { return NUM_INT; }
{DIGITS}+\.{DIGITS}+ { return NUM_FLOAT; }
 
 
{ANY_CHAR} {
	printf("\n****** Erro (line=%d): lexical error, unspected char '%c'.\n",lnumber, yytext[0]);
	return -1;
}

%%
