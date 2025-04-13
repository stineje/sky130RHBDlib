// device ID
`define DEVICE_ID 32'hDEADBEEF  // 12.1.1 (d)

// instruction register width
`define INST_REG_WIDTH 4

// decoded (one-hot) instruction signal bus width
`define INST_COUNT 10

// encoded instructions
`define E_BYPASS         'b1111  // 8.4
`define E_IDCODE         'b0001  // 8.13
`define E_SAMPLE_PRELOAD 'b0010  // 8.6, 8.7
`define E_EXTEST         'b0011  // 8.8
`define E_INTEST         'b0100  // 8.9
`define E_CLAMP          'b0101  // 8.11

`define E_HALT           'b0110  // stop logic clock
`define E_STEP           'b0111  // trigger logic clock once
`define E_RESUME         'b1000  // resume logic clock
`define E_RESET          'b1001  // reset logic


// decoded instructions
`define D_BYPASS         'b1
`define D_IDCODE         'b10
`define D_SAMPLE_PRELOAD 'b100
`define D_EXTEST         'b1000
`define D_INTEST         'b10000
`define D_CLAMP          'b100000

`define D_HALT           'b1000000
`define D_STEP           'b10000000
`define D_RESUME         'b100000000
`define D_RESET          'b1000000000