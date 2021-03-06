`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/25 22:52:53
// Design Name: 
// Module Name: Mul_32_tb
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


module Mul_32_tb(
    );
reg clk=0;
reg control=0;
reg [31:0] in_data_a=32'hffffffff;
reg [31:0] in_data_b=0;
wire [31:0] out_data;

always #20 clk=~clk;
always #40 in_data_a=in_data_a-1;
always #40 in_data_b=in_data_b+1;
always #40 control=~control;

Mul_32
Mul_32_inst(
.control(control),
.in_data_a(in_data_a),
.in_data_b(in_data_b),
.out_data(out_data)
);
endmodule
