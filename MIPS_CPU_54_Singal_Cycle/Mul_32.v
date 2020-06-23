`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/25 20:32:25
// Design Name: 
// Module Name: Mul_32
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


module Mul_32(
input control,
input [31:0] in_data_a,
input [31:0] in_data_b,
output [31:0] out_data
    );
assign out_data=control? in_data_b : in_data_a;
endmodule


module mux4x32(a0, a1, a2, a3, s, y);
  input [31:0] a0, a1, a2, a3;
  input [1:0] s;
  output [31:0] y;
  
  function [31:0] select;
    input [31:0] a0, a1, a2, a3;
     input [1:0] s;
     case(s)
       2'b00: select = a0;
       2'b01: select = a1; 
       2'b10: select = a2;
       2'b11: select = a3;
     endcase
  endfunction
  assign y = select(a0, a1, a2, a3, s);
endmodule