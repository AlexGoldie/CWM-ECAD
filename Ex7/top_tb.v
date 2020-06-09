//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #7 - Times Table
// Student Name:Alex Goldie
// Date: 9/6/2020
//
// Description: A testbench module to test Ex7 - Times Table
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module top_tb(
    );
    
    //Parameters
    parameter CLK_PERIOD = 10;

    //Registers and wires
    reg clk;
	reg [2:0] a;
	reg [2:0] b;
	reg enable;
	wire [5:0] result;
	reg err;

    //Clock generation
    initial
    begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=!clk;
     end
    
 //Todo: User logic
	initial begin
       	err=0; 
		enable = 1;
		a = 0;
		b = 1;

       forever begin
       #10
		if ((enable == 0) & (result != 0) & (a!=0) & (b!=0))
		begin
		
           $display("***TEST FAILED! Enable didnt work! enable==%d, result==%d***", enable, result);
           err=1;
		end
		
		if ((enable == 1) & (result != a * b))
		begin
		
           $display("***TEST FAILED! Multiply incorrect! result==%d, a==%d, b==%d***", result,a, b);
           err=1;
		end

		enable = !enable;
		a = a+1;
		b = b+1;

end
end


//Todo: Finish test, check for success
      initial begin
        #60
        if (err==0)
          $display("***TEST PASSED! :) ***");
        $finish;
      end


    //User's module
    times_table top (
	.clk (clk),
	.enable (enable),
	.a (a),
	.b (b),
	.result (result)
     );
     
endmodule 
