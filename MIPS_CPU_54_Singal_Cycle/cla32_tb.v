`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/27 23:15:53
// Design Name: 
// Module Name: cla32_tb
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


module cla32_tb(
    );
wire  [31:0]pc=0;
wire [31:0]four=4;
wire [31:0]p4;
wire co;
cla32 
cla32_inst(
.a(pc),
.b(four),
.ci(0),
.s(p4),
.co(co)
);
endmodule
