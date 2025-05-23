module mult2 #(
	WIDTH = 11
) (
	input logic [WIDTH-1:0] op1, op2,
	input logic clk,
	output logic [2*WIDTH-1:0] y
);
	logic [WIDTH-1:0] ha_cout;
	logic [WIDTH-1:0] fa0_cout, fa0_sum;
	logic [WIDTH-1:0] fa1_cout, fa1_sum;
	logic [WIDTH-1:0] fa2_cout, fa2_sum;
	logic [WIDTH-1:0] fa3_cout, fa3_sum;
	logic [WIDTH-1:0] fa4_cout, fa4_sum;
	logic [WIDTH-1:0] fa5_cout, fa5_sum;
	logic [WIDTH-1:0] fa6_cout, fa6_sum;
	logic [WIDTH-1:0] fa7_cout, fa7_sum;
	logic [WIDTH-1:0] fa8_cout, fa8_sum;
	logic [WIDTH-1:0] fa9_cout, fa9_sum;
	logic [7:0] fa10_cout;

	logic and00,and01,and02,and03,and04,and05,and06,and07,and08,and09,and010;
	logic and10,and11,and12,and13,and14,and15,and16,and17,and18,and19,and110;
	logic and20,and21,and22,and23,and24,and25,and26,and27,and28,and29,and210;
	logic and30,and31,and32,and33,and34,and35,and36,and37,and38,and39,and310;
	logic and40,and41,and42,and43,and44,and45,and46,and47,and48,and49,and410;
	logic and50,and51,and52,and53,and54,and55,and56,and57,and58,and59,and510;
	logic and60,and61,and62,and63,and64,and65,and66,and67,and68,and69,and610;
	logic and70,and71,and72,and73,and74,and75,and76,and77,and78,and79,and710;
	logic and80,and81,and82,and83,and84,and85,and86,and87,and88,and89,and810;
	logic and90,and91,and92,and93,and94,and95,and96,and97,and98,and99,and910;
	logic and100,and101,and102,and103,and104,and105,and106,and107,and108,and109,and1010;

	assign and00 = op1[0] & op2[0];
	assign and01 = op1[0] & op2[1];
	assign and02 = op1[0] & op2[2];
	assign and03 = op1[0] & op2[3];
	assign and04 = op1[0] & op2[4];
	assign and05 = op1[0] & op2[5];
	assign and06 = op1[0] & op2[6];
	assign and07 = op1[0] & op2[7];
	assign and08 = op1[0] & op2[8];
	assign and09 = op1[0] & op2[9];
	assign and010= op1[0] & op2[10];
	assign and10 = op1[1] & op2[0];
	assign and11 = op1[1] & op2[1];
	assign and12 = op1[1] & op2[2];
	assign and13 = op1[1] & op2[3];
	assign and14 = op1[1] & op2[4];
	assign and15 = op1[1] & op2[5];
	assign and16 = op1[1] & op2[6];
	assign and17 = op1[1] & op2[7];
	assign and18 = op1[1] & op2[8];
	assign and19 = op1[1] & op2[9];
	assign and110= op1[1] & op2[10];
	assign and20 = op1[2] & op2[0];
	assign and21 = op1[2] & op2[1];
	assign and22 = op1[2] & op2[2];
	assign and23 = op1[2] & op2[3];
	assign and24 = op1[2] & op2[4];
	assign and25 = op1[2] & op2[5];
	assign and26 = op1[2] & op2[6];
	assign and27 = op1[2] & op2[7];
	assign and28 = op1[2] & op2[8];
	assign and29 = op1[2] & op2[9];
	assign and210= op1[2] & op2[10];
	assign and30 = op1[3] & op2[0];
	assign and31 = op1[3] & op2[1];
	assign and32 = op1[3] & op2[2];
	assign and33 = op1[3] & op2[3];
	assign and34 = op1[3] & op2[4];
	assign and35 = op1[3] & op2[5];
	assign and36 = op1[3] & op2[6];
	assign and37 = op1[3] & op2[7];
	assign and38 = op1[3] & op2[8];
	assign and39 = op1[3] & op2[9];
	assign and310= op1[3] & op2[10];
	assign and40 = op1[4] & op2[0];
	assign and41 = op1[4] & op2[1];
	assign and42 = op1[4] & op2[2];
	assign and43 = op1[4] & op2[3];
	assign and44 = op1[4] & op2[4];
	assign and45 = op1[4] & op2[5];
	assign and46 = op1[4] & op2[6];
	assign and47 = op1[4] & op2[7];
	assign and48 = op1[4] & op2[8];
	assign and49 = op1[4] & op2[9];
	assign and410= op1[4] & op2[10];
	assign and50 = op1[5] & op2[0];
	assign and51 = op1[5] & op2[1];
	assign and52 = op1[5] & op2[2];
	assign and53 = op1[5] & op2[3];
	assign and54 = op1[5] & op2[4];
	assign and55 = op1[5] & op2[5];
	assign and56 = op1[5] & op2[6];
	assign and57 = op1[5] & op2[7];
	assign and58 = op1[5] & op2[8];
	assign and59 = op1[5] & op2[9];
	assign and510= op1[5] & op2[10];
	assign and60 = op1[6] & op2[0];
	assign and61 = op1[6] & op2[1];
	assign and62 = op1[6] & op2[2];
	assign and63 = op1[6] & op2[3];
	assign and64 = op1[6] & op2[4];
	assign and65 = op1[6] & op2[5];
	assign and66 = op1[6] & op2[6];
	assign and67 = op1[6] & op2[7];
	assign and68 = op1[6] & op2[8];
	assign and69 = op1[6] & op2[9];
	assign and610= op1[6] & op2[10];
	assign and70 = op1[7] & op2[0];
	assign and71 = op1[7] & op2[1];
	assign and72 = op1[7] & op2[2];
	assign and73 = op1[7] & op2[3];
	assign and74 = op1[7] & op2[4];
	assign and75 = op1[7] & op2[5];
	assign and76 = op1[7] & op2[6];
	assign and77 = op1[7] & op2[7];
	assign and78 = op1[7] & op2[8];
	assign and79 = op1[7] & op2[9];
	assign and710= op1[7] & op2[10];
	assign and80 = op1[8] & op2[0];
	assign and81 = op1[8] & op2[1];
	assign and82 = op1[8] & op2[2];
	assign and83 = op1[8] & op2[3];
	assign and84 = op1[8] & op2[4];
	assign and85 = op1[8] & op2[5];
	assign and86 = op1[8] & op2[6];
	assign and87 = op1[8] & op2[7];
	assign and88 = op1[8] & op2[8];
	assign and89 = op1[8] & op2[9];
	assign and810= op1[8] & op2[10];
	assign and90 = op1[9] & op2[0];
	assign and91 = op1[9] & op2[1];
	assign and92 = op1[9] & op2[2];
	assign and93 = op1[9] & op2[3];
	assign and94 = op1[9] & op2[4];
	assign and95 = op1[9] & op2[5];
	assign and96 = op1[9] & op2[6];
	assign and97 = op1[9] & op2[7];
	assign and98 = op1[9] & op2[8];
	assign and99 = op1[9] & op2[9];
	assign and910= op1[9] & op2[10];
	assign and100 = op1[10] & op2[0];
	assign and101 = op1[10] & op2[1];
	assign and102 = op1[10] & op2[2];
	assign and103 = op1[10] & op2[3];
	assign and104 = op1[10] & op2[4];
	assign and105 = op1[10] & op2[5];
	assign and106 = op1[10] & op2[6];
	assign and107 = op1[10] & op2[7];
	assign and108 = op1[10] & op2[8];
	assign and109 = op1[10] & op2[9];
	assign and1010= op1[10] & op2[10];

	assign y[0] = op1[0] & op2[0];

    // Row 1
	HA ha0(and10, and01, ha_cout[0], y[1]);
	FA fa0_0(and11, and20, and02, fa0_cout[0], fa0_sum[0]);
	FA fa0_1(and12, and21, and03, fa0_cout[1], fa0_sum[1]);
	FA fa0_2(and13, and22, and04, fa0_cout[2], fa0_sum[2]);
	FA fa0_3(and14, and23, and05, fa0_cout[3], fa0_sum[3]);
	FA fa0_4(and15, and24, and06, fa0_cout[4], fa0_sum[4]);
	FA fa0_5(and16, and25, and07, fa0_cout[5], fa0_sum[5]);
	FA fa0_6(and17, and26, and08, fa0_cout[6], fa0_sum[6]);
	FA fa0_7(and18, and27, and09, fa0_cout[7], fa0_sum[7]);
	FA fa0_8(and19, and28, and010, fa0_cout[8], fa0_sum[8]);

    // Row 2
	HA ha1(fa0_sum[0], ha_cout[0], ha_cout[1], y[2]);
	FA fa1_0(fa0_sum[1], and30, fa0_cout[0], fa1_cout[0], fa1_sum[0]);
	FA fa1_1(fa0_sum[2], and31, fa0_cout[1], fa1_cout[1], fa1_sum[1]);
	FA fa1_2(fa0_sum[3], and32, fa0_cout[2], fa1_cout[2], fa1_sum[2]);
	FA fa1_3(fa0_sum[4], and33, fa0_cout[3], fa1_cout[3], fa1_sum[3]);
	FA fa1_4(fa0_sum[5], and34, fa0_cout[4], fa1_cout[4], fa1_sum[4]);
	FA fa1_5(fa0_sum[6], and35, fa0_cout[5], fa1_cout[5], fa1_sum[5]);
	FA fa1_6(fa0_sum[7], and36, fa0_cout[6], fa1_cout[6], fa1_sum[6]);
	FA fa1_7(fa0_sum[8], and37, fa0_cout[7], fa1_cout[7], fa1_sum[7]);
	FA fa1_8(and29,  and110, fa0_cout[8], fa1_cout[8], fa1_sum[8]);

    // Row 3
	HA ha2(fa1_sum[0], ha_cout[1], ha_cout[2], y[3]);
	FA fa2_0(fa1_sum[1], and40, fa1_cout[0], fa2_cout[0], fa2_sum[0]);
	FA fa2_1(fa1_sum[2], and41, fa1_cout[1], fa2_cout[1], fa2_sum[1]);
	FA fa2_2(fa1_sum[3], and42, fa1_cout[2], fa2_cout[2], fa2_sum[2]);
	FA fa2_3(fa1_sum[4], and43, fa1_cout[3], fa2_cout[3], fa2_sum[3]);
	FA fa2_4(fa1_sum[5], and44, fa1_cout[4], fa2_cout[4], fa2_sum[4]);
	FA fa2_5(fa1_sum[6], and45, fa1_cout[5], fa2_cout[5], fa2_sum[5]);
	FA fa2_6(fa1_sum[7], and46, fa1_cout[6], fa2_cout[6], fa2_sum[6]);
	FA fa2_7(fa1_sum[8], and38, fa1_cout[7], fa2_cout[7], fa2_sum[7]);
	FA fa2_8(and39,  and210, fa1_cout[8], fa2_cout[8], fa2_sum[8]);

    // Row 4
	HA ha3(fa2_sum[0], ha_cout[2], ha_cout[3], y[4]);
	FA fa3_0(fa2_sum[1], and50, fa2_cout[0], fa3_cout[0], fa3_sum[0]);
	FA fa3_1(fa2_sum[2], and51, fa2_cout[1], fa3_cout[1], fa3_sum[1]);
	FA fa3_2(fa2_sum[3], and52, fa2_cout[2], fa3_cout[2], fa3_sum[2]);
	FA fa3_3(fa2_sum[4], and53, fa2_cout[3], fa3_cout[3], fa3_sum[3]);
	FA fa3_4(fa2_sum[5], and54, fa2_cout[4], fa3_cout[4], fa3_sum[4]);
	FA fa3_5(fa2_sum[6], and55, fa2_cout[5], fa3_cout[5], fa3_sum[5]);
	FA fa3_6(fa2_sum[7], and47, fa2_cout[6], fa3_cout[6], fa3_sum[6]);
	FA fa3_7(fa2_sum[8], and48, fa2_cout[7], fa3_cout[7], fa3_sum[7]);
	FA fa3_8(and49,  and310,fa2_cout[8], fa3_cout[8], fa3_sum[8]);

    // Row 5
	HA ha4(fa3_sum[0], ha_cout[3], ha_cout[4], y[5]);
	FA fa4_0(fa3_sum[1], and60, fa3_cout[0], fa4_cout[0], fa4_sum[0]);
	FA fa4_1(fa3_sum[2], and61, fa3_cout[1], fa4_cout[1], fa4_sum[1]);
	FA fa4_2(fa3_sum[3], and62, fa3_cout[2], fa4_cout[2], fa4_sum[2]);
	FA fa4_3(fa3_sum[4], and63, fa3_cout[3], fa4_cout[3], fa4_sum[3]);
	FA fa4_4(fa3_sum[5], and64, fa3_cout[4], fa4_cout[4], fa4_sum[4]);
	FA fa4_5(fa3_sum[6], and56, fa3_cout[5], fa4_cout[5], fa4_sum[5]);
	FA fa4_6(fa3_sum[7], and57, fa3_cout[6], fa4_cout[6], fa4_sum[6]);
	FA fa4_7(fa3_sum[8], and58, fa3_cout[7], fa4_cout[7], fa4_sum[7]);
	FA fa4_8(and59,  and410,fa3_cout[8], fa4_cout[8], fa4_sum[8]);

    // Row 6
	HA ha5(fa4_sum[0], ha_cout[4], ha_cout[5], y[6]);
	FA fa5_0(fa4_sum[1], and70, fa4_cout[0], fa5_cout[0], fa5_sum[0]);
	FA fa5_1(fa4_sum[2], and71, fa4_cout[1], fa5_cout[1], fa5_sum[1]);
	FA fa5_2(fa4_sum[3], and72, fa4_cout[2], fa5_cout[2], fa5_sum[2]);
	FA fa5_3(fa4_sum[4], and73, fa4_cout[3], fa5_cout[3], fa5_sum[3]);
	FA fa5_4(fa4_sum[5], and65, fa4_cout[4], fa5_cout[4], fa5_sum[4]);
	FA fa5_5(fa4_sum[6], and66, fa4_cout[5], fa5_cout[5], fa5_sum[5]);
	FA fa5_6(fa4_sum[7], and67, fa4_cout[6], fa5_cout[6], fa5_sum[6]);
	FA fa5_7(fa4_sum[8], and68, fa4_cout[7], fa5_cout[7], fa5_sum[7]);
	FA fa5_8(and69,  and510,fa4_cout[8], fa5_cout[8], fa5_sum[8]);

    // Row 7
	HA ha6(fa5_sum[0], ha_cout[5], ha_cout[6], y[7]);
	FA fa6_0(fa5_sum[1], and80, fa5_cout[0], fa6_cout[0], fa6_sum[0]);
	FA fa6_1(fa5_sum[2], and81, fa5_cout[1], fa6_cout[1], fa6_sum[1]);
	FA fa6_2(fa5_sum[3], and82, fa5_cout[2], fa6_cout[2], fa6_sum[2]);
	FA fa6_3(fa5_sum[4], and74, fa5_cout[3], fa6_cout[3], fa6_sum[3]);
	FA fa6_4(fa5_sum[5], and75, fa5_cout[4], fa6_cout[4], fa6_sum[4]);
	FA fa6_5(fa5_sum[6], and76, fa5_cout[5], fa6_cout[5], fa6_sum[5]);
	FA fa6_6(fa5_sum[7], and77, fa5_cout[6], fa6_cout[6], fa6_sum[6]);
	FA fa6_7(fa5_sum[8], and78, fa5_cout[7], fa6_cout[7], fa6_sum[7]);
	FA fa6_8(and79,  and610,fa5_cout[8], fa6_cout[8], fa6_sum[8]);

    // Row 8
	HA ha7(fa6_sum[0], ha_cout[6], ha_cout[7], y[8]);
	FA fa7_0(fa6_sum[1], and90, fa6_cout[0], fa7_cout[0], fa7_sum[0]);
	FA fa7_1(fa6_sum[2], and91, fa6_cout[1], fa7_cout[1], fa7_sum[1]);
	FA fa7_2(fa6_sum[3], and83, fa6_cout[2], fa7_cout[2], fa7_sum[2]);
	FA fa7_3(fa6_sum[4], and84, fa6_cout[3], fa7_cout[3], fa7_sum[3]);
	FA fa7_4(fa6_sum[5], and85, fa6_cout[4], fa7_cout[4], fa7_sum[4]);
	FA fa7_5(fa6_sum[6], and86, fa6_cout[5], fa7_cout[5], fa7_sum[5]);
	FA fa7_6(fa6_sum[7], and87, fa6_cout[6], fa7_cout[6], fa7_sum[6]);
	FA fa7_7(fa6_sum[8], and88, fa6_cout[7], fa7_cout[7], fa7_sum[7]);
	FA fa7_8(and89,  and710,fa6_cout[8], fa7_cout[8], fa7_sum[8]);

    // Row 9
	HA ha8(fa7_sum[0], ha_cout[7], ha_cout[8], y[9]);
	FA fa8_0(fa7_sum[1], and100, fa7_cout[0], fa8_cout[0], fa8_sum[0]);
	FA fa8_1(fa7_sum[2], and92, fa7_cout[1], fa8_cout[1], fa8_sum[1]);
	FA fa8_2(fa7_sum[3], and93, fa7_cout[2], fa8_cout[2], fa8_sum[2]);
	FA fa8_3(fa7_sum[4], and94, fa7_cout[3], fa8_cout[3], fa8_sum[3]);
	FA fa8_4(fa7_sum[5], and95, fa7_cout[4], fa8_cout[4], fa8_sum[4]);
	FA fa8_5(fa7_sum[6], and96, fa7_cout[5], fa8_cout[5], fa8_sum[5]);
	FA fa8_6(fa7_sum[7], and97, fa7_cout[6], fa8_cout[6], fa8_sum[6]);
	FA fa8_7(fa7_sum[8], and98, fa7_cout[7], fa8_cout[7], fa8_sum[7]);
	FA fa8_8(and99,  and810, fa7_cout[8], fa8_cout[8], fa8_sum[8]);

    // Row 10
	HA ha9(fa8_sum[0], ha_cout[8], ha_cout[9], y[10]);
	FA fa9_0(fa8_sum[1], and101, fa8_cout[0], fa9_cout[0], fa9_sum[0]);
	FA fa9_1(fa8_sum[2], and102, fa8_cout[1], fa9_cout[1], fa9_sum[1]);
	FA fa9_2(fa8_sum[3], and103, fa8_cout[2], fa9_cout[2], fa9_sum[2]);
	FA fa9_3(fa8_sum[4], and104, fa8_cout[3], fa9_cout[3], fa9_sum[3]);
	FA fa9_4(fa8_sum[5], and105, fa8_cout[4], fa9_cout[4], fa9_sum[4]);
	FA fa9_5(fa8_sum[6], and106, fa8_cout[5], fa9_cout[5], fa9_sum[5]);
	FA fa9_6(fa8_sum[7], and107, fa8_cout[6], fa9_cout[6], fa9_sum[6]);
	FA fa9_7(fa8_sum[8], and108, fa8_cout[7], fa9_cout[7], fa9_sum[7]);
	FA fa9_8(and109, and910, fa8_cout[8], fa9_cout[8], fa9_sum[8]);

    // Row 11
	HA ha10(fa9_sum[0], ha_cout[9], ha_cout[10], y[11]);
	FA fa10_0(fa9_sum[1], fa9_cout[0], ha_cout[10], fa10_cout[0], y[12]);
	FA fa10_1(fa9_sum[2], fa9_cout[1], fa10_cout[0], fa10_cout[1], y[13]);
	FA fa10_2(fa9_sum[3], fa9_cout[2], fa10_cout[1], fa10_cout[2], y[14]);
	FA fa10_3(fa9_sum[4], fa9_cout[3], fa10_cout[2], fa10_cout[3], y[15]);
	FA fa10_4(fa9_sum[5], fa9_cout[4], fa10_cout[3], fa10_cout[4], y[16]);
	FA fa10_5(fa9_sum[6], fa9_cout[5], fa10_cout[4], fa10_cout[5], y[17]);
	FA fa10_6(fa9_sum[7], fa9_cout[6], fa10_cout[5], fa10_cout[6], y[18]);
	FA fa10_7(fa9_sum[8], fa9_cout[7], fa10_cout[6], fa10_cout[7], y[19]);
	FA fa10_8(and1010,fa9_cout[8], fa10_cout[7], y[21], y[20]);

endmodule
