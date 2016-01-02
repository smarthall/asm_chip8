#include "ast.h"

#include <stdlib.h>
#include <string.h>

// Internal only
void ast_destroy_argument(ast_argument *arg);

ast_argument* ast_create_label(char *label) {
    ast_argument *new = malloc(sizeof(ast_argument));

    new->type = AST_LABEL;

    size_t label_len = strlen(label) + 1;
    new->value.label = malloc(sizeof(char) * label_len);
    memcpy(new->value.label, label, sizeof(char) * label_len);

    return new;
}

ast_argument* ast_create_number(int number) {
    ast_argument *new = malloc(sizeof(ast_argument));

    new->type = AST_NUMBER;
    new->value.number = number;

    return new;
}

ast_argument* ast_create_register(int reg) {
    ast_argument *new = malloc(sizeof(ast_argument));

    new->type = AST_REGISTER;
    new->value.number = reg;

    return new;
}

void ast_destroy_argument(ast_argument *arg) {
    if (arg->type == AST_LABEL) free(arg->value.label);
    free(arg);
}

