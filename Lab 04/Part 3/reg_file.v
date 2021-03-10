
//module for reg file
module reg_file
  (input clk,
   input reset,
   input write,
   input [2:0] writeAddr,
   input [7:0] writeData,
   input [2:0] readAddrA,
   output [7:0] readDataA,
   input [2:0] readAddrB,
   output [7:0] readDataB);

   //give reg file 8 bit reg
   reg [7:0] 	 regfile [0:7];

   //assigning the data with the 2 time delay
   assign #2 readDataA = regfile[readAddrA];
   assign #2 readDataB = regfile[readAddrB];
   

   always @(posedge clk)  begin    		
       
	 if (write) #2 regfile[writeAddr] <= writeData ;		//erite data in to reg file
      // else: !if(reset)
	end
   always @(posedge reset)  begin				//reset with the delay
	 regfile[0] <= 0;
	 regfile[1] <= 0;
	 regfile[2] <= 0;
	 regfile[3] <= 0;
	 regfile[4] <= 0;
	 regfile[5] <= 0;
	 regfile[6] <= 0;
	 regfile[7] <= 0;
    end
endmodule
