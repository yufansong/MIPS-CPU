`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/01 16:39:25
// Design Name: 
// Module Name: CP0_tb
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


module CP0_tb(
    );
reg clk = 0;
reg rst = 0;
reg teq = 0;
reg eret = 0;
reg mtc0 = 0;
reg mfc0 = 0;
reg [31:0] pc = 0;
reg [4:0] addr = 0;
reg [4:0] cause = 0;
reg [31:0] wdata = 0;
wire [31:0] rdata ;
wire [31:0] exc_addr;

parameter   SYSCALL = 4'b1000,
            BREAK   = 4'b1001,
            TEQ     = 4'b1101,
            IE      = 0;

initial begin
// reset
#10 rst = 1;
#10 rst = 0;
// #10 mfc0 = 1; addr = 2;                             // rdata = 0
// read/write data
// #10 mtc0 = 1; mfc0 = 0; addr = 2; wdata = 4'hF;
// #10 mtc0 = 0; mfc0 = 1; addr = 12;                   // rdata = 4'hF

//中断不匹�?
// #10 rst  = 0; teq  = 1; eret = 0; cause = SYSCALL; pc = 1;    // pc =  NULL
// #10 mtc0 = 0; mfc0 = 1; addr = 12;
// #10 mtc0 = 0; mfc0 = 1; addr = 13;
// #10 mtc0 = 0; mfc0 = 1; addr = 14;

// //teq
// #10 rst  = 0; teq  = 1; eret = 0; cause = TEQ; pc = 2;       // pc =  2
// #10 mtc0 = 0; mfc0 = 1; addr = 12;
// #10 mtc0 = 0; mfc0 = 1; addr = 13;
// #10 mtc0 = 0; mfc0 = 1; addr = 14;
//中断屏蔽
// #10 rst  = 0; teq  = 1; eret = 0; cause = TEQ; pc = 1;    // pc = NULL
// #10 mtc0 = 0; mfc0 = 1; addr = 12;
// #10 mtc0 = 0; mfc0 = 1; addr = 13;
// #10 mtc0 = 0; mfc0 = 1; addr = 14;

//syscall
#10 rst  = 0; teq  = 0; eret = 0; cause = SYSCALL; pc = 3;        // pc = 3
#10 mtc0 = 0; mfc0 = 1; addr = 12;
#10 mtc0 = 0; mfc0 = 1; addr = 13;
#10 mtc0 = 0; mfc0 = 1; addr = 14;

//eret
#10 teq  = 0; eret = 1; cause = SYSCALL; pc = 5;       // NULL
#10 mtc0 = 0; mfc0 = 1; addr = 12;                     // pc = 4

//break
#10 rst  = 0; teq  = 0; eret = 0; cause = BREAK; pc = 4;        // pc =  4
#10 mtc0 = 0; mfc0 = 1; addr = 12;
#10 mtc0 = 0; mfc0 = 1; addr = 13;
#10 mtc0 = 0; mfc0 = 1; addr = 14;


end

always #10 clk = ~clk;

CP0
CP0_inst(
.clk(clk),
.rst(rst),
.teq(teq),
.eret(eret),
.mtc0(mtc0),
.mfc0(mfc0),
.pc(pc),
.addr(addr),
.cause(cause),
.wdata(wdata),
.rdata(rdata),
.exc_addr(exc_addr)
);
endmodule
