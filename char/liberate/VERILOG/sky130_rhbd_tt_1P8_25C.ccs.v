// Verilog for library /import/yukari1/lrburle/sky130RHBDlib/char/liberate/VERILOG/sky130_rhbd_tt_1P8_25C.ccs created by Liberate 23.1.1.221.isr1 on Tue Jan 27 19:42:04 2026 for SDF version 2.1

// type:  
`timescale 1ns/10ps
`celldefine
module AND2X1 (Y, B);
	output Y;
	input B;

	// Function
	buf (Y, B);

	// Timing
	specify
		ifnone (negedge B => (Y+:1'b0)) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module AND3X1 (Y, B, C);
	output Y;
	input B, C;

	// Function
	and (Y, B, C);

	// Timing
	specify
		ifnone (negedge B => (Y+:1'b0)) = 0;
		ifnone (negedge C => (Y+:1'b0)) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module AO3X1 (Y, B, C);
	output Y;
	input B, C;

	// Function
	wire B__bar;

	not (B__bar, B);
	or (Y, B__bar, C);

	// Timing
	specify
		ifnone (negedge B => (Y+:1'b1)) = 0;
		(C => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module AOA4X1 (Y, B, C, D);
	output Y;
	input B, C, D;

	// Function
	wire C__bar;

	not (C__bar, C);
	and (Y, B, C__bar, D);

	// Timing
	specify
		ifnone (negedge B => (Y+:1'b0)) = 0;
		(C => Y) = 0;
		(D => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module AOAI4X1 (YN, B, C, D);
	output YN;
	input B, C, D;

	// Function
	wire B__bar, D__bar;

	not (D__bar, D);
	not (B__bar, B);
	or (YN, B__bar, C, D__bar);

	// Timing
	specify
		ifnone (negedge B => (YN+:1'b1)) = 0;
		(C => YN) = 0;
		(D => YN) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module AOI3X1 (YN, B, C);
	output YN;
	input B, C;

	// Function
	wire C__bar;

	not (C__bar, C);
	and (YN, B, C__bar);

	// Timing
	specify
		ifnone (negedge B => (YN+:1'b0)) = 0;
		(C => YN) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module BUFX1 ();
	// Timing
	specify
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module DFFQNX1 (QN, CLK, D);
	output QN;
	input CLK, D;

	// Function
	buf (QN, 1'b1);

	// Timing
	specify
		(CLK => QN) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module DFFQX1 (Q, CLK, D);
	output Q;
	input CLK, D;

	// Function
	buf (Q, 1'b1);

	// Timing
	specify
		(CLK => Q) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module DFFRNQNX1 (QN, CLK, D, RN);
	output QN;
	input CLK, D, RN;

	// Function
	buf (QN, 1'b1);

	// Timing
	reg notifier;

	// Additional timing wires
	wire adacond0, adacond1, adacond2;
	wire adacond3, CLK__bar, D__bar;


	// Additional timing gates
	and (adacond0, CLK, D);
	not (D__bar, D);
	and (adacond1, CLK, D__bar);
	not (CLK__bar, CLK);
	and (adacond2, CLK__bar, D);
	and (adacond3, CLK__bar, D__bar);

	specify
		(CLK => QN) = 0;
		if ((CLK & D))
			(negedge RN => (QN-:1'b1)) = 0;
		if ((CLK & ~D))
			(negedge RN => (QN-:1'b1)) = 0;
		if ((~CLK & D))
			(negedge RN => (QN-:1'b1)) = 0;
		if ((~CLK & ~D))
			(negedge RN => (QN-:1'b1)) = 0;
		ifnone (negedge RN => (QN-:1'b1)) = 0;
		$width (negedge RN &&& adacond0, 0, 0, notifier);
		$width (negedge RN &&& adacond1, 0, 0, notifier);
		$width (negedge RN &&& adacond2, 0, 0, notifier);
		$width (negedge RN &&& adacond3, 0, 0, notifier);
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module DFFSNQX1 (Q, CLK, D, SN);
	output Q;
	input CLK, D, SN;

	// Function
	buf (Q, 1'b1);

	// Timing
	reg notifier;

	// Additional timing wires
	wire adacond0, adacond1, adacond2;
	wire adacond3, CLK__bar, D__bar;


	// Additional timing gates
	and (adacond0, CLK, D);
	not (D__bar, D);
	and (adacond1, CLK, D__bar);
	not (CLK__bar, CLK);
	and (adacond2, CLK__bar, D);
	and (adacond3, CLK__bar, D__bar);

	specify
		(CLK => Q) = 0;
		if ((CLK & D))
			(negedge SN => (Q-:1'b1)) = 0;
		if ((CLK & ~D))
			(negedge SN => (Q-:1'b1)) = 0;
		if ((~CLK & D))
			(negedge SN => (Q-:1'b1)) = 0;
		if ((~CLK & ~D))
			(negedge SN => (Q-:1'b1)) = 0;
		ifnone (negedge SN => (Q-:1'b1)) = 0;
		$width (negedge SN &&& adacond0, 0, 0, notifier);
		$width (negedge SN &&& adacond1, 0, 0, notifier);
		$width (negedge SN &&& adacond2, 0, 0, notifier);
		$width (negedge SN &&& adacond3, 0, 0, notifier);
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module DFFSNRNX1 (Q, QN, CLK, D, RN, SN);
	output Q, QN;
	input CLK, D, RN, SN;

	// Function
	wire RN__bar, SN__bar;

	not (SN__bar, SN);
	or (Q, RN, SN__bar);
	not (RN__bar, RN);
	or (QN, RN__bar, SN);

	// Timing
	wire delayed_RN, delayed_SN;
	reg notifier;

	// Additional timing wires
	wire adacond0, adacond1, adacond2;
	wire adacond3, adacond4, adacond5;
	wire adacond6, adacond7, adacond8;
	wire adacond9, adacond10, adacond11;
	wire CLK__bar, D__bar;


	// Additional timing gates
	and (adacond4, CLK, D, SN);
	not (D__bar, D);
	and (adacond5, CLK, D__bar, SN);
	not (CLK__bar, CLK);
	and (adacond6, CLK__bar, D, SN);
	and (adacond7, CLK__bar, D__bar, SN);
	and (adacond0, CLK, D);
	and (adacond1, CLK, D__bar);
	and (adacond2, CLK__bar, D);
	and (adacond3, CLK__bar, D__bar);
	and (adacond8, CLK, D, RN);
	and (adacond9, CLK, D__bar, RN);
	and (adacond10, CLK__bar, D, RN);
	and (adacond11, CLK__bar, D__bar, RN);

	specify
		(CLK => Q) = 0;
		if ((CLK & D & SN))
			(negedge RN => (Q+:1'b0)) = 0;
		if ((CLK & ~D & SN))
			(negedge RN => (Q+:1'b0)) = 0;
		if ((~CLK & D & SN))
			(negedge RN => (Q+:1'b0)) = 0;
		if ((~CLK & ~D & SN))
			(negedge RN => (Q+:1'b0)) = 0;
		ifnone (negedge RN => (Q+:1'b0)) = 0;
		if ((CLK & D & RN))
			(negedge SN => (Q-:1'b1)) = 0;
		if ((CLK & ~D & RN))
			(negedge SN => (Q-:1'b1)) = 0;
		if ((~CLK & D & RN))
			(negedge SN => (Q-:1'b1)) = 0;
		if ((~CLK & ~D & RN))
			(negedge SN => (Q-:1'b1)) = 0;
		if ((CLK & ~RN))
			(SN => Q) = 0;
		if ((~CLK & ~RN))
			(SN => Q) = 0;
		ifnone (SN => Q) = 0;
		(CLK => QN) = 0;
		if ((CLK & D & SN))
			(negedge RN => (QN-:1'b1)) = 0;
		if ((CLK & ~D & SN))
			(negedge RN => (QN-:1'b1)) = 0;
		if ((~CLK & D & SN))
			(negedge RN => (QN-:1'b1)) = 0;
		if ((~CLK & ~D & SN))
			(negedge RN => (QN-:1'b1)) = 0;
		if ((CLK & D & ~SN))
			(RN => QN) = 0;
		if ((CLK & ~D & ~SN))
			(RN => QN) = 0;
		if ((~CLK & D & ~SN))
			(RN => QN) = 0;
		if ((~CLK & ~D & ~SN))
			(RN => QN) = 0;
		ifnone (RN => QN) = 0;
		if ((CLK & D & RN))
			(negedge SN => (QN+:1'b0)) = 0;
		if ((CLK & ~D & RN))
			(negedge SN => (QN+:1'b0)) = 0;
		if ((~CLK & D & RN))
			(negedge SN => (QN+:1'b0)) = 0;
		if ((~CLK & ~D & RN))
			(negedge SN => (QN+:1'b0)) = 0;
		ifnone (negedge SN => (QN+:1'b0)) = 0;
		$setuphold (posedge SN &&& adacond0, posedge RN &&& adacond0, 0, 0, notifier,,, delayed_SN, delayed_RN);
		$setuphold (posedge SN &&& adacond1, posedge RN &&& adacond1, 0, 0, notifier,,, delayed_SN, delayed_RN);
		$setuphold (posedge SN &&& adacond2, posedge RN &&& adacond2, 0, 0, notifier,,, delayed_SN, delayed_RN);
		$setuphold (posedge SN &&& adacond3, posedge RN &&& adacond3, 0, 0, notifier,,, delayed_SN, delayed_RN);
		$setuphold (posedge SN, posedge RN, 0, 0, notifier,,, delayed_SN, delayed_RN);
		$setuphold (posedge RN &&& CLK, posedge SN &&& CLK, 0, 0, notifier,,, delayed_RN, delayed_SN);
		$setuphold (posedge RN &&& adacond2, posedge SN &&& adacond2, 0, 0, notifier,,, delayed_RN, delayed_SN);
		$setuphold (posedge RN &&& adacond3, posedge SN &&& adacond3, 0, 0, notifier,,, delayed_RN, delayed_SN);
		$setuphold (posedge RN, posedge SN, 0, 0, notifier,,, delayed_RN, delayed_SN);
		$width (negedge RN &&& adacond4, 0, 0, notifier);
		$width (negedge RN &&& adacond5, 0, 0, notifier);
		$width (negedge RN &&& adacond6, 0, 0, notifier);
		$width (negedge RN &&& adacond7, 0, 0, notifier);
		$width (negedge SN &&& adacond8, 0, 0, notifier);
		$width (negedge SN &&& adacond9, 0, 0, notifier);
		$width (negedge SN &&& adacond10, 0, 0, notifier);
		$width (negedge SN &&& adacond11, 0, 0, notifier);
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module DFFX1 (Q, QN, CLK, D);
	output Q, QN;
	input CLK, D;

	// Function
	buf (Q, 1'b1);
	buf (QN, 1'b1);

	// Timing
	specify
		(CLK => Q) = 0;
		(CLK => QN) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module DLATCH (Q, D, GATE);
	output Q;
	input D, GATE;

	// Function
	wire GATE__bar;

	not (GATE__bar, GATE);
	or (Q, D, GATE__bar);

	// Timing
	specify
		(D => Q) = 0;
		(GATE => Q) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module DLATCHN (Q, D, GATE_N);
	output Q;
	input D, GATE_N;

	// Function
	or (Q, D, GATE_N);

	// Timing
	specify
		(D => Q) = 0;
		(GATE_N => Q) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module INVX1 (Y);
	output Y;
	// Missing function for pin Y
	// Timing
	specify
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module MUX2X1 (Y, A0, A1, S);
	output Y;
	input A0, A1, S;

	// Function
	wire int_fwire_0, int_fwire_1, S__bar;

	not (S__bar, S);
	and (int_fwire_0, A1, S__bar);
	and (int_fwire_1, A0, S);
	or (Y, int_fwire_1, int_fwire_0);

	// Timing
	specify
		(A0 => Y) = 0;
		(A1 => Y) = 0;
		if ((A0 & ~A1))
			(S => Y) = 0;
		if ((~A0 & A1))
			(S => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module NAND2X1 (Y, B);
	output Y;
	input B;

	// Function
	not (Y, B);

	// Timing
	specify
		ifnone (negedge B => (Y+:1'b1)) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module NAND3X1 (Y, B, C);
	output Y;
	input B, C;

	// Function
	wire B__bar, C__bar;

	not (C__bar, C);
	not (B__bar, B);
	or (Y, B__bar, C__bar);

	// Timing
	specify
		ifnone (negedge B => (Y+:1'b1)) = 0;
		ifnone (negedge C => (Y+:1'b1)) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module NOR2X1 (Y, B);
	output Y;
	input B;

	// Function
	not (Y, B);

	// Timing
	specify
		ifnone (posedge B => (Y-:1'b0)) = 0;
		(negedge B => (Y:!B)) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module NOR3X1 ();
	// Timing
	specify
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module OR2X1 (Y, B);
	output Y;
	input B;

	// Function
	buf (Y, B);

	// Timing
	specify
		ifnone (posedge B => (Y+:1'b1)) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module OR3X1 (Y, B, C);
	output Y;
	input B, C;

	// Function
	or (Y, B, C);

	// Timing
	specify
		ifnone (posedge B => (Y+:1'b1)) = 0;
		ifnone (posedge C => (Y+:1'b1)) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module TIEHI (Y);
	output Y;

	// Function
	buf (Y, 1'b1);

	// Timing
	specify
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module TIELO (YN);
	output YN;

	// Function
	buf (YN, 1'b0);

	// Timing
	specify
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module TMRDFFQNX1 (QN, CLK, D);
	output QN;
	input CLK, D;

	// Function
	buf (QN, 1'b1);

	// Timing
	specify
		ifnone (posedge CLK => (QN+:1'b1)) = 0;
		(negedge CLK => (QN:1)) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module TMRDFFQX1 (Q, CLK, D);
	output Q;
	input CLK, D;

	// Function
	buf (Q, 1'b1);

	// Timing
	specify
		ifnone (posedge CLK => (Q-:1'b0)) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module TMRDFFSNQX1 (Q, CLK, D, SN);
	output Q;
	input CLK, D, SN;

	// Function
	buf (Q, 1'b1);

	// Timing
	reg notifier;

	// Additional timing wires
	wire adacond0, adacond1, adacond2;
	wire adacond3, CLK__bar, D__bar;


	// Additional timing gates
	and (adacond0, CLK, D);
	not (D__bar, D);
	and (adacond1, CLK, D__bar);
	not (CLK__bar, CLK);
	and (adacond2, CLK__bar, D);
	and (adacond3, CLK__bar, D__bar);

	specify
		(CLK => Q) = 0;
		if ((CLK & D))
			(negedge SN => (Q-:1'b1)) = 0;
		if ((CLK & ~D))
			(negedge SN => (Q-:1'b1)) = 0;
		if ((~CLK & D))
			(negedge SN => (Q-:1'b1)) = 0;
		if ((~CLK & ~D))
			(negedge SN => (Q-:1'b1)) = 0;
		ifnone (negedge SN => (Q-:1'b1)) = 0;
		$width (negedge SN &&& adacond0, 0, 0, notifier);
		$width (negedge SN &&& adacond1, 0, 0, notifier);
		$width (negedge SN &&& adacond2, 0, 0, notifier);
		$width (negedge SN &&& adacond3, 0, 0, notifier);
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module VOTER3X1 (Y, B, C);
	output Y;
	input B, C;

	// Function
	buf (Y, B);

	// Timing
	specify
		ifnone (negedge B => (Y+:1'b0)) = 0;
	endspecify
endmodule
`endcelldefine


`ifdef _udp_def_altos_latch_
`else
`define _udp_def_altos_latch_
primitive altos_latch (q, v, clk, d);
	output q;
	reg q;
	input v, clk, d;

	table
		* ? ? : ? : x;
		? 1 0 : ? : 0;
		? 1 1 : ? : 1;
		? x 0 : 0 : -;
		? x 1 : 1 : -;
		? 0 ? : ? : -;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_dff_err_
`else
`define _udp_def_altos_dff_err_
primitive altos_dff_err (q, clk, d);
	output q;
	reg q;
	input clk, d;

	table
		(0x) ? : ? : 0;
		(1x) ? : ? : 1;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_dff_
`else
`define _udp_def_altos_dff_
primitive altos_dff (q, v, clk, d, xcr);
	output q;
	reg q;
	input v, clk, d, xcr;

	table
		*  ?   ? ? : ? : x;
		? (x1) 0 0 : ? : 0;
		? (x1) 1 0 : ? : 1;
		? (x1) 0 1 : 0 : 0;
		? (x1) 1 1 : 1 : 1;
		? (x1) ? x : ? : -;
		? (bx) 0 ? : 0 : -;
		? (bx) 1 ? : 1 : -;
		? (x0) b ? : ? : -;
		? (x0) ? x : ? : -;
		? (01) 0 ? : ? : 0;
		? (01) 1 ? : ? : 1;
		? (10) ? ? : ? : -;
		?  b   * ? : ? : -;
		?  ?   ? * : ? : -;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_dff_r_err_
`else
`define _udp_def_altos_dff_r_err_
primitive altos_dff_r_err (q, clk, d, r);
	output q;
	reg q;
	input clk, d, r;

	table
		 ?   0 (0x) : ? : -;
		 ?   0 (x0) : ? : -;
		(0x) ?  0   : ? : 0;
		(0x) 0  x   : ? : 0;
		(1x) ?  0   : ? : 1;
		(1x) 0  x   : ? : 1;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_dff_r_
`else
`define _udp_def_altos_dff_r_
primitive altos_dff_r (q, v, clk, d, r, xcr);
	output q;
	reg q;
	input v, clk, d, r, xcr;

	table
		*  ?   ?  ?   ? : ? : x;
		?  ?   ?  1   ? : ? : 0;
		?  b   ? (1?) ? : 0 : -;
		?  x   0 (1?) ? : 0 : -;
		?  ?   ? (10) ? : ? : -;
		?  ?   ? (x0) ? : ? : -;
		?  ?   ? (0x) ? : 0 : -;
		? (x1) 0  ?   0 : ? : 0;
		? (x1) 1  0   0 : ? : 1;
		? (x1) 0  ?   1 : 0 : 0;
		? (x1) 1  0   1 : 1 : 1;
		? (x1) ?  ?   x : ? : -;
		? (bx) 0  ?   ? : 0 : -;
		? (bx) 1  0   ? : 1 : -;
		? (x0) 0  ?   ? : ? : -;
		? (x0) 1  0   ? : ? : -;
		? (x0) ?  0   x : ? : -;
		? (01) 0  ?   ? : ? : 0;
		? (01) 1  0   ? : ? : 1;
		? (10) ?  ?   ? : ? : -;
		?  b   *  ?   ? : ? : -;
		?  ?   ?  ?   * : ? : -;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_dff_s_err_
`else
`define _udp_def_altos_dff_s_err_
primitive altos_dff_s_err (q, clk, d, s);
	output q;
	reg q;
	input clk, d, s;

	table
		 ?   1 (0x) : ? : -;
		 ?   1 (x0) : ? : -;
		(0x) ?  0   : ? : 0;
		(0x) 1  x   : ? : 0;
		(1x) ?  0   : ? : 1;
		(1x) 1  x   : ? : 1;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_dff_s_
`else
`define _udp_def_altos_dff_s_
primitive altos_dff_s (q, v, clk, d, s, xcr);
	output q;
	reg q;
	input v, clk, d, s, xcr;

	table
		*  ?   ?  ?   ? : ? : x;
		?  ?   ?  1   ? : ? : 1;
		?  b   ? (1?) ? : 1 : -;
		?  x   1 (1?) ? : 1 : -;
		?  ?   ? (10) ? : ? : -;
		?  ?   ? (x0) ? : ? : -;
		?  ?   ? (0x) ? : 1 : -;
		? (x1) 0  0   0 : ? : 0;
		? (x1) 1  ?   0 : ? : 1;
		? (x1) 1  ?   1 : 1 : 1;
		? (x1) 0  0   1 : 0 : 0;
		? (x1) ?  ?   x : ? : -;
		? (bx) 1  ?   ? : 1 : -;
		? (bx) 0  0   ? : 0 : -;
		? (x0) 1  ?   ? : ? : -;
		? (x0) 0  0   ? : ? : -;
		? (x0) ?  0   x : ? : -;
		? (01) 1  ?   ? : ? : 1;
		? (01) 0  0   ? : ? : 0;
		? (10) ?  ?   ? : ? : -;
		?  b   *  ?   ? : ? : -;
		?  ?   ?  ?   * : ? : -;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_dff_sr_err_
`else
`define _udp_def_altos_dff_sr_err_
primitive altos_dff_sr_err (q, clk, d, s, r);
	output q;
	reg q;
	input clk, d, s, r;

	table
		 ?   1 (0x)  ?   : ? : -;
		 ?   0  ?   (0x) : ? : -;
		 ?   0  ?   (x0) : ? : -;
		(0x) ?  0    0   : ? : 0;
		(0x) 1  x    0   : ? : 0;
		(0x) 0  0    x   : ? : 0;
		(1x) ?  0    0   : ? : 1;
		(1x) 1  x    0   : ? : 1;
		(1x) 0  0    x   : ? : 1;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_dff_sr_0
`else
`define _udp_def_altos_dff_sr_0
primitive altos_dff_sr_0 (q, v, clk, d, s, r, xcr);
	output q;
	reg q;
	input v, clk, d, s, r, xcr;

	table
	//	v,  clk, d, s, r : q' : q;

		*  ?   ?   ?   ?   ? : ? : x;
		?  ?   ?   ?   1   ? : ? : 0;
		?  ?   ?   1   0   ? : ? : 1;
		?  b   ? (1?)  0   ? : 1 : -;
		?  x   1 (1?)  0   ? : 1 : -;
		?  ?   ? (10)  0   ? : ? : -;
		?  ?   ? (x0)  0   ? : ? : -;
		?  ?   ? (0x)  0   ? : 1 : -;
		?  b   ?  0   (1?) ? : 0 : -;
		?  x   0  0   (1?) ? : 0 : -;
		?  ?   ?  0   (10) ? : ? : -;
		?  ?   ?  0   (x0) ? : ? : -;
		?  ?   ?  0   (0x) ? : 0 : -;
		? (x1) 0  0    ?   0 : ? : 0;
		? (x1) 1  ?    0   0 : ? : 1;
		? (x1) 0  0    ?   1 : 0 : 0;
		? (x1) 1  ?    0   1 : 1 : 1;
		? (x1) ?  ?    0   x : ? : -;
		? (x1) ?  0    ?   x : ? : -;
		? (1x) 0  0    ?   ? : 0 : -;
		? (1x) 1  ?    0   ? : 1 : -;
		? (x0) 0  0    ?   ? : ? : -;
		? (x0) 1  ?    0   ? : ? : -;
		? (x0) ?  0    0   x : ? : -;
		? (0x) 0  0    ?   ? : 0 : -;
		? (0x) 1  ?    0   ? : 1 : -;
		? (01) 0  0    ?   ? : ? : 0;
		? (01) 1  ?    0   ? : ? : 1;
		? (10) ?  0    ?   ? : ? : -;
		? (10) ?  ?    0   ? : ? : -;
		?  b   *  0    ?   ? : ? : -;
		?  b   *  ?    0   ? : ? : -;
		?  ?   ?  ?    ?   * : ? : -;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_dff_sr_1
`else
`define _udp_def_altos_dff_sr_1
primitive altos_dff_sr_1 (q, v, clk, d, s, r, xcr);
	output q;
	reg q;
	input v, clk, d, s, r, xcr;

	table
	//	v,  clk, d, s, r : q' : q;

		*  ?   ?   ?   ?   ? : ? : x;
		?  ?   ?   0   1   ? : ? : 0;
		?  ?   ?   1   ?   ? : ? : 1;
		?  b   ? (1?)  0   ? : 1 : -;
		?  x   1 (1?)  0   ? : 1 : -;
		?  ?   ? (10)  0   ? : ? : -;
		?  ?   ? (x0)  0   ? : ? : -;
		?  ?   ? (0x)  0   ? : 1 : -;
		?  b   ?  0   (1?) ? : 0 : -;
		?  x   0  0   (1?) ? : 0 : -;
		?  ?   ?  0   (10) ? : ? : -;
		?  ?   ?  0   (x0) ? : ? : -;
		?  ?   ?  0   (0x) ? : 0 : -;
		? (x1) 0  0    ?   0 : ? : 0;
		? (x1) 1  ?    0   0 : ? : 1;
		? (x1) 0  0    ?   1 : 0 : 0;
		? (x1) 1  ?    0   1 : 1 : 1;
		? (x1) ?  ?    0   x : ? : -;
		? (x1) ?  0    ?   x : ? : -;
		? (1x) 0  0    ?   ? : 0 : -;
		? (1x) 1  ?    0   ? : 1 : -;
		? (x0) 0  0    ?   ? : ? : -;
		? (x0) 1  ?    0   ? : ? : -;
		? (x0) ?  0    0   x : ? : -;
		? (0x) 0  0    ?   ? : 0 : -;
		? (0x) 1  ?    0   ? : 1 : -;
		? (01) 0  0    ?   ? : ? : 0;
		? (01) 1  ?    0   ? : ? : 1;
		? (10) ?  0    ?   ? : ? : -;
		? (10) ?  ?    0   ? : ? : -;
		?  b   *  0    ?   ? : ? : -;
		?  b   *  ?    0   ? : ? : -;
		?  ?   ?  ?    ?   * : ? : -;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_latch_r_
`else
`define _udp_def_altos_latch_r_
primitive altos_latch_r (q, v, clk, d, r);
	output q;
	reg q;
	input v, clk, d, r;

	table
		* ? ? ? : ? : x;
		? ? ? 1 : ? : 0;
		? 0 ? 0 : ? : -;
		? 0 ? x : 0 : -;
		? 1 0 0 : ? : 0;
		? 1 0 x : ? : 0;
		? 1 1 0 : ? : 1;
		? x 0 0 : 0 : -;
		? x 0 x : 0 : -;
		? x 1 0 : 1 : -;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_latch_s_
`else
`define _udp_def_altos_latch_s_
primitive altos_latch_s (q, v, clk, d, s);
	output q;
	reg q;
	input v, clk, d, s;

	table
		* ? ? ? : ? : x;
		? ? ? 1 : ? : 1;
		? 0 ? 0 : ? : -;
		? 0 ? x : 1 : -;
		? 1 1 0 : ? : 1;
		? 1 1 x : ? : 1;
		? 1 0 0 : ? : 0;
		? x 1 0 : 1 : -;
		? x 1 x : 1 : -;
		? x 0 0 : 0 : -;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_latch_sr_0
`else
`define _udp_def_altos_latch_sr_0
primitive altos_latch_sr_0 (q, v, clk, d, s, r);
	output q;
	reg q;
	input v, clk, d, s, r;

	table
		* ? ? ? ? : ? : x;
		? 1 1 ? 0 : ? : 1;
		? 1 0 0 ? : ? : 0;
		? ? ? 1 0 : ? : 1;
		? ? ? ? 1 : ? : 0;
		? 0 * ? ? : ? : -;
		? 0 ? * 0 : 1 : 1;
		? 0 ? 0 * : 0 : 0;
		? * 1 ? 0 : 1 : 1;
		? * 0 0 ? : 0 : 0;
		? ? 1 * 0 : 1 : 1;
		? ? 0 0 * : 0 : 0;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_latch_sr_1
`else
`define _udp_def_altos_latch_sr_1
primitive altos_latch_sr_1 (q, v, clk, d, s, r);
	output q;
	reg q;
	input v, clk, d, s, r;

	table
		* ? ? ? ? : ? : x;
		? 1 1 ? 0 : ? : 1;
		? 1 0 0 ? : ? : 0;
		? ? ? 1 ? : ? : 1;
		? ? ? 0 1 : ? : 0;
		? 0 * ? ? : ? : -;
		? 0 ? * 0 : 1 : 1;
		? 0 ? 0 * : 0 : 0;
		? * 1 ? 0 : 1 : 1;
		? * 0 0 ? : 0 : 0;
		? ? 1 * 0 : 1 : 1;
		? ? 0 0 * : 0 : 0;
	endtable
endprimitive
`endif
