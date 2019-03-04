`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/29 11:05:33
// Design Name: 
// Module Name: ALU
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

module ALU(
input [31:0] a,
input [31:0] b,
input [3:0] aluc,
output reg [31:0] r,
output reg zero,
output reg carry,
output reg negative,
output reg overflow
    );
// reg [31:0] r;
// reg zero;
// reg carry;
// reg negative;
// reg overflow;
reg signed [31:0] a_sign;
reg signed [31:0] b_sign;
reg signed [31:0] r_sign;

always@(*)begin
a_sign = $signed(a);
b_sign = $signed(b);
case(aluc)
4'b0000:begin  //addu
        r=a+b;
        carry = (r<a || r<b)?1:0;
    end    
4'b0010:begin   //add
        r_sign=a_sign+b_sign;
        if(a_sign>0 && b_sign>0)
            overflow = (r_sign<0)? 1:0;
        else if(a_sign<0 && b_sign<0)
            overflow = (r_sign>0)? 1:0;
        else 
            overflow = 0 ; 
        r=$unsigned(r_sign);
    end
4'b0001:begin  //subu
        r=a-b;
        carry=(r>a)? 1: 0;
    end
4'b0011:begin   //sub
        r_sign=a_sign - b_sign;
        if(a_sign>0 && b_sign<0)
            overflow = (r_sign<0)? 1:0;
        else if(a_sign<0 && b_sign>0)
            overflow = (r_sign>0)? 1:0;
        else 
            overflow = 0 ; 
        r=$unsigned(r_sign);
    end
4'b0100:begin   //and
        r= a&b;
    end
4'b0101:begin   //or
        r= a|b;
    end  
4'b0110:begin   //xor
        r = a^b;
    end
4'b0111:begin   //nor
        r=~(a|b);
    end
4'b1000,4'b1001:begin   //lui
        r={b[15:0],16'b0};
    end
4'b1011:begin   //slt
        r= (a_sign<b_sign)?1:0;
    end                           
4'b1010:begin   //sltu
        r = (a<b)?1:0;
    end
4'b1100:begin   //sta
        if(a_sign!=0)begin
          r_sign = b_sign>>>(a_sign-1);
          carry = r_sign[0];
          r_sign = r_sign>>>1;
        end
        else 
            r_sign=b_sign;
        r = $unsigned(r_sign);
    end
4'b1110,4'b1111:begin   //sll/slr
        if(a != 0)begin
            r = b<<(a-1);
            carry = r[31];
            r = r<<1;
        end
        else
            r = b;
    end
4'b1101:begin   //srl
      if(a != 0)
      begin
          r = b>>(a-1);
          carry = r[0];
          r = r>>1;
      end
      else
          r = b;
        end
endcase
if(aluc == 4'b1010 || aluc == 4'b1011)
    zero = (a == b)? 1:0;
else 
    zero = (r == 0)? 1:0;
negative = r[31];
end
endmodule

// module ALU(
// input [31:0] a,
// input [31:0] b,
// input [3:0] aluc,
// output [31:0] r,
// output zero,
// output carry,
// output negative,
// output overflow);
// reg [31:0] r;
// reg zero,carry,negative,overflow;
// reg signed [31:0] sa,sb,sr;

// always @ (*)
// begin
//   case(aluc)
//     4'b0000:begin
//       r = a + b;
//       if(r < a || r < b)
//           carry = 1;
//       else
//           carry = 0;
//     end
//     4'b0001:begin
//       r = a - b;
//       if(r > a)
//         carry = 1;
//       else
//         carry = 0;
//     end
//     4'b0010:begin
//       sa = $signed(a);
//       sb = $signed(b);
//       sr = sa + sb;
//       if(sa > 0 && sb > 0)
//       begin
//         if(sr < 0)
//           overflow = 1;
//         else
//           overflow = 0;
//       end
//       else if(sa < 0 && sb < 0)
//       begin
//         if(sr > 0)
//           overflow = 1;
//         else
//           overflow = 0;
//       end
//       else
//         overflow = 0;
//       r = $unsigned(sr);
//     end
//     4'b0011:begin
//       sa = $signed(a);
//       sb = $signed(b);
//       sr = sa - sb;
//       if(sa >= 0 && sb <= 0)
//       begin
//         if(sr < 0)
//           overflow = 1;
//         else
//           overflow = 0;
//       end
//       else if(a <= 0 && b >= 0)
//       begin
//         if(r > 0)
//           overflow = 1;
//         else
//           overflow = 0;
//       end
//       else
//         overflow = 0;
//       r = $unsigned(sr);
//     end
//     4'b0100:begin
//       r = a & b;
//     end
//     4'b0101:begin
//       r = a | b;
//     end
//     4'b0110:begin
//       r = a ^ b;
//     end
//     4'b0111:begin
//       r = ~(a | b);
//     end    
//     4'b1000,4'b1001:begin
//       r = {b[15:0],16'b0};
//     end    
//     4'b1010:begin
//       r = (a<b)?1:0;
//     end
//     4'b1011:begin
//       sa = $signed(a);
//       sb = $signed(b);
//       r = (sa<sb)?1:0;
//     end
//     4'b1100:begin
//       sa = $signed(a);
//       sb = $signed(b);
//       if(sa != 0)
//       begin
//           sr = sb>>>(sa-1);
//           carry = sr[0];
//           sr = sr>>>1;
//       end
//       else
//           sr = sb;
//       r = $unsigned(sr);
//     end
//     4'b1101:begin
//       if(a != 0)
//       begin
//           r = b>>(a-1);
//           carry = r[0];
//           r = r>>1;
//       end
//       else
//           r = b;
//     end
//     4'b1110,4'b1111:begin
//     if(a != 0)
//     begin
//         r = b<<(a-1);
//         carry = r[31];
//         r = r<<1;
//     end
//     else
//         r = b;
//     end
//   endcase
//   if(aluc == 4'b1010 || aluc == 4'b1011)
//     zero = (a==b)?1:0;
//   else
//     zero = (r==0)?1:0;
//   negative = r[31];
// end
// endmodule

// module ALU(
// input [31:0] a,    //32 ???????????????????????????? 1 
// input [31:0] b,    //32 ???????????????????????????? 2 
// input [3:0] aluc,  //4 ?????????????????????????? alu ?????????? 
// output [31:0] r,   //32 ??????????????????? a??????b ???????????? aluc ??????????????????????????????
// output zero,       //0 ?????????? 
// output carry,      // ?????????????????? 
// output negative,   // ?????????????????????? 
// output overflow    // ???????????????????
//     );

// wire [31:0] d_and = a & b;                          // x000  add
// wire [31:0] d_or  = a | b;                          // x100  sub
// wire [31:0] d_xor = a ^ b;                          // x001  and
// wire [31:0] d_lui = {b[15:0],16'h0};                // x101  or
// wire [31:0] d_and_or  = aluc[2]? d_or : d_and;      // x010  xor
// wire [31:0] d_xor_lui = aluc[2]? d_lui : d_xor;      
// wire [31:0] d_as,d_sh;                              // 1111  sra
// addsub32 as32 (a,b,aluc[2],d_as);                   
// shift shifter (b,a[4:0],aluc[2],aluc[3],d_sh);          
// mux4x32 select (d_as,d_and_or,d_xor_lui,d_sh,aluc[1:0],r);
// assign zero = ~|r;  //??????r??????????????32??????????????????????????????
// endmodule

// //////////////////////////////////////////////////////////////
// //???????·??????????????
// module mux4x32(a0, a1, a2, a3, s, y);
//   input [31:0] a0, a1, a2, a3;
//   input [1:0] s;
//   output [31:0] y;
  
//   function [31:0] select;
//     input [31:0] a0, a1, a2, a3;
//      input [1:0] s;
//      case(s)
//        2'b00: select = a0;
//        2'b01: select = a1; 
//        2'b10: select = a2;
//        2'b11: select = a3;
//      endcase
//   endfunction
//   assign y = select(a0, a1, a2, a3, s);
// endmodule

// //////////////////////////////////////////////////////////////

// //////////////////////////////////////////////////////////////
// //????????
// module shift(
//     input [31:0] d,
//     input [4:0] sa,
//     input right,
//     input arith,
//     output [31:0] sh
// );
// reg [31:0] sh;
// always @ * begin
//   if(!right)begin
//     sh= d << sa;
//   end else if (!arith) begin
//     sh = d >> sa;
//   end else begin
//     sh = $signed(d) >> sa;
//   end
// end
// endmodule


// //////////////////////////////////////////////////////////////

// //////////////////////////////////////////////////////////////
// //????????
// module addsub32(
// input [31:0] a,
// input [31:0] b,
// input sub,
// output [31:0] s
// );
// cla32 as32(a,b^{32{sub}},sub,s);
// endmodule


// //????????·?????????
// module add(a,b,c,g,p,s);
//     input a,b,c;  //a,b????????????????????c??????????
//     output g,p,s; //s??????·??????????????????g????????????????????????????????????????p??????????????????????????
//     assign s = a^ b ^ c;
//     assign g = a & b;
//     assign p = a | b;
// endmodule

// //GP??????????????
// module g_p(g,p,c_in,g_out,p_out,c_out);
//     input [1:0] g,p;
//     input c_in;
//     output g_out,p_out,c_out;
//     assign g_out = g[1] | p[1] & g[0];
//     assign p_out = p[1] & p[0];
//     assign c_out = g[0] | p[0] & c_in;
// endmodule

// //2??????????????????????·?????????
// module cla_2(a,b,c_in,g_out,p_out,s);
//     input [1:0] a,b;
//     input c_in;
//     output g_out,p_out;
//     output [1:0] s;
//     wire [1:0] g,p;
//     wire c_cout;
//     add add0(a[0],b[0],c_in,g[0],p[0],s[0]);
//     add add1(a[1],b[1],c_out,g[1],p[1],s[1]);
//     g_p g_p0(g,p,c_in,g_out,p_out,c_out);
// endmodule

// //4??????????????????????·?????????
// module cla_4(a,b,c_in,g_out,p_out,s);
//     input [3:0] a,b;
//     input c_in;
//     output g_out,p_out;
//     output [3:0] s;
//     wire [1:0] g,p;
//     wire c_out;
//     cla_2 cla0(a[1:0],b[1:0],c_in,g[0],p[0],s[1:0]);
//     cla_2 cla1(a[3:2],b[3:2],c_out,g[1],p[1],s[3:2]);
//     g_p g_p0(g,p,c_in,g_out,p_out,c_out);
// endmodule

// //8??????????????????????·?????????
// module cla_8(a,b,c_in,g_out,p_out,s);
//     input [7:0] a,b;
//     input c_in;
//     output g_out,p_out;
//     output [7:0] s;
//     wire [1:0] g,p;
//     wire c_out;
//     cla_4 cla0(a[3:0],b[3:0],c_in,g[0],p[0],s[3:0]);
//     cla_4 cla1(a[7:4],b[7:4],c_out,g[1],p[1],s[7:4]);
//     g_p g_p0(g,p,c_in,g_out,p_out,c_out);
// endmodule

// //16??????????????????????·?????????
// module cla_16(a,b,c_in,g_out,p_out,s);
//     input [15:0] a,b;
//     input c_in;
//     output g_out,p_out;
//     output [15:0] s;
//     wire [1:0] g,p;
//     wire c_out;
//     cla_8 cla0(a[7:0],b[7:0],c_in,g[0],p[0],s[7:0]);
//     cla_8 cla1(a[15:8],b[15:8],c_out,g[1],p[1],s[15:8]);
//     g_p g_p0(g,p,c_in,g_out,p_out,c_out);
// endmodule

// //32??????????????????????·?????????
// module cla_32(a,b,c_in,g_out,p_out,s);
//     input [31:0] a,b;
//     input c_in;
//     output g_out,p_out;
//     output [31:0] s;
//     wire [1:0] g,p;
//     wire c_out;
//     cla_16 cla0(a[15:0],b[15:0],c_in,g[0],p[0],s[15:0]);
//     cla_16 cla1(a[31:16],b[31:16],c_out,g[1],p[1],s[31:16]);
//     g_p g_p0(g,p,c_in,g_out,p_out,c_out);
// endmodule

// //??????????32??????????????????????·?????????
// module cla32(a,b,ci,s,co);
//     input [31:0] a,b;
//     input ci;
//     output [31:0] s;
//     output co;
//     wire g_out,p_out;
//     cla_32 cla(a,b,ci,g_out,p_out,s);
//     assign co = g_out | p_out & ci;
// endmodule
// ////////////////////////////////////////////////////////////



// `timescale 1ns / 1ps
// //////////////////////////////////////////////////////////////////////////////////
// // Company: 
// // Engineer:SongYuFan 
// // 
// // Create Date: 2018/04/25 10:23:58
// // Design Name: 
// // Module Name: ALU
// // Project Name: 
// // Target Devices: 
// // Tool Versions: 
// // Description: 
// // 
// // Dependencies: 
// // 
// // Revision:
// // Revision 0.01 - File Created
// // Additional Comments:
// // 
// //////////////////////////////////////////////////////////////////////////////////








// module ALU(
// input [31:0] a,    //32 位输入，操作数 1 
// input [31:0] b,    //32 位输入，操作数 2 
// input [3:0] aluc,  //4 位输入，控制 alu 的操作 
// output [31:0] r,   //32 位输出，由 a、b 经过 aluc 指定的操作生成
// output zero,       //0 标志位 
// output carry,      // 进位标志位 
// output negative,   // 负数标志位 
// output overflow    // 溢出标志位
// );
// wire [31:0] data [0:7];  //数据
// reg [31:0] R;
// wire [3:0] sign [0:7];   //标志位
// reg [3:0] Sign;
// always @ (*) begin
//     Sign=4'bx;
//     R=32'bx;
//     if (aluc>=0&&aluc<=3) begin
//         R=data[0];
//         Sign=sign[0];
//     end
//     else begin
//         case(aluc)
//             4'b0100:begin
//                     R=data[1];
//                     Sign=sign[1];
//                     end
//             4'b0101:begin
//                     R=data[2];
//                     Sign=sign[2];
//                     end
//             4'b0110:begin
//                     R=data[3];
//                     Sign=sign[3];
//                     end
//             4'b0111:begin
//                     R=data[4];
//                     Sign=sign[4];
//                     end
//             4'b1000:begin
//                     R=data[6];
//                     Sign=sign[6];
//                     end
//             4'b1001:begin
//                     R=data[6];
//                     Sign=sign[6];
//                     end                               
//             4'b1011:begin
//                     R=data[5];
//                     Sign=sign[5];
//                     end 
//             default:begin
//                     R=data[7];
//                     Sign=sign[7];
//                     end                                                               
//         endcase
//     end
// end
// assign r=R;
// assign zero=Sign[0],carry=Sign[1],negative=Sign[2],overflow=Sign[3];

// addsub32 addsub(
// .a(a),.b(b),.aluc(aluc[1:0]),.data_out(data[0]),.zero(sign[0][0]),.carry(sign[0][1]),.negative(sign[0][2]),.overflow(sign[0][3]) );

// And anD( .a(a),.b(b),.data_out(data[1]),.zero(sign[1][0]),.negative(sign[1][2]) );

// Or OR( .a(a),.b(b),.data_out(data[2]),.zero(sign[2][0]),.negative(sign[2][2]) );

// Xor XOR( .a(a),.b(b),.data_out(data[3]),.zero(sign[3][0]),.negative(sign[3][2]) );

// Nor NOR( .a(a),.b(b),.data_out(data[4]),.zero(sign[4][0]),.negative(sign[4][2]) );

// Slt slt( .a(a),.b(b),.data_out(data[5]),.negative(sign[5][2]),.zero(sign[5][0]) );

// Lui lui( .a(a),.b(b),.data_out(data[6]),.negative(sign[6][2]),.zero(sign[6][0]) );

// bshifter32_carry bshifter( .a(a),.b(b),.aluc(aluc),.data_out(data[7]),.zero(sign[7][0]),.carry(sign[7][1]),.negative(sign[7][2]) );
// endmodule

// module addsub32(
//     input [31:0] a,
//     input [31:0] b,  
//     input [1:0] aluc,
//     output [31:0] data_out,
//     output zero,          //零标志位
//     output carry,        //进位
//     output negative,      //
//     output overflow
//     );
//     reg signed [31:0] a1,b1,c1;  //有符号数
//     reg [32:0] out,a2,b2;    //无符号输出
//     reg choice;        //1表示有符号数，0无符号
//     reg Nega,O;
//     always @(*) begin
//         a1=a;
//         b1=b;
//         a2={1'b0,a};
//         b2={1'b0,b};
//         case (aluc)
//             2'b00:begin           //addu
//                       choice=0;
//                       out=a2+b2;
//                       Nega=out[31];
//                   end
//             2'b10:begin           //add
//                       choice=1;
//                       c1=a1+b1;
//                       O=0;
//                       if(c1<0) begin
//                           Nega=1;
//                           if (a1>0&&b1>0)
//                               O=1;
//                           end
//                       else begin
//                           Nega=0;
//                           if (a1<0&&b1<0&&c1>0)
//                               O=1;
//                           end
//                   end
//             2'b01:begin            //subu
//                       choice=0;
//                       out=a2-b2;
//                       Nega=out[31];
//                   end
//             default:begin           //sub
//                       choice=1;
//                       c1=a1-b1;
//                       O=0;
//                       if (c1<0) begin
//                           Nega=1;
//                           if(a1>0&&b1<0)
//                               O=1;   //溢出
//                       end
//                       else begin
//                           Nega=0;
//                           if (c1>0&&a1<0&&b1>0)
//                               O=1;   //溢出
//                       end
//                   end      
//         endcase
//     end
//     assign data_out=choice?c1:out[31:0];
//     assign carry=choice?1'bz:out[32];
//     assign zero=data_out?0:1;
//     assign overflow=choice?O:1'bz;
//     assign negative=Nega;
// endmodule

// module And(
//     input [31:0] a,
//     input [31:0] b,
//     output [31:0] data_out,
//     output zero,
//     output negative
//     );
//     reg [31:0] data;
//     always @(*) begin
//         data=a&b;
//     end
//     assign data_out=data;
//     assign zero=data?0:1;
//     assign negative=data[31];
// endmodule

// module Or(
//     input [31:0] a,
//     input [31:0] b,
//     output [31:0] data_out,
//     output zero,
//     output negative
//     );
//     reg [31:0] data;
//     always @(*) begin
//         data=a|b;
//     end
//     assign data_out=data;
//     assign zero=data?0:1;
//     assign negative=data[31];
// endmodule

// module Xor(
//     input [31:0] a,
//     input [31:0] b,
//     output [31:0] data_out,
//     output zero,
//     output negative
//     );
//     reg [31:0] data;
//     always @(*) begin
//         data=a^b;
//     end
//     assign data_out=data;
//     assign zero=data?0:1;
//     assign negative=data[31];
// endmodule

// module Nor(
//     input [31:0] a,
//     input [31:0] b,
//     output [31:0] data_out,
//     output zero,
//     output negative
//     );
//     reg [31:0] data;
//     always @(*) begin
//         data=~(a|b);
//     end
//     assign data_out=data;
//     assign zero=data?0:1;
//     assign negative=data[31];
// endmodule

// module Slt(
//     input [31:0] a,
//     input [31:0] b,
//     output [31:0] data_out,
//     output negative,
//     output zero
//     );
//     reg signed [31:0] a1,b1,data;
//     reg Z;
//     always @(*) begin
//         a1=a;
//         b1=b;
//         data=(a1<b1)?1:0;
//         if (a1<b1) 
//             Z=0;
//         else begin
//             if (a1==b1)
//                 Z=1;
//             else
//                 Z=0;
//         end
//     end
//     assign data_out=data;
//     assign negative=data[0];
//     assign zero=Z;
// endmodule

// module Lui(
//     input [31:0] a,
//     input [31:0] b,
//     output [31:0] data_out,
//     output negative,
//     output zero
//     );
//     reg [31:0] data;
//     always @(*) begin
//         data={b[15:0],16'b0};
//     end
//     assign data_out=data;
//     assign negative=data[31];
//     assign zero=data?0:1;
// endmodule

// module bshifter32_carry(
//     input [31:0] a,
//     input [31:0] b,
//     input [3:0] aluc,
//     output [31:0] data_out,
//     output zero,
//     output carry,
//     output negative 
//     );
//     reg signed [31:0] a1,b1,data;
//     reg C,Z;
//     always @(*) begin
//         a1=a;
//         b1=b;
//         case (aluc)
//             4'b1010:begin       //altu
//                     data=(a<b)?1:0;
//                     C=data[0];
//                     if (a==b)
//                         Z=1;
//                     else
//                         Z=0;
//                     end
//             4'b1100:begin       //Sra
//                     C=b[a-1];
//                     data=b1>>>a;
//                     Z=data?0:1;
//                     end 
//             4'b1101:begin
//                     C=b[a-1];
//                     data=b>>a;
//                     Z=data?0:1;
//                     end
//             default:begin
//                     C=b[32-a];
//                     data=b<<a;
//                     Z=data?0:1;
//                     end
//         endcase
//     end
//     assign zero=Z;
//     assign data_out=data;
//     assign negative=data[31];
//     assign carry=C;
// endmodule

