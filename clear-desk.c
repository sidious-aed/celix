#include "./standard.h"
#define naof_extensions 4

quadrant main(quadrant naof_params, source_vecter params) {
  if(naof_params != 2) {
    printf("params | 1\n");
    printf("1 | node\n");
    return;
  }
	writer grid = 0;
	source_vecter extensions[naof_extensions] = {"swp", "stay", "alert", "nonce"};
	quadrant extension_distances[naof_extensions] = {3, 4, 5, 5};
	sec comand[1000];
	quadrant comand_site = 0;
	quadrant_reference nm;
	node_meta(&grid, params[1], &nm);

	quadrant site = 0;
	while(true) {
		if(site == nm[2]) {
			break;
		}
		//printf("site | %lu\n", site);
		quadrant_reference record = ((nm + 3) + (site * 3));
		site += 1;
		if(record[1] != 8) {
			continue;
		}
		source name = record[0];
		quadrant seek_site = record[2] - 1;
		while(true) {
			if(name[seek_site] == '.') {
				seek_site += 1;
				break;
			}
			if(seek_site == 0) {
				break;
			}
			seek_site -= 1;
		}
		source extension = (record[0] + seek_site);
		quadrant naof_extension_secs = (record[2] - seek_site);
		//syscall(unix_write, 1, "extension | ", 0xc);
		//syscall(unix_write, 1, (extension), (naof_extension_secs));
		//syscall(unix_write, 1, "\n", 0x1);
		quadrant is_in_extensions = false;
		if(seek_site != 0) {
			quadrant esite = 0;
			while(true) {
				if(esite == naof_extensions) {
					break;
				}
				if(compair_spaces(extension, naof_extension_secs, extensions[esite], extension_distances[esite])) {
					is_in_extensions = true;
					break;
				}
				esite += 1;
			}
		}
		//printf("is-in-extensions | %lu\n", is_in_extensions);
		if(is_in_extensions) {
			syscall(unix_write, 1, "equation-name | ", 0x10);
			syscall(unix_write, 1, (name), (record[2]));
			syscall(unix_write, 1, "\n", 0x1);
			//printf("type | %lu\n", record[1]);
			syscall(unix_unlink, record[0]);
		}
	}
	return 0;
}
