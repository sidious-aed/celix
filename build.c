#include "./standard.h"

quadrant main() {
	// libs
	system("gcc -c standard.c -o standard.lib");
	//system("gcc -c standard.lib clerk.c -o clerk.lib");
	system("gcc -c standard.lib machine.c -o machine.lib");

	// lib mains
	system("gcc standard.lib standard-main.c -o standard-main");
	//system("gcc standard.lib clerk.lib clerk-main.c -o clerk-main");
	system("gcc standard.lib machine-main.c -o machine-main");
	//system("./non-cltqs clerk-main");

	// exec-ware
	//system("gcc cn.c -o cn");
	//system("gcc rn.c -o rn");
	//system("gcc standard.lib stay.c -o stay");
	//system("gcc standard.lib naof-secs.c -o naof-secs");
	//system("gcc standard.lib naof-elements.c -o naof-elements");
	//system("gcc standard.lib base.c -o base");
	system("gcc standard.lib vecter-entree.c -o vecter-entree");
	//system("gcc standard.lib statemints.c -o statemints");

	// archives-ware
	//system("gcc standard.lib clerk.lib clear-desk.c -o clear-desk");
	//system("gcc standard.lib clerk.lib list-files.c -o list-files");
	//system("gcc standard.lib clerk.lib ngrep.c -o ngrep");
	//system("gcc standard.lib seek-file-site.c -o seek-file-site");
	//system("gcc standard.lib file-secs-sites.c -o file-secs-sites");

	// clerk-wide-ware (es always mean-(t))
	//system("./non-cltqs base");
	//system("gcc standard.lib asm-secs.c -o asm-secs");
	//system("gcc standard.lib clerk.lib equations.c -o equations");
	//system("gcc standard.lib machine.lib sequences.c -o sequences");
	//system("gcc standard.lib machine.lib sequences-full.c -o sequences-full");
	//system("gcc standard.lib clerk.lib build-equations.c -o build-equations");
	//system("gcc standard.lib build-shell.c -o build-shell");
	//system("gcc standard.lib view-assembly.c -o view-assembly");
	// all respects to the awesome spec fulfilling dinasaurs.
	// be to the spec demanders the non (in a prose of trends) of their docket issuances goes to.
	//system("gcc standard.lib clerk.lib non-cltqs.c -o non-cltqs");

	// main-shells
	//system("./sequences procs/i-sim.asm procs/i-sim.proc 0");
	//system("./build-shell procs/i-sim.proc i-sim.c");
	//system("gcc i-sim.c -o i-sim");
	//system("./sequences assemblies/equations.asm secs/equations.secs 0");
	//system("./sequences procs/equations-main.asm procs/equations-main.proc 0");
	//system("./build-shell procs/equations-main.proc equations-main.c");
  return 0;
}
