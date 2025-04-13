`timescale 1ns/1ps

module tb();

  // Define signals
  localparam N = 8;
  localparam T = 20;

  logic           clk, reset;
  logic [N-1:0] d_vec, q_vec;
  logic   [1:0]     ctrl_vec;

  // Instatiate dut (device under test)
  Univ_Shift_Reg #(.WIDTH(N)) dut (.d(d_vec), .ctrl(ctrl_vec), .clk(clk),
                              .reset(reset), .q(q_vec));

  // Set up clk
  always
  begin
    clk = 1'b0;
    #(T / 2);
    clk = 1'b1;
    #(T / 2);
  end

  // Initial reset
  initial
  begin
    reset = 1;
    #(T/2);
    reset = 0;
  end

  // Increment d every 2 clk cycles
  //always
  //begin
  //  repeat(2) @(negedge clk)
  //  d_vec = d_vec + 1;
  //end

  // Wouldn't this also work??
  // This would do it every 1 clk cycle
  
  always @(negedge clk)
  begin
    d_vec = d_vec + 1;
  end

  initial
  begin
    d_vec = 0;
    ctrl_vec = 2'b01;

    wait(d_vec == 10)
    #(12)

    reset = 1;
    #(3)
    reset = 0;
    d_vec = 0;
    ctrl_vec = 2'b10;

    wait(d_vec == 10)
    #(12)

    reset = 1;
    #(3)
    reset = 0;
    d_vec = 0;
    ctrl_vec = 2'b11;
    #(12)

    wait(d_vec == 10)
    #(12)

    reset = 1;
    #(3)
    reset = 0;
    d_vec = 0;
    ctrl_vec = 2'b00;
    #(12)

    $stop;
  end

endmodule
