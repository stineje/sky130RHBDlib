// Ross Thompson
// September 24, 2019
// Oklahoma State University
// Original work by Kurt Rooks Nov 14, 2011.
// Translated to verilog by Ross Thompson

// theory of operation
// Areset is an asynchronous reset which needs to be synced to a clock clk.
// But areset needs to be able to reset any downstream flip flops with an 
// asynchronous reset without a clock.  This works by resetting both registers.
// Because they are both asynchronous reset registers the output reset_out is
// immediately pulled high.  When areset is pulled low, the first flip flop
// may go metastable but is synched by ff_2.  Then after another clock period
// reset_out will go low.

module arrs (output reset_out,
	     input areset,
	     input clk);

   logic 	   n1, n2;

   flopenr #(1) ff_1(.clk(clk),
		     .reset(areset),
		     .en(1'b1),
		     .d(1'b1),
		     .q(n1));

   flopenr #(1) ff_2(.clk(clk),
		     .reset(areset),
		     .en(1'b1),
		     .d(n1),
		     .q(n2));

   assign reset_out = ~n2;
      
endmodule // arrs

   
