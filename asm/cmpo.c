#include "/home/tyrel/celix/standard.h"

quadrant main(quadrant naof_params, source_vecter params) {
	asm("mov $0xaed, %r8");
	asm("mov $0xaee, %r9");
	asm("cmp %r8, %r9");
	asm("jae 0x696");
	syscall(unix_write, 1, "is not above.\n", 14);
	asm("jmp 0x6b6");
	syscall(unix_write, 1, "is above.\n", 10);
	return 0;
}
