module datapath(input 	      clk, reset,
		input [31:0]  instr,
		input [2:0]   imm,
		output [31:0] pc,
		output [31:0] pcnext, 
		input 	      pcsrc, pcadd, pcext,
		input 	      ISRsel,
		input [31:0]  ISR,
		input 	      unsign,
		output 	      gt, lt, eq,
		input [3:0]   alucontrol,
		input 	      alusrc, storepc, sltunsigned,
		input [1:0]   shtype,
		input 	      alu2src,
		input 	      memtoreg, regwrite,
		output [31:0] aluout, writedata,
		input [31:0]  readdata,
		input 	      suspend);

   wire [31:0] 		      pcsum, pcimm_sum, pcjalr, pctoreg;
   wire [31:0] 		      signimm, signimm2;
   wire [31:0] 		      srca, srca2, srcb;
   wire [31:0] 		      result, result2;
   wire [31:0] 		      shoutput, aluout2;
   wire [4:0] 		      rs1;
   wire 		      compA,compB;
   wire [31:0] 		      pcISRin, pcext_imm;
   wire [31:0] 		      SEPC;  

   // SEPC
   flopenr #(32) epc(.clk(clk), .reset(reset), .en(suspend), 
		     .d(pc), .q(SEPC));
   // next PC logic
   flopr #(32) pcreg(.clk(clk), .reset(reset),
                     .d(pcnext), .q(pc));
   // PC Next Adder PC+4
   adder pcadder(.a(pc), .b(32'b100), .y(pcsum));

   // need to read a zero on rs1 for lui to work.
   // this is in the decoder, not in the bit-sliced datapath
   mux2 #(5) rs1mux(.d0(instr[19:15]), .d1(5'b00000),
		    .s(imm[2]), .y(rs1));
   // register file logic
   regfile rf (.clk(clk), .we3(regwrite),
               .ra1(rs1), .ra2(instr[24:20]),
               .wa3(instr[11:7]), .wd3(result), 
	       .rd1(srca2), .rd2(writedata));

   // Sign Extension (Immediate)
   signext se(.a(instr[31:0]), .sel(imm[1:0]), .y(signimm));
   // Sign Extension (lui)
   mux2 #(32) semux(.d0(signimm), .d1({instr[31:12], 12'b0}), 
                    .s(imm[2]), .y(signimm2));   
   // Shifting immediate for PC
   mux2 #(32) pcextmux(.d0(signimm2), .d1({signimm2[30:0],1'b0}),
                       .s(pcext), .y(pcext_imm));
   
   // Branch Mux
   mux2 #(32) pcmux(.d0(pcsum), .d1(pcimm_sum), 
                    .s(pcsrc), .y(pcISRin));
   mux2 #(32) pcmux2(.d0(pcimm_sum), .d1(pcsum), 
                     .s(pcsrc), .y(pctoreg));

   // PC imm Adder PC + imm
   adder pcimm(.a(pcjalr), .b(pcext_imm), .y(pcimm_sum));
   // ISR mux
   mux2 #(32) ISRmux(.d0(pcISRin), .d1(ISR),
                     .s(ISRsel), .y(pcnext));
   // ALU PC/imm mux
   mux2 #(32) pcsrcmux(.d0(srca2), .d1(pc),
                       .s(pcadd), .y(pcjalr));

   // ALU mem/imm mux
   mux2 #(32) memsrcmux(.d0(writedata), .d1(pcext_imm),
			.s(alusrc), .y(srcb));

   // Choose whether to invert the sign bit of the comparator 
   // or not for unsigned logic change these 
   // This can be 33rd bit logic
   assign compA = srca2[31] ^ ~unsign;
   assign compB = writedata[31] ^ ~unsign; 

   // Comparator (for beq, bge, blt, beq)
   magcompare32 compare (.GT(gt), .LT(lt), .EQ(eq),
			 .A({compA, srca2[30:0]}), 
			 .B({compB, writedata[30:0]}));
   // ALU
   alu alu (.a(srca2), .b(srcb),
            .alucont(alucontrol),
            .sltunsigned(sltunsigned),
            .result(aluout2));

   // Shifter
   shifter shift (.a(srca2), .shamt(srcb[4:0]), 
		  .shtype(shtype), .y(shoutput));

   // Choose ALU or Shifter output
   mux2 #(32) srccmux(.d0(aluout2), .d1(shoutput),
                      .s(alu2src), .y(aluout));

   // Memory Output
   mux2 #(32) resmux(.d0(aluout), .d1(readdata),
                     .s(memtoreg), .y(result2));
   mux2 #(32) storepcmux(.d0(result2), .d1(pctoreg),
			 .s(storepc), .y(result));
   
endmodule // datapath
