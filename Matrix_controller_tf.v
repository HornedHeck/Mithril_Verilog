`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:45:09 05/17/2022
// Design Name:   Matrix_controller
// Module Name:   /home/hornedheck/Documents/Mithril/Matrix_controller_tf.v
// Project Name:  Mithril
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Matrix_controller
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Matrix_controller_tf;

	// Inputs
	reg clock;
	reg [95:0] x;

	// Instantiate the Unit Under Test (UUT)
	Matrix_controller uut (
		.clock(clock),
		.x(x)
	);
	
	
	
	initial begin
		// Initialize Inputs
		x = 1;
		clock = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		repeat(50) 
			#5 clock = !clock;
		
	end
      
endmodule

