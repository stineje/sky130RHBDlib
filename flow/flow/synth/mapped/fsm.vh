/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : V-2023.12-SP3
// Date      : Tue Apr 22 11:05:10 2025
/////////////////////////////////////////////////////////////


module fsm ( done, load_rega, load_regb, load_regc, load_regd, load_regr, 
        load_regs, sel_muxa, sel_muxb, sel_muxr, clk, reset, start, error, 
        op_type );
  output [2:0] sel_muxa;
  output [2:0] sel_muxb;
  input clk, reset, start, error, op_type;
  output done, load_rega, load_regb, load_regc, load_regd, load_regr,
         load_regs, sel_muxr;
  wire   N32, N33, N34, N35, N36, n88, n90, n91, n92, n93, n94, n95, n96, n97,
         n98, n99, n100, n101, n102, n103, n104, n105, n106, n107, n108, n109,
         n110, n111, n112, n113, n114, n115, n116, n117, n118, n119, n120,
         n121, n122, n123, n124, n125, n126, n127, n128, n129, n130, n131,
         n132, n133, n134, n135, n136, n137, n138, n139, n140, n141, n142,
         n143, n144, n145, n146, n147, n148, n149, n150, n151, n152, n153,
         n154, n155, n156, n157, n158, n159, n160, n161, n162, n163, n164,
         n165, n166, n167, n168, n169, n170, n171, n172, n173, n174, n177,
         n178, n179, n180, n181;
  wire   [4:0] state;

  DFFX1 \state_reg[1]  ( .D(N33), .CLK(clk), .Q(state[1]), .QN(n180) );
  DFFX1 \state_reg[4]  ( .D(N36), .CLK(clk), .Q(state[4]), .QN(n181) );
  DFFX1 \state_reg[0]  ( .D(N32), .CLK(clk), .Q(state[0]), .QN(n178) );
  DFFX1 \state_reg[2]  ( .D(N34), .CLK(clk), .Q(state[2]), .QN(n177) );
  DFFX1 \state_reg[3]  ( .D(N35), .CLK(clk), .Q(state[3]), .QN(n179) );
  OR2X1 U107 ( .A(n165), .B(n164), .Y(n88) );
  OR2X1 U108 ( .A(n94), .B(sel_muxa[2]), .Y(load_rega) );
  AND2X1 U109 ( .A(n92), .B(n136), .Y(n90) );
  NOR2X1 U110 ( .A(n116), .B(n121), .Y(n155) );
  NOR2X1 U111 ( .A(n91), .B(n166), .Y(n170) );
  NAND3X1 U112 ( .A(n88), .B(n169), .C(n168), .Y(n91) );
  INVX1 U113 ( .A(n136), .Y(n135) );
  INVX1 U114 ( .A(n95), .Y(n92) );
  NAND2X1 U115 ( .A(n96), .B(n93), .Y(sel_muxa[2]) );
  NAND2X1 U116 ( .A(n148), .B(n126), .Y(n93) );
  NAND2X1 U117 ( .A(n97), .B(n142), .Y(n94) );
  NOR2X1 U118 ( .A(n179), .B(state[2]), .Y(n167) );
  NOR2X1 U119 ( .A(n178), .B(state[1]), .Y(n149) );
  NAND2X1 U120 ( .A(n167), .B(n149), .Y(n152) );
  INVX1 U121 ( .A(n152), .Y(load_regr) );
  BUFX1 U122 ( .A(load_regr), .Y(sel_muxr) );
  NAND2X1 U123 ( .A(n178), .B(n180), .Y(n136) );
  NOR2X1 U124 ( .A(n178), .B(n180), .Y(n95) );
  NOR2X1 U125 ( .A(n90), .B(n181), .Y(n126) );
  NAND2X1 U126 ( .A(state[2]), .B(n179), .Y(n164) );
  INVX1 U127 ( .A(n164), .Y(n148) );
  NAND2X1 U128 ( .A(state[4]), .B(n149), .Y(n120) );
  INVX1 U129 ( .A(n120), .Y(n111) );
  NAND2X1 U130 ( .A(n177), .B(n179), .Y(n146) );
  INVX1 U131 ( .A(n146), .Y(n154) );
  NAND2X1 U132 ( .A(n111), .B(n154), .Y(n96) );
  NOR2X1 U133 ( .A(state[0]), .B(n180), .Y(n134) );
  AND3X1 U134 ( .A(state[2]), .B(state[3]), .C(n181), .Y(n159) );
  NAND2X1 U135 ( .A(n134), .B(n159), .Y(n142) );
  NAND3X1 U136 ( .A(state[0]), .B(n181), .C(n179), .Y(n97) );
  BUFX1 U137 ( .A(load_rega), .Y(load_regc) );
  NAND2X1 U138 ( .A(n177), .B(n180), .Y(n171) );
  INVX1 U139 ( .A(start), .Y(n116) );
  NOR2X1 U140 ( .A(n116), .B(op_type), .Y(n98) );
  NOR2X1 U141 ( .A(n171), .B(n98), .Y(n99) );
  NAND2X1 U142 ( .A(n181), .B(n178), .Y(n121) );
  NOR2X1 U143 ( .A(n99), .B(n121), .Y(n100) );
  NAND2X1 U144 ( .A(n100), .B(n179), .Y(n114) );
  NAND2X1 U145 ( .A(state[0]), .B(n159), .Y(n119) );
  NAND2X1 U146 ( .A(n148), .B(n90), .Y(n102) );
  OR2X1 U147 ( .A(n146), .B(n149), .Y(n101) );
  NAND2X1 U148 ( .A(n102), .B(n101), .Y(n103) );
  NAND2X1 U149 ( .A(state[4]), .B(n103), .Y(n104) );
  NAND3X1 U150 ( .A(n114), .B(n119), .C(n104), .Y(sel_muxb[0]) );
  NAND2X1 U151 ( .A(n179), .B(n171), .Y(n107) );
  NAND2X1 U152 ( .A(state[4]), .B(n179), .Y(n145) );
  OR2X1 U153 ( .A(n180), .B(n119), .Y(n132) );
  NAND2X1 U154 ( .A(n145), .B(n132), .Y(n173) );
  INVX1 U155 ( .A(n173), .Y(n106) );
  NAND2X1 U156 ( .A(n111), .B(n177), .Y(n105) );
  NAND3X1 U157 ( .A(n107), .B(n106), .C(n105), .Y(sel_muxb[1]) );
  NAND2X1 U158 ( .A(state[4]), .B(load_regr), .Y(n108) );
  NAND2X1 U159 ( .A(n142), .B(n108), .Y(sel_muxb[2]) );
  NAND2X1 U160 ( .A(n154), .B(n134), .Y(n109) );
  NAND2X1 U161 ( .A(n109), .B(n108), .Y(n115) );
  INVX1 U162 ( .A(n159), .Y(n144) );
  NOR2X1 U163 ( .A(n180), .B(n144), .Y(n110) );
  NOR2X1 U164 ( .A(n115), .B(n110), .Y(n113) );
  NAND2X1 U165 ( .A(n148), .B(n111), .Y(n112) );
  NAND3X1 U166 ( .A(n114), .B(n113), .C(n112), .Y(sel_muxa[0]) );
  INVX1 U167 ( .A(n115), .Y(n124) );
  NAND3X1 U168 ( .A(n155), .B(op_type), .C(n179), .Y(n118) );
  NAND3X1 U169 ( .A(n154), .B(n149), .C(n181), .Y(n117) );
  AND3X1 U170 ( .A(n119), .B(n118), .C(n117), .Y(n123) );
  NAND2X1 U171 ( .A(n121), .B(n120), .Y(n122) );
  NAND2X1 U172 ( .A(n148), .B(n122), .Y(n131) );
  NAND3X1 U173 ( .A(n124), .B(n123), .C(n131), .Y(sel_muxa[1]) );
  NAND2X1 U174 ( .A(state[4]), .B(n178), .Y(n156) );
  INVX1 U175 ( .A(n156), .Y(n125) );
  NAND3X1 U176 ( .A(state[1]), .B(n148), .C(n125), .Y(n129) );
  NAND2X1 U177 ( .A(n159), .B(n149), .Y(n128) );
  NAND2X1 U178 ( .A(n126), .B(n154), .Y(n127) );
  NAND3X1 U179 ( .A(n129), .B(n128), .C(n127), .Y(load_regd) );
  NOR2X1 U180 ( .A(n155), .B(n134), .Y(n130) );
  NOR2X1 U181 ( .A(n146), .B(n130), .Y(n138) );
  INVX1 U182 ( .A(n138), .Y(n133) );
  NAND3X1 U183 ( .A(n133), .B(n132), .C(n131), .Y(load_regb) );
  AND2X1 U184 ( .A(n134), .B(n167), .Y(done) );
  AND2X1 U185 ( .A(n135), .B(n167), .Y(load_regs) );
  NOR2X1 U186 ( .A(n164), .B(n136), .Y(n137) );
  NOR2X1 U187 ( .A(n138), .B(n137), .Y(n141) );
  NOR2X1 U188 ( .A(n156), .B(state[3]), .Y(n139) );
  NOR2X1 U189 ( .A(load_regs), .B(n139), .Y(n140) );
  AND3X1 U190 ( .A(n142), .B(n141), .C(n140), .Y(n143) );
  NOR2X1 U191 ( .A(reset), .B(n143), .Y(N32) );
  NAND3X1 U192 ( .A(n146), .B(n145), .C(n144), .Y(n147) );
  NAND2X1 U193 ( .A(n90), .B(n147), .Y(n151) );
  NAND2X1 U194 ( .A(n149), .B(n148), .Y(n150) );
  AND3X1 U195 ( .A(n152), .B(n151), .C(n150), .Y(n153) );
  NOR2X1 U196 ( .A(reset), .B(n153), .Y(N33) );
  NAND3X1 U197 ( .A(state[0]), .B(n154), .C(state[1]), .Y(n161) );
  NAND3X1 U198 ( .A(n155), .B(op_type), .C(n180), .Y(n163) );
  NAND2X1 U199 ( .A(state[1]), .B(n156), .Y(n165) );
  NAND2X1 U200 ( .A(state[2]), .B(n165), .Y(n157) );
  NAND2X1 U201 ( .A(n163), .B(n157), .Y(n158) );
  NAND2X1 U202 ( .A(n179), .B(n158), .Y(n160) );
  NAND2X1 U203 ( .A(n159), .B(n90), .Y(n169) );
  AND3X1 U204 ( .A(n161), .B(n160), .C(n169), .Y(n162) );
  NOR2X1 U205 ( .A(reset), .B(n162), .Y(N34) );
  NOR2X1 U206 ( .A(n163), .B(state[2]), .Y(n166) );
  NAND2X1 U207 ( .A(n167), .B(n180), .Y(n168) );
  NOR2X1 U208 ( .A(reset), .B(n170), .Y(N35) );
  NOR2X1 U209 ( .A(n181), .B(n171), .Y(n172) );
  NOR2X1 U210 ( .A(n173), .B(n172), .Y(n174) );
  NOR2X1 U211 ( .A(reset), .B(n174), .Y(N36) );
endmodule

