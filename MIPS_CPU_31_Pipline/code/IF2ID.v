//register from IF to ID
module IF2ID(clk, reset, instruction_in, instruction_out, 
    PC_in, PC_out, flush_IF2ID, Write_IF2ID);
    input clk;
    input reset;
    input flush_IF2ID;
    input [31:0] instruction_in;
    input [31:0] PC_in;
    input Write_IF2ID; 
    
    output [31:0] instruction_out;
    output [31:0] PC_out;
    
    reg [31:0] instruction_out;
    reg [31:0] PC_out;
    
    always @(posedge clk or posedge reset)
    begin
        if (reset)
        begin 
            PC_out <= 32'h8000_0000;
            instruction_out <= 32'h0000_0000;
        end
        else if (flush_IF2ID)
        begin
            PC_out <= PC_in;
            instruction_out <= 32'h0000_0000;
        end
        else if(Write_IF2ID)
        begin
            instruction_out <= instruction_in;
            PC_out <= PC_in;
        end
    end
endmodule