// Universal Shift Register
//
//   - Performs 4 different operations:
//      * Remain in same state.
//      * Shift it's contents to the left.
//      * Shift it's contents to the right.
//      * Load parallel data.
//
//  - Inputs:
//    * input logic  [WIDTH-1:0]      d
//    * input logic        [1:0]   ctrl
//    * input logic                 clk
//    * input logic               reset
//    
//  - Outputs:
//    * output logic [WIDTH-1:0]      q
//
//  - Internal Signals:
//    * logic        [WIDTH-1:0] r_next
//    * logic        [WIDTH-1:0]  r_reg
//
//  - ctrl signal: 
//      2'b00: remain the same.
//      2'b01: shift left.
//      2'b10: shift right.
//      2'b11: load parallel data.
//


module Univ_Shift_Reg #(parameter WIDTH=8)
(
  input logic  [WIDTH-1:0]      d,
  input logic        [1:0]   ctrl,
  input logic                 clk,
  input logic               reset,


  output logic [WIDTH-1:0]      q
);

  logic        [WIDTH-1:0]  r_next, r_reg;


  always_ff @(posedge clk, posedge reset)
  begin

    if(reset) 
      r_reg <= 0;
    else
      r_reg <= r_next;

  end // end always_ff

  always_comb
  begin

    case(ctrl)
      3'b00:   r_next = r_reg;
      3'b01:   r_next = {r_reg[WIDTH-2:0], d[0]};
      3'b10:   r_next = {d[WIDTH-1], r_reg[WIDTH-1:1]};
      3'b11:   r_next = d;
      default: r_next = r_reg;
    endcase

  end // end always_comb

  assign q = r_reg;

endmodule
