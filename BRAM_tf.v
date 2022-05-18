`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:07:15 05/12/2022
// Design Name:   bram
// Module Name:   /home/hornedheck/Documents/Mithril/BRAM_tf.v
// Project Name:  Mithril
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: bram
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module BRAM_tf;

	// Inputs
	reg clock;
	reg ram_enable;
	reg write_enable;
	reg [8:0] address;
	reg [31:0] input_data;

	// Outputs
	wire [31:0] output_data;

	// Instantiate the Unit Under Test (UUT)
	Bram uut (
		.clock(clock), 
		.ram_enable(ram_enable), 
		.address(address), 
		.output_data(output_data)
	);

	initial begin
		// Initialize Inputs
		clock = 0;
		ram_enable = 0;
		write_enable = 0;
		address = 0;
		input_data = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

