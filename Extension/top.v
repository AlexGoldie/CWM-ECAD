//////////////////////////////////////////////////////////////////////////////////
// Extension top
// Student Name: Alex Goldie
// Date: 11/6/2020
//
//  Runs all checks of safety and then adjusts speed accordingly
//
//  inputs:
//           clk, temp[6:0], enable_temp, speed[6:0], enable_speed, rst, dist [8:0],
//			 throttle, brake
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
	input [2:0] throttle,
	input [3:0] brake,
	input rst,
	input [8:0] dist,
	input [1:0] x_co_ord,
	input [1:0] y_co_ord,
	output wire [6:0] fail_prob,
	output wire [8:0] stopping_distance,
	output reg [6:0] speed
	);
	
	wire [6:0] speed_lim;
	always @(posedge clk) begin
		
		if (rst == 1)
			speed = speed_lim-10;
		
		else begin

		if (fail_prob > 50) 
			speed = 0;

		else begin 

			if (fail_prob > 10)
				speed = (speed == 0) ? 0 : speed - 1;
			
			else begin 

			if (brake != 0)
				speed = (speed >= brake) ? speed - brake : 0;
		
			else begin

			if (throttle != 0)
				speed = (speed + throttle > speed_lim) ? speed_lim : speed + throttle;
						
			else begin

				if (dist < stopping_distance) begin
					if (speed == 0)
						speed = 0;
					else
						speed = speed - 1;
				end
				

				else if (dist > (stopping_distance + 10)) begin
					if (speed + 1 > speed_lim)
						speed = speed_lim;
					else
						speed = speed + 1;
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

	speed_limit_mem check_speed_lim (
  	.clka(clk),    // input wire clka
  	.ena(1),      // input wire ena
  	.wea(0),      // input wire [0 : 0] wea
  	.addra({y_co_ord,x_co_ord}),  // input wire [3 : 0] addra
 	.dina(0),    // input wire [6 : 0] dina
 	.douta(speed_lim)  // output wire [6 : 0] douta
);

/*speed_uartlite your_instance_name (
  .s_axi_aclk(s_axi_aclk),        // input wire s_axi_aclk
  .s_axi_aresetn(s_axi_aresetn),  // input wire s_axi_aresetn
  .interrupt(interrupt),          // output wire interrupt
  .s_axi_awaddr(s_axi_awaddr),    // input wire [3 : 0] s_axi_awaddr
  .s_axi_awvalid(s_axi_awvalid),  // input wire s_axi_awvalid
  .s_axi_awready(s_axi_awready),  // output wire s_axi_awready
  .s_axi_wdata(s_axi_wdata),      // input wire [31 : 0] s_axi_wdata
  .s_axi_wstrb(s_axi_wstrb),      // input wire [3 : 0] s_axi_wstrb
  .s_axi_wvalid(s_axi_wvalid),    // input wire s_axi_wvalid
  .s_axi_wready(s_axi_wready),    // output wire s_axi_wready
  .s_axi_bresp(s_axi_bresp),      // output wire [1 : 0] s_axi_bresp
  .s_axi_bvalid(s_axi_bvalid),    // output wire s_axi_bvalid
  .s_axi_bready(s_axi_bready),    // input wire s_axi_bready
  .s_axi_araddr(s_axi_araddr),    // input wire [3 : 0] s_axi_araddr
  .s_axi_arvalid(s_axi_arvalid),  // input wire s_axi_arvalid
  .s_axi_arready(s_axi_arready),  // output wire s_axi_arready
  .s_axi_rdata(s_axi_rdata),      // output wire [31 : 0] s_axi_rdata
  .s_axi_rresp(s_axi_rresp),      // output wire [1 : 0] s_axi_rresp
  .s_axi_rvalid(s_axi_rvalid),    // output wire s_axi_rvalid
  .s_axi_rready(s_axi_rready),    // input wire s_axi_rready
  .rx(rx),                        // input wire rx
  .tx(tx)                        // output wire tx
);*/

endmodule
