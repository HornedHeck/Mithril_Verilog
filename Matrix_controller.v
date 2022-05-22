`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:40:01 05/17/2022 
// Design Name: 
// Module Name:    Matrix_controller 
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
module Matrix_controller
#(
		// matrix size params
		parameter I_SIZE = 0,
		parameter J_SIZE = 2,
		parameter X_ENC_SIZE = 3,
		parameter J_MAX = 2 ** J_SIZE - 1,

		// x_enc params
		parameter SPLIT_LIST_SIZE = 1,
		parameter TOTAL_SPLITS = 2 ** X_ENC_SIZE - 1,
		parameter [DTYPE_SIZE * TOTAL_SPLITS-1:0] S = 0,
		
		// bram params
		parameter BRAM_COUNT = 2,
		parameter BRAM_COUNT_SIZE = 1,
		parameter RAM_WIDTH = 8,
		parameter ADDR_SIZE = 4,
		
		// dist calc params
		parameter LUTS_PER_CLOCK_SIZE = 0,
		parameter LUTS_PER_CLOCK = 2 ** LUTS_PER_CLOCK_SIZE,
		parameter CLOCKS_COUNT_SIZE = J_SIZE - LUTS_PER_CLOCK_SIZE,
		parameter CLOCKS_COUNT = 2 ** CLOCKS_COUNT_SIZE,

		// utilities
		parameter DTYPE_SIZE = 32,
		parameter ENC_DTYPE_BYTES = 1,
		parameter ENC_DTYPE_SIZE = 8 * ENC_DTYPE_BYTES,
		parameter LOG = 1
)(
	input clock,
	input [DTYPE_SIZE * X_ENC_SIZE - 1:0] x,
	output reg [RAM_WIDTH-1:0] res
);
	
	reg is_ram_enabled;
	reg [ADDR_SIZE-1:0] bram_addrs [0:BRAM_COUNT-1];
	wire [RAM_WIDTH-1:0] bram_data [0:BRAM_COUNT-1];
	wire [ADDR_SIZE-1:0] got_addrs [0:LUTS_PER_CLOCK-1];
	wire [BRAM_COUNT_SIZE-1:0] got_numbers [0:LUTS_PER_CLOCK-1];
	reg [BRAM_COUNT_SIZE-1:0] p_got_numbers [0:LUTS_PER_CLOCK-1];
	
	reg [1:0] state;
	reg [J_SIZE-1:0] j;
//	reg [I_SIZE-1:0] i;
	reg i;
	reg ready;
	
	wire [X_ENC_SIZE-1:0] x_enc;
	
	X_encoder 
	#(
		.X_ENC_SIZE(X_ENC_SIZE),
		.S(S)
	)
	encoder (
		clock,
		x,
		x_enc
	);
	
	integer init_addr_i;
	initial begin
		state <= 1;
		is_ram_enabled <= 1;
		j <= 0;
	end

	
	genvar bram_i, a_calc_i;
	generate
		for (bram_i = 0; bram_i < BRAM_COUNT; bram_i = bram_i + 1) begin : brams
			if (LOG)
				initial
					#1 $display("Initializing BRAM %d",bram_i);
//			initial
//				bram_addrs[bram_i] = 0;
//			Bram #(
//				.ADDR_SIZE(ADDR_SIZE), // temp for 4x1x8 tests
//				.RAM_WIDTH(RAM_WIDTH),
//				.DATA_FILE()
//			) bram (
//				clock,
//				is_ram_enabled,
//				bram_addrs[bram_i],
//				bram_data[bram_i]
//			);
		end
		Bram #(
				.ADDR_SIZE(ADDR_SIZE), // temp for 4x1x8 tests
				.RAM_WIDTH(RAM_WIDTH),
				.DATA_FILE("Data.txt")
			) bram_0 (
				clock,
				is_ram_enabled,
				bram_addrs[0],
				bram_data[0]
			);
			Bram #(
				.ADDR_SIZE(ADDR_SIZE), // temp for 4x1x8 tests
				.RAM_WIDTH(RAM_WIDTH),
				.DATA_FILE("Data_1.txt")
			) bram_1 (
				clock,
				is_ram_enabled,
				bram_addrs[1],
				bram_data[1]
			);
		for (a_calc_i = 0; a_calc_i < LUTS_PER_CLOCK; a_calc_i = a_calc_i + 1) begin : adress_calcs
			initial
					#1 $display("Initializing Address calc %d",a_calc_i);
			Address_calc
			#(
					.BRAM_NUMBER_SIZE(BRAM_COUNT_SIZE),
					.BRAM_ADDRESS_SIZE(ADDR_SIZE),
					.I_SIZE(I_SIZE),
					.J_SIZE(J_SIZE),
					.X_SIZE(X_ENC_SIZE)
			)
			calc (
				clock,
				j,
				i,
				x_enc,
				got_numbers[a_calc_i],
				got_addrs[a_calc_i]
			);
		end
	endgenerate
	
	always @(posedge clock)
	begin
	case(state)
		0 : // - wait, write to res last item

			begin
			if(LOG)
				$display("Finished");
//			assign res = bram_data[p_got_numbers[0]];
			res <= bram_data[p_got_numbers[0]];
			end
		1 : //encode x 
			begin
			if (j == 0 && LOG)
				$display("x: %b", x_enc);
			state <= 2;
			end
		2 : // calc part from luts
			begin
			if (LOG)
				$display("for j = %d got BRAM %d at addr %d" , j , got_numbers[0] , got_addrs[0]);			

			bram_addrs[got_numbers[0]] <= got_addrs[0];
			p_got_numbers[0] <= got_numbers[0];
//			assign res = bram_data[got_numbers[0]];
			res <= bram_data[got_numbers[0]];
			if (j == J_MAX ) begin
				state <= 0;
			end else begin
				state <= 2;
			end
			j <= j + 1;
			end
		endcase	
	end

endmodule
