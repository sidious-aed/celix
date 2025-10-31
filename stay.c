#include "./standard.h"

quadrant main(quadrant naof_params, source_vecter params) {
  if(naof_params != 2) {
		syscall(unix_write, 1, "params | 2\n", 11);
		syscall(unix_write, 1, "1 | comand\n", 11);
    return;
  }
	quadrant exec_params[4];
	source exec_param_0 = "sh";
	exec_params[0] = exec_param_0;
	source exec_param_1 = "-c";
	exec_params[1] = exec_param_1;
	//exec_params[2] = params[2];
	exec_params[3] = 0;
	quadrant env[1] = {0};
	quadrant comand_distance = get_distance(params[1]);
	sec stay_name[100];
	sec alert_name[100];
	quadrant name_site = 0;
	add_seed62_to_entree(7, stay_name, &name_site);
	add_to_entree(".stay", 5, stay_name, &name_site);
	syscall(unix_write, 1, stay_name, 12);
	syscall(unix_write, 1, "\n", 1);
	name_site = 0;
	add_seed62_to_entree(7, alert_name, &name_site);
	add_to_entree(".alert", 6, alert_name, &name_site);
	syscall(unix_write, 1, alert_name, 13);
	syscall(unix_write, 1, "\n", 1);
	sec comand[1000];
	quadrant comand_site = 0;
	add_to_entree(params[1], comand_distance, comand, &comand_site);
	add_to_entree(" > ", 3, comand, &comand_site);
	add_to_entree(stay_name, 12, comand, &comand_site);
	add_to_entree(" 2> ", 4, comand, &comand_site);
	add_to_entree(alert_name, 13, comand, &comand_site);
	syscall(unix_write, 1, comand, comand_site);
	syscall(unix_write, 1, "\n", 1);
	system(comand);
	exec_params[2] = comand;
	archive_grid stay_file = syscall(unix_open, stay_name, archive_read);
	if(stay_file > 0) {
		quadrant stay_distance = syscall(unix_lseek, stay_file, 0, seek_completion);
		if(stay_distance > 0) {
			comand_site = 0;
			add_to_entree("vim ", 4, comand, &comand_site);
			add_to_entree(stay_name, 12, comand, &comand_site);
			syscall(unix_write, 1, comand, comand_site);
			syscall(unix_write, 1, "\n", 1);
			system(comand);
		}
	}
	archive_grid alert_file = syscall(unix_open, alert_name, archive_read);
	if(alert_file > 0) {
		quadrant alert_distance = syscall(unix_lseek, alert_file, 0, seek_completion);
		if(alert_distance > 0) {
			comand_site = 0;
			add_to_entree("vim ", 4, comand, &comand_site);
			add_to_entree(alert_name, 13, comand, &comand_site);
			syscall(unix_write, 1, comand, comand_site);
			syscall(unix_write, 1, "\n", 1);
			system(comand);
		}
	}
	//syscall(unix_execve, "/bin/sh", exec_params, env);
	comand_site = 0;
	add_to_entree("./ul ", 5, comand, &comand_site);
	add_to_entree(stay_name, 12, comand, &comand_site);
	syscall(unix_write, 1, comand, comand_site);
	syscall(unix_write, 1, "\n", 1);
	//system(comand);
	comand_site = 0;
	add_to_entree("./ul ", 5, comand, &comand_site);
	add_to_entree(alert_name, 13, comand, &comand_site);
	syscall(unix_write, 1, comand, comand_site);
	syscall(unix_write, 1, "\n", 1);
	//system(comand);

  return 0;
}
