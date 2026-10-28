`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:25:22 08/27/2026 
// Design Name: 
// Module Name:    fifo_memory 
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
module fifo_memory #(parameter DATA_WIDTH = 8,
parameter ADDR_WIDTH = 4)
(	input wire   wr_clk,
	input wire   rd_clk,
	input wire   wr_en,
	input wire   rd_en,
	input wire   [ADDR_WIDTH-1:0] wr_addr,
	input wire   [ADDR_WIDTH-1:0] rd_addr,
	input wire   [DATA_WIDTH-1:0] data_in,
	output reg   [DATA_WIDTH-1:0] data_out
    );
	 
	 reg[DATA_WIDTH-1:0] mem[0:(1<<ADDR_WIDTH)-1];
	 
	 always @(posedge wr_clk) begin
	 if(wr_en)
	 mem[wr_addr] <= data_in;
	 end
	 
	 always @(posedge rd_clk) begin
	 if(rd_en)
	 data_out <= mem[rd_addr];
	 end


endmodule
