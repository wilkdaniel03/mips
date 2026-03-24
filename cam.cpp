#include <iostream>
#include <cstdlib>
#include <cstdint>
#include <memory>

#include "obj_dir/Vcam_tb.h"

using namespace sc_core;

int32_t sc_main(int32_t argc, char **argv) {
	Verilated::commandArgs(argc,argv);
	std::unique_ptr<Vcam_tb> tb(new Vcam_tb("tb"));
	sc_start(1000,SC_NS);
	return EXIT_SUCCESS;
}
