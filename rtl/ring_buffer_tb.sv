`include "rtl/ring_buffer.sv"
`timescale 1ns / 10ps

module ring_buffer_tb
	();

	reg clk = 0;
	reg wr_en = 0;
	reg rd_en = 0;
	reg[1:0] addr = 0;
	reg[7:0] din;
	reg[7:0] dout;
	ring_buffer #(4,8) uut(clk,wr_en,rd_en,addr,din,dout);

	integer i;
	initial begin
		for(i=0;i<10;i=i+1) begin
			clk = 1'b1;
			rd_en = 1'b1;
			if(i == 0) begin
				din = 8'h55;
				wr_en = 1'b1;
			end
			else if(i == 1) begin
				din = 8'h56;
				wr_en = 1'b1;
			end
			else if(i == 3) begin
				din = 8'h66;
				wr_en = 1'b1;
			end
			#1;
			clk = 1'b0;
			#1;
			wr_en = 1'b0;
		end
	end

	always @(negedge clk) begin
		$display("dout -> %x",dout);
		addr = addr + 1;
	end

endmodule
