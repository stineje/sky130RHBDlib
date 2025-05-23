module bsr #(parameter WIDTH) (
    input  clk,
    input  update_dr,
    input  shift_dr,
    input  mode,

    input  tdi,
    output tdo,
    
    input [WIDTH-1:0] parallel_in,
    output [WIDTH-1:0] parallel_out
);

logic [WIDTH:0] shift_reg;

assign shift_reg[WIDTH] = tdi;
assign tdo = shift_reg[0];

genvar i;
for (i=0; i<WIDTH; i=i+1) begin
    bsr_cell bsr_cell (
        .clk(clk),
        .update_dr(update_dr),
        .shift_dr(shift_dr),
        .mode(mode),
        .parallel_in(parallel_in[i]),
        .parallel_out(parallel_out[i]),
        .sequential_in(shift_reg[i+1]),
        .sequential_out(shift_reg[i])
    );
end

endmodule  // bsr


// IEEE 1149.1 - 8.5.1 example boundary scan register
module bsr_cell (
    input clk, update_dr, shift_dr, mode,
    input parallel_in, sequential_in,
    output logic parallel_out, sequential_out
);

logic state_in, state_out;

assign state_in = shift_dr ? sequential_in : parallel_in;

always @(posedge clk)
    sequential_out <= state_in;

always @(posedge update_dr)  // 11.3.1 (b)
    state_out <= sequential_out;

assign parallel_out = mode ? state_out : parallel_in;

endmodule // bsr_cell