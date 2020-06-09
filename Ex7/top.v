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
	output reg [5:0] result
	);

always @ (posedge clk) begin
	result <= enable ? (a * b) : 0;
end

mybram ipinstance (
  .clka(clka),    // input wire clka
  .ena(ena),      // input wire ena
  .wea(wea),      // input wire [0 : 0] wea
  .addra(addra),  // input wire [3 : 0] addra
  .dina(dina),    // input wire [15 : 0] dina
  .douta(douta)  // output wire [15 : 0] douta
);

endmodule
