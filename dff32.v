`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/27 00:00:27
// Design Name: 
// Module Name: dff32
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


module dff32(d, clk, clrn, q);//1ÓÐÐ§
  input [31:0] d;
  input clk, clrn;
  output [31:0] q;
  
  reg [31:0] q;
  always @ ( posedge clk or posedge clrn)
    if( clrn==1 ) 
   begin
     q = 0;
   end
   else
   begin
      q = d;
   end
endmodule

