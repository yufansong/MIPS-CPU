`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/25 16:32:34
// Design Name: 
// Module Name: Regfile_tb
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


module Regfile_tb(

    );
reg clk;
reg rst;
reg we;
reg [4:0]raddr1;
reg [4:0]raddr2;
reg [4:0]waddr;
reg [31:0]wdata;
wire [31:0]rdata1;
wire[31:0]rdata2;
initial
begin
     clk=1;
    #40 we=0;raddr1=0;raddr2=1;
    #40 we=1;waddr=0;wdata=4;
    #40 we=1;waddr=1;wdata=6;
    #40 we=0;raddr1=0;raddr2=1;

    #40 we=0;raddr1=3;raddr2=4;
    #40 we=1;waddr=3;wdata=123;
    #40 we=0;raddr1=3; 
    #40 we=1;waddr=4;wdata=456;
    #40 we=0;raddr1=0;raddr2=1;
    #40 we=0;raddr1=4;
    #40 we=0;raddr1=4;raddr2=3;   
      
    #40 we=0;raddr1=0;raddr2=1;

     #40 raddr1=2'B0;raddr2=2'B10;
     #40 we=1;waddr=2'B10;wdata=4'B0101;
//     #40 we=0;raddr1=2'B10;
     #40 we=1;waddr=2'B11;wdata=4'B1111;
//     #40 we=0;raddr1=2'B11;
     #40 we=1;waddr=2'B0;wdata=4'B0011;
//     #40 we=0;raddr1=2'B0;
     #40 we=0;raddr2=4'B0010;raddr1=4'B0011;
     #40 we=0;raddr1=4'B000;     
    //  #40 rst=1;we=0;raddr2=4'B10;
    // #40 rst=1;
    #40 we=1;waddr=1;wdata=1;

end
always #20 clk=~clk;


regfile 
regfile_inst(
.clk(clk),
.clrn(rst),
.we(we),
.rna(raddr1),
.rnb(raddr2),
.wn(waddr),
.d(wdata),
.qa(rdata1),
.qb(rdata2)
);


//  RegFile
//  RegFile_inst(
// .clk(clk),
// .rst(rst),
// .we(we),
// .raddr1(raddr1),
// .raddr2(raddr2),
// .waddr(waddr),
// .wdata(wdata),
// .rdata1(rdata1),
// .rdata2(rdata2)
//         );



endmodule
