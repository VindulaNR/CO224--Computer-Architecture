//module for instruction genaration 
module instruction_gen(PC,INSTRUCTION);
	input [31:0] PC;
	output [31:0] INSTRUCTION;
	reg [31:0] memory[6:0];
	wire [6:0] rom_adr = PC[5:2];
	
	initial
	begin
		$readmemb("test.prog",memory,0,6);				//read the file of instruction
	end
	assign #2 INSTRUCTION = memory[rom_adr];	//put te instruction in to reg
endmodule
	
	
	