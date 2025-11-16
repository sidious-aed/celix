#ifndef satlevel3
#define satlevel3

#include <dlfcn.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/time.h>
#include <dirent.h>
#include <string.h>
#include <sys/resource.h>
#include <sys/syscall.h>
#include <sys/wait.h>
#include <asm/prctl.h>
#include <sys/prctl.h>
#include <sys/mman.h>
#include <signal.h>
#include <sys/socket.h>
#include <pthread.h>
#include <errno.h>
#include <ctype.h>
#include "./unix.h"
#include <locale.h>

// archive constants
#define archive_read 0
#define archive_write 1
#define archive_read_write 2
#define archive_append 1024
#define archive_create 64
#define archive_arws 00777
#define archive_droid 00770 // for close projects
#define archive_open 00755
#define archive_jypsy 00750
#define archive_admin 00700
#define seek_origin 0
#define seek_at 1
#define seek_completion 2
#define nonce_distance 12
// mmap constants
// anonymous | the nicer aviniou
#define map_stay 4
#define map_read 1
#define map_write 2
#define map_rws 7
#define map_cloe 0x22
#define map_shares 0x21
#define map_close 2
// just | as in just is with ask of stack space which wide mapped any way and without some extra silent clerical vibe
// and free of an issues potential
#define map_just 32
#define file_read_distance 662796

// mapping
#define map_readable 1
#define map_writable 2
#define map_stayable 4
#define clerk_descreet 2
#define map_as_space 32
//#define clerk_presision 42 // reveals base-2 third-bar facter more
#define clerk_presision 21

// standard
typedef unsigned long * reader;
typedef unsigned long * writer;
typedef unsigned char * grid_site;
typedef unsigned long * quadrant_reference;
typedef unsigned char * sec_reference;
typedef unsigned char sec;
typedef unsigned char * source;
typedef unsigned char ** source_vecter;
typedef unsigned char ** source_reference;
typedef void * vast_reference;
typedef void vast;
typedef unsigned long archive_grid;
typedef unsigned long quadrant;
typedef double precision;
typedef double * precision_reference;
typedef unsigned int portion;
typedef int portion_directional;
typedef long directional;
typedef short dyno;
typedef short * dyno_reference;

#define true 1
#define false 0
#define non 0

// vecter memory
// naof-secs | quad-0
// breadth | quad-1
// at | quad-2
#define naof_vecter_meta_secs 24

//vast cerindipitous_place(source entree, source destination, quadrant naof_secs);
// aliases
//#define get_distance(s) strlen(s)
// #define place(s, d, naof_secs) memcpy(d, s, naof_secs)
//#define place(entree, destination, naof_secs) cerindipitous_place(entree, destination, naof_secs)
//#define naoify(space, naof_secs) bzero(space, naof_secs)
#define naoify(space, naof_secs) { \
	quadrant stack_naof_secs = naof_secs; \
	quadrant naof_quads = stack_naof_secs / 8; \
	stack_naof_secs -= (naof_quads * 8); \
	register quadrant space_register asm("rdi"); \
	space_register = space; \
	register quadrant constant_register asm("rcx"); \
	constant_register = naof_quads; \
	asm("xor %rax, %rax"); \
	asm("rep stos %rax, %es:(%rdi)"); \
	constant_register = stack_naof_secs; \
	asm("rep stosb %al, %es:(%rdi)"); \
}

#endif
// completion of core-mavras for gcc basises
