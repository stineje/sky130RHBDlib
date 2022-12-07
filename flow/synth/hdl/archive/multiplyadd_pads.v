// 16-Bit Multiply Add Unit, test design for Standard Cell/Custom Design
// F = Accumulation ( A * B )
// Author: Ivan Castellanos
// email: ivan.castellanos@okstate.edu
// VLSI Computer Architecture Research Group,
// Oklahoma Stata University

module multiplyadd(result, a, b, reset, clk);

   output [16:0] result;
   input  [7:0] a;
   input  [7:0] b;
   input  reset;
   input  clk;
   
   wire [15:0] multiplication;
   wire [16:0] sum;
   wire [7:0]  a_i, b_i;
   wire [16:0] result_i;
   wire        reset_i, clk_i;

// Custom cell block:
   multi multi_module(multiplication, a_i, b_i);

   cla16 cla16_module(sum, multiplication, result_i[15:0]);

// Output register is 17-bits long to include Carry out in the result.
   dffr_17 accu_output(result_i, sum, clk_i, reset_i);

  PADOUT U56 ( .DO(result_i[15]), .YPAD(result[15]) );
  PADOUT U57 ( .DO(result_i[14]), .YPAD(result[14]) );
  PADOUT U58 ( .DO(result_i[13]), .YPAD(result[13]) );
  PADOUT U59 ( .DO(result_i[12]), .YPAD(result[12]) );
  PADOUT U60 ( .DO(result_i[11]), .YPAD(result[11]) );
  PADOUT U61 ( .DO(result_i[10]), .YPAD(result[10]) );
  PADOUT U62 ( .DO(result_i[9]), .YPAD(result[9]) );
  PADOUT U63 ( .DO(result_i[8]), .YPAD(result[8]) );
  PADOUT U64 ( .DO(result_i[7]), .YPAD(result[7]) );
  PADOUT U65 ( .DO(result_i[6]), .YPAD(result[6]) );
  PADOUT U66 ( .DO(result_i[5]), .YPAD(result[5]) );
  PADOUT U67 ( .DO(result_i[4]), .YPAD(result[4]) );
  PADOUT U68 ( .DO(result_i[3]), .YPAD(result[3]) );
  PADOUT U69 ( .DO(result_i[2]), .YPAD(result[2]) );
  PADOUT U70 ( .DO(result_i[1]), .YPAD(result[1]) );
  PADOUT U71 ( .DO(result_i[0]), .YPAD(result[0]) );
  PADINC U72 ( .DI(a_i[7]), .YPAD(a[7]) );
  PADINC U73 ( .DI(a_i[6]), .YPAD(a[6]) );
  PADINC U74 ( .DI(a_i[5]), .YPAD(a[5]) );
  PADINC U75 ( .DI(a_i[4]), .YPAD(a[4]) );
  PADINC U76 ( .DI(a_i[3]), .YPAD(a[3]) );
  PADINC U77 ( .DI(a_i[2]), .YPAD(a[2]) );
  PADINC U78 ( .DI(a_i[1]), .YPAD(a[1]) );
  PADINC U79 ( .DI(a_i[0]), .YPAD(a[0]) );
  PADINC U80 ( .DI(b_i[7]), .YPAD(b[7]) );
  PADINC U81 ( .DI(b_i[6]), .YPAD(b[6]) );
  PADINC U82 ( .DI(b_i[5]), .YPAD(b[5]) );
  PADINC U83 ( .DI(b_i[4]), .YPAD(b[4]) );
  PADINC U84 ( .DI(b_i[3]), .YPAD(b[3]) );
  PADINC U85 ( .DI(b_i[2]), .YPAD(b[2]) );
  PADINC U86 ( .DI(b_i[1]), .YPAD(b[1]) );
  PADINC U87 ( .DI(b_i[0]), .YPAD(b[0]) );
  PADINC U88 ( .DI(reset_i), .YPAD(reset) );
  PADINC U89 ( .DI(clk_i), .YPAD(clk) );

endmodule
