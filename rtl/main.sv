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

	reg[7:0] addr;
	reg[7:0] next_addr = 0;
	reg[2:0] state;
	reg state_rco;
	counter #(3,5) state_counter(clk,state,state_rco);

	always @(posedge clk) begin
		if(state == 3'b001) next_addr = addr + 1;
	end

	reg[31:0] instruction;
	progmem prog(clk,addr,instruction);

	wire[31:0] reg_a;
	wire[31:0] reg_b;
	wire[31:0] reg_din;
	reg is_jump;
	reg[1:0] oper;
	registers regs(clk,instruction,reg_din,is_jump,oper,reg_a,reg_b);

	assign reg_din = instruction;

	reg[31:0] alu_result;
	alu alu_unit(reg_a,reg_b,clk,oper,alu_result);

	assign addr = is_jump == 1'b1 ? alu_result[7:0] : next_addr;

	assign y = alu_result;

endmodule
