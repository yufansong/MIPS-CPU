module UART_Baud_Rate_Generator(sysclk,BRclk);
  input sysclk;
  output BRclk; 
  reg BRclk;
  reg [9:0]state;

  initial
  begin
    state =10'd0;
    BRclk =0;
  end
  
  always@(posedge sysclk )
  begin
      if (state==10'd325)
      begin
        state<=10'd0; BRclk<=~BRclk;
      end else
      begin
        state<=state+10'd1;
      end
    end
endmodule


