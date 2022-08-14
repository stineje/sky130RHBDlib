module Adder #(parameter WIDTH=8)(
  input  logic [WIDTH-1:0] a, b,

  output logic [WIDTH-1:0] y
);

  logic [WIDTH-1:0] cout;
  generate
    genvar i;
    for (i = 0; i < WIDTH; i=i+1)
    begin
      if(i == 0)
        Half_Adder ha(.a(a[0]), .b(b[0]), .y(y[0]), .cout(cout[0]));
      else
        Full_Adder fa(.a(a[i]), .b(b[i]), .cin(cout[i-1]), .y(y[i]), .cout(cout[i]));
    end

  endgenerate

endmodule
