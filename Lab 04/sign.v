//sign extention
module sign(SIGNIN,SIGNOUT);
//port declaration
input [7:0] SIGNIN;
output reg [31:0] SIGNOUT;
reg [6:0] SIGNHOLD;

always @(SIGNIN) begin 
	if(SIGNIN[7]==1'b0) begin   //for positive in
		SIGNOUT = {24'b00000000_00000000_00000000,SIGNIN};
	end
	if (SIGNIN[7]== 1'b1) begin  //for negative in
		//SIGNIN[6:0] =~SIGNIN[6:0];
		SIGNHOLD = SIGNIN[6:0] ;
		
		SIGNOUT = {1'b1,24'b11111111_11111111_11111111,SIGNHOLD[6:0]};
		
		
	end
	SIGNOUT   = SIGNOUT <<< 2;  //shift left by two
end

endmodule


//adder module
module adder(D1,D2,OUT);
//port declaration
	input [31:0] D1,D2;
	output reg [31:0] OUT;


always @ (D1,D2) begin
	#2  //delay to sync with ALU
	#2  //delay for the adder
	OUT = D1 + D2;	
end	
endmodule



//and module
module and_gate(ANDIN1,ANDIN2,ANDOUT);
//port declaration
	input  ANDIN1,ANDIN2;
	output reg ANDOUT;


always @ (ANDIN1,ANDIN2) begin
	if(ANDIN1 == 1'b1 && ANDIN2 == 1'b1) begin
		ANDOUT = 1'b1;
	end	
	
	else begin
		ANDOUT = 1'b0;
	end
	
	
end
		
endmodule



























/*module sign_test;
	reg [7:0] in;

	//declaring output
	wire reg[31:0] out;
	

	//cteate alumodel for testing
	sign sign1(in,out);
	
	initial
	begin
		//generate files need to plot waveform using GTKWave
		$dumpfile("wavedata_cpu.vcd");
		$dumpvars(0,sign_test);
	end
	
	initial
	begin  
		//testing the forward answer 0100 0100
		
		
		
		in = 8'b00011100;
		#10
		in = 8'b11111111;
		#10
		in = 8'b00000001;
		#10
		in = 8'b11001110;
		#20;
		
		
		
		end
		
endmodule	*/	