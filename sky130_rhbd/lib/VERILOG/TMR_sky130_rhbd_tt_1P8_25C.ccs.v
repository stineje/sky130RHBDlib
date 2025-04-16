// Verilog for library /home/zwils11/Documents/OSU_SKY130_FLOW/char/liberate/VERILOG/TMR_sky130_rhbd_tt_1P8_25C.ccs created by Liberate 23.1.1.221.isr1 on Thu Oct 17 15:55:21 2024 for SDF version 2.1

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
module TMRDFFSNQNX1 (QN, D, SN, CLK);
	output QN;
	input D, SN, CLK;
	reg notifier;
	wire delayed_D, delayed_CLK;

	// Function
	wire int_fwire_IQN, int_fwire_s, xcr_0;

	not (int_fwire_s, SN);
	altos_dff_s_err (xcr_0, delayed_CLK, delayed_D, int_fwire_s);
	altos_dff_s (int_fwire_IQN, notifier, delayed_CLK, delayed_D, int_fwire_s, xcr_0);
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
			(negedge SN => (QN+:1'b1)) = 0;
		if ((CLK & ~D))
			(negedge SN => (QN+:1'b1)) = 0;
		if ((~CLK & D))
			(negedge SN => (QN+:1'b1)) = 0;
		if ((~CLK & ~D))
			(negedge SN => (QN+:1'b1)) = 0;
		ifnone (negedge SN => (QN+:1'b1)) = 0;
		(posedge CLK => (QN+:D)) = 0;
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
