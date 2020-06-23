//register from ID to EX
module ID2EX(clk, reset, flush_ID2EX, PC_in, PC_out, 
    DatabusA_in, DatabusA_out, DatabusB_in, DatabusB_out,  Imm_in, Imm_out,// ConBA_in, ConBA_out,
    Rs_in, Rs_out, Rt_in, Rt_out, Rd_in, Rd_out, shamt_in, shamt_out,
    ALUSrc1_in, ALUSrc1_out, ALUSrc2_in, ALUSrc2_out, ALUFun_in, ALUFun_out, Sign_in, Sign_out, RegDst_in, RegDst_out,
    MemRead_in, MemRead_out, MemWrite_in, MemWrite_out, PCSrc_in, PCSrc_out,
    MemtoReg_in, MemtoReg_out, RegWrite_in, RegWrite_out);
 
    input reset, clk, flush_ID2EX;
    input [31:0] PC_in;
    input [31:0] DatabusA_in, DatabusB_in;
    input [31:0] Imm_in;// ConBA_in;
    input [5:0] ALUFun_in;
    input [4:0] Rs_in, Rd_in, Rt_in, shamt_in;
    input ALUSrc1_in, ALUSrc2_in;
    input [1:0] RegDst_in;
    input Sign_in;
    input MemRead_in, MemWrite_in;
    input [2:0] PCSrc_in;
    input [1:0] MemtoReg_in;
    input RegWrite_in;
    
    output [31:0] PC_out;
    output [31:0] DatabusA_out, DatabusB_out;
    output [31:0] Imm_out;//ConBA_out;
    output [5:0] ALUFun_out;
    output [4:0] Rs_out, Rd_out, Rt_out, shamt_out;
    output ALUSrc1_out, ALUSrc2_out;
    output [1:0] RegDst_out;
    output Sign_out;
    output MemRead_out, MemWrite_out;
    output [2:0] PCSrc_out;
    output [1:0] MemtoReg_out;
    output RegWrite_out;
    
    reg [31:0] PC_out;
    reg [31:0] DatabusA_out, DatabusB_out;
    reg [31:0] Imm_out;//ConBA_out;
    reg [5:0] ALUFun_out;
    reg [4:0] Rs_out, Rd_out, Rt_out, shamt_out;
    reg ALUSrc1_out, ALUSrc2_out;
    reg [1:0] RegDst_out;
    reg Sign_out;
    reg MemRead_out, MemWrite_out;
    reg [2:0] PCSrc_out;
    reg [1:0] MemtoReg_out;
    reg RegWrite_out;
    
    always @(posedge clk or posedge reset)
    begin
        if (reset)
        begin
            PC_out <= 32'h8000_0000;
            DatabusA_out <= 32'h0000_0000;
            DatabusB_out <= 32'h0000_0000;
            Imm_out <= 32'h0000_0000;
            //ConBA_out <= 32'h0000_0000;
            Rs_out <= 5'b00000;
            Rd_out <= 5'b00000;
            Rt_out <= 5'b00000;
            shamt_out <= 5'b00000;
            ALUFun_out <= 6'b000000;
            ALUSrc1_out <= 1'b0;
            ALUSrc2_out <= 1'b0;
            RegDst_out <= 2'b00;
            Sign_out <= 1'b0;
            MemRead_out <=1'b0;
            MemWrite_out <= 1'b0;
            PCSrc_out <= 3'b000;
            MemtoReg_out <= 2'b00;
            RegWrite_out <= 1'b0;
        end
        else if (flush_ID2EX)
        begin
            PC_out <= PC_in;
            DatabusA_out <= 32'h0000_0000;
            DatabusB_out <= 32'h0000_0000;
            Imm_out <= 32'h0000_0000;
            //ConBA_out <= 32'h0000_0000;
            Rs_out <= 5'b00000;
            Rd_out <= 5'b00000;
            Rt_out <= 5'b00000;
            shamt_out <= 5'b00000;
            ALUFun_out <= 6'b000000;
            ALUSrc1_out <= 1'b0;
            ALUSrc2_out <= 1'b0;
            RegDst_out <= 2'b00;
            Sign_out <= 1'b0;
            MemRead_out <=1'b0;
            MemWrite_out <= 1'b0;
            PCSrc_out <= 3'b000;
            MemtoReg_out <= 2'b00;
            RegWrite_out <= 1'b0;
        end
        else
        begin
            PC_out <= PC_in;
            DatabusA_out <= DatabusA_in;
            DatabusB_out <= DatabusB_in;
            Imm_out <= Imm_in;
            //ConBA_out <= ConBA_in;
            Rs_out <= Rs_in;
            Rd_out <= Rd_in;
            Rt_out <= Rt_in;
            shamt_out <= shamt_in;
            ALUFun_out <= ALUFun_in;
            ALUSrc1_out <= ALUSrc1_in;
            ALUSrc2_out <= ALUSrc2_in;
            RegDst_out <= RegDst_in;
            Sign_out <= Sign_in;
            MemRead_out <= MemRead_in;
            MemWrite_out <= MemWrite_in;
            PCSrc_out <= PCSrc_in;
            MemtoReg_out <= MemtoReg_in;
            RegWrite_out <= RegWrite_in;
        end
    end
endmodule
     