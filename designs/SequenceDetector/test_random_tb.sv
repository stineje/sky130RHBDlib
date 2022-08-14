`timescale 1ns/1ns
module tb;
  
  localparam T = 20;
  logic d, clk;
  logic [3:0] current_sequence;
  integer iter;
  

  initial 
  begin
    iter = 0;
    clk = 1'b0;
    forever #(T / 2) clk = ~clk;
  end

  always @(posedge clk)
  begin
    std::randomize(d);
    current_sequence <= {current_sequence[2:0], d};
    if (current_sequence == 4'b0111)
      $display("SEQUENCE FOUND:(%d) %b", iter, current_sequence);
    iter = iter + 1;

    if (iter == 10000)
      $stop;
  end

endmodule // tb
