#include <iostream>
#include <cstdlib>
#include <cstdint>
#include <memory>

#include <verilated.h>
#include <verilated_sc.h>
#include "obj_dir/Vmain.h"

using namespace sc_core;

int32_t sc_main(int32_t argc, char **argv) {
	Verilated::commandArgs(argc,argv);
	std::unique_ptr<Vmain> vmain(new Vmain("main"));
	sc_signal<uint32_t> a,b,y;
	sc_clock clk("clk",1,SC_US);
	vmain->a(a);
	vmain->b(b);
	vmain->y(y);
	vmain->clk(clk);

	a.write(15);
	b.write(33);

	sc_start(1,SC_US);
	std::cout << "a: " << a.read() << ",b: " << b.read() << ",y: " << y.read() << std::endl;

	return EXIT_SUCCESS;
}
