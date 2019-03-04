`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/28 02:12:31
// Design Name: 
// Module Name: mux4x32_tb
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


module mux4x32_tb(
    );
reg [31:0]a0=0;
reg [31:0]a1=1;
reg [31:0]a2=2;
reg [31:0]a3=3;
reg [1:0] s=2;
wire [31:0] y;

mux4x32 
mux4x32_inst(
.a0(a0),
.a1(a1),
.a2(a2),
.a3(a3),
.s(s),
.y(y)
);

endmodule
