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

%union {
	int ival;
	double fval;
	char *sval;
}

// Aqui os tokens utilizados 
%token INTEGER
%token FLOAT
%token DOUBLE
%token LONG
%token SHORT
%token VOID
%token CHAR
%token <sval> STRING
%token <ival> NUM_INT
%token <fval> NUM_REAL
%token <sval> ID
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
        |		assign_var
;

param:
                NUM_INT
        |		NUM_REAL
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
        |		assign_var
;

stms:
			    stm
		|       stms stm
;

assign_var:
		ID '=' NUM_INT  ';' {printf("VARIÁVEL %s, RECEBEU %d.\n",$1, $3);}
		| ID '=' NUM_REAL ';' {printf("VARIÁVEL %s, RECEBEU %f.\n",$1, $3);}
		| ID '=' STRING ';' {printf("VARIÁVEL %s, RECEBEU %s.\n",$1, $3);}

;

declare_var:
			CHAR ID '=' STRING ';' {printf("DECLARADA VARIÁVEL %s, TIPO char, RECEBEU %s.\n",$2, $4);}
		|   INTEGER ID '=' NUM_INT ';' {printf("DECLARADA VARIÁVEL %s, TIPO int, RECEBEU %d.\n",$2, $4);}
		|   DOUBLE ID '=' NUM_REAL ';' {printf("DECLARADA VARIÁVEL %s, TIPO double, RECEBEU %f.\n",$2, $4);}
		|   FLOAT ID '=' NUM_REAL ';' {printf("DECLARADA VARIÁVEL %s, TIPO float, RECEBEU %f.\n",$2, $4);}
		|	CHAR ID';' {printf("DECLARADA VARIÁVEL %s, TIPO int.\n",$2);}
		|   INTEGER ID ';' {printf("DECLARADA VARIÁVEL %s, TIPO int.\n",$2);}
		|   DOUBLE ID ';' {printf("DECLARADA VARIÁVEL %s, TIPO int.\n",$2);}
		|   FLOAT ID ';' {printf("DECLARADA VARIÁVEL %s, TIPO int.\n",$2);}
;

if_stm:
				IF '(' condition ')' '{' stms '}' {printf("Um IF foi utilizado.\n");}
		|       IF '(' condition ')' stm {printf("Um IF sem {} foi utilizado.\n");}
;
 
%%

// Mensagem de erro
void yyerror(const char* s)
{
	printf("\n****** Error (line=%d): %s\n", lnumber, s);
}
 
int yywrap(void) { return 1; }
 
int main(int argc, char** argv)
{	
   // Verificamos se foi passado um parametro
        if (argc != 2) 
	{
		printf("****** Error\nusage:\n\t$ ./compiler input_file.c\n");
		return -1;
	}
	// Tentamos carregar o arquivo
	FILE *entry = fopen(argv[1], "r");
	if (!entry) {
		printf("****** Error: file \"%s\" not found.\n", argv[1]);
		return -1;
	}
	printf("<<< Cabeçalho do Assembly >>>\n");
	// O leitor de stream do Bison recebe o endereço do arquivo
	yyin = entry;
        
    // Agora o pau come
    do {
		yyparse();
	} while (!feof(yyin));

 	return 0;
}
