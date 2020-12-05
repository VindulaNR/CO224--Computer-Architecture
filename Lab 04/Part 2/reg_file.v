// Computer Architecture (CO224) - Lab 05 part 2
//e16319 Ratnayake R.P.V.N

//test bench for the register file
module reg_file_tb;
    
    reg [7:0] WRITEDATA;
    reg [2:0] WRITEREG, READREG1, READREG2;
    reg CLK, RESET, WRITEENABLE; 
    wire [7:0] REGOUT1, REGOUT2;
    
    reg_file myregfile(CLK,RESET,WRITEENABLE,WRITEREG,WRITEDATA,READREG1,REGOUT1,READREG2,REGOUT2);
       
    initial
    begin
        CLK = 1'b1;
        
        // generate files needed to plot the waveform using GTKWave
        $dumpfile("reg_file_wavedata.vcd");
		$dumpvars(0, reg_file);
        
        // assign values with time to input signals to see output 
        RESET = 1'b0;
        WRITEENABLE = 1'b0;
        
        #1
        RESET = 1'b1;
        READREG1 = 3'd0;
        READREG2 = 3'd4;
        
        #8
        RESET = 1'b0;
        
        #5
        WRITEREG = 3'd3;
        WRITEDATA = 8'd35;
        WRITEENABLE = 1'b1;
        
        #10
        WRITEENABLE = 1'b0;
        
        #1
        READREG1 = 3'd3;
        
        #9
        WRITEREG = 3'd1;
        WRITEDATA = 8'd53;

        WRITEENABLE = 1'b1;
        READREG1 = 3'd1;
        
        #10
        WRITEENABLE = 1'b0;
        
        #10
        WRITEREG = 3'd4;
        WRITEDATA = 8'd98;
        WRITEENABLE = 1'b1;
        
        #10
        WRITEDATA = 8'd15;
        WRITEENABLE = 1'b1;
        
        #10
        WRITEENABLE = 1'b0;
        
        #6
        WRITEREG = 3'd1;
        WRITEDATA = 8'd50;
        WRITEENABLE = 1'b1;
        
        #5
        WRITEENABLE = 1'b0;

        #8
        WRITEREG = 3'd3;
        WRITEDATA = 8'd36;
        WRITEENABLE = 1'b1;
        
        #5
        WRITEENABLE = 1'b0;

        #1
        READREG1 = 3'd3;
        READREG2 = 3'd7;

        #5
        WRITEREG = 3'd7;
        WRITEDATA = 8'd24;
        WRITEENABLE = 1'b1;

        #10
        WRITEENABLE = 1'b0;

        #10
        $finish;
    end
    
    
    // clock signal generation
    always
        #5 CLK = ~CLK;

    always @ (WRITEREG,CLK)
    	#5 ;

endmodule

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

   always @(posedge clk) #2 begin    		
      if (reset) #1 begin				//reset with the delay
	 regfile[0] <= 0;
	 regfile[1] <= 0;
	 regfile[2] <= 0;
	 regfile[3] <= 0;
	 regfile[4] <= 0;
	 regfile[5] <= 0;
	 regfile[6] <= 0;
	 regfile[7] <= 0;
      end else  begin 
	 if  (write) regfile[writeAddr] <= writeData ;		//erite data in to reg file
      end // else: !if(reset)
   end
endmodule
