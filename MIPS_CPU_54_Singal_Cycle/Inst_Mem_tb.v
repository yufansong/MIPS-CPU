`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/26 10:25:31
// Design Name: 
// Module Name: Inst_Mem_tb
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


module Inst_Mem_tb(
    );
reg i_ram_rena=0;
reg i_ram_wena=0;
reg [31:0] IAddr=0;
wire [5:0] op;
wire [4:0] rs;
wire [4:0] rt;
wire [4:0] rd;
wire [15:0] immediate;
reg  [31:0]pc=0;
wire [31:0] inst;

always #10 pc = pc + 1;


scinstmem
scinstmem_inst(
.pc(pc),
.inst(inst)
);
// Inst_Mem
// Inst_Mem_inst(
// .i_ram_rena(1),
// .i_ram_wena(0),
// .IAddr(IAddr),
// .op(op),
// .rs(rs),
// .rt(rt),
// .rd(rd),
// .immediate(immediate)
// );

endmodule
