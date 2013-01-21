%{
#include <stdio.h>
#include <stdlib.h>
%}
%token COMMENT
%token COMMENT_BLOCK_START
%token COMMENT_BLOCK_END
%token INCLUDE
%token DEFINE
%token CODE_FORMAT
%token TYPE_VAR
%token MODFIER_VAR
%token CONTROL_STRUCT
%token LOGIC_OPERATOR
%token ADDRES_OPERATOR
%token OPERATOR
%token COMPARE
%token KEYWAY
%token BRACKET
%token BRACE
%token PARENTHESIS
%token DELIMITER
%token QUOTE
%token APOSTROPHE
%token SEMI
%token COMMA
%token NUMBER
%token ID
%token WSPC
%%

selection_statement
	: IF '(' expression ')' statement
