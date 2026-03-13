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

### Opcodes(6bit)
* 000000: movlw
* 000001: movf
* 000010: jmp
* 000011: ld
* 000100: st
* 000101: add 
* 000110: sub
