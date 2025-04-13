`timescale 1ns/1ps
module tb;
  
  localparam T = 20;
  logic d, clk, reset, y;

  logic [3:0] current_sequence;

  integer iter, pass, fail;

  seq_detector dut (
    .d(d),
    .clk(clk),
    .reset(reset),
    .y(y)
  );

  // initialize signals
  initial 
  begin
    iter = 0;
    pass = 0;
    fail = 0;
    reset = 1;
    clk = 1'b0;
    #(T)
    reset = 0;
    forever #(T / 2) clk = ~clk;
  end //initial

  always @(posedge clk)
  begin

    std::randomize(d);

    current_sequence <= {current_sequence[2:0], d};
    #(1)

    if (current_sequence == 4'b0111)
    begin

      if (y == 1'b1)
        pass = pass + 1;
      else
        fail = fail + 1;

    end // if (current_sequence == 4'b0111)

    else
    begin

      if (y == 1'b0)
        pass = pass + 1;
      else
        fail = fail + 1;

    end // else

    iter = iter + 1;
    if (iter >= 10000)
    begin

      $display("[PASSED] %d\n[FAILED] %d", pass, fail);
      #(1)
      $stop;

    end // if (iter >= 10000)

  end // always @(posedge clk)

endmodule // tb
