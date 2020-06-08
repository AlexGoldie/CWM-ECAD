//////////////////////////////////////////////////////////////////////////////////
// Exercise #3 
// Student Name: Alex Goldie
// Date: 8/6/2020
//
//  Description: In this exercise, you need to design an up / down counter, where 
//  if the rst=1, the counter should be set to zero. If enable=0, the value
//  should stay constant. If direction=1, the counter should count up every
//  clock cycle, otherwise it should count down.
//  Wrap-around values are allowed.
//
//  inputs:
//           clk, rst, enable, direction
//
//  outputs:
//           counter_out[7:0]
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module counter(
    //Todo: add ports 
	input rst,
	input enable,
	input direction,
	input clk,
	output [7:0] counter_out
    );
                    
    //Todo: add registers and wires, if needed
	reg count;
	reg counter;

    //Todo: add user logic
	always @ (posedge clk) begin
		if (rst) begin
			counter <= 0;
		end
		else begin
			assign count = direction * 2 -1;
			counter <= counter + (count && enable);
		end

	end

	assign counter_out = counter;

      
endmodule
