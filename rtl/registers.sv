module registers
	(
		input wire clk,
		input wire[31:0] instruction,
		output wire is_jump,
		output reg[31:0] y_a,y_b
	);

	localparam OPCODE_MSB = 31;
	localparam OPCODE_LSB = 26;
	localparam RS_MSB = 25;
	localparam RS_LSB = 21;
	localparam RT_MSB = 20;
	localparam RT_LSB = 16;
	localparam IMM_MSB = 15;
	localparam IMM_LSB = 0;

	typedef enum reg[2:0] { FETCH, DECODE, EXEC, MEM, SAVE } state_t;
	typedef enum logic[5:0] { MOVLW, MOVF, JMP, LD, ST, ADD, SUB } instr_t;

	reg[31:0] regs[0:31];
	state_t current_state = FETCH;
	reg[4:0] dest;

	integer i;
	initial begin
		for(i=0;i<32;i=i+1) begin
			regs[i] = 0;
		end
	end

	always_ff @(posedge clk) begin
		case(current_state)
			FETCH: begin
				case(instruction[OPCODE_MSB:OPCODE_LSB])
					ADD,SUB: begin
						y_a <= regs[instruction[RS_MSB:RS_LSB]];
						y_b <= regs[instruction[RT_MSB:RT_LSB]];
					end
					MOVLW: begin
						y_a <= regs[instruction[RT_MSB:RT_LSB]];
						y_b <= {{16{1'b0}},instruction[IMM_MSB:IMM_LSB]};
					end
					default: begin end
				endcase
				dest <= instruction[RS_MSB:RS_LSB];
				current_state <= DECODE;
			end
			DECODE: current_state <= EXEC;
			EXEC: current_state <= MEM;
			MEM: current_state <= SAVE;
			SAVE: current_state <= FETCH;
			default: begin end
		endcase
	end

endmodule
