#include "./standard.h"

quadrant main(quadrant naof_params, source_vecter params) {
  if(naof_params != 3) {
		syscall(unix_write, 1, "params | 2\n", 11);
		syscall(unix_write, 1, "1 | source-file\n", 16);
		syscall(unix_write, 1, "2 | destination-file\n", 21);
    return;
  }
	//sec b16[100];
	archive_grid source = syscall(unix_open, params[1], archive_read);
	//quadrant naof_b16_secs = number_to_entree(source, b16, 16);
	//syscall(unix_write, 1, b16, naof_b16_secs);
	//syscall(unix_write, 1, "\n", 1);
	quadrant naof_secs = syscall(unix_lseek, source, 0, seek_completion);
	//naof_b16_secs = number_to_entree(naof_secs, b16, 16);
	//syscall(unix_write, 1, b16, naof_b16_secs);
	//syscall(unix_write, 1, "\n", 1);
	syscall(unix_lseek, source, 0, seek_origin);
	archive_grid destination = syscall(unix_open, params[2], archive_write|archive_create, archive_arws);
	//naof_b16_secs = number_to_entree(destination, b16, 16);
	//syscall(unix_write, 1, b16, naof_b16_secs);
	//syscall(unix_write, 1, "\n", 1);
	syscall(unix_sendfile, destination, source, 0, naof_secs);
	syscall(unix_close, source);
	syscall(unix_close, destination);
  return 0;
}
