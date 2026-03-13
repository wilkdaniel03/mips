`ifndef DEFS_INC
`include "rtl/defs.sv"
`define DEFS_INC 1
`endif

module alu
	(
		input wire[31:0] a,b,
		input wire clk,
		input alu_oper_t operation,
		output wire[31:0] y
	);

	import defs::*;

	reg[31:0] addition;
	reg[31:0] subtraction;

	reg[31:0] result;

	always_comb begin
		addition = a + b;
		subtraction = a - b;
	end

	always_ff @(posedge clk) begin
		case(operation)
			ADD: result = addition;
			SUB: result = subtraction;
			default: begin end
		endcase
	end

	assign y = result;

endmodule
