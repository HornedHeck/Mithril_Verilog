`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:52:46 05/16/2022
// Design Name:   X_encoder
// Module Name:   /home/hornedheck/Documents/Mithril/X_encoder_tf.v
// Project Name:  Mithril
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: X_encoder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module X_encoder_tf;
	
	parameter DTYPE_SIZE = 32;
	parameter [DTYPE_SIZE-1:0] sv1 = 'b10111110100000011000110001111110;
	
	parameter [DTYPE_SIZE-1:0] sv2_0 = 'b10111111001010101001100010100100;
	parameter [DTYPE_SIZE-1:0] sv2_1 = 'b10111110100111010011000101001000;
	
	parameter [DTYPE_SIZE-1:0] sv3_0 = 'b10111110111101010001101101100000;
	parameter [DTYPE_SIZE-1:0] sv3_1 = 'b00111110100110101110010010100000;
	parameter [DTYPE_SIZE-1:0] sv3_2 = 'b00111111000011010111001001010000;
	parameter [DTYPE_SIZE-1:0] sv3_3 = 'b00111110111110101110010010100000;
	
//	parameter [DTYPE_SIZE-1:0] s [0:6]= {
//		sv1,
//		sv2_0,
//		sv2_1,
//		sv3_0,
//		sv3_1,
//		sv3_2,
//		sv3_3
//	};
	// Inputs
	reg clock;
	
	reg [95:0] x ;
	reg [31:0] x_0;
	reg [31:0] x_1;
	reg [31:0] x_2;
	wire [2:0] x_enc;
	// Instantiate the Unit Under Test (UUT)
	X_encoder
//	#( .S(s)	)
	uut (
		clock,
		x,
		x_enc
	);

	initial begin
		// Initialize Inputs
		clock = 0;
		
		x_0 = 'b00111110100000101010100001101111;
		x[95-:32] = x_0;
		x_1 = 'b10111101101011011110001111011000;
		x[95-32-:32] = x_1;
		x_2 = 'b00111111101101101100111011011000;
		x[95-64-:32] = x_0;
		
		#1 $display(x_0);
		#1 $display(x_1);
		#1 $display(x_2);
		#1 $display("--------------------------");
//		x = {
//			'b00111110100000101010100001101111,
//			'b10111101101011011110001111011000,
//			'b00111111101101101100111011011000
//		};
//		x = 'b00111110100000101010100001101111_10111101101011011110001111011000_00111111101101101100111011011000;
		// Wait 100 ns for global reset to finish
		#100;
		
		repeat(20)
			#5 clock = !clock;
        
		// Add stimulus here

	end
      
endmodule

