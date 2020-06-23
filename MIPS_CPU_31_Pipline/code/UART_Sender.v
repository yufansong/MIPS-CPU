`timescale 1ps/1ps
module UART_Sender(sysclk,BRclk,TX_EN,TX_DATA,TX_STATUS,UART_TX);
  input sysclk,BRclk,TX_EN;
  input [7:0]TX_DATA;
  output TX_STATUS,UART_TX;
  reg TX_STATUS,UART_TX;
  reg enable;
  reg [8:0] state;

  initial  
  begin
    enable<=0; state<=9'd0;
    TX_STATUS<=0; UART_TX<=1;
  end

  always@(posedge sysclk)
  begin
    if (TX_EN)
      begin
        enable<=1; TX_STATUS<=1;
      end else if (state==9'd144)
      begin
        enable<=0; TX_STATUS<=0;
      end
  end

  always@(posedge BRclk)
  begin
   
    if (enable) state<=state+9'd1;
    else state<=9'd0;
  end

  always@(posedge BRclk)
  begin
     if (enable)
    begin
      case (state)
        0:  UART_TX<=0;
        16: UART_TX<=TX_DATA[0];
        32: UART_TX<=TX_DATA[1];
        48: UART_TX<=TX_DATA[2];
        64: UART_TX<=TX_DATA[3];
        80: UART_TX<=TX_DATA[4];
        96: UART_TX<=TX_DATA[5];
        112:UART_TX<=TX_DATA[6];
        128:UART_TX<=TX_DATA[7];
        144:UART_TX<=1;
      endcase
    end else UART_TX<=1;
  end
endmodule

