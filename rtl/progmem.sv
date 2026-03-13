module progmem
	(
		input wire clk,
		input wire[1:0] addr,
		output reg[31:0] data
	);

	reg[31:0] prog[0:3];

	initial begin
		prog[0] = {6'b000010,{10{1'b0}},16'd1};
		prog[1] = 5;
		prog[2] = {{16{1'b0}},16'd1};
	end

	always_ff @(posedge clk) begin
		data <= prog[addr];
	end

endmodule
