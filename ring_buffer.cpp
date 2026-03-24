#include <iostream>
#include <cstdlib>
#include <cstdint>
#include <memory>

#include "obj_dir/Vring_buffer_tb.h"

using namespace sc_core;

int32_t sc_main(int32_t argc, char **argv) {
	Verilated::commandArgs(argc,argv);
	std::unique_ptr<Vring_buffer_tb> tb(new Vring_buffer_tb("tb"));
	sc_start(100,SC_NS);
	return EXIT_SUCCESS;
}
