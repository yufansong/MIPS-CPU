`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/25 10:23:58
// Design Name: 
// Module Name: Inst_Mem
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

module scinstmem(pc,inst);
    input [31:0] pc;    //指令地址
    output [31:0] inst; //输出指令
    
    reg [31:0] ram [0:1000]; //指令存储�?
    
    assign inst = ram[pc[31:2]];
    
    initial
    begin
        $readmemh("C:\\Users\\Ordinary\\Desktop\\test\\cp0.hex.txt", ram);  //读取测试文档中的指令
    end
    
endmodule

