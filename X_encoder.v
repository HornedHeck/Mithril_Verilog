`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:01:06 05/16/2022 
// Design Name: 
// Module Name:    X_encoder 
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
module X_encoder
#(
	parameter DTYPE_SIZE = 32,
	parameter X_ENC_SIZE = 3,
	parameter TOTAL_SPLITS = 2 ** X_ENC_SIZE - 1, // 7
	parameter [DTYPE_SIZE*TOTAL_SPLITS-1:0] S = 0
) (
		input clock,
		input [DTYPE_SIZE*3-1:0] x,
		output reg [X_ENC_SIZE-1:0] x_enc
	);

	wire is_bigger[0:TOTAL_SPLITS-1];

	
	genvar i, j;
	generate 
		for (i = 0; i < X_ENC_SIZE; i = i + 1) begin : cmpOut
			for (j = 0; j < 2 ** i ; j = j + 1) begin : cmpIn 
				initial begin
					#1 $display("S[%d]: %b",(TOTAL_SPLITS - (2 ** i - 1 + j)) * DTYPE_SIZE - 1, S[(TOTAL_SPLITS - (2 ** i - 1 + j)) * DTYPE_SIZE - 1 -: DTYPE_SIZE]);
				end
				Float_comparator 
				#( .b(S[(TOTAL_SPLITS - (2 ** i - 1 + j)) * DTYPE_SIZE - 1 -: DTYPE_SIZE])) 
				cmp(
					clock,
					x[DTYPE_SIZE*(X_ENC_SIZE-i)-1:DTYPE_SIZE*(X_ENC_SIZE-1-i)],
					is_bigger[2 ** i - 1 + j]
				);
			end
		end
	endgenerate
	
	integer k;
	
	
	always @(posedge clock) begin
		x_enc = 0;
		for(k = 0; k < X_ENC_SIZE; k = k + 1) begin
			x_enc = x_enc * 2;
			x_enc[0] = is_bigger[2**k - 1 + x_enc/2];
		end
	end


endmodule
