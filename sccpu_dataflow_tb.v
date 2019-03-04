`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/28 11:13:01
// Design Name: 
// Module Name: sccpu_dataflow_tb
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


module sccpu_dataflow_tb(
    );
reg clk=0;
reg rst=0;
wire [31:0]inst=32'h20010001;
wire [31:0] mem=1;
wire [31:0] pc,alu,data;
wire d_ram_rena,d_ram_wena;

always #10 clk=~clk;
always #1000 rst=~rst;
cpu
sccpu_dataflow_inst(
.clk(clk),
.rst(rst),
.inst(inst),
.mem(mem),
.pc(pc),
.alu(alu),
.data(data),
.d_ram_rena(d_ram_rena),
.d_ram_wena(d_ram_wena)
);

endmodule
