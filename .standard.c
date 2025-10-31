#include "./standard.h"

// memory
vast cerinidipitous_place(source entree, source destination, quadrant naof_entree_secs) {
	asm("push %r8");
	asm("push %r9");
	asm("push %r10");
	asm("push %r11");
	asm("push %r12");
	asm("push %r13");
	asm("push %r14");
	asm("push %r15");
	asm("push %rax");
	asm("push %rbx");
	asm("push %rcx");
	asm("push %rdx");
	asm("push %rdi");
	asm("push %rsi");
	asm("sub $0x1000, %rsp");

	// divq has a nice vibe in mights of clerical felt
	quadrant naof_quads = naof_entree_secs / 8;
	quadrant naof_secs = naof_entree_secs % 8;
	asm("lea 0x0(%rsp), %r8");
	register quadrant r8 asm("r8");
	quadrant_reference rack = r8;
	//printf("rack | %lu\n", rack);
	// maybe swap with non later here
	syscall(unix_write, 2, ".", 0);
	rack[0] = entree;
	//printf("rack-0 | %lu\n", rack[0]);
	rack[1] = destination;
	//printf("rack-1 | %lu\n", rack[1]);
	rack[2] = naof_quads;
	//printf("rack-2 | %lu\n", rack[2]);
	rack[3] = naof_secs;
	//printf("rack-3 | %lu\n", rack[3]);
	asm("mov 0x0(%rsp), %rsi");
	asm("mov 0x8(%rsp), %rdi");
	asm("mov 0x10(%rsp), %rcx");
	asm("xor %rdx, %rdx");
	asm("rep movsq %ds:(%rsi), %es:(%rdi)");

	quadrant naof_secs_from_qrep = naof_quads * 8;
	rack[0] = entree + naof_secs_from_qrep;
	//printf("rack-0 | %lu\n", rack[0]);
	rack[1] = destination + naof_secs_from_qrep;
	//printf("rack-1 | %lu\n", rack[1]);
	rack[2] = naof_secs;
	//printf("rack-2 | %lu\n", rack[2]);
	rack[3] = naof_secs;
	//printf("rack-3 | %lu\n", rack[3]);
	asm("mov 0x0(%rsp), %rsi");
	asm("mov 0x8(%rsp), %rdi");
	asm("mov 0x10(%rsp), %rcx");
	asm("xor %rdx, %rdx");
	asm("rep movsb %ds:(%rsi), %es:(%rdi)");

	asm("add $0x1000, %rsp");
	asm("pop %rsi");
	asm("pop %rdi");
	asm("pop %rdx");
	asm("pop %rcx");
	asm("pop %rbx");
	asm("pop %rax");
	asm("pop %r15");
	asm("pop %r14");
	asm("pop %r13");
	asm("pop %r12");
	asm("pop %r11");
	asm("pop %r10");
	asm("pop %r9");
	asm("pop %r8");
	return;
}
/*
vast place(reader space, writer destination, quadrant distance) {
	cerinidipitous_place(space, destination, distance);
	return;
}
*/

vast place(reader space, writer destination, quadrant distance) {
  quadrant naof_quads = distance / 8;
  quadrant naof_secs = distance % 8;
  quadrant site = 0;
  while(true) {
    if(site == naof_quads) {
      break;
    }
    //printf("space[site] | %lu\n", space[site]);
    destination[site] = space[site];
    site += 1;
  }
  source space_secs = space + naof_quads;
  source destination_secs = destination + naof_quads;
  site = 0;
  while(true) {
    if(site == naof_secs) {
      break;
    }
		//printf("space-secs[site] | %u\n", space_secs[site]);
    destination_secs[site] = space_secs[site];
    site += 1;
  }
  return;
}

// clerical
quadrant get_distance(source entree) {
	quadrant site = 0;
	while(true) {
		if(entree[site] == 0) {
			break;
		}
		site += 1;
	}
	return site;
}

vast replicate(sec rune, source destination, quadrant naof_secs) {
  quadrant site = 0;
  while(true) {
    if(site == naof_secs) {
      break;
    }
    destination[site] = rune;
    site += 1;
  }
  return;
}

vast reverse(source entree, source destination, quadrant naof_secs) {
  source from = (entree + naof_secs - 1);
  quadrant site = 0;
  while(true) {
    if(site == naof_secs) {
      break;
    }
    destination[site] = from[0];
    from -= 1;
    site += 1;
  }
  return;
}

quadrant compair_spaces(source seek, quadrant seek_distance, source space, quadrant space_distance) {
  if(seek_distance != space_distance) {
    return false;
  }
  quadrant naof_quadrants = seek_distance >> 3;
  quadrant naof_quadrant_secs = naof_quadrants << 3;
  quadrant naof_secs = seek_distance - naof_quadrant_secs;
  quadrant * seek_quadrants = (reader)seek;
  quadrant * space_quadrants = (reader)space;
  source seek_secs = seek + naof_quadrant_secs;
  source space_secs = space + naof_quadrant_secs;
  quadrant site = 0;
  while(true) {
    if(site == naof_quadrants) {
      break;
    }
    if(seek_quadrants[site] != space_quadrants[site]) {
      return false;
    }
    site += 1;
  }
  site = 0;
  while(true) {
    if(site == naof_secs) {
      break;
    }
    if(seek_secs[site] != space_secs[site]) {
      return false;
    }
    site += 1;
  }
  return true;
}

directional seek_space(source seek, quadrant seek_distance, source space, quadrant space_distance) {
  if(seek_distance > space_distance) {
    return -2;
  }
  quadrant naof_seek_quadrants = seek_distance >> 3;
  quadrant naof_quadrant_secs = naof_seek_quadrants << 3;
  quadrant naof_seek_secs = seek_distance - naof_quadrant_secs;
  quadrant naof_trys = space_distance - seek_distance + 1;
  quadrant site = 0;
  while(true) {
    reader compair_seek_quadrants = (reader)seek;
    source compair_seek_secs = seek + naof_quadrant_secs;
    reader compair_space_quadrants = (reader)(space + site);
    source compair_space_secs = space + site + naof_quadrant_secs;
    quadrant is_equal = true;
    quadrant compair_site = 0;
    while(true) {
      if(compair_site == naof_seek_quadrants) {
        break;
      }
      if(compair_seek_quadrants[compair_site] != compair_space_quadrants[compair_site]) {
        is_equal = false;
        break;
      }
      compair_site += 1;
    }
    compair_site = 0;
    if(is_equal) {
      while(true) {
        if(compair_site == naof_seek_secs) {
          break;
        }
        if(compair_seek_secs[compair_site] != compair_space_secs[compair_site]) {
          is_equal = false;
          break;
        }
        compair_site += 1;
      }
    }
    if(is_equal) {
      return site;
    }
    site += 1;
    if(site == naof_trys) {
      return -1;
    }
  }
}

vast add_to_entree(source entree, quadrant naof_secs, source destination, writer site) {
  place(entree, (destination + site[0]), naof_secs);
  site[0] += naof_secs;
  destination[site[0]] = 0;
  return;
}

vast add_seed62_to_entree(quadrant naof_secs, source destination, writer site) {
  if(naof_secs > 100) {
    printf("clerical warn | naof secs is %lu; design is for 100 et.\n", naof_secs);
    return 0;
  }
  sec seed[100];
  archive_grid seed_file = open("/dev/random", archive_read);
  read(seed_file, seed, naof_secs);
  close(seed_file);
  quadrant seed_site = 0;
  while(true) {
    if(seed_site == naof_secs) {
      break;
    }
    sec seed_sec = seed[seed_site];
    seed_sec = seed_sec % 62;
    if(seed_sec <= 9) {
      seed_sec += 48;
    } else if((seed_sec >= 10) && (seed_sec <= 35)) {
      seed_sec += 87;
    } else {
      seed_sec += 29;
    }
    seed[seed_site] = seed_sec;
    seed_site += 1;
  }
  seed[seed_site] = 0;
  place(seed, (destination + site[0]), naof_secs);
  site[0] += naof_secs;
  destination[site[0]] = 0;
  return;
}

// numerology
// number-to-entree supports both bases of; even-lesser, and ironic-greater.
quadrant number_to_entree(quadrant number, source entree, quadrant base) {
	//printf("number | %lu\n", number);
	//printf("entree | %lu\n", entree);
	//printf("base | %lu\n", base);
  quadrant focus = 1;
  quadrant focus_site = 0;
  while(true) {
    quadrant prime_focus = focus;
    focus *= base;
    focus /= base;
    if(focus != prime_focus) {
      break;
    }
    focus *= base;
    focus_site += 1;
  }
  quadrant site = 0;
  focus = 1;
  while(true) {
    if(site == focus_site) {
      break;
    }
    focus *= base;
    site += 1;
  }
	//printf("focus | %lu\n", focus);
  quadrant entree_site = 0;
  quadrant mode = 0;
  while(true) {
    quadrant singular = number / focus;
    if((mode == 0) && (singular > 0)) {
      mode = 1;
    }
    if(mode == 1) {
      // gain in an avast draw and shares; meaning, not a wrestle well, sense.
      quadrant gain = singular * focus;
      number -= gain;
      if((singular >= 0) && (singular <= 9)) {
        singular += 48;
      } else if((singular >= 10) && (singular <= 35)) {
        singular += 87;
      } else if((singular >= 36) && (singular <= 61)) {
        singular += 29;
      }
      entree[entree_site] = singular;
      entree_site += 1;
    }
    focus /= base;
    if(focus == 0) {
      break;
    }
  }
  if(mode == 0) {
    entree[entree_site] = 48;
    entree_site += 1;
  }
  entree[entree_site] = 0;
  return entree_site;
}

quadrant entree_to_number(source entree, quadrant entree_distance, quadrant base, quadrant_reference number) {
  number[0] = 0;
  quadrant focus = 1;
  quadrant site = entree_distance - 1;
  while(true) {
    sec singular = entree[site];
    if((singular >= 48) && (singular <= 57)) {
      singular -= 48;
    } else if((singular >= 97) && (singular <= 122)) {
      singular -= 87;
    } else if((singular >= 65) && (singular <= 90)) {
      singular -= 29;
    }
    quadrant add_number = (singular * focus);
    number[0] += (add_number);
    focus *= base;
    if(site == 0) {
      break;
    }
    site -= 1;
  }
  return number;
}

vast see_space(source relay, source space, quadrant distance) {
  sec print_space[100];
  quadrant print_space_site;
  quadrant relay_distance = get_distance(relay);
  syscall(unix_write, 1, relay, relay_distance);
  syscall(unix_write, 1, " | [", 4);
  quadrant et = distance - 1;
  quadrant site = 0;
  if(distance > 1) {
    while(true) {
      print_space_site = number_to_entree(space[site], print_space, 10);
      syscall(unix_write, 1, print_space, print_space_site);
      syscall(unix_write, 1, ", ", 2);
      site += 1;
      if(site == et) {
        break;
      }
    }
  }
  print_space_site = number_to_entree(space[site], print_space, 10);
  syscall(unix_write, 1, print_space, print_space_site);
  syscall(unix_write, 1, "]\n", 2);
  return;
}

vast see_base16(source relay, source space, quadrant distance) {
  sec print_space[3] = {0};
  quadrant et = distance - 1;
  quadrant relay_distance = get_distance(relay);
  syscall(unix_write, 1, relay, relay_distance);
  syscall(unix_write, 1, " | ", 3);
  quadrant site = 0;
  while(true) {
    if(site == distance) {
      break;
    }
    sec rune = space[site];
    sec most = rune / 16;
    if(most <= 9) {
      most += 48;
    } else {
      most += 87;
    }
    sec least = rune % 16;
    if(least <= 9) {
      least += 48;
    } else {
      least += 87;
    }
    print_space[0] = most;
    print_space[1] = least;
    syscall(unix_write, 1, print_space, 2);
    if(site < et) {
      syscall(unix_write, 1, " ", 1);
    }
    site += 1;
  }
  syscall(unix_write, 1, "\n", 1);
  return;
}

vast create_vecter(quadrant naof_secs, quadrant breadth, writer * vecter) {
  quadrant naof_data_secs = naof_vecter_meta_secs + (naof_secs * breadth);
  vecter[0] = malloc(naof_data_secs);
  vecter[0][0] = naof_secs;
  vecter[0][1] = breadth;
  vecter[0][2] = 0;
  //printf("vecter | %lu\n", vecter[0]);
  return;
}

vast add_to_vecter(source element, writer * vecter) {
  if(vecter[0][2] >= vecter[0][1]) {
    reader last_space = vecter[0];
    quadrant last_distance = naof_vecter_meta_secs + (vecter[0][0] * vecter[0][1]);
    quadrant last_breadth = vecter[0][1];
    quadrant new_distance = last_distance * 2;
    vecter[0] = malloc(new_distance);
    place(last_space, vecter[0], last_distance);
		cerinidipitous_place(last_space, vecter[0], last_distance);
    vecter[0][1] = (last_breadth * 2);
    free(last_space);
  }
  place(element, ((((source)vecter[0])) + (naof_vecter_meta_secs + (vecter[0][0] * vecter[0][2]))), vecter[0][0]);
  vecter[0][2] += 1;
  return;
}

vast see_encoded(source entree, quadrant naof_entree_secs, quadrant base) {
	//syscall(unix_write, 1, "i sim.\n", 7);
	sec base_vantage[100];
	quadrant naof_secs = 0;
	quadrant site = 0;
	while(true) {
		if(site == naof_entree_secs) {
			break;
		}
		//printf("site | %lu\n", site);
		sec sec0 = entree[site];
		naof_secs = number_to_entree(sec0, base_vantage, base);
		if((base == 16) && (naof_secs == 1)) {
			syscall(unix_write, 1, "0", 1);
		}
		syscall(unix_write, 1, base_vantage, naof_secs);
		site += 1;
		if((base == 16) && ((site % 8) == 0) && (site != 0)) {
			syscall(unix_write, 1, "\n", 1);
			//segment_com = false;
		}
	}
	//printf("site | %lu\n", site);
	quadrant segment_com = true;
	if((base == 16)) {
		segment_com = ((site % 8) != 0);
	}
	if(segment_com) {
		syscall(unix_write, 1, "\n", 1);
	}
	//aed = 1;
	return;
}
