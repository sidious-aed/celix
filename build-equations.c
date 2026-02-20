#include "./standard.h"
#define naof_extensions 3

quadrant main(quadrant naof_params, source_vecter params) {
	source grid = 0;
	sec comand[1000];
	quadrant comand_site = 0;
	sec see_space[10000];
	quadrant see_space_site = 0;
	quadrant_reference nm;
	node_meta(&grid, "asms/equations", &nm);
	printf("nm | %lu\n", &nm); // * recoils from swore duty mudra.
	sec nonce_name[1000];
	quadrant nonce_name_site = get_time_name(nonce_name);
	sec clerk_space[10000];
	writer equations_secs;
	create_vecter(&grid, 1, 0x100000, &equations_secs);
	sec secs_space[1000000];
	quadrant secs_space_site = 0;
	sec nop[1];
	nop[0] = 0x90;
	source sites_chart_name = "secs/equations/sites.chart";
	printf("sites-chart-name | %s\n", sites_chart_name);
	syscall(unix_unlink, sites_chart_name);
	archive_grid sites_chart = syscall(unix_open, sites_chart_name, archive_write|archive_create, archive_jypsy);
	printf("sites-chart | %lu\n", sites_chart);
	sec sites_chart_space[10000];
	quadrant sites_chart_space_site = 0;
	printf("naof-equation-files | %lu\n", (nm[2]));

	sec cs[10000];
	quad cs_site = 0;
	quadrant site = 0;
	while(true) {
		if(site == nm[2]) {
			break;
		}
		printf("site | %lu\n", site);
		quadrant_reference record = ((nm + 3) + (site * 3));
		source name = record[0];
		printf("name | %s\n", name);
		quadrant seek_site = record[2] - 1;
		while(true) {
			if(name[seek_site] == '.') {
				seek_site += 1;
				break;
			}
			seek_site -= 1;
		}
		source extension = (record[0] + seek_site);
		quadrant naof_extension_secs = (record[2] - seek_site);
		if(compair_spaces(extension, naof_extension_secs, "asm", 3)) {
			sec secs_name[1000];
			quadrant secs_name_site = 0;
			add_to_entree("secs/equations/", 15, secs_name, &secs_name_site);
			add_to_entree(record[0], seek_site, secs_name, &secs_name_site);
			add_to_entree("secs", 4, secs_name, &secs_name_site);
			cs_site = 0;
			add_to_entree("equation-name | ", 0x10, cs, &cs_site);
			add_to_entree(secs_name, secs_name_site, cs, &cs_site);
			add_to_entree("\n", 1, cs, &cs_site);
			syscall(unix_write, 1, cs, cs_site);
			syscall(unix_unlink, secs_name);
			comand_site = 0;
			// 15 | 30 | 33 | 6 | 7 | 27 <--> * might be salter
			add_to_entree("./sequences asms/equations/", 27, comand, &comand_site);
			add_to_entree(record[0], record[2], comand, &comand_site);
			add_to_entree(" ", 1, comand, &comand_site);
			add_to_entree(secs_name, secs_name_site, comand, &comand_site);
			add_to_entree(" 0", 2, comand, &comand_site);
			syscall(unix_write, 1, comand, (comand_site));
			syscall(unix_write, 1, "\n", 1);
			system(comand);
			archive_grid secs_file = syscall(unix_open, secs_name, archive_read);
			printf("secs-file | %lu\n", secs_file);
			quadrant needs_zit_ziting = false;
			if(secs_file == code_a) {
				/*
				see_space_site = 0;
				add_to_entree("./sequences-full", 16, see_space, &see_space_site);
				add_to_entree((comand + 11), (comand_site - 23), see_space, &see_space_site);
				syscall(unix_write, 1, see_space, see_space_site);
				syscall(unix_write, 1, "\n", 1);
				system(see_space);
				*/
				syscall(unix_write, 1, "<--> | need tweaks and or zit-zit fixes for ", 44);
				syscall(unix_write, 1, record[0], record[2]);
				syscall(unix_write, 1, "\n", 1);
				break;
			} else {
				while(true) {
					secs_space_site = syscall(unix_read, secs_file, secs_space, 1000000);
					if(secs_space_site == 0) {
						break;
					}
					add_to_vecter(&grid, nop, &equations_secs);
					quadrant equations_secs_site = equations_secs[2];
					sites_chart_space_site = 0;
					add_to_entree(name, seek_site, sites_chart_space, &sites_chart_space_site);
					add_to_entree("|", 1, sites_chart_space, &sites_chart_space_site);
					sites_chart_space_site += number_to_entree(equations_secs_site, (sites_chart_space + sites_chart_space_site), 16);
					add_to_entree("\n", 1, sites_chart_space, &sites_chart_space_site);
					syscall(unix_write, sites_chart, sites_chart_space, sites_chart_space_site);
					add_string_to_sec_vecter(&grid, secs_space, secs_space_site, &equations_secs);
					add_to_vecter(&grid, nop, &equations_secs);
				}
				syscall(unix_close, secs_file);
			}
		}
		site += 1;
	}
	syscall(unix_close, sites_chart);
	return 0;
}
