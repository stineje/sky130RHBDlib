module half_adder (Cout, Sum, A, B);

   input A,B;
   output Sum,Cout;

   xor xor1(Sum,A,B);
   and and1(Cout,A,B);

endmodule // ha


module full_adder (Cout, Sum, A, B, Cin);

   input A,B,Cin;
   output Sum,Cout;
   wire S1,C1,C2;

   half_adder ha1(C1,S1,A,B);
   half_adder ha2(C2,Sum,S1,Cin);
   or or1(Cout,C1,C2);

endmodule // fa

module specialized_half_adder (Cout, Sum, A, B);

   input A,B;
   output Sum,Cout;

   assign Cout = A | B;
   assign Sum = !(A ^ B);
   
endmodule // sha

module reduced_full_adder (Cout, A, B, Cin);
   
   input A,B,Cin;
   output Cout;

   assign Cout = (A&(B|Cin)) | (B&Cin);

endmodule // reduced_full_adder
