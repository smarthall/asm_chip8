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
