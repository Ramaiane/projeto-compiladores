%{
#include <stdio.h>
#include "y.tab.h"
%}
%%
id        [_a-zA-Z]{1}[_a-zA-Z0-9]*
wspc      [ \t\n]+
semi      [;]{1}
comma     [,]{1}
operator  [\+\-\*\/\%]{1}
bracket [\[\]{1}
brace [\{\}]{1}
parenthesis [\(\)]{1}
comparare (>=|<=|>|<|==)
comment [//]+.*
comment_block /\*[\S\s]*\*/

%option noyywrap
%%
int       { return INT; }
char      { return CHAR; }
float     { return FLOAT; }
{comma}   { return COMMA; }        /* Necessary? */
{semi}    { return SEMI; }
{id}      { return ID;}
{wspc}    {;}
