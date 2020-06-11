//////////////////////////////////////////////////////////////////////////////////
// Extension top
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

module top (
	input clk,
	input [6:0] temp,
	input enable_temp,
	input enable_speed,
	input throttle,
	input brake,
	input rst,
	input [8:0] dist,
	output wire [6:0] fail_prob,
	output wire [8:0] stopping_distance,
	output reg [8:0] speed
	);
	
	//wire [27:0] counter;
	always @(posedge clk) begin
		
		if (rst == 1) begin
			//counter = 0;
			speed = 30;
		end
		else begin
		if (fail_prob > 50) begin
			speed = 0;
			//counter = 0;
		end
		else begin 

			if ((fail_prob > 10)) begin
				speed = speed - 1;
				//counter = 0;
			end
			
			else begin 
			if (throttle == 1) begin
				speed = speed + 1;
				//counter = 0;
			end
		
			else begin
			if ((brake == 1)) begin
				speed = speed - 1;
				//counter = 0
			end
			

			if ((throttle == 0) & (brake == 0)) begin
				if ((dist < stopping_distance)) begin
					speed = speed - 1;
					//counter = 0;
				end
				else if (dist > (stopping_distance + 10)) begin
					speed = speed + 1;
					//counter = 0;
				end
			end
			end
			end
		end
		end
	end

	check check (
	.clk(clk),
	.temp(temp),
	.speed (speed),
	.enable_temp (enable_temp),
	.enable_speed (enable_speed),
	.fail_prob(fail_prob),
	.stopping_distance (stopping_distance)
	);


endmodule
