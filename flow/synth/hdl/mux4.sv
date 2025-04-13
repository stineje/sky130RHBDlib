module mux4 #(parameter WIDTH = 8)
   (input  logic [WIDTH-1:0] d0, d1, d2, d3,
    input  logic [1:0]       s, 
    output logic [WIDTH-1:0] y);

   assign y = s[1] ? (s[0] ? d3 : d2) : (s[0] ? d1 : d0);

endmodule // mux4
