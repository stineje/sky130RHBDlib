`timescale 1ns/1ps
module tb;
  
  localparam T = 20;
  logic clk, reset;
  logic [1:0] y;

  Mod4Counter dut (
    .clk(clk),
    .reset(reset),
    .y(y)
  );

  // initialize signals
  initial 
  begin
    clk = 1'b0;
    reset = 1'b1;
    #(T)
    reset = 1'b0;
    #(T)
    forever #(T / 2) clk = ~clk;
  end //initial

endmodule // tb
