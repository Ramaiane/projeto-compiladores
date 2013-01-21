%{
#include <stdio.h>
#include "parser.tab.h"  // to get the token types that we return

// stuff from flex that bison needs to know about:
extern int yylex();
extern int yyparse();
 
void yyerror(const char *s);
%}
 
%token INTEGER
%token FLOAT
%token DOUBLE
%token LONG
%token SHORT
%token VOID
%token CHAR
%token STRING
%token NUM_INT
%token NUM_FLOAT
%token ID
%token IF
%token BE_CMP 
%token SE_CMP 
%token EQUAL_CMP 
%token DIFF_CMP 

 
%error-verbose
 
%%

commands: 
        |       commands command
;

command:
                declare_assign_var
        |       declare_var
        |       if_stm
        |       condition
                 
;

param:
                number
        |       ID
        |       '"' STRING '"'

;

compare:
                '>'
        |       '<'
        |       BE_CMP        
        |       SE_CMP
        |       EQUAL_CMP
        |       DIFF_CMP
;

condition:
                param compare param
;


stms:
                declare_assign_var
        |       declare_var
        |       if_stm
;

number:
		NUM_INT
	|	NUM_FLOAT
;

datatype:
		INTEGER
	|	FLOAT
;

declare_assign_var:
		datatype ID '=' number ';' {printf("Foi declarado uma variavel e associado um valor.\n");}
;

declare_var:
		datatype ID ';' {printf("Foi declarada uma variavel.\n");}
;

if_stm:
		IF '(' condition ')' '{' stms '}' {printf("Um IF foi utilizado.\n");}
;
 
%%
 
void yyerror(const char* s)
{
	printf("\n****** Erro: %s\n", s);
}
 
int yywrap(void) { return 1; }
 
int main(int argc, char** argv)
{
     yyparse();
     return 0;
}
