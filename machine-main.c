#include "./machine.h"

quadrant main(quadrant naof_params, source_vecter params) {
	syscall(unix_write, 1, "in machine-main.\n", 0x11);
	return 0;
}
