`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/27 23:03:06
// Design Name: 
// Module Name: dff32_tb
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


module dff32_tb(
    );
reg [31:0] data=2'hf;
reg clk=0,rst=0,e=1;
wire [31:0] q;

initial
begin
  #100 rst = 0;
  #100 rst = 1;
  #100 rst = 0;
end

always #10 clk=~clk;
always #10 data=data+1;

dff32 
dff_32_tb(
.d(data),
.clk(clk),
.clrn(rst),
.e(e),
.q(q)
);

endmodule
