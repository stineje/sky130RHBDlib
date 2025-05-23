module alu (input [31:0]      a, b, 
            input [3:0]       alucont,
	    input 	      sltunsigned,
            output reg [31:0] result);
   
   wire [32:0] 		      a2, b2, sum;
   wire [31:0] 		      slt;

   assign a2 = {sltunsigned ? 1'b0 : a[31], a};
   assign b2 = alucont[2] ? ~{sltunsigned ? 1'b0 : b[31], b} : 
	       {sltunsigned ? 1'b0 : b[31], b};
   assign sum = a2 + b2 + alucont[2];
   assign slt = sum[32];

   always@(*)
     case({alucont[3], alucont[1:0]})
       3'b000: result <= a2 & b2;
       3'b001: result <= a2 | b2;
       3'b010: result <= sum[31:0];
       3'b011: result <= slt;
       3'b100: result <= a2 ^ b2;       
       default: result <= 32'h0;       
     endcase

endmodule // alu
