//2s compliment moodule ******************************************
module comp(In2S,OUT2S);
	input [7:0] In2S;
	output reg [7:0] OUT2S;
	reg [7:0] pchold;
	always @ (In2S) begin	
		pchold = ~In2S;
	    pchold = pchold + 1;
		OUT2S = pchold;
	end
endmodule

//muxtiflexer module*********************************************
module mux(IN0,IN1,SEL,OUT);
	//declaring the ports
	input [7:0] IN0,IN1;
	input SEL;
	output reg [7:0] OUT;
	
	always @ (SEL,IN0,IN1) begin //set sensivity 
	if(SEL == 1'b0)begin
	OUT = IN0; 
	end
	else begin
	OUT = IN1;
	end
	end
	
endmodule

//control unit***************************************************
module ctrl_unit(INSTRUCTIONS,CLK,RESET,READREG1,READREG2,WRITEREG,WRITEENABLE,IMMIDIATE,ALUOP,MUX_immi,MUX_2s,BRANCH);

	//declareing input 
	input [31:0] INSTRUCTIONS;
	input CLK,RESET;
	//declaring output
	//output reg[31:0] PC;
	output reg [7:0] IMMIDIATE;
	output reg [2:0] READREG1,READREG2,WRITEREG,ALUOP;
	output reg MUX_immi,MUX_2s,WRITEENABLE;
	output reg BRANCH;
	//wire [31:0] PC_out;
	
	//pc module*********************************************************
	
	
	
	always @ (INSTRUCTIONS) begin
		if(INSTRUCTIONS[31:24] == 8'd0)  begin //add 
					
					WRITEREG = INSTRUCTIONS[18:16];
					READREG1 = INSTRUCTIONS[10:8];
					READREG2 = INSTRUCTIONS[2:0];
					#1
					MUX_2s = 1'b0;
					MUX_immi = 1'b1;
					WRITEENABLE = 1'b1;
					ALUOP = 3'b001;
					BRANCH = 1'b0;
					
			end
			if(INSTRUCTIONS[31:24] == 8'd1) begin //sub
					
					WRITEREG = INSTRUCTIONS[18:16];
					READREG1 = INSTRUCTIONS[10:8];
					READREG2 = INSTRUCTIONS[2:0];
					#1
					MUX_2s = 1'b1;
					MUX_immi = 1'b1;
					WRITEENABLE = 1'b1;
					ALUOP = 3'b001;
					BRANCH = 1'b0;
					end
			if(INSTRUCTIONS[31:24] == 8'd2)begin  //and
					
					WRITEREG = INSTRUCTIONS[18:16];
					READREG1 = INSTRUCTIONS[10:8];
					READREG2 = INSTRUCTIONS[2:0];
					#1
					MUX_2s = 1'b0;
					MUX_immi = 1'b1;
					WRITEENABLE = 1'b1;
					ALUOP = 3'b010;
					BRANCH = 1'b0;
					end
			
			if(INSTRUCTIONS[31:24] == 8'd3) begin //or
					
					WRITEREG = INSTRUCTIONS[18:16];
					READREG1 = INSTRUCTIONS[10:8];
					READREG2 = INSTRUCTIONS[2:0];
					#1
					MUX_2s = 1'b0;
					MUX_immi = 1'b1;
					WRITEENABLE = 1'b1;
					ALUOP = 3'b011;
					BRANCH = 1'b0;
					end
			if(INSTRUCTIONS[31:24] == 8'd4) begin  //move
					
					WRITEREG = INSTRUCTIONS[18:16];
					READREG2 = INSTRUCTIONS[2:0];
					#1
					MUX_immi = 1'b1;
					MUX_2s = 1'b0;
					WRITEENABLE = 1'b1;
					ALUOP = 3'b000;
					BRANCH = 1'b0;
					end
			
			
			if(INSTRUCTIONS[31:24] == 8'd5) begin //loadi
					
					
					WRITEREG = INSTRUCTIONS[18:16];
					IMMIDIATE = INSTRUCTIONS[7:0];
				#1
					MUX_immi = 1'b0;
					MUX_2s = 1'b0;
					WRITEENABLE = 1'b1;
					ALUOP = 3'b000;
					BRANCH = 1'b0;
					end
			
			if(INSTRUCTIONS[31:24] == 8'd6) begin //BEQ
					
					
					READREG1 = INSTRUCTIONS[10:8];
					READREG2 = INSTRUCTIONS[2:0];
					IMMIDIATE = INSTRUCTIONS[23:16];
				#1
					MUX_immi = 1'b1;
					MUX_2s = 1'b0;
					//ALUOP = 3'b001;
					BRANCH = 1'b1;
					end
					
			if(INSTRUCTIONS[31:24] == 8'd7) begin //jump
					
					
					READREG1 = INSTRUCTIONS[2:0];
					READREG2 = INSTRUCTIONS[2:0];
					IMMIDIATE = INSTRUCTIONS[23:16];
				#1
					MUX_immi = 1'b1;
					MUX_2s = 1'b0;
					//ALUOP = 3'b001;
					BRANCH = 1'b1;
					end
		
		end
endmodule

//************************CPU module***************************************
module cpu(PC,INSTRUCTIONS,CLK,RESET);
	//declaring inputs and outputs
	input [31:0] INSTRUCTIONS;
	input CLK,RESET;
	
	output reg [31:0] PC;
	//declaring wires
	
	wire reg ZERO,BRANCH;
	wire  reg GATE_OUT;
	wire [31:0] SIGNOUT;
	wire [7:0] IMMIDIATE,REGOUT1,REGOUT2,MUX_immi_out,MUX_2s_out,COMP_out,ALURESULT;
	wire [2:0] READREG1,READREG2,WRITEREG,ALUOP;
	wire WRITEENABLE,MUX_2s,MUX_immi;
	reg [31:0] pc_hold;
	initial begin   //initial settings
		
		  //initialy it is zero
		pc_hold = 32'b0;
		end
	always @(posedge CLK,posedge RESET) begin
		
		if(RESET == 1'b0  )begin  //normal mood
	
			pc_hold = pc_hold + 4; 
		end
		
		if(RESET == 1'b0 && GATE_OUT == 1'b1) begin
			
			pc_hold = pc_hold + SIGNOUT;
		
		end
		
		if(RESET == 1'b1) begin //if the reset happen
		pc_hold = -4; 
		end
		
		#1   //delay to update the pc 
		PC = pc_hold;
	end
	

//connect control unit	
	ctrl_unit ctrl_unit1(INSTRUCTIONS,CLK,RESET,READREG1,READREG2,WRITEREG,WRITEENABLE,IMMIDIATE,ALUOP,MUX_immi,MUX_2s,BRANCH);
	

//connect the register file
	reg_file reg_file1(ALURESULT, REGOUT1,REGOUT2, INSTRUCTIONS[18:16], READREG1, READREG2, WRITEENABLE, CLK, RESET);//wired direcly for parallel working
	
//2s compliment unit
	comp comp1(REGOUT2,COMP_out);
	
//mulitflexer in 2s compliment
	mux mux1(REGOUT2,COMP_out,MUX_2s,MUX_2s_out);
	
//multiflexer for immidiate value
	mux mux2(IMMIDIATE,MUX_2s_out,MUX_immi,MUX_immi_out);
	
//connect alu
	alu alu1(REGOUT1,MUX_immi_out,ALUOP,ALURESULT,ZERO);
	
//connect sign extend
		sign sign1(IMMIDIATE,SIGNOUT);
		
//connect the and gate 
	and_gate and_gate1(BRANCH,ZERO,GATE_OUT);	





endmodule