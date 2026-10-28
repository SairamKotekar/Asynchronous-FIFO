`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:17:28 08/27/2026 
// Design Name: 
// Module Name:    async_fifo 
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
module async_fifo #(parameter DATA_WIDTH = 8, parameter ADDR_WIDTH = 4)
(	input wire   wr_clk,
	input wire   rd_clk,
	input wire   wr_rst_n,
	input wire   rd_rst_n,
	
	input wire   wr_en,
	input wire   rd_en,
	
	input wire [DATA_WIDTH-1:0] data_in,
	output wire [DATA_WIDTH-1:0] data_out,
	
	output wire  full,
	output wire  empty
    );
	 
	 wire[ADDR_WIDTH:0] wr_ptr_bin;
	 wire[ADDR_WIDTH:0] wr_ptr_gray;
	 
	 wire[ADDR_WIDTH:0] rd_ptr_bin;
	 wire[ADDR_WIDTH:0] rd_ptr_gray;
	 
	 wire[ADDR_WIDTH:0] rd_ptr_gray_sync;
	 wire[ADDR_WIDTH:0] wr_ptr_gray_sync;
	 
	 wire[ADDR_WIDTH-1:0] wr_addr;
	 wire[ADDR_WIDTH-1:0] rd_addr;
	 
	 assign wr_addr = wr_ptr_bin[ADDR_WIDTH-1:0];
	 assign rd_addr = rd_ptr_bin[ADDR_WIDTH-1:0];
	 
	 fifo_pointer #(.ADDR_WIDTH(ADDR_WIDTH))
	 write_pointer(
	 .wr_clk(wr_clk),
	 .wr_rst_n(wr_rst_n),
	 .wr_en(wr_en),
	 .full(full),
	 .wr_ptr_bin(wr_ptr_bin),
	 .wr_ptr_gray(wr_ptr_gray),
	 .wr_ptr_gray_next(wr_ptr_gray_next)
	 );
	 
	 fifo_pointer #(.ADDR_WIDTH(ADDR_WIDTH))
	 read_pointer(
	 .wr_clk(rd_clk),
	 .wr_rst_n(rd_rst_n),
	 .wr_en(rd_en),
	 .full(empty),
	 .wr_ptr_bin(rd_ptr_bin),
	 .wr_ptr_gray(rd_ptr_gray),
	 .wr_ptr_gray_next(wr_ptr_gray_next)
	 );
	 
	 cdc_sync #(.WIDTH(ADDR_WIDTH+1))
	 sync_read_ptr(
	 .clk(wr_clk),
	 .rst_n(wr_rst_n),
	 .async_in(rd_ptr_gray),
	 .sync_out(rd_ptr_gray_sync)
	 );
	 
	 cdc_sync #(.WIDTH(ADDR_WIDTH+1))
	 sync_write_ptr(
	 .clk(rd_clk),
	 .rst_n(rd_rst_n),
	 .async_in(wr_ptr_gray),
	 .sync_out(wr_ptr_gray_sync)
	 );
	 
	 assign empty = (rd_ptr_gray == wr_ptr_gray_sync);
	 
	 assign full = (wr_ptr_gray_next == {~rd_ptr_gray_sync[ADDR_WIDTH: ADDR_WIDTH-1],
	 rd_ptr_gray_sync[ADDR_WIDTH-2:0]});
	 
	 
	 
	 fifo_memory #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH))
	 memory (
	 .wr_clk(wr_clk),
	 .rd_clk(rd_clk),
	 .wr_en(wr_en && !full),
	 .rd_en(rd_en && !empty),
	 .wr_addr(wr_addr),
	 .rd_addr(rd_addr),
	 .data_in(data_in),
	 .data_out(data_out)
	 );
endmodule
