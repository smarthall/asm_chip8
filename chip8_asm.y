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

%token SEMICOLON COMMA
%token MOV_MNEMONIC CALL_MNEMONIC CLS_MNEMONIC RTN_MNEMONIC

%token <int_token> NUMBER
%token <char_token> HEX_CHAR LABEL ADDRESS

%start program

%%

program: statement_list;

statement_list: statement statement_list
              | statement;

statement: instruction SEMICOLON
         | LABEL instruction SEMICOLON;

instruction: mov
           | call
           | cls
           | rtn;

mov: MOV_MNEMONIC HEX_CHAR COMMA HEX_CHAR
   { printf("Move instruction.\n"); };

call: CALL_MNEMONIC ADDRESS
   { printf("Call instruction.\n"); };

cls: CLS_MNEMONIC
   { printf("Clear screen instruction.\n"); };

rtn: RTN_MNEMONIC
   { printf("Return instruction.\n"); };

