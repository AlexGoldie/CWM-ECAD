//////////////////////////////////////////////////////////////////////////////////
// Exercise #7
// Student Name: Alex Goldie
// Date: 9/6/2020
//
//  Description: In this exercise, you need to implement a times table of 0..7x0..7
//  using a memory.
//
//  inputs:
//           clk, a[2:0], b[2:0], read
//
//  outputs:
//           result[4:0]
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module times_table (
	input clk,
	input [2:0] a,
	input [2:0] b,
	input enable,
	output wire [5:0] result
	);


multiply_bram multiply_ip (
  .clka(clk),    // input wire clka
  .ena(enable),      // input wire ena
  .wea(0),      // input wire [0 : 0] wea
  .addra({a,b}),  // input wire [5 : 0] addra
  .dina(0),    // input wire [5 : 0] dina
  .douta(result)  // output wire [5 : 0] douta
);

endmodule
