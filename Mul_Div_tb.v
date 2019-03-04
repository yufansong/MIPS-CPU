`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/01 16:39:25
// Design Name: 
// Module Name: Mul_Div_tb
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


module Mul_Div_tb(
    );
reg [3:0] choice = 0;
reg [31:0] a = 0;
reg [31:0] b =0;
reg clk = 0;
reg rst = 1;
wire buzy;
wire [31:0] q;
wire [31:0] r;

parameter DIV  = 4'b1000,
          DIVU = 4'b0100,
          MUL  = 4'b0010,
          MULTU= 4'b0001;
always #10 clk = ~clk;
initial begin
#10 rst = 0;
// #10  choice = DIV ; a =-4 ; b = 2;//FFFF_FFFE
// #400 choice = DIVU; a= -4 ; b = 2;//7FFF_FFFE
// #400 choice = DIVU; a=  4 ; b = 2;//2
// #400 choice = MUL;  a= -4 ; b = 2;//FFFF_FFF8
#400 choice = MUL;  a= 7 ; b =4'hf;//2
// #400 choice = MULTU;a= -4 ; b = 2;//1_FFFF_FFF8
// #400 choice = MULTU;a=  4 ; b = 2;//2
end

Mul_Div
Mul_Div_inst(
.choice(choice),
.a(a),
.b(b),
.clk(clk),
.rst(rst),
.buzy(buzy),
.q(q),
.r(r)
);

endmodule 
