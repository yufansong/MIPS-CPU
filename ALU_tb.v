`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: SongYuFan
// 
// Create Date: 2018/04/25 10:52:20
// Design Name: 
// Module Name: ALU_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU_tb(

    );
reg[31:0] a;
    reg[31:0] b;
    reg[3:0] aluc;
    reg[31:0] r_temp;
    wire [31:0] r;
    wire zero;
    wire carry;
    wire negative;
    wire overflow;
     initial
     begin
      #40 aluc=4'b0000;a=32'b11111111111111111111111111111110;b=1;r_temp=a+b;
      #40 aluc=4'b0010;a=32'b01111111111111111111111111111111;b=1;r_temp=a+b;
      #40 aluc=4'b0001;a=32'b11111111111111111111111111111110;b=1;r_temp=a-b;
      #40 aluc=4'b0011;a=32'b01111111111111111111111111111111;b=1;r_temp=a-b;
      #40 aluc=4'b0100;a=32'b11111111111111111111111111111110;b=1;r_temp=a&b;
      #40 aluc=4'b0101;a=32'b11111111111111111111111111111110;b=1;r_temp=a|b;
      #40 aluc=4'b0110;a=32'b11111111111111111111111111111110;b=1;r_temp=a^b;
      #40 aluc=4'b0111;a=32'b11111111111111111111111111111110;b=1;r_temp=~(a|b);
      #40 aluc=4'b1000;a=32'b00000000000000000111111111111110;b=1;r_temp={b[15:0],16'b0};
      #40 aluc=4'b1011;a=32'b10000000000000000111111111111110;b=1;r_temp=(a<b)?1:0;
      #40 aluc=4'b1100;b=32'b10000000000000000111111111111110;a=10;r_temp= b>>>a;
      #40 aluc=4'b0011;b=32'h0;a=0;//r_temp=a<<b;
      #40 aluc=4'b1101;b=32'b10000000000000000111111111111110;a=1;r_temp=b>>a;
      #40 aluc=4'b1000;b=32'b00000000000000000111111111111110;b=1;r_temp={b[15:0],16'b0};
     #40 aluc=4'b0010;b=32'h10001000;a=32'h4;
    #40 aluc=4'b1100;b=32'hf;a=1;
     end
    ALU
    alu_inst(
    .a(a),
    .b(b),
    .aluc(aluc),
    .r(r),
    .zero(zero),
    .carry(carry),
    .negative(negative),
    .overflow(overflow)
            );   
endmodule
