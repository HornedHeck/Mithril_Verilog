`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:43:19 05/16/2022
// Design Name:   Address_calc
// Module Name:   /home/hornedheck/Documents/Mithril/Address_calc_tf.v
// Project Name:  Mithril
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Address_calc
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Address_calc_tf;
	parameter BRAM_NUMBER_SIZE = 3;
	parameter BRAM_ADDRESS_SIZE = 8;
	parameter I_SIZE = 1;
	parameter J_SIZE = 3;
	parameter X_SIZE = 3;
	parameter DTYPE_BYTES_SIZE = 1;

	reg clock;
	reg [J_SIZE-1:0] j;
	reg [I_SIZE-1:0] i;
	reg [X_SIZE-1:0] x_enc;
	wire [BRAM_NUMBER_SIZE-1:0] bram_number;
	wire [BRAM_ADDRESS_SIZE-1:0] bram_address;
	// Instantiate the Unit Under Test (UUT)
	Address_calc #(
		.BRAM_NUMBER_SIZE(BRAM_NUMBER_SIZE),
		.BRAM_ADDRESS_SIZE(BRAM_ADDRESS_SIZE),
		.I_SIZE(I_SIZE),
		.J_SIZE(J_SIZE),
		.X_SIZE(X_SIZE)		
	) uut (
		clock,
		j,
		i,
		x_enc,
		bram_number,
		bram_address
	);

	initial
	begin
		clock = 0;
		forever #5 clock = ~clock;
	end

	initial begin
		// Initialize Inputs
		j = 5;
		i = 1;
		x_enc = 3;

		// Wait 100 ns for global reset to finish
		#100;
		#1 $display ("NUMBER: %d", bram_number);
		#1 $display ("ADDRESS: %d", bram_address);
		
      for(j = 0; j < 8; j = j + 1) begin
				@(posedge clock);
				#1 $display ("NUMBER: %d", bram_number);
		end
		
		// Add stimulus here

	end
      
endmodule

