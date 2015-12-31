#include <limits.h>

#include "generator.h"

uint16_t generate_mov_register_register(int src, int dest) {
    src = src << 4;
    dest = dest << 8;

    return 0x8000 | src | dest;
}

uint16_t generate_mov_number_register(int src, int dest) {
    src = src % UCHAR_MAX;
    dest = dest << 8;

    return 0x6000 | dest | src;
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
