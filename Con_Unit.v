`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/26 10:46:15
// Design Name: 
// Module Name: sccu_dataflow
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


module Con_Unit(
//cpu31
input [5:0] op,
input [5:0] func,
input z,
output wreg,
output regrt,
output jal,
output m2reg,
output shift,
output aluimm,
output sext,
output wmem,
output [3:0] aluc,
output [1:0] pcsource,
output d_ram_wena,
output d_ram_rena,
//cp0
input [4:0] rd,
output [4:0] cause,
//others
output i_clz,
output i_jalr,
output i_bgez,
//choice
output [3:0] choice_md,
output [4:0] choice_hilo,
output [5:0] choice_mem,
output [3:0] choice_cp0
    );

wire r_type=~op[5] & ~op[4] &~op[3] &~op[2] &~op[1] &~op[0];
assign i_clz= ~op[5] & op[4] & op[3] & op[2] & ~op[1] & ~op[0]
            & func[5] & ~func[4] & ~func[3] & ~func[2] & ~func[1] & ~func[0];

assign i_jalr= r_type & ~func[5] & ~func[4] & func[3] & ~func[2] & ~func[1] & func[0];
assign i_bgez=    ~op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & op[0];

wire i_lb =   op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0];
wire i_lbu=   op[5] & ~op[4] & ~op[3] &  op[2] & ~op[1] & ~op[0];
wire i_lhu=   op[5] & ~op[4] & ~op[3] &  op[2] & ~op[1] &  op[0];
wire i_sb=    op[5] & ~op[4] &  op[3] & ~op[2] & ~op[1] & ~op[0];
wire i_sh=    op[5] & ~op[4] &  op[3] & ~op[2] & ~op[1] &  op[0];
wire i_lh =   op[5] & ~op[4] & ~op[3] & ~op[2] & ~op[1] &  op[0];

wire i_mfhi = r_type & ~func[5] &  func[4] & ~func[3] & ~func[2] & ~func[1] & ~func[0];
wire i_mflo = r_type & ~func[5] &  func[4] & ~func[3] & ~func[2] &  func[1] & ~func[0];
wire i_mthi = r_type & ~func[5] &  func[4] & ~func[3] & ~func[2] & ~func[1] &  func[0];
wire i_mtlo = r_type & ~func[5] &  func[4] & ~func[3] & ~func[2] & func[1]  &  func[0];

wire i_mul =  ~op[5] & op[4] & op[3] & op[2] & ~op[1] & ~op[0]
                     & ~func[5] & ~func[4] & ~func[3] & ~func[2] &  func[1] & ~func[0];
wire i_multu= r_type & ~func[5] &  func[4] &  func[3] & ~func[2] & ~func[1] &  func[0];
wire i_div= ~func[5] & func[4] & func[3] & ~func[2] & func[1] & ~func[0];
wire i_divu= r_type & ~func[5] & func[4] & func[3] & ~func[2] & func[1] & func[0];

wire i_syscall=r_type& ~func[5] &  ~func[4]&  func[3] &  func[2] & ~func[1] & ~func[0];
wire i_teq=   r_type &  func[5] &  func[4] & ~func[3] &  func[2] & ~func[1] & ~func[0];
wire i_break=  r_type& ~func[5] &  ~func[4]&  func[3] &  func[2] & ~func[1] &  func[0];
wire i_mtc0 = ~op[5] & op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0]
                     & ~func[5] & ~func[4] & ~func[3] & ~func[2] & ~func[1] & ~func[0] &  rd[2];
wire i_mfc0= ~op[5] & op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0]
                     & ~func[5] & ~func[4] & ~func[3] & ~func[2] & ~func[1] & ~func[0] & ~rd[2];
wire i_eret= ~op[5] & op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0]
            & ~func[5] & func[4] & func[3] & ~func[2] & ~func[1] & ~func[0];



//choice 
assign choice_hilo = { i_mfhi, i_mflo , i_mthi, i_mtlo , (i_div | i_divu | i_multu)};
assign choice_md   = { i_div , i_divu , i_mul , i_multu};
assign choice_mem  = { i_lb , i_lbu , i_lh , i_lhu , i_sb , i_sh}; 
assign choice_cp0  = { i_teq , i_eret , i_mtc0 , i_mfc0};

parameter   SYSCALL = 4'b1000,
            BREAK   = 4'b1001,
            TEQ     = 4'b1101;
assign cause = i_syscall ? SYSCALL :
                ( i_break ? BREAK :
                ( i_teq ? TEQ : 4'b0000 ));
//////////////////////////////////////////////////////////////////////////////////////


wire i_add=r_type & func[5] & ~func[4] & ~func[3] &~ func[2] & ~func[1] & ~func[0];
wire i_addu=r_type & func[5] & ~func[4] & ~func[3] &~ func[2] & ~func[1] & func[0];
wire i_sub=r_type & func[5] & ~func[4] &~ func[3] & ~func[2] & func[1] & ~func[0];
wire i_subu=r_type & func[5] & ~func[4] & ~func[3] &~ func[2] & func[1] & func[0];
wire i_and=r_type & func[5] & ~func[4] & ~func[3] & func[2] & ~func[1] & ~func[0];
wire i_or= r_type & func[5] & ~func[4] & ~func[3] & func[2] & ~func[1] & func[0];
wire i_xor=r_type & func[5] & ~func[4] & ~func[3] & func[2] & func[1] & ~func[0];
wire i_nor= r_type & func[5] & ~func[4] & ~func[3] & func[2] & func[1] & func[0];
wire i_slt= r_type & func[5] & ~func[4] & func[3] & ~func[2] & func[1] & ~func[0];
wire i_sltu= r_type & func[5] & ~func[4] & func[3] & ~func[2] & func[1] & func[0];
wire i_sll= r_type & ~func[5] & ~func[4] & ~func[3] & ~func[2] & ~func[1] & ~func[0];
wire i_srl= r_type & ~func[5] & ~func[4] & ~func[3] & ~func[2] & func[1] & ~func[0];
wire i_sra= r_type & ~func[5] & ~func[4] & ~func[3] & ~func[2] & func[1] & func[0];
wire i_sllv= r_type & ~func[5] & ~func[4] & ~func[3] & func[2] & ~func[1] & ~func[0];
wire i_srlv= r_type & ~func[5] & ~func[4] & ~func[3] & func[2] & func[1] & ~func[0];
wire i_srav= r_type & ~func[5] & ~func[4] & ~func[3] & func[2] & func[1] & func[0];
wire i_jr= r_type & ~func[5] & ~func[4] & func[3] & ~func[2] & ~func[1] & ~func[0];

wire i_addi= ~op[5] & ~op[4] & op[3] & ~op[2] & ~op[1] & ~op[0];
wire i_addiu= ~op[5] & ~op[4] & op[3] & ~op[2] & ~op[1] & op[0];
wire i_andi= ~op[5] & ~op[4] & op[3] & op[2] & ~op[1] & ~op[0];
wire i_ori= ~op[5] & ~op[4] & op[3] & op[2] & ~op[1] & op[0];
wire i_xori= ~op[5] & ~op[4] & op[3] & op[2] & op[1] & ~op[0];
wire i_lw= op[5] & ~op[4] & ~op[3] & ~op[2] & op[1] & op[0];
wire i_sw= op[5] & ~op[4] & op[3] & ~op[2] & op[1] & op[0];
wire i_beq= ~op[5] & ~op[4] & ~op[3] & op[2] & ~op[1] & ~op[0];
wire i_bne= ~op[5] & ~op[4] & ~op[3] & op[2] & ~op[1] & op[0];
wire i_slti= ~op[5] & ~op[4] & op[3] & ~op[2] & op[1] & ~op[0];
wire i_sltiu= ~op[5] & ~op[4] & op[3] & ~op[2] & op[1] & op[0];
wire i_lui= ~op[5] & ~op[4] & op[3] & op[2] & op[1] & op[0];
wire i_j= ~op[5] & ~op[4] & ~op[3] & ~op[2] & op[1] & ~op[0];
wire i_jal= ~op[5] & ~op[4] & ~op[3] & ~op[2] & op[1] & op[0];

assign wreg       = i_add | i_sub | i_and | i_xor | i_sll | i_srl | i_sra | i_or |
                    i_addi | i_andi | i_ori | i_xori | i_lw | i_lui | i_jal |
                    i_addu | i_subu | i_nor | i_slt | i_sltu | i_sllv | i_srlv |
                    i_srav | i_addiu | i_slti | i_sltiu |
                    i_mfc0 | i_mul | i_clz | i_jalr | i_lb | i_lbu | i_lh | i_lhu | i_mfhi | i_mflo;
assign regrt      = i_addi | i_andi | i_ori | i_xori | i_lw | i_lui | //i_jal | 这个�?要加上么？？�?
                    i_addiu | i_slti | i_sltiu |
                    i_mfc0 | i_lb | i_lbu | i_lh | i_lhu ;
assign jal        = i_jal;
assign m2reg      = i_lw |
                    i_lb | i_lbu | i_lh | i_lhu ;
assign shift      = i_sll | i_srl | i_sra ;
assign aluimm     = i_addi | i_andi | i_ori | i_xori | i_lw | i_lui | i_sw |
                    i_addiu | i_slti | i_sltiu |
                    i_lb | i_lbu | i_lh | i_lhu | i_sb | i_sh;
assign sext       = i_addi | i_lw | i_sw | i_beq | i_bne |
                    i_slti | i_addiu;
assign aluc[3]    = i_slt | i_sltu | i_sll | i_srl | i_sra | i_sllv | i_srlv | i_srav | i_slti | i_sltiu | i_lui;
assign aluc[2]    = i_and | i_or | i_xor | i_nor | i_sll | i_srl | i_sra |i_sllv | i_srlv | i_srav | i_andi | i_ori | i_xori ;
assign aluc[1]    = i_add | i_sub | i_xor | i_nor | i_slt | i_sltu | i_sll | i_sllv | i_addi | i_xori | i_lw | i_sw | i_beq | i_bne | i_slti | i_sltiu ;
assign aluc[0]    = i_sub | i_subu | i_or | i_nor | i_slt | i_srl | i_srlv | i_ori | i_beq | i_bne | i_slti;
assign wmem       = i_sw ;
assign pcsource[1]= i_jr | i_j | i_jal ;
assign pcsource[0]= i_beq&z | i_bne&~z | i_j | i_jal;
assign d_ram_wena = i_sw;
assign d_ram_rena = i_lw;
///////////////////////////////////////////////////////////////////////

endmodule


// wire i_unimplemented = ~(i_mfc0 | i_mtc0 | i_eret | i_syscall |
//                 i_add | i_sub | i_and | i_or | i_xor | i_sll | i_srl |
//                 i_sra | i_jr | i_addi | i_andi | i_ori | i_xori | i_lw |
//                 i_sw | i_beq | i_bne | i_lui | i_j | i_jal);



//?????????? 4? ???? ???? ????? ??

// wire overflow = ov & (i_add | i_sub | i_addi);
// wire int_int  = sta[0] & intr;
// wire exc_sys  = sta[1] & i_syscall;//??
// wire exc_uni  = sta[2] & unimplemented_inst;//??
// wire exc_ovr  = sta[3] & overflow;
// assign exc    = int_int | exc_ovr | exc_sys | exc_uni;
// assign inta   = int_int;
// // ExcCode 00 ???? 01 ????  10 ?????? 11 ??
// wire ExcCode0 = i_syscall | overflow;   //??
// wire ExcCode1 = unimplemented_inst | overflow ;//??
// assign cause  = { 28'h0 , ExcCode1 , ExcCode0 , 2'b00 };
// //??3??????????
// assign mtc0 = i_mtc0;//??
// assign wsta = exc | mtc0 & rd_is_status | i_eret;
// assign wcau = exc | mtc0 & rd_is_cause;
// assign wepc = exc | mtc0 & rd_is_epc;

// wire rd_is_status = {rd == 5'd12};//cp0 status register
// wire rd_is_cause  = {rd == 5'd13};//cp0 cause register
// wire rd_is_epc    = {rd == 5'd14};//cp0 epc register
// assign mfc0[0]    = i_mfc0 & rd_is_status | i_mfc0 & rd_is_epc;
// assign mfc0[1]    = i_mfc0 & rd_is_cause  | i_mfc0 & rd_is_epc;

// //00:??? 01:EPC 10:????????????
// assign selpc[0] = i_eret;
// assign selpc[1] = exc;
