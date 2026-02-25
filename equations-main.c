#include "./standard.h"

quadrant main(quadrant naof_params, source_vecter params) {
	source proc_name = "secs/equations/main.secs";
	archive_grid source_file = syscall(unix_open, proc_name, archive_read);
	quadrant source_file_distance = syscall(unix_lseek, source_file, 0, seek_completion);
	source em = syscall(unix_mmap, non, source_file_distance, map_rws, clerk_descreet, source_file, non);
	printf("em | %lu\n", em);
	syscall(unix_close, source_file);

	proc_name = "secs/equations/equations.secs";
	source_file = syscall(unix_open, proc_name, archive_read);
	source_file_distance = syscall(unix_lseek, source_file, 0, seek_completion);
	source es = syscall(unix_mmap, non, source_file_distance, map_rws, clerk_descreet, source_file, non);
	printf("es | %lu\n", es);
	syscall(unix_close, source_file);

	asm("sub $0x1000, %rsp");
	register quadrant_reference rsp asm("rsp");
	quadrant_reference rack = rsp;
	rack[0] = em;
	rack[1] = es;
	asm("mov 0x0(%rsp), %r8");
	asm("mov 0x8(%rsp), %r11");
	asm("callq *%r8");
	asm("add $0x1000, %rsp");
	/*
	*/
	return 0;
}
