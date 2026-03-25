`include "rtl/instruction_cache.sv"

module instruction_cache_tb
	();

	reg clk = 0;

	reg[31:0] prog_mem[0:255];

	reg[7:0] wr_addr = 0;
	reg[7:0] rd_addr = 0;
	reg[31:0] current_instruction;
	reg[31:0] read_instruction;

	instruction_cache uut(clk,1'b1,1'b1,wr_addr,rd_addr,current_instruction,read_instruction);

	integer i;
	initial begin
		prog_mem[0] = 32'h00000010;
		prog_mem[1] = 32'h00000020;
		prog_mem[2] = 32'h00000030;
		prog_mem[3] = 32'h00000040;
		prog_mem[4] = 32'h00000050;
		prog_mem[5] = 32'h00000060;
		prog_mem[6] = 32'h00000070;
		prog_mem[7] = 32'h00000080;
		prog_mem[8] = 32'h00000090;
		prog_mem[9] = 32'h000000a0;
		prog_mem[10] = 32'h000000b0;
		prog_mem[11] = 32'h000000c0;
		prog_mem[12] = 32'h000000d0;

		current_instruction = prog_mem[wr_addr];

		clk = 1'b1;
		#10;
		clk = 1'b0;
		wr_addr = wr_addr + 1;
		#10;

		for(i=0;i<16;i=i+1) begin
			current_instruction = prog_mem[wr_addr];

			clk = 1'b1;
			#10;
			clk = 1'b0;
			wr_addr = wr_addr + 1;
			rd_addr = rd_addr + 1;
			#10;
		end
	end

	always @(posedge clk) begin
		$display("addr = %x, instruction = %x",rd_addr,read_instruction);
	end

endmodule
