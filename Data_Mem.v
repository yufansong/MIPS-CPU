`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/25 10:23:58
// Design Name: 
// Module Name: Data_Mem
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


module Data_Mem(
input clk,
input d_ram_rena,//数据存储器读使能,1可读?璇?
input d_ram_wena,//数据存储器写使能，1可写
input [31:0] DAddr,
input [31:0] DataIn,
input [5:0] choice,
output [31:0] Data_out
    );
reg [31:0] data_out=0;
reg [31:0] memory [0:800];
reg [31:0] DAddr_temp;
reg [31:0] load_word;
parameter LB  = 6'b100000,
          LBU = 6'b010000,
          LH  = 6'b001000,
          LHU = 6'b000100,
          SB  = 6'b000010,
          SH  = 6'b000001; 
integer i;
initial 
begin
  for (i=0;i<800;i=i+1)
      memory[i]<=0;
end

always @(negedge clk)
begin
    DAddr_temp=DAddr-32'h10010000;
  if(d_ram_rena==1 && d_ram_wena==1 )
    data_out<=data_out;
  else if (d_ram_wena)
    memory[DAddr_temp] <= DataIn;
  // else if (d_ram_rena)
  //   data_out = memory[DAddr_temp];
  else begin
    load_word = memory[DAddr_temp];
    case (choice)
      LB : data_out = {{24{load_word[7]}} , load_word[7:0]};
      LBU: data_out = { 24'b0             , load_word[7:0]};
      LH : data_out = {{16{load_word[15]}}, load_word[15:0]};
      LHU: data_out = { 16'b0             , load_word[15:0]};
      SB : memory[DAddr_temp] = {24'b0 , DataIn[7:0] };
      SH : memory[DAddr_temp] = {16'b0 , DataIn[15:0]};
      default: 
        ;
    endcase
  end
end

assign    Data_out = d_ram_rena ? memory[DAddr_temp] : 
                    (choice == LB)?  {{24{ memory[DAddr_temp][7]}} , memory[DAddr_temp][7:0]} :
                    ((choice == LBU)?  { 24'b0             , memory[DAddr_temp][7:0]} :
                    ((choice == LH)?  {{16{ memory[DAddr_temp][15]}}, memory[DAddr_temp][15:0]}  :
                    ( (choice == LHU)? { 16'b0             , memory[DAddr_temp][15:0]}  : 0 )));

endmodule
