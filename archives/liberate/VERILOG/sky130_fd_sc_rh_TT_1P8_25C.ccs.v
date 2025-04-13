// Verilog for library /home/rjridle/sky130RHBDlib/char/liberate/VERILOG/sky130_fd_sc_rh_TT_1P8_25C.ccs created by Liberate 19.2.1.591 on Tue Dec  6 19:27:13 CST 2022 for SDF version 2.1

// type:  
`timescale 1ns/10ps
`celldefine
module AND3X1 (Y, A, B, C);
	output Y;
	input A, B, C;

	// Function
	and (Y, A, B, C);

	// Timing
	specify
		(A => Y) = 0;
		(B => Y) = 0;
		(C => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module AO3X1 (Y, A, B, C);
	output Y;
	input A, B, C;

	// Function
	wire A__bar, B__bar;

	not (B__bar, B);
	not (A__bar, A);
	or (Y, A__bar, B__bar, C);

	// Timing
	specify
		(A => Y) = 0;
		(B => Y) = 0;
		(C => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module AOA4X1 (Y, A, B, C, D);
	output Y;
	input A, B, C, D;

	// Function
	wire C__bar;

	not (C__bar, C);
	and (Y, A, B, C__bar, D);

	// Timing
	specify
		(A => Y) = 0;
		(B => Y) = 0;
		(C => Y) = 0;
		(D => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module AOAI4X1 (YN, A, B, C, D);
	output YN;
	input A, B, C, D;

	// Function
	wire A__bar, B__bar, D__bar;

	not (D__bar, D);
	not (B__bar, B);
	not (A__bar, A);
	or (YN, A__bar, B__bar, C, D__bar);

	// Timing
	specify
		(A => YN) = 0;
		(B => YN) = 0;
		(C => YN) = 0;
		(D => YN) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module AOI3X1 (YN, A, B, C);
	output YN;
	input A, B, C;

	// Function
	wire C__bar;

	not (C__bar, C);
	and (YN, A, B, C__bar);

	// Timing
	specify
		(A => YN) = 0;
		(B => YN) = 0;
		(C => YN) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module BUFX1 (Y, A);
	output Y;
	input A;

	// Function
	buf (Y, A);

	// Timing
	specify
		(A => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module DFFQNX1 (QN, D, CLK);
	output QN;
	input D, CLK;
	reg notifier;
	wire delayed_D, delayed_CLK;

	// Function
	wire int_fwire_d, int_fwire_IQN, xcr_0;

	not (int_fwire_d, delayed_D);
	altos_dff_err (xcr_0, delayed_CLK, int_fwire_d);
	altos_dff (int_fwire_IQN, notifier, delayed_CLK, int_fwire_d, xcr_0);
	buf (QN, int_fwire_IQN);

	// Timing
	specify
		(posedge CLK => (QN+:!D)) = 0;
		$setuphold (posedge CLK, posedge D, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$setuphold (posedge CLK, negedge D, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$width (posedge CLK &&& D, 0, 0, notifier);
		$width (negedge CLK &&& D, 0, 0, notifier);
		$width (posedge CLK &&& ~D, 0, 0, notifier);
		$width (negedge CLK &&& ~D, 0, 0, notifier);
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module DFFQX1 (Q, D, CLK);
	output Q;
	input D, CLK;
	reg notifier;
	wire delayed_D, delayed_CLK;

	// Function
	wire int_fwire_IQ, xcr_0;

	altos_dff_err (xcr_0, delayed_CLK, delayed_D);
	altos_dff (int_fwire_IQ, notifier, delayed_CLK, delayed_D, xcr_0);
	buf (Q, int_fwire_IQ);

	// Timing
	specify
		(posedge CLK => (Q+:D)) = 0;
		$setuphold (posedge CLK, posedge D, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$setuphold (posedge CLK, negedge D, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$width (posedge CLK &&& D, 0, 0, notifier);
		$width (negedge CLK &&& D, 0, 0, notifier);
		$width (posedge CLK &&& ~D, 0, 0, notifier);
		$width (negedge CLK &&& ~D, 0, 0, notifier);
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module DFFRNQX1 (Q, D, RN, CLK);
	output Q;
	input D, RN, CLK;
	reg notifier;
	wire delayed_D, delayed_CLK;

	// Function
	wire int_fwire_IQ, int_fwire_r, xcr_0;

	not (int_fwire_r, RN);
	altos_dff_r_err (xcr_0, delayed_CLK, delayed_D, int_fwire_r);
	altos_dff_r (int_fwire_IQ, notifier, delayed_CLK, delayed_D, int_fwire_r, xcr_0);
	buf (Q, int_fwire_IQ);

	// Timing

	// Additional timing wires
	wire adacond0, adacond1, adacond2;
	wire adacond3, adacond4, adacond5;
	wire CLK__bar, D__bar;


	// Additional timing gates
	and (adacond0, CLK, D);
	not (D__bar, D);
	and (adacond1, CLK, D__bar);
	not (CLK__bar, CLK);
	and (adacond2, CLK__bar, D);
	and (adacond3, CLK__bar, D__bar);
	and (adacond4, D, RN);
	and (adacond5, D__bar, RN);

	specify
		if ((CLK & D))
			(negedge RN => (Q+:1'b0)) = 0;
		if ((CLK & ~D))
			(negedge RN => (Q+:1'b0)) = 0;
		if ((~CLK & D))
			(negedge RN => (Q+:1'b0)) = 0;
		if ((~CLK & ~D))
			(negedge RN => (Q+:1'b0)) = 0;
		ifnone (negedge RN => (Q+:1'b0)) = 0;
		(posedge CLK => (Q+:D)) = 0;
		$setuphold (posedge CLK &&& RN, posedge D &&& RN, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$setuphold (posedge CLK &&& RN, negedge D &&& RN, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$setuphold (posedge CLK, posedge D, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$setuphold (posedge CLK, negedge D, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$recovery (posedge RN &&& D, posedge CLK &&& D, 0, notifier);
		$recovery (posedge RN, posedge CLK, 0, notifier);
		$hold (posedge CLK &&& D, posedge RN &&& D, 0, notifier);
		$hold (posedge CLK, posedge RN, 0, notifier);
		$width (negedge RN &&& adacond0, 0, 0, notifier);
		$width (negedge RN &&& adacond1, 0, 0, notifier);
		$width (negedge RN &&& adacond2, 0, 0, notifier);
		$width (negedge RN &&& adacond3, 0, 0, notifier);
		$width (posedge CLK &&& adacond4, 0, 0, notifier);
		$width (negedge CLK &&& adacond4, 0, 0, notifier);
		$width (posedge CLK &&& adacond5, 0, 0, notifier);
		$width (negedge CLK &&& adacond5, 0, 0, notifier);
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module DFFSNQNX1 (QN, D, SN, CLK);
	output QN;
	input D, SN, CLK;
	reg notifier;
	wire delayed_D, delayed_CLK;

	// Function
	wire int_fwire_d, int_fwire_IQN, int_fwire_r;
	wire xcr_0;

	not (int_fwire_d, delayed_D);
	not (int_fwire_r, SN);
	altos_dff_r_err (xcr_0, delayed_CLK, int_fwire_d, int_fwire_r);
	altos_dff_r (int_fwire_IQN, notifier, delayed_CLK, int_fwire_d, int_fwire_r, xcr_0);
	buf (QN, int_fwire_IQN);

	// Timing

	// Additional timing wires
	wire adacond0, adacond1, adacond2;
	wire adacond3, adacond4, adacond5;
	wire CLK__bar, D__bar;


	// Additional timing gates
	and (adacond0, CLK, D);
	not (D__bar, D);
	and (adacond1, CLK, D__bar);
	not (CLK__bar, CLK);
	and (adacond2, CLK__bar, D);
	and (adacond3, CLK__bar, D__bar);
	and (adacond4, D, SN);
	and (adacond5, D__bar, SN);

	specify
		if ((CLK & D))
			(negedge SN => (QN+:1'b0)) = 0;
		if ((CLK & ~D))
			(negedge SN => (QN+:1'b0)) = 0;
		if ((~CLK & D))
			(negedge SN => (QN+:1'b0)) = 0;
		if ((~CLK & ~D))
			(negedge SN => (QN+:1'b0)) = 0;
		ifnone (negedge SN => (QN+:1'b0)) = 0;
		(posedge CLK => (QN+:!D)) = 0;
		$setuphold (posedge CLK &&& SN, posedge D &&& SN, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$setuphold (posedge CLK &&& SN, negedge D &&& SN, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$setuphold (posedge CLK, posedge D, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$setuphold (posedge CLK, negedge D, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$recovery (posedge SN &&& ~D, posedge CLK &&& ~D, 0, notifier);
		$recovery (posedge SN, posedge CLK, 0, notifier);
		$hold (posedge CLK &&& ~D, posedge SN &&& ~D, 0, notifier);
		$hold (posedge CLK, posedge SN, 0, notifier);
		$width (negedge SN &&& adacond0, 0, 0, notifier);
		$width (negedge SN &&& adacond1, 0, 0, notifier);
		$width (negedge SN &&& adacond2, 0, 0, notifier);
		$width (negedge SN &&& adacond3, 0, 0, notifier);
		$width (posedge CLK &&& adacond4, 0, 0, notifier);
		$width (negedge CLK &&& adacond4, 0, 0, notifier);
		$width (posedge CLK &&& adacond5, 0, 0, notifier);
		$width (negedge CLK &&& adacond5, 0, 0, notifier);
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module DFFSNQX1 (Q, D, SN, CLK);
	output Q;
	input D, SN, CLK;
	reg notifier;
	wire delayed_D, delayed_CLK;

	// Function
	wire int_fwire_IQ, int_fwire_s, xcr_0;

	not (int_fwire_s, SN);
	altos_dff_s_err (xcr_0, delayed_CLK, delayed_D, int_fwire_s);
	altos_dff_s (int_fwire_IQ, notifier, delayed_CLK, delayed_D, int_fwire_s, xcr_0);
	buf (Q, int_fwire_IQ);

	// Timing

	// Additional timing wires
	wire adacond0, adacond1, adacond2;
	wire adacond3, adacond4, adacond5;
	wire CLK__bar, D__bar;


	// Additional timing gates
	and (adacond0, CLK, D);
	not (D__bar, D);
	and (adacond1, CLK, D__bar);
	not (CLK__bar, CLK);
	and (adacond2, CLK__bar, D);
	and (adacond3, CLK__bar, D__bar);
	and (adacond4, D, SN);
	and (adacond5, D__bar, SN);

	specify
		if ((CLK & D))
			(negedge SN => (Q+:1'b1)) = 0;
		if ((CLK & ~D))
			(negedge SN => (Q+:1'b1)) = 0;
		if ((~CLK & D))
			(negedge SN => (Q+:1'b1)) = 0;
		if ((~CLK & ~D))
			(negedge SN => (Q+:1'b1)) = 0;
		ifnone (negedge SN => (Q+:1'b1)) = 0;
		(posedge CLK => (Q+:D)) = 0;
		$setuphold (posedge CLK &&& SN, posedge D &&& SN, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$setuphold (posedge CLK &&& SN, negedge D &&& SN, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$setuphold (posedge CLK, posedge D, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$setuphold (posedge CLK, negedge D, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$recovery (posedge SN &&& ~D, posedge CLK &&& ~D, 0, notifier);
		$recovery (posedge SN, posedge CLK, 0, notifier);
		$hold (posedge CLK &&& ~D, posedge SN &&& ~D, 0, notifier);
		$hold (posedge CLK, posedge SN, 0, notifier);
		$width (negedge SN &&& adacond0, 0, 0, notifier);
		$width (negedge SN &&& adacond1, 0, 0, notifier);
		$width (negedge SN &&& adacond2, 0, 0, notifier);
		$width (negedge SN &&& adacond3, 0, 0, notifier);
		$width (posedge CLK &&& adacond4, 0, 0, notifier);
		$width (negedge CLK &&& adacond4, 0, 0, notifier);
		$width (posedge CLK &&& adacond5, 0, 0, notifier);
		$width (negedge CLK &&& adacond5, 0, 0, notifier);
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module DFFSNRNQNX1 (QN, D, RN, SN, CLK);
	output QN;
	input D, RN, SN, CLK;
	reg notifier;
	wire delayed_D, delayed_RN, delayed_SN, delayed_CLK;

	// Function
	wire int_fwire_d, int_fwire_IQN, int_fwire_r;
	wire int_fwire_s, xcr_0;

	not (int_fwire_d, delayed_D);
	not (int_fwire_s, delayed_RN);
	not (int_fwire_r, delayed_SN);
	altos_dff_sr_err (xcr_0, delayed_CLK, int_fwire_d, int_fwire_s, int_fwire_r);
	altos_dff_sr_1 (int_fwire_IQN, notifier, delayed_CLK, int_fwire_d, int_fwire_s, int_fwire_r, xcr_0);
	buf (QN, int_fwire_IQN);

	// Timing

	// Additional timing wires
	wire adacond0, adacond1, adacond2;
	wire adacond3, adacond4, adacond5;
	wire adacond6, adacond7, adacond8;
	wire adacond9, adacond10, adacond11;
	wire adacond12, adacond13, adacond14;
	wire adacond15, adacond16, CLK__bar;
	wire D__bar;


	// Additional timing gates
	and (adacond0, RN, SN);
	and (adacond1, D, SN);
	and (adacond6, CLK, D, SN);
	not (D__bar, D);
	and (adacond7, CLK, D__bar, SN);
	not (CLK__bar, CLK);
	and (adacond8, CLK__bar, D, SN);
	and (adacond9, CLK__bar, D__bar, SN);
	and (adacond2, CLK, D);
	and (adacond3, CLK, D__bar);
	and (adacond4, CLK__bar, D);
	and (adacond5, CLK__bar, D__bar);
	and (adacond10, D__bar, RN);
	and (adacond11, CLK, D, RN);
	and (adacond12, CLK, D__bar, RN);
	and (adacond13, CLK__bar, D, RN);
	and (adacond14, CLK__bar, D__bar, RN);
	and (adacond15, D, RN, SN);
	and (adacond16, D__bar, RN, SN);

	specify
		if ((CLK & D & ~SN))
			(posedge RN => (QN+:1'b0)) = 0;
		if ((CLK & ~D & ~SN))
			(posedge RN => (QN+:1'b0)) = 0;
		if ((~CLK & D & ~SN))
			(posedge RN => (QN+:1'b0)) = 0;
		if ((~CLK & ~D & ~SN))
			(posedge RN => (QN+:1'b0)) = 0;
		ifnone (posedge RN => (QN+:1'b0)) = 0;
		if ((CLK & D & SN))
			(negedge RN => (QN+:1'b1)) = 0;
		if ((CLK & D & ~SN))
			(negedge RN => (QN+:1'b1)) = 0;
		if ((CLK & ~D & SN))
			(negedge RN => (QN+:1'b1)) = 0;
		if ((CLK & ~D & ~SN))
			(negedge RN => (QN+:1'b1)) = 0;
		if ((~CLK & D & SN))
			(negedge RN => (QN+:1'b1)) = 0;
		if ((~CLK & D & ~SN))
			(negedge RN => (QN+:1'b1)) = 0;
		if ((~CLK & ~D & SN))
			(negedge RN => (QN+:1'b1)) = 0;
		if ((~CLK & ~D & ~SN))
			(negedge RN => (QN+:1'b1)) = 0;
		ifnone (negedge RN => (QN+:1'b1)) = 0;
		if ((CLK & D & RN))
			(negedge SN => (QN+:1'b0)) = 0;
		if ((CLK & ~D & RN))
			(negedge SN => (QN+:1'b0)) = 0;
		if ((~CLK & D & RN))
			(negedge SN => (QN+:1'b0)) = 0;
		if ((~CLK & ~D & RN))
			(negedge SN => (QN+:1'b0)) = 0;
		ifnone (negedge SN => (QN+:1'b0)) = 0;
		(posedge CLK => (QN+:!D)) = 0;
		$setuphold (posedge CLK &&& adacond0, posedge D &&& adacond0, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$setuphold (posedge CLK &&& adacond0, negedge D &&& adacond0, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$setuphold (posedge CLK, posedge D, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$setuphold (posedge CLK, negedge D, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$setuphold (posedge SN &&& adacond2, posedge RN &&& adacond2, 0, 0, notifier,,, delayed_SN, delayed_RN);
		$setuphold (posedge SN &&& adacond3, posedge RN &&& adacond3, 0, 0, notifier,,, delayed_SN, delayed_RN);
		$setuphold (posedge SN &&& adacond4, posedge RN &&& adacond4, 0, 0, notifier,,, delayed_SN, delayed_RN);
		$setuphold (posedge SN &&& adacond5, posedge RN &&& adacond5, 0, 0, notifier,,, delayed_SN, delayed_RN);
		$setuphold (posedge SN, posedge RN, 0, 0, notifier,,, delayed_SN, delayed_RN);
		$setuphold (posedge RN &&& CLK, posedge SN &&& CLK, 0, 0, notifier,,, delayed_RN, delayed_SN);
		$setuphold (posedge RN &&& adacond4, posedge SN &&& adacond4, 0, 0, notifier,,, delayed_RN, delayed_SN);
		$setuphold (posedge RN &&& adacond5, posedge SN &&& adacond5, 0, 0, notifier,,, delayed_RN, delayed_SN);
		$setuphold (posedge RN, posedge SN, 0, 0, notifier,,, delayed_RN, delayed_SN);
		$recovery (posedge RN &&& adacond1, posedge CLK &&& adacond1, 0, notifier);
		$recovery (posedge RN, posedge CLK, 0, notifier);
		$hold (posedge CLK &&& adacond1, posedge RN &&& adacond1, 0, notifier);
		$hold (posedge CLK, posedge RN, 0, notifier);
		$recovery (posedge SN &&& adacond10, posedge CLK &&& adacond10, 0, notifier);
		$recovery (posedge SN, posedge CLK, 0, notifier);
		$hold (posedge CLK &&& adacond10, posedge SN &&& adacond10, 0, notifier);
		$hold (posedge CLK, posedge SN, 0, notifier);
		$width (negedge RN &&& adacond6, 0, 0, notifier);
		$width (negedge RN &&& adacond7, 0, 0, notifier);
		$width (negedge RN &&& adacond8, 0, 0, notifier);
		$width (negedge RN &&& adacond9, 0, 0, notifier);
		$width (negedge SN &&& adacond11, 0, 0, notifier);
		$width (negedge SN &&& adacond12, 0, 0, notifier);
		$width (negedge SN &&& adacond13, 0, 0, notifier);
		$width (negedge SN &&& adacond14, 0, 0, notifier);
		$width (posedge CLK &&& adacond15, 0, 0, notifier);
		$width (negedge CLK &&& adacond15, 0, 0, notifier);
		$width (posedge CLK &&& adacond16, 0, 0, notifier);
		$width (negedge CLK &&& adacond16, 0, 0, notifier);
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
module FA (COUT, SUM, A, B, CIN);
	output COUT, SUM;
	input A, B, CIN;

	// Function
	wire A__bar, B__bar, CIN__bar;
	wire int_fwire_0, int_fwire_1, int_fwire_2;
	wire int_fwire_3, int_fwire_4, int_fwire_5;
	wire int_fwire_6;

	and (int_fwire_0, B, CIN);
	and (int_fwire_1, A, CIN);
	and (int_fwire_2, A, B);
	or (COUT, int_fwire_2, int_fwire_1, int_fwire_0);
	not (B__bar, B);
	not (A__bar, A);
	and (int_fwire_3, A__bar, B__bar, CIN);
	not (CIN__bar, CIN);
	and (int_fwire_4, A__bar, B, CIN__bar);
	and (int_fwire_5, A, B__bar, CIN__bar);
	and (int_fwire_6, A, B, CIN);
	or (SUM, int_fwire_6, int_fwire_5, int_fwire_4, int_fwire_3);

	// Timing
	specify
		if ((B & ~CIN))
			(A => COUT) = 0;
		if ((~B & CIN))
			(A => COUT) = 0;
		ifnone (A => COUT) = 0;
		if ((A & ~CIN))
			(B => COUT) = 0;
		if ((~A & CIN))
			(B => COUT) = 0;
		ifnone (B => COUT) = 0;
		(CIN => COUT) = 0;
		if ((B & CIN))
			(A => SUM) = 0;
		if ((~B & ~CIN))
			(A => SUM) = 0;
		ifnone (A => SUM) = 0;
		if ((B & ~CIN))
			(A => SUM) = 0;
		if ((~B & CIN))
			(A => SUM) = 0;
		if ((A & CIN))
			(B => SUM) = 0;
		if ((~A & ~CIN))
			(B => SUM) = 0;
		ifnone (B => SUM) = 0;
		if ((A & ~CIN))
			(B => SUM) = 0;
		if ((~A & CIN))
			(B => SUM) = 0;
		if ((A & B) | (~A & ~B))
			(CIN => SUM) = 0;
		if ((A & ~B) | (~A & B))
			(CIN => SUM) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module HA (COUT, SUM, A, B);
	output COUT, SUM;
	input A, B;

	// Function
	wire A__bar, B__bar, int_fwire_0;
	wire int_fwire_1;

	and (COUT, A, B);
	not (A__bar, A);
	and (int_fwire_0, A__bar, B);
	not (B__bar, B);
	and (int_fwire_1, A, B__bar);
	or (SUM, int_fwire_1, int_fwire_0);

	// Timing
	specify
		(A => COUT) = 0;
		(B => COUT) = 0;
		if (~B)
			(A => SUM) = 0;
		if (B)
			(A => SUM) = 0;
		if (~A)
			(B => SUM) = 0;
		if (A)
			(B => SUM) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module INVX1 (Y, A);
	output Y;
	input A;

	// Function
	not (Y, A);

	// Timing
	specify
		(A => Y) = 0;
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
module NAND2X1 (Y, A, B);
	output Y;
	input A, B;

	// Function
	wire A__bar, B__bar;

	not (B__bar, B);
	not (A__bar, A);
	or (Y, A__bar, B__bar);

	// Timing
	specify
		(A => Y) = 0;
		(B => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module NAND3X1 (Y, A, B, C);
	output Y;
	input A, B, C;

	// Function
	wire A__bar, B__bar, C__bar;

	not (C__bar, C);
	not (B__bar, B);
	not (A__bar, A);
	or (Y, A__bar, B__bar, C__bar);

	// Timing
	specify
		(A => Y) = 0;
		(B => Y) = 0;
		(C => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module NOR2X1 (Y, A, B);
	output Y;
	input A, B;

	// Function
	wire A__bar, B__bar;

	not (B__bar, B);
	not (A__bar, A);
	and (Y, A__bar, B__bar);

	// Timing
	specify
		(A => Y) = 0;
		(B => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module OR2X1 (Y, A, B);
	output Y;
	input A, B;

	// Function
	or (Y, A, B);

	// Timing
	specify
		(A => Y) = 0;
		(B => Y) = 0;
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
module TMRDFFQNX1 (QN, D, CLK);
	output QN;
	input D, CLK;
	reg notifier;
	wire delayed_D, delayed_CLK;

	// Function
	wire int_fwire_d, int_fwire_IQN, xcr_0;

	not (int_fwire_d, delayed_D);
	altos_dff_err (xcr_0, delayed_CLK, int_fwire_d);
	altos_dff (int_fwire_IQN, notifier, delayed_CLK, int_fwire_d, xcr_0);
	buf (QN, int_fwire_IQN);

	// Timing
	specify
		(posedge CLK => (QN+:!D)) = 0;
		$setuphold (posedge CLK, posedge D, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$setuphold (posedge CLK, negedge D, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$width (posedge CLK &&& D, 0, 0, notifier);
		$width (negedge CLK &&& D, 0, 0, notifier);
		$width (posedge CLK &&& ~D, 0, 0, notifier);
		$width (negedge CLK &&& ~D, 0, 0, notifier);
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module TMRDFFQX1 (Q, D, CLK);
	output Q;
	input D, CLK;
	reg notifier;
	wire delayed_D, delayed_CLK;

	// Function
	wire int_fwire_IQ, xcr_0;

	altos_dff_err (xcr_0, delayed_CLK, delayed_D);
	altos_dff (int_fwire_IQ, notifier, delayed_CLK, delayed_D, xcr_0);
	buf (Q, int_fwire_IQ);

	// Timing
	specify
		(posedge CLK => (Q+:D)) = 0;
		$setuphold (posedge CLK, posedge D, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$setuphold (posedge CLK, negedge D, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$width (posedge CLK &&& D, 0, 0, notifier);
		$width (negedge CLK &&& D, 0, 0, notifier);
		$width (posedge CLK &&& ~D, 0, 0, notifier);
		$width (negedge CLK &&& ~D, 0, 0, notifier);
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module TMRDFFRNQNX1 (QN, D, RN, CLK);
	output QN;
	input D, RN, CLK;
	reg notifier;
	// Missing function for pin QN
	// Timing

	// Additional timing wires
	wire adacond0, D__bar;


	// Additional timing gates
	not (D__bar, D);
	and (adacond0, D__bar, RN);

	specify
		(negedge CLK => (QN-:CLK)) = 0;
		$width (negedge CLK &&& adacond0, 0, 0, notifier);
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module TMRDFFRNQX1 (Q, D, RN, CLK);
	output Q;
	input D, RN, CLK;
	reg notifier;
	// Missing function for pin Q
	// Timing

	// Additional timing wires
	wire adacond0, D__bar;


	// Additional timing gates
	not (D__bar, D);
	and (adacond0, D__bar, RN);

	specify
		(negedge CLK => (Q+:CLK)) = 0;
		$width (negedge CLK &&& adacond0, 0, 0, notifier);
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module TMRDFFSNQX1 (Q, D, SN, CLK);
	output Q;
	input D, SN, CLK;
	reg notifier;
	wire delayed_D, delayed_CLK;

	// Function
	wire int_fwire_IQ, int_fwire_s, xcr_0;

	not (int_fwire_s, SN);
	altos_dff_s_err (xcr_0, delayed_CLK, delayed_D, int_fwire_s);
	altos_dff_s (int_fwire_IQ, notifier, delayed_CLK, delayed_D, int_fwire_s, xcr_0);
	buf (Q, int_fwire_IQ);

	// Timing

	// Additional timing wires
	wire adacond0, adacond1, adacond2;
	wire adacond3, adacond4, adacond5;
	wire CLK__bar, D__bar;


	// Additional timing gates
	and (adacond0, CLK, D);
	not (D__bar, D);
	and (adacond1, CLK, D__bar);
	not (CLK__bar, CLK);
	and (adacond2, CLK__bar, D);
	and (adacond3, CLK__bar, D__bar);
	and (adacond4, D, SN);
	and (adacond5, D__bar, SN);

	specify
		if ((CLK & D))
			(negedge SN => (Q+:1'b1)) = 0;
		if ((CLK & ~D))
			(negedge SN => (Q+:1'b1)) = 0;
		if ((~CLK & D))
			(negedge SN => (Q+:1'b1)) = 0;
		if ((~CLK & ~D))
			(negedge SN => (Q+:1'b1)) = 0;
		ifnone (negedge SN => (Q+:1'b1)) = 0;
		(posedge CLK => (Q+:D)) = 0;
		$setuphold (posedge CLK &&& SN, posedge D &&& SN, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$setuphold (posedge CLK &&& SN, negedge D &&& SN, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$setuphold (posedge CLK, posedge D, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$setuphold (posedge CLK, negedge D, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$recovery (posedge SN &&& ~D, posedge CLK &&& ~D, 0, notifier);
		$recovery (posedge SN, posedge CLK, 0, notifier);
		$hold (posedge CLK &&& ~D, posedge SN &&& ~D, 0, notifier);
		$hold (posedge CLK, posedge SN, 0, notifier);
		$width (negedge SN &&& adacond0, 0, 0, notifier);
		$width (negedge SN &&& adacond1, 0, 0, notifier);
		$width (negedge SN &&& adacond2, 0, 0, notifier);
		$width (negedge SN &&& adacond3, 0, 0, notifier);
		$width (posedge CLK &&& adacond4, 0, 0, notifier);
		$width (negedge CLK &&& adacond4, 0, 0, notifier);
		$width (posedge CLK &&& adacond5, 0, 0, notifier);
		$width (negedge CLK &&& adacond5, 0, 0, notifier);
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module TMRDFFSNRNQNX1 (Q, D, RN, SN, CLK);
	output Q;
	input D, RN, SN, CLK;
	reg notifier;
	wire delayed_D, delayed_RN, delayed_SN, delayed_CLK;

	// Function
	wire int_fwire_IQ, int_fwire_r, int_fwire_s;
	wire xcr_0;

	not (int_fwire_s, delayed_SN);
	not (int_fwire_r, delayed_RN);
	altos_dff_sr_err (xcr_0, delayed_CLK, delayed_D, int_fwire_s, int_fwire_r);
	altos_dff_sr_0 (int_fwire_IQ, notifier, delayed_CLK, delayed_D, int_fwire_s, int_fwire_r, xcr_0);
	buf (Q, int_fwire_IQ);

	// Timing

	// Additional timing wires
	wire adacond0, adacond1, adacond2;
	wire adacond3, adacond4, adacond5;
	wire adacond6, adacond7, adacond8;
	wire adacond9, adacond10, adacond11;
	wire adacond12, adacond13, adacond14;
	wire adacond15, adacond16, CLK__bar;
	wire D__bar;


	// Additional timing gates
	and (adacond0, RN, SN);
	and (adacond1, D, SN);
	and (adacond6, CLK, D, SN);
	not (D__bar, D);
	and (adacond7, CLK, D__bar, SN);
	not (CLK__bar, CLK);
	and (adacond8, CLK__bar, D, SN);
	and (adacond9, CLK__bar, D__bar, SN);
	and (adacond2, CLK, D);
	and (adacond3, CLK, D__bar);
	and (adacond4, CLK__bar, D);
	and (adacond5, CLK__bar, D__bar);
	and (adacond10, D__bar, RN);
	and (adacond11, CLK, D, RN);
	and (adacond12, CLK, D__bar, RN);
	and (adacond13, CLK__bar, D, RN);
	and (adacond14, CLK__bar, D__bar, RN);
	and (adacond15, D, RN, SN);
	and (adacond16, D__bar, RN, SN);

	specify
		if ((CLK & D & SN))
			(negedge RN => (Q+:1'b0)) = 0;
		if ((CLK & D & ~SN))
			(negedge RN => (Q+:1'b0)) = 0;
		if ((CLK & ~D & SN))
			(negedge RN => (Q+:1'b0)) = 0;
		if ((CLK & ~D & ~SN))
			(negedge RN => (Q+:1'b0)) = 0;
		if ((~CLK & D & SN))
			(negedge RN => (Q+:1'b0)) = 0;
		if ((~CLK & D & ~SN))
			(negedge RN => (Q+:1'b0)) = 0;
		if ((~CLK & ~D & SN))
			(negedge RN => (Q+:1'b0)) = 0;
		if ((~CLK & ~D & ~SN))
			(negedge RN => (Q+:1'b0)) = 0;
		ifnone (negedge RN => (Q+:1'b0)) = 0;
		if ((CLK & D & ~SN))
			(posedge RN => (Q+:1'b1)) = 0;
		if ((CLK & ~D & ~SN))
			(posedge RN => (Q+:1'b1)) = 0;
		if ((~CLK & D & ~SN))
			(posedge RN => (Q+:1'b1)) = 0;
		if ((~CLK & ~D & ~SN))
			(posedge RN => (Q+:1'b1)) = 0;
		ifnone (posedge RN => (Q+:1'b1)) = 0;
		if ((CLK & D & RN))
			(negedge SN => (Q+:1'b1)) = 0;
		if ((CLK & ~D & RN))
			(negedge SN => (Q+:1'b1)) = 0;
		if ((~CLK & D & RN))
			(negedge SN => (Q+:1'b1)) = 0;
		if ((~CLK & ~D & RN))
			(negedge SN => (Q+:1'b1)) = 0;
		ifnone (negedge SN => (Q+:1'b1)) = 0;
		(posedge CLK => (Q+:D)) = 0;
		$setuphold (posedge CLK &&& adacond0, posedge D &&& adacond0, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$setuphold (posedge CLK &&& adacond0, negedge D &&& adacond0, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$setuphold (posedge CLK, posedge D, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$setuphold (posedge CLK, negedge D, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$setuphold (posedge SN &&& adacond2, posedge RN &&& adacond2, 0, 0, notifier,,, delayed_SN, delayed_RN);
		$setuphold (posedge SN &&& adacond3, posedge RN &&& adacond3, 0, 0, notifier,,, delayed_SN, delayed_RN);
		$setuphold (posedge SN &&& adacond4, posedge RN &&& adacond4, 0, 0, notifier,,, delayed_SN, delayed_RN);
		$setuphold (posedge SN &&& adacond5, posedge RN &&& adacond5, 0, 0, notifier,,, delayed_SN, delayed_RN);
		$setuphold (posedge SN, posedge RN, 0, 0, notifier,,, delayed_SN, delayed_RN);
		$setuphold (posedge RN &&& CLK, posedge SN &&& CLK, 0, 0, notifier,,, delayed_RN, delayed_SN);
		$setuphold (posedge RN &&& adacond4, posedge SN &&& adacond4, 0, 0, notifier,,, delayed_RN, delayed_SN);
		$setuphold (posedge RN &&& adacond5, posedge SN &&& adacond5, 0, 0, notifier,,, delayed_RN, delayed_SN);
		$setuphold (posedge RN, posedge SN, 0, 0, notifier,,, delayed_RN, delayed_SN);
		$recovery (posedge RN &&& adacond1, posedge CLK &&& adacond1, 0, notifier);
		$recovery (posedge RN, posedge CLK, 0, notifier);
		$hold (posedge CLK &&& adacond1, posedge RN &&& adacond1, 0, notifier);
		$hold (posedge CLK, posedge RN, 0, notifier);
		$recovery (posedge SN &&& adacond10, posedge CLK &&& adacond10, 0, notifier);
		$recovery (posedge SN, posedge CLK, 0, notifier);
		$hold (posedge CLK &&& adacond10, posedge SN &&& adacond10, 0, notifier);
		$hold (posedge CLK, posedge SN, 0, notifier);
		$width (negedge RN &&& adacond6, 0, 0, notifier);
		$width (negedge RN &&& adacond7, 0, 0, notifier);
		$width (negedge RN &&& adacond8, 0, 0, notifier);
		$width (negedge RN &&& adacond9, 0, 0, notifier);
		$width (negedge SN &&& adacond11, 0, 0, notifier);
		$width (negedge SN &&& adacond12, 0, 0, notifier);
		$width (negedge SN &&& adacond13, 0, 0, notifier);
		$width (negedge SN &&& adacond14, 0, 0, notifier);
		$width (posedge CLK &&& adacond15, 0, 0, notifier);
		$width (negedge CLK &&& adacond15, 0, 0, notifier);
		$width (posedge CLK &&& adacond16, 0, 0, notifier);
		$width (negedge CLK &&& adacond16, 0, 0, notifier);
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module TMRDFFSNRNQX1 (Q, D, RN, SN, CLK);
	output Q;
	input D, RN, SN, CLK;
	reg notifier;
	wire delayed_D, delayed_RN, delayed_SN, delayed_CLK;

	// Function
	wire int_fwire_IQ, int_fwire_r, int_fwire_s;
	wire xcr_0;

	not (int_fwire_s, delayed_SN);
	not (int_fwire_r, delayed_RN);
	altos_dff_sr_err (xcr_0, delayed_CLK, delayed_D, int_fwire_s, int_fwire_r);
	altos_dff_sr_1 (int_fwire_IQ, notifier, delayed_CLK, delayed_D, int_fwire_s, int_fwire_r, xcr_0);
	buf (Q, int_fwire_IQ);

	// Timing

	// Additional timing wires
	wire adacond0, adacond1, adacond2;
	wire adacond3, adacond4, adacond5;
	wire adacond6, adacond7, adacond8;
	wire adacond9, adacond10, adacond11;
	wire adacond12, adacond13, adacond14;
	wire adacond15, adacond16, CLK__bar;
	wire D__bar;


	// Additional timing gates
	and (adacond0, RN, SN);
	and (adacond1, D, SN);
	and (adacond6, CLK, D, SN);
	not (D__bar, D);
	and (adacond7, CLK, D__bar, SN);
	not (CLK__bar, CLK);
	and (adacond8, CLK__bar, D, SN);
	and (adacond9, CLK__bar, D__bar, SN);
	and (adacond2, CLK, D);
	and (adacond3, CLK, D__bar);
	and (adacond4, CLK__bar, D);
	and (adacond5, CLK__bar, D__bar);
	and (adacond10, D__bar, RN);
	and (adacond11, CLK, D, RN);
	and (adacond12, CLK, D__bar, RN);
	and (adacond13, CLK__bar, D, RN);
	and (adacond14, CLK__bar, D__bar, RN);
	and (adacond15, D, RN, SN);
	and (adacond16, D__bar, RN, SN);

	specify
		if ((CLK & D & SN))
			(negedge RN => (Q+:1'b0)) = 0;
		if ((CLK & ~D & SN))
			(negedge RN => (Q+:1'b0)) = 0;
		if ((~CLK & D & SN))
			(negedge RN => (Q+:1'b0)) = 0;
		if ((~CLK & ~D & SN))
			(negedge RN => (Q+:1'b0)) = 0;
		ifnone (negedge RN => (Q+:1'b0)) = 0;
		if ((CLK & ~RN))
			(posedge SN => (Q+:1'b0)) = 0;
		if ((~CLK & ~RN))
			(posedge SN => (Q+:1'b0)) = 0;
		ifnone (posedge SN => (Q+:1'b0)) = 0;
		if ((CLK & D & RN))
			(negedge SN => (Q+:1'b1)) = 0;
		if ((CLK & ~RN))
			(negedge SN => (Q+:1'b1)) = 0;
		if ((CLK & ~D & RN))
			(negedge SN => (Q+:1'b1)) = 0;
		if ((~CLK & D & RN))
			(negedge SN => (Q+:1'b1)) = 0;
		if ((~CLK & ~RN))
			(negedge SN => (Q+:1'b1)) = 0;
		if ((~CLK & ~D & RN))
			(negedge SN => (Q+:1'b1)) = 0;
		ifnone (negedge SN => (Q+:1'b1)) = 0;
		(posedge CLK => (Q+:D)) = 0;
		$setuphold (posedge CLK &&& adacond0, posedge D &&& adacond0, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$setuphold (posedge CLK &&& adacond0, negedge D &&& adacond0, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$setuphold (posedge CLK, posedge D, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$setuphold (posedge CLK, negedge D, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$setuphold (posedge SN &&& adacond2, posedge RN &&& adacond2, 0, 0, notifier,,, delayed_SN, delayed_RN);
		$setuphold (posedge SN &&& adacond3, posedge RN &&& adacond3, 0, 0, notifier,,, delayed_SN, delayed_RN);
		$setuphold (posedge SN &&& adacond4, posedge RN &&& adacond4, 0, 0, notifier,,, delayed_SN, delayed_RN);
		$setuphold (posedge SN &&& adacond5, posedge RN &&& adacond5, 0, 0, notifier,,, delayed_SN, delayed_RN);
		$setuphold (posedge SN, posedge RN, 0, 0, notifier,,, delayed_SN, delayed_RN);
		$setuphold (posedge RN &&& CLK, posedge SN &&& CLK, 0, 0, notifier,,, delayed_RN, delayed_SN);
		$setuphold (posedge RN &&& adacond4, posedge SN &&& adacond4, 0, 0, notifier,,, delayed_RN, delayed_SN);
		$setuphold (posedge RN &&& adacond5, posedge SN &&& adacond5, 0, 0, notifier,,, delayed_RN, delayed_SN);
		$setuphold (posedge RN, posedge SN, 0, 0, notifier,,, delayed_RN, delayed_SN);
		$recovery (posedge RN &&& adacond1, posedge CLK &&& adacond1, 0, notifier);
		$recovery (posedge RN, posedge CLK, 0, notifier);
		$hold (posedge CLK &&& adacond1, posedge RN &&& adacond1, 0, notifier);
		$hold (posedge CLK, posedge RN, 0, notifier);
		$recovery (posedge SN &&& adacond10, posedge CLK &&& adacond10, 0, notifier);
		$recovery (posedge SN, posedge CLK, 0, notifier);
		$hold (posedge CLK &&& adacond10, posedge SN &&& adacond10, 0, notifier);
		$hold (posedge CLK, posedge SN, 0, notifier);
		$width (negedge RN &&& adacond6, 0, 0, notifier);
		$width (negedge RN &&& adacond7, 0, 0, notifier);
		$width (negedge RN &&& adacond8, 0, 0, notifier);
		$width (negedge RN &&& adacond9, 0, 0, notifier);
		$width (negedge SN &&& adacond11, 0, 0, notifier);
		$width (negedge SN &&& adacond12, 0, 0, notifier);
		$width (negedge SN &&& adacond13, 0, 0, notifier);
		$width (negedge SN &&& adacond14, 0, 0, notifier);
		$width (posedge CLK &&& adacond15, 0, 0, notifier);
		$width (negedge CLK &&& adacond15, 0, 0, notifier);
		$width (posedge CLK &&& adacond16, 0, 0, notifier);
		$width (negedge CLK &&& adacond16, 0, 0, notifier);
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module VOTER3X1 (Y, A, B, C);
	output Y;
	input A, B, C;

	// Function
	wire int_fwire_0, int_fwire_1, int_fwire_2;

	and (int_fwire_0, B, C);
	and (int_fwire_1, A, C);
	and (int_fwire_2, A, B);
	or (Y, int_fwire_2, int_fwire_1, int_fwire_0);

	// Timing
	specify
		if ((B & ~C))
			(A => Y) = 0;
		if ((~B & C))
			(A => Y) = 0;
		ifnone (A => Y) = 0;
		if ((A & ~C))
			(B => Y) = 0;
		if ((~A & C))
			(B => Y) = 0;
		ifnone (B => Y) = 0;
		if ((A & ~B))
			(C => Y) = 0;
		if ((~A & B))
			(C => Y) = 0;
		ifnone (C => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module VOTERN3X1 (YN, A, B, C);
	output YN;
	input A, B, C;

	// Function
	wire A__bar, B__bar, C__bar;
	wire int_fwire_0, int_fwire_1, int_fwire_2;

	not (C__bar, C);
	not (B__bar, B);
	and (int_fwire_0, B__bar, C__bar);
	not (A__bar, A);
	and (int_fwire_1, A__bar, C__bar);
	and (int_fwire_2, A__bar, B__bar);
	or (YN, int_fwire_2, int_fwire_1, int_fwire_0);

	// Timing
	specify
		if ((B & ~C))
			(A => YN) = 0;
		if ((~B & C))
			(A => YN) = 0;
		ifnone (A => YN) = 0;
		if ((A & ~C))
			(B => YN) = 0;
		if ((~A & C))
			(B => YN) = 0;
		ifnone (B => YN) = 0;
		if ((A & ~B))
			(C => YN) = 0;
		if ((~A & B))
			(C => YN) = 0;
		ifnone (C => YN) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module XNOR2X1 (Y, A, B);
	output Y;
	input A, B;

	// Function
	wire A__bar, B__bar, int_fwire_0;
	wire int_fwire_1;

	not (B__bar, B);
	not (A__bar, A);
	and (int_fwire_0, A__bar, B__bar);
	and (int_fwire_1, A, B);
	or (Y, int_fwire_1, int_fwire_0);

	// Timing
	specify
		if (B)
			(A => Y) = 0;
		if (~B)
			(A => Y) = 0;
		if (A)
			(B => Y) = 0;
		if (~A)
			(B => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type:  
`timescale 1ns/10ps
`celldefine
module XOR2X1 (Y, A, B);
	output Y;
	input A, B;

	// Function
	wire A__bar, B__bar, int_fwire_0;
	wire int_fwire_1;

	not (A__bar, A);
	and (int_fwire_0, A__bar, B);
	not (B__bar, B);
	and (int_fwire_1, A, B__bar);
	or (Y, int_fwire_1, int_fwire_0);

	// Timing
	specify
		if (~B)
			(A => Y) = 0;
		if (B)
			(A => Y) = 0;
		if (~A)
			(B => Y) = 0;
		if (A)
			(B => Y) = 0;
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
