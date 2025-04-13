module aludec (input            funct7b,
	       input [2:0] 	funct3,
               input [2:0] 	aluop,
               output reg [2:0] alucontrol,
	       output reg [1:0] shtype,
	       output reg 	alu2src,
	       output reg 	sltunsigned);

   wire [3:0] 			aluop2;

   // Logic works because we don't have XORI
   assign aluop2 = {(funct3[2]|funct3[0])&!funct3[1],aluop};

   always @(*)
     case(aluop2)
       4'b1000:
	 // slli / srli / srai
         begin
            case({funct7b, funct3})
              // slli
              4'b0001: 
		begin
		   alucontrol <= 3'b010; 
		   shtype <= 2'b00;
		   alu2src <= 1'b1;
		   sltunsigned <= 1'b0;
		end
              // srli
              4'b0101:
		begin
		   alucontrol <= 3'b010; 
		   shtype <= 2'b01;
		   alu2src <= 1'b1;
		   sltunsigned <= 1'b0;
		end
              // srai
              4'b1101:
		begin
                   alucontrol <= 3'b010;
                   shtype <= 2'b10;
                   alu2src <= 1'b1;
		   sltunsigned <= 1'b0;
		end
	      default:
		begin
                   alucontrol <= 3'b000;
                   shtype <= 2'b00;
                   alu2src <= 1'b0;
		   sltunsigned <= 1'b0;
		end
            endcase
         end // case: 4'b1000
       // lw/sw
       4'b0100:
	 begin
            alucontrol <= 3'b010; 
            shtype <= 2'b00;
            alu2src <= 1'b0;
	    sltunsigned <= 1'b0;
	 end
       // immediate
       4'b0000:
         begin
            case(funct3)
              // ANDI
              3'b111:
		begin
                   alucontrol <= 3'b000;
                   shtype <= 2'b00;
                   alu2src <= 1'b0;
		   sltunsigned <= 1'b0;
		end
              // ORI
              3'b110:
		begin
                   alucontrol <= 3'b001;
                   shtype <= 2'b00;
                   alu2src <= 1'b0;
		   sltunsigned <= 1'b0;
		end
              //slti
              3'b010:
		begin
                   alucontrol <= 3'b111;
                   alu2src <= 1'b0;
                   shtype <= 2'b00;
                   sltunsigned <= 1'b0;
		end
              // sltiu
              3'b011:
		begin
                   alucontrol <= 3'b111;
                   alu2src <= 1'b0;
                   shtype <= 2'b00;
                   sltunsigned <= 1'b1;
		end
              // Handle other immediates
              default: 
		begin
		   alucontrol <= 3'b010; 
		   shtype <= 2'b00;
		   alu2src <= 1'b0;
		   sltunsigned <= 1'b0;
		end
            endcase
         end
       default:
	 // R-type
	 case({funct7b, funct3})
	   // add
	   4'b0000: 
	     begin
	        alucontrol <= 3'b010;     
	        alu2src <= 1'b0;
  		shtype <= 2'b00;
		sltunsigned <= 1'b0;
	     end
	   // sll
	   4'b0001: 
	     begin
	        alucontrol <= 3'b010;     
		alu2src <= 1'b1;
  	        shtype <= 2'b00;
		sltunsigned <= 1'b0;
	     end
	   // srl
	   4'b0101: 
	     begin
	        alucontrol <= 3'b010;     
	        alu2src <= 1'b1;
  	        shtype <= 2'b01;
		sltunsigned <= 1'b0;
	     end
	   // sra
	   4'b1101: 
	     begin
	        alucontrol <= 3'b010;     
	        alu2src <= 1'b1;
  	        shtype <= 2'b10;
		sltunsigned <= 1'b0;
	     end
	   // sub
	   4'b1000:
	     begin
	        alucontrol <= 3'b110;     
	        alu2src <= 1'b0;
  		shtype <= 2'b00;	       
		sltunsigned <= 1'b0;
	     end
	   // and
	   4'b0111:
	     begin
	        alucontrol <= 3'b000;     
	        alu2src <= 1'b0;
  	        shtype <= 2'b00;	       
		sltunsigned <= 1'b0;
	     end
	   // or
	   4'b0110: 
	     begin
	        alucontrol <= 3'b001;     
	        alu2src <= 1'b0;
  	        shtype <= 2'b00;	       
		sltunsigned <= 1'b0;
	     end
	   // slt
	   4'b0010:
	     begin
	        alucontrol <= 3'b111;     
	        alu2src <= 1'b0;
  	        shtype <= 2'b00;	       
		sltunsigned <= 1'b0;
	     end
	   // sltu
	   4'b0011:
	     begin
	        alucontrol <= 3'b111;     
	        alu2src <= 1'b0;
  	        shtype <= 2'b00;	       
		sltunsigned <= 1'b1;
	     end
	   // ???
	   default:
	     begin
	        alucontrol <= 3'b000;     
	        alu2src <= 1'b0;
	        shtype <= 2'b00;
		sltunsigned <= 1'b0;
	     end
	 endcase
     endcase // case (aluop)

endmodule // aludec
