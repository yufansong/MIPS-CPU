`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/01 10:57:15
// Design Name: 
// Module Name: Clz
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


module Clz(
input  clk,
input  [31:0] data,
output [31:0] num
    );
integer i;
reg [31:0] num_temp = 32;
reg flag = 1 ;
always @( *)begin
  flag = 1;
  i = 0;
  num_temp = 32;
  for (i=0 ; i<32 ; i=i+1)begin
    if(data[31-i] == 1 && flag == 1)begin
      num_temp = i;
      flag = 0;
    end
  end
  i = 0;
end
assign num = num_temp;
endmodule
