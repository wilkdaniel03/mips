`ifndef COUNTER_INC
`include "rtl/counter.sv"
`define COUNTER_INC 1
`endif
`timescale 1ns / 1ps

module cam
	#(
		parameter WIDTH,
		parameter DEPTH
	)
	(
		input wire clk,wr_en,
		input wire[DEPTH-1:0] wr_addr,
		input wire[DEPTH-1:0] din,
		output wire[WIDTH-1:0] rd_addr
	);

	reg[DEPTH-1:0] data[0:2**WIDTH-1];
	reg[WIDTH-1:0] current_dout;

	reg[WIDTH-1:0] current_addr;
	reg[WIDTH-1:0] current_addr_buf;
	reg current_addr_rco;
	counter #(WIDTH,2**WIDTH) addr_counter(clk,wr_en,current_addr,current_addr_rco);

	integer i;
	always_latch begin
		for(i=0;i<2**WIDTH;i=i+1) begin
			if(WIDTH'(i) == current_addr) begin
				data[current_addr] = wr_addr;
			end
			if(din == data[WIDTH'(i)]) begin
				current_dout = WIDTH'(i);
			end
		end
	end

	always_ff @(posedge clk) begin
		current_addr_buf = current_addr;
	end

	assign rd_addr = current_addr_buf;

endmodule
