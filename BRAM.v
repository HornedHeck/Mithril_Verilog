module Bram
	#(
		parameter RAM_WIDTH = 8,
		parameter ADDR_SIZE = 8,
		parameter DATA_FILE = "Data.txt",
		parameter INIT_START_ADDR = 0,
		parameter INIT_END_ADDR	= 2 ** ADDR_SIZE - 1
	)
	(
    input							clock,
	 input							ram_enable,
    input 		[ADDR_SIZE-1:0]	address,
	 output reg 	[RAM_WIDTH-1:0] 	output_data
	);
	
   
   (* RAM_STYLE="BLOCK" *)
   reg [RAM_WIDTH-1:0] ram_name [(2**ADDR_SIZE)-1:0];


   //  The forllowing code is only necessary if you wish to initialize the RAM 
   //  contents via an external file (use $readmemb for binary data)
   initial
      $readmemh(DATA_FILE, ram_name, INIT_START_ADDR, INIT_END_ADDR);

   always @(posedge clock)
      if (ram_enable) begin
         output_data <= ram_name[address];
      end

endmodule