`include "instruction.v"
`include "pc.v"

//Module fore main control
module main_control(
	input CLK,
	input RESET,
	output [2:0] ALU_OP,
	output SUB_SELECT,
	output IMMEDIATAE_SELECT,
	output WRITE,
	output [7:0 ]IMMEDIATAE,
	output [2:0] OUT1_ADD,
	output [2:0] OUT2_ADD,
	output [2:0] WRITE_ADD
	);
	wire [31:0] PC,INSTRUCTION;
	reg IMMEDIATAE_SELECT,SUB_SELECT;
	reg [2:0] ALU_OP;
	
	pc program_counter(CLK,RESET,PC);
	instruction_gen myinstruction_gen(PC,INSTRUCTION);
	
	//decoding for next operatios
	assign #1 WRITE=1;
	assign #1 IMMEDIATAE= INSTRUCTION[7:0];
	assign  OUT1_ADD= INSTRUCTION[10:8];
	assign  OUT2_ADD= INSTRUCTION[2:0];
	assign  WRITE_ADD= INSTRUCTION[18:16];
	//decoding ALUopp and selects for muxes
	always @(INSTRUCTION) #1 begin
		if (INSTRUCTION[27:24]==4'b0000) begin
			IMMEDIATAE_SELECT=1'b1;   		//for load instruction give the emmediate select=1
		end
		if (INSTRUCTION[27:24]!=4'b0000) begin
			IMMEDIATAE_SELECT=1'b0;
		end
		if (INSTRUCTION[26:24]==3'b011) begin
			SUB_SELECT=1'b1;						//for the subtract give the sub select=1
		end
		if (INSTRUCTION[26:24]!=3'b011) begin
			SUB_SELECT=1'b0;
		end
		//ALU_OP decoding
		if (INSTRUCTION[27:24]==4'b0000) begin
			ALU_OP=3'b000;							//for load
		end
		if (INSTRUCTION[27:24]==4'b0001) begin
			ALU_OP=3'b000;							//for move 
		end
		if (INSTRUCTION[27:24]==4'b0010) begin
			ALU_OP=3'b001;							//for add
		end
		if (INSTRUCTION[27:24]==4'b0011) begin
			ALU_OP=3'b001;							//dor sub				
		end
		if (INSTRUCTION[27:24]==4'b0100) begin
			ALU_OP=3'b010;							//for AND
		end
		if (INSTRUCTION[27:24]==4'b0101) begin
			ALU_OP=3'b011;
		end
	end
	
endmodule
	
	