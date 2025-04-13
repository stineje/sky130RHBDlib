// Module: Mod2_Counter
// Author: Ryan Ridley
// 
// Function: Counts up by 1 on every rising edge of clk
//
//
//
//       LSB-> QA          MSB-> QB 
//              ^                ^ 
//  ____________|   ____________|
// |   ______   |  |   ______   |
// |  |      |  |  |  |      |  |
// -->|d   QN|---  -->|d   QN|---
//    |      |        |      |  
//  ->|clk  q|------->|clk  q|--->
//    |______|        |______|  
//      LSB             MSB
//
// Just uses the CLK to count

module Mod4_Counter(
  input  logic clk, reset,

  output logic [1:0] y
);

  logic clk2, fp2_q;
  flop fp1(.d(y[0]), .clk(clk), .reset(reset), .q(clk2), .qn(y[0]));
  flop fp2(.d(y[1]), .clk(clk2), .reset(reset), .q(fp2_q), .qn(y[1]));

endmodule // seq_detector

module flop(
  input logic d, clk, reset,

  output logic q, qn
);

  always_ff @(posedge clk, posedge reset)
  begin
    if (reset)
    begin
      q <= 0;
      qn <= 1;
    end
    else
    begin
      q  <= d;
      qn <= ~d;
    end
  end
endmodule
