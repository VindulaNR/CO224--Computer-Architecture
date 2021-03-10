//module for converting 2s complement
module complement(IN,OUT);
	input [7:0] IN;
	output [7:0] OUT;
	reg [7:0] OUT;
	integer i;
	always @(IN)
	begin
		//invert all bits
		for (i=0;i<8;i=i+1) begin
			if (IN[i]==0) begin
				OUT[i]=1;
			end if (IN[i]==1) begin
				OUT[i]=0;
			end
		end
		//adding binary one for final value
		OUT=OUT+8'b00000001;
	end
	
endmodule
	
