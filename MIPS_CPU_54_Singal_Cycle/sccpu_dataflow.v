`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/26 22:50:35
// Design Name: 
// Module Name: sccpu_dataflow
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


module cpu(
input clk,
input rst,
input [31:0] inst,
input [31:0] mem,
input intr,
output inta,
//output wmem,
output [31:0] pc,
output [31:0] alu,
output [31:0] data,
output d_ram_rena,
output d_ram_wena,
output [5:0] choice_mem
    );

parameter EXC_BASE = 32'h00000004; //base

wire [31:0] pc_show;////
wire [31:0] p4,bpc,npc,adr,ra,alua,alub,res,alu_mem;
wire [3:0]  aluc;
wire [4:0]  reg_dest,wn; 
wire [1:0]  pcsource;
wire        zero,wmem,wreg,regrt,m2reg,shift,aluimm,jal,sext;//d_ram_wena,d_ram_rena;
wire [31:0] sa = {27'b0, inst[10:6]};
////////////////////cpu54
wire [3:0] choice_md;
wire [4:0] choice_hilo;
//wire [5:0] choice_mem;
wire [3:0] choice_cp0;
wire buzy;
wire [31:0] q;
wire [31:0] r;
wire [ 3:0] cause;
wire [31:0] exc_addr;
wire [31:0] data_rc;
wire i_clz , i_jalr , i_bgez;
wire [31:0] clz_num;

wire        e = sext & inst[15];
wire [15:0] imm = {16{e}};
wire [31:0] immediate = {imm,inst[15:0]};
wire [31:0] offset = {imm[13:0],inst[15:0],2'b00};
wire [31:0] jpc ={p4[31:28],inst[25:0],2'b00};
wire [31:0] Hi_o , Lo_o;



////////////////////////////////

Mul_32 alu_b (aluimm,data,immediate,alub);
Mul_32 alu_a (shift,ra,sa,alua);
Mul_32 result (m2reg,alu,mem,alu_mem);
Mul_32 link (jal,alu_mem,p4,res);
Mul_5 reg_wn (regrt,inst[15:11],inst[20:16],reg_dest);

assign wn = reg_dest| {5{jal}} ;
wire [31:0] res_all = choice_cp0[0] ? data_rc :
              (i_clz? clz_num : 
              (i_jalr?  pc + 4 + 32'h400000: 
              (choice_hilo[4] ? Hi_o :
              (choice_hilo[3] ? Lo_o  :
              ( choice_md[1] ?  r : res)))));
// wire [31:0] res_all = choice_cp0[0] ? data_rc :
//               (i_clz? clz_num : 
//               (i_jalr?  pc + 4 + 32'h400000:res));


PC 
PC_inst(
.clk(clk),
.rst(rst),
.jal(jal),
.jpc(jpc),
.pcsource(pcsource),
.ra(ra),
.offset(offset),
.cause(cause),
.buzy(buzy),
.i_jalr(i_jalr),
.i_bgez(i_bgez),
.i_eret(choice_cp0[2]),
.inst(inst),
.exc_addr(exc_addr),
.pc(pc),
.p4(p4)
);

Con_Unit 
Con_Unit_inst (
.op(inst[31:26]),
.func(inst[5:0]),
.z(zero),
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
.rd(inst[25:21]),
.cause(cause),
.i_clz(i_clz),
.i_jalr(i_jalr),
.i_bgez(i_bgez),
.choice_md(choice_md),
.choice_hilo(choice_hilo),
.choice_mem(choice_mem),
.choice_cp0(choice_cp0)
);

ALU 
alu_unit(
.a(alua),
.b(alub),
.aluc(aluc),
.r(alu),
.zero(zero)
// .carry(carry),
// .negative(negative),
// .overflow(overflow)
);

Clz
Clz_inst(
.clk(clk),
.data(ra),
.num(clz_num)
);




CP0
CP0_inst(
.clk(clk),
.rst(rst),
.choice(choice_cp0),
.pc(pc),
.cause(cause),
.addr(inst[15:11]),
.wdata(data),
.rdata(data_rc),
.exc_addr(exc_addr)
);



Hi_Lo
Hi_Lo_inst(
.clk(clk),
.rst(rst),
.choice(choice_hilo),
.Hi_i(ra),
.Lo_i(ra),
.mul_h(q),
.mul_l(r),
.Hi_o(Hi_o),
.Lo_o(Lo_o)
);

Mul_Div
Mul_Div_inst(
.choice(choice_md),
.a(ra),
.b(data),
.clk(clk),
.rst(rst),
.q(q),
.r(r)
);



regfile
cpu_ref(
.clk(clk),
.clrn(rst),
.we(wreg),
.rna(inst[25:21]),
.rnb(inst[20:16]),
.wn(wn),
.d(res_all),
.qa(ra),
.qb(data)
);

// wire carry,negative,overflow;

endmodule



//////////////////////////////////pc module
// reg [31:0]pc_show_temp=0;
// reg [31:0]p4_temp=0;
// reg [31:0]adr_temp=0;
// reg [31:0]pc_temp=0;
// reg [31:0] jpc_temp=0;
// always @(posedge clk)
// begin
//   if (rst==1)begin
//     pc_temp=0;
//     pc_show_temp=pc_temp+32'h400000;
//   end
//   else
//   begin
//     jpc_temp = jpc-32'h400000;
//     p4_temp = pc_temp +4;
//     // p4_temp = (choice_cp0[3] | choice_cp0[1] | choice_cp0[0]) ? EXC_BASE : //cp0
//     //           ( buzy ? p4_temp :
//     //           ( i_jalr? ra :
//     //           ((i_bgez & ra[31]==1) ? {2'b1 , inst[15:0] , 2'b00} : pc_temp+4)));// div mul
//     adr_temp = p4_temp+offset;
//     pc_show_temp=pc_temp+32'h400000;
//     case (pcsource)
//       2'b00: pc_temp=p4_temp;
//       2'b01: pc_temp=adr_temp;
//       2'b10: pc_temp=ra-32'h400000;
//       2'b11: pc_temp=jpc_temp;
//       default: pc_temp=0;
//     endcase
//   end
//     // if (pc==32'h100)
//     //   pc_temp=pc_temp;
// end

// assign p4=jal?p4_temp+32'h400004:p4_temp;
// assign adr=adr_temp;
// assign pc=pc_temp;
// assign pc_show=pc_temp+32'h400000;
////////////////////////////////////////////////////////
