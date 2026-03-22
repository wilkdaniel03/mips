`timescale 1ns/1ps
`include "rtl/counter.sv"

module counter_tb
	();

	logic clk = 0;
	wire[3:0] cout;
	wire rco;

	counter #(4,10) uut(clk,1'b1,cout,rco);

	integer i;
	initial begin
		for(i=0;i<16;i=i+1) begin
			clk = 1'b1;
			#1;
			clk = 1'b0;
			#1;
		end
	end

	always @(posedge clk) begin
		$display("cout: %d, rco: %d",cout,rco);
	end

endmodule
