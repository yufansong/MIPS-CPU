`timescale 1ns / 1ps

 
module Divider(
input i_clk,
input rst,
output o_clk
    );

reg o_clk_r = 0;
//wire o_clk;
assign o_clk = o_clk_r;
parameter l =10000/2 - 1;//100000
integer i = 0;

always @ (posedge i_clk)begin
  if(rst)begin
        o_clk_r <= 0;
        i <= 0; 
  end
  else begin
    if(i == l)begin
        o_clk_r = ~ o_clk_r;
        i<=0;
    end
    else 
        i <= i + 1;
  end
end



endmodule
