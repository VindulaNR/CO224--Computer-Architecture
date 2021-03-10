//module for programme counter
module pc(CLK,RESET,OUT);
	input CLK,RESET;
	output [31:0] OUT;
	reg [31:0] IN,IN2;
	
	//sete the IN 2 OUT
	assign  OUT=IN2;

	always @(posedge CLK) #1 begin 
		IN2<=IN;
		
		//increment the value
		#2 IN<=IN+32'h00000004;
			
	end
	always @(posedge RESET) #1 begin
		if (RESET)  #2
			IN<=32'h00000000;
			
	end
	//assign  OUT=IN;
endmodule
		
		