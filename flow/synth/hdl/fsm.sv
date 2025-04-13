module fsm (done, load_rega, load_regb, load_regc, 
	    load_regd, load_regr, load_regs,
	    sel_muxa, sel_muxb, sel_muxr, 
	    clk, reset, start, error, op_type);

   input logic 	      clk;
   input logic 	      reset;
   input logic 	      start;
   input logic 	      error;
   input logic 	      op_type;
   
   output logic       done;      
   output logic       load_rega;
   output logic       load_regb;
   output logic       load_regc;
   output logic       load_regd;   
   output logic       load_regr;
   output logic       load_regs;
   
   output logic [2:0] sel_muxa;
   output logic [2:0] sel_muxb;
   output logic       sel_muxr;
   
   typedef enum       logic [4:0] {IDLE, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, 
	                           S11, S12, S13, S14, S15, S16, S17, S18, S19, 
				   S20, S21, S22, S23, S24, S25, S26, S27, S28, S29, 
				   S30, S31} statetype;
   statetype state, nextstate;
   
   always_ff @(posedge clk)
     begin
	if(reset==1'b1)
	  state <= IDLE;
	else
	  state <= nextstate;
     end

   // Idle : S0 -> S0
   // DP: (DIV) S0 -> S1 -> S10 (10 cycles)
   // DP: (SQRT) S0 -> S13 -> S26
   always_comb
     begin
 	case(state)
	  IDLE:  // iteration 0
	    begin
	       if (start==1'b0)
		 begin
		    done = 1'b0;
		    load_rega = 1'b0;
		    load_regb = 1'b0;
		    load_regc = 1'b0;
		    load_regd = 1'b0;
		    load_regr = 1'b0;
		    load_regs = 1'b0;
		    sel_muxa = 3'b000;
		    sel_muxb = 3'b000;
		    sel_muxr = 1'b0;
		    nextstate <= IDLE;
		 end 
	       else if (start==1'b1 && op_type==1'b0) 
		 begin
		    done = 1'b0;
		    load_rega = 1'b0;
		    load_regb = 1'b1;
		    load_regc = 1'b0;
		    load_regd = 1'b0;		    
		    load_regr = 1'b0;
		    load_regs = 1'b0;		    		    
		    sel_muxa = 3'b001;
		    sel_muxb = 3'b001;		    
		    sel_muxr = 1'b0;
		    nextstate <= S1;
		 end // if (start==1'b1 && op_type==1'b0)
	       else if (start==1'b1 && op_type==1'b1) 
		 begin
		    done = 1'b0;
		    load_rega = 1'b0;
		    load_regb = 1'b1;
		    load_regc = 1'b0;
		    load_regd = 1'b0;		    
		    load_regr = 1'b0;
		    load_regs = 1'b0;		    		    
		    sel_muxa = 3'b010;
		    sel_muxb = 3'b000;		    
		    sel_muxr = 1'b0;
		    nextstate <= S13;
		 end 	       
	    end // case: S0
	  S1:
	    begin
	       done = 1'b0;
	       load_rega = 1'b1;
	       load_regb = 1'b0;
	       load_regc = 1'b1;
	       load_regd = 1'b0;
	       load_regr = 1'b0;
	       load_regs = 1'b0;		    	       
	       sel_muxa = 3'b010;
	       sel_muxb = 3'b000;		    
	       sel_muxr = 1'b0;	
	       nextstate <= S2;
	    end	  
	  S2: // iteration 1
	    begin
	       done = 1'b0;
	       load_rega = 1'b0;
	       load_regb = 1'b1;
	       load_regc = 1'b0;
	       load_regd = 1'b0;
	       load_regr = 1'b0;
	       load_regs = 1'b0;		    	       
	       sel_muxa = 3'b011;
	       sel_muxb = 3'b011;
	       sel_muxr = 1'b0;
	       nextstate <= S3;
	    end
	  S3:
	    begin
	       done = 1'b0;
	       load_rega = 1'b1;
	       load_regb = 1'b0;
	       load_regc = 1'b1;
	       load_regd = 1'b0;
	       load_regr = 1'b0;
	       load_regs = 1'b0;		    	       
	       sel_muxa = 3'b000;
	       sel_muxb = 3'b010;
	       sel_muxr = 1'b0;
	       nextstate <= S4;
	    end
	  S4: // iteration 2
	    begin
	       done = 1'b0;
	       load_rega = 1'b0;
	       load_regb = 1'b1;
	       load_regc = 1'b0;
	       load_regd = 1'b0;
	       load_regr = 1'b0;
	       load_regs = 1'b0;		    	       
	       sel_muxa = 3'b011;
	       sel_muxb = 3'b011;
	       sel_muxr = 1'b0;
	       nextstate <= S5;
	    end
	  S5:
	    begin
	       done = 1'b0;
	       load_rega = 1'b1;
	       load_regb = 1'b0;
	       load_regc = 1'b1;
	       load_regd = 1'b0;
	       load_regr = 1'b0;
	       load_regs = 1'b0;
	       sel_muxa = 3'b000;
	       sel_muxb = 3'b010;
	       sel_muxr = 1'b0;  // add
	       nextstate <= S6;
	    end
	  S6: // iteration 3
	    begin
	       done = 1'b0;
	       load_rega = 1'b0;
	       load_regb = 1'b1;
	       load_regc = 1'b0;
	       load_regd = 1'b0;
	       load_regr = 1'b0;
	       load_regs = 1'b0;
	       sel_muxa = 3'b011;
	       sel_muxb = 3'b011;
	       sel_muxr = 1'b0;
	       nextstate <= S8;
	    end
	  S7:
	    begin
	       done = 1'b0;
	       load_rega = 1'b1;
	       load_regb = 1'b0;
	       load_regc = 1'b1;
	       load_regd = 1'b0;
	       load_regr = 1'b0;
	       load_regs = 1'b0;
	       sel_muxa = 3'b000;
	       sel_muxb = 3'b010;
	       sel_muxr = 1'b0;
	       nextstate <= S8;
	    end // case: S7
	  S8: // q,qm,qp
	    begin
	       done = 1'b0;
	       load_rega = 1'b0;
	       load_regb = 1'b0;
	       load_regc = 1'b0;
	       load_regd = 1'b0;
	       load_regr = 1'b0;
	       load_regs = 1'b1;		    	       
	       sel_muxa = 3'b000;
	       sel_muxb = 3'b000;
	       sel_muxr = 1'b0;
	       nextstate <= S9;
	    end 
	  S9:  // rem
	    begin
	       done = 1'b0;
	       load_rega = 1'b0;
	       load_regb = 1'b0;
	       load_regc = 1'b0;
	       load_regd = 1'b0;	       
	       load_regr = 1'b1;
	       load_regs = 1'b0;  
	       sel_muxa = 3'b000;
	       sel_muxb = 3'b000;
	       sel_muxr = 1'b1;
	       nextstate <= S10;
	    end 	  
	  S10:  // done
	    begin
	       done = 1'b1;
	       load_rega = 1'b0;
	       load_regb = 1'b0;
	       load_regc = 1'b0;
	       load_regd = 1'b0;	       
	       load_regr = 1'b0;
	       load_regs = 1'b0;		    	       
	       sel_muxa = 3'b000;
	       sel_muxb = 3'b000;
	       sel_muxr = 1'b0;
	       nextstate <= IDLE;
	    end 
	  S13:  // start of sqrt path
	    begin
	       done = 1'b0;
	       load_rega = 1'b0;
	       load_regb = 1'b0;
	       load_regc = 1'b0;
	       load_regd = 1'b1;	       
	       load_regr = 1'b0;
	       load_regs = 1'b0;
	       sel_muxa = 3'b010;
	       sel_muxb = 3'b001;
	       sel_muxr = 1'b0;
	       nextstate <= S14;
	    end
	  S14:  
	    begin
	       done = 1'b0;
	       load_rega = 1'b1;
	       load_regb = 1'b0;
	       load_regc = 1'b1;
	       load_regd = 1'b0;
	       load_regr = 1'b0;
	       load_regs = 1'b0;		    	       
	       sel_muxa = 3'b001;
	       sel_muxb = 3'b100;
	       sel_muxr = 1'b0;
	       nextstate <= S15;
	    end 
	  S15:  // iteration 1
	    begin
	       done = 1'b0;
	       load_rega = 1'b0;
	       load_regb = 1'b1;
	       load_regc = 1'b0;
	       load_regd = 1'b0;	       
	       load_regr = 1'b0;
	       load_regs = 1'b0;		    	       
	       sel_muxa = 3'b011;
	       sel_muxb = 3'b011;
	       sel_muxr = 1'b0;
	       nextstate <= S16;
	    end
	  S16:  
	    begin
	       done = 1'b0;
	       load_rega = 1'b0;
	       load_regb = 1'b0;
	       load_regc = 1'b0;
	       load_regd = 1'b1;	       
	       load_regr = 1'b0;
	       load_regs = 1'b0;		    	       
	       sel_muxa = 3'b000;
	       sel_muxb = 3'b011;
	       sel_muxr = 1'b0;
	       nextstate <= S17;
	    end
	  S17:  
	    begin
	       done = 1'b0;
	       load_rega = 1'b1;
	       load_regb = 1'b0;
	       load_regc = 1'b1;
	       load_regd = 1'b0;	       
	       load_regr = 1'b0;
	       load_regs = 1'b0;		    	       
	       sel_muxa = 3'b100;
	       sel_muxb = 3'b010;
	       sel_muxr = 1'b0;
	       nextstate <= S18;
	    end
	  S18:  // iteration 2
	    begin
	       done = 1'b0;
	       load_rega = 1'b0;
	       load_regb = 1'b1;
	       load_regc = 1'b0;
	       load_regd = 1'b0;	       
	       load_regr = 1'b0;
	       load_regs = 1'b0;		    	       
	       sel_muxa = 3'b011;
	       sel_muxb = 3'b011;
	       sel_muxr = 1'b0;
	       nextstate <= S19;
	    end
	  S19:  
	    begin
	       done = 1'b0;
	       load_rega = 1'b0;
	       load_regb = 1'b0;
	       load_regc = 1'b0;
	       load_regd = 1'b1;	       
	       load_regr = 1'b0;
	       load_regs = 1'b0;		    	       
	       sel_muxa = 3'b000;
	       sel_muxb = 3'b011;
	       sel_muxr = 1'b0;
	       nextstate <= S20;
	    end
	  S20:  
	    begin
	       done = 1'b0;
	       load_rega = 1'b1;
	       load_regb = 1'b0;
	       load_regc = 1'b1;
	       load_regd = 1'b0;	       
	       load_regr = 1'b0;
	       load_regs = 1'b0;		    	       
	       sel_muxa = 3'b100;
	       sel_muxb = 3'b010;
	       sel_muxr = 1'b0;
	       nextstate <= S21;
	    end
	  S21:  // iteration 3
	    begin
	       done = 1'b0;
	       load_rega = 1'b0;
	       load_regb = 1'b1;
	       load_regc = 1'b0;
	       load_regd = 1'b0;	       
	       load_regr = 1'b0;
	       load_regs = 1'b0;		    	       
	       sel_muxa = 3'b011;
	       sel_muxb = 3'b011;
	       sel_muxr = 1'b0;
	       nextstate <= S22;
	    end
	  S22:  
	    begin
	       done = 1'b0;
	       load_rega = 1'b0;
	       load_regb = 1'b0;
	       load_regc = 1'b0;
	       load_regd = 1'b1;
	       load_regr = 1'b0;
	       load_regs = 1'b0;
	       sel_muxa = 3'b000;
	       sel_muxb = 3'b011;
	       sel_muxr = 1'b0;
	       nextstate <= S23;
	    end
	  S23:  
	    begin
	       done = 1'b0;
	       load_rega = 1'b1;
	       load_regb = 1'b0;
	       load_regc = 1'b1;
	       load_regd = 1'b0;	       
	       load_regr = 1'b0;
	       load_regs = 1'b0;		    	       
	       sel_muxa = 3'b100;
	       sel_muxb = 3'b010;
	       sel_muxr = 1'b0;
	       nextstate <= S24;
	    end 
	  S24: // q,qm,qp
	    begin
	       done = 1'b0;
	       load_rega = 1'b0;
	       load_regb = 1'b0;
	       load_regc = 1'b0;
	       load_regd = 1'b0;
	       load_regr = 1'b0;
	       load_regs = 1'b1;		    	       
	       sel_muxa = 3'b000;
	       sel_muxb = 3'b000;
	       sel_muxr = 1'b0;
	       nextstate <= S25;
	    end 	  
	  S25:  // rem
	    begin
	       done = 1'b0;
	       load_rega = 1'b0;
	       load_regb = 1'b0;
	       load_regc = 1'b0;
	       load_regd = 1'b0;	       
	       load_regr = 1'b1;
	       load_regs = 1'b0;  
	       sel_muxa = 3'b011;
	       sel_muxb = 3'b110;
	       sel_muxr = 1'b1;
	       nextstate <= S26;
	    end 	  
	  S26:  // done
	    begin
	       done = 1'b1;
	       load_rega = 1'b0;
	       load_regb = 1'b0;
	       load_regc = 1'b0;
	       load_regd = 1'b0;	       
	       load_regr = 1'b0;
	       load_regs = 1'b0;		    	       
	       sel_muxa = 3'b000;
	       sel_muxb = 3'b000;
	       sel_muxr = 1'b0;
	       nextstate <= IDLE;
	    end 
	  default: 
	    begin
	       done = 1'b0;
	       load_rega = 1'b0;
	       load_regb = 1'b0;
	       load_regc = 1'b0;
	       load_regd = 1'b0;	       
	       load_regr = 1'b0;
	       load_regs = 1'b0;		    	       
	       sel_muxa = 3'b000;
	       sel_muxb = 3'b000;
	       sel_muxr = 1'b0;
	       nextstate <= IDLE;
	    end
	endcase // case(state)	
     end // always @ (state or X)   

endmodule // fsm
