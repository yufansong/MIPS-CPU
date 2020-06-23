`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/26 22:50:35
// Design Name: 
// Module Name: sccomp_dataflow
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


module sccomp_dataflow(
input clk_in,
input reset,
output clk_return,
//input mem_clk,
output [31:0] inst,
output [31:0] pc,
output [31:0] addr,
output [31:0] mem_out
    );
wire [31:0] alu_out;
wire [31:0] data;
wire        wmem;
wire [5:0] choice_mem;
assign addr=alu_out;
//reg  [31:0] pc_show_temp;
wire [31:0] pc_0;
assign pc=pc_0+32'h400000;

assign clk_return=clk_in;


Data_Mem
dmem(
.clk(clk_in),
.d_ram_rena(d_ram_rena),
.d_ram_wena(d_ram_wena),
.DAddr(alu_out),
.DataIn(data),
.choice(choice_mem),
.Data_out(mem_out)
);

cpu
sccpu(
.clk(clk_in),
.rst(reset),
.inst(inst),
.mem(mem_out),
.pc(pc_0),
.alu(alu_out),
.data(data),
.d_ram_rena(d_ram_rena),
.d_ram_wena(d_ram_wena),
.choice_mem(choice_mem)
);

//  scinstmem
//  scinstmem_inst(
//  .pc(pc_0),
//  .inst(inst)
//  );
imem
imem_inst(pc_0[12:2],inst
);





endmodule


