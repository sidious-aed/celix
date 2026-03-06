#include "./standard.h"

quadrant main(quadrant naof_params, source_vecter params) {
	system("./build-equations equations");
	system("./build-equations views");
	system("./build-equations vecters");
	system("./build-equations clerk");
	//system("./sequences asms/equations/main.asm secs/equations/main.secs 0");
	//system("./sequences asms/vecters/main.asm secs/vecters/main.secs 0");
	//system("./sequences asms/clerk/main.asm secs/clerk/main.secs 0");
	//system("./sequences asms/procs/genseed.asm secs/procs/genseed.secs 0");
  return 0;
}
