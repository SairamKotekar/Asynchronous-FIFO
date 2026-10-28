`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:00:23 08/27/2026
// Design Name:   async_fifo
// Module Name:   /home/ise/Asyc_fifo/async_fifo_tb.v
// Project Name:  Asyc_fifo
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: async_fifo
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module async_fifo_tb;
	parameter DATA_WIDTH = 8;
	parameter ADDR_WIDTH = 3;
	// Inputs
	reg wr_clk;
	reg rd_clk;
	
	reg wr_rst_n;
	reg rd_rst_n;
	
	reg wr_en;
	reg rd_en;
	reg [DATA_WIDTH-1:0] data_in;

	// Outputs
	wire [DATA_WIDTH-1:0] data_out;
	wire full;
	wire empty;

	// Instantiate the Unit Under Test (UUT)
	async_fifo #(.DATA_WIDTH(DATA_WIDTH), 
	.ADDR_WIDTH(ADDR_WIDTH))
	dut(
		.wr_clk(wr_clk), 
		.rd_clk(rd_clk), 
		.wr_rst_n(wr_rst_n), 
		.rd_rst_n(rd_rst_n), 
		.wr_en(wr_en), 
		.rd_en(rd_en), 
		.data_in(data_in), 
		.data_out(data_out), 
		.full(full), 
		.empty(empty)
	);

	initial begin
		wr_clk = 0;
		forever #5 wr_clk = ~wr_clk;
	end
		
	initial begin
		rd_clk = 0;
		forever #7 rd_clk = ~rd_clk;
	end
	initial begin
		
		// Initialize Inputs
		wr_rst_n = 0;
		rd_rst_n = 0;
		
		wr_en = 0;
		rd_en = 0;
		data_in = 8'h00;
		
		#30;
		if(empty !== 1'b1)
		$display("ERROR: FIFO should be EMPTY after reset");
		else
		$display("PASS: FIFO EMPTY after reset");

		// Wait 100 ns for global reset to finish
		#20;
		
		wr_rst_n = 1;
		rd_rst_n = 1;
		
		@(negedge wr_clk);
		wr_en = 1;
		data_in = 8'h11;
		
		@(negedge wr_clk);
		data_in = 8'h22;
		
		@(negedge wr_clk);
		data_in = 8'h33;
		
		@(negedge wr_clk);
		data_in = 8'h44;
		
		@(negedge wr_clk);
		data_in = 8'h55;
		
		@(negedge wr_clk);
		data_in = 8'h66;
		
		@(negedge wr_clk);
		data_in = 8'h77;
		
		@(negedge wr_clk);
		data_in = 8'h88;
		
		@(negedge wr_clk);
		data_in = 8'h99;
		
		@(negedge wr_clk);
		wr_en = 0;
		
		//#10;
		wr_en = 0;
		
		#100;
		
		@(negedge rd_clk);
		rd_en = 1;
		
		repeat (15) begin
		@(negedge rd_clk);
		end
		
		//#14;
		//#14;
		//#14;
		//#14;
		//#14;
		//#14;
		//#14;
		
		
		//@(negedge rd_clk);
		//@(negedge rd_clk);
		//@(negedge rd_clk);
		//@(negedge rd_clk);
		//@(negedge rd_clk);
		//@(negedge rd_clk);
		//@(negedge rd_clk);
		//@(negedge rd_clk);
		
		wr_en = 1;
		@(negedge wr_clk); data_in = 8'hA0;
		@(negedge wr_clk); data_in = 8'hA1;
		@(negedge wr_clk); data_in = 8'hA2;
		@(negedge wr_clk); data_in = 8'hA3;
		@(negedge wr_clk); data_in = 8'hA4;
		@(negedge wr_clk); data_in = 8'hA5;
		@(negedge wr_clk); data_in = 8'hA6;
		@(negedge wr_clk); data_in = 8'hA7;
		//@(negedge wr_clk); data_in = 8'hA8;
		//@(negedge wr_clk); data_in = 8'hA9;
		//@(negedge wr_clk); data_in = 8'hAA;
		//@(negedge wr_clk); data_in = 8'hAB;
		//@(negedge wr_clk); data_in = 8'hAC;
		//@(negedge wr_clk); data_in = 8'hAD;
		//@(negedge wr_clk); data_in = 8'hAE;
		//@(negedge wr_clk); data_in = 8'hAF;
		
		wr_en = 0;
		
		repeat (10)
		@(negedge wr_clk);
		
		if(full == 1'b1)
		$display("PASS: FIFO FULL");
		else
		$display("ERROR: FIFO FULL FAILED");
		
		rd_en = 1;
		
		repeat (16)
		@(negedge rd_clk);
		
		rd_en = 0;
		
		repeat (3)
		@(negedge rd_clk);
		
		if(empty == 1'b1)
		$display("PASS: FIFO EMPTY");
		else
		$display("ERROR: FIFO EMPTY FAILED");
		
		
		rd_en = 0;
		
		#50;
		
		$finish;
	end
endmodule

