%{
#include <stdio.h>
#include "y.tab.h"
%}

comment 		("\/\/")
comment_block_start	("\/\*")
comment_block_end	("\*\/")
include			(#include)
define			(#define)
code_format		[%][0-9]*[.0-9]*(c|d|f|i|e|E|g|G|o|s|u|x|X|%|p)
type_var		("int"|"float"|"char"|"double"|"void")
modfier_var		("unsigned"|"signed"|"short"|"long")
control_struct		(if|else|do|while|switch|case|for|goto|[?])
logic_operator		("&&"|"||"|"!")
address_operator	("&"|"*")
operator 		[\+\-\*\/\%]{1}
compare			(">="|"<="|">"|"<"|"=="|"!=")
bracket 		("["|"]")
keyway			("{"|"}")
brace 			("\"|"\")
parenthesis 		("("|")")
delimiter		("."|","|"!"|"?"|"..."|":"|";")
quote			["]
apostrophe		[']
semi 			[;]{1}
comma 			[,]{1}
number			[0-9]*
id			[a-zA-Z_][a-zA-Z0-9_]*
wspc 			[ \t]+

%option noyywrap

%%
{comment}		{ return COMMENT; }
{comment_block_start}	{ return COMMENT_BLOCK_START; }
{comment_block_end}	{ return COMMENT_BLOCK_END; }
{include}		{ return INCLUDE; }
{define}		{ return DEFINE; }
{code_format}		{ return CODE_FORMAT; }
{type_var}		{ return TYPE_VAR; }
{modfier_var}		{ return MODFIER_VAR; }
{control_struct}	{ return CONTROL_STRUCT; }
{logic_operator}	{ return LOGIC_OPERATOR; }
{address_operator}	{ return ADDRES_OPERATOR; }
{operator}		{ return OPERATOR; }
{compare}		{ return COMPARE; }
{keyway}		{ return KEYWAY; }
{bracket}		{ return BRACKET; }
{brace}			{ return BRACE; }
{parenthesis}		{ return PARENTHESIS; }
{delimiter}		{ return DELIMITER; }
{quote}			{ return QUOTE; }
{apostrophe}		{ return APOSTROPHE; }
{semi}			{ return SEMI; }
{comma}			{ return COMMA; }
{number}		{ return NUMBER; }
{id}			{ return ID; }
{wspc}			{ return WSPC; }
%%
