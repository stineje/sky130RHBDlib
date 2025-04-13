`timescale 1ns/1ps
module tb;
  
  localparam WIDTH = 16;
  localparam RANGE = 2**WIDTH;
  localparam T = 10;

  logic [WIDTH-1:0] a, b, y;

  integer iter, pass, fail;

  Adder #(WIDTH) dut (
    .a(a),
    .b(b),
    .y(y)
  );

  // initialize signals
  initial 
  begin
    $display("RANGE = %d", RANGE);
    a = 0;
    b = 0;
    iter = 0;
    pass = 0;
    fail = 0;
  end //initial

  always
  begin

    a = $urandom_range(RANGE);
    b = $urandom_range(RANGE);

    #(T);

    if (y == (a + b))
      pass = pass + 1;
    else
      fail = fail + 1;

    iter = iter + 1;
    if (iter >= 10000)
    begin
      $display("[PASSED] %d\n[FAILED] %d", pass, fail);
      $stop;

    end // if (iter >= 10000)

  end // always

endmodule // tb
