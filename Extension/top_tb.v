//////////////////////////////////////////////////////////////////////////////////
// Test bench for Extension
// Student Name:Alex Goldie
// Date: 11/6/2020
//
// Description: 
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
    );
    
//Todo: Parameters
    parameter CLK_PERIOD = 50;

//Todo: Regitsers and wires
    reg clk;
	reg [6:0] temp;
	wire [6:0] speed;
	reg enable_temp;
	reg enable_speed;
	reg [2:0] throttle;
	reg [3:0] brake;
	wire [6:0] fail_prob;
	wire [8:0] stopping_distance;
	reg [6:0] fail_prob_prev;
	reg [8:0] stopping_dist_prev;
	reg [8:0] dist;
	reg [6:0] speed_prev;
	reg [1:0] x_co_ord;
	reg [1:0] y_co_ord;
	wire [6:0] speed_lim;
	reg err;
	reg rst;
	reg [6:0] speed_lim_prev;

//Todo: Clock generation
    initial
    begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=!clk;
	end

//Todo: User logic
initial begin
	clk = 0;
	temp = 0;
	rst = 1;
	enable_temp = 1;
	enable_speed = 1;
	dist = 0;
	err = 0;
	x_co_ord = 0;
	y_co_ord = 0;
	#150

	fail_prob_prev = fail_prob;
	stopping_dist_prev = stopping_distance;
	speed_prev = speed;
	rst = 0;
	#30
forever begin
	#50
	
	if ((rst == 1) & (speed != speed_lim - 10))
		begin
		
           $display("***TEST FAILED! reset didnt work! reset==%d, speed==%d, stopping distance ==%d, fail_prob ==%d***", rst, speed, stopping_distance, fail_prob);
           err=1;
		end

	if ((rst == 0) & (dist < stopping_dist_prev) & (!((speed == speed_prev - 1) | (speed == 0))) & (fail_prob_prev < 10) & (throttle == 0) & (brake == 0))
		begin
		
           $display("***TEST FAILED! distance didnt work! dist==%d, stopping dist prev==%d, speed ==%d, speed_prev==%d***", dist, stopping_dist_prev, speed, speed_prev);
           err=1;
		end
		
	if ((rst == 0) & (dist >= stopping_dist_prev) & (!((speed == speed_prev - 1) | (speed == 0))) & (fail_prob_prev > 10) & (fail_prob_prev < 50) & (throttle == 0) & (brake == 0))
		begin
		
           $display("***TEST FAILED! fail prob didnt work! prob_fail_prev==%d, speed ==%d, speed_prev==%d***", fail_prob_prev, speed, speed_prev);
           err=1;
		end
			

	if ((rst == 0) & (dist >= stopping_dist_prev) & (!((speed == speed_prev - 1) | (speed == 0))) & (fail_prob_prev < 10) & (throttle == 0) & (brake == 1))
		begin
		
           $display("***TEST FAILED! brake didnt work! brake==%d, speed ==%d, speed_prev==%d***", brake, speed, speed_prev);
           err=1;
		end
		
			
	if ((rst == 0) & (dist >= stopping_dist_prev) & (!((speed == speed_prev + 1) | (speed == speed_lim_prev))) & (fail_prob_prev < 10) & (throttle == 1) & (brake == 0))
		begin
		
           $display("***TEST FAILED! throttle didnt work! throttle==%d, speed ==%d, speed_prev==%d***", throttle, speed, speed_prev);
           err=1;
		end

	if ((rst == 0) & (dist > (stopping_dist_prev +10)) & (!((speed == speed_prev + 1) | (speed == speed_lim_prev))) & (fail_prob_prev < 10) & (throttle == 0) & (brake == 0))
		begin
		
           $display("***TEST FAILED! stopping distance didnt work! dist==%d, stopping_distance_prev == %d, speed ==%d, speed_prev==%d***, speed_lim_prev == %d", dist, stopping_dist_prev, speed, speed_prev,speed_lim_prev);
           err=1;
		end

	if ((rst == 0) & (speed != 0) & (fail_prob_prev > 50))
		begin
		
           $display("***TEST FAILED! fail_prob didnt work! fail_prob==%d, speed ==%d, speed_prev==%d***", fail_prob, speed, speed_prev);
           err=1;
		end

	dist = dist + 20;


	fail_prob_prev = fail_prob;
	stopping_dist_prev = stopping_distance;
	speed_prev = speed;
	speed_lim_prev = speed_lim;
end
end

initial begin
#50
forever begin
#2200
dist = 0;
temp = temp + 5;
x_co_ord = x_co_ord + 1;
end
end

initial begin
forever begin
#500
throttle = 1;
#100
throttle = 0;
#500
brake = 1;
#100
brake = 0;
end
end



//Todo: Finish test, check for success
      initial begin
        #39950 
        if (err==0)
          $display("***TEST PASSED! :) ***");
        $finish;
      end

//Todo: Instantiate modules
	top top (
	     .clk (clk),
	     .enable_temp (enable_temp),
	     .enable_speed (enable_speed),
	     .speed (speed),
		 .temp (temp),
		 .x_co_ord (x_co_ord),
		 .y_co_ord (y_co_ord),
		 .throttle (throttle),
		 .brake (brake),
		 .rst (rst),
		 .dist (dist),
	     .fail_prob (fail_prob),
		 .stopping_distance (stopping_distance)
	     );

	speed_limit_mem check_lim (
  	.clka(clk),    // input wire clka
  	.ena(1),      // input wire ena
  	.wea(0),      // input wire [0 : 0] wea
  	.addra({y_co_ord,x_co_ord}),  // input wire [3 : 0] addra
  	.dina(0),    // input wire [6 : 0] dina
  	.douta(speed_lim)  // output wire [6 : 0] douta
	);

	/*check check (
	.clk (clk),
	.temp (temp),
	.speed (speed),
	.enable_temp (enable_temp),
	.enable_speed (enable_speed),
	.fail_prob (fail_prob),
	.stopping_distance (stopping_distance)
	);*/

endmodule 
