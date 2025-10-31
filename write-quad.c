#include "./standard.h"

quadrant main(quadrant naof_params, source_vecter params) {
  if(naof_params != 3) {
    printf("params | 4\n");
    printf("1 | destination-file\n");
    printf("2 | quad (base-16)\n");
    return;
  }
  archive_grid destination_file = syscall(unix_open, params[1], archive_create|archive_write, archive_arws);
  quadrant quad;
  if(params[2][0] != '-') {
    entree_to_number(params[2], get_distance(params[2]), 16, &quad);
  } else {
    entree_to_number((params[2] + 1), (get_distance(params[2]) - 1), 16, &quad);
    quad = 0xffffffffffffffff - quad;
    quad += 1;
  }
  //printf("quad | %lu\n", quad);
  syscall(unix_write, destination_file, &quad, 8);
  syscall(unix_close, destination_file);
  return 0;
}
