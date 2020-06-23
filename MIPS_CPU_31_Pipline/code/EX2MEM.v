//register  EX to MEM
module EX2MEM(clk, reset, PC_in, PC_out, PCSrc_in, PCSrc_out,
    ALUOut_in, ALUOut_out, DatabusB_in, DatabusB_out, RegAddr_in, RegAddr_out,
    MemRead_in, MemRead_out, MemWrite_in, MemWrite_out,
    MemtoReg_in, MemtoReg_out, RegWrite_in, RegWrite_out);
     
    input clk, reset;
    input [31:0] PC_in;
    input [31:0] ALUOut_in;
    input [31:0] DatabusB_in;
    input [4:0] RegAddr_in;
    input [2:0] PCSrc_in;
    input MemRead_in, MemWrite_in;
    input [1:0] MemtoReg_in;
    input RegWrite_in;
    
    output [31:0] PC_out;
    output [31:0] ALUOut_out;
    output [31:0] DatabusB_out;
    output [4:0] RegAddr_out;
    output [2:0] PCSrc_out;
    output MemRead_out, MemWrite_out;
    output [1:0] MemtoReg_out;
    output RegWrite_out;
    
    reg [31:0] PC_out;
    reg [31:0] ALUOut_out;
    reg [31:0] DatabusB_out;
    reg [4:0] RegAddr_out;
    reg [2:0] PCSrc_out;
    reg MemRead_out, MemWrite_out;
    reg [1:0] MemtoReg_out;
    reg RegWrite_out;
    
    always @(posedge clk or posedge reset)
    begin
        if (reset)
        begin
            PC_out <= 32'h8000_0000;
            ALUOut_out <= 32'h0000_0000;
            DatabusB_out <= 32'h0000_0000;
            RegAddr_out <= 5'b00000;
            PCSrc_out <= 3'b000;
            MemRead_out <= 1'b0;
            MemWrite_out <= 1'b0;
            MemtoReg_out <= 2'b00;
            RegWrite_out <= 1'b0;
        end
        else 
        begin
            PC_out <= PC_in;
            ALUOut_out <= ALUOut_in;
            DatabusB_out <= DatabusB_in;
            RegAddr_out <= RegAddr_in;
            PCSrc_out <= PCSrc_in;
            MemRead_out <= MemRead_in;
            MemWrite_out <= MemWrite_in;
            MemtoReg_out <= MemtoReg_in;
            RegWrite_out <= RegWrite_in;
        end
    end
endmodule
