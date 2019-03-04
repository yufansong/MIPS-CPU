`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/01 16:39:25
// Design Name: 
// Module Name: Clz_tb
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


module Clz_tb(
    );
reg [31:0] data = 32'hFFFF_FFFF;
wire [4:0] num;

always #10 data = data>>1;


Clz
Clz_inst(
.data(data),
.num(num)
);

endmodule
