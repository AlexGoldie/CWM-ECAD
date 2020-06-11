//////////////////////////////////////////////////////////////////////////////////
// Extension check
// Student Name: Alex Goldie
// Date: 11/6/2020
//
//  Runs all checks of safety
//
//  inputs:
//           clk, temp[6:0], enable_temp, speed[6:0], enable_speed
//
//  outputs:
//           fail_prob[6:0], stopping_distance [6:0]
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module check (
	input clk,
	input [6:0] temp,
	input [6:0] speed,
	input enable_temp,
	input enable_speed,
	output wire [6:0] fail_prob,
	output wire [8:0] stopping_distance
	);

	fail_prob fail_prob_out(
	.clk (clk),
	.temp (temp),
	.enable_temp (enable_temp),
	.fail_prob (fail_prob)
	);

	stopping_distance stopping_distance_out(
	.clk (clk),
	.speed (speed),
	.enable_speed (enable_speed),
	.stopping_distance (stopping_distance)
	);

endmodule
