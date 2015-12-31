#ifndef GENERATOR_H
#define GENERATOR_H

#include <inttypes.h>

uint16_t generate_mov_register_register(int src, int dest);
uint16_t generate_mov_number_register(int src, int dest);
uint16_t generate_call(int address);
uint16_t generate_rcall(int address);
uint16_t generate_cls();

#endif /* GENERATOR_H */
