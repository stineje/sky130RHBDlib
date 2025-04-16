module tap_controller (
    input tck, trst, tms,
    output logic reset,
    output logic tdo_en,
    output logic shiftIR,
    output logic captureIR,
    output logic clockIR,
    output logic updateIR,
    output logic shiftDR,
    output logic captureDR,
    output logic clockDR,
    output logic updateDR,
    output logic updateDRstate,
    output logic select
);

(* mark_debug = "true" *) logic [3:0] state;

always @(posedge tck, negedge trst) begin
    if (~trst) begin
        state <= 4'b1111;
    end else begin
        state[0] <= ~tms && ~state[2] && state[0] || tms && ~state[1] || tms && ~state[0] || tms && state[3] && state[2];
        state[1] <= ~tms && state[1] && ~state[0] || ~tms && ~state[2] || ~tms && ~state[3] && state[1] || ~tms && ~state[3] && ~state[0] || tms && state[2] && ~state[1] || tms && state[3] && state[2] && state[0];
        state[2] <= state[2] && ~state[1] || state[2] && state[0] || tms && ~state[1];
        state[3] <= state[3] && ~state[2] || state[3] && state[1] || ~tms && state[2] && ~state[1] || ~state[3] && state[2] && ~state[1] && ~state[0];
    end
end

always @(negedge tck, negedge trst) begin
    if (~trst) begin
        reset <= 1'b0;
        tdo_en <= 1'b0;
        shiftIR <= 1'b0;
        captureIR <= 1'b0;
        shiftDR <= 1'b0;
        captureDR <= 1'b0;
    end else begin
        reset <= ~&state;
        tdo_en <= ~state[0] && state[1] && ~state[2] && state[3] || ~state[0] && state[1] && ~state[2] && ~state[3]; // shiftIR || shiftDR;
        shiftIR <= ~state[0] && state[1] && ~state[2] && state[3];
        captureIR <= ~state[0] && state[1] && state[2] && state[3];
        shiftDR <= ~state[0] && state[1] && ~state[2] && ~state[3];
        captureDR <= ~state[0] && state[1] && state[2] && ~state[3]; // TODO: && this with tck unless needed for one cycle
    end
end

assign clockIR = tck || state[0] || ~state[1] || ~state[3];
assign updateIR = ~tck && state[0] && ~state[1] && state[2] && state[3];
assign clockDR = tck || state[0] || ~state[1] || state[3];
assign updateDR = ~tck && updateDRstate;
assign updateDRstate = state[0] && ~state[1] && state[2] && ~state[3];
assign select = state[3];

endmodule  // tap_controller