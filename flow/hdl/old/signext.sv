module signext (input  [31:0] a,
		input [1:0]   sel,
		output [31:0] y);

   // 0 = normal (I) immediate 
   // 1 = sw (S) immediate
   // 2 = branch (SB) immediate
   // 3 = jal (UJ) immediate
   mux4 #(32) m1 (.d0({{21{a[31]}}, a[30:20]}),
                  .d1({{21{a[31]}}, a[30:25], a[11:7]}),
                  .d2({{21{a[31]}}, a[7], a[30:25], a[11:8]}),
                  .d3({{13{a[31]}}, a[19:12], a[20], a[30:21]}),
                  .s(sel),
                  .y(y));
   
endmodule // signext
