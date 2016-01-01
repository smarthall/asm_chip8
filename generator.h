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
uint16_t generate_shl(int reg);
uint16_t generate_shr(int reg);
uint16_t generate_sub(int value, int accumulator);
uint16_t generate_rsb(int accumulator, int value);
uint16_t generate_ldi(int I);
uint16_t generate_jmi(int base);
uint16_t generate_rand(int reg, int mask);
uint16_t generate_draw(int x_reg, int y_reg, int height);
uint16_t generate_skk(int reg);
uint16_t generate_snk(int reg);
uint16_t generate_sdelay(int reg);
uint16_t generate_ssound(int reg);
uint16_t generate_adi(int reg);
uint16_t generate_font(int reg);
uint16_t generate_bcd(int reg);
uint16_t generate_str(int reg);
uint16_t generate_ldr(int reg);
uint16_t generate_key(int reg);

#endif /* GENERATOR_H */
