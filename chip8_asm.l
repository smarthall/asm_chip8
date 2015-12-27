%{

#include <stdio.h>
void yyerror(char*);
int yyparse(void);

%}

%%

";"         return SEMICOLON;
[ \t\n]+    ; // Ignore whitespace

%%

void yyerror(char * str) { printf("ERROR: Could not parse!\n"); }
int yywrap(void) { }
int main(void) {
    yyparse();
}

