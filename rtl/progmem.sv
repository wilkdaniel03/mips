module progmem
	(
		input wire clk,
		input wire[7:0] addr,
		output wire[31:0] data
	);

	reg[31:0] prog[0:255];
	reg[31:0] current;

	initial begin
		// prog[0] = {6'b000011,{10{1'b0}},16'd2};
		prog[0] = 1; // RST
		prog[1] = {6'b000001,5'b00001,5'b00011,16'd0}; // MOVLW 1
		prog[2] = {6'b000110,5'b00000,5'b00001,{16{1'b0}}}; // ADD R0,R1
		prog[3] = {6'b000011,{10{1'b0}},16'd254}; // jmp 2
	end

	always_ff @(posedge clk) begin
		current = prog[addr];
	end

	assign data = current;

endmodule
