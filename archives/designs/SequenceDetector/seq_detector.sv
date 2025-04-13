// Module: Sequence Detector
// Author: Ryan Ridley
// 
// Function: Given a serial input, d, of the sequence 0111,
//           will return 1 on the output, y.
//
//

`timescale 1ps/1ps
module seq_detector(
  input  logic d, clk, reset,

  output logic y
);

  // Creating new type for states
  typedef enum logic [1:0]
  {S0=3'b00, S1=3'b01, S2=3'b10, S3=3'b11} state_type;

  // Insansiating a current_state and next_state of type state_type
  state_type CURRENT_STATE, NEXT_STATE;

  //
  // State Registers
  always_ff @(posedge clk, posedge reset)
	begin
	  if(reset)
      CURRENT_STATE <= S0;
	  else
      CURRENT_STATE <= NEXT_STATE;
  end //always_ff@(posedge clk

  
  // Next State Logic
  always_comb
  begin

    NEXT_STATE = S0;

    // y and NEXT_STATE are always 1'b0/S0 unless otherwise specified
    case(CURRENT_STATE)
      S0:
      begin
        NEXT_STATE = (d==1'b0) ? S1 : S0;
      end // end S0

      S1:
      begin
        NEXT_STATE = (d==1'b1) ? S2 : S1;
      end // end S1
          
      S2:
      begin
        NEXT_STATE = (d==1'b1) ? S3 : S1;
      end // end S2

      S3:
      begin
        NEXT_STATE = (d==1'b1) ? S0 : S1;
      end // end S3

	    default:
      begin
        NEXT_STATE = S0;
	  	end // defualt

    endcase // case(CURRENT_STATE)

  end // always_comb

  assign y = (CURRENT_STATE == S3) & (d == 1'b1);

endmodule // seq_detector
