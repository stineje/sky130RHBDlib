/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : V-2023.12-SP3
// Date      : Fri Mar  7 11:20:42 2025
/////////////////////////////////////////////////////////////


module mult2 ( op1, op2, clk, y );
  input [10:0] op1;
  input [10:0] op2;
  output [21:0] y;
  input clk;
  wire   n23;

  TIEHI U3 ( .Y(n23) );
  INVX1 U4 ( .A(n23), .Y(y[1]) );
  INVX1 U5 ( .A(n23), .Y(y[2]) );
  INVX1 U6 ( .A(n23), .Y(y[3]) );
  INVX1 U7 ( .A(n23), .Y(y[4]) );
  INVX1 U8 ( .A(n23), .Y(y[5]) );
  INVX1 U9 ( .A(n23), .Y(y[6]) );
  INVX1 U10 ( .A(n23), .Y(y[7]) );
  INVX1 U11 ( .A(n23), .Y(y[8]) );
  INVX1 U12 ( .A(n23), .Y(y[9]) );
  INVX1 U13 ( .A(n23), .Y(y[10]) );
  INVX1 U14 ( .A(n23), .Y(y[11]) );
  INVX1 U15 ( .A(n23), .Y(y[12]) );
  INVX1 U16 ( .A(n23), .Y(y[13]) );
  INVX1 U17 ( .A(n23), .Y(y[14]) );
  INVX1 U18 ( .A(n23), .Y(y[15]) );
  INVX1 U19 ( .A(n23), .Y(y[16]) );
  INVX1 U20 ( .A(n23), .Y(y[17]) );
  INVX1 U21 ( .A(n23), .Y(y[18]) );
  INVX1 U22 ( .A(n23), .Y(y[19]) );
  INVX1 U23 ( .A(n23), .Y(y[20]) );
  INVX1 U24 ( .A(n23), .Y(y[21]) );
  AND2X1 U25 ( .A(op2[0]), .B(op1[0]), .Y(y[0]) );
endmodule

