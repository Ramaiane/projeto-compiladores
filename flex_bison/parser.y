%{
#include <stdio.h>
#include <stdlib.h>
// Aqui ficarão os tokens que o Bison retorna
#include "parser.tab.h"

// Coisas do Flex que o bison trabalha 
extern int yylex();
extern int yyparse();
extern FILE *yyin; 
extern int lnumber;
void yyerror(const char *s);
%}

// Aqui os tokens utilizados 
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

// Em commands e command são referenciadas todas as regras que criamos
commands: 
        |       command commands
;

command:
                declare_var
        |       if_stm
        |       condition
;

param:
                number
        |       STRING
        |       ID
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

stm:
                declare_var
        |       if_stm
;

stms:
	        stm
	|       stms stm
	;

number:
		NUM_INT
	|	NUM_FLOAT
;

datatype:
		INTEGER
	|	FLOAT
;

declare_var:
			datatype ID '=' number ';' {printf("Foi declarado uma variavel e associado um valor.\n");}
		|	datatype ID ';' {printf("Foi declarada uma variavel.\n");}
;

if_stm:
		IF '(' condition ')' '{' stms '}' {printf("Um IF foi utilizado.\n");}
	|       IF '(' condition ')' stm {printf("Um IF sem {} foi utilizado.\n");}
;
 
%%

// Mensagem de erro
void yyerror(const char* s)
{
	printf("\n****** Erro (line=%d): %s\n", lnumber, s);
}
 
int yywrap(void) { return 1; }
 
int main(int argc, char** argv)
{
	printf("!!!!!!! CABECALHO !!!!!\n");	
   // Verificamos se foi passado um parametro
        if (argc != 2) 
	{
		printf("***ERROR***\nusage:\n\t$ ./compiler input_file.c\n");
		return -1;
	}
	// Tentamos carregar o arquivo
	FILE *entry = fopen(argv[1], "r");
	if (!entry) {
		printf("***ERROR***\nFile \"%s\" not found.\n", argv[1]);
		return -1;
	}
	// O leitor de stream do Bison recebe o endereço do arquivo
	yyin = entry;
        
        // Agora o pau come
        do {
		yyparse();
	} while (!feof(yyin));

 	return 0;
}
