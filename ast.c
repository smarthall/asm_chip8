#include "ast.h"

#include <stdlib.h>
#include <string.h>

// Internal only
ast_argument* ast_create_argument();
void ast_destroy_argument(ast_argument *arg);
void ast_destroy_instruction(ast_instruction *instruction);


// Arguments
ast_argument* ast_create_argument() {
    ast_argument *new = malloc(sizeof(ast_argument));

    new->next = NULL;

    return new;
}

ast_argument* ast_create_label(char *label) {
    ast_argument *new = ast_create_argument();

    new->type = AST_LABEL;

    size_t label_len = strlen(label) + 1;
    new->value.label = malloc(sizeof(char) * label_len);
    memcpy(new->value.label, label, sizeof(char) * label_len);

    return new;
}

ast_argument* ast_create_number(int number) {
    ast_argument *new = ast_create_argument();

    new->type = AST_NUMBER;
    new->value.number = number;

    return new;
}

ast_argument* ast_create_register(int reg) {
    ast_argument *new = ast_create_argument();

    new->type = AST_REGISTER;
    new->value.number = reg;

    return new;
}

void ast_destroy_argument(ast_argument *arg) {
    if (arg->type == AST_LABEL) free(arg->value.label);
    free(arg);
}

// Instructions
ast_instruction* ast_create_instruction(ast_opcode_generator generator) {
    ast_instruction *new = malloc(sizeof(ast_instruction));

    new->next = NULL;
    new->arg_head = NULL;
    new->arg_tail = NULL;

    new->generator = generator;

    return new;
}

void ast_add_argument(ast_instruction *instruction, ast_argument *argument) {
    if (instruction->arg_head = NULL) {
        instruction->arg_head = argument;
    } else {
        instruction->arg_tail->next = argument;
    }
    
    instruction->arg_tail = argument;
}

void ast_destroy_instruction(ast_instruction *instruction) {
    ast_argument *current = instruction->arg_head;
    ast_argument *last;

    while (current != NULL) {
        last = current;
        current = current->next;

        ast_destroy_argument(last);
    }

    free(instruction);
}
