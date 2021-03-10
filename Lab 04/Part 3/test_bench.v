`include "cpu.v"
//test bench
module test_bench;
	reg CLK,RESET;
	cpu mycpu(CLK,RESET);
	initial
	begin
		//$monitor($time,"inpt=%b     oypt=%b   seleje=%b",in,result,select);
		$dumpfile("wavedata12.vcd");
		$dumpvars(0, test_bench);
		CLK=1'b1;
		#3
		RESET=1'b1;
		#5
		RESET=1'b0;
		#75
		$finish;
	end
	always
        #5 CLK = ~CLK;				//CLK value
endmodule