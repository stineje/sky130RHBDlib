// 16-Bit Carry Look Ahead adder, test design for Standard Cell/Custom Design
// 
// Author: Ivan Castellanos
// email: ivan.castellanos@okstate.edu
// VLSI Computer Architecture Research Group,
// Oklahoma Stata University

module cla16 (sum, a, b);
    
   output [16:0] sum;
   input  [15:0] a,b;
   
   wire [14:0] carry;
   wire [15:0] g, p;
   wire [4:0] gout, pout;

   rfa rfa0(sum[0], g[0], p[0], a[0], b[0], 1'b0);
   rfa rfa1(sum[1], g[1], p[1], a[1], b[1], carry[0]);
   rfa rfa2(sum[2], g[2], p[2], a[2], b[2], carry[1]);
   rfa rfa3(sum[3], g[3], p[3], a[3], b[3], carry[2]);
   bclg4 bclg30(carry[2:0], gout[0], pout[0], g[3:0], p[3:0], 1'b0);
   
   rfa rfa4(sum[4], g[4], p[4], a[4], b[4], carry[3]);
   rfa rfa5(sum[5], g[5], p[5], a[5], b[5], carry[4]);
   rfa rfa6(sum[6], g[6], p[6], a[6], b[6], carry[5]);
   rfa rfa7(sum[7], g[7], p[7], a[7], b[7], carry[6]);
   bclg4 bclg74(carry[6:4], gout[1], pout[1], g[7:4], p[7:4], carry[3]);
   
   rfa rfa8(sum[8], g[8], p[8], a[8], b[8], carry[7]);
   rfa rfa9(sum[9], g[9], p[9], a[9], b[9], carry[8]);
   rfa rfa10(sum[10], g[10], p[10], a[10], b[10], carry[9]);
   rfa rfa11(sum[11], g[11], p[11], a[11], b[11], carry[10]);
   bclg4 bclg118(carry[10:8], gout[2], pout[2], g[11:8], p[11:8], carry[7]);

   rfa rfa12(sum[12], g[12], p[12], a[12], b[12], carry[11]);
   rfa rfa13(sum[13], g[13], p[13], a[13], b[13], carry[12]);
   rfa rfa14(sum[14], g[14], p[14], a[14], b[14], carry[13]);
   rfa rfa15(sum[15], g[15], p[15], a[15], b[15], carry[14]);
   bclg4 bclg1512(carry[14:12], gout[3], pout[3], g[15:12], p[15:12], carry[11]);

   bclg4 bclg_150({carry[11], carry[7], carry[3]}, gout[4], pout[4], {gout[3], gout[2], gout[1], gout[0]}, {pout[3], pout[2], pout[1], pout[0]}, 1'b0);

   assign sum[16] = gout[4]; 

endmodule


// 4-bit Block Carry Look-Ahead Generator

module bclg4 (cout, gout, pout, g, p, cin);

   output [2:0] cout;
   output gout;
   output pout;
   input [3:0] g;
   input [3:0] p;
   input cin;
   
   wire a1_out, a2_out, a3_out, a4_out, a5_out, a6_out;
   wire a7_out, a8_out, a9_out;

   and a1(a1_out, p[0], cin);
   or  o1(cout[0], g[0], a1_out);

   and a2(a2_out, p[1], g[0]);
   and a3(a3_out, p[1], p[0], cin);
   or  o2(cout[1], g[1], a2_out, a3_out);

   and a4(a4_out, p[2], g[1]);
   and a5(a5_out, p[2], p[1], g[0]);
   and a6(a6_out, p[2], p[1], p[0], cin);
   or  o3(cout[2], g[2], a4_out, a5_out, a6_out);

   and a7(a7_out, p[3], g[2]);
   and a8(a8_out, p[3], p[2], g[1]);
   and a9(a9_out, p[3], p[2], p[1], g[0]);
   or  o4(gout, g[3], a7_out, a8_out, a9_out);
   and a10(pout, p[0], p[1], p[2], p[3]);
   
endmodule
