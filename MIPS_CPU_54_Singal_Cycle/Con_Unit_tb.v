`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/26 16:20:25
// Design Name: 
// Module Name: sccu_dataflow_tb
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


module Con_Unit_tb( 
    );
reg [5:0] op=0;
reg [5:0] func=0;
reg z=0;
wire wreg;
wire regrt;
wire jal;
wire m2reg;
wire shift;
wire aluimm;
wire sext;
wire wmem;
wire [3:0] aluc;
wire [1:0] pcsource;
wire d_ram_wena;
wire d_ram_rena;
reg  [4:0] rd;
wire [4:0] cause;
wire i_clz;
wire i_jalr;
wire i_bgez;
wire [3:0] choice_md;
wire [3:0] choice_hilo;
wire [5:0] choice_mem;
wire [3:0] choice_cp0;
initial
begin
#10 op = 6'b000000;func = 6'b001001;
//   #10 op=6'b000000; func=6'b100000;//add
//   #10 op=6'b000000; func=6'b100010;//sub
//   #10 op=6'b000000; func=6'b100100;//and
//   #10 op=6'b000000; func=6'b100101;//or
//   #10 op=6'b000000; func=6'b100110;//xor
//   #10 op=6'b000000; func=6'b000000;//sll
//   #10 op=6'b000000; func=6'b000010;//srl
//   #10 op=6'b000000; func=6'b000011;//sra
//   #10 op=6'b000000; func=6'b001000;//jr
//   #10 op=6'b001000;//addi
//   #10 op=6'b001100;//andi
//   #10 op=6'b001101;//ori
//   #10 op=6'b001110;//xori
//   #10 op=6'b100011;//lw
//   #10 op=6'b101011;//sw
//   #10 op=6'b000100;//beq
//   #10 op=6'b000101;//bne
//   #10 op=6'b001111;//lui
//   #10 op=6'b000010;//j
//   #10 op=6'b000011;//jal
//   #10 op=6'b000000; func=6'b100001;//addu
//   #10 op=6'b000000; func=6'b100011;//subu
//   #10 op=6'b000000; func=6'b100111;//nor
//   #10 op=6'b000000; func=6'b101010;//slt
//   #10 op=6'b000000; func=6'b101011;//sltu
//   #10 op=6'b000000; func=6'b000100;//sllv
//   #10 op=6'b000000; func=6'b000110;//srlv
//   #10 op=6'b000000; func=6'b000111;//srav
//   #10 op=6'b001001;//addiu
//   #10 op=6'b001010;//slti
//   #10 op=6'b001011;//sltiu

  // #10 op=6'b000000; func=6'b100101;//or
//   #10 op=6'b000000; func=6'b100011;//subu
//   #10 op=6'b000000; func=6'b000111;//srav
//   #10 op=6'b100011; //lw
//   #10 op=6'b101011; //sw


end



Con_Unit
Con_Unit_inst(
.op(op),
.func(func),
.z(z),
.wreg(wreg),
.regrt(regrt),
.jal(jal),
.m2reg(m2reg),
.shift(shift),
.aluimm(aluimm),
.sext(sext),
.wmem(wmem),
.aluc(aluc),
.pcsource(pcsource),
.d_ram_wena(d_ram_wena),
.d_ram_rena(d_ram_rena),
.rd(rd),
.cause(cause),
.i_clz(i_clz),
.i_jalr(i_jalr),
.i_bgez(i_bgez),
.choice_md(choice_md),
.choice_hilo(choice_hilo),
.choice_mem(choice_mem),
.choice_cp0(choice_cp0)
);


endmodule
