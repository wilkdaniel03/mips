`ifndef DEFS_INC
`include "rtl/defs.sv"
`define DEFS_INC 1
`endif

`include "rtl/counter.sv"
`include "rtl/progmem.sv"
`include "rtl/registers.sv"
`include "rtl/alu.sv"

module main
	(
		input wire[31:0] a,b,
		input wire clk,
		output wire[31:0] y
	);

	import defs::*;

	reg[1:0] addr;
	reg ic_rco;
	counter #(2) ic(clk,addr,ic_rco);

	reg[31:0] instruction;
	progmem prog(clk,addr,instruction);

	wire[31:0] reg_a;
	wire[31:0] reg_b;
	reg is_jump;
	registers regs(clk,instruction,is_jump,reg_a,reg_b);

	alu_oper_t oper = SUB;
	reg[31:0] alu_result;
	alu alu_unit(a,b,clk,oper,alu_result);

	assign y = alu_result;

endmodule
