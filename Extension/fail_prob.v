//////////////////////////////////////////////////////////////////////////////////
// Temp_fail module
// Student Name: Alex Goldie
// Date: 9/6/2020
//
//  Calls on ip Temp_fail_mem to check probabiliy of failure
//
//  inputs:
//           clk, temp[6:0], enable
//
//  outputs:
//           fail_prob[6:0]
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module fail_prob (
	input clk,
	input [6:0] temp,
	input enable_temp,
	output wire [6:0] fail_prob
	);


fail_prob_mem check_fail (
  .clka(clk),    // input wire clka
  .ena(enable_temp),      // input wire ena
  .wea(0),      // input wire [0 : 0] wea
  .addra(temp),  // input wire [6 : 0] addra
  .dina(0),    // input wire [6 : 0] dina
  .douta(fail_prob)  // output wire [6 : 0] douta
);

endmodule
