%{

#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern void yyerror(char*);

%}

%union {
	int		int_token;
    char    *char_token;
}

%token <int_token> SEMICOLON COMMA MOV_MNEMONIC NUMBER LABEL
%token <char_token> HEX_CHAR

%start program

%%

program: statement_list;

statement_list: statement statement_list
              | statement;

statement: instruction SEMICOLON
         | LABEL instruction SEMICOLON;

instruction: mov;

mov: MOV_MNEMONIC HEX_CHAR COMMA HEX_CHAR
   { printf("Move instruction.\n"); };


