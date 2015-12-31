#include <limits.h>

#include "generator.h"

uint16_t mov_register_register(int src, int dest) {
    uint16_t opcode = 0x8000;

    src = src << 4;
    dest = dest << 8;

    opcode = opcode | src | dest;

    return opcode;
}

uint16_t mov_number_register(int src, int dest) {
    uint16_t opcode = 0x6000;

    src = src % UCHAR_MAX;
    dest = dest << 8;

    opcode = opcode | dest | src;
}
