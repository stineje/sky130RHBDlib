/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : V-2023.12-SP3
// Date      : Tue Apr 15 20:33:51 2025
/////////////////////////////////////////////////////////////


module fsm ( done, load_rega, load_regb, load_regc, load_regd, load_regr, 
        load_regs, sel_muxa, sel_muxb, sel_muxr, clk, reset, start, error, 
        op_type );
  output [2:0] sel_muxa;
  output [2:0] sel_muxb;
  input clk, reset, start, error, op_type;
  output done, load_rega, load_regb, load_regc, load_regd, load_regr,
         load_regs, sel_muxr;
  wire   N32, N33, N34, N35, N36, n88, n89, n90, n91, n92, n93, n94, n95, n96,
         n97, n98, n99, n100, n101, n102, n103, n104, n105, n106, n107, n108,
         n109, n110, n111, n112, n113, n114, n115, n116, n117, n118, n119,
         n120, n121, n122, n123, n124, n125, n126, n127, n128, n129, n130,
         n131, n132, n133, n134, n135, n136, n137, n138, n139, n140, n141,
         n142, n143, n144, n145, n146, n147, n148, n149, n150, n151, n152,
         n153, n154, n155, n156, n157, n158, n159, n160, n161, n162, n163,
         n164, n165, n166, n167, n168, n169, n170, n171, n172, n175, n176,
         n177, n178, n179;
  wire   [4:0] state;

  DFFX1 \state_reg[1]  ( .D(N33), .CLK(clk), .Q(state[1]), .QN(n178) );
  DFFX1 \state_reg[4]  ( .D(N36), .CLK(clk), .Q(state[4]), .QN(n179) );
  DFFX1 \state_reg[0]  ( .D(N32), .CLK(clk), .Q(state[0]), .QN(n176) );
  DFFX1 \state_reg[2]  ( .D(N34), .CLK(clk), .Q(state[2]), .QN(n175) );
  DFFX1 \state_reg[3]  ( .D(N35), .CLK(clk), .Q(state[3]), .QN(n177) );
  NOR2X1 U107 ( .A(n177), .B(state[2]), .Y(n164) );
  NOR2X1 U108 ( .A(n176), .B(state[1]), .Y(n144) );
  NAND2X1 U109 ( .A(n164), .B(n144), .Y(n147) );
  INVX1 U110 ( .A(n147), .Y(load_regr) );
  BUFX1 U111 ( .A(load_regr), .Y(sel_muxr) );
  NAND2X1 U112 ( .A(n176), .B(n178), .Y(n131) );
  INVX1 U113 ( .A(n131), .Y(n130) );
  NOR2X1 U114 ( .A(n176), .B(n178), .Y(n88) );
  NOR2X1 U115 ( .A(n130), .B(n88), .Y(n154) );
  NOR2X1 U116 ( .A(n154), .B(n179), .Y(n121) );
  NAND2X1 U117 ( .A(state[2]), .B(n177), .Y(n160) );
  INVX1 U118 ( .A(n160), .Y(n143) );
  NAND2X1 U119 ( .A(n121), .B(n143), .Y(n90) );
  NAND2X1 U120 ( .A(state[4]), .B(n144), .Y(n115) );
  INVX1 U121 ( .A(n115), .Y(n106) );
  NAND2X1 U122 ( .A(n175), .B(n177), .Y(n141) );
  INVX1 U123 ( .A(n141), .Y(n149) );
  NAND2X1 U124 ( .A(n106), .B(n149), .Y(n89) );
  NAND2X1 U125 ( .A(n90), .B(n89), .Y(sel_muxa[2]) );
  INVX1 U126 ( .A(sel_muxa[2]), .Y(n92) );
  NOR2X1 U127 ( .A(state[0]), .B(n178), .Y(n129) );
  AND3X1 U128 ( .A(state[2]), .B(state[3]), .C(n179), .Y(n155) );
  NAND2X1 U129 ( .A(n129), .B(n155), .Y(n137) );
  NAND3X1 U130 ( .A(state[0]), .B(n179), .C(n177), .Y(n91) );
  NAND3X1 U131 ( .A(n92), .B(n137), .C(n91), .Y(load_rega) );
  BUFX1 U132 ( .A(load_rega), .Y(load_regc) );
  NAND2X1 U133 ( .A(n175), .B(n178), .Y(n169) );
  INVX1 U134 ( .A(start), .Y(n111) );
  NOR2X1 U135 ( .A(n111), .B(op_type), .Y(n93) );
  NOR2X1 U136 ( .A(n169), .B(n93), .Y(n94) );
  NAND2X1 U137 ( .A(n179), .B(n176), .Y(n116) );
  NOR2X1 U138 ( .A(n94), .B(n116), .Y(n95) );
  NAND2X1 U139 ( .A(n95), .B(n177), .Y(n109) );
  NAND2X1 U140 ( .A(state[0]), .B(n155), .Y(n114) );
  NAND2X1 U141 ( .A(n143), .B(n154), .Y(n97) );
  OR2X1 U142 ( .A(n141), .B(n144), .Y(n96) );
  NAND2X1 U143 ( .A(n97), .B(n96), .Y(n98) );
  NAND2X1 U144 ( .A(state[4]), .B(n98), .Y(n99) );
  NAND3X1 U145 ( .A(n109), .B(n114), .C(n99), .Y(sel_muxb[0]) );
  NAND2X1 U146 ( .A(n177), .B(n169), .Y(n102) );
  NAND2X1 U147 ( .A(state[4]), .B(n177), .Y(n140) );
  OR2X1 U148 ( .A(n178), .B(n114), .Y(n127) );
  NAND2X1 U149 ( .A(n140), .B(n127), .Y(n171) );
  INVX1 U150 ( .A(n171), .Y(n101) );
  NAND2X1 U151 ( .A(n106), .B(n175), .Y(n100) );
  NAND3X1 U152 ( .A(n102), .B(n101), .C(n100), .Y(sel_muxb[1]) );
  NAND2X1 U153 ( .A(state[4]), .B(load_regr), .Y(n103) );
  NAND2X1 U154 ( .A(n137), .B(n103), .Y(sel_muxb[2]) );
  NAND2X1 U155 ( .A(n149), .B(n129), .Y(n104) );
  NAND2X1 U156 ( .A(n104), .B(n103), .Y(n110) );
  INVX1 U157 ( .A(n155), .Y(n139) );
  NOR2X1 U158 ( .A(n178), .B(n139), .Y(n105) );
  NOR2X1 U159 ( .A(n110), .B(n105), .Y(n108) );
  NAND2X1 U160 ( .A(n143), .B(n106), .Y(n107) );
  NAND3X1 U161 ( .A(n109), .B(n108), .C(n107), .Y(sel_muxa[0]) );
  INVX1 U162 ( .A(n110), .Y(n119) );
  NOR2X1 U163 ( .A(n116), .B(n111), .Y(n150) );
  NAND3X1 U164 ( .A(n150), .B(op_type), .C(n177), .Y(n113) );
  NAND3X1 U165 ( .A(n149), .B(n144), .C(n179), .Y(n112) );
  AND3X1 U166 ( .A(n114), .B(n113), .C(n112), .Y(n118) );
  NAND2X1 U167 ( .A(n116), .B(n115), .Y(n117) );
  NAND2X1 U168 ( .A(n143), .B(n117), .Y(n126) );
  NAND3X1 U169 ( .A(n119), .B(n118), .C(n126), .Y(sel_muxa[1]) );
  NAND2X1 U170 ( .A(state[4]), .B(n176), .Y(n151) );
  INVX1 U171 ( .A(n151), .Y(n120) );
  NAND3X1 U172 ( .A(state[1]), .B(n143), .C(n120), .Y(n124) );
  NAND2X1 U173 ( .A(n155), .B(n144), .Y(n123) );
  NAND2X1 U174 ( .A(n121), .B(n149), .Y(n122) );
  NAND3X1 U175 ( .A(n124), .B(n123), .C(n122), .Y(load_regd) );
  NOR2X1 U176 ( .A(n150), .B(n129), .Y(n125) );
  NOR2X1 U177 ( .A(n141), .B(n125), .Y(n133) );
  INVX1 U178 ( .A(n133), .Y(n128) );
  NAND3X1 U179 ( .A(n128), .B(n127), .C(n126), .Y(load_regb) );
  AND2X1 U180 ( .A(n129), .B(n164), .Y(done) );
  AND2X1 U181 ( .A(n130), .B(n164), .Y(load_regs) );
  NOR2X1 U182 ( .A(n160), .B(n131), .Y(n132) );
  NOR2X1 U183 ( .A(n133), .B(n132), .Y(n136) );
  NOR2X1 U184 ( .A(n151), .B(state[3]), .Y(n134) );
  NOR2X1 U185 ( .A(load_regs), .B(n134), .Y(n135) );
  AND3X1 U186 ( .A(n137), .B(n136), .C(n135), .Y(n138) );
  NOR2X1 U187 ( .A(reset), .B(n138), .Y(N32) );
  NAND3X1 U188 ( .A(n141), .B(n140), .C(n139), .Y(n142) );
  NAND2X1 U189 ( .A(n154), .B(n142), .Y(n146) );
  NAND2X1 U190 ( .A(n144), .B(n143), .Y(n145) );
  AND3X1 U191 ( .A(n147), .B(n146), .C(n145), .Y(n148) );
  NOR2X1 U192 ( .A(reset), .B(n148), .Y(N33) );
  NAND3X1 U193 ( .A(state[0]), .B(n149), .C(state[1]), .Y(n157) );
  NAND3X1 U194 ( .A(n150), .B(op_type), .C(n178), .Y(n159) );
  NAND2X1 U195 ( .A(state[1]), .B(n151), .Y(n161) );
  NAND2X1 U196 ( .A(state[2]), .B(n161), .Y(n152) );
  NAND2X1 U197 ( .A(n159), .B(n152), .Y(n153) );
  NAND2X1 U198 ( .A(n177), .B(n153), .Y(n156) );
  NAND2X1 U199 ( .A(n155), .B(n154), .Y(n167) );
  AND3X1 U200 ( .A(n157), .B(n156), .C(n167), .Y(n158) );
  NOR2X1 U201 ( .A(reset), .B(n158), .Y(N34) );
  NOR2X1 U202 ( .A(n159), .B(state[2]), .Y(n163) );
  NOR2X1 U203 ( .A(n161), .B(n160), .Y(n162) );
  NOR2X1 U204 ( .A(n163), .B(n162), .Y(n166) );
  NAND2X1 U205 ( .A(n164), .B(n178), .Y(n165) );
  AND3X1 U206 ( .A(n167), .B(n166), .C(n165), .Y(n168) );
  NOR2X1 U207 ( .A(reset), .B(n168), .Y(N35) );
  NOR2X1 U208 ( .A(n179), .B(n169), .Y(n170) );
  NOR2X1 U209 ( .A(n171), .B(n170), .Y(n172) );
  NOR2X1 U210 ( .A(reset), .B(n172), .Y(N36) );
endmodule

