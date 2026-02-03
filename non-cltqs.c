#include "./standard.h"
#include "./clerk.h"

quadrant main(quadrant naof_params, source_vecter params) {
  if(naof_params != 2) {
    printf("params | 1\n");
    printf("1 | binary-name\n");
    return;
  }
	quadrant naof_binary_name_secs = get_naof_secs(params[1]);
	sec time_name[1000];
	quadrant naof_time_name_secs = get_time_name(time_name);
	sec comand[1000];
	quadrant comand_site = 0;
	add_to_entree("objdump -d ", 0xb, comand, &comand_site);
	add_to_entree(params[1], naof_binary_name_secs, comand, &comand_site);
	add_to_entree(" > ", 0x3, comand, &comand_site);
	add_to_entree(time_name, naof_time_name_secs, comand, &comand_site);
	syscall(unix_write, 1, comand, comand_site);
	syscall(unix_write, 1, "\n", 1);
	system(comand);
	source nops_name = "secs/nops.secs";
	sec nops[2] = {0x90, 0x90};
	syscall(unix_unlink, nops_name);
	ip_file nops_file = syscall(unix_open, nops_name, archive_write|archive_create, archive_jypsy);
	syscall(unix_write, nops_file, nops, 2);
	syscall(unix_close, nops_file);

	archive_grid obj_file = syscall(unix_open, time_name, archive_read);
	quadrant naof_obj_file_secs = syscall(unix_lseek, obj_file, 0, seek_completion);
  source obj_map = syscall(unix_mmap, non, naof_obj_file_secs, map_rws, clerk_descreet, obj_file, non);
	//printf("obj-map | %lu\n", obj_map);
	syscall(unix_close, obj_file);
	//printf("naof-obj-file-secs | %lu\n", naof_obj_file_secs);
	quadrant site = 0;
	while(true) {
		//printf("site | %lu\n", site);
		if(site >= naof_obj_file_secs) {
			break;
		}
		source map_at = (obj_map + site);
		quadrant seek_site = (((source)strstr(map_at, "cltq")) - map_at);
		//printf("seek-site | %lu\n", seek_site);
		if((seek_site == non) || (seek_site >= 0xffff000000000000)) {
			break;
		}
		while(true) {
			seek_site -= 1;
			if(map_at[seek_site] == ':') {
				break;
			}
		}
		//printf("seek-site | %lu\n", seek_site);
		quadrant naof_b16_secs = seek_site;
		while(true) {
			seek_site -= 1;
			if(map_at[seek_site] == ' ') {
				seek_site += 1;
				naof_b16_secs = (naof_b16_secs - seek_site);
				break;
			}
		}
		//printf("naof-b16-secs | %lu\n", naof_b16_secs);
		//printf("seek-site | %lu\n", seek_site);
		source section = (map_at + seek_site);
		//printf("section | %lu\n", section);
		quadrant section_site = (section - obj_map);
		//printf("section-site | %lu\n", section_site);
		quadrant naof_section_secs = seek_space("\n", 1, (section), (naof_obj_file_secs - section_site));
		//printf("naof-section-secs | %lu\n", naof_section_secs);
		syscall(unix_write, 1, (section), naof_section_secs);
		syscall(unix_write, 1, "\n", 1);
		quadrant bs = 0;
		entree_to_number(section, naof_b16_secs, 16, &bs);
		//printf("bs | %lu\n", bs);
		comand_site = 0;
		add_to_entree("place secs/nops.secs ", 0x15, comand, &comand_site);
		add_to_entree(params[1], naof_binary_name_secs, comand, &comand_site);
		add_to_entree(" ", 0x1, comand, &comand_site);
		comand_site += number_to_entree(bs, (comand + comand_site), 16);
		syscall(unix_write, 1, comand, comand_site);
		syscall(unix_write, 1, "\n", 1);
		system(comand);
		site += (seek_site + naof_section_secs);
		printf("\n");
	}
	syscall(unix_unlink, time_name);
  return 0;
}
