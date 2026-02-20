#include "./standard.h"

quadrant main(quadrant naof_params, source_vecter params) {
  if(naof_params != 3) {
    printf("params | 2\n");
    printf("1 | proc-name\n");
    printf("2 | shell-name\n");
    return;
  }
	// cs | clerk-space synonomous with cp | (clerk-pages|clerk-parchment) <--> * (es) always mean-(t)
	sec cs[10000];
	quad cs_site = 0;
	quadrant naof_proc_name_secs = get_naof_secs(params[1]);
	quadrant naof_shell_name_secs = get_naof_secs(params[2]);
	if(compair_spaces((params[2] + naof_shell_name_secs - 2), 2, ".c", 2) == false) {
		cs_site = 0;
		// <--> interesting that 0x53 is 83.
		add_to_entree("<--> esoteric-wide-standards is a c extension for shell-name please suffix with .c\n", 0x53, cs, &cs_site);
																																																	// <--> in short russian
		syscall(unix_write, 1, cs, cs_site);
		syscall(unix_exit_group, 0);
	}
	//quadrant naof_shell_name_secs = get_naof_secs(params[2]);
	source shell_shell_name = "shell.c";
  archive_grid shell_shell_file = syscall(unix_open, shell_shell_name, archive_read);
  quadrant naof_shell_map_secs = syscall(unix_lseek, shell_shell_file, 0, seek_completion);
  source shell_map = syscall(unix_mmap, non, naof_shell_map_secs, map_rws, clerk_descreet, shell_shell_file, non);
  source new_shell_map = syscall(unix_mmap, non, (naof_shell_map_secs + 0x1000), map_rws, map_cloe, non, non);
	//printf("shell-map | %s\n", shell_map);
	quadrant proc_name_site = (seek_space("source proc_name = \"", 0x14, shell_map, naof_shell_map_secs) + 0x14);
	//printf("shell-map-from-proc-name-site | %s\n", (shell_map + proc_name_site));
	quadrant new_shell_map_site = 0;
	add_to_entree(shell_map, proc_name_site, new_shell_map, &new_shell_map_site);
	add_to_entree(params[1], naof_proc_name_secs, new_shell_map, &new_shell_map_site);
	//printf("new-shell-map-site | %lu\n", new_shell_map_site);
	add_to_entree((shell_map + proc_name_site), (naof_shell_map_secs - proc_name_site), new_shell_map, &new_shell_map_site);
	//printf("new-shell-map-site | %lu\n", new_shell_map_site);
	//printf("new-shell-map | %s\n", new_shell_map);
	archive_grid new_shell_file = syscall(unix_open, params[2], archive_write|archive_create, archive_jypsy);
	syscall(unix_write, new_shell_file, new_shell_map, new_shell_map_site);
	syscall(unix_close, new_shell_file);
	cs_site = 0;
	add_to_entree("gcc ", 4, cs, &cs_site);
	add_to_entree(params[2], naof_shell_name_secs, cs, &cs_site);
	add_to_entree(" -o ", 4, cs, &cs_site);
	add_to_entree(params[2], (naof_shell_name_secs - 2), cs, &cs_site);
	add_to_entree("\n", 1, cs, &cs_site);
	syscall(unix_write, 1, cs, cs_site);
	cs[(cs_site - 1)] = 0;
	system(cs);
  return 0;
}
