//////////////////////////////////////////////////////////////////////////////////
// Exercise #2 
// Student Name: Alex Goldie
// Date: 8/6/2020
//
//  Description: In this exercise, you need to design a multiplexer, where the  
//  output acts according to the following truth table:
//
//  sel | out
// -----------------
//   0  | a
//   1  | b
//
//  inputs:
//           a, b, sel
//
//  outputs:
//           out
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module mux(
    //Todo: define inputs here
    input sel,
    input a,
    input b,
    output out
    );

    

    //Todo: define registers and wires here
    reg out_out;
    reg clk;

    parameter CLK_PERIOD = 10; //set the clock period
        initial begin
           clk = 1'b0;
	   forever
               #(CLK_PERIOD/2) clk=!clk; //happens every delay of CLK_PERIOD/2
	end

    assign out = out_out;

    //Todo: define your logic here                 
    always @ (posedge clk) begin
	out_out = (sel && b) || (!sel && a);
    end
	
      
endmodule
