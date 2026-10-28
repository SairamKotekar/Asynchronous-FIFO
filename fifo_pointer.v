`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:33:46 08/27/2026 
// Design Name: 
// Module Name:    fifo_pointer 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module fifo_pointer #(parameter ADDR_WIDTH = 3)
(	input wire  wr_clk,
	input wire  wr_rst_n,
	input wire  wr_en,
	input wire  full,
	output reg [ADDR_WIDTH:0] wr_ptr_bin,
	output reg [ADDR_WIDTH:0] wr_ptr_gray,
	output reg [ADDR_WIDTH:0] wr_ptr_gray_next
    );
	 
	 reg [ADDR_WIDTH:0] wr_ptr_bin_next;
	 //reg [ADDR_WIDTH:0] wr_ptr_gray_next;
	 
	 always @(*) begin
	 wr_ptr_bin_next = wr_ptr_bin;
	 if(wr_en && !full)
	 wr_ptr_bin_next = wr_ptr_bin + 1'b1;
	 wr_ptr_gray_next = wr_ptr_bin_next ^ (wr_ptr_bin_next >> 1);
	 end
	 
	 always @(posedge wr_clk or negedge wr_rst_n) begin
	 if(!wr_rst_n) begin
	 wr_ptr_bin <= {(ADDR_WIDTH+1){1'b0}};
	 wr_ptr_gray <= {(ADDR_WIDTH+1){1'b0}};
	 end
	 else begin
	 wr_ptr_bin <= wr_ptr_bin_next;
	 wr_ptr_gray <= wr_ptr_gray_next;
	 end
	 end
endmodule
