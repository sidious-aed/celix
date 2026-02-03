#include "./standard.h"

// low-clerk
vast wide_com(source init, source com, quad naof_com_secs) {
	//printf("in wide place.\n");
	asm("sub $0x1000, %rsp");
	asm("lea 0x0(%rsp), %r8");
	register quad r8 asm("r8");
	writer rack = r8;
	rack[0] = init;
	rack[1] = com;
	quad naof_quads = naof_com_secs / 8;
	//printf("naof-quads | %lu\n", naof_quads);
	rack[2] = naof_quads;
	quad naof_quad_secs = (naof_quads * 8);
	quad naof_secs = naof_com_secs - naof_quad_secs;
	//printf("naof-secs | %lu\n", naof_secs);
	rack[3] = naof_secs;
	//printf("sending quads.\n");
	asm("mov 0x0(%rsp), %rsi");

	asm("mov 0x8(%rsp), %rdi");
	asm("mov 0x10(%rsp), %rcx");
	asm("rep movsq %ds:(%rsi), %es:(%rdi)");
	//printf("at com of quads-com\n");
	quad init_secs_con = (init + naof_quad_secs);
	rack[0] = init_secs_con;
	//printf("init-secs-con | %lu\n", init_secs_con);
	quad com_secs_con = (com + naof_quad_secs);
	rack[1] = com_secs_con;
	//printf("con-secs-con | %lu\n", com_secs_con);
	asm("mov 0x0(%rsp), %rsi");
	asm("mov 0x8(%rsp), %rdi");
	asm("mov 0x18(%rsp), %rcx");
	asm("rep movsb %ds:(%rsi), %es:(%rdi)");
	asm("add $0x1000, %rsp");
	//printf("at com of wide place.\n");

	/*
	register quad rsi asm("rsi");
	quad stack_number = rsi;
	printf("stack-number | %lu\n", rsi);
	*/
	return;
}

quadrant get_naof_secs(source entree) {
	quadrant site = 0;
	while(true) {
		if(entree[site] == 0) {
			break;
		}
		site += 1;
	}
	return site;
}

quadrant replicate(sec rune, source destination, quadrant naof_secs) {
  quadrant site = 0;
  while(true) {
    if(site == naof_secs) {
      break;
    }
    destination[site] = rune;
    site += 1;
  }
  return naof_secs;
}

// stave all spaces.
quadrant strip(source entree, source destination, quadrant naof_secs) {
	quadrant destination_site = 0;
	quadrant site = 0;
	while(true) {
		if(site == naof_secs) {
			break;
		}
		sec rune = entree[site];
		if(rune != ' ') {
			destination[destination_site] = rune;
			destination_site += 1;
		}
		site += 1;
	}
	return destination_site;
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

// some natural is an old say.
vast place(reader space, writer destination, quadrant distance) {
	//printf("entree | %s\n", space);
	//printf("destination-first-quad | %lu\n", destination[0]);
	//printf("distance | %lu\n", distance);
  quadrant naof_quads = distance / 8;
	//printf("naof-quads | %lu\n", naof_quads);
  quadrant naof_secs = distance % 8;
	//printf("naof-secs | %lu\n", naof_secs);
  quadrant site = 0;
  while(true) {
    if(site == naof_quads) {
      break;
    }
		//printf("site | %lu\n", site);
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
		//printf("site | %lu\n", site);
		//printf("space-secs[site] | %u\n", space_secs[site]);
    destination_secs[site] = space_secs[site];
    site += 1;
  }
  return;
}

// numerology
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

quadrant presice_to_entree(quadrant height, quadrant bar, quadrant base, source entree) {
	//printf("\n");
	//printf("init-height | %lu\n", height);
	//printf("init-bar | %lu\n", bar);
	//printf("init-base | %lu\n", base);
	quadrant number = height / bar;
	//printf("number | %lu\n", number);
	quadrant naof_secs = number_to_entree(number, entree, base);
	height -= (number * bar);
	//printf("data-com-height | %lu\n", height);
	if(height > 0) {
		entree[naof_secs] = '.';
		naof_secs += 1;
		quadrant naof_presice_secs = 0;
		while(true) {
			sec digit;
			while(true) {
				//printf("----------\n");
				height *= base;
				//printf("height | %lu\n", height);
				digit = height / bar;
				//printf("digit | %lu\n", digit);
				if(digit != 0) {
					break;
				}
				entree[naof_secs] = '0';
				naof_secs += 1;
				naof_presice_secs += 1;
				if(naof_presice_secs == clerk_presision) {
					break;
				}
			}
			if(naof_presice_secs == clerk_presision) {
				break;
			}
			//printf("digit | %lu\n", digit);
			//printf("base | %lu\n", base);
			//printf("height | %lu\n", height);
			height -= (digit * bar);
			naof_secs += number_to_entree(digit, (entree + naof_secs), base);
			naof_presice_secs += 1;
			if(height == 0 || naof_presice_secs == clerk_presision) {
				break;
			}
		}
	}
	return naof_secs;
}

quadrant entree_to_number(source entree, quadrant entree_distance, quadrant base, quadrant_reference number) {
	//printf("entree | %s\n", entree);
	//printf("entree-distance | %lu\n", entree_distance);
	quadrant stack_base = base;
  number[0] = 0;
  quadrant focus = 1;
	if(entree_distance > 0) {
		quadrant site = entree_distance - 1;
		while(true) {
			sec singular = entree[site];
			//printf("rune | %c\n", singular);
			if((singular >= 48) && (singular <= 57)) {
				singular -= 48;
			} else if((singular >= 97) && (singular <= 122)) {
				singular -= 87;
			} else if((singular >= 65) && (singular <= 90)) {
				singular -= 29;
			}
			//printf("singular | %u\n", singular);
			//printf("focus | %lu\n", focus);
			quadrant add_number = (singular * focus);
			//printf("add-number | %lu\n", add_number);
			number[0] += (add_number);
			focus = focus * base;
			if(site == 0) {
				break;
			}
			site -= 1;
		}
	}
	//printf("entree-to-number-com-base | %lu\n", base);
  return number;
}

quadrant number_aof(source space, quadrant naof_secs) {
	quadrant base = 1;
	quadrant number = 0;
	quadrant site = 0;
	while(true) {
		if(site == naof_secs) {
			break;
		}
		sec quad_sec = space[site];
		//printf("quad-sec | %lu\n", quad_sec);
		number += (quad_sec * base);
		//printf("number | %lu\n", number);
		base *= 256;
		site += 1;
	}
	return number;
}

// clerical
quadrant compair_spaces(source seek, quadrant seek_distance, source space, quadrant space_distance) {
  if(seek_distance != space_distance) {
    return false;
  }
  quadrant naof_quadrants = seek_distance >> 3;
	//printf("naof-quadrants | %lu\n", naof_quadrants);
  quadrant naof_quadrant_secs = naof_quadrants << 3;
  quadrant naof_secs = seek_distance - naof_quadrant_secs;
	//printf("naof-secs | %lu\n", naof_secs);
  quadrant * seek_quadrants = (reader)seek;
  quadrant * space_quadrants = (reader)space;
  source seek_secs = seek + naof_quadrant_secs;
  source space_secs = space + naof_quadrant_secs;
  quadrant site = 0;
  while(true) {
    if(site == naof_quadrants) {
      break;
    }
		//printf("quad-site | %lu\n", site);
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
		//printf("comp | %u | %u\n", seek_secs[site], space_secs[site]);
		//printf("sec-site | %lu\n", site);
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
				//printf("comp | %c | %c\n", compair_seek_secs[compair_site], compair_space_secs[compair_site]);
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
  wide_com(entree, (destination + site[0]), naof_secs);
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
  wide_com(seed, (destination + site[0]), naof_secs);
  site[0] += naof_secs;
  destination[site[0]] = 0;
  return;
}

quadrant get_time_name(source time_name) {
	quadrant times[2];
	times[0] = 0;
	times[1] = 0;
	quadrant zones[2];
	syscall(unix_gettimeofday, times, zones);
	sec base[100];
	quadrant naof_base_secs = number_to_entree(times[0], base, 16);
	quadrant time_name_site = 0;
	add_to_entree(base, naof_base_secs, time_name, &time_name_site);
	add_to_entree(".", 0x1, time_name, &time_name_site);
	naof_base_secs = number_to_entree(times[1], base, 16);
	add_to_entree(base, naof_base_secs, time_name, &time_name_site);
	add_to_entree(".nonce", 0x6, time_name, &time_name_site);
	return time_name_site;
}

quadrant standardise_entree(source entree, source destination) {
	quadrant naof_secs = get_naof_secs(entree);
	quadrant dsite = 0;
	quadrant site = 0;
	while(true) {
		if(site >= naof_secs) {
			break;
		}
		sec rune = entree[site];
		//printf("rune | %c\n", rune);
		site += 1;
		if(rune == '\\') {
			sec nrune = entree[site];
			site += 1;
			if(nrune == 'n') {
				destination[dsite] = '\n';
			} else if (nrune == 't') {
				destination[dsite] = '\t';
			} else if (nrune == '\\') {
				destination[dsite] = '\\';
			}
		} else {
			destination[dsite] = rune;
		}
		//printf("drune | %c\n", destination[dsite]);
		dsite += 1;
	}
}

// clerical views
vast see_quad(source relay, quad number, quad base) {
	quad naof_relay_secs = get_naof_secs(relay);
	sec entree[10000];
	quadrant entree_site = 0;
	add_to_entree(relay, naof_relay_secs, entree, &entree_site);
	entree_site += number_to_entree(number, (entree + entree_site), base);
	add_to_entree("\n", 1, entree, &entree_site);
	syscall(unix_write, 1, entree, entree_site);
	return;
}

vast see_space(source relay, source space, quadrant distance) {
  sec print_space[100];
  quadrant print_space_site;
  quadrant relay_distance = get_naof_secs(relay);
  syscall(unix_write, 1, relay, relay_distance);
  syscall(unix_write, 1, " | [", 4);
  if(distance > 0) {
		quadrant site = 0;
		if(distance > 1) {
			quadrant et = distance - 1;
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
  }
  syscall(unix_write, 1, "]\n", 2);
  return;
}

vast see_base16(source relay, source space, quadrant distance) {
  sec print_space[3] = {0};
  quadrant et = distance - 1;
  quadrant relay_distance = get_naof_secs(relay);
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
		if(base == 16) {
			if(((site % 8) == 0) && (site != 0)) {
				syscall(unix_write, 1, "\n", 1);
				//segment_com = false;
			} else {
				syscall(unix_write, 1, " ", 1);
			}
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

// ([clerk] || (clerkess)) | memory
// simpler and non quark impeded in regards to stack resign from gcc.
source get_grid_secs(writer grid, quadrant naof_secs, writer tab) {
	naof_secs += 1;
	//printf("in get-get-secs.\n");
	quadrant stack_grid;
	writer qgrid;
	quadrant is_new = false;
	if(grid[0] == 0) {
		//printf("creating new grid.\n");
		//printf("naof-igrid-secs | %lu\n", naof_igrid_secs);
		stack_grid = syscall(unix_mmap, non, naof_igrid_secs, map_rws, map_anon|map_console, non, 0);
		//getc(stdin);
		//perror("mmap");
		//printf("stack-grid | %lu\n", stack_grid);
		//printf("stack-grid | %lu\n", stack_grid);
		//perror("mmap");
		grid[0] = stack_grid;
		is_new = true;
	} else {
		stack_grid = grid[0];
	}
	qgrid = stack_grid;
	if(is_new) {
		qgrid[0] = naof_igrid_secs;
		qgrid[1] = 0;
	}
	//printf("stack-grid | %lu\n", stack_grid);
	//getc(stdin);
	//printf("naof-grid-secs | %lu\n", qgrid[0]);
	//printf("grid-site | %lu\n", qgrid[1]);
	quad grid_com_site = qgrid[1] + naof_secs;
	//printf("grid-com-site | %lu\n", grid_com_site);
	if(grid_com_site >= qgrid[0]) {
		//printf("expanding grid\n");
		quadrant naof_new_secs = naof_secs + (qgrid[0] * 2);
		stack_grid = syscall(unix_mmap, non, naof_new_secs, map_rws, map_anon|map_console, non, 0);
		//printf("stack-grid | %lu\n", stack_grid);
		//getc(stdin);
		grid[0] = stack_grid;
		qgrid = stack_grid;
		qgrid[0] = naof_new_secs;
		qgrid[1] = 0;
	}
	source grid_con = get_grid_console(qgrid); // es always mean-(t)
	//printf("grid-com | %lu\n", grid_con);
	tab[0] = grid_con;
	qgrid[1] += naof_secs;
	//printf("at com of get grid secs.\n");
  return;
}

vast create_vecter(writer grid, quadrant naof_secs, quadrant breadth, writer * vecter) {
  quadrant naof_data_secs = naof_vecter_meta_secs + (naof_secs * breadth);
	writer qgrid = 0;
	get_grid_secs(grid, naof_data_secs, &qgrid);
  vecter[0] = qgrid;
  qgrid[0] = naof_secs;
  qgrid[1] = breadth;
  qgrid[2] = 0;
  //printf("vecter | %lu\n", vecter[0]);
  return;
}

vast add_to_vecter(writer grid, source element, writer * vecter) {
	//printf("in add to vecter.\n");
	//printf("grid | %lu\n", grid[0]);
	writer qvec = vecter[0];
	//printf("naof-capacity | %lu\n", qvec[1]);
	//printf("naof-elements | %lu\n", qvec[2]);
	//printf("element | %lu\n", element);
  if(qvec[2] == qvec[1]) {
		//printf("expanding vecter.\n");
    reader last_qvec = qvec;
		//printf("last-qvec | %lu\n", last_qvec);
    quadrant last_naof_secs = naof_vecter_meta_secs + (qvec[0] * qvec[1]);
		//printf("last-naof-secs | %lu\n", last_naof_secs);
    quadrant last_breadth = qvec[1];
		qvec[1] *= 2;
    quadrant new_naof_secs = naof_vecter_meta_secs + (qvec[0] * qvec[1]);
		//printf("naof-new-secs | %lu\n", new_naof_secs);
		quadrant new_qvec = 0;
		get_grid_secs(grid, new_naof_secs, &new_qvec);
		qvec = new_qvec;
		//printf("new-qvec | %lu\n", qvec);
		//getc(stdin);
		vecter[0] = qvec;
    wide_com(last_qvec, qvec, last_naof_secs);
  }
	//printf("qvec | %lu\n", qvec);
	source vecter_com = get_vecter_site(qvec);
	//printf("vecter-com | %lu\n", vecter_com);
  wide_com(element, get_vecter_site(qvec), qvec[0]);
  qvec[2] += 1;
	source new_vecter_com = get_vecter_site(qvec);
	//printf("new-vecter-com | %lu\n", vecter_com);
	//printf("vecter-com-distances | %lu\n", (new_vecter_com - vecter_com));
	//printf("naof-capacity | %lu\n", qvec[1]);
	//printf("naof-elements | %lu\n", qvec[2]);
  return;
}

vast add_string_to_sec_vecter(writer grid, source string, quadrant naof_string_secs, writer * vecter) {
	quadrant string_site = vecter[0][2];
	quadrant naof_com_secs = (naof_string_secs + 1);
	quadrant com_string_site = (string_site + naof_com_secs);
	quadrant capacity = vecter[0][1];
  if(com_string_site > capacity) {
		//printf("expanding string.\n");
		//printf("string | %s\n", (vecter[0] + 3));
    reader last_space = vecter[0];
		//printf("last-space | %lu\n", last_space);
		quadrant new_capacity = (capacity * 2) + naof_com_secs;
    quadrant new_distance = naof_vecter_meta_secs + (new_capacity);
		writer stack_vecter = vecter[0];
		//printf("stack-vecter | %lu\n", stack_vecter);
		get_grid_secs(grid, new_distance, &stack_vecter);
		//printf("stack-vecter | %lu\n", stack_vecter);
		//printf("last-space | %lu\n", last_space);
    wide_com(last_space, stack_vecter, (naof_vecter_meta_secs + vecter[0][2]));
		vecter[0] = stack_vecter;
    vecter[0][1] = (new_capacity);
		//see_space("meta", vecter[0], 0x18);
		//printf("string | %s\n", (vecter[0] + 3));
  }
	writer qvec = vecter[0];
	source vec_con = get_vecter_site(qvec);
	//printf("((((source)vecter[0])) | %lu\n", (((source)vecter[0])));
  wide_com(string, vec_con, naof_string_secs);
  vecter[0][2] += naof_string_secs;
	//printf("string | %s\n", (vecter[0] + 3));
  return;
}

vast add_file_string_to_sec_vecter(writer grid, source file_name, quad site, quad naof_string_secs, writer * vecter) {
	sec read_space[10000];
	ip_file file = syscall(unix_open, file_name, archive_read);
	printf("file | %lu\n", file);
	if(file == code_a) {
		syscall(unix_write, "<--> | add-file-string-to-sec-vecter file not found.\n", 0x35);
		return;
	}
	quad naof_file_secs = syscall(unix_lseek, file, 0, seek_completion);
	syscall(unix_lseek, file, site, seek_origin);
	//quad stack_grid = syscall(unix_mmap, non, naof_file_secs, map_read, 0x2, file, 0);
	//see_quad("stack-grid | ", stack_grid, 16);
	//add_string_to_sec_vecter(grid, (stack_grid + site), naof_string_secs, vecter);
	//syscall(unix_munmap, stack_grid, naof_file_secs);
	quad rsite = 0;
	while(true) {
		if(rsite == naof_string_secs) {
			break;
		}
		quad naof_read_secs = naof_string_secs;
		if(naof_read_secs > 10000) {
			naof_read_secs = 10000;
		}
		naof_read_secs = syscall(unix_read, file, read_space, naof_read_secs);
		if(naof_read_secs == 0) {
			break;
		}
		add_string_to_sec_vecter(grid, (read_space), naof_read_secs, vecter);
		rsite += naof_read_secs;
	}
	return;
}

vast see_string(writer vec) {
	syscall(unix_write, 1, get_vecter_grid(vec), vec[2]);
	return;
}

// auxillery extras
vast noom_nodes(writer grid, source entree, quadrant naof_secs, writer nodes) {
	create_vecter(grid, 0x18, 100, nodes);
	sec section[1000];
	quadrant section_site = 0;
	quadrant noom_site = 0;
	quadrant site = 0;
	while(true) {
		sec rune = entree[site];
		//printf("rune | %c\n", rune);
		quadrant is_noom_com = false;
		quadrant is_com = false;
		if(rune == '(') {
			is_noom_com = true;
		} else if(rune == ')') {
			is_noom_com = true;
		} else {
			section[section_site] = rune;
			section_site += 1;
		}
		site += 1;
		if(site == naof_secs) {
			is_com = true;
			if(section_site > 0) {
				is_noom_com = true;
			}
		}
		if(is_noom_com && (section_site > 0)) {
			source section_entree = 0;
			get_grid_secs(grid, (section_site + 1), &section_entree);
			wide_com(section, section_entree, section_site);
			//printf("noom-site | %lu\n", noom_site);
			//printf("section-entree | %s\n", section_entree);
			//printf("section-site | %lu\n", section_site);
			quadrant record[3];
			record[0] = noom_site;
			record[1] = section_entree;
			record[2] = section_site;
			add_to_vecter(&grid, record, nodes);
			section_site = 0;
		}
		if(rune == '(') {
			noom_site += 1;
		} else if(rune == ')') {
			noom_site -= 1;
		}
		//if(section_site > 0) {
			//syscall(unix_write, 1, section, section_site);
			//syscall(unix_write, 1, "\n", 1);
		//}
		//printf("noom-site | %lu\n", noom_site);
		//printf("\n");
		if(is_com) {
			break;
		}
	}
}

vast statemint(source statemint, quadrant naof_secs, quadrant base, directional * number) {
	quadrant non_code = 0x8000000000000000;
	number[0] = 0;
	//printf("statemint | %s\n", statemint);
	//printf("naof-secs | %lu\n", naof_secs);
	sec number_entree[1000];
	quadrant number_entree_site = 0;
	quadrant site = 0;
	quadrant mode = 0;
	while(true) {
		sec rune = 0;
		quadrant is_number_com = false;
		quadrant is_com = false;
		if(site == naof_secs) {
			if(number_entree_site > 0) {
				is_number_com = true;
			}
			is_com = true;
		}
		//printf("is-com | %lu\n", is_com);
		if(is_com == false) {
			rune = statemint[site];
			//printf("rune | %c\n", rune);
			if((rune == '+') || (rune == '-') || (rune == '*') || (rune == '/')) {
				is_number_com = true;
			} else {
				number_entree[number_entree_site] = rune;
				number_entree_site += 1;
			}
			number_entree[number_entree_site] = 0;
		}
		site += 1;
		if(is_number_com) {
			//printf("com-number\n");
			//printf("number before arithmatic | %lu\n", number);
			//syscall(unix_write, 1, number_entree, number_entree_site);
			//syscall(unix_write, 1, "\n", 1);
			//printf("number-entree | |%s|\n", number_entree);
			//printf("number-entree-site | %lu\n", number_entree_site);
			quadrant com_number = 0;
			entree_to_number(number_entree, number_entree_site, base, &com_number);
			//printf("com-number | %lu\n", com_number);
			//printf("mode | %lu\n", mode);
			number_entree_site = 0;
			if(mode == 0) {
				number[0] += com_number;
			} else if(mode == 1) {
				number[0] -= com_number;
			} else if(mode == 2) {
				number[0] *= com_number;
			} else if(mode == 3) {
				number[0] /= com_number;
			}
			//printf("number after arithmatic | %lu\n", number[0]);
			//printf("rune | %c\n", rune);
		}
		if(is_com) {
			break;
		}
		if(is_number_com) {
			if(site != naof_secs) {
				if(rune == '+') {
					mode = 0;
				} else if(rune == '-') {
					mode = 1;
				} else if(rune == '*') {
					mode = 2;
				} else if(rune == '/') {
					mode = 3;
				}
			}
		}
	}
	//if((naof_secs == 1) && (number == 0)) {
		//number = non_code;
	//}
	//printf("number | %lu\n", number[0]);
	return;
}

// clasicall 6 + 8 * 2 is different thant 6 + (8 * 2)
// but as you might more naturally expect than the standard russian salt of order of opps
vast statemints(writer grid, source statemints_source, quadrant naof_statemints_secs, directional * number, quadrant base) {
	quadrant non_code = 0xffffffffffffffff;
	number[0] = 0;
	writer math_que = 0;
	create_vecter(grid, 0x28, 100, &math_que);
	sec statemints[10000];
	naof_statemints_secs = strip(statemints_source, statemints, naof_statemints_secs);
	//syscall(unix_write, 1, statemints, naof_statemints_secs);
	//syscall(unix_write, 1, "\n", 1);
	writer nodes = 0;
	noom_nodes(grid, statemints, naof_statemints_secs, &nodes);
	//syscall(unix_write, 1, "\n", 1);
	quadrant nsite = 0;
	while(true) {
		if(nsite == nodes[2]) {
			break;
		}
		writer record = ((nodes + 3) + (nsite * 3));
		//printf("noom-site | %lu\n", record[0]);
		//syscall(unix_write, 1, (record[1]), (record[2]));
		//syscall(unix_write, 1, "\n", 1);
		quadrant mrecord[4];
		quadrant entree_site = 0;
		quadrant naof_entree_secs = record[2];
		//printf("naof-entree-secs | %lu\n", naof_entree_secs);
		quadrant bmode = non_code;
		sec rune = ((source)record[1])[0];
		if((rune == '+') || (rune == '-') || (rune == '*') || (rune == '/')) {
			if(rune == '+') {
				bmode = 0;
			} else if(rune == '-') {
				bmode = 1;
			} else if(rune == '*') {
				bmode = 2;
			} else if(rune == '/') {
				bmode = 3;
			}
			entree_site += 1;
			naof_entree_secs -= 1;
		}
		quadrant amode = non_code;
		quadrant et = (record[2] - 1);
		if(et != 0) {
			rune = ((source)record[1])[(et)];
			if((rune == '+') || (rune == '-') || (rune == '*') || (rune == '/')) {
				if(rune == '+') {
					amode = 0;
				} else if(rune == '-') {
					amode = 1;
				} else if(rune == '*') {
					amode = 2;
				} else if(rune == '/') {
					amode = 3;
				}
				naof_entree_secs -= 1;
			}
		}
		//syscall(unix_write, 1, (record[1] + entree_site), (naof_entree_secs));
		//syscall(unix_write, 1, "\n", 1);
		//printf("naof-entree-secs | %lu\n", naof_entree_secs);
		//getc(stdin);
		quadrant number = 0;
		statemint((record[1] + entree_site), naof_entree_secs, base, &number);
		mrecord[0] = record[0];
		mrecord[1] = bmode;
		mrecord[2] = number;
		mrecord[3] = amode;
		mrecord[4] = 0;
		add_to_vecter(&grid, mrecord, &math_que);
		nsite += 1;
	}
	quadrant vsite = 0;
	while(true) {
		if(vsite == math_que[2]) {
			break;
		}
		writer record = ((math_que + 3) + (vsite * 5));
		//see_space("record", record, 0x28);
		vsite += 1;
	}
	//syscall(unix_write, 1, "\n", 1);
	quadrant met = math_que[2] - 1;
	while(true) {
		quadrant net = 0;
		quadrant msite = 0;
		while(true) {
			if(msite == math_que[2]) {
				break;
			}
			writer nrecord = ((math_que + 3) + (msite * 5));
			//see_space("record", nrecord, 0x28);
			//printf("number | %lu\n", nrecord[2]);
			if((nrecord[0] > net) && (nrecord[2] != non_code)) {
				net = nrecord[0];
			}
			msite += 1;
		}
		//printf("net | %lu\n", net);
		writer record = 0;
		msite = 0;
		while(true) {
			if(msite == math_que[2]) {
				record = 0;
				break;
			}
			record = ((math_que + 3) + (msite * 5));
			//see_space("record", record, 0x28);
			if((record[0] == net) && (record[2] != non_code)) {
				break;
			}
			msite += 1;
		}
		quadrant msite2 = 0;
		quadrant msite3 = 0;
		writer record2 = 0;
		quadrant direction = 0;
		if(msite != 0) {
			msite2 = msite - 1;
			while(true) {
				//printf("msite2 | %lu\n", msite2);
				record2 = ((math_que + 3) + (msite2 * 5));
				if(record2[2] == non_code) {
					if(msite2 == 0) {
						record2 = 0;
						break;
					}
					msite2 -= 1;
				} else {
					//see_space("record2", record2, 0x28);
					break;
				}
			}
		}
		if(msite != met) {
			msite3 = msite + 1;
			while(true) {
				//printf("msite3 | %lu\n", msite3);
				writer record3 = ((math_que + 3) + (msite3 * 5));
				//see_space("record3", record3, 0x28);
				if(record3[2] != non_code) {
					if(record2 != 0) {
						if(record3[0] > record2[0]) {
							record2 = record3;
							direction = 1;
						}
					} else {
						record2 = record3;
						direction = 1;
					}
					break;
				} else {
					msite3 += 1;
					if(msite3 == nodes[2]) {
						break;
					}
				}
			}
			if(record2[2] == non_code) {
				record2 = 0;
			}
		}
		if(record2 != 0) {
			//printf("direction | %lu\n", direction);
			//printf("msite | %lu\n", msite);
			//see_space("record", record, 0x28);
			//printf("number | %lu\n", record[2]);
			//printf("msite2 | %lu\n", msite2);
			//see_space("record2", record2, 0x28);
			//printf("number2 | %lu\n", record2[2]);
			quadrant mode = 0;
			if(direction == 0) {
				if(record2[3] != non_code) {
					mode = record2[3];
				}
				//printf("mode | %lu\n", mode);
				if(mode == 0) {
					record[2] += record2[2];
				} else if(mode == 1) {
					record[2] = (record2[2] - record[2]);
				} else if(mode == 2) {
					record[2] = (record2[2] * record[2]);
				} else if(mode == 3) {
					record[2] = (record2[2] / record[2]);
				}
				record2[2] = non_code;
			} else {
				if(record2[1] != non_code) {
					mode = record2[1];
				}
				//printf("mode | %lu\n", mode);
				if(mode == 0) {
					record2[2] += record[2];
				} else if(mode == 1) {
					record2[2] = (record[2] - record2[2]);
				} else if(mode == 2) {
					record2[2] = (record[2] * record2[2]);
				} else if(mode == 3) {
					record2[2] = (record[2] / record2[2]);
				}
				record[2] = non_code;
			}
			//see_space("record", record, 0x28);
			//printf("number | %lu\n", record[2]);
			//see_space("record2", record2, 0x28);
			//printf("number2 | %lu\n", record2[2]);
		}
		quadrant naof_todos = 0;
		writer record3 = 0;
		quadrant com_number = 0;
		msite2 = 0;
		while(true) {
			if(msite2 == math_que[2]) {
				break;
			}
			record3 = ((math_que + 3) + (msite2 * 5));
			if(record3[2] != non_code) {
				com_number = record3[2];
				naof_todos += 1;
			}
			msite2 += 1;
		}
		//printf("naof-todos | %lu\n", naof_todos);
		if(naof_todos == 1) {
			number[0] = com_number;
			break;
		}
		//getc(stdin);
		//see_space("record", record3, 0x28);
		//break;
	}
	return;
}
