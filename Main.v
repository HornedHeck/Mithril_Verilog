`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:20:47 05/16/2022 
// Design Name: 
// Module Name:    Main 
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
module Main
#(
	parameter BRAM_COUNT = 32;
	parameter BRAM_NUMBER_SIZE = 5;
	parameter I_SIZE = 3;
);
	 
function [BRAM_ADDRESS_SIZE-1:0] bram_number;
	input [I_SIZE-1:0] i;
	input [BRAM_NUMBER_SIZE-I_SIZE-1:0] j_lower;
	begin
		bram_number[I_SIZE-1:0] = i;
		bram_number[BRAM_NUMBER_SIZE:I_SIZE] = j_lower;
	end

	

endmodule
