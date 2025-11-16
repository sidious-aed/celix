#include "./standard.h"
#define naof_conventional_secs 0x10000

quadrant main(quadrant naof_params, source_vecter params) {
  if(naof_params != 2) {
    printf("params | 1\n");
    printf("1 | base (base-16)\n");
    return;
  }
	quadrant base = 0;
	entree_to_number(params[1], get_distance(params[1]), 16, &base);
	//printf("base | %lu\n", base);
	//return 0;
	sec maps_name[1000];
	quadrant maps_name_site = 0;
	quadrant pid = syscall(unix_getpid, 0);
	add_to_entree("/proc/", 6, maps_name, &maps_name_site);
	maps_name_site += number_to_entree(pid, (maps_name + maps_name_site), 10);
	add_to_entree("/maps", 5, maps_name, &maps_name_site);
	//syscall(unix_write, 1, "maps-name ", 0xa);
	//syscall(unix_write, 1, maps_name, maps_name_site);
	//syscall(unix_write, 1, "\n", 1);
	source arbitrary_name = "droid/clerk-leave.entree";
	archive_grid proc_maps_file = syscall(unix_open, maps_name, archive_read);
	archive_grid cl_maps_file = syscall(unix_open, arbitrary_name, archive_write|archive_create, archive_jypsy);
	sec clerk_space[naof_conventional_secs];
	while(true) {
		directional naof_read_secs = syscall(unix_read, proc_maps_file, clerk_space, naof_conventional_secs);
		if(naof_read_secs <= 0) {
			break;
		}
		syscall(unix_write, cl_maps_file, clerk_space, naof_read_secs);
	}
	syscall(unix_close, proc_maps_file);
	syscall(unix_close, cl_maps_file);
	cl_maps_file = syscall(unix_open, arbitrary_name, archive_read);
	quadrant vvar_site = 0;
	quadrant site = 0;
	while(true) {
		syscall(unix_lseek, cl_maps_file, site, seek_origin);
		directional naof_read_secs = syscall(unix_read, cl_maps_file, clerk_space, naof_conventional_secs);
		if(naof_read_secs <= 0) {
			break;
		}
		quadrant segment_site = seek_space("\n", 1, clerk_space, naof_read_secs);
		//syscall(unix_write, 1, clerk_space, segment_site);
		//syscall(unix_write, 1, "\n", 1);
		quadrant name_site = segment_site - 1;
		while(true) {
			if(clerk_space[name_site] == ' ') {
				name_site += 1;
				break;
			}
			name_site -= 1;
		}
		quadrant naof_name_secs = segment_site - name_site;
		source name = (clerk_space + name_site);
		//syscall(unix_write, 1, "name | ", 7);
		//syscall(unix_write, 1, (name), naof_name_secs);
		//syscall(unix_write, 1, "\n", 1);
		//see_space("name", (name), naof_name_secs);
		if(compair_spaces("[vvar]", 6, (name), naof_name_secs)) {
			quadrant naof_origin_secs = seek_space("-", 1, clerk_space, naof_read_secs);
			entree_to_number(clerk_space, naof_origin_secs, 16, &vvar_site);
		}
		site += (segment_site + 1);
	}
	// seems the kernel updates the time during each wide sequences hash, so no ask needed.
	// ssov | secs-seek-of-vvar
	//source ssov = vvar_site;
	// wsov | words-seek-of-vvar
	//portion * wsov = vvar_site;
	//portion ask = w_at_ask[0];
	//ask = w_at_ask[0];
	//time[0] = kt[0x15];
	//time[1] = kt[0x14];
	//portion * w_at_ask = (vvar_site + 0x84);
	sec b16[100];
	quadrant naof_b16_secs = number_to_entree(vvar_site, b16, 16);
	//syscall(unix_write, 1, b16, naof_b16_secs);
	//syscall(unix_write, 1, "\n", 1);
	quadrant_reference kt = vvar_site;
	quadrant time[2] = {0};
	asm("sub $0x1000, %rsp");
	asm("lea 0x0(%rsp), %r8");
	register quadrant r8 asm("r8");
	quadrant_reference rack = r8;
	rack[0] = kt;
	asm("mov 0x0(%rsp), %r8");
	asm("mov $0x2, %rcx");
	asm("lea 0xa0(%r8), %rsi");
	asm("lea 0x8(%rsp), %rdi");
	asm("rep movsq %ds:(%rsi), %es:(%rdi)");
	time[1] = rack[1];
	time[0] = rack[2];
	asm("add $0x1000, %rsp");
	//see_space("time", time, 0x10);
	//precisision micro = = ((presision)(time[1])) / ((presision)0xffffffffffffffff);
	sec time_entree[100];
	quadrant naof_secs = number_to_entree(time[0], time_entree, base);
	syscall(unix_write, 1, time_entree, naof_secs);
	//return 0;
	naof_secs = presice_to_entree(time[1], 0x3c7d20d47ee1c3, base, time_entree);
	if(naof_secs) {
		naof_secs -= 1;
		syscall(unix_write, 1, (time_entree + 1), naof_secs);
	}
	syscall(unix_write, 1, "\n", 1);
  return 0;
}
