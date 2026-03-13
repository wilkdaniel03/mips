module progmem
	(
		input wire clk,
		input wire[1:0] addr,
		output wire[31:0] data
	);

	reg[31:0] prog[0:3];
	reg[31:0] current;

	initial begin
		prog[0] = {6'b000010,{10{1'b0}},16'd1};
		prog[1] = 5;
		prog[2] = {{16{1'b0}},16'd1};
		prog[3] = {6'b000101,5'b00000,5'b00001,{16{1'b0}}};
	end

	always_ff @(posedge clk) begin
		current = prog[addr];
	end

	assign data = current;

endmodule
