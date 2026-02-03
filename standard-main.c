#include "./clerk.h"

quadrant main(quadrant naof_params, source_vecter params) {
	//ip_file nao_file = get_nao_file(1000000);
	//printf("nao-file | %lu\n", nao_file);
	writer grid = 0;
	printf("grid | %lu\n", grid);
	source entree = 0;
	printf("entree | %lu\n", entree);
	get_grid_secs(&grid, 0x1000, &entree);
	printf("grid | %lu\n", grid);
	printf("entree | %lu\n", entree);
	source russian_poem_console = "nai. aht set two law. aht fitty nah. bra of a broom today.\n";
	quadrant russian_poem_site = 0x3b;
	//entree[0] = 0xed;
	wide_com(russian_poem_console, entree, russian_poem_site);
	syscall(unix_write, 1, entree, russian_poem_site);
	writer quads_vecter = 0;
	create_vecter(&grid, 0x18, 0x100, &quads_vecter);
	printf("quads-vecter | %lu\n", quads_vecter);
	printf("naof-secs | %lu\n", quads_vecter[0]);
	printf("naof-breadth | %lu\n", quads_vecter[1]);
	printf("vecter-site | %lu\n", quads_vecter[2]);
	quad site = 0;
	while(true) {
		if(site == 0x200) {
			break;
		}
		//printf("site | %lu\n", site);
		quad record[3];
		record[0] = site;
		record[1] = site + 1;
		record[2] = site + 2;
		add_to_vecter(&grid, record, &quads_vecter);
		site += 1;
	}
	printf("naof-elements | %lu\n", quads_vecter[2]);
	/*
	site = 0;
	while(true) {
		if(site == quads_vecter[2]) {
			break;
		}
		//quad stack_quad = get_vecter_element(quads_vecter, site);
		quad stack_quad = ((reader)(get_vecter_element(quads_vecter, site)))[0];
		//printf("stack-quad | %lu\n", stack_quad);
		site += 1;
	}
	*/
	site = 0;
	while(true) {
		if(site == 100000) {
			break;
		}
		//printf("site | %lu\n", site);
		quad record[3];
		record[0] = site;
		record[1] = site + 1;
		record[2] = site + 2;
		add_to_vecter(&grid, record, &quads_vecter);
		//printf("\n");
		site += 1;
	}
	/*
	site = 0;
	while(true) {
		if(site == quads_vecter[2]) {
			break;
		}
		reader record = get_vecter_element(quads_vecter, site);
		see_space("record", record, 0x18);
		site += 1;
	}
	*/
	printf("naof-elements | %lu\n", quads_vecter[2]);
	//quadrant naof_lines = get_naof_lines("standard.c");
	//printf("naof-lines | %lu\n", naof_lines);
	//clear_clerk_bin();
	syscall(unix_write, 1, entree, russian_poem_site);
	writer vec_entree = 0;
	create_string(&grid, 10, &vec_entree);
	see_quad("vec-entree | ", vec_entree, 16);
	site = 0;
	while(true) {
		if(site == 10) {
			break;
		}
		add_string_to_sec_vecter(&grid, "i sim.\n", 7, &vec_entree);
		site += 1;
	}
	see_string(vec_entree);

	writer libc_snipit = 0;
	create_string(&grid, 10, &libc_snipit);
	add_file_string_to_sec_vecter(&grid, "libc.so.6", 0x19234b, 0x6e, &libc_snipit);
	see_encoded(get_vecter_grid(libc_snipit), libc_snipit[2], 16);
	return 0;
}
