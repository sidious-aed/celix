#include "./standard.h"

quadrant main(quadrant naof_params, source_vecter params) {
  if(naof_params != 2) {
		syscall(unix_write, 1, "params | 1\n", 11);
		syscall(unix_write, 1, "1 | node-name\n", 14);
    return;
  }
	syscall(unix_rmdir, params[1]);
  return 0;
}
