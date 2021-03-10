module cpu_test;
	reg [31:0] INSTRUCTIONS;
	reg CLK,RESET;
	//declaring output
	wire reg[31:0] PC;
	
	reg [7:0] MEMORY[1023:0];

	//cteate alumodel for testing
	cpu cpu1(PC,INSTRUCTIONS,CLK,RESET);
	
	initial
	begin
		//generate files need to plot waveform using GTKWave
		$dumpfile("wavedata_cpu.vcd");
		$dumpvars(0,cpu_test);
	end
	
	initial
	begin  
		//testing the forward answer 0100 0100
		RESET = 1'b1;
		CLK = 1'b1;
		#10
		RESET =1'b0;
		
		
		{MEMORY[0],MEMORY[1],MEMORY[2],MEMORY[3]} =     32'b00000101000000010000000000010100; //loadi 1 #20
		{MEMORY[4],MEMORY[5],MEMORY[6],MEMORY[7]} =     32'b00000101000000100000000000010100; //loadi 2 #10
		{MEMORY[8],MEMORY[9],MEMORY[10],MEMORY[11]} =   32'b00000110_00000011_00000011_00000010; //BEQ 2 1 2  should not jump
		{MEMORY[12],MEMORY[13],MEMORY[14],MEMORY[15]} = 32'b00000110_00000010_00000001_00000010; //BEQ 2 1 2  should jump
		{MEMORY[16],MEMORY[17],MEMORY[18],MEMORY[19]} = 32'b00000100000001000000000000000011; //mov 4 3
		{MEMORY[20],MEMORY[21],MEMORY[22],MEMORY[23]} = 32'b00000001000001010000001100000010; // SUB 5 3 2
		{MEMORY[24],MEMORY[25],MEMORY[26],MEMORY[27]} = 32'b00000101000000010000000000010111; //loadi 1 #23
		{MEMORY[28],MEMORY[29],MEMORY[30],MEMORY[31]} = 32'b00000101000000100000000000001011; //loadi 2 #11
		{MEMORY[32],MEMORY[33],MEMORY[34],MEMORY[35]} = 32'b00000011_00000100_00000001_00000011; //sub 4 3
		{MEMORY[36],MEMORY[37],MEMORY[38],MEMORY[39]} = 32'b00000001_00000101_00000011_00000010; // AND 5 3 2
		{MEMORY[40],MEMORY[41],MEMORY[42],MEMORY[43]} = 32'b00000111_11111100_0000000100000010; //jump -4
		
		end
		always @(PC) begin
			#2
			INSTRUCTIONS = {MEMORY[PC],MEMORY[PC+1],MEMORY[PC+2],MEMORY[PC+3]} ; //instruction fettiching
		
		end
	always begin
	 #5 CLK = ~CLK; //clk signal
	end
	
	
	always begin
	#25
	RESET = 1'b1;
	#12
	RESET = 1'b0;
	#110
	$finish;
	end
endmodule	
