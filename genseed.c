#include "./standard.h"

quadrant main(quadrant naof_params, source_vecter params) {
  if(naof_params != 3) {
    printf("params | 2\n");
    printf("1 | naof-secs\n");
		printf("2 | file-name\n");
    return;
  }
	quad naof_secs = 0;
	entree_to_number(params[1], get_naof_secs(params[1]), 16, &naof_secs);
	printf("naof-secs | %lu\n", naof_secs);
	printf("file-name | %s\n", params[2]);

	source proc_name = "secs/procs/genseed.secs";
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

	proc_name = "secs/views/views.secs";
	source_file = syscall(unix_open, proc_name, archive_read);
	source_file_distance = syscall(unix_lseek, source_file, 0, seek_completion);
	source vs = syscall(unix_mmap, non, source_file_distance, map_rws, clerk_descreet, source_file, non);
	printf("vs | %lu\n", vs);
	syscall(unix_close, source_file);

	proc_name = "secs/clerk/clerk.secs";
	source_file = syscall(unix_open, proc_name, archive_read);
	source_file_distance = syscall(unix_lseek, source_file, 0, seek_completion);
	source cs = syscall(unix_mmap, non, source_file_distance, map_rws, clerk_descreet, source_file, non);
	printf("cs | %lu\n", vs);
	syscall(unix_close, source_file);

	asm("sub $0x1000, %rsp");
	register quadrant_reference rsp asm("rsp");
	quadrant_reference rack = rsp;
	rack[0] = em;
	rack[1] = es;
	rack[2] = vs;
	rack[3] = cs;
	rack[4] = naof_secs;
	rack[5] = params[2];
	asm("mov 0x0(%rsp), %r8");
	asm("mov 0x8(%rsp), %r11");
	asm("mov 0x10(%rsp), %r12");
	asm("mov 0x18(%rsp), %r13");
	asm("mov 0x20(%rsp), %r14");
	asm("mov 0x28(%rsp), %r15");
	//asm("lea 0x50(%rsp), %r9");
	asm("lea 0x3(%rip), %rbx");
	asm("jmpq *%r8");
	asm("add $0x1000, %rsp");
	/*
	*/
	return 0;
}
