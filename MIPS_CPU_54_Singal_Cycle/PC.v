`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/25 10:23:58
// Design Name: 
// Module Name: PC
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


module PC(
input clk,
input rst,
input jal,
input [31:0] jpc,
input [1:0] pcsource,
input [31:0] ra,
input [31:0] offset,
input [3:0] cause,
input buzy,
input i_jalr,
input i_bgez,
input i_eret,
input [31:0] inst,
input [31:0] exc_addr,
output [31:0] pc,
output [31:0] p4
    );

reg [31:0]pc_show_temp=0;
reg [31:0]p4_temp=0;
reg [31:0]adr_temp=0;
reg [31:0]pc_temp=0;
reg [31:0] jpc_temp=0;
parameter EXC_BASE = 32'h00000004; //base
parameter   SYSCALL = 4'b1000,
            BREAK   = 4'b1001,
            TEQ     = 4'b1101;

always @(posedge clk or posedge rst)
begin
  if (rst==1)begin
    pc_temp=0;
    pc_show_temp=pc_temp+32'h400000;
  end
  else
  begin
    jpc_temp = jpc-32'h400000;
    if ((cause == SYSCALL | cause == BREAK | cause == TEQ) == 1)
      p4_temp = EXC_BASE;
    else if (i_eret)
      p4_temp = exc_addr;
    else if ( buzy )
      p4_temp = p4_temp;
    else if (i_jalr)
      p4_temp = ra -32'h400000;
    else if (i_bgez & ra[31]==0)
      p4_temp = pc_temp + 4 + {2'b00 , inst[15:0] , 2'b00};
    else 
      p4_temp = pc_temp + 4;
    adr_temp = p4_temp+offset;
    pc_show_temp=pc_temp+32'h400000;
    case (pcsource)
      2'b00: pc_temp=p4_temp;
      2'b01: pc_temp=adr_temp;
      2'b10: pc_temp=ra-32'h400000;
      2'b11: pc_temp=jpc_temp;
      default: pc_temp=0;
    endcase
  end
    if (pc_temp==32'h00000b54)
      pc_temp=pc_temp;
end

assign p4=jal?p4_temp+32'h400004:p4_temp;
// assign adr=adr_temp;
assign pc=pc_temp;
// assign pc_show=pc_temp+32'h400000;

endmodule