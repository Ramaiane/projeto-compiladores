%{
#include <stdio.h>
#include "parser.tab.h"

#define YY_DECL extern int yylex()
%}
/* Definições */
STRING [a-zA-Z_].[a-zA-Z0-9]*
WHITESPACE [ \n\r\t]+
DIGITS [0-9]+
ANY_CHAR .
 
 
%% /* Regras */
 
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
 
{STRING} { return ID; }
{DIGITS} { return NUM_INT; }
{DIGITS}+\.{DIGITS}+ { return NUM_FLOAT; }
 
 
{ANY_CHAR} {
	printf("Caracter inesperado na entrada: '%c'  (ASCII=%d)\n", yytext[0], yytext[0]);
}

%%
