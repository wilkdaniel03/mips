`include "rtl/cam.sv"
`timescale 1 ns / 1 ps

module cam_tb
	();

	reg clk = 0;
	reg wr_en = 1'b0;
	reg[7:0] wr_addr = 8'h50;
	reg[7:0] din = 8'h53;
	reg[1:0] rd_addr = 0;

	cam #(2,8) cam_mem(clk,wr_en,wr_addr,din,rd_addr);

	integer i;
	initial begin
		wr_en = 1'b1;
		for(i=0;i<30;i=i+1) begin
			wr_addr = wr_addr + 1;
			clk = 1'b1;
			#10;
			clk = 1'b0;
			#10;
		end
		wr_en = 1'b0;
	end

	always @(posedge clk) begin
		$display("din = %x, dout = %x",din,rd_addr);
	end

endmodule
