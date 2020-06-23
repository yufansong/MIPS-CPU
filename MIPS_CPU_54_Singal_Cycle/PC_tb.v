`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/25 19:35:46
// Design Name: 
// Module Name: PC_tb
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


module PC_tb(
    );
reg clk=0;
reg rst=0;
reg PCWre=0;
reg [31:0] newAddress=0;
wire [31:0] currentAddress;

always #20 clk=~clk;
always #40 PCWre=~PCWre;
always #40 newAddress=newAddress+1;

PC
PC_inst(
.clk(clk),
.rst(rst),
.PCWre(PCWre),
.newAddress(newAddress),
.currentAddress(currentAddress)
);
endmodule
