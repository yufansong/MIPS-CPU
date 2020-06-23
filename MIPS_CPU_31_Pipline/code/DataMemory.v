 
module DataMemory(clk, Address, Write_data, Read_data, MemRead, MemWrite);
	input clk;
	input [31:0] Address, Write_data;
	input MemRead, MemWrite;
	output [31:0] Read_data;
	
	parameter RAM_SIZE = 400;
	parameter RAM_SIZE_BIT = 8;
	
	reg [31:0] RAM_data[RAM_SIZE - 1: 0];
	assign Read_data = (MemRead && (Address < RAM_SIZE))? RAM_data[Address[9:2]]: 32'h00000000;
	
	always @(posedge clk)//delete the function of reset
	if (MemWrite && (Address < RAM_SIZE))
		RAM_data[Address[9:2]] <= Write_data;
			
endmodule
