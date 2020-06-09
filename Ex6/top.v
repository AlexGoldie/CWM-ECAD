//////////////////////////////////////////////////////////////////////////////////
// Exercise #6 
// Student Name: Alex Goldie
// Date: 9/6/2020
//
//
//  Description: In this exercise, you need to design a multiplexer between a dice and traffic 
//  lights, where the output acts according to the following truth table:
//
//  sel | out
// -----------------
//   0  | dice
//   1  | traffic lights
//
//  inputs:
//           rst, clk, button,sel
//
//  outputs:
//           result[2:0]
//
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module multiplexer(

    //Todo: define inputs here
    input rst,
    input clk,
    input button,
    input sel,
	output wire [2:0] result
    );
	
	wire [2:0] throw;
	wire [2:0] rag;
	
    dice dice_out(clk,rst,button,throw);
	traffic traffic_out(clk,rag[2],rag[1],rag[0]);

	mux choice(sel,clk,throw,rag,result);

	      
endmodule
