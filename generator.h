#ifndef GENERATOR_H
#define GENERATOR_H

#include <inttypes.h>

uint16_t mov_register_register(int src, int dest);
uint16_t mov_number_register(int src, int dest);

#endif /* GENERATOR_H */
