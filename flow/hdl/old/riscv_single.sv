// riscvsingle.sv

// RISC-V single-cycle processor
// From Section 7.6 of Digital Design & Computer Architecture
// 27 April 2020
// David_Harris@hmc.edu 
// Sarah.Harris@unlv.edu

// run 210
// Expect simulator to print "Simulation succeeded"
// when the value 25 (0x19) is written to address 100 (0x64)

//   Instruction  opcode    funct3    funct7
//   add          0110011   000       0000000
//   sub          0110011   000       0100000
//   and          0110011   111       0000000
//   or           0110011   110       0000000
//   slt          0110011   010       0000000
//   addi         0010011   000       immediate
//   andi         0010011   111       immediate
//   ori          0010011   110       immediate
//   slti         0010011   010       immediate
//   beq          1100011   000       immediate
//   lw	          0000011   010       immediate
//   sw           0100011   010       immediate
//   jal          1101111   immediate immediate

module testbench();

   logic        clk;
   logic        reset;

   logic [31:0] WriteData;
   logic [31:0] DataAdr;
   logic        MemWrite;

   // instantiate device to be tested
   top dut(clk, reset, WriteData, DataAdr, MemWrite);

   initial
     begin
	string memfilename;
        memfilename = {"../testing/template.memfile"};
        $readmemh(memfilename, dut.imem.RAM);
        $readmemh(memfilename, dut.dmem.RAM);	
     end

   
   // initialize test
   initial
     begin
	reset <= 1; # 22; reset <= 0;
     end

   // generate clock to sequence tests
   always
     begin
	clk <= 1; # 5; clk <= 0; # 5;
     end

   // check results
   always @(negedge clk)
     begin
	if(MemWrite) begin
           if(DataAdr === 100 & WriteData === 10) begin
              $display("Simulation succeeded");
              $stop;
           end else if (DataAdr === 100 & WriteData === 17) begin
              $display("Simulation failed");
              $stop;
           end	   
	end
     end
endmodule // testbench

module riscvsingle (input  logic        clk, reset,
		    output logic [31:0] PC,
		    input  logic [31:0] Instr,
		    output logic 	MemWrite,
		    output logic [31:0] ALUResult, WriteData,
		    input  logic [31:0] ReadData);
   
   logic 				ALUSrc;
   logic 				RegWrite;
   logic 				Jump;
   logic 				Zero;
   logic 				V;
   logic 				Neg;   
   logic [1:0] 				ResultSrc;
   logic [2:0] 				ImmSrc;
   logic [3:0] 				ALUControl;
   logic [3:0] 				Flags;
   logic [2:0] 				LoadType;
   logic [1:0]				StoreType;
   logic 				PCTargetSrc;      
   
   controller c (Instr[6:0], Instr[14:12], Instr[30], 
		 Flags, ResultSrc, MemWrite, PCSrc,
		 ALUSrcA, ALUSrcB, RegWrite, Jump,
		 ImmSrc, ALUControl, LoadType, StoreType, PCTargetSrc);
   datapath dp (clk, reset, ResultSrc, PCSrc,
		ALUSrcA, ALUSrcB, PCTargetSrc, RegWrite,
		ImmSrc, ALUControl, LoadType, StoreType,
		Flags, PC, Instr, ALUResult, WriteData, ReadData);
   
endmodule // riscvsingle

module controller (input  logic [6:0] op,
		   input logic [2:0]  funct3,
		   input logic 	      funct7b5,
		   input logic [3:0]  Flags,
		   output logic [1:0] ResultSrc,
		   output logic       MemWrite,
		   output logic       PCSrc, ALUSrcA, ALUSrcB,
		   output logic       RegWrite, Jump,
		   output logic [2:0] ImmSrc,
		   output logic [3:0] ALUControl,
		   output logic [2:0] LoadType,
		   output logic [1:0] StoreType,
		   output logic       PCTargetSrc);
   
   logic [1:0] 			      ALUOp;
   logic 			      Branch;
   logic 			      branchtaken;   

   maindec md (op, ResultSrc, MemWrite, Branch,
	       ALUSrcA, ALUSrcB, RegWrite, Jump, ImmSrc, ALUOp, PCTargetSrc);
   aludec ad (op[5], funct3, funct7b5, ALUOp, ALUControl);
   lsu lsu (funct3, LoadType, StoreType);   
   bu branchunit (Branch, Flags, funct3, branchtaken);
   assign PCSrc = branchtaken | Jump;   
   
endmodule // controller

module bu (input logic       Branch,
	   input logic [3:0] Flags,
	   input logic [2:0] funct3,
	   output logic      taken);

   logic 		     v, c, n, z;
   logic 		     cond;
   
   assign {v, c, n, z} = Flags;
   assign taken = cond & Branch;
   always_comb
     case (funct3)
       3'b000: cond = z;         // beq
       3'b001: cond = ~z;        // bne
       3'b100: cond = (n ^ v);   // blt
       3'b101: cond = ~(n ^ v);  // bge 
       3'b110: cond = ~c;        // bltu
       3'b111: cond = c;         // bgeu
       default: cond = 1'b0;
     endcase // case (funct3)    

endmodule // bu

module maindec (input  logic [6:0] op,
		output logic [1:0] ResultSrc,
		output logic 	   MemWrite,
		output logic 	   Branch, ALUSrcA, ALUSrcB,
		output logic 	   RegWrite, Jump,
		output logic [2:0] ImmSrc,
		output logic [1:0] ALUOp,
		output logic       PCTargetSrc);
   
   logic [13:0] 		   controls;
   
   assign {RegWrite, ImmSrc, ALUSrcA, ALUSrcB, MemWrite,
	   ResultSrc, Branch, ALUOp, Jump, PCTargetSrc} = controls;
   
   always_comb
     case(op)
       // RegWrite_ImmSrc_ALUSrcA_ALUSrcB_MemWrite_ResultSrc_Branch_ALUOp_Jump_PCTargetSrc
       7'b0000011: controls = 14'b1_000_0_1_0_01_0_00_0_x; // lw
       7'b0100011: controls = 14'b0_001_0_1_1_00_0_00_0_x; // sw
       7'b0110011: controls = 14'b1_xxx_0_0_0_00_0_10_0_x; // R–type
       7'b1100011: controls = 14'b0_010_0_0_0_00_1_01_0_0; // B-type
       7'b0010011: controls = 14'b1_000_0_1_0_00_0_10_0_x; // I–type ALU
       7'b1101111: controls = 14'b1_011_x_0_0_10_0_00_1_0; // jal
       7'b0110111: controls = 14'b1_100_1_1_0_00_0_00_0_x; // lui       
       7'b0010111: controls = 14'b1_100_x_x_0_11_0_xx_0_0; // auipc
       7'b1100111: controls = 14'b1_000_0_1_0_10_0_00_1_1; // jalr
       default: controls = 14'bx_xxx_x_x_x_xx_x_xx_x_x;    // ???
     endcase // case (op)
   
endmodule // maindec

module aludec (input  logic       opb5,
	       input  logic [2:0] funct3,
	       input  logic 	  funct7b5,
	       input  logic [1:0] ALUOp,
	       output logic [3:0] ALUControl);
   
   logic 			  RtypeSub;
   
   assign RtypeSub = funct7b5 & opb5; // TRUE for R–type subtract
   always_comb
     case(ALUOp)
       2'b00: ALUControl = 4'b0000; // addition
       2'b01: ALUControl = 4'b0001; // subtraction
       default: case(funct3) // R–type or I–type ALU
		  3'b000: if (RtypeSub)
		    ALUControl = 4'b0001; // sub
		  else
		    ALUControl = 4'b0000; // add, addi
		  3'b001: ALUControl = 4'b0110; // sll, slli		  
		  3'b010: ALUControl = 4'b0101; // slt, slti
		  3'b011: ALUControl = 4'b1001; // sltu, sltiu
		  3'b100: ALUControl = 4'b0100; // xor, xori		  
		  3'b101: 
		    if (funct7b5)
		      ALUControl = 4'b1000;     // sra, srai
		    else
		      ALUControl = 4'b0111;     // srl, srli		    
		  3'b110: ALUControl = 4'b0011; // or, ori
		  3'b111: ALUControl = 4'b0010; // and, andi
		  default: ALUControl = 3'bxxx; // ???
		endcase // case (funct3)       
     endcase // case (ALUOp)
   
endmodule // aludec

module lsu (input  logic [2:0] funct3,
	    output logic [2:0] LoadType,
	    output logic [1:0] StoreType);

   always_comb
     case(funct3)
       3'b000:     {LoadType, StoreType} = {3'b010, 2'b01}; // LB
       3'b001:     {LoadType, StoreType} = {3'b011, 2'b10}; // LH
       3'b010:     {LoadType, StoreType} = {3'b000, 2'b00}; // LW
       3'b101:     {LoadType, StoreType} = {3'b100, 2'bxx}; // LHU      
       3'b100:     {LoadType, StoreType} = {3'b001, 2'bxx}; // LBU
       default:    {LoadType, StoreType} = 5'bxxxxx;
     endcase // case (funct3)   

endmodule // lsu
   
module datapath (input  logic        clk, reset,
		 input  logic [1:0]  ResultSrc,
		 input  logic 	     PCSrc, ALUSrcA, ALUSrcB,
		 input  logic 	     PCTargetSrc,
		 input  logic 	     RegWrite,
		 input  logic [2:0]  ImmSrc,
		 input  logic [3:0]  ALUControl,
		 input  logic [2:0]  LoadType,
		 input  logic [1:0]  StoreType,
		 output logic [3:0]  Flags,
		 output logic [31:0] PC,
		 input logic [31:0]  Instr,
		 output logic [31:0] ALUResult, WriteData,
		 input logic [31:0]  ReadData);

   logic [31:0] 		     RD1;
   logic [31:0] 		     RD2;   
   logic [31:0] 		     PCNext, PCPlus4;
   logic [31:0] 		     PCRelativeTarget;   
   logic [31:0] 		     PCTarget;
   logic [31:0] 		     ImmExt;
   logic [31:0] 		     SrcA, SrcB;
   logic [31:0] 		     Result;
   logic [31:0] 		     ZeroExtendByte;
   logic [31:0] 		     SignExtendByte;
   logic [31:0] 		     ZeroExtendWord;      
   logic [31:0] 		     SignExtendWord;   
   logic [31:0] 		     ReadDataOut;   
   logic [7:0] 			     byteout;
   logic [15:0] 		     halfwordout;
   
   // next PC logic
   flopr #(32) pcreg (clk, reset, PCNext, PC);
   adder  pcadd4 (PC, 32'd4, PCPlus4);
   adder  pcaddbranch (PC, ImmExt, PCRelativeTarget);
   // jalr logic
   mux2 #(32)  jalrmux (PCRelativeTarget, ALUResult, PCTargetSrc, PCTarget);      
   mux2 #(32)  pcmux (PCPlus4, PCTarget, PCSrc, PCNext);   
   // register file logic
   regfile  rf (clk, RegWrite, Instr[19:15], Instr[24:20],
	       Instr[11:7], Result, RD1, RD2);
   extend  ext (Instr[31:7], ImmSrc, ImmExt);
   // ALU logic
   mux2 #(32)  srcamux (RD1, 32'h0, ALUSrcA, SrcA);   
   mux2 #(32)  srcbmux (RD2, ImmExt, ALUSrcB, SrcB);
   alu  alu (SrcA, SrcB, ALUControl, ALUResult, Flags);
   mux4 #(32) resultmux (ALUResult, ReadDataOut, PCPlus4, PCTarget, ResultSrc, Result);

   // Handle lb/lh
   mux4 #(8) bytesel (ReadData[7:0], ReadData[15:8], ReadData[23:16], ReadData[31:24],
		      ALUResult[1:0], byteout);
   mux2 #(16) wordsel (ReadData[15:0], ReadData[31:16], ALUResult[1], halfwordout);   
   zeroextend #(8) zeb (byteout, ZeroExtendByte);
   signextend #(8) seb (byteout, SignExtendByte);
   zeroextend #(16) zew (halfwordout, ZeroExtendWord);   
   signextend #(16) sew (halfwordout, SignExtendWord);
   mux5 #(32) readdatamux (ReadData, ZeroExtendByte, SignExtendByte, SignExtendWord, ZeroExtendWord, 
			   LoadType, ReadDataOut);   
   // Handle sb/sh
   wdunit wdu (RD2, ReadData, StoreType, ALUResult[1:0], WriteData);   

endmodule // datapath

module adder (input  logic [31:0] a, b,
	      output logic [31:0] y);
   
   assign y = a + b;
   
endmodule

module extend (input  logic [31:7] instr,
	       input  logic [2:0]  immsrc,
	       output logic [31:0] immext);
   
   always_comb
     case(immsrc)
       // I−type
       3'b000:  immext = {{20{instr[31]}}, instr[31:20]};
       // S−type (stores)
       3'b001:  immext = {{20{instr[31]}}, instr[31:25], instr[11:7]};
       // B−type (branches)
       3'b010:  immext = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};       
       // J−type (jal)
       3'b011:  immext = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
       // U−type (jalr) 
       3'b100:  immext = {instr[31:12], 12'h0};       
       default: immext = 32'bx; // undefined
     endcase // case (immsrc)
   
endmodule // extend

module flopr #(parameter WIDTH = 8)
   (input  logic             clk, reset,
    input logic [WIDTH-1:0]  d,
    output logic [WIDTH-1:0] q);
   
   always_ff @(posedge clk, posedge reset)
     if (reset) q <= 0;
     else  q <= d;
   
endmodule // flopr

module flopenr #(parameter WIDTH = 8)
   (input  logic             clk, reset, en,
    input logic [WIDTH-1:0]  d,
    output logic [WIDTH-1:0] q);
   
   always_ff @(posedge clk, posedge reset)
     if (reset)  q <= 0;
     else if (en) q <= d;
   
endmodule // flopenr

module mux2 #(parameter WIDTH = 8)
   (input  logic [WIDTH-1:0] d0, d1,
    input logic 	     s,
    output logic [WIDTH-1:0] y);
   
  assign y = s ? d1 : d0;
   
endmodule // mux2

module mux3 #(parameter WIDTH = 8)
   (input  logic [WIDTH-1:0] d0, d1, d2,
    input logic [1:0] 	     s,
    output logic [WIDTH-1:0] y);
   
  assign y = s[1] ? d2 : (s[0] ? d1 : d0);
   
endmodule // mux3

module mux4 #(parameter WIDTH = 8) (
  input  logic [WIDTH-1:0] d0, d1, d2, d3,
  input  logic [1:0]       s, 
  output logic [WIDTH-1:0] y);

  assign y = s[1] ? (s[0] ? d3 : d2) : (s[0] ? d1 : d0); 

endmodule // mux4

module mux5 #(parameter WIDTH = 8) (
  input  logic [WIDTH-1:0] d0, d1, d2, d3, d4,
  input  logic [2:0]       s, 
  output logic [WIDTH-1:0] y);

  assign y = s[2] ? d4 : (s[1] ? (s[0] ? d3 : d2) : (s[0] ? d1 : d0)); 
endmodule

module top (input  logic        clk, reset,
	    output logic [31:0] WriteData, DataAdr,
	    output logic 	MemWrite);
   
   logic [31:0] 		PC, Instr, ReadData;
   
   // instantiate processor and memories
   riscvsingle rv32single (clk, reset, PC, Instr, MemWrite, DataAdr,
			   WriteData, ReadData);
   imem imem (PC, Instr);
   dmem dmem (clk, MemWrite, DataAdr, WriteData, ReadData);
   
endmodule // top

module imem (input  logic [31:0] a,
	     output logic [31:0] rd);
   
   logic [31:0] 		 RAM[2047:0];
   
   assign rd = RAM[a[31:2]]; // word aligned
   
endmodule // imem

module dmem (input  logic        clk, we,
	     input  logic [31:0] a, wd,
	     output logic [31:0] rd);
   
   logic [31:0] 		 RAM[8191:0];
   
   assign rd = RAM[a[31:2]]; // word aligned
   always_ff @(posedge clk)
     if (we) RAM[a[31:2]] <= wd;
   
endmodule // dmem

module alu (input  logic [31:0] a, b,
            input logic  [3:0] 	alucontrol,
            output logic [31:0] result,
            output logic [3:0] 	flags);

   logic [31:0] 		condinvb, sum;   
   logic 			v, c, n, z;
   logic 			Asign, Bsign;
   logic 			Neg;   
   logic 			LT, LTU;   
   logic 			cout;
   logic 			isAddSub;       // true when is add or subtract operation

   assign flags = {v, c, n, z};   
   assign condinvb = alucontrol[0] ? ~b : b;
   assign {cout, sum} = a + condinvb + alucontrol[0];
   assign isAddSub = (~alucontrol[3] & ~alucontrol[2] & ~alucontrol[1]) |
                     (~alucontrol[3] & ~alucontrol[1] & alucontrol[0]);
   assign Asign = a[31];
   assign Bsign = b[31];
   assign Neg  = sum[31];   
   assign LT = Asign & ~Bsign | Asign & Neg | ~Bsign & Neg; 
   assign LTU = ~cout;   

   always_comb
     case (alucontrol)
       4'b0000:  result = sum;                  // add
       4'b0001:  result = sum;                  // subtract
       4'b0010:  result = a & b;                // and
       4'b0011:  result = a | b;                // or
       4'b0100:  result = a ^ b;                // xor       
       4'b0101:  result = {{31{1'b0}}, LT};     // slt
       4'b1001:  result = {{31{1'b0}}, LTU};    // sltu       
       4'b0110:  result = a << b[4:0];          // sll
       4'b0111:  result = a >> b[4:0];          // srl
       4'b1000: result = $signed(a) >>> b[4:0]; // sra        
       default: result = 32'bx;
     endcase

   assign z = (result == 32'b0);
   assign n = result[31];
   assign c = cout & isAddSub;   
   assign v = ~(alucontrol[0] ^ a[31] ^ b[31]) & (a[31] ^ sum[31]) & isAddSub;
   
endmodule // alu

module zeroextend #(parameter WIDTH = 8)
   (input  logic [WIDTH-1:0] a,
    output logic [31:0] zeroimmext);

   assign zeroimmext = {{{32-WIDTH}{1'b0}}, a};

endmodule // zeroextend

module signextend #(parameter WIDTH = 8)
   (input  logic [WIDTH-1:0] a,
    output logic [31:0] signext);

   assign signext = {{{32-WIDTH}{a[WIDTH-1]}}, a};

endmodule // signextend

module regfile (input  logic        clk, 
		input  logic 	    we3, 
		input  logic [4:0]  a1, a2, a3, 
		input  logic [31:0] wd3, 
		output logic [31:0] rd1, rd2);

   logic [31:0] 		    rf[31:0];

   // three ported register file
   // read two ports combinationally (A1/RD1, A2/RD2)
   // write third port on rising edge of clock (A3/WD3/WE3)
   // register 0 hardwired to 0

   always_ff @(posedge clk)
     if (we3) rf[a3] <= wd3;	

   assign rd1 = (a1 != 0) ? rf[a1] : 0;
   assign rd2 = (a2 != 0) ? rf[a2] : 0;
   
endmodule // regfile

module wdunit (input  logic [31:0] rd2, 
	       input  logic [31:0] readdata,
	       input  logic [1:0]  StoreType,
	       input  logic [1:0]  byteoffset,
	       output logic [31:0] WriteData);
   
   logic [31:0] 		   storeb0;
   logic [31:0] 		   storeb1;
   logic [31:0] 		   storeb2;
   logic [31:0] 		   storeb3;
   logic [31:0] 		   storeh0;
   logic [31:0] 		   storeh1;   
   logic [31:0] 		   sbword;
   logic [31:0] 		   shword;

   assign storeb0 = {readdata[31:8], rd2[7:0]};
   assign storeb1 = {readdata[31:16], rd2[7:0], readdata[7:0]};
   assign storeb2 = {readdata[31:24], rd2[7:0], readdata[15:0]};
   assign storeb3 = {rd2[7:0], readdata[31:8]};

   assign storeh0 = {readdata[31:16], rd2[15:0]};
   assign storeh1 = {rd2[15:0], readdata[31:16]};

   mux4 #(32) sbmux (storeb0, storeb1, storeb2, storeb3, byteoffset, sbword);
   mux2 #(32) shmux (storeh0, storeh1, byteoffset[1], shword);   
   mux3 #(32) wdmux (rd2, sbword, shword, StoreType, WriteData);     
   
endmodule // wdunit

