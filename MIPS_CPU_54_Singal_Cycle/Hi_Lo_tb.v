`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/01 16:39:25
// Design Name: 
// Module Name: Hi_Lo_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Hi_Lo_tb(
    );
reg clk = 0;
reg rst = 1;
reg [4:0] choice ;
reg [31:0] Hi_i = 0;
reg [31:0] Lo_i = 0;
reg [31:0] mul_h = 0;
reg [31:0] mul_l = 0;
wire [31:0] Hi_o ;
wire [31:0] Lo_o ;
parameter MFHI = 5'b10000, 
          MFLO = 5'b01000,
          MTHI = 5'b00100,
          MTLO = 5'b00010,
          D_M  = 5'b00001;

initial begin
#10 rst = 0;
#20 choice = MTHI ; Hi_i = 1;
#20 choice = MFHI ; Hi_i = 2;

#20 choice = MTLO ; Lo_i = 3;
#20 choice = MFLO ; Lo_i = 4;

#20 choice = D_M ; mul_h = 5 ; mul_l = 6;
#20 choice = MFHI; 
#20 choice = MFLO;
end
always #10 clk = ~ clk ;

Hi_Lo
Hi_Lo_inst(
.clk(clk),
.rst(rst),
.choice(choice),
.Hi_i(Hi_i),
.Lo_i(Lo_i),
.mul_h(mul_h),
.mul_l(mul_l),
.Hi_o(Hi_o),
.Lo_o(Lo_o)
);

endmodule
