//////////////////////////////////////////////////////////////////////////////////
// Exercise #5 
// Student Name: Alex Goldie	
// Date: 9/6/2020
//
//  Description: In this exercise, you need to implement a UK traffic lights 
//  sequencing system. 
//
//  inputs:
//           clk
//
//  outputs:
//           red, amber, green
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module traffic(
    //Todo: define inputs here
    input clk,
    output reg red,
    output reg amber,
    output reg green
    );

    always @(posedge clk) begin
		if (red) begin
			if (!amber) begin
				amber <= 1;
				green <= 0;
			end
			else begin
				red <= 0;
				amber <= 0;
				green <= 1;
			end
		end
		else begin
			if (green) begin
				green <= 0;
				amber <= 1;
				red <= 0;
			end
			else if (amber) begin
				red <= 1;
				amber <= 0;
			end
			else begin
				red <= 1;
				amber <= 0;
				green <= 0;
			end
		end
	end

endmodule

