`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/31 23:37:51
// Design Name: 
// Module Name: Mul_Div
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


module Mul_Div(
input [3:0] choice,//1000:div 0100:divu 0010:mul 0001:multu
input [31:0] a,
input [31:0] b,
input clk,
input rst,
output buzy,
output [31:0] q, //shang
output [31:0] r  //yushu
    );
parameter DIV  = 4'b1000,
          DIVU = 4'b0100,
          MUL  = 4'b0010,
          MULTU= 4'b0001;


//div  
reg r_sign = 0;
reg a_sign = 0;
reg b_sign = 0;
reg [5:0]  count = 0;
reg [63:0] a_div , b_div; 
wire [31:0] q_div;
wire [31:0] r_div;
reg bz_div = 0;
wire start_div = ~bz_div && (choice == DIV);

assign r_div= a_sign ? 
            (b_sign ? ~a_div[63:32]+1 : ~a_div[63:32]+1) :
            (b_sign ? a_div[63:32] : a_div[63:32]) ;

assign q_div= a_sign ? 
            (b_sign ? a_div[31:0] : ~a_div[31:0]+1) :
            (b_sign ? ~a_div[31:0]+1 : a_div[31:0]) ;
//divu

reg r_sign_u = 0;
reg [31:0] reg_q; 
reg [31:0] reg_r; 
reg [31:0] reg_b;
wire [32:0] sub_add;
assign sub_add = r_sign_u?({reg_r,q[31]} + reg_b):({reg_r,q[31]} - reg_b);   

reg bz_divu = 0;
wire start_divu = ~bz_divu & (choice == DIVU);
wire [31:0] r_divu;
wire [31:0] q_divu;
assign r_divu = r_sign_u?( reg_r + reg_b ): reg_r; 
assign q_divu = reg_q;

//mul
reg [63:0] result = 0;
reg [31:0] x = 0;
reg [31:0] y = 0;
reg flag = 0;
reg [31:0] high = 0;
wire [31:0] r_mul;
wire [31:0] q_mul;
assign r_mul = result[31:0];//mul ouput low 32 bit
assign q_mul = result[63:32];

//multu
wire [31:0] r_multu;
wire [31:0] q_multu;
assign r_multu = result[31:0];
assign q_multu = result[63:32];


//////////////////////////////////////



always @(*)begin
case (choice)
DIV:begin
    if(rst)begin
      count = 0;
      bz_div = 0;
    end
    else begin
      if( start_div )begin
        r_sign = 0;
        a_sign = a[31];
        b_sign = b[31];
        a_div = a_sign ? {32'b0,~a+1} : {32'b0,a}; //被除数取绝对值扩�?
        b_div = b_sign ? {~b+1,32'b0} : {b,32'b0}; //除数取绝对�?�扩�?
        count = 6'b0;                 //计数器置�?
        bz_div = 1;                  //�?始执行除法指�?
      end
      else if ( bz_div )begin
        count = count + 1;           //计数器加�?
        a_div = {a_div[62:0],1'b0};   //左移
        if( a_div >= b_div ) 
            a_div = a_div - b_div + 1; //够减则执行减�?,商上1
        else 
            a_div = a_div;            //不够减则不变,商上0
        if( count == 6'h20 )
            bz_div = 0;              //结束执行除法指令
      end
    end
end
      
DIVU:begin
    if(rst)begin
            count<=0;
            reg_q<=0;
            reg_r<=0;
            reg_b<=0;
            bz_divu<=0;
        end
    else begin
        if(start_divu)begin
            reg_q <= a; // dividend;
            reg_b <= b; //divisor;  
            reg_r <= 0;    
            count <= 0;       
            bz_divu <= 1; 
            r_sign_u<=0;
        end
        else if(bz_divu)begin
            reg_r <= sub_add[31:0];   
            r_sign_u <= sub_add[32]; 
            reg_q <= {reg_q[30:0],~sub_add[32]};       
            count <= count +1;                   
            if (count == 31) 
                bz_divu <= 0;   
        end
    end
end

MUL:begin
    if (rst)begin
        result=0;
        x = 0;
        y = 0;
        high = 0;
        flag = 0;
    end
    else begin
        x = a;
        y = b;
        high = 0;
        result = 0;
        flag = (~x[31] & y[31]) | (x[31] & ~y[31]);
        if (x[31] == 1)begin
            x = x - 1;
            x = ~x;
        end
        if (y[31] == 1)begin
            y = y - 1;
            y = ~y;
        end
        while(y != 0)begin
            if(y[0]==1)
                result = result + {high,x};
            high = high << 1;
            high[0] = x[31];
            x = x << 1;
            y = y >> 1;
        end
        if (flag == 1)begin
            result = ~result;
            result = result + 1;
            flag = 0;
         end
     end
end

MULTU:begin
    if (rst)begin
        result=0;
        x=0;
        y=0;
        high=0;
    end
    else begin
        x=a;
        y=b;
        high=0;
        result=0;
        while(y!=0) begin
            if(y[0]==1)
            result=result+{high,x};
            high=high<<1;
            high[0]=x[31];
            x=x<<1;
            y=y>>1;
        end
    end
end
  default: 
    ;
endcase
end

assign q = choice[3] ? q_div  : 
         ( choice[2] ? q_divu : (
           choice[1] ? q_mul : (
           choice[0] ? q_multu: 0
           ))) ;

assign r = choice[3] ? r_div  : 
         ( choice[2] ? r_divu : (
           choice[1] ? result[31:0]  : (
           choice[0] ? r_multu: 0
           ))) ;

assign buzy = choice[3] ? bz_div  : 
            ( choice[2] ? bz_divu : 0) ;


endmodule
