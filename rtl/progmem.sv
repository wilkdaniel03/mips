module progmem
	(
		input wire clk,
		input wire[7:0] addr,
		output wire[31:0] data
	);

	reg[31:0] prog[0:255];
	reg[31:0] current;

	initial begin
		prog[0] = {6'b000011,{10{1'b0}},16'd2};
		prog[1] = 5;
		prog[2] = 10;
		prog[3] = {6'b000001,5'b00000,5'b00011,16'd1};
		prog[4] = {6'b000001,5'b00001,5'b00011,16'd2};
		prog[5] = {6'b000110,5'b00000,5'b00001,{16{1'b0}}};
	end

	always_ff @(posedge clk) begin
		current = prog[addr];
	end

	assign data = current;

endmodule
