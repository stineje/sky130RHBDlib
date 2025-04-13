module jtag_test_logic (
    `include "defines.sv"

    input  tck, tms, tdi, trst,
    output tdo,

    output bsr_tdi, bsr_clk, bsr_update,
    (* mark_debug = "true" *) output bsr_shift, bsr_mode,
    input bsr_tdo,

    input sys_clk,
    output dbg_clk,
    output dm_reset
);

// TAP controller logic
logic reset;
logic tdo_en;
logic shiftIR;
logic captureIR;
logic ir_clk;
logic updateIR;
logic shiftDR;
logic captureDR;
logic clk_dr;
logic updateDRstate;
logic select;

// instruction signals
logic [`INST_COUNT-1:0] instructions;
logic idcode;
logic sample_preload;
logic extest;
logic intest;
(* mark_debug = "true" *) logic clamp;
(* mark_debug = "true" *) logic clamp_last;

(* mark_debug = "true" *) logic halt;
(* mark_debug = "true" *) logic step;
(* mark_debug = "true" *) logic resume;
logic logic_reset;

// intermediate wires
logic tdi_ir, tdi_dr;
logic tdo_ir, tdo_dr;
logic tdo_br;
logic tdo_id;


tap_controller fsm (
    .tck(tck),
    .trst(trst),
    .tms(tms),
    .reset(reset),
    .tdo_en(tdo_en),
    .shiftIR(shiftIR),
    .captureIR(captureIR),
    .clockIR(ir_clk),
    .updateIR(updateIR),
    .shiftDR(shiftDR),
    .captureDR(captureDR),
    .clockDR(clk_dr),
    .updateDR(updateDR),
    .updateDRstate(updateDRstate),
    .select(select)
);


// IR/DR input demux
assign {tdi_ir,tdi_dr} = select ? {tdi,1'bx} : {1'bx,tdi};
// IR/DR output mux
assign tdo = ~tdo_en ? 1'b0 : // TODO: check spec to see if this should be low or high when tdo_en is low
              select ? tdo_ir : tdo_dr;


instruction_register ir (
    .tck_ir(ir_clk), 
    .tdi(tdi_ir),
    .tl_reset(reset),
    .captureIR(captureIR),
    .updateIR(updateIR),
    .tdo(tdo_ir),
    .instructions(instructions)
);


// synth tool should recognize these as one-hot signals
assign idcode         = (instructions == `D_IDCODE);
assign sample_preload = (instructions == `D_SAMPLE_PRELOAD);
assign extest         = (instructions == `D_EXTEST);
assign intest         = (instructions == `D_INTEST);
assign clamp          = (instructions == `D_CLAMP);

assign halt           = (instructions == `D_HALT);
assign step           = (instructions == `D_STEP);
assign resume         = (instructions == `D_RESUME);
assign logic_reset    = (instructions == `D_RESET);

// Data Registers

bypass_register br (
    .clockDR(clk_dr),
    .tdi(tdi_dr),
    .shiftDR(shiftDR), // 10.1.1 (b)
    .tdo(tdo_br)
);


device_identification_register didr (
    .tdi(tdi_dr),
    .tdo(tdo_id),
    .clockDR(clk_dr || ~idcode),
    .captureDR(captureDR)
);


// BSR mux
logic bsr_enable;
assign bsr_enable = (sample_preload || extest || intest || clamp);

assign bsr_mode = (extest || intest || clamp || (clamp_last && step));  // selects parallel output latches for BSR output

assign bsr_tdi = bsr_enable ? tdi_dr : 1'bx;
assign bsr_clk = clk_dr || ~bsr_enable;  // clock high when idle
assign bsr_update = updateDR || clk_dr && captureDR;  // 8.7.1 (f)
assign bsr_shift = shiftDR;


// DR demux
always_comb begin
    unique0 case (instructions)
        `D_BYPASS          : tdo_dr <= tdo_br;
        `D_IDCODE          : tdo_dr <= tdo_id;
        `D_SAMPLE_PRELOAD,
        `D_EXTEST,
        `D_INTEST,
        `D_CLAMP           : tdo_dr <= bsr_tdo;
        default            : tdo_dr <= tdo_br;  // BYPASS
    endcase
end

// soft persistence clamp
always @(posedge updateIR) begin
    clamp_last <= clamp;
end



// Debug Core (sys_clk domain) ////////////////////////////////////////////////

logic clk_en, clk_gate;
logic [1:0] debug_state;

logic dbg_rst;
logic dbg_halt;
logic dbg_step;
logic dbg_resume;

cdc_sync_stb logicrst (.a(logic_reset), .clk_b(sys_clk), .b(dm_reset));
cdc_sync_stb #(.RISING_EDGE(0)) dbgrst (.a(trst && reset), .clk_b(sys_clk), .b(dbg_rst));
cdc_sync_stb dbghalt (.a(halt), .clk_b(sys_clk), .b(dbg_halt));
cdc_sync_stb dbgstep (.a(step && updateIR), .clk_b(sys_clk), .b(dbg_step));
cdc_sync_stb dbgresume (.a(resume), .clk_b(sys_clk), .b(dbg_resume));


always @(negedge sys_clk)
    clk_gate <= clk_en;

assign dbg_clk = sys_clk & clk_gate;

localparam
    DBGRUN  = 2'b00,
    DBGHALT = 2'b01,
    DBGSTEP = 2'b10;

always @(posedge sys_clk, negedge dbg_rst) begin
    if (~dbg_rst) begin
        debug_state <= DBGRUN;
        clk_en <= 1;
    end else begin
        case (debug_state)
            DBGRUN : begin
                if (dbg_halt) begin
                    clk_en <= 0;
                    debug_state <= DBGHALT;
                end
            end

            DBGHALT : begin
                if (dbg_step) begin
                    clk_en <= 1;
                    debug_state <= DBGSTEP;
                end else if (dbg_resume) begin
                    clk_en <= 1;
                    debug_state <= DBGRUN;
                end
            end

            DBGSTEP : begin
                clk_en <= 0;
                debug_state <= DBGHALT;
            end
        endcase
    end
end

endmodule  // jtag_test_logic


module cdc_sync_stb #(
    parameter RISING_EDGE = 1
)(
    input a,
    input clk_b,
    output logic b
);

logic sync1, sync2;
logic lock;

initial
    lock = 0;

always @(posedge clk_b) begin
    sync1 <= a;
    sync2 <= sync1;

    if (RISING_EDGE) begin
        if (sync2 && ~lock) begin
            lock <= 1;
            b <= 1;
        end
        if (b)
            b <= 0;
        if (~sync2)
            lock <= 0;
    end else begin
        if (~sync2 && ~lock) begin
            lock <= 1;
            b <= 0;
        end
        if (~b)
            b <= 1;
        if (sync2)
            lock <= 0;
    end
end

endmodule  // cdc_sync