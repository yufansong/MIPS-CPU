
module Control(OpCode, Funct, IRQ,
	PCSrc, RegWrite, RegDst, 
	MemRead, MemWrite, MemtoReg, 
	ALUSrc1, ALUSrc2, ExtOp, LuOp, ALUFun,sign);
	input IRQ;//中断，内核态
	input [5:0] OpCode; 
	input [5:0] Funct;
	output [2:0] PCSrc;
	output RegWrite;
	output [1:0] RegDst;
	output MemRead;
	output MemWrite;
	output [1:0] MemtoReg;
	output ALUSrc1;
	output ALUSrc2;
	output ExtOp;
	output LuOp;
	output [5:0] ALUFun;//ALU功能
	output sign;
	wire [2:0] PCSrc;
	wire RegWrite;
	wire [1:0] RegDst;
	wire MemRead;
	wire MemWrite;
	wire [1:0] MemtoReg;
	wire ALUSrc1;
	wire ALUSrc2;
	wire ExtOp;
	wire LuOp;
	wire [5:0] ALUFun;
	wire sign;
	// Your code below
	assign PCSrc[2:0]=//??
			  (IRQ)?3'b100:
	          (OpCode==6'h0 && (Funct==6'h8 || Funct==6'h9))? 3'b011://jalr jr
	          (OpCode==6'h2 || OpCode==6'h3)? 3'b010:
			  (OpCode==6'h4||OpCode==6'h6||OpCode==6'h7||OpCode==6'h1||OpCode==6'h5)?3'b001:
			  ((OpCode==6'h0 && (Funct!=6'h8 || Funct!=6'h9))|| OpCode==6'h1c ||OpCode==6'h8||OpCode==6'h9||OpCode==6'hc//change there
			        ||OpCode==6'hf||OpCode==6'h23||OpCode==6'ha||OpCode==6'hb||OpCode==6'h2b)?3'b000:
	          3'b101;
	assign RegWrite=
			  (IRQ)?1:
	          (OpCode==6'h4||OpCode==6'h2||OpCode==6'h1||OpCode==6'h7||OpCode==6'h5||OpCode==6'h6||(OpCode==6'h0 && Funct==6'h8)||OpCode==6'h2b)? 0:1;
    assign RegDst[1:0]=
			  (IRQ)?2'b11:
			  (OpCode==6'h0 || OpCode==6'h1c)?2'b00://change
	          (OpCode==6'h23||OpCode==6'hf||OpCode==6'h8||OpCode==6'h9||OpCode==6'hc||OpCode==6'ha|| OpCode==6'hb)?2'b01://????
			  (OpCode==6'h3)?2'b10:2'b11;//????
    assign sign=((OpCode==6'h0&&(Funct==6'h23||Funct==6'h21))||OpCode==6'h9||OpCode==6'hb)?0:1;//addu subu
	
    assign MemRead=
              (OpCode==6'h23)? 1:0;
    assign MemWrite=
              (OpCode==6'h2b)? 1:0;
    assign MemtoReg[1:0]=
			  (IRQ)?2'b10:
              (OpCode==6'h3 || (OpCode==6'h0 && Funct==6'h9))? 2'b10://jr
              (OpCode==6'h23)? 2'b01:
               2'b00;
    assign ALUSrc1=
              (OpCode==6'h0 &&(Funct==6'h0 || Funct==6'h2 ||Funct==6'h3))? 1:0;//sll srl sra
    assign ALUSrc2=
              (OpCode==6'h0 || OpCode==6'h1c || OpCode==6'h4||OpCode==6'h5||OpCode==6'h6||OpCode==6'h7||OpCode==6'h1) ? 0:1;//change
    assign ExtOp=
              (OpCode==6'hc) ? 0:1;
    assign LuOp=
              (OpCode==6'hf) ? 1:0;


	// Your code above
	
	assign ALUFun = 
		(OpCode == 6'h23||OpCode==6'h2b||OpCode==6'hf||OpCode==6'h8||OpCode==6'h9||
		(OpCode==6'h0&&(Funct==6'h20||Funct==6'h21)))? 6'b000000:
		(OpCode == 6'h0&&(Funct==6'h22||Funct==6'h23))? 6'b000001: 
		(OpCode == 6'h1c)? 6'b000010://change there 
		((OpCode == 6'h0&&(Funct==6'h24))||OpCode==6'hc)? 6'b011000: 
		(OpCode == 6'h0&&(Funct==6'h25))?6'b011110:
		(OpCode == 6'h0&&(Funct==6'h26))?6'b010110:
		(OpCode == 6'h0&&(Funct==6'h27))?6'b010001:
		(OpCode == 6'h0&&(Funct==6'h00))?6'b100000://????
		(OpCode == 6'h0&&(Funct==6'h02))?6'b100001:
		(OpCode == 6'h0&&(Funct==6'h03))?6'b100011:
		(OpCode == 6'ha||OpCode == 6'hb||(OpCode == 6'h0&&(Funct==6'h2a)))?6'b110101://??????
		(OpCode == 6'h4)?6'b110011: 
		(OpCode == 6'h5)?6'b110001:
		(OpCode == 6'h6)?6'b111101:
		(OpCode == 6'h7)?6'b111111:6'b111011;//??????
	
endmodule