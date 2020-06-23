`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/25 10:23:58
// Design Name: 
// Module Name: RegFile
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



module regfile(rna,rnb,d,wn,we,clk,clrn,qa,qb);
    input clk;            //时钟信号
    input clrn;           //清零信号
    input we;             //写使能信号
    input [4:0] rna, rnb; //读端口a,b的寄存器地址
    input [4:0] wn;       //写端口的寄存器地址
    input [31:0] d;       //写端口的32位数据
    output [31:0] qa,qb;  //读端口a,b的32为数据
    
    reg [31:0] array_reg [0:31]; //31 * 32-bit regs
    
    //读寄存器
    assign qa = (rna == 0) ? 0 : array_reg[rna];
    assign qb = (rnb == 0) ? 0 : array_reg[rnb];
    
    integer i;
    initial
    begin
        for(i = 0; i < 32; i = i + 1)
            array_reg[i] <= 0;
    end 



    //写寄存器 //下降沿写入？？？
    always @(negedge clk or negedge clrn)
    begin
        if(clrn == 1)
        begin
            for(i = 0; i < 32; i = i + 1)
                array_reg[i] <= 0;
        end  
        else if((wn != 0) && we)
            array_reg[wn] = d;
    end
endmodule

