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
       
       counter_out_prev=counter_out;
       err=0;
       direction=1;
	   rst = 0;
       clk = 0;
	   enable = 1;
       #6
       forever begin
         #(CLK_PERIOD-6)
	 if (counter_out != counter_out_prev)
         begin
           $display("***TEST FAILED! did not maintain 5 ticks gap! counter=%d, counter_prev=%d ***",counter_out, counter_out_prev);
           err=1;
         end
         #6
	 if ((direction&(counter_out!=(counter_out_prev+1)))| (!direction&(counter_out!=(counter_out_prev-1))))
        begin
           $display("***TEST FAILED! counter_out==%d, counter_out_prev==%d, direction='%d' ***",counter_out,counter_out_prev,direction);
           err=1;
         end
if (rst&(counter_out!=0))
         begin
           $display("***TEST FAILED! counter_out==%d, counter_out_prev==%d, reset='%d' ***",counter_out,counter_out_prev,rst);
		 end
if ((!enable&(counter_out!=counter_out_prev))| (enable&(counter_out==counter_out_prev)))
         begin
           $display("***TEST FAILED! counter_out==%d, counter_out_prev==%d, enable='%d' ***",counter_out,counter_out_prev,enable);
		 end
	 counter_out_prev=counter_out;
		if (counter_out == 8'b00000001)
         enable = !enable;
         if (counter_out==8'b11111111)
           direction=!direction;
		if ((direction == 0) & (counter_out == 8'b11111100))
			rst = !rst;
       end
	end

//Todo: Finish test, check for success
      initial begin
        #2620 
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
