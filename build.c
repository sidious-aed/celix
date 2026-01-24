#include "./standard.h"

quadrant main() {
	// libs
	//system("gcc -c standard.c -o standard.lib");
	//system("gcc -c standard.lib machine.c -o machine.lib");
	//system("gcc standard.lib machine.lib sequences.c -o sequences");
	system("gcc -c standard.lib clerk.c -o clerk.lib");

	// ware
	system("gcc standard.lib naof-secs.c -o naof-secs");
	//system("gcc standard.lib b16.c -o b16");
	//system("gcc standard.lib b10.c -o b10");
	system("gcc standard.lib clerk.lib clear-desk.c -o clear-desk");
	system("gcc standard.lib clerk.lib build-equations.c -o build-equations");

	// shells
	system("./sequences procs/i-sim.asm procs/i-sim.proc 0");
	system("./build-shell procs/i-sim.proc i-sim.c");
	system("gcc i-sim.c -o i-sim");
	system("./sequences assemblies/equations.asm secs/equations.secs 0");
	system("./sequences procs/equations-main.asm procs/equations-main.proc 0");
	system("./build-shell procs/equations-main.proc equations-main.c");
  return 0;
}
