// Rising Edge Detector
// Author: Ryan Ridley
//
//

module Rising_Edge_Detector(


);

  // New type that binary encodes states
  typedef enum logic [1:0]
  {s0=2'b00, s1=2'b01, s2=2'b10} binary_enc_state;

  // New type that 1 hot encodes states
  typedef enum logic [2:0]
  {s0=2'b001, s1=2'b010, s2=2'b100} 1hot_enc_state;

  // Creating two binary encoded state variables
  binary_enc_state state_reg_bin, state_next_bin;

  // Creating two 1 hot encoded state variables
  1hot_enc_state state_reg_1hot, state_next_1hot;


endmodule
