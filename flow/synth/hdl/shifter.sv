module shifter (input  logic signed [31:0] a,
		input logic [ 4:0]  shamt,
		input logic [ 1:0]  shtype,
		output logic [31:0] y);
   
   always_comb
     case (shtype)
       2'b00:   
	 begin
	    y = a << shamt;
	 end	    
       2'b01:   
	 begin
	    y = a >> shamt;
	 end
       2'b10:   
	 begin
	    y = a >>> shamt;
	 end
       default: 
	 begin
	    y = a;
	 end
     endcase // case (shtype)

endmodule // shifter
