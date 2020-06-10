//////////////////////////////////////////////////////////////////////////////////
// Exercise #8
// Student Name: Alex Goldie
// Date: 10/6/2020
//
//  Description: In this exercise, you need to implement a times table of 0..7x0..7
//  using a memory and AXI-4-lite interface.
//
//  inputs:
//           clk, rst, a[2:0], b[2:0], read
//
//  outputs:
//           result[5:0]
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module times_table (
	input clk,
	input [2:0] a,
	input [2:0] b,
	input enable,
	input rst,
	output wire [5:0] result
	);

	wire [32:0] addr;
	wire awready;
	wire rsta_busy;
	wire rstb_busy;
	wire wready;
	wire [1:0] bresp;
	wire bvalid;
	wire arready;
	wire rvalid;
	wire s_axi_rresp;
	
	
	assign addr = {24'd0,a,b,2'd0};

blk_mem_gen_0 Axi4_multiply (
  .rsta_busy(rsta_busy),          // output wire rsta_busy
  .rstb_busy(rstb_busy),          // output wire rstb_busy
  .s_aclk(clk),                // input wire s_aclk
  .s_aresetn(rst),          // input wire s_aresetn
  .s_axi_awaddr(0),    // input wire [31 : 0] s_axi_awaddr
  .s_axi_awvalid(0),  // input wire s_axi_awvalid
  .s_axi_awready(awready),  // output wire s_axi_awready
  .s_axi_wdata(0),      // input wire [31 : 0] s_axi_wdata
  .s_axi_wstrb(0),      // input wire [3 : 0] s_axi_wstrb
  .s_axi_wvalid(0),    // input wire s_axi_wvalid
  .s_axi_wready(wready),    // output wire s_axi_wready
  .s_axi_bresp(bresp),      // output wire [1 : 0] s_axi_bresp
  .s_axi_bvalid(bvalid),    // output wire s_axi_bvalid
  .s_axi_bready(0),    // input wire s_axi_bready
  .s_axi_araddr(addr),    // input wire [31 : 0] s_axi_araddr
  .s_axi_arvalid(1),  // input wire s_axi_arvalid
  .s_axi_arready(arready),  // output wire s_axi_arready
  .s_axi_rdata(result),      // output wire [31 : 0] s_axi_rdata
  .s_axi_rresp(s_axi_rresp),      // output wire [1 : 0] s_axi_rresp
  .s_axi_rvalid(rvalid),    // output wire s_axi_rvalid
  .s_axi_rready(enable)    // input wire s_axi_rready
);

endmodule
