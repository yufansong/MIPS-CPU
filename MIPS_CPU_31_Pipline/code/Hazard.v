//hazard
module Hazard(IRQ, PCSrc_ID, PCSrc_EX, Branch_EX, MemRead_EX, Rs_ID, Rt_ID, Rt_EX,
    flush_IF2ID, flush_ID2EX, Write_IF2ID, Write_PC);
    
    input IRQ; 
    input [2:0]PCSrc_ID, PCSrc_EX;
    input MemRead_EX, Branch_EX;
    input [4:0] Rs_ID, Rt_ID, Rt_EX;
    
    output flush_IF2ID, flush_ID2EX;
    output Write_IF2ID, Write_PC;
    
    //flush IF2ID when branch success and j
    assign flush_IF2ID = 
        ((PCSrc_EX==3'b001 && Branch_EX) || (PCSrc_ID == 3'b010) || (PCSrc_ID == 3'b011)) ? 1:0;
    
    //flush ID2EX when branch success, lw
    assign flush_ID2EX = 
        (IRQ) ? 0:
        ((MemRead_EX && (Rt_EX == Rs_ID || Rt_EX == Rt_ID)) || (PCSrc_EX==3'b001 && Branch_EX)) ? 1:0;
    
    //bubble when lw 
    assign Write_IF2ID = 
        (MemRead_EX && (Rt_EX == Rs_ID || Rt_EX == Rt_ID)) ? 0:1;
    assign Write_PC = 
        (MemRead_EX && (Rt_EX == Rs_ID || Rt_EX == Rt_ID)) ? 0:1;

endmodule

    