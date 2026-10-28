`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:50:32 08/27/2026 
// Design Name: 
// Module Name:    bin_to_gray 
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
module bin_to_gray #(
parameter WIDTH = 4)
(
input wire [WIDTH-1:0] binary,
output wire [WIDTH-1:0] gray 
    );
	 assign gray = binary ^ (binary >> 1);
endmodule
