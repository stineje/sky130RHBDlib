module HA(
	input logic a,b,
	output logic cout,sum); 

    assign sum = a ^ b;
    assign cout = a & b;
endmodule
