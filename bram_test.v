`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:52:45 05/12/2022
// Design Name:   BRAM
// Module Name:   /home/hornedheck/Documents/Mithril/bram_test.v
// Project Name:  Mithril
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: BRAM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module bram_test;

	parameter RAM_WIDTH = 32;
	parameter RAM_ADDR_BITS = 9;

	reg							clk;
	reg							ram_enable;
	reg							write_enable;
	reg 	[RAM_ADDR_BITS-1:0]	address;
	reg 	[RAM_WIDTH-1:0] 	input_data;
	wire	[RAM_WIDTH-1:0] 	output_data;

	// Instantiate the Unit Under Test (UUT)
	BRAM
#(
	.RAM_WIDTH 		(RAM_WIDTH 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS 	),
	.INIT_START_ADDR(0				),
	.INIT_END_ADDR	(10				)
)
bram_inst
(
	.clock			(clk			),
	.ram_enable		(ram_enable		),
	.write_enable	(write_enable	),
	.address		(address		),
	.input_data		(input_data		),
	.output_data    (output_data	)
);

		initial
	begin
		clk = 0;
		forever #5 clk = ~clk;
	end

	initial
	begin
		$dumpfile("wave.vcd");
		$dumpvars(0, tb_bram);
		
		ram_enable		= 1;
		write_enable	= 0;
		address			= 0;
		input_data		= 0;

		repeat(2) @(posedge clk);


//		$display("Writing data in BRAM");
//		#1	write_enable	= 1;
//		for (address = 0; address < 20; address = address +1)
//		begin
//			input_data = address*10;
//			@(posedge clk);
//			#1;
//		end
//		write_enable	= 0;

		$display("Reading data from BRAM");
		repeat(2) @(posedge clk);
		for (address = 0; address < 20; address = address +1)
		begin
			@(posedge clk);
			#1 $display ("ADDR: %d, DATA: %d", address, output_data);
		end
		
		repeat(2) @(posedge clk);
		$finish;
	end
      
endmodule

