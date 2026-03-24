`timescale 1ns / 1ps

module counter
	#(
		parameter WIDTH,
		parameter MOD=2**WIDTH
	)
	(
		input wire clk,
		input wire en = 1'b1,
		output wire[WIDTH-1:0] cout,
		output wire rco
	);

	reg[WIDTH-1:0] current = 0;
	reg current_rco = 1'b1;

	always_ff @(posedge clk) begin
		if(current < MOD-1 && en == 1'b1) begin
			current <= current + 1;
			current_rco <= 1'b0;
		end
		else if(en == 1'b1) begin
			current <= 0;
			current_rco <= 1'b1;
		end
		else begin
			current <= current;
			current_rco <= current_rco;
		end
	end

	assign cout = current;
	assign rco = current_rco;

endmodule
