`timescale 1ps/1ps
module Peripheral (reset,clk,sysclk,MemRead,MemWrite,Address,Write_data,UART_RX,UART_TX,Read_data,led,digi,IRQ,PC_31);
input reset,clk,PC_31,sysclk;
input MemRead,MemWrite;
input [31:0] Address;
input [31:0] Write_data;
output [31:0] Read_data;
reg [31:0] Read_data;

output [7:0] led;
reg [7:0] led;
output [11:0] digi;
reg [11:0] digi;

input UART_RX;
output UART_TX;

wire irqout;//
output IRQ;//
reg [31:0] TH;
reg [31:0] TL;
reg [2:0] TCON;
assign irqout = TCON[2];//

wire RX_STATUS,TX_STATUS;
wire [7:0]RX_DATA;
wire [7:0]TX_DATA;
wire BRclk;
reg TX_EN;//uart 所需信号

wire [7:0] r_DATA;//为什么是wire
reg [7:0] t_DATA;
reg r_status,t_status;//接收（发送）中断状态
reg r_en,t_en;//接收（发送）中断使能
reg [1:0] TX_shift,RX_shift;//移位寄存器
wire [4:0] UART_CON;
//reg [8:0]count;//计数

assign UART_CON[4]=TX_STATUS;
assign UART_CON[3]=r_status;//接收中断状态
assign UART_CON[2]=t_status;//发送中断状态
assign UART_CON[1]=r_en;//接收中断使能
assign UART_CON[0]=t_en;//发送中断使能
assign r_DATA=RX_DATA;
assign TX_DATA=t_DATA;
assign IRQ=(irqout&&~PC_31);//
initial
     begin  
	    RX_shift<=2'b00;
	    TX_shift<=2'b00;
		TH<=32'b0;
		TL<=32'b0;
		//count<=5'b0;
		TCON<=3'b0; 
		r_status<=0;
		t_status<=0;
		r_en<=0;
		t_en<=0;
		TX_EN<=0;
	end
//在此引用UART波特率、发送、接收
UART_Baud_Rate_Generator uart_brg(sysclk,BRclk);
UART_Receiver uart_r(sysclk,BRclk,UART_RX,RX_DATA,RX_STATUS);
//Controller c(sysclk,RX_DATA,RX_STATUS,TX_DATA,TX_EN,TX_STATUS);
UART_Sender uart_s(sysclk,BRclk,TX_EN,TX_DATA,TX_STATUS,UART_TX);
always@(*) begin
	if(MemRead) begin
		case(Address)
			32'h40000000: Read_data <= TH;			
			32'h40000004: Read_data <= TL;			
			32'h40000008: Read_data <= {29'b0,TCON};				
			32'h4000000C: Read_data <= {24'b0,led};			
			32'h40000014: Read_data <= {20'b0,digi};
			32'h40000018: Read_data <= {24'b0,t_DATA};
			32'h4000001C: Read_data <= {24'b0,r_DATA};
			32'h40000020: Read_data <= {27'b0,UART_CON};
			default: Read_data <= 32'b0;
		endcase
	end
	else
		Read_data <= 32'b0;
end

always@(posedge reset or posedge clk) begin
	if(reset) begin
		TH <= 32'b0;
		TL <= 32'b0;
		TCON <= 3'b0;	
	end
	else begin
		if(TCON[0]) begin	//timer is enabled
			if(TL==32'hffffffff) begin
				TL <= TH;
				if(TCON[1]) TCON[2] <= 1'b1;		//irq is enabled
			end
			else TL <= TL + 1;
		end
	if((MemWrite&&(Address==32'h40000018))&&UART_CON[0]==1&&TX_STATUS==0)
	begin
	   TX_EN<=1;
	end
	if (TX_EN) TX_EN<=0;
	if(MemRead&&(Address==32'h4000001C)) 
	    r_status<=0;
	if(MemWrite&&(Address==32'h40000018)) 
	    t_status<=0;//清零
		
	RX_shift<={RX_shift[0],RX_STATUS};
	if(RX_shift==2'b01)  
	    r_status<=1;
	TX_shift<={TX_shift[0],TX_STATUS};
	if(TX_shift==2'b10)  
	    t_status<=1;//发送（接收）状态在发送完毕后置1
		
		if(MemWrite) begin
			case(Address)
				32'h40000000: TH <= Write_data;
				32'h40000004: TL <= Write_data;
				32'h40000008: TCON <= Write_data[2:0];		
				32'h4000000C: led <= Write_data[7:0];			
				32'h40000014: digi <= Write_data[11:0];
				32'h40000018: t_DATA[7:0]<= Write_data[7:0];
				32'h40000020: {r_en,t_en}<= Write_data[1:0];
				default: ;
			endcase
		end
	end
end
endmodule

