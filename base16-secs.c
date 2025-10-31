#include "./standard.h"

quadrant main(quadrant naof_params, source_vecter params) {
  if(naof_params != 4) {
    syscall(unix_write, 1, "params | 1\n", 11);
    syscall(unix_write, 1, "1 | file\n", 9);
    syscall(unix_write, 1, "2 | site (base-16)\n", 19);
    syscall(unix_write, 1, "3 | distance (base-16)\n", 23);
    return 0;
  }
  archive_grid file = syscall(unix_open, params[1], archive_read);
  quadrant site;
  entree_to_number(params[2], get_distance(params[2]), 16, &site);
  printf("site | %lu\n", site);
  quadrant distance;
  entree_to_number(params[3], get_distance(params[3]), 16, &distance);
  printf("distance | %lu\n", distance);
  if(file == 0xffffffffffffffff) {
    syscall(unix_write, 1, "[]\n", 3);
    return 0;
  }
  quadrant file_distance = syscall(unix_lseek, file, 0, seek_completion);
  if(file_distance == 0) {
    syscall(unix_write, 1, "[]\n", 3);
    return 0;
  }
  syscall(unix_lseek, file, 0, seek_origin);
  source fast_from_archives = syscall(unix_mmap, non, file_distance, PROT_READ, MAP_PRIVATE, file, 0);
  syscall(unix_lseek, file, 0, seek_origin);
  see_base16("fast-from-archives", (fast_from_archives + site), distance);
  sec print_space[100];
  number_to_entree(file_distance, print_space, 16);
  printf("file-distance (base-16) | %s\n", print_space);
  printf("file-distance (base-10) | %lu\n", file_distance);
  return 0;
}
