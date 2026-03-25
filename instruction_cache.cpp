#include <iostream>
#include <cstdlib>
#include <cstdint>
#include <memory>

#include "obj_dir/Vinstruction_cache_tb.h"

using namespace sc_core;

int32_t sc_main(int32_t argc, char **argv) {
	Verilated::commandArgs(argc,argv);
	std::unique_ptr<Vinstruction_cache_tb> tb(new Vinstruction_cache_tb("tb"));
	sc_start(1000,SC_NS);
	return EXIT_SUCCESS;
}
