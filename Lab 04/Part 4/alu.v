module alu(DATA1,DATA2,SELECT,RESULT,ZERO);
	//port declaration 
	//create 2  8 bit input
	input [7:0] DATA1 , DATA2;
	//create a 3bit input
	input [2:0] SELECT;
	//create a 8 bit output reg for hold the result
	output reg [7:0] RESULT;
	output reg ZERO;  //for branch purpose
	
	
	always @ (DATA1,DATA2,SELECT) //sensivity for data1 ,data2 and select ports
	begin
		casex (SELECT)
			3'b000 : #1 RESULT = DATA2;               //forward
 			3'b001 : #2 RESULT = DATA1 + DATA2;   //add data
			3'b010 : #1 RESULT = DATA1 & DATA2;  //bitwise and opration
			3'b011 : #1 RESULT = DATA1 | DATA2;   //bitwise or opration
			3'b1xx :    RESULT = 8'b00000000;        //reserved
		endcase
		
	end
	always @ (DATA1,DATA2,SELECT) begin
	#2
		if(DATA1-DATA2 == 0) begin
			ZERO = 1'b1;
		end
		else begin
			ZERO =1'b0;
		end
		
		
		
	end
	
endmodule 

