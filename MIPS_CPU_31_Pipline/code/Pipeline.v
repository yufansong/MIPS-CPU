//top pipeline
// module pipeline(sysclk, reset, UART_RX, UART_TX, led, digi);
// module pipeline(sysclk, reset,o_seg,o_sel,show_data_d);
module pipeline(sysclk, reset,o_seg,o_sel);
    input sysclk, reset;
    // input UART_RX;
    // output UART_TX;
    // output [7:0] led;
    // output [11:0] digi;
    


    wire IRQ;
    wire clk;
    // assign clk = sysclk;
    //always@(posedge sysclk) clk <= ~clk;


    //show
    reg UART_RX = 1;
    wire UART_TX;
    wire [7:0] led;
    wire [11:0] digi;
    
    output [7:0] o_seg;
    output [7:0] o_sel;
    // output [31:0] show_data_d;
    wire [31:0] show_data_d;
    Divider
    Divider_inst(
    .i_clk(sysclk),
    .rst(reset),
    .o_clk(clk)
    );
    //show end




    //IF
    reg [31:0] PC_IF_reg;//??
    wire [31:0] PC_IF;//??
    wire [31:0] instruction_IF_A, instruction_IF;//??
    wire [2:0] PCSrc;
    parameter ILLOP = 32'h8000_0004;
    parameter XADR = 32'h8000_0008;
    
    //ID
    wire [31:0] instruction_ID, instructionNoforward_ID;
    wire [31:0] PC_ID, PCNoforward_ID;
    wire [31:0] DatabusA_ID, DatabusB_ID;
    wire [31:0] DatabusAForward_ID, DatabusBForward_ID;
    wire [31:0] Imm_ID, ExtOut, ConBA_ID, JT_ID;
    wire [5:0] ALUFun_ID;
    wire [4:0] Rs_ID, Rd_ID, Rt_ID, shamt_ID;
    wire ALUSrc1_ID, ALUSrc2_ID, ExtOp, LuOp;
    wire [1:0] RegDst_ID;
    wire [2:0] PCSrc_ID;
    wire Sign_ID;
    wire MemRead_ID, MemWrite_ID;
    wire [1:0] MemtoReg_ID;
    wire RegWrite_ID;
    
    //EX
    wire [31:0] PC_EX;
    wire [31:0] DatabusA_EX, DatabusB_EX, Imm_EX;
    wire [31:0] ALUInput1_EX, ALUInput2_EX;
    wire [31:0] DatabusAForward_EX, DatabusBForward_EX;
    wire [31:0] ALUOut_EX;
    wire [31:0] ConBA_EX;
    wire [4:0] Rs_EX, Rt_EX, Rd_EX, RegAddr_EX, shamt_EX;
    wire [5:0] ALUFun_EX;
    wire [1:0] RegDst_EX;
    wire [2:0] PCSrc_EX;
    wire ALUSrc1_EX, ALUSrc2_EX, Sign_EX, MemRead_EX, MemWrite_EX, RegWrite_EX;
    wire [1:0] MemtoReg_EX;
    wire Zero;
    
    //MEM
    wire [31:0] PC_MEM;
    wire [31:0] ALUOut_MEM, DatabusB_MEM;
    wire [31:0] ReadData_MEM, ReadData_MEM1, ReadData_MEM2;
    wire [4:0] RegAddr_MEM;
    wire [2:0] PCSrc_MEM;
    wire MemRead_MEM, MemWrite_MEM, RegWrite_MEM;
    wire [1:0] MemtoReg_MEM;
    
    //WB
    wire [31:0] PC_WB;
    wire [31:0] ReadData_WB, ALUOut_WB, DatabusC_WB;
    wire [4:0] RegAddr_WB;
    wire [1:0] MemtoReg_WB;
    wire RegWrite_WB;
    
    //forward
    wire [1:0] ForwardRs, ForwardRt, ForwardJr;
    wire ForwardRs_ID, ForwardRt_ID;
    wire [31:0] DatabusJr;
    
    //Hazard
    wire flush_IF2ID, flush_ID2EX, Write_IF2ID, Write_PC;
    
    //PC
    wire [31:0] PC_next, PCPlus4;
    
//================================================================================
 
    //IF
    InstructionMemory instructionM(PC_IF[30:2], instruction_IF_A);
    
    assign instruction_IF = (IRQ) ? 32'h0000_0000: instruction_IF_A; //IRQ的时候清除IF阶段的指�?
    
    IF2ID r1(clk, reset, instruction_IF, instructionNoforward_ID, 
        PC_IF, PCNoforward_ID, flush_IF2ID, Write_IF2ID);
    
    //ID
    assign PC_ID = 
        (IRQ && PCSrc_EX==3'b001 && Zero) ? ConBA_EX:  //IRQ的时候为了做�?$k0的存储，在这里进行PC的转�?
        (IRQ && PCSrc_MEM == 3'b001 && ALUOut_MEM[0]) ? PC_IF: //由于$k0中存的是ID阶段的PC，这里对EX，MEM阶段�?
        (IRQ && PCSrc_EX==3'b010) ? PC_IF: PCNoforward_ID;     //PCSrc做判断，解决分支和跳转指令的终端存储问题
        
    assign instruction_ID = (IRQ) ? 32'h0000_0000: instructionNoforward_ID; //IRQ到来的时候清除ID指令
    assign Rs_ID = instruction_ID[25:21];
    assign Rt_ID = instruction_ID[20:16];
    assign Rd_ID = instruction_ID[15:11];
    assign shamt_ID = instruction_ID[10:6];
    
    Control control(instruction_ID[31:26], instruction_ID[5:0], IRQ,
        PCSrc_ID, RegWrite_ID, RegDst_ID,
        MemRead_ID, MemWrite_ID, MemtoReg_ID,
        ALUSrc1_ID, ALUSrc2_ID, ExtOp, LuOp, ALUFun_ID, Sign_ID);
        
    RegisterFile register(reset, clk, RegWrite_WB, 
        Rs_ID, Rt_ID, RegAddr_WB, DatabusC_WB,
        DatabusA_ID, DatabusB_ID,show_data_d);
        
    assign ExtOut = {(ExtOp) ? {16{instruction_ID[15]}}:16'h0000, instruction_ID[15:0]};
    assign Imm_ID = LuOp ? {instruction_ID[15:0], 16'h0000} : ExtOut;  //立即�?
    assign DatabusAForward_ID = ForwardRs_ID ? DatabusC_WB : DatabusA_ID;
    assign DatabusBForward_ID = ForwardRt_ID ? DatabusC_WB : DatabusB_ID;
    //assign ConBA_ID = PC_ID +3'd4 +{Imm_ID[29:0], 2'b00};           //分支指令地址，这个寄存器在电路中出现在IF阶段
    assign JT_ID = {PC_ID[31:28], instruction_ID[25:0], 2'b00};     //跳转指令地址
    
    ID2EX r2(clk, reset, flush_ID2EX, PC_ID, PC_EX, 
        DatabusAForward_ID, DatabusA_EX, DatabusBForward_ID, DatabusB_EX, Imm_ID, Imm_EX,// ConBA_ID, ConBA_EX,
        Rs_ID, Rs_EX, Rt_ID, Rt_EX, Rd_ID, Rd_EX, shamt_ID, shamt_EX,
        ALUSrc1_ID, ALUSrc1_EX, ALUSrc2_ID, ALUSrc2_EX, ALUFun_ID, ALUFun_EX, Sign_ID, Sign_EX, RegDst_ID, RegDst_EX,
        MemRead_ID, MemRead_EX, MemWrite_ID, MemWrite_EX, PCSrc_ID, PCSrc_EX,
        MemtoReg_ID, MemtoReg_EX, RegWrite_ID, RegWrite_EX);
    
    //EX
    assign ALUInput1_EX = (ALUSrc1_EX) ? {27'd0, shamt_EX} : DatabusAForward_EX; //先转发后进行ALUSrc的判断
    assign ALUInput2_EX = (ALUSrc2_EX) ? Imm_EX : DatabusBForward_EX;
    
    ALU alu(ALUInput1_EX, ALUInput2_EX, ALUFun_EX, Sign_EX, ALUOut_EX, Zero);   //ALUOut的�?�出现在了ID阶段
    
    assign ConBA_EX = PC_EX +3'd4 +{Imm_EX[29:0], 2'b00};  
    assign RegAddr_EX = 
        (RegDst_EX == 2'b01) ? Rt_EX:
        (RegDst_EX == 2'b00) ? Rd_EX:
        (RegDst_EX == 2'b10) ? 5'b11111:
        5'b11010;
    
    EX2MEM r3(clk, reset, PC_EX, PC_MEM, PCSrc_EX, PCSrc_MEM,
        ALUOut_EX, ALUOut_MEM, DatabusBForward_EX, DatabusB_MEM, RegAddr_EX, RegAddr_MEM,
        MemRead_EX, MemRead_MEM, MemWrite_EX, MemWrite_MEM,
        MemtoReg_EX, MemtoReg_MEM, RegWrite_EX, RegWrite_MEM);
    
    //MEM
    DataMemory dataM(clk, ALUOut_MEM, DatabusB_MEM, ReadData_MEM1, MemRead_MEM, MemWrite_MEM);
    
    Peripheral per(reset, clk, sysclk, MemRead_MEM, MemWrite_MEM, ALUOut_MEM, DatabusB_MEM, 
        UART_RX, UART_TX, ReadData_MEM2, led, digi, IRQ, PC_IF[31]);

    seg7x16
    seg7x16_inst(
    .clk(clk),
    .reset(~reset),
    .cs(1),
    .i_data(show_data_d),//d reg 14
    .o_seg(o_seg),
    .o_sel(o_sel)
    );





    assign ReadData_MEM = 
        (ALUOut_MEM[31:28] == 4'b0100) ? ReadData_MEM2:
        ReadData_MEM1;
        
    MEM2WB r4(clk, reset, PC_MEM, PC_WB,
        ReadData_MEM, ReadData_WB, ALUOut_MEM, ALUOut_WB, RegAddr_MEM, RegAddr_WB,
        MemtoReg_MEM, MemtoReg_WB, RegWrite_MEM, RegWrite_WB);
    
    //WB
    assign DatabusC_WB = 
        (MemtoReg_WB == 2'b00) ? ALUOut_WB:
        (MemtoReg_WB == 2'b01) ? ReadData_WB:
        PC_WB+3'b100;
    
    //forward
    Forward forward(Rt_ID, Rs_ID, Rs_EX, Rt_EX, RegAddr_MEM, RegAddr_WB, RegAddr_EX,
        RegWrite_MEM, RegWrite_WB, RegWrite_EX, ALUSrc1_EX,
        ForwardRs, ForwardRt, ForwardJr, ForwardRs_ID, ForwardRt_ID);
        
    assign DatabusAForward_EX=  
        (ForwardRs == 2'b10) ? DatabusC_WB:
        (ForwardRs == 2'b01) ? ALUOut_MEM: DatabusA_EX;    //Rs的冲突的转发
    assign DatabusBForward_EX = 
        (ForwardRt == 2'b10) ? DatabusC_WB:
        (ForwardRt == 2'b01) ? ALUOut_MEM: DatabusB_EX;    //Rt的冲突转发（包括了sw的转发）
    assign DatabusJr =   
        (ForwardJr == 2'b10) ? ALUOut_MEM:
        (ForwardJr == 2'b01) ? ALUOut_EX: DatabusAForward_ID; //Jr数据通路的转发
    
    //Hazard
    Hazard hazard(IRQ, PCSrc_ID, PCSrc_EX, Zero, MemRead_EX, Rs_ID, Rt_ID, Rt_EX,
        flush_IF2ID, flush_ID2EX, Write_IF2ID, Write_PC);    //冒险处理，分支清空IF、ID，跳转清空IF，Lw冲突阻塞�?个周期
    
    //PC
    assign PCSrc =                     
        (PCSrc_ID == 3'b100 || PCSrc_ID == 3'b101) ? PCSrc_ID: //中断和异常在ID阶段跳转，为最高优先级
        (PCSrc_EX == 3'b001 && Zero) ? PCSrc_EX:       //分支指令在EX阶段跳转，为次高优先�?
        (PCSrc_ID == 3'b010 || PCSrc_ID == 3'b011) ? PCSrc_ID:  //跳转指令在ID阶段判断，为最低优先级
        3'b000;
    assign PCPlus4 = PC_IF + 3'b100;
    assign PC_next =                                             //判断下一条指令，
        (PCSrc == 3'b000) ? PCPlus4:
        (PCSrc == 3'b001) ? ConBA_EX:
        (PCSrc == 3'b010) ? JT_ID:
        (PCSrc == 3'b011) ? DatabusJr:
        (PCSrc == 3'b100) ? 32'h8000_0004:
        32'h8000_0008;
    
    assign PC_IF = PC_IF_reg;
    
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            PC_IF_reg <= 32'h8000_0000;
        else if (Write_PC)
            PC_IF_reg <= PC_next;
    end
    
endmodule     