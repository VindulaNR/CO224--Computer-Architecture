//module for mux
module sub_mux(IN0,IN1,SELECT,OUT);
	input [7:0] IN0,IN1;
	output [7:0] OUT;
	input SELECT;
	reg [7:0] OUT;
	
	always @(SELECT,IN0,IN1)  
	begin
		if (SELECT==0) begin
			OUT= IN0;
		end if (SELECT==1) begin
			OUT=IN1;
		end
	end
endmodule