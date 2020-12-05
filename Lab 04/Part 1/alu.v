
module alu(DATA1, DATA2, RESULT,SELECT);			//ALU
	input [0:7]DATA1;
	input [0:7]DATA2;
	input [0:2]SELECT;						//inputs
	output [0:7]RESULT;						//out put result

	reg [0:7]RESULT;
	always @ (DATA1,DATA2,SELECT)			//done it whe there is a change in values
	begin
		if (SELECT==3'b000) begin			//for the forward
		//for the FOWARD function
			RESULT= DATA2;

		end if (SELECT==3'b001) begin
		//for the ADD and SUB function
			RESULT=DATA1+DATA2;

		end if (SELECT==3'b010) begin
		//for the AND function
			RESULT= DATA1 & DATA2;

		end if(SELECT==3'b011) begin
		//for the OR function
			RESULT=DATA1 | DATA2;

		end 
	end
endmodule
