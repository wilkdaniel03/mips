`ifndef DEFS_INC
`include "rtl/defs.sv"
`define DEFS_INC 1
`endif

module registers
	(
		input wire clk,
		input wire[31:0] instruction,
		input wire[31:0] din,
		output reg is_jump,
		output wire[1:0] oper,
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
	typedef enum logic[5:0] { NOP, MOVLW, MOVF, JMP, LD, ST, ADD, SUB, MUL, DIV } instr_t;

	reg[31:0] regs[0:31];
	state_t current_state = FETCH;
	reg[5:0] current_instr;
	reg[4:0] dest;
	reg[1:0] alu_operation;

	integer i;
	initial begin
		for(i=0;i<32;i=i+1) begin
			regs[i] = 0;
		end
	end

	always_ff @(posedge clk) begin
		$display("current state: %d",current_state);
		case(current_state)
			FETCH: current_state <= DECODE;
			DECODE: begin
				current_instr = instruction[OPCODE_MSB:OPCODE_LSB];
				case(current_instr)
					ADD,SUB: begin
						y_a <= regs[instruction[RS_MSB:RS_LSB]];
						y_b <= regs[instruction[RT_MSB:RT_LSB]];
					end
					MOVLW: begin
						y_a <= regs[instruction[RT_MSB:RT_LSB]];
						y_b <= {{16{1'b0}},instruction[IMM_MSB:IMM_LSB]};
						is_jump <= 1'b1;
					end
					default: begin end
				endcase
				if(instruction[OPCODE_MSB:OPCODE_LSB] == SUB) alu_operation <= defs::SUB;
				else if(instruction[OPCODE_MSB:OPCODE_LSB] == MUL) alu_operation <= defs::MUL;
				else if(instruction[OPCODE_MSB:OPCODE_LSB] == DIV) alu_operation <= defs::DIV;
				else alu_operation <= defs::ADD;
				dest <= instruction[RS_MSB:RS_LSB];
				current_state <= EXEC;
			end
			EXEC: current_state <= MEM;
			MEM: current_state <= SAVE;
			SAVE: begin
				if(current_instr == MOVLW) begin 
					regs[dest] <= din;
					$display("R%d <- %d",dest,din);
				end
				current_state <= FETCH;
				is_jump <= 1'b0;
			end
			default: begin end
		endcase
	end

endmodule
