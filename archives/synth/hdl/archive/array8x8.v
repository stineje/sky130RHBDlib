
// Correction constant value: 0 (0000000000000000)

module mult (Z2, X, Y);
	
	input [7:0] Y;
	input [7:0] X;
	output [15:0] Z2;


	wire [7:0] P0;
	wire [7:0] carry1;
	wire [7:0] sum1;
	wire [7:0] P1;
	wire [7:0] carry2;
	wire [7:0] sum2;
	wire [7:0] P2;
	wire [7:0] carry3;
	wire [7:0] sum3;
	wire [7:0] P3;
	wire [7:0] carry4;
	wire [7:0] sum4;
	wire [7:0] P4;
	wire [7:0] carry5;
	wire [7:0] sum5;
	wire [7:0] P5;
	wire [7:0] carry6;
	wire [7:0] sum6;
	wire [7:0] P6;
	wire [7:0] carry7;
	wire [7:0] sum7;
	wire [7:0] P7;
	wire [7:0] carry8;
	wire [7:0] sum8;
	wire [14:0] carry9;
	wire [15:0] Z;


	// generate the partial products.
	and pp1(P0[7], X[7], Y[0]);
	and pp2(P0[6], X[6], Y[0]);
	and pp3(P0[5], X[5], Y[0]);
	and pp4(P0[4], X[4], Y[0]);
	and pp5(P0[3], X[3], Y[0]);
	and pp6(P0[2], X[2], Y[0]);
	and pp7(P0[1], X[1], Y[0]);
	and pp8(P0[0], X[0], Y[0]);
	and pp9(sum1[7], X[7], Y[1]);
	and pp10(P1[6], X[6], Y[1]);
	and pp11(P1[5], X[5], Y[1]);
	and pp12(P1[4], X[4], Y[1]);
	and pp13(P1[3], X[3], Y[1]);
	and pp14(P1[2], X[2], Y[1]);
	and pp15(P1[1], X[1], Y[1]);
	and pp16(P1[0], X[0], Y[1]);
	and pp17(sum2[7], X[7], Y[2]);
	and pp18(P2[6], X[6], Y[2]);
	and pp19(P2[5], X[5], Y[2]);
	and pp20(P2[4], X[4], Y[2]);
	and pp21(P2[3], X[3], Y[2]);
	and pp22(P2[2], X[2], Y[2]);
	and pp23(P2[1], X[1], Y[2]);
	and pp24(P2[0], X[0], Y[2]);
	and pp25(sum3[7], X[7], Y[3]);
	and pp26(P3[6], X[6], Y[3]);
	and pp27(P3[5], X[5], Y[3]);
	and pp28(P3[4], X[4], Y[3]);
	and pp29(P3[3], X[3], Y[3]);
	and pp30(P3[2], X[2], Y[3]);
	and pp31(P3[1], X[1], Y[3]);
	and pp32(P3[0], X[0], Y[3]);
	and pp33(sum4[7], X[7], Y[4]);
	and pp34(P4[6], X[6], Y[4]);
	and pp35(P4[5], X[5], Y[4]);
	and pp36(P4[4], X[4], Y[4]);
	and pp37(P4[3], X[3], Y[4]);
	and pp38(P4[2], X[2], Y[4]);
	and pp39(P4[1], X[1], Y[4]);
	and pp40(P4[0], X[0], Y[4]);
	and pp41(sum5[7], X[7], Y[5]);
	and pp42(P5[6], X[6], Y[5]);
	and pp43(P5[5], X[5], Y[5]);
	and pp44(P5[4], X[4], Y[5]);
	and pp45(P5[3], X[3], Y[5]);
	and pp46(P5[2], X[2], Y[5]);
	and pp47(P5[1], X[1], Y[5]);
	and pp48(P5[0], X[0], Y[5]);
	and pp49(sum6[7], X[7], Y[6]);
	and pp50(P6[6], X[6], Y[6]);
	and pp51(P6[5], X[5], Y[6]);
	and pp52(P6[4], X[4], Y[6]);
	and pp53(P6[3], X[3], Y[6]);
	and pp54(P6[2], X[2], Y[6]);
	and pp55(P6[1], X[1], Y[6]);
	and pp56(P6[0], X[0], Y[6]);
	and pp57(sum7[7], X[7], Y[7]);
	and pp58(P7[6], X[6], Y[7]);
	and pp59(P7[5], X[5], Y[7]);
	and pp60(P7[4], X[4], Y[7]);
	and pp61(P7[3], X[3], Y[7]);
	and pp62(P7[2], X[2], Y[7]);
	and pp63(P7[1], X[1], Y[7]);
	and pp64(P7[0], X[0], Y[7]);

// FAILED TO OPTIMIZE THE CORRECTION!
	// Array Reduction
	half_adder  HA1(carry1[6],sum1[6],P1[6],P0[7]);
	half_adder  HA2(carry1[5],sum1[5],P1[5],P0[6]);
	half_adder  HA3(carry1[4],sum1[4],P1[4],P0[5]);
	half_adder  HA4(carry1[3],sum1[3],P1[3],P0[4]);
	half_adder  HA5(carry1[2],sum1[2],P1[2],P0[3]);
	half_adder  HA6(carry1[1],sum1[1],P1[1],P0[2]);
	half_adder  HA7(carry1[0],sum1[0],P1[0],P0[1]);
	full_adder  FA1(carry2[6],sum2[6],P2[6],sum1[7],carry1[6]);
	full_adder  FA2(carry2[5],sum2[5],P2[5],sum1[6],carry1[5]);
	full_adder  FA3(carry2[4],sum2[4],P2[4],sum1[5],carry1[4]);
	full_adder  FA4(carry2[3],sum2[3],P2[3],sum1[4],carry1[3]);
	full_adder  FA5(carry2[2],sum2[2],P2[2],sum1[3],carry1[2]);
	full_adder  FA6(carry2[1],sum2[1],P2[1],sum1[2],carry1[1]);
	full_adder  FA7(carry2[0],sum2[0],P2[0],sum1[1],carry1[0]);
	full_adder  FA8(carry3[6],sum3[6],P3[6],sum2[7],carry2[6]);
	full_adder  FA9(carry3[5],sum3[5],P3[5],sum2[6],carry2[5]);
	full_adder  FA10(carry3[4],sum3[4],P3[4],sum2[5],carry2[4]);
	full_adder  FA11(carry3[3],sum3[3],P3[3],sum2[4],carry2[3]);
	full_adder  FA12(carry3[2],sum3[2],P3[2],sum2[3],carry2[2]);
	full_adder  FA13(carry3[1],sum3[1],P3[1],sum2[2],carry2[1]);
	full_adder  FA14(carry3[0],sum3[0],P3[0],sum2[1],carry2[0]);
	full_adder  FA15(carry4[6],sum4[6],P4[6],sum3[7],carry3[6]);
	full_adder  FA16(carry4[5],sum4[5],P4[5],sum3[6],carry3[5]);
	full_adder  FA17(carry4[4],sum4[4],P4[4],sum3[5],carry3[4]);
	full_adder  FA18(carry4[3],sum4[3],P4[3],sum3[4],carry3[3]);
	full_adder  FA19(carry4[2],sum4[2],P4[2],sum3[3],carry3[2]);
	full_adder  FA20(carry4[1],sum4[1],P4[1],sum3[2],carry3[1]);
	full_adder  FA21(carry4[0],sum4[0],P4[0],sum3[1],carry3[0]);
	full_adder  FA22(carry5[6],sum5[6],P5[6],sum4[7],carry4[6]);
	full_adder  FA23(carry5[5],sum5[5],P5[5],sum4[6],carry4[5]);
	full_adder  FA24(carry5[4],sum5[4],P5[4],sum4[5],carry4[4]);
	full_adder  FA25(carry5[3],sum5[3],P5[3],sum4[4],carry4[3]);
	full_adder  FA26(carry5[2],sum5[2],P5[2],sum4[3],carry4[2]);
	full_adder  FA27(carry5[1],sum5[1],P5[1],sum4[2],carry4[1]);
	full_adder  FA28(carry5[0],sum5[0],P5[0],sum4[1],carry4[0]);
	full_adder  FA29(carry6[6],sum6[6],P6[6],sum5[7],carry5[6]);
	full_adder  FA30(carry6[5],sum6[5],P6[5],sum5[6],carry5[5]);
	full_adder  FA31(carry6[4],sum6[4],P6[4],sum5[5],carry5[4]);
	full_adder  FA32(carry6[3],sum6[3],P6[3],sum5[4],carry5[3]);
	full_adder  FA33(carry6[2],sum6[2],P6[2],sum5[3],carry5[2]);
	full_adder  FA34(carry6[1],sum6[1],P6[1],sum5[2],carry5[1]);
	full_adder  FA35(carry6[0],sum6[0],P6[0],sum5[1],carry5[0]);
	full_adder  FA36(carry7[6],sum7[6],P7[6],sum6[7],carry6[6]);
	full_adder  FA37(carry7[5],sum7[5],P7[5],sum6[6],carry6[5]);
	full_adder  FA38(carry7[4],sum7[4],P7[4],sum6[5],carry6[4]);
	full_adder  FA39(carry7[3],sum7[3],P7[3],sum6[4],carry6[3]);
	full_adder  FA40(carry7[2],sum7[2],P7[2],sum6[3],carry6[2]);
	full_adder  FA41(carry7[1],sum7[1],P7[1],sum6[2],carry6[1]);
	full_adder  FA42(carry7[0],sum7[0],P7[0],sum6[1],carry6[0]);

	// Generate lower product bits YBITS 
	buf b1(Z2[0], P0[0]);
	assign Z2[1] = sum1[0];
	assign Z2[2] = sum2[0];
	assign Z2[3] = sum3[0];
	assign Z2[4] = sum4[0];
	assign Z2[5] = sum5[0];
	assign Z2[6] = sum6[0];
	assign Z2[7] = sum7[0];

	// Final Carry Propagate Addition
	//   Generate higher product bits
	half_adder CPA1(carry8[0],Z2[8],carry7[0],sum7[1]);
	full_adder CPA2(carry8[1],Z2[9],carry7[1],carry8[0],sum7[2]);
	full_adder CPA3(carry8[2],Z2[10],carry7[2],carry8[1],sum7[3]);
	full_adder CPA4(carry8[3],Z2[11],carry7[3],carry8[2],sum7[4]);
	full_adder CPA5(carry8[4],Z2[12],carry7[4],carry8[3],sum7[5]);
	full_adder CPA6(carry8[5],Z2[13],carry7[5],carry8[4],sum7[6]);
	full_adder CPA7(Z2[15],Z2[14],carry7[6],carry8[5],sum7[7]);
endmodule