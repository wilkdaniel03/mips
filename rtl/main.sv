`include "rtl/counter.sv"
`include "rtl/progmem.sv"

module main
	(
		input wire[31:0] a,b,
		input wire clk,
		output wire[31:0] y
	);

	reg[1:0] addr;
	reg ic_rco;
	counter #(2,3) ic(clk,addr,ic_rco);

	reg[31:0] instruction;
	progmem prog(clk,addr,instruction);

	assign y = instruction;

endmodule
