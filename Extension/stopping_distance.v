//////////////////////////////////////////////////////////////////////////////////
// stopping_Distance module
// Student Name: Alex Goldie
// Date: 9/6/2020
//
//  Calls on ip stopping_distance_mem to check stopping distance at current speed
//
//  inputs:
//           clk, speed[6:0], enable
//
//  outputs:
//           stopping_distance[6:0]
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module stopping_distance (
	input clk,
	input [6:0] speed,
	input enable_speed,
	output wire [8:0] stopping_distance
	);


stopping_distance_mem check_stopping_distance (
  .clka(clk),    // input wire clka
  .ena(enable_speed),      // input wire ena
  .wea(0),      // input wire [0 : 0] wea
  .addra(speed),  // input wire [6 : 0] addra
  .dina(0),    // input wire [8 : 0] dina
  .douta(stopping_distance)  // output wire [8 : 0] douta
);

endmodule
