`ifndef COUNTER_INC
`define COUNTER_INC 1
`include "rtl/counter.sv"
`endif
`timescale 1ns / 1ps

module ring_buffer
	#(
		parameter WIDTH,
		parameter DEPTH
	)
	(
		input wire clk,wr_en,rd_en,
		input wire[WIDTH-1:0] addr,
		input wire[DEPTH-1:0] din,
		output wire[DEPTH-1:0] dout
	);

	parameter IDX_WIDTH = $clog2(WIDTH) + 1;

	reg idx_en = 0;
	wire[IDX_WIDTH-1:0] idx_data;
	wire idx_rco;
	counter #(IDX_WIDTH,WIDTH) idx(clk,idx_en,idx_data,idx_rco);
	reg[DEPTH-1:0] data[0:2**WIDTH-1];

	reg[DEPTH-1:0] dout_buf = 0;

	always_ff @(posedge clk) begin
		if(wr_en == 1'b1) begin
			idx_en = 1'b1;
			data[idx_data] = din;
		end
		if(rd_en == 1'b1) begin
			dout_buf = data[addr];
		end
	end

	always_ff @(negedge clk) begin
		idx_en =  1'b0;
	end

	assign dout = dout_buf;

endmodule
