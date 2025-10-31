#include "./machine.h"

directional source_site(quadrant naof_sources, source_vecter sources, reader sources_distances, source entree, quadrant entree_distance) {
  quadrant site = 0;
  while(true) {
    if(site == naof_sources) {
      break;
    }
    //printf("entree | %s\n", entree);
    //printf("entree-distance | %lu\n", entree_distance);
    //printf("sources[%lu] | %s\n", site, sources[site]);
    //printf("sources-distance | %lu\n", sources_distances[site]);
    if(compair_spaces(entree, entree_distance, sources[site], sources_distances[site])) {
      return site;
    }
    site += 1;
  }
  return -1;
}

quadrant asm_motion_stay(source alu_module, quadrant alu_module_distance, directional motion, source write_space) {
  directional motion_alu_site = source_site(naof_standard_motion_alus, standard_motion_alus, standard_motion_alus_distances, alu_module, alu_module_distance);
  if(motion_alu_site == -1) {
    printf("clerical warn | no sign found for %s in asm-motion-stay\n", alu_module);
    syscall(unix_exit_group, 0);
  }
  quadrant write_site = 0;
  place(standard_motion_signs[motion_alu_site], write_space, standard_motion_signs_distances[motion_alu_site]);
  write_site += standard_motion_signs_distances[motion_alu_site];
  place(&motion, (write_space + write_site), 4);
  write_site += 4;
  return write_site;
}

quadrant asm_set_conditional(source alu_module, quadrant alu_module_distance, quadrant rack_site, source write_space) {
  directional motion_alu_site = source_site(naof_set_conditionals, set_conditionals, set_conditional_distances, alu_module, alu_module_distance);
  //printf("motion-alu-site | %lu\n", motion_alu_site);
  if(motion_alu_site == -1) {
    printf("clerical warn | no sign found for %s in asm-motion-stay\n", alu_module);
    syscall(unix_exit_group, 0);
  }
  quadrant write_site = 0;
  place(set_conditional_alus[motion_alu_site], write_space, 4);
  write_site += 4;
  place(&rack_site, (write_space + write_site), 4);
  write_site += 4;
  //see_space("set-sec-from-conditional", write_space, write_site);
  return write_site;
}

quadrant asm_motion_stay_from(source alu_module, quadrant alu_module_distance, quadrant origin, quadrant destination, source write_space) {
  directional motion_alu_site = source_site(naof_standard_motion_alus, standard_motion_alus, standard_motion_alus_distances, alu_module, alu_module_distance);
  //printf("motion-alu-site | %lu\n", motion_alu_site);
  quadrant naof_secs = standard_motion_signs_distances[motion_alu_site] + 4;
  directional motion = destination - (origin + naof_secs);
  directional write_site = asm_motion_stay(alu_module, alu_module_distance, motion, write_space);
  return write_site;
}

quadrant asm_clerical_motion_stay_from(source alu_module, quadrant alu_module_distance, quadrant origin, quadrant destination, source write_space) {
  //printf("alu-module | %s\n", alu_module);
  directional motion_alu_site = source_site(naof_standard_motion_alus, clerical_motion_alus, clerical_motion_alus_distances, alu_module, alu_module_distance);
  quadrant naof_secs = standard_motion_signs_distances[motion_alu_site] + 4;
  directional motion = destination - (origin + naof_secs);
  directional write_site = asm_motion_stay(standard_motion_alus[motion_alu_site], standard_motion_alus_distances[motion_alu_site], motion, write_space);
  return write_site;
}

quadrant asm_back_stay_from(quadrant origin, quadrant destination, source write_space) {
	directional distance = destination - origin;
  //printf("alu-module | %s\n", alu_module);
	quadrant write_site = 0;
	sec back_stay_sign[1] = {232};
  place(back_stay_sign, (write_space), 1);
  write_site += 1;
  place(&distance, (write_space + write_site), 4);
  write_site += 4;
  return write_site;
}

quadrant asm_register_to_rack(source register_source, quadrant register_distance, source write_space) {
  directional register_site = source_site(naof_general_registers, gnu_registers, gnu_registers_distances, register_source, register_distance);
  //printf("pair-site | %ld\n", register_site);
  if(register_site == -1) {
    printf("clerical warn | no sign found for %s in asm-move-registers\n", register_source);
    syscall(unix_exit_group, 0);
  }
  //printf("naof-and-sign-secs | %lu\n", naof_and_sign_secs[register_site]);
  //see_space("sign", and_signs[register_site], naof_and_sign_secs[register_site]);
  place(register_to_rack_signs[register_site], write_space, register_to_rack_signs_distances[register_site]);
  quadrant write_site = register_to_rack_signs_distances[register_site];
  return write_site;
}

quadrant asm_rack_to_register(source register_source, quadrant register_distance, source write_space) {
  directional register_site = source_site(naof_general_registers, gnu_registers, gnu_registers_distances, register_source, register_distance);
  //printf("pair-site | %ld\n", register_site);
  if(register_site == -1) {
    printf("clerical warn | no sign found for %s in asm-move-registers\n", register_source);
    syscall(unix_exit_group, 0);
  }
  //printf("naof-and-sign-secs | %lu\n", naof_and_sign_secs[register_site]);
  //see_space("sign", and_signs[register_site], naof_and_sign_secs[register_site]);
  place(rack_to_register_signs[register_site], write_space, rack_to_register_signs_distances[register_site]);
  quadrant write_site = rack_to_register_signs_distances[register_site];
  return write_site;
}

quadrant asm_leeve_registers(source registers, quadrant registers_distance, directional leeve_site, source write_space) {
  directional pair_site = source_site(naof_register_pairs, register_pairs, register_pairs_distances, registers, registers_distance);
  //printf("pair-site | %ld\n", pair_site);
  if(pair_site == -1) {
    printf("clerical warn | no sign found for %s in asm-move-registers\n", registers);
    syscall(unix_exit_group, 0);
  }
  //printf("naof-leeve-sign-secs | %lu\n", naof_leeve_sign_secs[pair_site]);
  //see_space("sign", leeve_signs[pair_site], naof_leeve_sign_secs[pair_site]);
  place(leeve_signs[pair_site], write_space, naof_leeve_sign_secs[pair_site]);
  quadrant write_site = naof_leeve_sign_secs[pair_site];
  place(&leeve_site, (write_space + write_site), 4);
  write_site += 4;
  return write_site;
}

quadrant asm_move_registers(source registers, quadrant registers_distance, directional move_site, source write_space) {
  //printf("registers-distance | %lu\n", registers_distance);
  directional pair_site = source_site(naof_register_pairs, register_pairs, register_pairs_distances, registers, registers_distance);
  //printf("pair-site | %ld\n", pair_site);
  if(pair_site == -1) {
    printf("clerical warn | no sign found for %s in asm-move-registers\n", registers);
    syscall(unix_exit_group, 0);
  }
  //printf("naof-move-sign-secs | %lu\n", naof_move_sign_secs[pair_site]);
  //see_space("sign", move_signs[pair_site], naof_move_sign_secs[pair_site]);
  place(move_signs[pair_site], write_space, naof_move_sign_secs[pair_site]);
  quadrant write_site = naof_move_sign_secs[pair_site];
  place(&move_site, (write_space + write_site), 4);
  write_site += 4;
  return write_site;
}

quadrant asm_move_to(source registers, quadrant registers_distance, directional move_site, source write_space) {
  directional pair_site = source_site(naof_to_register_pairs, to_register_pairs, to_register_pairs_distances, registers, registers_distance);
  //printf("pair-site | %ld\n", pair_site);
  if(pair_site == -1) {
    printf("clerical warn | no sign found for %s in asm-move-registers\n", registers);
    syscall(unix_exit_group, 0);
  }
  //printf("naof-move-sign-secs | %lu\n", naof_move_sign_secs[pair_site]);
  //see_space("sign", move_signs[pair_site], naof_move_sign_secs[pair_site]);
  place(move_to_signs[pair_site], write_space, naof_move_to_sign_secs[pair_site]);
  quadrant write_site = naof_move_to_sign_secs[pair_site];
  place(&move_site, (write_space + write_site), 4);
  write_site += 4;
  return write_site;
}

quadrant asm_move_sec(source registers, quadrant registers_distance, directional move_site, source write_space) {
  directional pair_site = source_site(naof_register_pairs, register_pairs, register_pairs_distances, registers, registers_distance);
  //printf("pair-site | %ld\n", pair_site);
  if(pair_site == -1) {
    printf("clerical warn | no sign found for %s in asm-move-registers\n", registers);
    syscall(unix_exit_group, 0);
  }
  //printf("naof-move-sign-secs | %lu\n", naof_move_sign_secs[pair_site]);
  //see_space("sign", move_signs[pair_site], naof_move_sign_secs[pair_site]);
  place(move_sec_signs[pair_site], write_space, naof_move_sec_sign_secs[pair_site]);
  quadrant write_site = naof_move_sec_sign_secs[pair_site];
  place(&move_site, (write_space + write_site), 4);
  write_site += 4;
  return write_site;
}

quadrant asm_move_sec_to(source registers, quadrant registers_distance, directional move_site, source write_space) {
  directional pair_site = source_site(naof_to_register_pairs, to_register_pairs, to_register_pairs_distances, registers, registers_distance);
  //printf("pair-site | %ld\n", pair_site);
  if(pair_site == -1) {
    printf("clerical warn | no sign found for %s in asm-move-registers\n", registers);
    syscall(unix_exit_group, 0);
  }
  //printf("naof-move-sign-secs | %lu\n", naof_move_sign_secs[pair_site]);
  //see_space("sign", move_sec_to_signs[pair_site], naof_move_sec_to_sign_secs[pair_site]);
  place(move_sec_to_signs[pair_site], write_space, naof_move_sec_to_sign_secs[pair_site]);
  quadrant write_site = naof_move_sec_to_sign_secs[pair_site];
  place(&move_site, (write_space + write_site), 4);
  write_site += 4;
  return write_site;
}

quadrant asm_add_registers(source registers, quadrant registers_distance, source write_space) {
  directional pair_site = source_site(naof_register_pairs, register_pairs, register_pairs_distances, registers, registers_distance);
  //printf("pair-site | %ld\n", pair_site);
  if(pair_site == -1) {
    printf("clerical warn | no sign found for %s in asm-move-registers\n", registers);
    syscall(unix_exit_group, 0);
  }
  //printf("naof-add-sign-secs | %lu\n", naof_add_sign_secs[pair_site]);
  //see_space("sign", add_signs[pair_site], naof_add_sign_secs[pair_site]);
  place(add_signs[pair_site], write_space, 3);
  return 3;
}

quadrant asm_sub_registers(source registers, quadrant registers_distance, source write_space) {
  directional pair_site = source_site(naof_register_pairs, register_pairs, register_pairs_distances, registers, registers_distance);
  //printf("pair-site | %ld\n", pair_site);
  if(pair_site == -1) {
    printf("clerical warn | no sign found for %s in asm-move-registers\n", registers);
    syscall(unix_exit_group, 0);
  }
  //printf("naof-sub-sign-secs | %lu\n", naof_sub_sign_secs[pair_site]);
  //see_space("sign", sub_signs[pair_site], naof_sub_sign_secs[pair_site]);
  place(sub_signs[pair_site], write_space, 3);
  return 3;
}

quadrant asm_and_registers(source registers, quadrant registers_distance, source write_space) {
  directional pair_site = source_site(naof_register_pairs, register_pairs, register_pairs_distances, registers, registers_distance);
  //printf("pair-site | %ld\n", pair_site);
  if(pair_site == -1) {
    printf("clerical warn | no sign found for %s in asm-move-registers\n", registers);
    syscall(unix_exit_group, 0);
  }
  //printf("naof-and-sign-secs | %lu\n", naof_and_sign_secs[pair_site]);
  //see_space("sign", and_signs[pair_site], naof_and_sign_secs[pair_site]);
  place(and_signs[pair_site], write_space, 3);
  return 3;
}

quadrant asm_compair_registers(source registers, quadrant registers_distance, source write_space) {
  directional pair_site = source_site(naof_register_pairs, register_pairs, register_pairs_distances, registers, registers_distance);
  //printf("pair-site | %ld\n", pair_site);
  if(pair_site == -1) {
    printf("clerical warn | no sign found for %s in asm-move-registers\n", registers);
    syscall(unix_exit_group, 0);
  }
  //printf("naof-compair-sign-secs | %lu\n", naof_compair_sign_secs[pair_site]);
  //see_space("sign", compair_signs[pair_site], naof_compair_sign_secs[pair_site]);
  place(compair_signs[pair_site], write_space, 3);
  return 3;
}

quadrant asm_set_register(source register_source, quadrant register_distance, quadrant number, source write_space) {
  directional register_site = source_site(naof_clerical_registers, gnu_registers, gnu_registers_distances, register_source, register_distance);
  //printf("pair-site | %ld\n", register_site);
  if(register_site == -1) {
    printf("clerical warn | no sign found for %s in asm-move-registers\n", register_source);
    syscall(unix_exit_group, 0);
  }
  //printf("naof-and-sign-secs | %lu\n", naof_and_sign_secs[register_site]);
  //see_space("sign", and_signs[register_site], naof_and_sign_secs[register_site]);
  place(set_signs[register_site], write_space, 2);
  place(&number, (write_space + 2), 8);
  return 10;
}

quadrant asm_add_constant(source register_source, quadrant register_distance, quadrant number, source write_space) {
  directional register_site = source_site(naof_clerical_registers, gnu_registers, gnu_registers_distances, register_source, register_distance);
  //printf("pair-site | %ld\n", register_site);
  if(register_site == -1) {
    printf("clerical warn | no sign found for %s in asm-move-registers\n", register_source);
    syscall(unix_exit_group, 0);
  }
  //printf("naof-and-sign-secs | %lu\n", naof_and_sign_secs[register_site]);
  //see_space("sign", and_signs[register_site], naof_and_sign_secs[register_site]);
  place(add_constant_signs[register_site], write_space, naof_add_constant_sign_secs[register_site]);
  quadrant write_site = naof_add_constant_sign_secs[register_site];
  place(&number, (write_space + write_site), 4);
  write_site += 4;
  return write_site;
}

quadrant asm_sub_constant(source register_source, quadrant register_distance, quadrant number, source write_space) {
  directional register_site = source_site(naof_clerical_registers, gnu_registers, gnu_registers_distances, register_source, register_distance);
  //printf("pair-site | %ld\n", register_site);
  if(register_site == -1) {
    printf("clerical warn | no sign found for %s in asm-move-registers\n", register_source);
    syscall(unix_exit_group, 0);
  }
  //printf("naof-and-sign-secs | %lu\n", naof_and_sign_secs[register_site]);
  //see_space("sign", and_signs[register_site], naof_and_sign_secs[register_site]);
  place(sub_constant_signs[register_site], write_space, naof_sub_constant_sign_secs[register_site]);
  quadrant write_site = naof_sub_constant_sign_secs[register_site];
  place(&number, (write_space + write_site), 4);
  write_site += 4;
  return write_site;
}

quadrant asm_compair_constant(source register_source, quadrant register_distance, quadrant number, source write_space) {
  directional register_site = source_site(naof_clerical_registers, gnu_registers, gnu_registers_distances, register_source, register_distance);
  //printf("pair-site | %ld\n", register_site);
  if(register_site == -1) {
    printf("clerical warn | no sign found for %s in asm-move-registers\n", register_source);
    syscall(unix_exit_group, 0);
  }
  //printf("naof-and-sign-secs | %lu\n", naof_and_sign_secs[register_site]);
  //see_space("sign", and_signs[register_site], naof_and_sign_secs[register_site]);
  place(compair_constant_signs[register_site], write_space, naof_compair_constant_sign_secs[register_site]);
  quadrant write_site = naof_compair_constant_sign_secs[register_site];
  place(&number, (write_space + write_site), 4);
  write_site += 4;
  return write_site;
}

quadrant asm_divide(quadrant rack_site, source write_space) {
  place(divide_sign, write_space, 4);
  place(&rack_site, (write_space + 4), 4);
  return 8;
}

quadrant asm_multiply(quadrant rack_site, source write_space) {
  place(multiply_sign, write_space, 5);
  place(&rack_site, (write_space + 5), 4);
  return 9;
}

quadrant asm_syscall(source write_space) {
  place(syscall_sign, write_space, 2);
  return 2;
}

quadrant asm_stay_from_rack(directional rack_site, source write_space) {
  place(stay_from_rack_sign, write_space, 3);
  place(&rack_site, (write_space + 3), 4);
  return 7;
}

quadrant asm_store_state(source write_space) {
  place(store_state_sign, write_space, 1);
  return 1;
}

quadrant asm_restore_state(source write_space) {
  place(restore_state_sign, write_space, 1);
  return 1;
}

quadrant asm_to_domain(source write_space) {
  place(to_domain_sign, write_space, 3);
  return 3;
}

quadrant asm_domain_back(source write_space) {
  place(domain_back_sign, write_space, 2);
  return 2;
}

quadrant asm_rsp_at_r8_to_xmm0(source write_space) {
  place(rsp_at_r8_to_xmm0_sign, write_space, 6);
  return 6;
}

quadrant repeat_send_quads(source write_space) {
  place(repeat_send_quads_sign, write_space, 3);
  return 3;
}

quadrant asm_repeat_send_secs(source write_space) {
  place(repeat_send_secs_sign, write_space, 2);
  return 2;
}

quadrant asm_xmm0_to_rsp_at_r8(source write_space) {
  place(xmm0_to_rsp_at_r8_sign, write_space, 6);
  return 6;
}

quadrant asm_naoify(source register_source, quadrant register_distance, source write_space) {
  directional register_site = source_site(naof_clerical_registers, gnu_registers, gnu_registers_distances, register_source, register_distance);
  //printf("pair-site | %ld\n", register_site);
  if(register_site == -1) {
    printf("clerical warn | no sign found for %s in asm-move-registers\n", register_source);
    syscall(unix_exit_group, 0);
  }
  //printf("naof-and-sign-secs | %lu\n", naof_and_sign_secs[register_site]);
  //see_space("sign", and_signs[register_site], naof_and_sign_secs[register_site]);
  place(naoify_signs[register_site], write_space, 3);
  return 3;
}

// rdi | site-of-cast
quadrant asm_rack_to_mm(quadrant mm_site, source write_space) {
  place(rack_to_mm_signs[mm_site], write_space, 5);
  return 5;
}

// rdi | site-of-cast
quadrant asm_mm_to_rack(quadrant mm_site, source write_space) {
  place(mm_to_rack_signs[mm_site], write_space, 5);
  return 5;
}

// rax | precise
// rdx | wide
quadrant asm_naof_thread_sequences(source write_space) {
  place(naof_thread_sequences_sign, write_space, 2);
  return 2;
}

quadrant asm_add_to_stack(quadrant constant_site, quadrant number, source write_space) {
	//printf("constant-site | %lu\n", constant_site);
	//printf("number | %lu\n", number);
  place(add_to_stack_sign, (write_space), 3);
  place(&constant_site, (write_space + 3), 4);
  place(&number, (write_space + 7), 4);
	//see_space("write-space", write_space, 11);
  return 11;
}
