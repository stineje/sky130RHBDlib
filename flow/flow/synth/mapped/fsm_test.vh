/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : V-2023.12-SP3
// Date      : Thu Apr 17 12:17:37 2025
/////////////////////////////////////////////////////////////


module fsm_test ( clk, reset, a, y );
  input clk, reset, a;
  output y;
  wire   N14, n1, n2, n3;
  wire   [1:0] state;
  wire   [1:0] nextstate;
  assign y = N14;

  DFFRNX1 \state_reg[0]  ( .D(nextstate[0]), .CLK(clk), .RN(n3), .Q(state[0]), 
        .QN() );
  DFFRNX1 \state_reg[1]  ( .D(nextstate[1]), .CLK(clk), .RN(n3), .Q(state[1]), 
        .QN() );
  INVX1 U4 ( .A(state[1]), .Y(n2) );
  AND3X1 U5 ( .A(state[0]), .B(a), .C(n2), .Y(nextstate[1]) );
  AND2X1 U6 ( .A(state[1]), .B(state[0]), .Y(n1) );
  NOR2X1 U8 ( .A(state[0]), .B(n2), .Y(N14) );
  NOR2X1 U9 ( .A(n1), .B(a), .Y(nextstate[0]) );
  INVX1 U10 ( .A(reset), .Y(n3) );
endmodule

