module PC_datapath(reset,clk,ConBA,JT,Databus_A,PC,PCSrc,ALUOut);
    input ALUOut;
    input reset, clk;
	input [31:0]ConBA,Databus_A; 
	input [25:0] JT;
	input[2:0]PCSrc;
	parameter ILLOP=32'h8000_0004,XADR=32'h8000_0008;
	output reg [31:0] PC;
	wire [31:0] plus, branch;
	wire [31:0] PC_next;
	assign plus={PC[31],PC[30:0]+31'b000_0000_0000_0000_0000_0000_0000_0100};//PC+4
	assign branch=(ALUOut)?ConBA:plus;
	initial begin PC<=32'h8000_0000;end 
	always @(posedge clk, posedge reset)
	 begin
		if(reset) PC<=32'b1000_0000_0000_0000_0000_0000_0000_0000;
		else 
		 begin
			case(PCSrc)
			 3'b000: PC<=plus;
			 3'b001: PC<=branch; 
			 3'b010: PC<={PC[31:28],JT,2'b0};
			 3'b011: PC<=Databus_A;
			 3'b100: PC<=ILLOP;
			 3'b101: PC<=XADR;
			endcase
		 end
	 end
endmodule

// module single_path(reset,clk);
//     input clk,reset;
// 	wire [31:0] Instruction;//ָ��
	
	
	
// 	parameter xp=26,ra=31;
// 	wire [1:0] RegDst;
// 	wire [2:0] PCSrc;
// 	wire MemRead;
// 	wire [1:0] MemtoReg;
// 	wire [5:0] ALUFun;
// 	wire ExtOp;
// 	wire LuOp;
// 	wire MemWrite;
// 	wire ALUSrc1;
// 	wire ALUSrc2;
// 	wire RegWrite;
// 	wire sign;
// 	wire IRQ;//�����ź�
// 	//wire [4:0] Shamt;instruction[10:6] ALU_in1��ѡ��֮һ
// 	//Rd,Rt,Rs,AddrC;�����Ĵ�����λ����instruction[]���,addrc(write_register)��RegDst���Ƶ�д��Ĵ���
// 	//wire [15:0] Imm16;������չ��Ԫ����������instruction[15:0]
// 	wire [25:0]JT;
// 	wire[31:0]Databus1, Databus2, Databus3,PC,PC_plus,ConBA,Ext_out;//Databus3
// 	assign JT=Instruction[25:0];
// 	assign PC_plus={PC[31],{PC[30:0]+31'b000_0000_0000_0000_0000_0000_0000_0100}};
//     assign ConBA={PC[31],PC_plus[30:0]+{Ext_out[28:0],2'b00}};//shift
//     wire [31:0] ALU_out;//ALU���ֵ����
// 	PC_datapath pc_data(.reset(reset), .clk(clk), .ConBA(ConBA),.JT(Instruction[25:0]),.Databus_A(Databus1),.PC(PC),.PCSrc(PCSrc),.ALUOut(ALU_out[0]));//PC����
// 	InstructionMemory instruction_memory1(.Address(PC), .Instruction(Instruction));//ָ��ִ��
// 	Control control1(
// 		.OpCode(Instruction[31:26]), .Funct(Instruction[5:0]),.IRQ(IRQ),
// 		.PCSrc(PCSrc),.RegWrite(RegWrite), .RegDst(RegDst), 
// 		.MemRead(MemRead),	.MemWrite(MemWrite), .MemtoReg(MemtoReg),
// 		.ALUSrc1(ALUSrc1), .ALUSrc2(ALUSrc2), .ExtOp(ExtOp), .LuOp(LuOp),	.ALUFun(ALUFun), .sign(sign));//�����ź�
	
// 	wire [4:0] Write_register;
// 	assign Write_register = (RegDst == 2'b01)? Instruction[20:16]: (RegDst == 2'b00)? Instruction[15:11]:(RegDst == 2'b10)? 5'b11111:(RegDst == 2'b11)?5'b11010:5'b00000;//д��Ĵ���ѡ��ģ��rd��rt�
// 	RegisterFile register_file1(.reset(reset), .clk(clk), .RegWrite(RegWrite), 
// 		.Read_register1(Instruction[25:21]), .Read_register2(Instruction[20:16]), .Write_register(Write_register),
// 		.Write_data(Databus3), .Read_data1(Databus1), .Read_data2(Databus2));//�Ĵ�����databus3=databusC
	
// 	//wire [31:0] Ext_out;
// 	assign Ext_out = {ExtOp? {16{Instruction[15]}}: 16'h0000, Instruction[15:0]};//���޷���
	
// 	wire [31:0] LU_out;
// 	assign LU_out = LuOp? {Instruction[15:0], 16'h0000}: Ext_out;//�Ƿ���չ�
	
// 	/*wire [4:0] ALUCtl;
// 	wire Sign;
// 	ALUControl alu_control1(.ALUOp(ALUOp), .Funct(Instruction[5:0]), .ALUCtl(ALUCtl), .Sign(Sign));
// 	*/
// 	wire [31:0] ALU_in1;
// 	wire [31:0] ALU_in2;
// 	//wire [31:0] ALU_out;
// 	//wire Zero;
// 	assign ALU_in1 = ALUSrc1? {27'h0000000, Instruction[10:6]}: Databus1;
// 	assign ALU_in2 = ALUSrc2? LU_out: Databus2;//ѡ��ALU������
// 	ALU alu1(.A(ALU_in1), .B(ALU_in2), .ALUFun(ALUFun), .Sign(sign), .Z(ALU_out));//ALU����
	
// 	wire [31:0] Read_data;
// 	DataMemory data_memory1(.reset(reset), .clk(clk), .Address(ALU_out), .Write_data(Databus2), .Read_data(Read_data), .MemRead(MemRead), .MemWrite(MemWrite));//memory��Ԫ
// 	assign Databus3 = (MemtoReg == 2'b00)? ALU_out: (MemtoReg == 2'b01)? Read_data: PC_plus;//дѡ��
	
// endmodule
	