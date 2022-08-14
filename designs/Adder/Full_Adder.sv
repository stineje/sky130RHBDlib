module Full_Adder(                                                              
  input logic   a, b, cin,                                                      
                                                                                
  output logic  y, cout                                                         
                                                                                
);                                                                              
                                                                                
  assign {cout, y}  = a + b + cin;                                              
                                                                                
endmodule  

