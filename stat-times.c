#include "./standard.h"
#define naof_clerk_space_secs 1000000

quadrant main(quadrant naof_params, source_vecter params) {
	sec dents_analasys[1000];
	quadrant pid = syscall(unix_getpid, 0);
	sec stat_name[1000];
	sec clerk_space[naof_clerk_space_secs];
	quadrant stat_name_site = 0;
	add_to_entree("/proc/", 6, stat_name, &stat_name_site);
	stat_name_site += number_to_entree(pid, (stat_name + stat_name_site), 10);
	//add_to_entree("/schedstat", 10, stat_name, &stat_name_site);
	//archive_grid node = syscall(unix_open, ".", archive_read);
	//syscall(unix_getdents, node, dents_analasys, 1000);
	add_to_entree("/stat", 6, stat_name, &stat_name_site);
	syscall(unix_write, 1, stat_name, stat_name_site);
	syscall(unix_write, 1, "\n", 1);
	quadrant site = 0;
	quadrant sum = 0;
	while(true) {
		if(site == 0xffffff) {
			break;
		}
		sum += site;
		site += 1;
	}
	/*
	*/
	archive_grid stat_file = syscall(unix_open, stat_name, archive_read);
	quadrant naof_secs = syscall(unix_read, stat_file, clerk_space, naof_clerk_space_secs);
	//see_space("clerk-space", clerk_space, naof_secs);
	syscall(unix_write, 1, clerk_space, naof_secs);
	syscall(unix_write, 1, "\n", 1);
  return 0;
}
