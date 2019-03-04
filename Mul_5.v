`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/25 20:32:25
// Design Name: 
// Module Name: Mul_5
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


module Mul_5(
input control,
input [4:0] in_data_a,
input [4:0] in_data_b,
output [4:0] out_data
    );
assign out_data=control? in_data_b : in_data_a;
endmodule
