#include <iostream>
#include <cstdlib>
#include <cstdint>
#include <memory>

#include <verilated.h>
#include <verilated_sc.h>
#include "obj_dir/Vcounter_tb.h"

using namespace sc_core;

int32_t sc_main(int32_t argc, char **argv) {
	Verilated::commandArgs(argc,argv);
	std::unique_ptr<Vcounter_tb> testbench(new Vcounter_tb("testbench"));

	sc_start(100,SC_NS);

	return EXIT_SUCCESS;
}
