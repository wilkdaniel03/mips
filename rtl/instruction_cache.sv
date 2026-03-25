`include "rtl/cam.sv"
`include "rtl/ring_buffer.sv"
`timescale 1 ns / 1 ps

module instruction_cache
	(
		input wire clk,wr_en,rd_en,
		input wire[7:0] wr_instruction_addr,
		input wire[7:0] rd_instruction_addr,
		input wire[31:0] instruction,
		output wire[31:0] dout
	);

	parameter CACHE_SIZE = 2;
	parameter INSTRUCTION_ADDR_LENGTH = 8;
	parameter INSTRUCTION_LENGTH = 32;

	reg[CACHE_SIZE-1:0] buf_addr;
	reg[INSTRUCTION_LENGTH-1:0] buf_instruction;

	cam #(CACHE_SIZE,INSTRUCTION_ADDR_LENGTH) cam_mem(clk,wr_en,wr_instruction_addr,rd_instruction_addr,buf_addr);

	ring_buffer #(CACHE_SIZE,INSTRUCTION_LENGTH) buffer(clk,wr_en,rd_en,buf_addr,instruction,buf_instruction);

	assign dout = buf_instruction;

endmodule
