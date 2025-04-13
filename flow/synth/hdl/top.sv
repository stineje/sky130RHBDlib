// systemverilog module that implements our module jtag test logic
//  alongside example system logic and boundary scan register


module top #(parameter IMEM_INIT_FILE="../RISCV_pipe/riscvtest/riscvtest.mem") (    
    // jtag logic
    (* mark_debug = "true" *) input tck,tdi,tms,trst,
    (* mark_debug = "true" *) output tdo,

    // dut logic
    input sysclk,
    (* mark_debug = "true" *) input sys_reset,

    (* mark_debug = "true" *) output logic success, fail  // PHY DEBUG
);

logic [8:0] bsr_chain;

logic bsr_tdi, bsr_clk, bsr_update, bsr_shift, bsr_mode, bsr_tdo;

(* mark_debug = "true" *) logic dbgclk;
(* mark_debug = "true" *) logic dm_reset;
(* mark_debug = "true" *) logic reset;

(* mark_debug = "true" *) logic [31:0] PCF;
(* mark_debug = "true" *) logic [31:0] InstrF;
(* mark_debug = "true" *) logic        MemWriteM;
(* mark_debug = "true" *) logic [31:0] DataAdrM;
(* mark_debug = "true" *) logic [31:0] WriteDataM;
(* mark_debug = "true" *) logic [31:0] ReadDataM;

logic [31:0] PCF_internal;
(* mark_debug = "true" *) logic [31:0] InstrF_internal;
logic        MemWriteM_internal;
logic [31:0] DataAdrM_internal;
logic [31:0] WriteDataM_internal;
logic [31:0] ReadDataM_internal;

assign reset = sys_reset || dm_reset;

assign bsr_chain[0] = bsr_tdi;
assign bsr_tdo = bsr_chain[6];

// PHY DEBUG

always @(posedge sysclk or posedge reset) begin
    if (reset) begin
        success <= 0;
        fail <= 0;
    end else if (MemWriteM) begin
        if(DataAdrM === 100 & WriteDataM === 25) begin
            success <= 1;
        end else if (DataAdrM === 100 & WriteDataM !== 25) begin
            fail <= 1;
        end
    end
end

// end PHY DEBUG



// test logic ////////////////////////////////////////////////////

jtag_test_logic jtag (
    .tck(tck),
    .tms(tms),
    .tdi(tdi),
    .trst(trst),
    .tdo(tdo),
    .bsr_tdi(bsr_tdi),
    .bsr_clk(bsr_clk),
    .bsr_update(bsr_update),
    .bsr_shift(bsr_shift),
    .bsr_mode(bsr_mode),
    .bsr_tdo(bsr_tdo),
    .sys_clk(sysclk),
    .dbg_clk(dbgclk),
    .dm_reset(dm_reset)
);

// RISC-V Core ///////////////////////////////////////////////////

riscv core (
    .clk(dbgclk),
    .reset(reset),
    .PCF(PCF_internal),
    .InstrF(InstrF_internal),
    .MemWriteM(MemWriteM_internal),
    .ALUResultM(DataAdrM_internal),
    .WriteDataM(WriteDataM_internal),
    .ReadDataM(ReadDataM_internal)
);

// Core memory

imem #(.MEM_INIT_FILE(IMEM_INIT_FILE)) imem (PCF, InstrF);
dmem dmem (dbgclk, MemWriteM, DataAdrM, WriteDataM, ReadDataM);

// boundary scan registers ///////////////////////////////////////


bsr #(.WIDTH(32)) PCF_bsr (
    .clk(bsr_clk),
    .update_dr(bsr_update),
    .shift_dr(bsr_shift),
    .mode(bsr_mode),
    .tdi(bsr_chain[0]),
    .tdo(bsr_chain[1]),
    .parallel_in(PCF_internal),
    .parallel_out(PCF)
);

bsr #(.WIDTH(32)) InstrF_bsr (
    .clk(bsr_clk),
    .update_dr(bsr_update),
    .shift_dr(bsr_shift),
    .mode(bsr_mode),
    .tdi(bsr_chain[1]),
    .tdo(bsr_chain[2]),
    .parallel_in(InstrF),
    .parallel_out(InstrF_internal)
);

bsr #(.WIDTH(1)) MemWriteM_bsr (
    .clk(bsr_clk),
    .update_dr(bsr_update),
    .shift_dr(bsr_shift),
    .mode(bsr_mode),
    .tdi(bsr_chain[2]),
    .tdo(bsr_chain[3]),
    .parallel_in(MemWriteM_internal),
    .parallel_out(MemWriteM)
);

bsr #(.WIDTH(32)) DataAdrM_bsr (
    .clk(bsr_clk),
    .update_dr(bsr_update),
    .shift_dr(bsr_shift),
    .mode(bsr_mode),
    .tdi(bsr_chain[3]),
    .tdo(bsr_chain[4]),
    .parallel_in(DataAdrM_internal),
    .parallel_out(DataAdrM)
);

bsr #(.WIDTH(32)) WriteDataM_bsr (
    .clk(bsr_clk),
    .update_dr(bsr_update),
    .shift_dr(bsr_shift),
    .mode(bsr_mode),
    .tdi(bsr_chain[4]),
    .tdo(bsr_chain[5]),
    .parallel_in(WriteDataM_internal),
    .parallel_out(WriteDataM)
);

bsr #(.WIDTH(32)) ReadDataM_bsr (
    .clk(bsr_clk),
    .update_dr(bsr_update),
    .shift_dr(bsr_shift),
    .mode(bsr_mode),
    .tdi(bsr_chain[5]),
    .tdo(bsr_chain[6]),
    .parallel_in(ReadDataM),
    .parallel_out(ReadDataM_internal)
);

endmodule // top