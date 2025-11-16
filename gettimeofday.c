#include "./standard.h"

quadrant main(quadrant naof_params, source_vecter params) {
  if(naof_params != 2) {
    printf("params | 1\n");
    printf("1 | base (base-16)\n");
    return;
	}
	quadrant naof_param0_secs = get_distance(params[1]);
	//quadrant naof_parm0_secs = 10;
	quadrant base = 0;
	entree_to_number(params[0], naof_param0_secs, 16, &base);

	sec b16[100];
	quadrant times[2] = {0};
	quadrant zones[2] = {0};
	gettimeofday(times, zones);
	quadrant some_results = times;
	quadrant_reference results = times;
	syscall(unix_write, 1, "entree\n", 7);
	syscall(unix_write, 1, "------\n", 7);
	see_encoded(times, 0x20, 16);
	/*
	quadrant naof_secs = 0;
	quadrant site = 0;
	while(true) {
		if(site == 4) {
			break;
		}
		quadrant element = results[site];
		naof_secs = number_to_entree(element, b16, base);
		syscall(unix_write, 1, b16, naof_secs);
		syscall(unix_write, 1, "\n", 1);
		see_space("element", &element, 8);
		site += 1;
	}
	*/
	return 0;
}
