`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/25 23:35:29
// Design Name: 
// Module Name: Data_Mem_tb
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


module Data_Mem_tb(
    );
reg clk=0;
reg d_ram_rena=0;
reg d_ram_wena=0;
reg [31:0] DAddr=0;
reg [31:0] Data_In=0;
wire [31:0] Data_out;
reg [5:0] choice = 0;
parameter LB  = 6'b100000,
          LBU = 6'b010000,
          LH  = 6'b001000,
          LHU = 6'b000100,
          SB  = 6'b000010,
          SH  = 6'b000001; 

initial
begin
  #40 d_ram_rena=1;d_ram_wena=0;DAddr=4;
  #40 d_ram_rena=0;d_ram_wena=1;DAddr=32'h10010008;Data_In=123456;
  #40 d_ram_rena=0;d_ram_wena=1;DAddr=0;Data_In=12345;
  #40 d_ram_rena=1;d_ram_wena=1;DAddr=4;
  #40 d_ram_rena=1;d_ram_wena=0;DAddr=0;
  #40 d_ram_rena=0;d_ram_wena=0;DAddr=4;
  #40 d_ram_rena=1;d_ram_wena=0;DAddr=4;
  #40 d_ram_rena=1;d_ram_wena=0;DAddr=32'h10010008;
  // #40 d_ram_rena =0 ; d_ram_wena =0; DAddr = 32'h10010000; Data_In = 16'hFFFF;
  // #40 choice = SB;
  // #40 choice = LB; 
  // #40 choice = LBU;
  // #40 choice = SH;
  // #40 choice = LH;
  // #40 choice = LHU;
  
end

always #20 clk=~clk;

Data_Mem
Data_Mem_inst(
.clk(clk),
.d_ram_rena(d_ram_rena),
.d_ram_wena(d_ram_wena),
.DAddr(DAddr),
.DataIn(Data_In),
.Data_out(Data_out),
.choice(choice)
);

endmodule
