#include <limits.h>

#include "generator.h"

uint16_t generate_mov_register_register(int src, int dst) {
    src = src << 4;
    dst = dst << 8;

    return 0x8000 | src | dst;
}

uint16_t generate_mov_number_register(int src, int dst) {
    src = src % UCHAR_MAX;
    dst = dst << 8;

    return 0x6000 | dst | src;
}

uint16_t generate_call(int address) {
    return 0x2000 | address;
}

uint16_t generate_rcall(int address) {
    return 0x0000 | address;
}

uint16_t generate_cls() {
    return 0x00e0;
}

uint16_t generate_rtn() {
    return 0x00ee;
}

uint16_t generate_jmp(int address) {
    return 0x1000 | address;
}

uint16_t generate_se_register_register(int src, int dst) {
    src = src << 4;
    dst = dst << 8;

    return 0x5000 | src | dst;
}

uint16_t generate_se_register_number(int src, int dst) {
    src = src << 8;

    return 0x3000 | src | dst;
}

uint16_t generate_sne_register_register(int src, int dst) {
    src = src << 4;
    dst = dst << 8;

    return 0x9000 | src | dst;
}

uint16_t generate_sne_register_number(int src, int dst) {
    src = src << 8;

    return 0x4000 | src | dst;
}

uint16_t generate_add_register_register(int value, int accumulator) {
    value = value << 4;
    accumulator = accumulator << 8;

    return 0x8004 | value | accumulator;
}

uint16_t generate_add_register_number(int value, int accumulator) {
    accumulator = accumulator << 8;

    return 0x7000 | value | accumulator;
}

uint16_t generate_or(int or, int dst) {
    or = or << 8;
    dst = dst << 4;

    return 0x8001 | or | dst;
}

uint16_t generate_and(int and, int dst) {
    and = and << 8;
    dst = dst << 4;

    return 0x8002 | and | dst;
}

uint16_t generate_xor(int xor, int dst) {
    xor = xor << 8;
    dst = dst << 4;

    return 0x8003 | xor | dst;
}

uint16_t generate_shl(int reg) {
    reg = reg << 8;

    return 0x800e | reg;
}

uint16_t generate_shr(int reg) {
    reg = reg << 8;

    return 0x8006 | reg;
}

uint16_t generate_sub(int value, int accumulator) {
    accumulator = accumulator << 8;
    value = value << 4;

    return 0x8005 | accumulator | value;
}

uint16_t generate_rsb(int accumulator, int value) {
    accumulator = accumulator << 4;
    value = value << 8;

    return 0x8007 | accumulator | value;
}

uint16_t generate_ldi(int I) {
    return 0xA000 | I;
}

uint16_t generate_jmi(int base) {
    return 0xB000 | base;
}

uint16_t generate_rand(int reg, int mask) {
    reg = reg << 8;

    return 0xC000 | reg | mask;
}

uint16_t generate_draw(int x_reg, int y_reg, int height) {
    x_reg = x_reg << 8;
    y_reg = y_reg << 4;

    return 0xD000 | x_reg | y_reg | height;
}

uint16_t generate_skk(int reg) {
    reg = reg << 8;

    return 0xE09E | reg;
}

uint16_t generate_snk(int reg) {
    reg = reg << 8;

    return 0xE0A1 | reg;
}

uint16_t generate_sdelay(int reg) {
    reg = reg << 8;

    return 0xF015 | reg;
}

uint16_t generate_ssound(int reg) {
    reg = reg << 8;

    return 0xF018 | reg;
}
