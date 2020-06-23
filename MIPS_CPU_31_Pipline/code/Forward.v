//forward 
module Forward(Rt_ID, Rs_ID, Rs_EX, Rt_EX, RegAddr_MEM, RegAddr_WB, RegAddr_EX,
    RegWrite_MEM, RegWrite_WB, RegWrite_EX, ALUSrc1, 
    ForwardRs, ForwardRt, ForwardJr, ForwardRs_ID, ForwardRt_ID);
     
    input [4:0] Rt_ID, Rs_ID, Rs_EX, Rt_EX, RegAddr_MEM, RegAddr_WB, RegAddr_EX;
    input RegWrite_MEM, RegWrite_WB, RegWrite_EX, ALUSrc1;
    output [1:0] ForwardRs, ForwardRt, ForwardJr;
    output ForwardRs_ID, ForwardRt_ID;
    
    //Rs，Rt先写后读的转发
    assign ForwardRs_ID =
        (RegWrite_WB && Rs_ID==RegAddr_WB)? 1:0;
    assign ForwardRt_ID =
        (RegWrite_WB && Rt_ID==RegAddr_WB)? 1:0;
        
    //ALU输入Rs，Rt的转发
    //Rt的转发包含sw的转发，由于ALUSrc2为0需要Rt的转发，如果为1需要Sw的转发，这里
    //将这一条件删去
    assign ForwardRs = 
        (RegWrite_MEM && RegAddr_MEM!=5'd0 && !ALUSrc1 && Rs_EX==RegAddr_MEM) ? 2'b01:
        (RegWrite_WB && RegAddr_WB!=5'd0 && !ALUSrc1 && Rs_EX==RegAddr_WB) ? 2'b10:
        2'b00;
    assign ForwardRt = 
        (RegWrite_MEM && RegAddr_MEM!=5'd0 && Rt_EX==RegAddr_MEM) ? 2'b01:
        (RegWrite_WB && RegAddr_WB!=5'd0 && Rt_EX==RegAddr_WB) ? 2'b10:
        2'b00;
        
    //jr，jalr的转发
    assign ForwardJr =
        (RegWrite_EX && RegAddr_MEM!=5'd0 && Rs_ID==RegAddr_EX) ? 2'b01:
        (RegWrite_MEM && RegAddr_MEM!=5'd0 && Rs_ID==RegAddr_MEM) ? 2'b10:
        2'b00;

endmodule