`timescale 1ps/1ps
module UART_Receiver(sysclk,BRclk,UART_RX,RX_DATA,RX_STATUS);
  input sysclk,BRclk,UART_RX;
  output RX_DATA,RX_STATUS;
  reg [7:0] RX_DATA;
  reg RX_STATUS;
  reg enable;
  reg [8:0] state;
 
  initial 
  begin
    enable<=0; state<=9'd0;
    RX_STATUS<=0; RX_DATA<=0;
  end

  always@(negedge UART_RX or posedge sysclk)
  begin
    if (~UART_RX) begin
      if (enable==0) enable<=1;
    end else
    if (state==9'd152) enable<=0;
  end

  always@(posedge BRclk)
  begin
    if (enable) state<=state+9'd1;
    else state<=9'd0;
  end
  
  always@(posedge BRclk )
  begin
    if (enable)
    begin
      case (state)
        24: RX_DATA[0]<=UART_RX;
        40: RX_DATA[1]<=UART_RX;
        56: RX_DATA[2]<=UART_RX;
        72: RX_DATA[3]<=UART_RX;
        88: RX_DATA[4]<=UART_RX;
        104:RX_DATA[5]<=UART_RX;
        120:RX_DATA[6]<=UART_RX;
        136:RX_DATA[7]<=UART_RX;
      endcase
    end
  end

  always@(posedge sysclk)
  begin
    if (state==152) RX_STATUS<=1;
    else RX_STATUS<=0;
  end
endmodule


