`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:19:22 05/16/2022 
// Design Name: 
// Module Name:    Float_comparator 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: IEEE 754 float comparator with only a > b operation
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Float_comparator
#(
	parameter E_SIZE = 8,
	parameter C_SIZE = 23,
	parameter [31:0] b = 0
)(
	input clock,
	input [C_SIZE+E_SIZE:0] a,
	output reg is_higher
);
	
	always @ (posedge clock)
	begin
		if (a[C_SIZE+E_SIZE] != b[C_SIZE+E_SIZE]) begin
			is_higher <= a[C_SIZE+E_SIZE] < b[C_SIZE+E_SIZE];
		end else if (a[C_SIZE+E_SIZE-2:C_SIZE-1] != b[C_SIZE+E_SIZE-2:C_SIZE-1]) begin
			is_higher <= a[C_SIZE+E_SIZE-2:C_SIZE-1] > b[C_SIZE+E_SIZE-2:C_SIZE-1];
		end else begin
			is_higher <= a[C_SIZE-1:0] > b[C_SIZE-1:0];
		end
	end

endmodule
