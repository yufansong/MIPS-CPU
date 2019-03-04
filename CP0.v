`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/01 09:12:05
// Design Name: 
// Module Name: CP0
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


module CP0(
input clk, 
input rst, 
// input [3:0] choice,
// input teq,              // 鐩哥瓑寮曞彂鑷櫡寮傚父 i_teq && zero
// input eret,             // 涓�?/寮傚父杩斿洖淇�?�彿 ERET(Exception Return)
// input mtc0,             // 鍐機P0淇�?�彿
// input mfc0,             // 璇籆P0淇�?�彿
input [3:0] choice,
input [31:0] pc,
input [4:0] addr,       // cp0�Ĵ�����ַ
input [3:0] cause,      // [6:2]=ExCode (syscall break teq)
input [31:0] wdata,     // write data
output [31:0] rdata,    // read data
output [31:0] exc_addr  // ���PC��ַ
);
parameter   SYSCALL = 4'b1000,
            BREAK   = 4'b1001,
            TEQ     = 4'b1101,
            IE      = 0;
wire teq  = choice [3];
wire eret = choice [2];
wire mtc0 = choice [1];
wire mfc0 = choice [0]; 

reg [31:0] cop0 [0:31];
wire [31:0] status=cop0[12];//cop[12]鐨勫垵濮嬬姸鎬佸埌搴曟槸鎬庝箞缁欏嚭鏉ョ殑锛燂紵锟�?
integer i;
initial
 begin
  for (i=0;i<32;i=i+1)
      cop0[i] = 0;
  cop0[12]={28'b0,4'b1};
end

wire exception    =    status[0]&&   ((status[1]&&cause==SYSCALL)||
                                      (status[2]&&cause==BREAK)    ||
                                      (status[3]&&cause==TEQ&&teq));

always@(posedge clk or posedge rst)
 begin
  if(rst)
   begin
    for (i=0;i<32;i=i+1)
      cop0[i] = 0;
    cop0[12]={28'b0,4'b1111};
   end
  else
   begin
    if (mtc0)
        cop0[addr] <= wdata;
    else if(exception)
        begin
          cop0[12] <= status<<5;
          cop0[13] <= {24'b0,cause,2'b0};
          cop0[14] <= pc + 32'h400000;
        end
    else if (eret)
        begin
          cop0[12] <= status>>5;  
        end
   end
end

assign exc_addr = eret ? cop0[14] - 32'h400000 : 32'h4;
assign rdata = mfc0 ? cop0[addr] : 32'hx;
endmodule
