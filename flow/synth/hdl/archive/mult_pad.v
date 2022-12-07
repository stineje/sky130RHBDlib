// 16-Bit Multiply Add Unit, test design for Standard Cell/Custom Design
// F = Accumulation ( A * B )
// Author: Ivan Castellanos
// email: ivan.castellanos@okstate.edu
// VLSI Computer Architecture Research Group,
// Oklahoma Stata University

module mult_pad(result, a, b, reset, clk);

   output [15:0] result;
   input  [7:0] a;
   input  [7:0] b;
   input  reset;
   input  clk;
   
   wire [15:0] multiplication;
   wire [16:0] sum;
   wire [7:0]  a_i, b_i;
   wire [15:0] result_i;
   wire        reset_i, clk_i;

   // Custom cell block:
   mult multiply(multiplication, a_i, b_i);

   cla16 cla16_module(sum, multiplication, result_i[15:0]);

   // Output register is 17-bits long to include Carry out in the result.
   dffr_17 accu_output(result_i, sum[15:0], clk_i, reset_i);

  PADOUT p19 ( .DO(result_i[15]), .YPAD(result[15]) );
  PADOUT p18 ( .DO(result_i[14]), .YPAD(result[14]) );
  PADOUT p17 ( .DO(result_i[13]), .YPAD(result[13]) );
  PADOUT p16 ( .DO(result_i[12]), .YPAD(result[12]) );
  PADOUT p15 ( .DO(result_i[11]), .YPAD(result[11]) );
  PADOUT p14 ( .DO(result_i[10]), .YPAD(result[10]) );
  PADOUT p13 ( .DO(result_i[9]), .YPAD(result[9]) );
  PADOUT p12 ( .DO(result_i[8]), .YPAD(result[8]) );
  PADOUT p11 ( .DO(result_i[7]), .YPAD(result[7]) );
  PADOUT p10 ( .DO(result_i[6]), .YPAD(result[6]) );
  PADOUT p09 ( .DO(result_i[5]), .YPAD(result[5]) );
  PADOUT p08 ( .DO(result_i[4]), .YPAD(result[4]) );
  PADOUT p07 ( .DO(result_i[3]), .YPAD(result[3]) );
  PADOUT p06 ( .DO(result_i[2]), .YPAD(result[2]) );
  PADOUT p05 ( .DO(result_i[1]), .YPAD(result[1]) );
  PADOUT p04 ( .DO(result_i[0]), .YPAD(result[0]) );
  PADINC p39 ( .DI(a_i[7]), .YPAD(a[7]) );
  PADINC p38 ( .DI(a_i[6]), .YPAD(a[6]) );
  PADINC p37 ( .DI(a_i[5]), .YPAD(a[5]) );
  PADINC p36 ( .DI(a_i[4]), .YPAD(a[4]) );
  PADINC p35 ( .DI(a_i[3]), .YPAD(a[3]) );
  PADINC p34 ( .DI(a_i[2]), .YPAD(a[2]) );
  PADINC p33 ( .DI(a_i[1]), .YPAD(a[1]) );
  PADINC p32 ( .DI(a_i[0]), .YPAD(a[0]) );
  PADINC p31 ( .DI(b_i[7]), .YPAD(b[7]) );
  PADINC p30 ( .DI(b_i[6]), .YPAD(b[6]) );
  PADINC p29 ( .DI(b_i[5]), .YPAD(b[5]) );
  PADINC p28 ( .DI(b_i[4]), .YPAD(b[4]) );
  PADINC p27 ( .DI(b_i[3]), .YPAD(b[3]) );
  PADINC p26 ( .DI(b_i[2]), .YPAD(b[2]) );
  PADINC p25 ( .DI(b_i[1]), .YPAD(b[1]) );
  PADINC p24 ( .DI(b_i[0]), .YPAD(b[0]) );
  PADINC p23 ( .DI(reset_i), .YPAD(reset) );
  PADINC p22 ( .DI(clk_i), .YPAD(clk) );
  PADNC p03 ();
  PADNC p02 ();
  PADNC p01 ();
  PADNC p00 ();
  PADVDD p21 ();
  PADGND p20 ();
  PADFC c04 ();
  PADFC c03 ();
  PADFC c02 ();
  PADFC c01 ();

endmodule
