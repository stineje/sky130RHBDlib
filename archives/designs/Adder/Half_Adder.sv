module Half_Adder(
  input logic   a, b,

  output logic  y, cout

);

assign y = a ^ b;
assign cout = a & b;

endmodule
