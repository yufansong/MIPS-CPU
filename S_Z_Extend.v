`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/25 10:23:58
// Design Name: 
// Module Name: S_Z_Extend
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


module S_Z_Extend(
input sext,
input [15:0] immediate,
output [31:0] extendImmediate
    );
assign extendImmediate[15:0]=immediate;
assign extendImmediate[31:16] =sext?(immediate[15]?16'hffff : 16'h0000) : 16'h0000;

endmodule
