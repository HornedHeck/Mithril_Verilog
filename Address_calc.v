`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:33:14 05/16/2022 
// Design Name: 
// Module Name:    Address_calc 
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
module Address_calc#(
	parameter BRAM_NUMBER_SIZE = 5,
	parameter BRAM_ADDRESS_SIZE = 8,
	parameter I_SIZE = 0,
	parameter J_SIZE = 9,
	parameter X_SIZE = 3,
	parameter DTYPE_BYTES_SIZE = 1
)(
	input clock,
	input [J_SIZE-1:0] j,
	input [I_SIZE-1:0] i,
	input [X_SIZE-1:0] x_enc,
	output reg [BRAM_NUMBER_SIZE-1:0] bram_number,
	output reg [BRAM_ADDRESS_SIZE-1:0] bram_address

);
	
	parameter USED_J_BITS = BRAM_ADDRESS_SIZE - X_SIZE;
	 
	always @(i or j or x_enc)
	begin
	if(I_SIZE > 0) begin
		bram_number[I_SIZE-1:0] <= i;
		bram_number[BRAM_NUMBER_SIZE-1:I_SIZE] <= j[BRAM_NUMBER_SIZE-I_SIZE-1:0];
	end else begin
		bram_number <= j[BRAM_NUMBER_SIZE-1:0];
	end
	
	bram_address[BRAM_ADDRESS_SIZE-1-:USED_J_BITS] <= j[J_SIZE-1-:USED_J_BITS];
	bram_address[X_SIZE-1:0] <= x_enc;
	
	end



endmodule
