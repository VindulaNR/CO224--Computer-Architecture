`include "main_control.v"
`include  "2s_complement.v" 
`include "sub_mux.v"
`include "alu.v"
`include "reg_file.v"
module cpu(CLK,RESET);
	input CLK,RESET;
	wire [7:0] IMMEDIATAE,ALU_RESULT,REG_OUT1,REG_OUT2,COMPLEMENT,RES1,OPERAND1;
	wire [2:0] ALU_OPP,OUT1_ADD,OUT2_ADD,WRITE_ADD;
	wire SUB_SELECT,IMMEDIATAE_SELECT,WRITE;
	
	main_control my_main_control(CLK,RESET, ALU_OPP,SUB_SELECT,IMMEDIATAE_SELECT, WRITE,IMMEDIATAE,OUT1_ADD,OUT2_ADD,WRITE_ADD);
	reg_file #1 myreg (CLK,RESET,WRITE,WRITE_ADD,ALU_RESULT,OUT1_ADD,REG_OUT1,OUT2_ADD,REG_OUT2);
	complement mycomp(REG_OUT2,COMPLEMENT);
	sub_mux mysub(REG_OUT2,COMPLEMENT,SUB_SELECT,RES1);
	sub_mux #1 myimmediate(RES1,IMMEDIATAE,IMMEDIATAE_SELECT,OPERAND1);
	alu #1 myalu (REG_OUT1,OPERAND1,ALU_RESULT,ALU_OPP);
	
endmodule