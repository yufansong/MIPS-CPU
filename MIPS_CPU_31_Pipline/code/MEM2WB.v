//register MEM to WB
module MEM2WB(clk, reset, PC_in, PC_out,
    ReadData_in, ReadData_out, ALUOut_in, ALUOut_out, RegAddr_in, RegAddr_out,
    MemtoReg_in, MemtoReg_out, RegWrite_in, RegWrite_out);
    
    input clk, reset;
    input [31:0] PC_in;
    input [31:0] ReadData_in;
    input [31:0] ALUOut_in;
    input [4:0] RegAddr_in;
    input [1:0] MemtoReg_in;
    input RegWrite_in;
    
    output [31:0] PC_out;
    output [31:0] ReadData_out;
    output [31:0] ALUOut_out;
    output [4:0] RegAddr_out;
    output [1:0] MemtoReg_out;
    output RegWrite_out;
    
    reg [31:0] PC_out;
    reg [31:0] ReadData_out;
    reg [31:0] ALUOut_out;
    reg [4:0] RegAddr_out;
    reg [1:0] MemtoReg_out;
    reg RegWrite_out;
    
    always @(posedge clk or posedge reset)
    begin
        if (reset)
        begin
            PC_out <= 32'h8000_0000;
            ReadData_out <= 32'h0000_0000;
            ALUOut_out <= 32'h0000_0000;
            RegAddr_out <= 5'b00000;
            MemtoReg_out <= 2'b00;
            RegWrite_out <= 1'b0;
        end 
        else 
        begin
            PC_out <= PC_in;
            ReadData_out <= ReadData_in;
            ALUOut_out <= ALUOut_in;
            RegAddr_out <= RegAddr_in;
            MemtoReg_out <= MemtoReg_in;
            RegWrite_out <= RegWrite_in;
        end
    end
endmodule
