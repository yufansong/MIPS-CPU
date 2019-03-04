`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/25 22:39:25
// Design Name: 
// Module Name: S_Z_Extend_tb
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


module S_Z_Extend_tb(
    );
reg sext=0;
reg [15:0] immediate=0;
wire [31:0] extendImmediate;

always #20 sext=~sext;
initial 
begin
  #40 immediate=16'hffff;
  #40 immediate=16'h0fff;
end

S_Z_Extend
S_Z_Extend_inst(
.sext(sext),
.immediate(immediate),
.extendImmediate(extendImmediate)
);

endmodule
