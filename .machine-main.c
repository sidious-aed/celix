#include "./machine.h"

unsigned long main(unsigned long naof_params, unsigned char ** params) {
  // clerical
  sec print_space[1000];
  quadrant print_site;
  source section_name = "asm-motion-stay";
  quadrant section_name_distance = get_distance(section_name);
  replicate('-', print_space, section_name_distance);
  print_space[section_name_distance] = 0;
  printf("%s\n", section_name);
  printf("%s\n", print_space);
  quadrant site = 0;
  while(true) {
    if(site == naof_standard_motion_alus) {
      break;
    }
    print_site = asm_motion_stay(standard_motion_alus[site], standard_motion_alus_distances[site], 0x20202020, print_space);
    see_base16(standard_motion_alus[site], print_space, print_site);
    site += 1;
  }
  print_site = asm_motion_stay_from("je", 2, 0x2020, 0x1020, print_space);
  see_base16("je", print_space, print_site);
  print_site = asm_clerical_motion_stay_from("always", 6, 0x2020, 0x1020, print_space);
  see_base16("always", print_space, print_site);
  printf("\n");

  section_name = "asm-set-conditional";
  section_name_distance = get_distance(section_name);
  replicate('-', print_space, section_name_distance);
  print_space[section_name_distance] = 0;
  printf("%s\n", section_name);
  printf("%s\n", print_space);
  site = 0;
  while(true) {
    if(site == naof_set_conditionals) {
      break;
    }
    print_site = asm_set_conditional(set_conditionals[site], set_conditional_distances[site], 0x20202020, print_space);
    see_base16(standard_motion_alus[site], print_space, print_site);
    site += 1;
  }
  printf("\n");

  section_name = "asm-register-to-rack";
  section_name_distance = get_distance(section_name);
  replicate('-', print_space, section_name_distance);
  print_space[section_name_distance] = 0;
  printf("%s\n", section_name);
  printf("%s\n", print_space);
  site = 0;
  while(true) {
    if(site == naof_general_registers) {
      break;
    }
    print_site = asm_register_to_rack(gnu_registers[site], gnu_registers_distances[site], print_space);
    see_base16(gnu_registers[site], print_space, print_site);
    site += 1;
  }
  printf("\n");

  section_name = "asm-rack-to-register";
  section_name_distance = get_distance(section_name);
  replicate('-', print_space, section_name_distance);
  print_space[section_name_distance] = 0;
  printf("%s\n", section_name);
  printf("%s\n", print_space);
  site = 0;
  while(true) {
    if(site == naof_general_registers) {
      break;
    }
    print_site = asm_rack_to_register(gnu_registers[site], gnu_registers_distances[site], print_space);
    see_base16(gnu_registers[site], print_space, print_site);
    site += 1;
  }
  printf("\n");

  section_name = "asm-leeve-registers";
  section_name_distance = get_distance(section_name);
  replicate('-', print_space, section_name_distance);
  print_space[section_name_distance] = 0;
  printf("%s\n", section_name);
  printf("%s\n", print_space);
  site = 0;
  while(true) {
    if(site == naof_register_pairs) {
      break;
    }
    print_site = asm_leeve_registers(register_pairs[site], register_pairs_distances[site], 0x20202020, print_space);
    see_base16(register_pairs[site], print_space, print_site);
    site += 1;
  }
  printf("\n");

  section_name = "asm-move-registers";
  section_name_distance = get_distance(section_name);
  replicate('-', print_space, section_name_distance);
  print_space[section_name_distance] = 0;
  printf("%s\n", section_name);
  printf("%s\n", print_space);
  site = 0;
  while(true) {
    if(site == naof_register_pairs) {
      break;
    }
    print_site = asm_move_registers(register_pairs[site], register_pairs_distances[site], 0x20202020, print_space);
    see_base16(register_pairs[site], print_space, print_site);
    site += 1;
  }
  printf("\n");

  section_name = "asm-move-to";
  section_name_distance = get_distance(section_name);
  replicate('-', print_space, section_name_distance);
  print_space[section_name_distance] = 0;
  printf("%s\n", section_name);
  printf("%s\n", print_space);
  site = 0;
  while(true) {
    if(site == naof_to_register_pairs) {
      break;
    }
    print_site = asm_move_to(to_register_pairs[site], to_register_pairs_distances[site], 0x20202020, print_space);
    see_base16(register_pairs[site], print_space, print_site);
    site += 1;
  }
  printf("\n");

  section_name = "asm-move-sec";
  section_name_distance = get_distance(section_name);
  replicate('-', print_space, section_name_distance);
  print_space[section_name_distance] = 0;
  printf("%s\n", section_name);
  printf("%s\n", print_space);
  site = 0;
  while(true) {
    if(site == naof_register_pairs) {
      break;
    }
    print_site = asm_move_sec(register_pairs[site], register_pairs_distances[site], 0x20202020, print_space);
    see_base16(register_pairs[site], print_space, print_site);
    site += 1;
  }
  printf("\n");

  section_name = "asm-move-sec-to";
  section_name_distance = get_distance(section_name);
  replicate('-', print_space, section_name_distance);
  print_space[section_name_distance] = 0;
  printf("%s\n", section_name);
  printf("%s\n", print_space);
  site = 0;
  while(true) {
    if(site == naof_to_register_pairs) {
      break;
    }
    print_site = asm_move_sec_to(to_register_pairs[site], to_register_pairs_distances[site], 0x20202020, print_space);
    see_base16(to_register_pairs[site], print_space, print_site);
    site += 1;
  }
  printf("\n");

  section_name = "asm-add-registers";
  section_name_distance = get_distance(section_name);
  replicate('-', print_space, section_name_distance);
  print_space[section_name_distance] = 0;
  printf("%s\n", section_name);
  printf("%s\n", print_space);
  site = 0;
  while(true) {
    if(site == naof_clerical_register_pairs) {
      break;
    }
    print_site = asm_add_registers(register_pairs[site], register_pairs_distances[site], print_space);
    see_base16(register_pairs[site], print_space, print_site);
    site += 1;
  }
  printf("\n");

  section_name = "asm-sub-registers";
  section_name_distance = get_distance(section_name);
  replicate('-', print_space, section_name_distance);
  print_space[section_name_distance] = 0;
  printf("%s\n", section_name);
  printf("%s\n", print_space);
  site = 0;
  while(true) {
    if(site == naof_clerical_register_pairs) {
      break;
    }
    print_site = asm_sub_registers(register_pairs[site], register_pairs_distances[site], print_space);
    see_base16(register_pairs[site], print_space, print_site);
    site += 1;
  }
  printf("\n");

  section_name = "asm-and-registers";
  section_name_distance = get_distance(section_name);
  replicate('-', print_space, section_name_distance);
  print_space[section_name_distance] = 0;
  printf("%s\n", section_name);
  printf("%s\n", print_space);
  site = 0;
  while(true) {
    if(site == naof_clerical_register_pairs) {
      break;
    }
    print_site = asm_and_registers(register_pairs[site], register_pairs_distances[site], print_space);
    see_base16(register_pairs[site], print_space, print_site);
    site += 1;
  }
  printf("\n");

  section_name = "asm-compair-registers";
  section_name_distance = get_distance(section_name);
  replicate('-', print_space, section_name_distance);
  print_space[section_name_distance] = 0;
  printf("%s\n", section_name);
  printf("%s\n", print_space);
  site = 0;
  while(true) {
    if(site == naof_clerical_register_pairs) {
      break;
    }
    print_site = asm_compair_registers(register_pairs[site], register_pairs_distances[site], print_space);
    see_base16(register_pairs[site], print_space, print_site);
    site += 1;
  }
  printf("\n");

  section_name = "asm-set-register";
  section_name_distance = get_distance(section_name);
  replicate('-', print_space, section_name_distance);
  print_space[section_name_distance] = 0;
  printf("%s\n", section_name);
  printf("%s\n", print_space);
  site = 0;
  while(true) {
    if(site == naof_clerical_registers) {
      break;
    }
    print_site = asm_set_register(gnu_registers[site], gnu_registers_distances[site], 0x2020202020202020, print_space);
    see_base16(gnu_registers[site], print_space, print_site);
    site += 1;
  }
  printf("\n");

  section_name = "asm-add-constant";
  section_name_distance = get_distance(section_name);
  replicate('-', print_space, section_name_distance);
  print_space[section_name_distance] = 0;
  printf("%s\n", section_name);
  printf("%s\n", print_space);
  site = 0;
  while(true) {
    if(site == naof_clerical_registers) {
      break;
    }
    print_site = asm_add_constant(gnu_registers[site], gnu_registers_distances[site], 0x20202020, print_space);
    see_base16(gnu_registers[site], print_space, print_site);
    site += 1;
  }
  printf("\n");

  section_name = "asm-sub-constant";
  section_name_distance = get_distance(section_name);
  replicate('-', print_space, section_name_distance);
  print_space[section_name_distance] = 0;
  printf("%s\n", section_name);
  printf("%s\n", print_space);
  site = 0;
  while(true) {
    if(site == naof_clerical_registers) {
      break;
    }
    print_site = asm_sub_constant(gnu_registers[site], gnu_registers_distances[site], 0x20202020, print_space);
    see_base16(gnu_registers[site], print_space, print_site);
    site += 1;
  }
  printf("\n");

  section_name = "asm-compair-constant";
  section_name_distance = get_distance(section_name);
  replicate('-', print_space, section_name_distance);
  print_space[section_name_distance] = 0;
  printf("%s\n", section_name);
  printf("%s\n", print_space);
  site = 0;
  while(true) {
    if(site == naof_clerical_registers) {
      break;
    }
    print_site = asm_compair_constant(gnu_registers[site], gnu_registers_distances[site], 0x20202020, print_space);
    see_base16(gnu_registers[site], print_space, print_site);
    site += 1;
  }
  printf("\n");

  section_name = "asm-divide";
  section_name_distance = get_distance(section_name);
  replicate('-', print_space, section_name_distance);
  print_space[section_name_distance] = 0;
  printf("%s\n", section_name);
  printf("%s\n", print_space);
  print_site = asm_divide(0x2020, print_space);
  see_base16(gnu_registers[site], print_space, print_site);
  printf("\n");

  section_name = "asm-multiply";
  section_name_distance = get_distance(section_name);
  replicate('-', print_space, section_name_distance);
  print_space[section_name_distance] = 0;
  printf("%s\n", section_name);
  printf("%s\n", print_space);
  print_site = asm_multiply(0x2020, print_space);
  see_base16(gnu_registers[site], print_space, print_site);
  printf("\n");

  section_name = "asm-syscall";
  section_name_distance = get_distance(section_name);
  replicate('-', print_space, section_name_distance);
  print_space[section_name_distance] = 0;
  printf("%s\n", section_name);
  printf("%s\n", print_space);
  print_site = asm_syscall(print_space);
  see_base16("to-rim", print_space, print_site);
  printf("\n");

  section_name = "asm-stay-from-rack";
  section_name_distance = get_distance(section_name);
  replicate('-', print_space, section_name_distance);
  print_space[section_name_distance] = 0;
  printf("%s\n", section_name);
  printf("%s\n", print_space);
  print_site = asm_stay_from_rack(0x20202020, print_space);
  see_base16("stay-from-rack", print_space, print_site);
  printf("\n");

  section_name = "asm-store-state";
  section_name_distance = get_distance(section_name);
  replicate('-', print_space, section_name_distance);
  print_space[section_name_distance] = 0;
  printf("%s\n", section_name);
  printf("%s\n", print_space);
  print_site = asm_store_state(print_space);
  see_base16("store-state", print_space, print_site);
  printf("\n");

  section_name = "asm-restore-state";
  section_name_distance = get_distance(section_name);
  replicate('-', print_space, section_name_distance);
  print_space[section_name_distance] = 0;
  printf("%s\n", section_name);
  printf("%s\n", print_space);
  print_site = asm_restore_state(print_space);
  see_base16("restore-state", print_space, print_site);
  printf("\n");

  section_name = "asm-naoify";
  section_name_distance = get_distance(section_name);
  replicate('-', print_space, section_name_distance);
  print_space[section_name_distance] = 0;
  printf("%s\n", section_name);
  printf("%s\n", print_space);
  site = 0;
  while(true) {
    if(site == naof_clerical_registers) {
      break;
    }
    print_site = asm_naoify(gnu_registers[site], gnu_registers_distances[site], print_space);
    see_base16(gnu_registers[site], print_space, print_site);
    site += 1;
  }
  printf("\n");

  sec b16[100];
  quadrant b16_site;
  section_name = "asm-rack-to-mm";
  section_name_distance = get_distance(section_name);
  replicate('-', print_space, section_name_distance);
  print_space[section_name_distance] = 0;
  printf("%s\n", section_name);
  printf("%s\n", print_space);
  site = 0;
  while(true) {
    if(site == naof_mm_registers) {
      break;
    }
    b16_site = 0;
    print_site = asm_rack_to_mm(site, print_space);
    add_to_entree("mm", 2, b16, &b16_site);
    b16_site += number_to_entree(site, (b16 + b16_site), 16);
    syscall(unix_write, 1, b16, b16_site);
    see_base16("-register", print_space, print_site);
    site += 1;
  }
  printf("\n");

  section_name = "asm-mm-to-rack";
  section_name_distance = get_distance(section_name);
  replicate('-', print_space, section_name_distance);
  print_space[section_name_distance] = 0;
  printf("%s\n", section_name);
  printf("%s\n", print_space);
  site = 0;
  while(true) {
    if(site == naof_mm_registers) {
      break;
    }
    b16_site = 0;
    print_site = asm_mm_to_rack(site, print_space);
    add_to_entree("mm", 2, b16, &b16_site);
    b16_site += number_to_entree(site, (b16 + b16_site), 16);
    syscall(unix_write, 1, b16, b16_site);
    see_base16("-register", print_space, print_site);
    site += 1;
  }
  printf("\n");
  return 0;
}
