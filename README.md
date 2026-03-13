# MIPS

### Goals
* Implement non-pipelined MIPS architecture using systemverilog
* Implement also the pipelined version

<img src="assets/mips.gif">

### Prerequisites
* CMake
* Verilator

### Setup

```bash
mkdir build
cmake -S . -B build/
verilator --sc main.sv --top-module main --build
cd build
make
./vmain
```
