//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #3 - Up/Down counter
// Student Name:Alex Goldie
// Date: 8/6/2020
//
// Description: A testbench module to test Ex3 - counter
// Guidance: start with simple tests of the module (how should it react to each 
// control signal?). Don't try to test everything at once - validate one part of 
// the functionality at a time.
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
    );
    
//Todo: Parameters
    parameter CLK_PERIOD = 10;

//Todo: Regitsers and wires
    reg clk;
    reg rst;
    reg direction;
    reg enable;
    reg err;
    wire [7:0] counter_out;
    reg [7:0] counter_out_prev;

//Todo: Clock generation
    initial
    begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=!clk;
end

//Todo: User logic
	initial begin
       err=0;
       direction=1;
	rst = 1;
       clk = 0;
	   enable = 1;
	#10
	rst = 0;
       forever begin
	
       #10

	 if ((direction&(counter_out!=(counter_out_prev+1)))| (!direction&(counter_out!=(counter_out_prev-1))))
        begin
           $display("***TEST FAILED! counter_out==%d, counter_out_prev==%d, direction='%d', enable ='%d' ***",counter_out,counter_out_prev,direction,enable);
           err=1;
         end


if (rst&(counter_out!=0))
         begin
           $display("***TEST FAILED! counter_out==%d, counter_out_prev==%d, reset='%d' ***",counter_out,counter_out_prev,rst);
	err = 1;
		 end


if ((!enable&(counter_out!=counter_out_prev))| (enable&(counter_out==counter_out_prev)))
         begin
           $display("***TEST FAILED! counter_out==%d, counter_out_prev==%d, enable='%d' ***",counter_out,counter_out_prev,enable);
	err = 1;
		 end

	 counter_out_prev=counter_out;
	if (counter_out == 8'b00000001)
         enable = 1;
         if (counter_out==8'b11111111)
           direction=0;
	if ((direction == 0) & (counter_out == 8'b11111100))
		rst = 1;
	if (counter_out == 0)
		rst = 0;
       end
end

//Todo: Finish test, check for success
      initial begin
        #5240 
        if (err==0)
          $display("***TEST PASSED! :) ***");
        $finish;
      end

//Todo: Instantiate counter module
	counter top (
	     .direction (direction),
	     .rst (rst),
	     .enable (enable),
		 .clk (clk),
	     .counter_out (counter_out)
	     );

endmodule 
