`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:38:47 05/16/2022
// Design Name:   Float_comparator
// Module Name:   /home/hornedheck/Documents/Mithril/Float_comparator_tf.v
// Project Name:  Mithril
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Float_comparator
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Float_comparator_tf;

	// Inputs
	reg clock;
	reg [31:0] a;

	// Outputs
	wire is_higher;

	// Instantiate the Unit Under Test (UUT)
	Float_comparator uut (
		.clock(clock), 
		.a(a), 
		.is_higher(is_higher)
	);
	
	initial
	begin
		clock = 0;
		forever #5 clock = ~clock;
	end
	
	initial begin
		// Initialize Inputs
		a = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		a = 'b10111110001000000000000000000000;
		@(posedge clock);
		#1 $display("Is a > b : %d", is_higher);
		
	end
      
endmodule

