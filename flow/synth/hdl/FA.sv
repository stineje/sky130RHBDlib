module FA(
	input logic a,b,cin, 
	output logic cout,sum); 

    assign sum = (a&!b&!cin) | (!a&b&!cin) | (!a&!b&cin) | (a&b&cin);
    assign cout = (a&b) | (a&cin) | (b&cin);
endmodule
