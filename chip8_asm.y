%{

#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern void yyerror(char*);

%}

%union {
	int		int_token;
}

%token <int_token> SEMICOLON

%start root_node

%%

root_node: SEMICOLON

