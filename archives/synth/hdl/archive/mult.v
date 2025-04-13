// 16-Bit Multiply Add Unit, test design for Standard Cell/Custom Design
// F = Accumulation ( A * B )
// Author: Ivan Castellanos
// email: ivan.castellanos@okstate.edu
// VLSI Computer Architecture Research Group,
// Oklahoma Stata University

module mult_alone (result, a, b, reset, clk);

   output [15:0] result;
   input  [7:0] a;
   input  [7:0] b;
   input  reset;
   input  clk;
   
   wire [15:0] multiplication;
   wire [16:0] sum;

   // Custom cell block:
   mult multiply(multiplication, a, b);

   cla16 cla16_module(sum, multiplication, result[15:0]);

   // Output register is 17-bits long to include Carry out in the result.
   dffr_17 accu_output(result, sum[15:0], clk, reset);
   
endmodule // mult_pad

