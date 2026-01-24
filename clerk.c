#include "./clerk.h"

vast i_sim_from_clerk() {
	syscall(unix_write, 1, "i sim.\n", 7);
	return;
}

quadrant clerk_code(source entree, writer entree_site) {
	asm("push %r8");
	asm("mov $0xffffffffffffff80, %rax");
	asm("mov %fs:(%rax), %r8");
	register quadrant rbx asm("r8");
	quadrant code = rbx;
	//asm("xor %r8, %r8");
	//asm("mov %r8, %fs:(%rax)");
	asm("pop %r8");
	if(entree && entree_site) {
		add_to_entree(clerk_syscall_code_entrees[code], clerk_syscall_code_entrees_naof_secs[code], entree, entree_site);
	}
	return code;
}

// seems there is might potential after an execve syscall that we need to exit_group ourself from our main
// so; where clerk-stay is a nice abstraction, simply replace return 0 in main with syscall(unix_exit_group, 0)
// seems the tty-print-map has some extra result quarks than the chain results of the stock basises
quadrant clerk_stay(quadrant_reference pause_meta, source binary_name, source_vecter params, source_vecter environment) {
	quadrant process_id[1];
	//syscall(unix_nanosleep, pause_meta);
	quadrant pid = syscall(unix_clone, 0x100011, 0, process_id);
	//futex_swtch(switches, switch_site, 11);
	if(pid == 0) {
		syscall(unix_write, 1, "initing-clerk-stay\n", 19);
		syscall(unix_execve, binary_name, params, environment);
		syscall(unix_exit, 0);
		//futex_swtch(switches, switch_site, 0);
		//printf("switch | %lu\n", ((source)(switches))[switch_site]);
	} else {
		//syscall(unix_nanosleep, pause_meta);
		//futex_pause(switches, switch_site, 11);
		//printf("process-id | %lu\n", pid);
		syscall(unix_wait4, pid, non, non);
		process_id[0] = 0;
	}
	// later maybe; environment still up, maybe meant still warnly
	//syscall(unix_write, 1, "i sim.\n", 7);
	return binary_name;
}

quadrant node_meta(source node_name, writer rnode_meta) {
	sec nm[1000];
	writer node_meta;
	create_vecter(0x18, 100, &node_meta);
	archive_grid node = syscall(unix_open, node_name, archive_read);
	//printf("node | %lu\n", node);
	quadrant naof_getdents = 0;
	while(true) {
		//naoify(nm, 1000);
		quadrant naof_secs = syscall(unix_getdents, node, nm, 1000);
		if(naof_secs == 0) {
			break;
		}
		naof_getdents += 1;
		//perror("getdents");
		//printf("naof-secs | %lu\n", naof_secs);
		//see_space("nm", nm, naof_secs);
		quadrant psite = 0;
		while(true) {
			if(psite >= naof_secs) {
				break;
			}
			quadrant rsite = psite;
			psite += 16;
			quadrant naof_record_secs = ((dyno_reference)(nm + psite))[0];
			//see_space("nm-rsite", (nm + rsite), naof_record_secs);
			psite += 2;
			//see_space("nm-psite", (nm + psite), 100);
			quadrant entree_site = psite;
			while(true) {
				if(nm[psite] == 0) {
					break;
				}
				psite += 1;
			}
			quadrant naof_entree_secs = psite - entree_site;
			//syscall(unix_write, 1, (nm + entree_site), naof_entree_secs);
			//syscall(unix_write, 1, "\n", 1);
			quadrant naof_memory_secs = (naof_entree_secs + 1);
			quadrant entree = malloc(naof_memory_secs);
			naoify(entree, naof_memory_secs);
			place((nm + entree_site), entree, naof_entree_secs);
			//see_space("nm-psite", (nm + psite), 100);
			sec record[0x18] = {0, 0, 0};
			place(&entree, record, 8);
			place(&nm[(rsite + naof_record_secs - 1)], (record + 8), 1);
			place(&naof_entree_secs, (record + 0x10), 8);
			//see_space("record", record, 0x18);
			psite = rsite + naof_record_secs;
			add_to_vecter(record, &node_meta);
		}
		//printf("\n");
		//break;
	}
	//printf("naof-getdents | %lu\n", naof_getdents);
	rnode_meta[0] = node_meta;
	return 0;
}

vast node_meta_completion(quadrant_reference nm) {
	quadrant site = 0;
	while(true) {
		if(site == nm[2]) {
			break;
		}
		writer record = (nm + 3 + (site * 2));
		//see_space("record", record, 16);
		//printf("entree\t%lu\t%s\n", record[1], record[0]);
		free(record[0]);
		site += 1;
	}
	free(nm[0]);
	return;
}
