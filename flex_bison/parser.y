%{
#include <stdio.h>
#include <stdlib.h>
// Aqui ficarão os tokens que o Bison retorna
#include "parser.tab.h"

//Includes, defines e declarações para uso da tabela de simbolos
#include "node.h"
#include "node.c"
#include "list.h"
#include "list.c"


#define TYPE_VAR_INT 200
#define TYPE_VAR_FLOAT 201
#define TYPE_VAR_DOUBLE 202
#define TYPE_VAR_CHAR 203

#define TYPE_SIZE_INT sizeof(int)
#define TYPE_SIZE_FLOAT sizeof(float)
#define TYPE_SIZE_DOUBLE sizeof(double)
#define TYPE_SIZE_CHAR sizeof(char)

List *list = ( List *) (malloc(sizeof(List)));

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
			CHAR ID '=' STRING ';' 
			{
				printf("DECLARADA VARIÁVEL %s, TIPO char, RECEBEU %s.\n",$2, $4);
				Node *node = create_node();
				node->name = $2;
				node->type = TYPE_VAR_CHAR;
				node->size = TYPE_SIZE_CHAR;

				push_back(list, node);
				print_list_file(list);
			}

		|   INTEGER ID '=' NUM_INT ';' 
			{
				printf("DECLARADA VARIÁVEL %s, TIPO int, RECEBEU %d.\n",$2, $4);
				Node *node = create_node();
				node->name = $2;
				node->type = TYPE_VAR_INT;
				node->size = TYPE_SIZE_INT;

				push_back(list, node);
				print_list_file(list);
			}
		|   DOUBLE ID '=' NUM_REAL ';' 
			{
				printf("DECLARADA VARIÁVEL %s, TIPO double, RECEBEU %f.\n",$2, $4);
				Node *node = create_node();
				node->name = $2;
				node->type = TYPE_VAR_DOUBLE;
				node->size = TYPE_SIZE_DOUBLE;

				push_back(list, node);
				print_list_file(list);
			}
		|   FLOAT ID '=' NUM_REAL ';' 
			{
				printf("DECLARADA VARIÁVEL %s, TIPO float, RECEBEU %f.\n",$2, $4);
				Node *node = create_node();
				node->name = $2;
				node->type = TYPE_VAR_FLOAT;
				node->size = TYPE_SIZE_FLOAT;

				push_back(list, node);
				print_list_file(list);
			}

		|	CHAR ID';' 
			{
				printf("DECLARADA VARIÁVEL %s, TIPO char.\n",$2);
				Node *node = create_node();
				node->name = $2;
				node->type = TYPE_VAR_CHAR;
				node->size = TYPE_SIZE_CHAR;

				push_back(list, node);
				print_list_file(list);
			}
		|   INTEGER ID ';' 
			{
				printf("DECLARADA VARIÁVEL %s, TIPO int.\n",$2);
				Node *node = create_node();
				node->name = $2;
				node->type = TYPE_VAR_INT;
				node->size = TYPE_SIZE_INT;

				push_back(list, node);
				print_list_file(list);
			}
		|   DOUBLE ID ';' 
			{
				printf("DECLARADA VARIÁVEL %s, TIPO double.\n",$2);
				Node *node = create_node();
				node->name = $2;
				node->type = TYPE_VAR_DOUBLE;
				node->size = TYPE_SIZE_DOUBLE;

				push_back(list, node);
				print_list_file(list);
			}
		|   FLOAT ID ';' 
			{
				printf("DECLARADA VARIÁVEL %s, TIPO int.\n",$2);
				Node *node = create_node();
				node->name = $2;
				node->type = TYPE_VAR_FLOAT;
				node->size = TYPE_SIZE_FLOAT;

				push_back(list, node);
				print_list_file(list);
			}
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
		printf("\n\n****** Error\nusage:\n\t$ ./compiler input_file.c\n");
		return -1;
	}
	// Tentamos carregar o arquivo
	FILE *entry = fopen(argv[1], "r");
	if (!entry) {
		printf("****** Error: file \"%s\" not found.\n", argv[1]);
		return -1;
	}

	
	printf("\n\t\t<<< Cabeçalho do Assembly >>>\n\n");
	// O leitor de stream do Bison recebe o endereço do arquivo
	yyin = entry;
        
    // Agora o pau come
    do {
		yyparse();
	 } while (!feof(yyin));
 	return 0;
};
