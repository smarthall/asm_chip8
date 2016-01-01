#ifndef GENERATOR_H
#define GENERATOR_H

#include <inttypes.h>

uint16_t generate_mov_register_register(int src, int dst);
uint16_t generate_mov_number_register(int src, int dst);
uint16_t generate_call(int address);
uint16_t generate_rcall(int address);
uint16_t generate_cls();
uint16_t generate_rtn();
uint16_t generate_jmp(int address);
uint16_t generate_se_register_register(int src, int dst);
uint16_t generate_se_register_number(int src, int dst);
uint16_t generate_sne_register_register(int src, int dst);
uint16_t generate_sne_register_number(int src, int dst);
uint16_t generate_add_register_register(int value, int accumulator);
uint16_t generate_add_register_number(int value, int accumulator);
uint16_t generate_or(int or, int dst);
uint16_t generate_and(int and, int dst);
uint16_t generate_xor(int xor, int dst);

#endif /* GENERATOR_H */
