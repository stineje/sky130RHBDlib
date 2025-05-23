// Ross Thompson
// September 20, 2019
// Oklahoma State University

// Counter.sv
// General purpuse up counter
// Specify the number of bits, automatically wraps around
// to zero.

module counter
  #(parameter WIDTH = 32)
   (input clk,
    input areset,
    input enable,
    input load,
    input [WIDTH-1:0] count_in,
    output [WIDTH-1:0] count_out);

   wire [WIDTH-1:0]    count_d;
   wire [WIDTH-1:0]    count_p1;
   wire 	       en;


   flopenr #(WIDTH) register(.clk(clk),
			     .reset(areset),
			     .en(en),
			     .d(count_d),
			     .q(count_out));
   
   assign count_p1 = count_out + 1'b1;
   assign count_d = load ? count_in : count_p1;
   assign en = enable | load;
   
endmodule


