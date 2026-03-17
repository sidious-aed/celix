#include "./standard.h"

quadrant main(quadrant naof_params, source_vecter params) {
	system("./build-equations equations");
	system("./build-equations views");
	system("./build-equations cf");
	//system("./build-equations vecters");
	//system("./build-equations vects");
	//system("./build-equations svects");
	//system("./build-equations clerk");
	//system("./sequences asms/equations/main.asm secs/equations/main.secs 0");
	//system("./sequences asms/vecters/main.asm secs/vecters/main.secs 0");
	//system("./sequences asms/clerk/main.asm secs/clerk/main.secs 0");
	//system("./sequences asms/procs/genseed.asm secs/procs/genseed.secs 0");
	//system("./sequences asms/procs/dc-client.asm secs/procs/dc-client.secs 0");
	//system("./build-msh asms/procs/dc-client.asm");
	//system("./build-msh asms/procs/dc-server.asm");
	system("./sequences asms/procs/chart-binary.asm secs/procs/chart-binary.secs 0");
	system("./build-msh asms/procs/chart-binary.asm");
	system("./sequences asms/procs/chart-elf.asm secs/procs/chart-elf.secs 0");
	system("./build-msh asms/procs/chart-elf.asm");
  return 0;
}
