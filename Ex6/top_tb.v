//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #6 - Dice or Traffic Lights?
// Student Name: Alex Goldie
// Date: 9/6/2020
//
// Description: A testbench module to test Ex6 - Dice or Traffic Lights?
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
    );
    
    //Parameters
    parameter CLK_PERIOD = 10;

    //Registers and wires
    reg clk;
	reg sel;
	reg rst;
    wire [2:0] rag;
	wire [2:0] throw;
	wire [2:0] result;
    reg err;
	reg button;

    //Clock generation
    initial
    begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=~clk;
     end
    
 //Todo: User logic
	initial begin
       	err=0; 
		rst = 0;
		sel = 0;
		button = 1;
		#10
    	clk = 0;
       forever begin
       #10
		if ((sel == 0) & (result != throw))
		begin
		
           $display("***TEST FAILED! Should have shown throw! sel==%d, throw==%d, result==%d***", sel,throw, result);
           err=1;
		end
		
		if ((sel == 1) & (result != rag))
		begin
		
           $display("***TEST FAILED! Should have shown rag! sel==%d, rag==%d, result==%d***", sel,rag, result);
           err=1;
		end
		
		sel = !sel;
end
end

//Todo: Finish test, check for success
      initial begin
        #300 
        if (err==0)
          $display("***TEST PASSED! :) ***");
        $finish;
      end


    //User's module
    multiplexer top (
	.rst (rst),
	.clk (clk),
	.button (button),
	.sel (sel),
	.result (result)
     );
	
    dice dice(clk,rst,button,throw);
	traffic traffic(clk,rag[2],rag[1],rag[0]);
     
endmodule 
