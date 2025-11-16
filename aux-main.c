#include "./standard.h"

unsigned long main(unsigned long naof_params, unsigned char ** params) {
  sec space[64] = {46, 117, 170, 194, 215, 206, 216, 74, 173, 7, 16, 114, 149, 179, 24, 154, 27, 57, 23, 174, 190, 59, 37, 137, 137, 201, 7, 104, 183, 183, 82, 106, 135, 240, 128, 7, 129, 61, 46, 228, 243, 193, 104, 171, 70, 205, 62, 12, 230, 2, 2, 222, 239, 137, 33, 240, 221, 92, 82, 188, 132, 56, 84, 101};
	sec space2[64] = {0};
	aux_place(space, space2, 57);
	see_space("space2", space2, 64);
  return 0;
}
