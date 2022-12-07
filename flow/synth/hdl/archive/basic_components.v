// Basic Components; muxes, flip-flops, etc.
//
// Author: Ivan Castellanos
// email: ivan.castellanos@okstate.edu
// VLSI Computer Architecture Research Group,
// Oklahoma Stata University


//Reduced Full Adder Cell (for CLA, 8 gates instead of 9)

module rfa (sum, g, p, a, b, cin);

   output sum;
   output g;
   output p;
   input a;
   input b;
   input cin;

   xor x1(sum, a, b, cin);
   and a1(g, a, b);
   or  o1(p, a, b);
   
endmodule


//17-bit Register with reset

module dffr_17 (q, d, clk, reset);

   output [15:0] q;
   input  [15:0] d;
   input  clk, reset;
   
   reg [15:0] q;
   
   always @ (posedge clk or negedge reset) 
      if (reset == 0)
         q <= 0; 
      else
         q <= d;

endmodule

//Basic adders for Multiplier

module FA (Sum, Cout, A, B, Cin);

   input A;
   input B;
   input Cin;   

   output Sum;
   output Cout;

	wire	w1;
	wire	w2;
	wire	w3;
	wire	w4;

	xor	x1(w1, A, B);
	xor	x2(Sum, w1, Cin);

	nand    n1(w2, A, B);
	nand    n2(w3, A, Cin);
	nand	n3(w4, B, Cin);
	nand	n4(Cout, w2, w3, w4);

endmodule // FA

module MFA (Sum, Cout, A, B, Sin, Cin);

   input A;
   input B;
   input Sin;
   input Cin;   

   output Sum;
   output Cout;

	wire    w0;
	wire	w1;
	wire	w2;
	wire	w3;
	wire	w4;

	and     a1(w0, A, B);

	xor	x1(w1, w0, Sin);
	xor	x2(Sum, w1, Cin);

	nand    n1(w2, w0, Sin);
	nand    n2(w3, w0, Cin);
	nand	n3(w4, Sin, Cin);
	nand	n4(Cout, w2, w3, w4);

endmodule // MFA

module NMFA (Sum, Cout, A, B, Sin, Cin);

   input A;
   input B;
   input Sin;
   input Cin;   

   output Sum;
   output Cout;

	wire  w0;
	wire	w1;
	wire	w2;
	wire	w3;
	wire	w4;

	nand    n0(w0, A, B);

	xor	x1(w1, w0, Sin);
	xor	x2(Sum, w1, Cin);

	nand    n1(w2, w0, Sin);
	nand    n2(w3, w0, Cin);
	nand	n3(w4, Sin, Cin);
	nand	n4(Cout, w2, w3, w4);

endmodule // NMFA

module MHA (Sum, Cout, A, B, Sin);

   input A;
   input B;
   input Sin;

   output Sum;
   output Cout;

	wire	w1;

	and	a0(w1, A, B);

	xor	x1(Sum, w1, Sin);

	and	a1(Cout, w1, Sin);

endmodule // MHA

