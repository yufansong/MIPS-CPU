`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/01 01:22:16
// Design Name: 
// Module Name: Hi_Lo
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


module Hi_Lo(
input clk,
input rst,
input [4:0] choice,
input [31:0] Hi_i,
input [31:0] Lo_i,
input [31:0] mul_h,
input [31:0] mul_l,
output [31:0] Hi_o,
output [31:0] Lo_o
    );
reg [31:0] H;
reg [31:0] L;


parameter MFHI = 5'b10000, 
          MFLO = 5'b01000,
          MTHI = 5'b00100,
          MTLO = 5'b00010,
          D_M  = 5'b00001;
          
assign Hi_o =(choice == MFHI) ? H : 0;
assign Lo_o =(choice == MFLO) ? L : 0;


always @(posedge clk or posedge rst)begin
  if(rst)begin
    H = 0;
    L = 0;
  end
  else begin
    case (choice)
        MTHI:
            H = Hi_i; 
        MTLO:
            L = Lo_i;
        D_M:begin 
            H = mul_h;
            L = mul_l;
        end
        default: begin
            H = H;
            L = L;
        end
    endcase
  end
end
endmodule
