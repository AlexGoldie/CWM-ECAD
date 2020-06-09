//////////////////////////////////////////////////////////////////////////////////
// Exercise #2 
// Student Name: Alex Goldie
// Date: 9/6/2020
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
	input clk,
    input [2:0] a,
    input [2:0] b,
    output reg [2:0] out
    );

 
    //Todo: define your logic here                 
    always @ (posedge clk) begin
	out = sel ? b : a;
    end
	
      
endmodule
