`include "rtl/counter.sv"
`include "rtl/progmem.sv"
`include "rtl/registers.sv"

module main
	(
		input wire[31:0] a,b,
		input wire clk,
		output wire[31:0] y
	);

	reg[1:0] addr;
	reg ic_rco;
	counter #(2) ic(clk,addr,ic_rco);

	reg[31:0] instruction;
	progmem prog(clk,addr,instruction);

	wire[31:0] reg_a;
	wire[31:0] reg_b;
	registers regs(clk,instruction,reg_a,reg_b);

	assign y = instruction;

	always begin
		$display("alu_a: %x, alu_b: %x",reg_a,reg_b);
	end

endmodule
