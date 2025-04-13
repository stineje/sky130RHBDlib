module adder(
	input  [8:0] a_in,
	input  [8:0] b_in,
	output [8:0] sum
);
	wire n8_tree_8, n9_tree_8, n10_tree_8, n11_tree_8, n12_tree_8, n13_tree_8, n16_tree_8, n17_tree_8, n18_tree_8, n19_tree_8, n20_tree_8, n21_tree_8, n24_tree_8, n25_tree_8, n26_tree_6, n28_tree_8, n29_tree_8, n31_tree_7, n36_tree_8;
// adder_forest tree_8
	wire n3_tree_8, n4_tree_8, n5_tree_8, n6_tree_8, n7_tree_8, n32_tree_8, n33_tree_8, n34_tree_8, n35_tree_8, n37_tree_8;
    assign n29_tree_8 = a_in[1]^b_in[1];
    assign n28_tree_8 = a_in[1]&b_in[1];
    assign n25_tree_8 = a_in[2]^b_in[2];
    assign n24_tree_8 = a_in[2]&b_in[2];
    assign n21_tree_8 = a_in[3]^b_in[3];
    assign n20_tree_8 = a_in[3]&b_in[3];
    assign n17_tree_8 = a_in[4]^b_in[4];
    assign n16_tree_8 = a_in[4]&b_in[4];
    assign n13_tree_8 = a_in[5]^b_in[5];
    assign n12_tree_8 = a_in[5]&b_in[5];
    assign n9_tree_8 = a_in[6]^b_in[6];
    assign n8_tree_8 = a_in[6]&b_in[6];
    assign n5_tree_8 = a_in[7]^b_in[7];
    assign n4_tree_8 = a_in[7]&b_in[7];
    assign n32_tree_8 = n5_tree_8&n9_tree_8;
    assign n3_tree_8 = (n8_tree_8&n5_tree_8)|n4_tree_8;
    assign n7_tree_8 = n32_tree_8&n11_tree_8;
    assign n6_tree_8 = (n10_tree_8&n32_tree_8)|n3_tree_8;
    assign n11_tree_8 = n13_tree_8&n17_tree_8;
    assign n10_tree_8 = (n16_tree_8&n13_tree_8)|n12_tree_8;
    assign n19_tree_8 = n21_tree_8&n25_tree_8;
    assign n18_tree_8 = (n24_tree_8&n21_tree_8)|n20_tree_8;
    assign n33_tree_8 = (n34_tree_8&n7_tree_8)|n6_tree_8;
    assign n34_tree_8 = (n35_tree_8&n19_tree_8)|n18_tree_8;
    assign n35_tree_8 = (n36_tree_8&n29_tree_8)|n28_tree_8;
    assign n36_tree_8 = a_in[0]&b_in[0];
    assign sum[8] = n33_tree_8^n37_tree_8;
    assign n37_tree_8 = a_in[8]^b_in[8];
// adder_forest tree_7
	wire n3_tree_7, n28_tree_7, n29_tree_7, n30_tree_7, n33_tree_7;
    assign n28_tree_7 = n9_tree_8&n11_tree_8;
    assign n3_tree_7 = (n10_tree_8&n9_tree_8)|n8_tree_8;
    assign n29_tree_7 = (n30_tree_7&n28_tree_7)|n3_tree_7;
    assign n30_tree_7 = (n31_tree_7&n19_tree_8)|n18_tree_8;
    assign n31_tree_7 = (n36_tree_8&n29_tree_8)|n28_tree_8;
    assign sum[7] = n29_tree_7^n33_tree_7;
    assign n33_tree_7 = a_in[7]^b_in[7];
// adder_forest tree_6
	wire n25_tree_6, n29_tree_6;
    assign n25_tree_6 = (n26_tree_6&n11_tree_8)|n10_tree_8;
    assign n26_tree_6 = (n31_tree_7&n19_tree_8)|n18_tree_8;
    assign sum[6] = n25_tree_6^n29_tree_6;
    assign n29_tree_6 = a_in[6]^b_in[6];
// adder_forest tree_5
	wire n20_tree_5, n24_tree_5;
    assign n20_tree_5 = (n26_tree_6&n17_tree_8)|n16_tree_8;
    assign sum[5] = n20_tree_5^n24_tree_5;
    assign n24_tree_5 = a_in[5]^b_in[5];
// adder_forest tree_4
	wire n20_tree_4;
    assign sum[4] = n26_tree_6^n20_tree_4;
    assign n20_tree_4 = a_in[4]^b_in[4];
// adder_forest tree_3
	wire n12_tree_3, n15_tree_3;
    assign n12_tree_3 = (n31_tree_7&n25_tree_8)|n24_tree_8;
    assign sum[3] = n12_tree_3^n15_tree_3;
    assign n15_tree_3 = a_in[3]^b_in[3];
// adder_forest tree_2
	wire n10_tree_2;
    assign sum[2] = n31_tree_7^n10_tree_2;
    assign n10_tree_2 = a_in[2]^b_in[2];
// adder_forest tree_1
	wire n5_tree_1;
    assign sum[1] = n36_tree_8^n5_tree_1;
    assign n5_tree_1 = a_in[1]^b_in[1];
// adder_forest tree_0
	wire n1_tree_0;
	assign sum[0] = n1_tree_0;
    assign n1_tree_0 = a_in[0]^b_in[0];
endmodule // adder
