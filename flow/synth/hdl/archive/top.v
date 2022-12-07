module regfile( // @[:@3.2]
  input         clk, // @[:@4.4]
  input         reset, // @[:@5.4]
  input         io_regWriteEnable, // @[:@6.4]
  input  [4:0]  io_regWriteAddress, // @[:@6.4]
  input  [31:0] io_regWriteData, // @[:@6.4]
  input  [4:0]  io_regReadAddress1, // @[:@6.4]
  input  [4:0]  io_regReadAddress2, // @[:@6.4]
  output [31:0] io_regReadData1, // @[:@6.4]
  output [31:0] io_regReadData2 // @[:@6.4]
);
  reg [31:0] rf [0:31]; // @[riscvSingle.scala 692:17:@8.4]
  reg [31:0] _RAND_0;
  wire [31:0] rf__T_34_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_34_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_35_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_35_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_45_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_45_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_55_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_55_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_65_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_65_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_75_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_75_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_85_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_85_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_95_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_95_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_105_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_105_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_115_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_115_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_125_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_125_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_135_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_135_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_145_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_145_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_155_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_155_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_165_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_165_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_175_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_175_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_185_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_185_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_195_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_195_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_205_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_205_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_215_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_215_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_225_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_225_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_235_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_235_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_245_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_245_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_255_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_255_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_265_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_265_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_275_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_275_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_285_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_285_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_295_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_295_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_305_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_305_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_315_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_315_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_325_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_325_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_335_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_335_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_345_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_345_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_355_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_355_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_30_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_30_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire  rf__T_30_mask; // @[riscvSingle.scala 692:17:@8.4]
  wire  rf__T_30_en; // @[riscvSingle.scala 692:17:@8.4]
  wire [31:0] rf__T_32_data; // @[riscvSingle.scala 692:17:@8.4]
  wire [4:0] rf__T_32_addr; // @[riscvSingle.scala 692:17:@8.4]
  wire  rf__T_32_mask; // @[riscvSingle.scala 692:17:@8.4]
  wire  rf__T_32_en; // @[riscvSingle.scala 692:17:@8.4]
  wire  _T_22; // @[riscvSingle.scala 695:28:@10.4]
  wire  _T_24; // @[riscvSingle.scala 695:28:@11.4]
  wire  _T_26; // @[riscvSingle.scala 695:57:@12.4]
  wire  _T_28; // @[riscvSingle.scala 695:36:@13.4]
  wire  _T_29; // @[riscvSingle.scala 695:33:@14.4]
  wire  _T_38; // @[riscvSingle.scala 711:11:@35.4]
  wire [31:0] _T_43; // @[riscvSingle.scala 716:26:@44.4 riscvSingle.scala 717:16:@46.4]
  wire [31:0] _T_53; // @[riscvSingle.scala 716:26:@57.4 riscvSingle.scala 717:16:@59.4]
  wire [31:0] _T_63; // @[riscvSingle.scala 716:26:@70.4 riscvSingle.scala 717:16:@72.4]
  wire [31:0] _T_73; // @[riscvSingle.scala 716:26:@83.4 riscvSingle.scala 717:16:@85.4]
  wire [31:0] _T_83; // @[riscvSingle.scala 716:26:@96.4 riscvSingle.scala 717:16:@98.4]
  wire [31:0] _T_93; // @[riscvSingle.scala 716:26:@109.4 riscvSingle.scala 717:16:@111.4]
  wire [31:0] _T_103; // @[riscvSingle.scala 716:26:@122.4 riscvSingle.scala 717:16:@124.4]
  wire [31:0] _T_113; // @[riscvSingle.scala 716:26:@135.4 riscvSingle.scala 717:16:@137.4]
  wire [31:0] _T_123; // @[riscvSingle.scala 716:26:@148.4 riscvSingle.scala 717:16:@150.4]
  wire [31:0] _T_133; // @[riscvSingle.scala 716:26:@161.4 riscvSingle.scala 717:16:@163.4]
  wire [31:0] _T_143; // @[riscvSingle.scala 716:26:@174.4 riscvSingle.scala 717:16:@176.4]
  wire [31:0] _T_153; // @[riscvSingle.scala 716:26:@187.4 riscvSingle.scala 717:16:@189.4]
  wire [31:0] _T_163; // @[riscvSingle.scala 716:26:@200.4 riscvSingle.scala 717:16:@202.4]
  wire [31:0] _T_173; // @[riscvSingle.scala 716:26:@213.4 riscvSingle.scala 717:16:@215.4]
  wire [31:0] _T_183; // @[riscvSingle.scala 716:26:@226.4 riscvSingle.scala 717:16:@228.4]
  wire [31:0] _T_193; // @[riscvSingle.scala 716:26:@239.4 riscvSingle.scala 717:16:@241.4]
  wire [31:0] _T_203; // @[riscvSingle.scala 716:26:@252.4 riscvSingle.scala 717:16:@254.4]
  wire [31:0] _T_213; // @[riscvSingle.scala 716:26:@265.4 riscvSingle.scala 717:16:@267.4]
  wire [31:0] _T_223; // @[riscvSingle.scala 716:26:@278.4 riscvSingle.scala 717:16:@280.4]
  wire [31:0] _T_233; // @[riscvSingle.scala 716:26:@291.4 riscvSingle.scala 717:16:@293.4]
  wire [31:0] _T_243; // @[riscvSingle.scala 716:26:@304.4 riscvSingle.scala 717:16:@306.4]
  wire [31:0] _T_253; // @[riscvSingle.scala 716:26:@317.4 riscvSingle.scala 717:16:@319.4]
  wire [31:0] _T_263; // @[riscvSingle.scala 716:26:@330.4 riscvSingle.scala 717:16:@332.4]
  wire [31:0] _T_273; // @[riscvSingle.scala 716:26:@343.4 riscvSingle.scala 717:16:@345.4]
  wire [31:0] _T_283; // @[riscvSingle.scala 716:26:@356.4 riscvSingle.scala 717:16:@358.4]
  wire [31:0] _T_293; // @[riscvSingle.scala 716:26:@369.4 riscvSingle.scala 717:16:@371.4]
  wire [31:0] _T_303; // @[riscvSingle.scala 716:26:@382.4 riscvSingle.scala 717:16:@384.4]
  wire [31:0] _T_313; // @[riscvSingle.scala 716:26:@395.4 riscvSingle.scala 717:16:@397.4]
  wire [31:0] _T_323; // @[riscvSingle.scala 716:26:@408.4 riscvSingle.scala 717:16:@410.4]
  wire [31:0] _T_333; // @[riscvSingle.scala 716:26:@421.4 riscvSingle.scala 717:16:@423.4]
  wire [31:0] _T_343; // @[riscvSingle.scala 716:26:@434.4 riscvSingle.scala 717:16:@436.4]
  wire [31:0] _T_353; // @[riscvSingle.scala 716:26:@447.4 riscvSingle.scala 717:16:@449.4]
  assign rf__T_34_addr = io_regReadAddress1;
  assign rf__T_34_data = rf[rf__T_34_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_35_addr = io_regReadAddress2;
  assign rf__T_35_data = rf[rf__T_35_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_45_addr = 5'h0;
  assign rf__T_45_data = rf[rf__T_45_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_55_addr = 5'h1;
  assign rf__T_55_data = rf[rf__T_55_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_65_addr = 5'h2;
  assign rf__T_65_data = rf[rf__T_65_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_75_addr = 5'h3;
  assign rf__T_75_data = rf[rf__T_75_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_85_addr = 5'h4;
  assign rf__T_85_data = rf[rf__T_85_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_95_addr = 5'h5;
  assign rf__T_95_data = rf[rf__T_95_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_105_addr = 5'h6;
  assign rf__T_105_data = rf[rf__T_105_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_115_addr = 5'h7;
  assign rf__T_115_data = rf[rf__T_115_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_125_addr = 5'h8;
  assign rf__T_125_data = rf[rf__T_125_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_135_addr = 5'h9;
  assign rf__T_135_data = rf[rf__T_135_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_145_addr = 5'ha;
  assign rf__T_145_data = rf[rf__T_145_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_155_addr = 5'hb;
  assign rf__T_155_data = rf[rf__T_155_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_165_addr = 5'hc;
  assign rf__T_165_data = rf[rf__T_165_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_175_addr = 5'hd;
  assign rf__T_175_data = rf[rf__T_175_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_185_addr = 5'he;
  assign rf__T_185_data = rf[rf__T_185_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_195_addr = 5'hf;
  assign rf__T_195_data = rf[rf__T_195_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_205_addr = 5'h10;
  assign rf__T_205_data = rf[rf__T_205_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_215_addr = 5'h11;
  assign rf__T_215_data = rf[rf__T_215_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_225_addr = 5'h12;
  assign rf__T_225_data = rf[rf__T_225_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_235_addr = 5'h13;
  assign rf__T_235_data = rf[rf__T_235_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_245_addr = 5'h14;
  assign rf__T_245_data = rf[rf__T_245_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_255_addr = 5'h15;
  assign rf__T_255_data = rf[rf__T_255_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_265_addr = 5'h16;
  assign rf__T_265_data = rf[rf__T_265_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_275_addr = 5'h17;
  assign rf__T_275_data = rf[rf__T_275_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_285_addr = 5'h18;
  assign rf__T_285_data = rf[rf__T_285_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_295_addr = 5'h19;
  assign rf__T_295_data = rf[rf__T_295_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_305_addr = 5'h1a;
  assign rf__T_305_data = rf[rf__T_305_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_315_addr = 5'h1b;
  assign rf__T_315_data = rf[rf__T_315_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_325_addr = 5'h1c;
  assign rf__T_325_data = rf[rf__T_325_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_335_addr = 5'h1d;
  assign rf__T_335_data = rf[rf__T_335_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_345_addr = 5'h1e;
  assign rf__T_345_data = rf[rf__T_345_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_355_addr = 5'h1f;
  assign rf__T_355_data = rf[rf__T_355_addr]; // @[riscvSingle.scala 692:17:@8.4]
  assign rf__T_30_data = io_regWriteData;
  assign rf__T_30_addr = io_regWriteAddress;
  assign rf__T_30_mask = 1'h1;
  assign rf__T_30_en = _T_24 & _T_28;
  assign rf__T_32_data = 32'sh0;
  assign rf__T_32_addr = 5'h0;
  assign rf__T_32_mask = 1'h1;
  assign rf__T_32_en = _T_29 ? 1'h0 : 1'h1;
  assign _T_22 = ~ io_regWriteEnable; // @[riscvSingle.scala 695:28:@10.4]
  assign _T_24 = _T_22 == 1'h0; // @[riscvSingle.scala 695:28:@11.4]
  assign _T_26 = io_regWriteAddress == 5'h0; // @[riscvSingle.scala 695:57:@12.4]
  assign _T_28 = _T_26 == 1'h0; // @[riscvSingle.scala 695:36:@13.4]
  assign _T_29 = _T_24 & _T_28; // @[riscvSingle.scala 695:33:@14.4]
  assign _T_38 = reset == 1'h0; // @[riscvSingle.scala 711:11:@35.4]
  assign _T_43 = rf__T_45_data; // @[riscvSingle.scala 716:26:@44.4 riscvSingle.scala 717:16:@46.4]
  assign _T_53 = rf__T_55_data; // @[riscvSingle.scala 716:26:@57.4 riscvSingle.scala 717:16:@59.4]
  assign _T_63 = rf__T_65_data; // @[riscvSingle.scala 716:26:@70.4 riscvSingle.scala 717:16:@72.4]
  assign _T_73 = rf__T_75_data; // @[riscvSingle.scala 716:26:@83.4 riscvSingle.scala 717:16:@85.4]
  assign _T_83 = rf__T_85_data; // @[riscvSingle.scala 716:26:@96.4 riscvSingle.scala 717:16:@98.4]
  assign _T_93 = rf__T_95_data; // @[riscvSingle.scala 716:26:@109.4 riscvSingle.scala 717:16:@111.4]
  assign _T_103 = rf__T_105_data; // @[riscvSingle.scala 716:26:@122.4 riscvSingle.scala 717:16:@124.4]
  assign _T_113 = rf__T_115_data; // @[riscvSingle.scala 716:26:@135.4 riscvSingle.scala 717:16:@137.4]
  assign _T_123 = rf__T_125_data; // @[riscvSingle.scala 716:26:@148.4 riscvSingle.scala 717:16:@150.4]
  assign _T_133 = rf__T_135_data; // @[riscvSingle.scala 716:26:@161.4 riscvSingle.scala 717:16:@163.4]
  assign _T_143 = rf__T_145_data; // @[riscvSingle.scala 716:26:@174.4 riscvSingle.scala 717:16:@176.4]
  assign _T_153 = rf__T_155_data; // @[riscvSingle.scala 716:26:@187.4 riscvSingle.scala 717:16:@189.4]
  assign _T_163 = rf__T_165_data; // @[riscvSingle.scala 716:26:@200.4 riscvSingle.scala 717:16:@202.4]
  assign _T_173 = rf__T_175_data; // @[riscvSingle.scala 716:26:@213.4 riscvSingle.scala 717:16:@215.4]
  assign _T_183 = rf__T_185_data; // @[riscvSingle.scala 716:26:@226.4 riscvSingle.scala 717:16:@228.4]
  assign _T_193 = rf__T_195_data; // @[riscvSingle.scala 716:26:@239.4 riscvSingle.scala 717:16:@241.4]
  assign _T_203 = rf__T_205_data; // @[riscvSingle.scala 716:26:@252.4 riscvSingle.scala 717:16:@254.4]
  assign _T_213 = rf__T_215_data; // @[riscvSingle.scala 716:26:@265.4 riscvSingle.scala 717:16:@267.4]
  assign _T_223 = rf__T_225_data; // @[riscvSingle.scala 716:26:@278.4 riscvSingle.scala 717:16:@280.4]
  assign _T_233 = rf__T_235_data; // @[riscvSingle.scala 716:26:@291.4 riscvSingle.scala 717:16:@293.4]
  assign _T_243 = rf__T_245_data; // @[riscvSingle.scala 716:26:@304.4 riscvSingle.scala 717:16:@306.4]
  assign _T_253 = rf__T_255_data; // @[riscvSingle.scala 716:26:@317.4 riscvSingle.scala 717:16:@319.4]
  assign _T_263 = rf__T_265_data; // @[riscvSingle.scala 716:26:@330.4 riscvSingle.scala 717:16:@332.4]
  assign _T_273 = rf__T_275_data; // @[riscvSingle.scala 716:26:@343.4 riscvSingle.scala 717:16:@345.4]
  assign _T_283 = rf__T_285_data; // @[riscvSingle.scala 716:26:@356.4 riscvSingle.scala 717:16:@358.4]
  assign _T_293 = rf__T_295_data; // @[riscvSingle.scala 716:26:@369.4 riscvSingle.scala 717:16:@371.4]
  assign _T_303 = rf__T_305_data; // @[riscvSingle.scala 716:26:@382.4 riscvSingle.scala 717:16:@384.4]
  assign _T_313 = rf__T_315_data; // @[riscvSingle.scala 716:26:@395.4 riscvSingle.scala 717:16:@397.4]
  assign _T_323 = rf__T_325_data; // @[riscvSingle.scala 716:26:@408.4 riscvSingle.scala 717:16:@410.4]
  assign _T_333 = rf__T_335_data; // @[riscvSingle.scala 716:26:@421.4 riscvSingle.scala 717:16:@423.4]
  assign _T_343 = rf__T_345_data; // @[riscvSingle.scala 716:26:@434.4 riscvSingle.scala 717:16:@436.4]
  assign _T_353 = rf__T_355_data; // @[riscvSingle.scala 716:26:@447.4 riscvSingle.scala 717:16:@449.4]
  assign io_regReadData1 = rf__T_34_data; // @[riscvSingle.scala 701:21:@24.4]
  assign io_regReadData2 = rf__T_35_data; // @[riscvSingle.scala 702:21:@26.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  _RAND_0 = {1{`RANDOM}};
  `ifdef RANDOMIZE_MEM_INIT
  for (initvar = 0; initvar < 32; initvar = initvar+1)
    rf[initvar] = _RAND_0[31:0];
  `endif // RANDOMIZE_MEM_INIT
  end
`endif // RANDOMIZE
  always @(posedge clk) begin
    if(rf__T_30_en & rf__T_30_mask) begin
      rf[rf__T_30_addr] <= rf__T_30_data; // @[riscvSingle.scala 692:17:@8.4]
    end
    if(rf__T_32_en & rf__T_32_mask) begin
      rf[rf__T_32_addr] <= rf__T_32_data; // @[riscvSingle.scala 692:17:@8.4]
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"\n\n\n___________________________\n|regfile Module:\n|  regWriteEnable  : b%b\n|  regReadAddress1 : b%b\n|  regReadAddress2 : b%b\n|  regWriteAddress : b%b\n|  regWriteData    : 0x%x\n|  regReadData1    : 0x%x\n|  regReadData2    : 0x%x\n|___________________________\n",io_regWriteEnable,io_regReadAddress1,io_regReadAddress2,io_regWriteAddress,io_regWriteData,io_regReadData1,io_regReadData2); // @[riscvSingle.scala 711:11:@37.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"\n\n\n___________________________\n"); // @[riscvSingle.scala 714:11:@42.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"| rf(0) = "); // @[riscvSingle.scala 718:15:@50.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"%d\n",_T_43); // @[riscvSingle.scala 719:15:@55.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"| rf(1) = "); // @[riscvSingle.scala 718:15:@63.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"%d\n",_T_53); // @[riscvSingle.scala 719:15:@68.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"| rf(2) = "); // @[riscvSingle.scala 718:15:@76.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"%d\n",_T_63); // @[riscvSingle.scala 719:15:@81.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"| rf(3) = "); // @[riscvSingle.scala 718:15:@89.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"%d\n",_T_73); // @[riscvSingle.scala 719:15:@94.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"| rf(4) = "); // @[riscvSingle.scala 718:15:@102.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"%d\n",_T_83); // @[riscvSingle.scala 719:15:@107.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"| rf(5) = "); // @[riscvSingle.scala 718:15:@115.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"%d\n",_T_93); // @[riscvSingle.scala 719:15:@120.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"| rf(6) = "); // @[riscvSingle.scala 718:15:@128.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"%d\n",_T_103); // @[riscvSingle.scala 719:15:@133.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"| rf(7) = "); // @[riscvSingle.scala 718:15:@141.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"%d\n",_T_113); // @[riscvSingle.scala 719:15:@146.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"| rf(8) = "); // @[riscvSingle.scala 718:15:@154.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"%d\n",_T_123); // @[riscvSingle.scala 719:15:@159.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"| rf(9) = "); // @[riscvSingle.scala 718:15:@167.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"%d\n",_T_133); // @[riscvSingle.scala 719:15:@172.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"| rf(10) = "); // @[riscvSingle.scala 718:15:@180.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"%d\n",_T_143); // @[riscvSingle.scala 719:15:@185.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"| rf(11) = "); // @[riscvSingle.scala 718:15:@193.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"%d\n",_T_153); // @[riscvSingle.scala 719:15:@198.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"| rf(12) = "); // @[riscvSingle.scala 718:15:@206.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"%d\n",_T_163); // @[riscvSingle.scala 719:15:@211.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"| rf(13) = "); // @[riscvSingle.scala 718:15:@219.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"%d\n",_T_173); // @[riscvSingle.scala 719:15:@224.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"| rf(14) = "); // @[riscvSingle.scala 718:15:@232.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"%d\n",_T_183); // @[riscvSingle.scala 719:15:@237.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"| rf(15) = "); // @[riscvSingle.scala 718:15:@245.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"%d\n",_T_193); // @[riscvSingle.scala 719:15:@250.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"| rf(16) = "); // @[riscvSingle.scala 718:15:@258.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"%d\n",_T_203); // @[riscvSingle.scala 719:15:@263.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"| rf(17) = "); // @[riscvSingle.scala 718:15:@271.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"%d\n",_T_213); // @[riscvSingle.scala 719:15:@276.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"| rf(18) = "); // @[riscvSingle.scala 718:15:@284.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"%d\n",_T_223); // @[riscvSingle.scala 719:15:@289.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"| rf(19) = "); // @[riscvSingle.scala 718:15:@297.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"%d\n",_T_233); // @[riscvSingle.scala 719:15:@302.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"| rf(20) = "); // @[riscvSingle.scala 718:15:@310.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"%d\n",_T_243); // @[riscvSingle.scala 719:15:@315.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"| rf(21) = "); // @[riscvSingle.scala 718:15:@323.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"%d\n",_T_253); // @[riscvSingle.scala 719:15:@328.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"| rf(22) = "); // @[riscvSingle.scala 718:15:@336.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"%d\n",_T_263); // @[riscvSingle.scala 719:15:@341.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"| rf(23) = "); // @[riscvSingle.scala 718:15:@349.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"%d\n",_T_273); // @[riscvSingle.scala 719:15:@354.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"| rf(24) = "); // @[riscvSingle.scala 718:15:@362.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"%d\n",_T_283); // @[riscvSingle.scala 719:15:@367.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"| rf(25) = "); // @[riscvSingle.scala 718:15:@375.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"%d\n",_T_293); // @[riscvSingle.scala 719:15:@380.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"| rf(26) = "); // @[riscvSingle.scala 718:15:@388.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"%d\n",_T_303); // @[riscvSingle.scala 719:15:@393.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"| rf(27) = "); // @[riscvSingle.scala 718:15:@401.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"%d\n",_T_313); // @[riscvSingle.scala 719:15:@406.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"| rf(28) = "); // @[riscvSingle.scala 718:15:@414.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"%d\n",_T_323); // @[riscvSingle.scala 719:15:@419.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"| rf(29) = "); // @[riscvSingle.scala 718:15:@427.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"%d\n",_T_333); // @[riscvSingle.scala 719:15:@432.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"| rf(30) = "); // @[riscvSingle.scala 718:15:@440.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"%d\n",_T_343); // @[riscvSingle.scala 719:15:@445.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"| rf(31) = "); // @[riscvSingle.scala 718:15:@453.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"%d\n",_T_353); // @[riscvSingle.scala 719:15:@458.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_38) begin
          $fwrite(32'h80000002,"|___________________________\n"); // @[riscvSingle.scala 721:11:@463.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module fpuRegfile( // @[:@466.2]
  input         clk, // @[:@467.4]
  input         reset, // @[:@468.4]
  input         io_fpuRegWriteEnable, // @[:@469.4]
  input  [4:0]  io_fpuRegWriteAddress, // @[:@469.4]
  input  [31:0] io_fpuRegWriteData, // @[:@469.4]
  input  [4:0]  io_fpuRegReadAddress1, // @[:@469.4]
  input  [4:0]  io_fpuRegReadAddress2, // @[:@469.4]
  output [31:0] io_fpuRegReadData1, // @[:@469.4]
  output [31:0] io_fpuRegReadData2 // @[:@469.4]
);
  reg [31:0] fpu_rf [0:31]; // @[riscvSingle.scala 758:21:@471.4]
  reg [31:0] _RAND_0;
  wire [31:0] fpu_rf__T_37_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_37_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_38_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_38_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_48_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_48_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_58_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_58_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_68_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_68_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_78_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_78_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_88_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_88_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_98_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_98_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_108_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_108_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_118_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_118_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_128_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_128_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_138_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_138_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_148_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_148_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_158_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_158_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_168_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_168_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_178_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_178_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_188_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_188_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_198_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_198_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_208_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_208_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_218_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_218_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_228_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_228_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_238_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_238_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_248_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_248_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_258_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_258_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_268_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_268_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_278_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_278_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_288_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_288_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_298_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_298_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_308_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_308_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_318_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_318_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_328_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_328_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_338_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_338_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_348_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_348_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_358_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_358_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_23_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_23_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire  fpu_rf__T_23_mask; // @[riscvSingle.scala 758:21:@471.4]
  wire  fpu_rf__T_23_en; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_33_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_33_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire  fpu_rf__T_33_mask; // @[riscvSingle.scala 758:21:@471.4]
  wire  fpu_rf__T_33_en; // @[riscvSingle.scala 758:21:@471.4]
  wire [31:0] fpu_rf__T_35_data; // @[riscvSingle.scala 758:21:@471.4]
  wire [4:0] fpu_rf__T_35_addr; // @[riscvSingle.scala 758:21:@471.4]
  wire  fpu_rf__T_35_mask; // @[riscvSingle.scala 758:21:@471.4]
  wire  fpu_rf__T_35_en; // @[riscvSingle.scala 758:21:@471.4]
  wire  _T_25; // @[riscvSingle.scala 763:31:@475.4]
  wire  _T_27; // @[riscvSingle.scala 763:31:@476.4]
  wire  _T_29; // @[riscvSingle.scala 763:63:@477.4]
  wire  _T_31; // @[riscvSingle.scala 763:39:@478.4]
  wire  _T_32; // @[riscvSingle.scala 763:36:@479.4]
  wire  _T_41; // @[riscvSingle.scala 779:11:@500.4]
  wire [31:0] _T_46; // @[riscvSingle.scala 784:26:@509.4 riscvSingle.scala 785:16:@511.4]
  wire [31:0] _T_56; // @[riscvSingle.scala 784:26:@522.4 riscvSingle.scala 785:16:@524.4]
  wire [31:0] _T_66; // @[riscvSingle.scala 784:26:@535.4 riscvSingle.scala 785:16:@537.4]
  wire [31:0] _T_76; // @[riscvSingle.scala 784:26:@548.4 riscvSingle.scala 785:16:@550.4]
  wire [31:0] _T_86; // @[riscvSingle.scala 784:26:@561.4 riscvSingle.scala 785:16:@563.4]
  wire [31:0] _T_96; // @[riscvSingle.scala 784:26:@574.4 riscvSingle.scala 785:16:@576.4]
  wire [31:0] _T_106; // @[riscvSingle.scala 784:26:@587.4 riscvSingle.scala 785:16:@589.4]
  wire [31:0] _T_116; // @[riscvSingle.scala 784:26:@600.4 riscvSingle.scala 785:16:@602.4]
  wire [31:0] _T_126; // @[riscvSingle.scala 784:26:@613.4 riscvSingle.scala 785:16:@615.4]
  wire [31:0] _T_136; // @[riscvSingle.scala 784:26:@626.4 riscvSingle.scala 785:16:@628.4]
  wire [31:0] _T_146; // @[riscvSingle.scala 784:26:@639.4 riscvSingle.scala 785:16:@641.4]
  wire [31:0] _T_156; // @[riscvSingle.scala 784:26:@652.4 riscvSingle.scala 785:16:@654.4]
  wire [31:0] _T_166; // @[riscvSingle.scala 784:26:@665.4 riscvSingle.scala 785:16:@667.4]
  wire [31:0] _T_176; // @[riscvSingle.scala 784:26:@678.4 riscvSingle.scala 785:16:@680.4]
  wire [31:0] _T_186; // @[riscvSingle.scala 784:26:@691.4 riscvSingle.scala 785:16:@693.4]
  wire [31:0] _T_196; // @[riscvSingle.scala 784:26:@704.4 riscvSingle.scala 785:16:@706.4]
  wire [31:0] _T_206; // @[riscvSingle.scala 784:26:@717.4 riscvSingle.scala 785:16:@719.4]
  wire [31:0] _T_216; // @[riscvSingle.scala 784:26:@730.4 riscvSingle.scala 785:16:@732.4]
  wire [31:0] _T_226; // @[riscvSingle.scala 784:26:@743.4 riscvSingle.scala 785:16:@745.4]
  wire [31:0] _T_236; // @[riscvSingle.scala 784:26:@756.4 riscvSingle.scala 785:16:@758.4]
  wire [31:0] _T_246; // @[riscvSingle.scala 784:26:@769.4 riscvSingle.scala 785:16:@771.4]
  wire [31:0] _T_256; // @[riscvSingle.scala 784:26:@782.4 riscvSingle.scala 785:16:@784.4]
  wire [31:0] _T_266; // @[riscvSingle.scala 784:26:@795.4 riscvSingle.scala 785:16:@797.4]
  wire [31:0] _T_276; // @[riscvSingle.scala 784:26:@808.4 riscvSingle.scala 785:16:@810.4]
  wire [31:0] _T_286; // @[riscvSingle.scala 784:26:@821.4 riscvSingle.scala 785:16:@823.4]
  wire [31:0] _T_296; // @[riscvSingle.scala 784:26:@834.4 riscvSingle.scala 785:16:@836.4]
  wire [31:0] _T_306; // @[riscvSingle.scala 784:26:@847.4 riscvSingle.scala 785:16:@849.4]
  wire [31:0] _T_316; // @[riscvSingle.scala 784:26:@860.4 riscvSingle.scala 785:16:@862.4]
  wire [31:0] _T_326; // @[riscvSingle.scala 784:26:@873.4 riscvSingle.scala 785:16:@875.4]
  wire [31:0] _T_336; // @[riscvSingle.scala 784:26:@886.4 riscvSingle.scala 785:16:@888.4]
  wire [31:0] _T_346; // @[riscvSingle.scala 784:26:@899.4 riscvSingle.scala 785:16:@901.4]
  wire [31:0] _T_356; // @[riscvSingle.scala 784:26:@912.4 riscvSingle.scala 785:16:@914.4]
  assign fpu_rf__T_37_addr = io_fpuRegReadAddress1;
  assign fpu_rf__T_37_data = fpu_rf[fpu_rf__T_37_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_38_addr = io_fpuRegReadAddress2;
  assign fpu_rf__T_38_data = fpu_rf[fpu_rf__T_38_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_48_addr = 5'h0;
  assign fpu_rf__T_48_data = fpu_rf[fpu_rf__T_48_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_58_addr = 5'h1;
  assign fpu_rf__T_58_data = fpu_rf[fpu_rf__T_58_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_68_addr = 5'h2;
  assign fpu_rf__T_68_data = fpu_rf[fpu_rf__T_68_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_78_addr = 5'h3;
  assign fpu_rf__T_78_data = fpu_rf[fpu_rf__T_78_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_88_addr = 5'h4;
  assign fpu_rf__T_88_data = fpu_rf[fpu_rf__T_88_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_98_addr = 5'h5;
  assign fpu_rf__T_98_data = fpu_rf[fpu_rf__T_98_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_108_addr = 5'h6;
  assign fpu_rf__T_108_data = fpu_rf[fpu_rf__T_108_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_118_addr = 5'h7;
  assign fpu_rf__T_118_data = fpu_rf[fpu_rf__T_118_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_128_addr = 5'h8;
  assign fpu_rf__T_128_data = fpu_rf[fpu_rf__T_128_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_138_addr = 5'h9;
  assign fpu_rf__T_138_data = fpu_rf[fpu_rf__T_138_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_148_addr = 5'ha;
  assign fpu_rf__T_148_data = fpu_rf[fpu_rf__T_148_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_158_addr = 5'hb;
  assign fpu_rf__T_158_data = fpu_rf[fpu_rf__T_158_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_168_addr = 5'hc;
  assign fpu_rf__T_168_data = fpu_rf[fpu_rf__T_168_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_178_addr = 5'hd;
  assign fpu_rf__T_178_data = fpu_rf[fpu_rf__T_178_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_188_addr = 5'he;
  assign fpu_rf__T_188_data = fpu_rf[fpu_rf__T_188_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_198_addr = 5'hf;
  assign fpu_rf__T_198_data = fpu_rf[fpu_rf__T_198_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_208_addr = 5'h10;
  assign fpu_rf__T_208_data = fpu_rf[fpu_rf__T_208_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_218_addr = 5'h11;
  assign fpu_rf__T_218_data = fpu_rf[fpu_rf__T_218_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_228_addr = 5'h12;
  assign fpu_rf__T_228_data = fpu_rf[fpu_rf__T_228_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_238_addr = 5'h13;
  assign fpu_rf__T_238_data = fpu_rf[fpu_rf__T_238_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_248_addr = 5'h14;
  assign fpu_rf__T_248_data = fpu_rf[fpu_rf__T_248_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_258_addr = 5'h15;
  assign fpu_rf__T_258_data = fpu_rf[fpu_rf__T_258_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_268_addr = 5'h16;
  assign fpu_rf__T_268_data = fpu_rf[fpu_rf__T_268_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_278_addr = 5'h17;
  assign fpu_rf__T_278_data = fpu_rf[fpu_rf__T_278_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_288_addr = 5'h18;
  assign fpu_rf__T_288_data = fpu_rf[fpu_rf__T_288_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_298_addr = 5'h19;
  assign fpu_rf__T_298_data = fpu_rf[fpu_rf__T_298_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_308_addr = 5'h1a;
  assign fpu_rf__T_308_data = fpu_rf[fpu_rf__T_308_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_318_addr = 5'h1b;
  assign fpu_rf__T_318_data = fpu_rf[fpu_rf__T_318_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_328_addr = 5'h1c;
  assign fpu_rf__T_328_data = fpu_rf[fpu_rf__T_328_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_338_addr = 5'h1d;
  assign fpu_rf__T_338_data = fpu_rf[fpu_rf__T_338_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_348_addr = 5'h1e;
  assign fpu_rf__T_348_data = fpu_rf[fpu_rf__T_348_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_358_addr = 5'h1f;
  assign fpu_rf__T_358_data = fpu_rf[fpu_rf__T_358_addr]; // @[riscvSingle.scala 758:21:@471.4]
  assign fpu_rf__T_23_data = 32'sh3dcccccd;
  assign fpu_rf__T_23_addr = 5'h0;
  assign fpu_rf__T_23_mask = 1'h1;
  assign fpu_rf__T_23_en = 1'h1;
  assign fpu_rf__T_33_data = io_fpuRegWriteData;
  assign fpu_rf__T_33_addr = io_fpuRegWriteAddress;
  assign fpu_rf__T_33_mask = 1'h1;
  assign fpu_rf__T_33_en = _T_27 & _T_31;
  assign fpu_rf__T_35_data = 32'sh3dcccccd;
  assign fpu_rf__T_35_addr = 5'h0;
  assign fpu_rf__T_35_mask = 1'h1;
  assign fpu_rf__T_35_en = _T_32 ? 1'h0 : 1'h1;
  assign _T_25 = ~ io_fpuRegWriteEnable; // @[riscvSingle.scala 763:31:@475.4]
  assign _T_27 = _T_25 == 1'h0; // @[riscvSingle.scala 763:31:@476.4]
  assign _T_29 = io_fpuRegWriteAddress == 5'h0; // @[riscvSingle.scala 763:63:@477.4]
  assign _T_31 = _T_29 == 1'h0; // @[riscvSingle.scala 763:39:@478.4]
  assign _T_32 = _T_27 & _T_31; // @[riscvSingle.scala 763:36:@479.4]
  assign _T_41 = reset == 1'h0; // @[riscvSingle.scala 779:11:@500.4]
  assign _T_46 = fpu_rf__T_48_data; // @[riscvSingle.scala 784:26:@509.4 riscvSingle.scala 785:16:@511.4]
  assign _T_56 = fpu_rf__T_58_data; // @[riscvSingle.scala 784:26:@522.4 riscvSingle.scala 785:16:@524.4]
  assign _T_66 = fpu_rf__T_68_data; // @[riscvSingle.scala 784:26:@535.4 riscvSingle.scala 785:16:@537.4]
  assign _T_76 = fpu_rf__T_78_data; // @[riscvSingle.scala 784:26:@548.4 riscvSingle.scala 785:16:@550.4]
  assign _T_86 = fpu_rf__T_88_data; // @[riscvSingle.scala 784:26:@561.4 riscvSingle.scala 785:16:@563.4]
  assign _T_96 = fpu_rf__T_98_data; // @[riscvSingle.scala 784:26:@574.4 riscvSingle.scala 785:16:@576.4]
  assign _T_106 = fpu_rf__T_108_data; // @[riscvSingle.scala 784:26:@587.4 riscvSingle.scala 785:16:@589.4]
  assign _T_116 = fpu_rf__T_118_data; // @[riscvSingle.scala 784:26:@600.4 riscvSingle.scala 785:16:@602.4]
  assign _T_126 = fpu_rf__T_128_data; // @[riscvSingle.scala 784:26:@613.4 riscvSingle.scala 785:16:@615.4]
  assign _T_136 = fpu_rf__T_138_data; // @[riscvSingle.scala 784:26:@626.4 riscvSingle.scala 785:16:@628.4]
  assign _T_146 = fpu_rf__T_148_data; // @[riscvSingle.scala 784:26:@639.4 riscvSingle.scala 785:16:@641.4]
  assign _T_156 = fpu_rf__T_158_data; // @[riscvSingle.scala 784:26:@652.4 riscvSingle.scala 785:16:@654.4]
  assign _T_166 = fpu_rf__T_168_data; // @[riscvSingle.scala 784:26:@665.4 riscvSingle.scala 785:16:@667.4]
  assign _T_176 = fpu_rf__T_178_data; // @[riscvSingle.scala 784:26:@678.4 riscvSingle.scala 785:16:@680.4]
  assign _T_186 = fpu_rf__T_188_data; // @[riscvSingle.scala 784:26:@691.4 riscvSingle.scala 785:16:@693.4]
  assign _T_196 = fpu_rf__T_198_data; // @[riscvSingle.scala 784:26:@704.4 riscvSingle.scala 785:16:@706.4]
  assign _T_206 = fpu_rf__T_208_data; // @[riscvSingle.scala 784:26:@717.4 riscvSingle.scala 785:16:@719.4]
  assign _T_216 = fpu_rf__T_218_data; // @[riscvSingle.scala 784:26:@730.4 riscvSingle.scala 785:16:@732.4]
  assign _T_226 = fpu_rf__T_228_data; // @[riscvSingle.scala 784:26:@743.4 riscvSingle.scala 785:16:@745.4]
  assign _T_236 = fpu_rf__T_238_data; // @[riscvSingle.scala 784:26:@756.4 riscvSingle.scala 785:16:@758.4]
  assign _T_246 = fpu_rf__T_248_data; // @[riscvSingle.scala 784:26:@769.4 riscvSingle.scala 785:16:@771.4]
  assign _T_256 = fpu_rf__T_258_data; // @[riscvSingle.scala 784:26:@782.4 riscvSingle.scala 785:16:@784.4]
  assign _T_266 = fpu_rf__T_268_data; // @[riscvSingle.scala 784:26:@795.4 riscvSingle.scala 785:16:@797.4]
  assign _T_276 = fpu_rf__T_278_data; // @[riscvSingle.scala 784:26:@808.4 riscvSingle.scala 785:16:@810.4]
  assign _T_286 = fpu_rf__T_288_data; // @[riscvSingle.scala 784:26:@821.4 riscvSingle.scala 785:16:@823.4]
  assign _T_296 = fpu_rf__T_298_data; // @[riscvSingle.scala 784:26:@834.4 riscvSingle.scala 785:16:@836.4]
  assign _T_306 = fpu_rf__T_308_data; // @[riscvSingle.scala 784:26:@847.4 riscvSingle.scala 785:16:@849.4]
  assign _T_316 = fpu_rf__T_318_data; // @[riscvSingle.scala 784:26:@860.4 riscvSingle.scala 785:16:@862.4]
  assign _T_326 = fpu_rf__T_328_data; // @[riscvSingle.scala 784:26:@873.4 riscvSingle.scala 785:16:@875.4]
  assign _T_336 = fpu_rf__T_338_data; // @[riscvSingle.scala 784:26:@886.4 riscvSingle.scala 785:16:@888.4]
  assign _T_346 = fpu_rf__T_348_data; // @[riscvSingle.scala 784:26:@899.4 riscvSingle.scala 785:16:@901.4]
  assign _T_356 = fpu_rf__T_358_data; // @[riscvSingle.scala 784:26:@912.4 riscvSingle.scala 785:16:@914.4]
  assign io_fpuRegReadData1 = fpu_rf__T_37_data; // @[riscvSingle.scala 769:24:@489.4]
  assign io_fpuRegReadData2 = fpu_rf__T_38_data; // @[riscvSingle.scala 770:24:@491.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  _RAND_0 = {1{`RANDOM}};
  `ifdef RANDOMIZE_MEM_INIT
  for (initvar = 0; initvar < 32; initvar = initvar+1)
    fpu_rf[initvar] = _RAND_0[31:0];
  `endif // RANDOMIZE_MEM_INIT
  end
`endif // RANDOMIZE
  always @(posedge clk) begin
    if(fpu_rf__T_23_en & fpu_rf__T_23_mask) begin
      fpu_rf[fpu_rf__T_23_addr] <= fpu_rf__T_23_data; // @[riscvSingle.scala 758:21:@471.4]
    end
    if(fpu_rf__T_33_en & fpu_rf__T_33_mask) begin
      fpu_rf[fpu_rf__T_33_addr] <= fpu_rf__T_33_data; // @[riscvSingle.scala 758:21:@471.4]
    end
    if(fpu_rf__T_35_en & fpu_rf__T_35_mask) begin
      fpu_rf[fpu_rf__T_35_addr] <= fpu_rf__T_35_data; // @[riscvSingle.scala 758:21:@471.4]
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"\n\n\n___________________________\n|fpuRegfile Module:\n|  fpuRegWriteEnable  : b%b\n|  fpuRegReadAddress1 : b%b\n|  fpuRegReadAddress2 : b%b\n|  fpuRegWriteAddress : b%b\n|  fpuRegWriteData    : 0x%x\n|  fpuRegReadData1    : 0x%x\n|  fpuRegReadData2    : 0x%x\n|___________________________\n",io_fpuRegWriteEnable,io_fpuRegReadAddress1,io_fpuRegReadAddress2,io_fpuRegWriteAddress,io_fpuRegWriteData,io_fpuRegReadData1,io_fpuRegReadData2); // @[riscvSingle.scala 779:11:@502.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"\n\n\n___________________________\n"); // @[riscvSingle.scala 782:11:@507.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"| fpu_rf(0) = "); // @[riscvSingle.scala 786:15:@515.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"%x\n",_T_46); // @[riscvSingle.scala 787:15:@520.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"| fpu_rf(1) = "); // @[riscvSingle.scala 786:15:@528.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"%x\n",_T_56); // @[riscvSingle.scala 787:15:@533.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"| fpu_rf(2) = "); // @[riscvSingle.scala 786:15:@541.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"%x\n",_T_66); // @[riscvSingle.scala 787:15:@546.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"| fpu_rf(3) = "); // @[riscvSingle.scala 786:15:@554.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"%x\n",_T_76); // @[riscvSingle.scala 787:15:@559.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"| fpu_rf(4) = "); // @[riscvSingle.scala 786:15:@567.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"%x\n",_T_86); // @[riscvSingle.scala 787:15:@572.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"| fpu_rf(5) = "); // @[riscvSingle.scala 786:15:@580.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"%x\n",_T_96); // @[riscvSingle.scala 787:15:@585.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"| fpu_rf(6) = "); // @[riscvSingle.scala 786:15:@593.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"%x\n",_T_106); // @[riscvSingle.scala 787:15:@598.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"| fpu_rf(7) = "); // @[riscvSingle.scala 786:15:@606.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"%x\n",_T_116); // @[riscvSingle.scala 787:15:@611.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"| fpu_rf(8) = "); // @[riscvSingle.scala 786:15:@619.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"%x\n",_T_126); // @[riscvSingle.scala 787:15:@624.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"| fpu_rf(9) = "); // @[riscvSingle.scala 786:15:@632.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"%x\n",_T_136); // @[riscvSingle.scala 787:15:@637.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"| fpu_rf(10) = "); // @[riscvSingle.scala 786:15:@645.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"%x\n",_T_146); // @[riscvSingle.scala 787:15:@650.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"| fpu_rf(11) = "); // @[riscvSingle.scala 786:15:@658.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"%x\n",_T_156); // @[riscvSingle.scala 787:15:@663.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"| fpu_rf(12) = "); // @[riscvSingle.scala 786:15:@671.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"%x\n",_T_166); // @[riscvSingle.scala 787:15:@676.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"| fpu_rf(13) = "); // @[riscvSingle.scala 786:15:@684.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"%x\n",_T_176); // @[riscvSingle.scala 787:15:@689.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"| fpu_rf(14) = "); // @[riscvSingle.scala 786:15:@697.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"%x\n",_T_186); // @[riscvSingle.scala 787:15:@702.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"| fpu_rf(15) = "); // @[riscvSingle.scala 786:15:@710.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"%x\n",_T_196); // @[riscvSingle.scala 787:15:@715.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"| fpu_rf(16) = "); // @[riscvSingle.scala 786:15:@723.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"%x\n",_T_206); // @[riscvSingle.scala 787:15:@728.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"| fpu_rf(17) = "); // @[riscvSingle.scala 786:15:@736.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"%x\n",_T_216); // @[riscvSingle.scala 787:15:@741.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"| fpu_rf(18) = "); // @[riscvSingle.scala 786:15:@749.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"%x\n",_T_226); // @[riscvSingle.scala 787:15:@754.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"| fpu_rf(19) = "); // @[riscvSingle.scala 786:15:@762.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"%x\n",_T_236); // @[riscvSingle.scala 787:15:@767.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"| fpu_rf(20) = "); // @[riscvSingle.scala 786:15:@775.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"%x\n",_T_246); // @[riscvSingle.scala 787:15:@780.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"| fpu_rf(21) = "); // @[riscvSingle.scala 786:15:@788.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"%x\n",_T_256); // @[riscvSingle.scala 787:15:@793.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"| fpu_rf(22) = "); // @[riscvSingle.scala 786:15:@801.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"%x\n",_T_266); // @[riscvSingle.scala 787:15:@806.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"| fpu_rf(23) = "); // @[riscvSingle.scala 786:15:@814.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"%x\n",_T_276); // @[riscvSingle.scala 787:15:@819.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"| fpu_rf(24) = "); // @[riscvSingle.scala 786:15:@827.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"%x\n",_T_286); // @[riscvSingle.scala 787:15:@832.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"| fpu_rf(25) = "); // @[riscvSingle.scala 786:15:@840.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"%x\n",_T_296); // @[riscvSingle.scala 787:15:@845.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"| fpu_rf(26) = "); // @[riscvSingle.scala 786:15:@853.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"%x\n",_T_306); // @[riscvSingle.scala 787:15:@858.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"| fpu_rf(27) = "); // @[riscvSingle.scala 786:15:@866.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"%x\n",_T_316); // @[riscvSingle.scala 787:15:@871.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"| fpu_rf(28) = "); // @[riscvSingle.scala 786:15:@879.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"%x\n",_T_326); // @[riscvSingle.scala 787:15:@884.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"| fpu_rf(29) = "); // @[riscvSingle.scala 786:15:@892.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"%x\n",_T_336); // @[riscvSingle.scala 787:15:@897.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"| fpu_rf(30) = "); // @[riscvSingle.scala 786:15:@905.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"%x\n",_T_346); // @[riscvSingle.scala 787:15:@910.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"| fpu_rf(31) = "); // @[riscvSingle.scala 786:15:@918.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"%x\n",_T_356); // @[riscvSingle.scala 787:15:@923.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_41) begin
          $fwrite(32'h80000002,"|___________________________\n"); // @[riscvSingle.scala 789:11:@928.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module alu( // @[:@931.2]
  input         clk, // @[:@932.4]
  input         reset, // @[:@933.4]
  input  [31:0] io_a, // @[:@934.4]
  input  [31:0] io_b, // @[:@934.4]
  input  [3:0]  io_aluControl, // @[:@934.4]
  output [31:0] io_out, // @[:@934.4]
  output        io_zeroFlag, // @[:@934.4]
  output        io_lessThanFlag, // @[:@934.4]
  output        io_greaterThanFlag // @[:@934.4]
);
  wire  _T_21; // @[riscvSingle.scala 829:25:@937.4]
  wire [31:0] _T_22; // @[riscvSingle.scala 830:24:@939.6]
  wire [31:0] _T_23; // @[riscvSingle.scala 830:24:@940.6]
  wire  _T_25; // @[riscvSingle.scala 831:31:@944.6]
  wire [31:0] _T_26; // @[riscvSingle.scala 832:24:@946.8]
  wire [31:0] _T_27; // @[riscvSingle.scala 832:24:@947.8]
  wire  _T_29; // @[riscvSingle.scala 833:31:@951.8]
  wire [32:0] _T_30; // @[riscvSingle.scala 834:24:@953.10]
  wire [31:0] _T_31; // @[riscvSingle.scala 834:24:@954.10]
  wire [31:0] _T_32; // @[riscvSingle.scala 834:24:@955.10]
  wire  _T_34; // @[riscvSingle.scala 835:31:@959.10]
  wire [11:0] _T_35; // @[riscvSingle.scala 836:31:@961.12]
  wire [4126:0] _GEN_14; // @[riscvSingle.scala 836:24:@962.12]
  wire [4126:0] _T_36; // @[riscvSingle.scala 836:24:@962.12]
  wire  _T_38; // @[riscvSingle.scala 837:31:@966.12]
  wire [31:0] _T_40; // @[riscvSingle.scala 838:24:@969.14]
  wire  _T_42; // @[riscvSingle.scala 839:30:@973.14]
  wire [31:0] _T_43; // @[riscvSingle.scala 840:19:@975.16]
  wire [31:0] _T_44; // @[riscvSingle.scala 840:33:@976.16]
  wire  _T_45; // @[riscvSingle.scala 840:26:@977.16]
  wire [1:0] _GEN_0; // @[riscvSingle.scala 840:40:@978.16]
  wire  _T_49; // @[riscvSingle.scala 845:31:@986.16]
  wire [31:0] _T_50; // @[riscvSingle.scala 846:24:@988.18]
  wire [31:0] _T_51; // @[riscvSingle.scala 846:24:@989.18]
  wire  _T_53; // @[riscvSingle.scala 847:31:@993.18]
  wire  _T_57; // @[riscvSingle.scala 849:30:@1000.20]
  wire [63:0] _T_58; // @[riscvSingle.scala 850:24:@1002.22]
  wire  _T_60; // @[riscvSingle.scala 851:30:@1006.22]
  wire  _T_61; // @[riscvSingle.scala 852:19:@1008.24]
  wire [1:0] _GEN_1; // @[riscvSingle.scala 852:26:@1009.24]
  wire  _T_65; // @[riscvSingle.scala 857:30:@1017.24]
  wire [32:0] _T_66; // @[riscvSingle.scala 858:24:@1019.26]
  wire  _T_68; // @[riscvSingle.scala 859:30:@1023.26]
  wire [32:0] _T_69; // @[riscvSingle.scala 860:24:@1025.28]
  wire [31:0] _T_70; // @[riscvSingle.scala 860:24:@1026.28]
  wire [31:0] _T_71; // @[riscvSingle.scala 860:24:@1027.28]
  wire [31:0] _GEN_2; // @[riscvSingle.scala 859:39:@1024.26]
  wire [32:0] _GEN_3; // @[riscvSingle.scala 857:39:@1018.24]
  wire [32:0] _GEN_4; // @[riscvSingle.scala 851:39:@1007.22]
  wire [63:0] _GEN_5; // @[riscvSingle.scala 849:39:@1001.20]
  wire [63:0] _GEN_6; // @[riscvSingle.scala 847:40:@994.18]
  wire [63:0] _GEN_7; // @[riscvSingle.scala 845:40:@987.16]
  wire [63:0] _GEN_8; // @[riscvSingle.scala 839:38:@974.14]
  wire [63:0] _GEN_9; // @[riscvSingle.scala 837:40:@967.12]
  wire [4126:0] _GEN_10; // @[riscvSingle.scala 835:40:@960.10]
  wire [4126:0] _GEN_11; // @[riscvSingle.scala 833:40:@952.8]
  wire [4126:0] _GEN_12; // @[riscvSingle.scala 831:40:@945.6]
  wire [4126:0] _GEN_13; // @[riscvSingle.scala 829:34:@938.4]
  wire  _T_85; // @[riscvSingle.scala 877:11:@1051.4]
  wire [31:0] _GEN_15; // @[riscvSingle.scala 830:16:@941.6 riscvSingle.scala 832:16:@948.8 riscvSingle.scala 834:16:@956.10 riscvSingle.scala 836:16:@963.12 riscvSingle.scala 838:16:@970.14 riscvSingle.scala 841:20:@979.18 riscvSingle.scala 843:20:@982.18 riscvSingle.scala 846:16:@990.18 riscvSingle.scala 848:16:@997.20 riscvSingle.scala 850:16:@1003.22 riscvSingle.scala 853:20:@1010.26 riscvSingle.scala 855:20:@1013.26 riscvSingle.scala 858:16:@1020.26 riscvSingle.scala 860:16:@1028.28 riscvSingle.scala 862:16:@1031.28]
  assign _T_21 = io_aluControl == 4'h0; // @[riscvSingle.scala 829:25:@937.4]
  assign _T_22 = $signed(io_a) & $signed(io_b); // @[riscvSingle.scala 830:24:@939.6]
  assign _T_23 = $signed(_T_22); // @[riscvSingle.scala 830:24:@940.6]
  assign _T_25 = io_aluControl == 4'h1; // @[riscvSingle.scala 831:31:@944.6]
  assign _T_26 = $signed(io_a) | $signed(io_b); // @[riscvSingle.scala 832:24:@946.8]
  assign _T_27 = $signed(_T_26); // @[riscvSingle.scala 832:24:@947.8]
  assign _T_29 = io_aluControl == 4'h2; // @[riscvSingle.scala 833:31:@951.8]
  assign _T_30 = $signed(io_a) + $signed(io_b); // @[riscvSingle.scala 834:24:@953.10]
  assign _T_31 = $signed(io_a) + $signed(io_b); // @[riscvSingle.scala 834:24:@954.10]
  assign _T_32 = $signed(_T_31); // @[riscvSingle.scala 834:24:@955.10]
  assign _T_34 = io_aluControl == 4'h3; // @[riscvSingle.scala 835:31:@959.10]
  assign _T_35 = io_b[11:0]; // @[riscvSingle.scala 836:31:@961.12]
  assign _GEN_14 = {{4095{io_a[31]}},io_a}; // @[riscvSingle.scala 836:24:@962.12]
  assign _T_36 = $signed(_GEN_14) << _T_35; // @[riscvSingle.scala 836:24:@962.12]
  assign _T_38 = io_aluControl == 4'h4; // @[riscvSingle.scala 837:31:@966.12]
  assign _T_40 = $signed(io_a) >>> _T_35; // @[riscvSingle.scala 838:24:@969.14]
  assign _T_42 = io_aluControl == 4'h5; // @[riscvSingle.scala 839:30:@973.14]
  assign _T_43 = $unsigned(io_a); // @[riscvSingle.scala 840:19:@975.16]
  assign _T_44 = $unsigned(io_b); // @[riscvSingle.scala 840:33:@976.16]
  assign _T_45 = _T_43 < _T_44; // @[riscvSingle.scala 840:26:@977.16]
  assign _GEN_0 = _T_45 ? $signed(2'sh1) : $signed(2'sh0); // @[riscvSingle.scala 840:40:@978.16]
  assign _T_49 = io_aluControl == 4'h6; // @[riscvSingle.scala 845:31:@986.16]
  assign _T_50 = $signed(io_a) ^ $signed(io_b); // @[riscvSingle.scala 846:24:@988.18]
  assign _T_51 = $signed(_T_50); // @[riscvSingle.scala 846:24:@989.18]
  assign _T_53 = io_aluControl == 4'h7; // @[riscvSingle.scala 847:31:@993.18]
  assign _T_57 = io_aluControl == 4'h8; // @[riscvSingle.scala 849:30:@1000.20]
  assign _T_58 = $signed(io_a) * $signed(io_b); // @[riscvSingle.scala 850:24:@1002.22]
  assign _T_60 = io_aluControl == 4'h9; // @[riscvSingle.scala 851:30:@1006.22]
  assign _T_61 = $signed(io_a) < $signed(io_b); // @[riscvSingle.scala 852:19:@1008.24]
  assign _GEN_1 = _T_61 ? $signed(2'sh1) : $signed(2'sh0); // @[riscvSingle.scala 852:26:@1009.24]
  assign _T_65 = io_aluControl == 4'ha; // @[riscvSingle.scala 857:30:@1017.24]
  assign _T_66 = $signed(io_a) / $signed(io_b); // @[riscvSingle.scala 858:24:@1019.26]
  assign _T_68 = io_aluControl == 4'hc; // @[riscvSingle.scala 859:30:@1023.26]
  assign _T_69 = $signed(io_a) - $signed(io_b); // @[riscvSingle.scala 860:24:@1025.28]
  assign _T_70 = $signed(io_a) - $signed(io_b); // @[riscvSingle.scala 860:24:@1026.28]
  assign _T_71 = $signed(_T_70); // @[riscvSingle.scala 860:24:@1027.28]
  assign _GEN_2 = _T_68 ? $signed(_T_71) : $signed(32'sh0); // @[riscvSingle.scala 859:39:@1024.26]
  assign _GEN_3 = _T_65 ? $signed(_T_66) : $signed({{1{_GEN_2[31]}},_GEN_2}); // @[riscvSingle.scala 857:39:@1018.24]
  assign _GEN_4 = _T_60 ? $signed({{31{_GEN_1[1]}},_GEN_1}) : $signed(_GEN_3); // @[riscvSingle.scala 851:39:@1007.22]
  assign _GEN_5 = _T_57 ? $signed(_T_58) : $signed({{31{_GEN_4[32]}},_GEN_4}); // @[riscvSingle.scala 849:39:@1001.20]
  assign _GEN_6 = _T_53 ? $signed({{32{_T_40[31]}},_T_40}) : $signed(_GEN_5); // @[riscvSingle.scala 847:40:@994.18]
  assign _GEN_7 = _T_49 ? $signed({{32{_T_51[31]}},_T_51}) : $signed(_GEN_6); // @[riscvSingle.scala 845:40:@987.16]
  assign _GEN_8 = _T_42 ? $signed({{62{_GEN_0[1]}},_GEN_0}) : $signed(_GEN_7); // @[riscvSingle.scala 839:38:@974.14]
  assign _GEN_9 = _T_38 ? $signed({{32{_T_40[31]}},_T_40}) : $signed(_GEN_8); // @[riscvSingle.scala 837:40:@967.12]
  assign _GEN_10 = _T_34 ? $signed(_T_36) : $signed({{4063{_GEN_9[63]}},_GEN_9}); // @[riscvSingle.scala 835:40:@960.10]
  assign _GEN_11 = _T_29 ? $signed({{4095{_T_32[31]}},_T_32}) : $signed(_GEN_10); // @[riscvSingle.scala 833:40:@952.8]
  assign _GEN_12 = _T_25 ? $signed({{4095{_T_27[31]}},_T_27}) : $signed(_GEN_11); // @[riscvSingle.scala 831:40:@945.6]
  assign _GEN_13 = _T_21 ? $signed({{4095{_T_23[31]}},_T_23}) : $signed(_GEN_12); // @[riscvSingle.scala 829:34:@938.4]
  assign _T_85 = reset == 1'h0; // @[riscvSingle.scala 877:11:@1051.4]
  assign _GEN_15 = _GEN_13[31:0]; // @[riscvSingle.scala 830:16:@941.6 riscvSingle.scala 832:16:@948.8 riscvSingle.scala 834:16:@956.10 riscvSingle.scala 836:16:@963.12 riscvSingle.scala 838:16:@970.14 riscvSingle.scala 841:20:@979.18 riscvSingle.scala 843:20:@982.18 riscvSingle.scala 846:16:@990.18 riscvSingle.scala 848:16:@997.20 riscvSingle.scala 850:16:@1003.22 riscvSingle.scala 853:20:@1010.26 riscvSingle.scala 855:20:@1013.26 riscvSingle.scala 858:16:@1020.26 riscvSingle.scala 860:16:@1028.28 riscvSingle.scala 862:16:@1031.28]
  assign io_out = $signed(_GEN_15); // @[riscvSingle.scala 830:16:@941.6 riscvSingle.scala 832:16:@948.8 riscvSingle.scala 834:16:@956.10 riscvSingle.scala 836:16:@963.12 riscvSingle.scala 838:16:@970.14 riscvSingle.scala 841:20:@979.18 riscvSingle.scala 843:20:@982.18 riscvSingle.scala 846:16:@990.18 riscvSingle.scala 848:16:@997.20 riscvSingle.scala 850:16:@1003.22 riscvSingle.scala 853:20:@1010.26 riscvSingle.scala 855:20:@1013.26 riscvSingle.scala 858:16:@1020.26 riscvSingle.scala 860:16:@1028.28 riscvSingle.scala 862:16:@1031.28]
  assign io_zeroFlag = $signed(_T_32) == $signed(32'sh0); // @[riscvSingle.scala 866:17:@1038.4]
  assign io_lessThanFlag = $signed(io_a) < $signed(io_b); // @[riscvSingle.scala 867:21:@1040.4]
  assign io_greaterThanFlag = $signed(io_a) > $signed(io_b); // @[riscvSingle.scala 868:24:@1042.4]
  always @(posedge clk) begin
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_85) begin
          $fwrite(32'h80000002,"\n\n\n___________________________\n|alu Module:\n|  a               : 0x%x\n|  b               : 0x%x\n|  out             : 0x%x\n|  aluControl      : b%b\n|  zeroFlag        : b%b\n|  lessThanFlag    : b%b\n|  greaterThanFlag : b%b\n|___________________________\n",io_a,io_b,io_out,io_aluControl,io_zeroFlag,io_lessThanFlag,io_greaterThanFlag); // @[riscvSingle.scala 877:11:@1053.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module fpu( // @[:@1056.2]
  input         clk, // @[:@1057.4]
  input         reset, // @[:@1058.4]
  input  [31:0] io_a, // @[:@1059.4]
  input  [31:0] io_b, // @[:@1059.4]
  input  [1:0]  io_fpuControl, // @[:@1059.4]
  output [31:0] io_s // @[:@1059.4]
);
  wire [7:0] exp_a; // @[riscvSingle.scala 954:18:@1076.4]
  wire [22:0] _T_30; // @[riscvSingle.scala 955:28:@1078.4]
  wire [23:0] mant_a; // @[Cat.scala 30:58:@1079.4]
  wire [7:0] exp_b; // @[riscvSingle.scala 956:18:@1081.4]
  wire [22:0] _T_34; // @[riscvSingle.scala 957:28:@1083.4]
  wire [23:0] mant_b; // @[Cat.scala 30:58:@1084.4]
  wire [47:0] result; // @[riscvSingle.scala 961:22:@1086.4]
  wire [8:0] _T_37; // @[riscvSingle.scala 964:25:@1088.4]
  wire [8:0] _T_38; // @[riscvSingle.scala 964:25:@1089.4]
  wire [7:0] aminusb; // @[riscvSingle.scala 964:25:@1090.4]
  wire [8:0] _T_39; // @[riscvSingle.scala 965:25:@1091.4]
  wire [8:0] _T_40; // @[riscvSingle.scala 965:25:@1092.4]
  wire [7:0] bminusa; // @[riscvSingle.scala 965:25:@1093.4]
  wire  alessb; // @[riscvSingle.scala 968:17:@1095.4]
  wire  _T_47; // @[riscvSingle.scala 974:27:@1103.4]
  wire  _T_49; // @[riscvSingle.scala 974:27:@1104.4]
  wire [7:0] exp_pre; // @[riscvSingle.scala 974:19:@1105.4]
  wire [7:0] shamt; // @[riscvSingle.scala 975:17:@1109.4]
  wire [23:0] _T_58; // @[riscvSingle.scala 980:44:@1113.4]
  wire [23:0] _T_59; // @[riscvSingle.scala 980:63:@1114.4]
  wire [23:0] _T_60; // @[riscvSingle.scala 980:22:@1115.4]
  wire  _T_61; // @[riscvSingle.scala 981:18:@1117.4]
  wire  _T_62; // @[riscvSingle.scala 981:29:@1118.4]
  wire  _T_63; // @[riscvSingle.scala 981:22:@1119.4]
  wire  _T_64; // @[riscvSingle.scala 981:40:@1120.4]
  wire  _T_65; // @[riscvSingle.scala 981:33:@1121.4]
  wire  _T_66; // @[riscvSingle.scala 981:52:@1122.4]
  wire  _T_67; // @[riscvSingle.scala 981:63:@1123.4]
  wire  _T_68; // @[riscvSingle.scala 981:56:@1124.4]
  wire  ovf; // @[riscvSingle.scala 981:44:@1125.4]
  wire  _T_70; // @[riscvSingle.scala 982:23:@1127.4]
  wire  _T_72; // @[riscvSingle.scala 982:23:@1128.4]
  wire [24:0] shiftedval; // @[riscvSingle.scala 945:26:@1069.4 riscvSingle.scala 980:16:@1116.4]
  wire [24:0] shmant; // @[riscvSingle.scala 982:18:@1129.4]
  wire [23:0] _T_78; // @[riscvSingle.scala 986:18:@1133.4]
  wire [24:0] addval; // @[riscvSingle.scala 946:22:@1070.4 riscvSingle.scala 986:12:@1134.4]
  wire [25:0] _T_79; // @[riscvSingle.scala 987:25:@1135.4]
  wire [24:0] addresult; // @[riscvSingle.scala 987:25:@1136.4]
  wire  _T_82; // @[riscvSingle.scala 989:24:@1138.4]
  wire  _T_84; // @[riscvSingle.scala 989:48:@1139.4]
  wire  _T_85; // @[riscvSingle.scala 989:32:@1140.4]
  wire  _T_86; // @[riscvSingle.scala 990:31:@1142.6]
  wire  _T_87; // @[riscvSingle.scala 990:36:@1143.6]
  wire  _T_89; // @[riscvSingle.scala 990:36:@1144.6]
  wire [22:0] _T_90; // @[riscvSingle.scala 990:51:@1145.6]
  wire [22:0] _T_91; // @[riscvSingle.scala 990:69:@1146.6]
  wire [22:0] _T_92; // @[riscvSingle.scala 990:21:@1147.6]
  wire [8:0] _T_98; // @[riscvSingle.scala 991:54:@1152.6]
  wire [7:0] _T_99; // @[riscvSingle.scala 991:54:@1153.6]
  wire [7:0] _T_100; // @[riscvSingle.scala 991:24:@1154.6]
  wire  _T_102; // @[riscvSingle.scala 992:31:@1158.6]
  wire  _T_104; // @[riscvSingle.scala 992:55:@1159.6]
  wire  _T_105; // @[riscvSingle.scala 992:39:@1160.6]
  wire  _T_106; // @[riscvSingle.scala 993:28:@1162.8]
  wire  _T_107; // @[riscvSingle.scala 993:33:@1163.8]
  wire  _T_109; // @[riscvSingle.scala 993:33:@1164.8]
  wire [22:0] _T_110; // @[riscvSingle.scala 993:45:@1165.8]
  wire [22:0] _T_111; // @[riscvSingle.scala 993:60:@1166.8]
  wire [22:0] _T_112; // @[riscvSingle.scala 993:21:@1167.8]
  wire [8:0] _T_117; // @[riscvSingle.scala 994:50:@1172.8]
  wire [7:0] _T_118; // @[riscvSingle.scala 994:50:@1173.8]
  wire [8:0] _T_120; // @[riscvSingle.scala 994:59:@1174.8]
  wire [8:0] _T_121; // @[riscvSingle.scala 994:59:@1175.8]
  wire [7:0] _T_122; // @[riscvSingle.scala 994:59:@1176.8]
  wire [8:0] _T_126; // @[riscvSingle.scala 994:86:@1179.8]
  wire [8:0] _T_127; // @[riscvSingle.scala 994:86:@1180.8]
  wire [7:0] _T_128; // @[riscvSingle.scala 994:86:@1181.8]
  wire [7:0] _T_129; // @[riscvSingle.scala 994:24:@1182.8]
  wire [22:0] _GEN_1; // @[riscvSingle.scala 992:63:@1161.6]
  wire [7:0] _GEN_2; // @[riscvSingle.scala 992:63:@1161.6]
  wire [22:0] fract; // @[riscvSingle.scala 989:56:@1141.4]
  wire [7:0] exponent; // @[riscvSingle.scala 989:56:@1141.4]
  wire [8:0] _T_133; // @[Cat.scala 30:58:@1189.4]
  wire  _T_137; // @[riscvSingle.scala 1024:11:@1213.4]
  wire [23:0] fpuMessage_shmant; // @[riscvSingle.scala 951:26:@1075.4 riscvSingle.scala 1013:23:@1201.4]
  wire [23:0] fpuMessage_shiftedval; // @[riscvSingle.scala 951:26:@1075.4 riscvSingle.scala 1015:27:@1203.4]
  wire [23:0] fpuMessage_addval; // @[riscvSingle.scala 951:26:@1075.4 riscvSingle.scala 1016:23:@1204.4]
  assign exp_a = io_a[30:23]; // @[riscvSingle.scala 954:18:@1076.4]
  assign _T_30 = io_a[22:0]; // @[riscvSingle.scala 955:28:@1078.4]
  assign mant_a = {1'h1,_T_30}; // @[Cat.scala 30:58:@1079.4]
  assign exp_b = io_b[30:23]; // @[riscvSingle.scala 956:18:@1081.4]
  assign _T_34 = io_b[22:0]; // @[riscvSingle.scala 957:28:@1083.4]
  assign mant_b = {1'h1,_T_34}; // @[Cat.scala 30:58:@1084.4]
  assign result = mant_a * mant_b; // @[riscvSingle.scala 961:22:@1086.4]
  assign _T_37 = exp_a - exp_b; // @[riscvSingle.scala 964:25:@1088.4]
  assign _T_38 = $unsigned(_T_37); // @[riscvSingle.scala 964:25:@1089.4]
  assign aminusb = _T_38[7:0]; // @[riscvSingle.scala 964:25:@1090.4]
  assign _T_39 = exp_b - exp_a; // @[riscvSingle.scala 965:25:@1091.4]
  assign _T_40 = $unsigned(_T_39); // @[riscvSingle.scala 965:25:@1092.4]
  assign bminusa = _T_40[7:0]; // @[riscvSingle.scala 965:25:@1093.4]
  assign alessb = aminusb[7]; // @[riscvSingle.scala 968:17:@1095.4]
  assign _T_47 = ~ alessb; // @[riscvSingle.scala 974:27:@1103.4]
  assign _T_49 = _T_47 == 1'h0; // @[riscvSingle.scala 974:27:@1104.4]
  assign exp_pre = _T_49 ? exp_b : exp_a; // @[riscvSingle.scala 974:19:@1105.4]
  assign shamt = _T_49 ? bminusa : aminusb; // @[riscvSingle.scala 975:17:@1109.4]
  assign _T_58 = mant_a >> shamt; // @[riscvSingle.scala 980:44:@1113.4]
  assign _T_59 = mant_b >> shamt; // @[riscvSingle.scala 980:63:@1114.4]
  assign _T_60 = _T_49 ? _T_58 : _T_59; // @[riscvSingle.scala 980:22:@1115.4]
  assign _T_61 = shamt[7]; // @[riscvSingle.scala 981:18:@1117.4]
  assign _T_62 = shamt[6]; // @[riscvSingle.scala 981:29:@1118.4]
  assign _T_63 = _T_61 | _T_62; // @[riscvSingle.scala 981:22:@1119.4]
  assign _T_64 = shamt[5]; // @[riscvSingle.scala 981:40:@1120.4]
  assign _T_65 = _T_63 | _T_64; // @[riscvSingle.scala 981:33:@1121.4]
  assign _T_66 = shamt[4]; // @[riscvSingle.scala 981:52:@1122.4]
  assign _T_67 = shamt[3]; // @[riscvSingle.scala 981:63:@1123.4]
  assign _T_68 = _T_66 & _T_67; // @[riscvSingle.scala 981:56:@1124.4]
  assign ovf = _T_65 | _T_68; // @[riscvSingle.scala 981:44:@1125.4]
  assign _T_70 = ~ ovf; // @[riscvSingle.scala 982:23:@1127.4]
  assign _T_72 = _T_70 == 1'h0; // @[riscvSingle.scala 982:23:@1128.4]
  assign shiftedval = {{1'd0}, _T_60}; // @[riscvSingle.scala 945:26:@1069.4 riscvSingle.scala 980:16:@1116.4]
  assign shmant = _T_72 ? 25'h0 : shiftedval; // @[riscvSingle.scala 982:18:@1129.4]
  assign _T_78 = _T_49 ? mant_b : mant_a; // @[riscvSingle.scala 986:18:@1133.4]
  assign addval = {{1'd0}, _T_78}; // @[riscvSingle.scala 946:22:@1070.4 riscvSingle.scala 986:12:@1134.4]
  assign _T_79 = shmant + addval; // @[riscvSingle.scala 987:25:@1135.4]
  assign addresult = shmant + addval; // @[riscvSingle.scala 987:25:@1136.4]
  assign _T_82 = io_fpuControl == 2'h0; // @[riscvSingle.scala 989:24:@1138.4]
  assign _T_84 = io_fpuControl == 2'h1; // @[riscvSingle.scala 989:48:@1139.4]
  assign _T_85 = _T_82 | _T_84; // @[riscvSingle.scala 989:32:@1140.4]
  assign _T_86 = addresult[24]; // @[riscvSingle.scala 990:31:@1142.6]
  assign _T_87 = ~ _T_86; // @[riscvSingle.scala 990:36:@1143.6]
  assign _T_89 = _T_87 == 1'h0; // @[riscvSingle.scala 990:36:@1144.6]
  assign _T_90 = addresult[23:1]; // @[riscvSingle.scala 990:51:@1145.6]
  assign _T_91 = addresult[22:0]; // @[riscvSingle.scala 990:69:@1146.6]
  assign _T_92 = _T_89 ? _T_90 : _T_91; // @[riscvSingle.scala 990:21:@1147.6]
  assign _T_98 = exp_pre + 8'h1; // @[riscvSingle.scala 991:54:@1152.6]
  assign _T_99 = exp_pre + 8'h1; // @[riscvSingle.scala 991:54:@1153.6]
  assign _T_100 = _T_89 ? _T_99 : exp_pre; // @[riscvSingle.scala 991:24:@1154.6]
  assign _T_102 = io_fpuControl == 2'h2; // @[riscvSingle.scala 992:31:@1158.6]
  assign _T_104 = io_fpuControl == 2'h3; // @[riscvSingle.scala 992:55:@1159.6]
  assign _T_105 = _T_102 | _T_104; // @[riscvSingle.scala 992:39:@1160.6]
  assign _T_106 = result[47]; // @[riscvSingle.scala 993:28:@1162.8]
  assign _T_107 = ~ _T_106; // @[riscvSingle.scala 993:33:@1163.8]
  assign _T_109 = _T_107 == 1'h0; // @[riscvSingle.scala 993:33:@1164.8]
  assign _T_110 = result[46:24]; // @[riscvSingle.scala 993:45:@1165.8]
  assign _T_111 = result[45:23]; // @[riscvSingle.scala 993:60:@1166.8]
  assign _T_112 = _T_109 ? _T_110 : _T_111; // @[riscvSingle.scala 993:21:@1167.8]
  assign _T_117 = exp_a + exp_b; // @[riscvSingle.scala 994:50:@1172.8]
  assign _T_118 = exp_a + exp_b; // @[riscvSingle.scala 994:50:@1173.8]
  assign _T_120 = _T_118 - 8'h7e; // @[riscvSingle.scala 994:59:@1174.8]
  assign _T_121 = $unsigned(_T_120); // @[riscvSingle.scala 994:59:@1175.8]
  assign _T_122 = _T_121[7:0]; // @[riscvSingle.scala 994:59:@1176.8]
  assign _T_126 = _T_118 - 8'h7f; // @[riscvSingle.scala 994:86:@1179.8]
  assign _T_127 = $unsigned(_T_126); // @[riscvSingle.scala 994:86:@1180.8]
  assign _T_128 = _T_127[7:0]; // @[riscvSingle.scala 994:86:@1181.8]
  assign _T_129 = _T_109 ? _T_122 : _T_128; // @[riscvSingle.scala 994:24:@1182.8]
  assign _GEN_1 = _T_105 ? _T_112 : 23'h0; // @[riscvSingle.scala 992:63:@1161.6]
  assign _GEN_2 = _T_105 ? _T_129 : 8'h0; // @[riscvSingle.scala 992:63:@1161.6]
  assign fract = _T_85 ? _T_92 : _GEN_1; // @[riscvSingle.scala 989:56:@1141.4]
  assign exponent = _T_85 ? _T_100 : _GEN_2; // @[riscvSingle.scala 989:56:@1141.4]
  assign _T_133 = {1'h0,exponent}; // @[Cat.scala 30:58:@1189.4]
  assign _T_137 = reset == 1'h0; // @[riscvSingle.scala 1024:11:@1213.4]
  assign fpuMessage_shmant = shmant[23:0]; // @[riscvSingle.scala 951:26:@1075.4 riscvSingle.scala 1013:23:@1201.4]
  assign fpuMessage_shiftedval = shiftedval[23:0]; // @[riscvSingle.scala 951:26:@1075.4 riscvSingle.scala 1015:27:@1203.4]
  assign fpuMessage_addval = addval[23:0]; // @[riscvSingle.scala 951:26:@1075.4 riscvSingle.scala 1016:23:@1204.4]
  assign io_s = {_T_133,fract}; // @[riscvSingle.scala 1002:10:@1191.4]
  always @(posedge clk) begin
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_137) begin
          $fwrite(32'h80000002,"\n\n\n___________________________\n|fpadd Module:\n|  a          : 0x%x\n|  b          : 0x%x\n|  mant_a     : b%b\n|  mant_b     : b%b\n|  exp_a      : b%b\n|  exp_b      : b%b\n|  aminusb    : b%b\n|  bminusa    : b%b\n|  alessb     : b%b\n|  exp_pre    : b%b\n|  shamt      : b%b\n|  shiftedval : b%b\n|  ovf        : b%b\n|  shmant     : 0x%x\n|  addval     : 0x%x\n|  addresult  : 0x%x\n|  result     : 0x%x\n|  exponent   : b%b\n|  fract      : b%b\n|  s          : 0x%x\n|___________________________\n",io_a,io_b,mant_a,mant_b,exp_a,exp_b,fpuMessage_shmant,shamt,alessb,exp_pre,shamt,fpuMessage_shiftedval,ovf,fpuMessage_shmant,fpuMessage_addval,addresult,result,exponent,fract,io_s); // @[riscvSingle.scala 1024:11:@1215.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module extend( // @[:@1218.2]
  input         clk, // @[:@1219.4]
  input         reset, // @[:@1220.4]
  input  [11:0] io_instr12, // @[:@1221.4]
  input  [19:0] io_instr20, // @[:@1221.4]
  input  [1:0]  io_immSrc, // @[:@1221.4]
  output [31:0] io_extImm // @[:@1221.4]
);
  wire  _T_15; // @[riscvSingle.scala 154:20:@1224.4]
  wire [11:0] _T_16; // @[riscvSingle.scala 155:33:@1226.6]
  wire  _T_18; // @[riscvSingle.scala 156:26:@1230.6]
  wire [12:0] _T_20; // @[Cat.scala 30:58:@1232.8]
  wire [12:0] _T_21; // @[riscvSingle.scala 157:50:@1233.8]
  wire  _T_23; // @[riscvSingle.scala 158:26:@1237.8]
  wire [20:0] _T_25; // @[Cat.scala 30:58:@1239.10]
  wire [20:0] _T_26; // @[riscvSingle.scala 159:50:@1240.10]
  wire [20:0] _GEN_0; // @[riscvSingle.scala 158:34:@1238.8]
  wire [20:0] _GEN_1; // @[riscvSingle.scala 156:34:@1231.6]
  wire [20:0] _GEN_2; // @[riscvSingle.scala 154:28:@1225.4]
  wire  _T_30; // @[riscvSingle.scala 167:11:@1251.4]
  assign _T_15 = io_immSrc == 2'h0; // @[riscvSingle.scala 154:20:@1224.4]
  assign _T_16 = $signed(io_instr12); // @[riscvSingle.scala 155:33:@1226.6]
  assign _T_18 = io_immSrc == 2'h1; // @[riscvSingle.scala 156:26:@1230.6]
  assign _T_20 = {io_instr12,1'h0}; // @[Cat.scala 30:58:@1232.8]
  assign _T_21 = $signed(_T_20); // @[riscvSingle.scala 157:50:@1233.8]
  assign _T_23 = io_immSrc == 2'h2; // @[riscvSingle.scala 158:26:@1237.8]
  assign _T_25 = {io_instr20,1'h0}; // @[Cat.scala 30:58:@1239.10]
  assign _T_26 = $signed(_T_25); // @[riscvSingle.scala 159:50:@1240.10]
  assign _GEN_0 = _T_23 ? $signed(_T_26) : $signed(21'sh0); // @[riscvSingle.scala 158:34:@1238.8]
  assign _GEN_1 = _T_18 ? $signed({{8{_T_21[12]}},_T_21}) : $signed(_GEN_0); // @[riscvSingle.scala 156:34:@1231.6]
  assign _GEN_2 = _T_15 ? $signed({{9{_T_16[11]}},_T_16}) : $signed(_GEN_1); // @[riscvSingle.scala 154:28:@1225.4]
  assign _T_30 = reset == 1'h0; // @[riscvSingle.scala 167:11:@1251.4]
  assign io_extImm = {{11{_GEN_2[20]}},_GEN_2}; // @[riscvSingle.scala 155:19:@1227.6 riscvSingle.scala 157:19:@1234.8 riscvSingle.scala 159:19:@1241.10 riscvSingle.scala 161:19:@1244.10]
  always @(posedge clk) begin
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_30) begin
          $fwrite(32'h80000002,"\n\n\n___________________________\n|extend Module:\n|  instr12     : b%b\n|  instr20     : b%b\n|  immsrc      : b%b\n|  extImm      : 0x%x\n|___________________________\n",io_instr12,io_instr20,io_immSrc,io_extImm); // @[riscvSingle.scala 167:11:@1253.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module datapath( // @[:@1294.2]
  input         clk, // @[:@1295.4]
  input         reset, // @[:@1296.4]
  inout  [2:0]  io_regSrc, // @[:@1297.4]
  input         io_regWriteEnable, // @[:@1297.4]
  input         io_fpuRegWriteEnable, // @[:@1297.4]
  input  [1:0]  io_immSrc, // @[:@1297.4]
  input         io_aluSrc, // @[:@1297.4]
  input         io_pcSrc, // @[:@1297.4]
  input  [3:0]  io_aluControl, // @[:@1297.4]
  input  [1:0]  io_fpuControl, // @[:@1297.4]
  input         io_memToReg, // @[:@1297.4]
  input  [31:0] io_instr, // @[:@1297.4]
  input  [31:0] io_memReadData, // @[:@1297.4]
  input  [1:0]  io_branchSrc, // @[:@1297.4]
  output [31:0] io_pc, // @[:@1297.4]
  output [31:0] io_memAddress, // @[:@1297.4]
  output [31:0] io_memWriteData, // @[:@1297.4]
  output        io_zeroFlag, // @[:@1297.4]
  output        io_lessThanFlag, // @[:@1297.4]
  output        io_greaterThanFlag // @[:@1297.4]
);
  wire  rf_clk; // @[riscvSingle.scala 550:20:@1300.4]
  wire  rf_reset; // @[riscvSingle.scala 550:20:@1300.4]
  wire  rf_io_regWriteEnable; // @[riscvSingle.scala 550:20:@1300.4]
  wire [4:0] rf_io_regWriteAddress; // @[riscvSingle.scala 550:20:@1300.4]
  wire [31:0] rf_io_regWriteData; // @[riscvSingle.scala 550:20:@1300.4]
  wire [4:0] rf_io_regReadAddress1; // @[riscvSingle.scala 550:20:@1300.4]
  wire [4:0] rf_io_regReadAddress2; // @[riscvSingle.scala 550:20:@1300.4]
  wire [31:0] rf_io_regReadData1; // @[riscvSingle.scala 550:20:@1300.4]
  wire [31:0] rf_io_regReadData2; // @[riscvSingle.scala 550:20:@1300.4]
  wire  fpurf_clk; // @[riscvSingle.scala 551:23:@1303.4]
  wire  fpurf_reset; // @[riscvSingle.scala 551:23:@1303.4]
  wire  fpurf_io_fpuRegWriteEnable; // @[riscvSingle.scala 551:23:@1303.4]
  wire [4:0] fpurf_io_fpuRegWriteAddress; // @[riscvSingle.scala 551:23:@1303.4]
  wire [31:0] fpurf_io_fpuRegWriteData; // @[riscvSingle.scala 551:23:@1303.4]
  wire [4:0] fpurf_io_fpuRegReadAddress1; // @[riscvSingle.scala 551:23:@1303.4]
  wire [4:0] fpurf_io_fpuRegReadAddress2; // @[riscvSingle.scala 551:23:@1303.4]
  wire [31:0] fpurf_io_fpuRegReadData1; // @[riscvSingle.scala 551:23:@1303.4]
  wire [31:0] fpurf_io_fpuRegReadData2; // @[riscvSingle.scala 551:23:@1303.4]
  wire  alu_clk; // @[riscvSingle.scala 552:21:@1306.4]
  wire  alu_reset; // @[riscvSingle.scala 552:21:@1306.4]
  wire [31:0] alu_io_a; // @[riscvSingle.scala 552:21:@1306.4]
  wire [31:0] alu_io_b; // @[riscvSingle.scala 552:21:@1306.4]
  wire [3:0] alu_io_aluControl; // @[riscvSingle.scala 552:21:@1306.4]
  wire [31:0] alu_io_out; // @[riscvSingle.scala 552:21:@1306.4]
  wire  alu_io_zeroFlag; // @[riscvSingle.scala 552:21:@1306.4]
  wire  alu_io_lessThanFlag; // @[riscvSingle.scala 552:21:@1306.4]
  wire  alu_io_greaterThanFlag; // @[riscvSingle.scala 552:21:@1306.4]
  wire  fpu_clk; // @[riscvSingle.scala 553:21:@1309.4]
  wire  fpu_reset; // @[riscvSingle.scala 553:21:@1309.4]
  wire [31:0] fpu_io_a; // @[riscvSingle.scala 553:21:@1309.4]
  wire [31:0] fpu_io_b; // @[riscvSingle.scala 553:21:@1309.4]
  wire [1:0] fpu_io_fpuControl; // @[riscvSingle.scala 553:21:@1309.4]
  wire [31:0] fpu_io_s; // @[riscvSingle.scala 553:21:@1309.4]
  wire  ext1_clk; // @[riscvSingle.scala 554:22:@1312.4]
  wire  ext1_reset; // @[riscvSingle.scala 554:22:@1312.4]
  wire [11:0] ext1_io_instr12; // @[riscvSingle.scala 554:22:@1312.4]
  wire [19:0] ext1_io_instr20; // @[riscvSingle.scala 554:22:@1312.4]
  wire [1:0] ext1_io_immSrc; // @[riscvSingle.scala 554:22:@1312.4]
  wire [31:0] ext1_io_extImm; // @[riscvSingle.scala 554:22:@1312.4]
  wire  ext2_clk; // @[riscvSingle.scala 555:22:@1315.4]
  wire  ext2_reset; // @[riscvSingle.scala 555:22:@1315.4]
  wire [11:0] ext2_io_instr12; // @[riscvSingle.scala 555:22:@1315.4]
  wire [19:0] ext2_io_instr20; // @[riscvSingle.scala 555:22:@1315.4]
  wire [1:0] ext2_io_immSrc; // @[riscvSingle.scala 555:22:@1315.4]
  wire [31:0] ext2_io_extImm; // @[riscvSingle.scala 555:22:@1315.4]
  wire  _T_52; // @[riscvSingle.scala 568:30:@1328.4]
  wire  _T_53; // @[riscvSingle.scala 568:44:@1329.4]
  wire [5:0] _T_54; // @[riscvSingle.scala 568:57:@1330.4]
  wire [3:0] _T_55; // @[riscvSingle.scala 568:74:@1331.4]
  wire [9:0] _T_56; // @[Cat.scala 30:58:@1332.4]
  wire [1:0] _T_57; // @[Cat.scala 30:58:@1333.4]
  wire [7:0] _T_60; // @[riscvSingle.scala 569:42:@1337.4]
  wire  _T_61; // @[riscvSingle.scala 569:59:@1338.4]
  wire [9:0] _T_62; // @[riscvSingle.scala 569:73:@1339.4]
  wire [19:0] _T_65; // @[Cat.scala 30:58:@1342.4]
  wire [19:0] _T_66; // @[riscvSingle.scala 570:28:@1344.4]
  wire [31:0] _T_68; // @[Cat.scala 30:58:@1345.4]
  wire [31:0] auiImm; // @[riscvSingle.scala 570:49:@1346.4]
  wire  _T_71; // @[riscvSingle.scala 578:28:@1356.4]
  wire  _T_73; // @[riscvSingle.scala 578:28:@1357.4]
  wire [31:0] extImm; // @[riscvSingle.scala 578:18:@1358.4]
  reg [31:0] pcReg; // @[riscvSingle.scala 582:25:@1360.4]
  reg [31:0] _RAND_0;
  wire [32:0] _T_82; // @[riscvSingle.scala 587:22:@1365.4]
  wire [31:0] pcPlus4; // @[riscvSingle.scala 587:22:@1366.4]
  wire [31:0] _T_87; // @[riscvSingle.scala 589:40:@1371.4]
  wire [31:0] branchExtImm; // @[riscvSingle.scala 560:28:@1322.4 riscvSingle.scala 577:18:@1355.4]
  wire [32:0] _T_88; // @[riscvSingle.scala 589:30:@1372.4]
  wire [31:0] _T_89; // @[riscvSingle.scala 589:30:@1373.4]
  wire [31:0] pcBranch; // @[riscvSingle.scala 589:30:@1374.4]
  wire [31:0] _T_91; // @[riscvSingle.scala 590:31:@1376.4]
  wire [31:0] pcRegBranch; // @[riscvSingle.scala 590:38:@1377.4]
  wire  _T_94; // @[riscvSingle.scala 591:31:@1379.4]
  wire  _T_95; // @[riscvSingle.scala 591:35:@1380.4]
  wire  _T_97; // @[riscvSingle.scala 591:35:@1381.4]
  wire  _T_98; // @[riscvSingle.scala 591:70:@1382.4]
  wire  _T_99; // @[riscvSingle.scala 591:74:@1383.4]
  wire  _T_101; // @[riscvSingle.scala 591:74:@1384.4]
  wire [31:0] _T_102; // @[riscvSingle.scala 591:89:@1385.4]
  wire [31:0] _T_103; // @[riscvSingle.scala 591:57:@1386.4]
  wire [31:0] pcNext; // @[riscvSingle.scala 591:18:@1387.4]
  wire [6:0] _T_105; // @[riscvSingle.scala 597:28:@1391.4]
  wire [4:0] _T_106; // @[riscvSingle.scala 597:45:@1392.4]
  wire [11:0] _T_107; // @[Cat.scala 30:58:@1393.4]
  wire [11:0] _T_108; // @[riscvSingle.scala 597:54:@1394.4]
  wire  _T_109; // @[riscvSingle.scala 600:40:@1396.4]
  wire  _T_111; // @[riscvSingle.scala 600:40:@1397.4]
  wire [31:0] memImm; // @[riscvSingle.scala 559:22:@1321.4 riscvSingle.scala 597:12:@1395.4]
  wire [31:0] _T_112; // @[riscvSingle.scala 600:27:@1398.4]
  wire [32:0] _T_113; // @[riscvSingle.scala 600:70:@1399.4]
  wire [31:0] _T_114; // @[riscvSingle.scala 600:70:@1400.4]
  wire [31:0] _T_115; // @[riscvSingle.scala 600:70:@1401.4]
  wire  _T_117; // @[riscvSingle.scala 603:37:@1404.4]
  wire  _T_118; // @[riscvSingle.scala 603:41:@1405.4]
  wire  _T_120; // @[riscvSingle.scala 603:41:@1406.4]
  wire [4:0] _T_122; // @[riscvSingle.scala 603:67:@1407.4]
  wire  _T_124; // @[riscvSingle.scala 604:37:@1410.4]
  wire  _T_125; // @[riscvSingle.scala 604:41:@1411.4]
  wire  _T_127; // @[riscvSingle.scala 604:41:@1412.4]
  wire [4:0] _T_129; // @[riscvSingle.scala 604:71:@1414.4]
  wire  _T_131; // @[riscvSingle.scala 605:34:@1417.4]
  wire  _T_132; // @[riscvSingle.scala 605:38:@1418.4]
  wire  _T_134; // @[riscvSingle.scala 605:38:@1419.4]
  wire [31:0] _T_139; // @[riscvSingle.scala 605:63:@1423.4]
  wire [31:0] regWriteData; // @[riscvSingle.scala 605:24:@1424.4]
  wire  _T_151; // @[riscvSingle.scala 630:31:@1450.4]
  wire  _T_153; // @[riscvSingle.scala 630:31:@1451.4]
  wire  _T_157; // @[riscvSingle.scala 654:11:@1477.4]
  wire [31:0] datapathMessage_aluOut; // @[riscvSingle.scala 549:31:@1299.4 riscvSingle.scala 640:28:@1462.4]
  wire [31:0] datapathMessage_regReadData2; // @[riscvSingle.scala 549:31:@1299.4 riscvSingle.scala 644:34:@1466.4]
  wire [1:0] datapathMessage_regSrc; // @[riscvSingle.scala 549:31:@1299.4 riscvSingle.scala 653:28:@1475.4]
  wire [11:0] jumpImm; // @[riscvSingle.scala 557:23:@1319.4 riscvSingle.scala 569:13:@1343.4]
  regfile rf ( // @[riscvSingle.scala 550:20:@1300.4]
    .clk(rf_clk),
    .reset(rf_reset),
    .io_regWriteEnable(rf_io_regWriteEnable),
    .io_regWriteAddress(rf_io_regWriteAddress),
    .io_regWriteData(rf_io_regWriteData),
    .io_regReadAddress1(rf_io_regReadAddress1),
    .io_regReadAddress2(rf_io_regReadAddress2),
    .io_regReadData1(rf_io_regReadData1),
    .io_regReadData2(rf_io_regReadData2)
  );
  fpuRegfile fpurf ( // @[riscvSingle.scala 551:23:@1303.4]
    .clk(fpurf_clk),
    .reset(fpurf_reset),
    .io_fpuRegWriteEnable(fpurf_io_fpuRegWriteEnable),
    .io_fpuRegWriteAddress(fpurf_io_fpuRegWriteAddress),
    .io_fpuRegWriteData(fpurf_io_fpuRegWriteData),
    .io_fpuRegReadAddress1(fpurf_io_fpuRegReadAddress1),
    .io_fpuRegReadAddress2(fpurf_io_fpuRegReadAddress2),
    .io_fpuRegReadData1(fpurf_io_fpuRegReadData1),
    .io_fpuRegReadData2(fpurf_io_fpuRegReadData2)
  );
  alu alu ( // @[riscvSingle.scala 552:21:@1306.4]
    .clk(alu_clk),
    .reset(alu_reset),
    .io_a(alu_io_a),
    .io_b(alu_io_b),
    .io_aluControl(alu_io_aluControl),
    .io_out(alu_io_out),
    .io_zeroFlag(alu_io_zeroFlag),
    .io_lessThanFlag(alu_io_lessThanFlag),
    .io_greaterThanFlag(alu_io_greaterThanFlag)
  );
  fpu fpu ( // @[riscvSingle.scala 553:21:@1309.4]
    .clk(fpu_clk),
    .reset(fpu_reset),
    .io_a(fpu_io_a),
    .io_b(fpu_io_b),
    .io_fpuControl(fpu_io_fpuControl),
    .io_s(fpu_io_s)
  );
  extend ext1 ( // @[riscvSingle.scala 554:22:@1312.4]
    .clk(ext1_clk),
    .reset(ext1_reset),
    .io_instr12(ext1_io_instr12),
    .io_instr20(ext1_io_instr20),
    .io_immSrc(ext1_io_immSrc),
    .io_extImm(ext1_io_extImm)
  );
  extend ext2 ( // @[riscvSingle.scala 555:22:@1315.4]
    .clk(ext2_clk),
    .reset(ext2_reset),
    .io_instr12(ext2_io_instr12),
    .io_instr20(ext2_io_instr20),
    .io_immSrc(ext2_io_immSrc),
    .io_extImm(ext2_io_extImm)
  );
  assign _T_52 = io_instr[31]; // @[riscvSingle.scala 568:30:@1328.4]
  assign _T_53 = io_instr[7]; // @[riscvSingle.scala 568:44:@1329.4]
  assign _T_54 = io_instr[30:25]; // @[riscvSingle.scala 568:57:@1330.4]
  assign _T_55 = io_instr[11:8]; // @[riscvSingle.scala 568:74:@1331.4]
  assign _T_56 = {_T_54,_T_55}; // @[Cat.scala 30:58:@1332.4]
  assign _T_57 = {_T_52,_T_53}; // @[Cat.scala 30:58:@1333.4]
  assign _T_60 = io_instr[19:12]; // @[riscvSingle.scala 569:42:@1337.4]
  assign _T_61 = io_instr[20]; // @[riscvSingle.scala 569:59:@1338.4]
  assign _T_62 = io_instr[30:21]; // @[riscvSingle.scala 569:73:@1339.4]
  assign _T_65 = {_T_52,_T_60,_T_61,_T_62}; // @[Cat.scala 30:58:@1342.4]
  assign _T_66 = io_instr[31:12]; // @[riscvSingle.scala 570:28:@1344.4]
  assign _T_68 = {_T_66,12'h0}; // @[Cat.scala 30:58:@1345.4]
  assign auiImm = $signed(_T_68); // @[riscvSingle.scala 570:49:@1346.4]
  assign _T_71 = ~ io_pcSrc; // @[riscvSingle.scala 578:28:@1356.4]
  assign _T_73 = _T_71 == 1'h0; // @[riscvSingle.scala 578:28:@1357.4]
  assign extImm = _T_73 ? $signed(auiImm) : $signed(ext2_io_extImm); // @[riscvSingle.scala 578:18:@1358.4]
  assign _T_82 = pcReg + 32'h4; // @[riscvSingle.scala 587:22:@1365.4]
  assign pcPlus4 = pcReg + 32'h4; // @[riscvSingle.scala 587:22:@1366.4]
  assign _T_87 = $signed(pcPlus4); // @[riscvSingle.scala 589:40:@1371.4]
  assign branchExtImm = ext1_io_extImm; // @[riscvSingle.scala 560:28:@1322.4 riscvSingle.scala 577:18:@1355.4]
  assign _T_88 = $signed(branchExtImm) + $signed(_T_87); // @[riscvSingle.scala 589:30:@1372.4]
  assign _T_89 = $signed(branchExtImm) + $signed(_T_87); // @[riscvSingle.scala 589:30:@1373.4]
  assign pcBranch = $signed(_T_89); // @[riscvSingle.scala 589:30:@1374.4]
  assign _T_91 = $unsigned(alu_io_out); // @[riscvSingle.scala 590:31:@1376.4]
  assign pcRegBranch = _T_91 & 32'hfffffffe; // @[riscvSingle.scala 590:38:@1377.4]
  assign _T_94 = io_branchSrc[1]; // @[riscvSingle.scala 591:31:@1379.4]
  assign _T_95 = ~ _T_94; // @[riscvSingle.scala 591:35:@1380.4]
  assign _T_97 = _T_95 == 1'h0; // @[riscvSingle.scala 591:35:@1381.4]
  assign _T_98 = io_branchSrc[0]; // @[riscvSingle.scala 591:70:@1382.4]
  assign _T_99 = ~ _T_98; // @[riscvSingle.scala 591:74:@1383.4]
  assign _T_101 = _T_99 == 1'h0; // @[riscvSingle.scala 591:74:@1384.4]
  assign _T_102 = $unsigned(pcBranch); // @[riscvSingle.scala 591:89:@1385.4]
  assign _T_103 = _T_101 ? _T_102 : pcPlus4; // @[riscvSingle.scala 591:57:@1386.4]
  assign pcNext = _T_97 ? pcRegBranch : _T_103; // @[riscvSingle.scala 591:18:@1387.4]
  assign _T_105 = io_instr[31:25]; // @[riscvSingle.scala 597:28:@1391.4]
  assign _T_106 = io_instr[11:7]; // @[riscvSingle.scala 597:45:@1392.4]
  assign _T_107 = {_T_105,_T_106}; // @[Cat.scala 30:58:@1393.4]
  assign _T_108 = $signed(_T_107); // @[riscvSingle.scala 597:54:@1394.4]
  assign _T_109 = ~ io_memToReg; // @[riscvSingle.scala 600:40:@1396.4]
  assign _T_111 = _T_109 == 1'h0; // @[riscvSingle.scala 600:40:@1397.4]
  assign memImm = {{20{_T_108[11]}},_T_108}; // @[riscvSingle.scala 559:22:@1321.4 riscvSingle.scala 597:12:@1395.4]
  assign _T_112 = _T_111 ? $signed(extImm) : $signed(memImm); // @[riscvSingle.scala 600:27:@1398.4]
  assign _T_113 = $signed(_T_112) + $signed(rf_io_regReadData1); // @[riscvSingle.scala 600:70:@1399.4]
  assign _T_114 = $signed(_T_112) + $signed(rf_io_regReadData1); // @[riscvSingle.scala 600:70:@1400.4]
  assign _T_115 = $signed(_T_114); // @[riscvSingle.scala 600:70:@1401.4]
  assign _T_117 = io_regSrc[0]; // @[riscvSingle.scala 603:37:@1404.4]
  assign _T_118 = ~ _T_117; // @[riscvSingle.scala 603:41:@1405.4]
  assign _T_120 = _T_118 == 1'h0; // @[riscvSingle.scala 603:41:@1406.4]
  assign _T_122 = io_instr[19:15]; // @[riscvSingle.scala 603:67:@1407.4]
  assign _T_124 = io_regSrc[1]; // @[riscvSingle.scala 604:37:@1410.4]
  assign _T_125 = ~ _T_124; // @[riscvSingle.scala 604:41:@1411.4]
  assign _T_127 = _T_125 == 1'h0; // @[riscvSingle.scala 604:41:@1412.4]
  assign _T_129 = io_instr[24:20]; // @[riscvSingle.scala 604:71:@1414.4]
  assign _T_131 = io_regSrc[2]; // @[riscvSingle.scala 605:34:@1417.4]
  assign _T_132 = ~ _T_131; // @[riscvSingle.scala 605:38:@1418.4]
  assign _T_134 = _T_132 == 1'h0; // @[riscvSingle.scala 605:38:@1419.4]
  assign _T_139 = _T_111 ? $signed(io_memReadData) : $signed(alu_io_out); // @[riscvSingle.scala 605:63:@1423.4]
  assign regWriteData = _T_134 ? $signed(_T_87) : $signed(_T_139); // @[riscvSingle.scala 605:24:@1424.4]
  assign _T_151 = ~ io_aluSrc; // @[riscvSingle.scala 630:31:@1450.4]
  assign _T_153 = _T_151 == 1'h0; // @[riscvSingle.scala 630:31:@1451.4]
  assign _T_157 = reset == 1'h0; // @[riscvSingle.scala 654:11:@1477.4]
  assign datapathMessage_aluOut = alu_io_out; // @[riscvSingle.scala 549:31:@1299.4 riscvSingle.scala 640:28:@1462.4]
  assign datapathMessage_regReadData2 = rf_io_regReadData2; // @[riscvSingle.scala 549:31:@1299.4 riscvSingle.scala 644:34:@1466.4]
  assign datapathMessage_regSrc = io_regSrc[1:0]; // @[riscvSingle.scala 549:31:@1299.4 riscvSingle.scala 653:28:@1475.4]
  assign jumpImm = _T_65[11:0]; // @[riscvSingle.scala 557:23:@1319.4 riscvSingle.scala 569:13:@1343.4]
  assign io_pc = pcReg; // @[riscvSingle.scala 593:11:@1390.4]
  assign io_memAddress = $unsigned(_T_115); // @[riscvSingle.scala 600:19:@1403.4]
  assign io_memWriteData = rf_io_regReadData2; // @[riscvSingle.scala 611:21:@1432.4]
  assign io_zeroFlag = alu_io_zeroFlag; // @[riscvSingle.scala 632:17:@1455.4]
  assign io_lessThanFlag = alu_io_lessThanFlag; // @[riscvSingle.scala 633:21:@1456.4]
  assign io_greaterThanFlag = alu_io_greaterThanFlag; // @[riscvSingle.scala 634:24:@1457.4]
  assign rf_clk = clk; // @[:@1301.4]
  assign rf_reset = reset; // @[:@1302.4]
  assign rf_io_regWriteEnable = io_regWriteEnable; // @[riscvSingle.scala 606:26:@1426.4]
  assign rf_io_regWriteAddress = io_instr[11:7]; // @[riscvSingle.scala 609:27:@1430.4]
  assign rf_io_regWriteData = _T_134 ? $signed(_T_87) : $signed(_T_139); // @[riscvSingle.scala 610:24:@1431.4]
  assign rf_io_regReadAddress1 = _T_120 ? 5'h1f : _T_122; // @[riscvSingle.scala 607:27:@1427.4]
  assign rf_io_regReadAddress2 = _T_127 ? _T_106 : _T_129; // @[riscvSingle.scala 608:27:@1428.4]
  assign fpurf_clk = clk; // @[:@1304.4]
  assign fpurf_reset = reset; // @[:@1305.4]
  assign fpurf_io_fpuRegWriteEnable = io_fpuRegWriteEnable; // @[riscvSingle.scala 621:32:@1436.4]
  assign fpurf_io_fpuRegWriteAddress = io_instr[11:7]; // @[riscvSingle.scala 622:33:@1438.4]
  assign fpurf_io_fpuRegWriteData = $signed(fpu_io_s); // @[riscvSingle.scala 623:30:@1440.4]
  assign fpurf_io_fpuRegReadAddress1 = io_instr[19:15]; // @[riscvSingle.scala 624:33:@1442.4]
  assign fpurf_io_fpuRegReadAddress2 = io_instr[24:20]; // @[riscvSingle.scala 625:33:@1444.4]
  assign alu_clk = clk; // @[:@1307.4]
  assign alu_reset = reset; // @[:@1308.4]
  assign alu_io_a = _T_73 ? $signed(_T_87) : $signed(rf_io_regReadData1); // @[riscvSingle.scala 629:14:@1449.4]
  assign alu_io_b = _T_153 ? $signed(extImm) : $signed(rf_io_regReadData2); // @[riscvSingle.scala 630:14:@1453.4]
  assign alu_io_aluControl = io_aluControl; // @[riscvSingle.scala 631:23:@1454.4]
  assign fpu_clk = clk; // @[:@1310.4]
  assign fpu_reset = reset; // @[:@1311.4]
  assign fpu_io_a = fpurf_io_fpuRegReadData1; // @[riscvSingle.scala 615:14:@1433.4]
  assign fpu_io_b = fpurf_io_fpuRegReadData2; // @[riscvSingle.scala 616:14:@1434.4]
  assign fpu_io_fpuControl = io_fpuControl; // @[riscvSingle.scala 617:23:@1435.4]
  assign ext1_clk = clk; // @[:@1313.4]
  assign ext1_reset = reset; // @[:@1314.4]
  assign ext1_io_instr12 = {_T_57,_T_56}; // @[riscvSingle.scala 571:21:@1348.4]
  assign ext1_io_instr20 = {{8'd0}, jumpImm}; // @[riscvSingle.scala 572:21:@1349.4]
  assign ext1_io_immSrc = io_immSrc; // @[riscvSingle.scala 573:20:@1350.4]
  assign ext2_clk = clk; // @[:@1316.4]
  assign ext2_reset = reset; // @[:@1317.4]
  assign ext2_io_instr12 = io_instr[31:20]; // @[riscvSingle.scala 574:21:@1352.4]
  assign ext2_io_instr20 = {{8'd0}, jumpImm}; // @[riscvSingle.scala 575:21:@1353.4]
  assign ext2_io_immSrc = io_immSrc; // @[riscvSingle.scala 576:20:@1354.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  pcReg = _RAND_0[31:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clk) begin
    if (reset) begin
      pcReg <= 32'h0;
    end else begin
      if (_T_97) begin
        pcReg <= pcRegBranch;
      end else begin
        if (_T_101) begin
          pcReg <= _T_102;
        end else begin
          pcReg <= pcPlus4;
        end
      end
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_157) begin
          $fwrite(32'h80000002,"\n\n\n___________________________\n|datapath Module:\n|  inst            : 0x%x\n|  memToReg        : b%b\n|  memImm          : b%b\n|  memAddress      : 0x%x\n|  memReadData     : 0x%x\n|  memWriteData    : 0x%x\n|  aluOut          : 0x%x\n|  pcNext          : 0x%x\n|  branchExtImm    : 0x%x\n|  extImm          : 0x%x\n|  regReadData2    : 0x%x\n|  regWriteData    : 0x%x\n|  regSrc          : 0x%x\n|  pcBranch        : 0x%x\n|  pcRegBranch     : 0x%x\n|  pcPlus4         : 0x%x\n|  branchSrc       : b%b\n|___________________________\n",io_instr,io_memToReg,memImm,io_memAddress,io_memReadData,io_memWriteData,datapathMessage_aluOut,pcNext,branchExtImm,extImm,datapathMessage_regReadData2,regWriteData,datapathMessage_regSrc,pcBranch,pcRegBranch,pcPlus4,io_branchSrc); // @[riscvSingle.scala 654:11:@1479.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module decoder( // @[:@1482.2]
  input        clk, // @[:@1483.4]
  input        reset, // @[:@1484.4]
  input  [6:0] io_opcode, // @[:@1485.4]
  input  [6:0] io_funct7, // @[:@1485.4]
  input  [2:0] io_funct3, // @[:@1485.4]
  output [2:0] io_regSrc, // @[:@1485.4]
  output       io_regWriteEnable, // @[:@1485.4]
  output       io_fpuRegWriteEnable, // @[:@1485.4]
  output [1:0] io_immSrc, // @[:@1485.4]
  output       io_aluSrc, // @[:@1485.4]
  output       io_pcSrc, // @[:@1485.4]
  output [3:0] io_aluControl, // @[:@1485.4]
  output [1:0] io_fpuControl, // @[:@1485.4]
  output       io_memWriteEnable, // @[:@1485.4]
  output       io_memToReg, // @[:@1485.4]
  output [1:0] io_branchSrc, // @[:@1485.4]
  input        io_zeroFlag, // @[:@1485.4]
  input        io_lessThanFlag, // @[:@1485.4]
  input        io_greaterThanFlag // @[:@1485.4]
);
  wire  _T_41; // @[riscvSingle.scala 235:20:@1488.4]
  wire  _T_53; // @[riscvSingle.scala 247:24:@1500.6]
  wire  _T_55; // @[riscvSingle.scala 248:28:@1502.8]
  wire  _T_58; // @[riscvSingle.scala 250:34:@1507.10]
  wire  _T_61; // @[riscvSingle.scala 252:34:@1512.12]
  wire  _T_64; // @[riscvSingle.scala 254:34:@1517.14]
  wire  _T_67; // @[riscvSingle.scala 256:34:@1522.16]
  wire  _T_70; // @[riscvSingle.scala 258:34:@1527.18]
  wire  _T_73; // @[riscvSingle.scala 260:34:@1532.20]
  wire  _T_76; // @[riscvSingle.scala 262:34:@1537.22]
  wire [3:0] _GEN_0; // @[riscvSingle.scala 262:48:@1538.22]
  wire [3:0] _GEN_1; // @[riscvSingle.scala 260:48:@1533.20]
  wire [3:0] _GEN_2; // @[riscvSingle.scala 258:48:@1528.18]
  wire [3:0] _GEN_3; // @[riscvSingle.scala 256:48:@1523.16]
  wire [3:0] _GEN_4; // @[riscvSingle.scala 254:48:@1518.14]
  wire [3:0] _GEN_5; // @[riscvSingle.scala 252:48:@1513.12]
  wire [3:0] _GEN_6; // @[riscvSingle.scala 250:48:@1508.10]
  wire [3:0] _GEN_7; // @[riscvSingle.scala 248:42:@1503.8]
  wire  _T_80; // @[riscvSingle.scala 267:30:@1546.8]
  wire [3:0] _GEN_8; // @[riscvSingle.scala 270:47:@1554.12]
  wire [3:0] _GEN_9; // @[riscvSingle.scala 268:41:@1549.10]
  wire  _T_89; // @[riscvSingle.scala 275:30:@1562.10]
  wire [3:0] _GEN_10; // @[riscvSingle.scala 278:47:@1570.14]
  wire [3:0] _GEN_11; // @[riscvSingle.scala 276:43:@1565.12]
  wire [3:0] _GEN_12; // @[riscvSingle.scala 275:47:@1563.10]
  wire [3:0] _GEN_13; // @[riscvSingle.scala 267:47:@1547.8]
  wire [3:0] _GEN_14; // @[riscvSingle.scala 247:42:@1501.6]
  wire  _T_99; // @[riscvSingle.scala 286:26:@1582.6]
  wire  _T_112; // @[riscvSingle.scala 298:26:@1597.8]
  wire [5:0] _T_123; // @[riscvSingle.scala 310:24:@1609.10]
  wire  _T_125; // @[riscvSingle.scala 310:30:@1610.10]
  wire [3:0] _GEN_15; // @[riscvSingle.scala 311:41:@1613.12]
  wire [2:0] _GEN_17; // @[riscvSingle.scala 327:48:@1647.22]
  wire [2:0] _GEN_18; // @[riscvSingle.scala 325:48:@1642.20]
  wire [2:0] _GEN_19; // @[riscvSingle.scala 323:48:@1637.18]
  wire [3:0] _GEN_20; // @[riscvSingle.scala 321:48:@1632.16]
  wire [3:0] _GEN_21; // @[riscvSingle.scala 319:48:@1627.14]
  wire [3:0] _GEN_22; // @[riscvSingle.scala 317:42:@1622.12]
  wire [3:0] _GEN_23; // @[riscvSingle.scala 310:46:@1611.10]
  wire  _T_153; // @[riscvSingle.scala 335:26:@1661.10]
  wire  _T_166; // @[riscvSingle.scala 347:26:@1676.12]
  wire  _T_179; // @[riscvSingle.scala 359:26:@1691.14]
  wire  _T_194; // @[riscvSingle.scala 371:37:@1705.16]
  wire  _T_199; // @[riscvSingle.scala 373:57:@1711.18]
  wire  _T_200; // @[riscvSingle.scala 373:43:@1712.18]
  wire  _T_206; // @[riscvSingle.scala 375:43:@1719.20]
  wire  _T_212; // @[riscvSingle.scala 377:43:@1726.22]
  wire  _T_218; // @[riscvSingle.scala 379:43:@1733.24]
  wire  _T_224; // @[riscvSingle.scala 381:43:@1740.26]
  wire  _GEN_25; // @[riscvSingle.scala 379:70:@1734.24]
  wire  _GEN_26; // @[riscvSingle.scala 377:73:@1727.22]
  wire  _GEN_27; // @[riscvSingle.scala 375:70:@1720.20]
  wire  _GEN_28; // @[riscvSingle.scala 373:66:@1713.18]
  wire  _GEN_29; // @[riscvSingle.scala 371:59:@1706.16]
  wire  _T_228; // @[riscvSingle.scala 387:26:@1749.16]
  wire  _T_241; // @[riscvSingle.scala 399:26:@1764.18]
  wire  _T_254; // @[riscvSingle.scala 411:26:@1779.20]
  wire  _T_267; // @[riscvSingle.scala 423:26:@1794.22]
  wire  _T_282; // @[riscvSingle.scala 437:30:@1811.26]
  wire  _T_286; // @[riscvSingle.scala 440:30:@1817.28]
  wire [1:0] _GEN_30; // @[riscvSingle.scala 440:48:@1818.28]
  wire [1:0] _GEN_32; // @[riscvSingle.scala 437:48:@1812.26]
  wire [1:0] _GEN_34; // @[riscvSingle.scala 434:42:@1806.24]
  wire [1:0] _GEN_38; // @[riscvSingle.scala 423:44:@1795.22]
  wire  _GEN_41; // @[riscvSingle.scala 411:44:@1780.20]
  wire [1:0] _GEN_43; // @[riscvSingle.scala 411:44:@1780.20]
  wire [2:0] _GEN_44; // @[riscvSingle.scala 399:44:@1765.18]
  wire  _GEN_46; // @[riscvSingle.scala 399:44:@1765.18]
  wire [1:0] _GEN_48; // @[riscvSingle.scala 399:44:@1765.18]
  wire  _GEN_49; // @[riscvSingle.scala 399:44:@1765.18]
  wire [1:0] _GEN_50; // @[riscvSingle.scala 399:44:@1765.18]
  wire [2:0] _GEN_51; // @[riscvSingle.scala 387:44:@1750.16]
  wire [1:0] _GEN_52; // @[riscvSingle.scala 387:44:@1750.16]
  wire  _GEN_53; // @[riscvSingle.scala 387:44:@1750.16]
  wire  _GEN_55; // @[riscvSingle.scala 387:44:@1750.16]
  wire [1:0] _GEN_56; // @[riscvSingle.scala 387:44:@1750.16]
  wire [1:0] _GEN_57; // @[riscvSingle.scala 387:44:@1750.16]
  wire  _GEN_58; // @[riscvSingle.scala 387:44:@1750.16]
  wire [1:0] _GEN_59; // @[riscvSingle.scala 387:44:@1750.16]
  wire [2:0] _GEN_60; // @[riscvSingle.scala 359:44:@1692.14]
  wire [1:0] _GEN_61; // @[riscvSingle.scala 359:44:@1692.14]
  wire  _GEN_62; // @[riscvSingle.scala 359:44:@1692.14]
  wire  _GEN_64; // @[riscvSingle.scala 359:44:@1692.14]
  wire [2:0] _GEN_65; // @[riscvSingle.scala 359:44:@1692.14]
  wire  _GEN_66; // @[riscvSingle.scala 359:44:@1692.14]
  wire [1:0] _GEN_67; // @[riscvSingle.scala 359:44:@1692.14]
  wire [1:0] _GEN_68; // @[riscvSingle.scala 359:44:@1692.14]
  wire [2:0] _GEN_69; // @[riscvSingle.scala 347:44:@1677.12]
  wire [1:0] _GEN_70; // @[riscvSingle.scala 347:44:@1677.12]
  wire  _GEN_71; // @[riscvSingle.scala 347:44:@1677.12]
  wire  _GEN_73; // @[riscvSingle.scala 347:44:@1677.12]
  wire [1:0] _GEN_75; // @[riscvSingle.scala 347:44:@1677.12]
  wire [2:0] _GEN_76; // @[riscvSingle.scala 347:44:@1677.12]
  wire  _GEN_77; // @[riscvSingle.scala 347:44:@1677.12]
  wire [1:0] _GEN_78; // @[riscvSingle.scala 347:44:@1677.12]
  wire [2:0] _GEN_79; // @[riscvSingle.scala 335:44:@1662.10]
  wire [1:0] _GEN_80; // @[riscvSingle.scala 335:44:@1662.10]
  wire  _GEN_81; // @[riscvSingle.scala 335:44:@1662.10]
  wire  _GEN_84; // @[riscvSingle.scala 335:44:@1662.10]
  wire  _GEN_85; // @[riscvSingle.scala 335:44:@1662.10]
  wire [1:0] _GEN_86; // @[riscvSingle.scala 335:44:@1662.10]
  wire [2:0] _GEN_87; // @[riscvSingle.scala 335:44:@1662.10]
  wire  _GEN_88; // @[riscvSingle.scala 335:44:@1662.10]
  wire [1:0] _GEN_89; // @[riscvSingle.scala 335:44:@1662.10]
  wire [2:0] _GEN_90; // @[riscvSingle.scala 298:44:@1598.8]
  wire [1:0] _GEN_91; // @[riscvSingle.scala 298:44:@1598.8]
  wire  _GEN_92; // @[riscvSingle.scala 298:44:@1598.8]
  wire  _GEN_94; // @[riscvSingle.scala 298:44:@1598.8]
  wire  _GEN_95; // @[riscvSingle.scala 298:44:@1598.8]
  wire  _GEN_96; // @[riscvSingle.scala 298:44:@1598.8]
  wire [1:0] _GEN_97; // @[riscvSingle.scala 298:44:@1598.8]
  wire  _GEN_98; // @[riscvSingle.scala 298:44:@1598.8]
  wire [1:0] _GEN_99; // @[riscvSingle.scala 298:44:@1598.8]
  wire [3:0] _GEN_100; // @[riscvSingle.scala 298:44:@1598.8]
  wire [2:0] _GEN_101; // @[riscvSingle.scala 286:43:@1583.6]
  wire [1:0] _GEN_102; // @[riscvSingle.scala 286:43:@1583.6]
  wire  _GEN_103; // @[riscvSingle.scala 286:43:@1583.6]
  wire  _GEN_105; // @[riscvSingle.scala 286:43:@1583.6]
  wire  _GEN_106; // @[riscvSingle.scala 286:43:@1583.6]
  wire  _GEN_107; // @[riscvSingle.scala 286:43:@1583.6]
  wire [1:0] _GEN_108; // @[riscvSingle.scala 286:43:@1583.6]
  wire [3:0] _GEN_109; // @[riscvSingle.scala 286:43:@1583.6]
  wire  _GEN_110; // @[riscvSingle.scala 286:43:@1583.6]
  wire [1:0] _GEN_111; // @[riscvSingle.scala 286:43:@1583.6]
  wire  _T_305; // @[riscvSingle.scala 479:11:@1858.4]
  wire  decoderMessage_regSrc; // @[riscvSingle.scala 233:30:@1487.4 riscvSingle.scala 466:27:@1844.4]
  assign _T_41 = io_opcode == 7'h33; // @[riscvSingle.scala 235:20:@1488.4]
  assign _T_53 = io_funct7 == 7'h0; // @[riscvSingle.scala 247:24:@1500.6]
  assign _T_55 = io_funct3 == 3'h0; // @[riscvSingle.scala 248:28:@1502.8]
  assign _T_58 = io_funct3 == 3'h1; // @[riscvSingle.scala 250:34:@1507.10]
  assign _T_61 = io_funct3 == 3'h2; // @[riscvSingle.scala 252:34:@1512.12]
  assign _T_64 = io_funct3 == 3'h3; // @[riscvSingle.scala 254:34:@1517.14]
  assign _T_67 = io_funct3 == 3'h4; // @[riscvSingle.scala 256:34:@1522.16]
  assign _T_70 = io_funct3 == 3'h5; // @[riscvSingle.scala 258:34:@1527.18]
  assign _T_73 = io_funct3 == 3'h6; // @[riscvSingle.scala 260:34:@1532.20]
  assign _T_76 = io_funct3 == 3'h7; // @[riscvSingle.scala 262:34:@1537.22]
  assign _GEN_0 = _T_76 ? 4'h0 : 4'hf; // @[riscvSingle.scala 262:48:@1538.22]
  assign _GEN_1 = _T_73 ? 4'h1 : _GEN_0; // @[riscvSingle.scala 260:48:@1533.20]
  assign _GEN_2 = _T_70 ? 4'h7 : _GEN_1; // @[riscvSingle.scala 258:48:@1528.18]
  assign _GEN_3 = _T_67 ? 4'h6 : _GEN_2; // @[riscvSingle.scala 256:48:@1523.16]
  assign _GEN_4 = _T_64 ? 4'h5 : _GEN_3; // @[riscvSingle.scala 254:48:@1518.14]
  assign _GEN_5 = _T_61 ? 4'h9 : _GEN_4; // @[riscvSingle.scala 252:48:@1513.12]
  assign _GEN_6 = _T_58 ? 4'h3 : _GEN_5; // @[riscvSingle.scala 250:48:@1508.10]
  assign _GEN_7 = _T_55 ? 4'h2 : _GEN_6; // @[riscvSingle.scala 248:42:@1503.8]
  assign _T_80 = io_funct7 == 7'h1; // @[riscvSingle.scala 267:30:@1546.8]
  assign _GEN_8 = _T_67 ? 4'ha : 4'hf; // @[riscvSingle.scala 270:47:@1554.12]
  assign _GEN_9 = _T_55 ? 4'h8 : _GEN_8; // @[riscvSingle.scala 268:41:@1549.10]
  assign _T_89 = io_funct7 == 7'h20; // @[riscvSingle.scala 275:30:@1562.10]
  assign _GEN_10 = _T_55 ? 4'hc : 4'hf; // @[riscvSingle.scala 278:47:@1570.14]
  assign _GEN_11 = _T_70 ? 4'h4 : _GEN_10; // @[riscvSingle.scala 276:43:@1565.12]
  assign _GEN_12 = _T_89 ? _GEN_11 : 4'hf; // @[riscvSingle.scala 275:47:@1563.10]
  assign _GEN_13 = _T_80 ? _GEN_9 : _GEN_12; // @[riscvSingle.scala 267:47:@1547.8]
  assign _GEN_14 = _T_53 ? _GEN_7 : _GEN_13; // @[riscvSingle.scala 247:42:@1501.6]
  assign _T_99 = io_opcode == 7'h17; // @[riscvSingle.scala 286:26:@1582.6]
  assign _T_112 = io_opcode == 7'h13; // @[riscvSingle.scala 298:26:@1597.8]
  assign _T_123 = io_funct7[6:1]; // @[riscvSingle.scala 310:24:@1609.10]
  assign _T_125 = _T_123 == 6'h10; // @[riscvSingle.scala 310:30:@1610.10]
  assign _GEN_15 = _T_70 ? 4'h4 : 4'hf; // @[riscvSingle.scala 311:41:@1613.12]
  assign _GEN_17 = _T_70 ? 3'h7 : {{2'd0}, _T_73}; // @[riscvSingle.scala 327:48:@1647.22]
  assign _GEN_18 = _T_67 ? 3'h6 : _GEN_17; // @[riscvSingle.scala 325:48:@1642.20]
  assign _GEN_19 = _T_64 ? 3'h5 : _GEN_18; // @[riscvSingle.scala 323:48:@1637.18]
  assign _GEN_20 = _T_61 ? 4'h9 : {{1'd0}, _GEN_19}; // @[riscvSingle.scala 321:48:@1632.16]
  assign _GEN_21 = _T_58 ? 4'h3 : _GEN_20; // @[riscvSingle.scala 319:48:@1627.14]
  assign _GEN_22 = _T_55 ? 4'h2 : _GEN_21; // @[riscvSingle.scala 317:42:@1622.12]
  assign _GEN_23 = _T_125 ? _GEN_15 : _GEN_22; // @[riscvSingle.scala 310:46:@1611.10]
  assign _T_153 = io_opcode == 7'h3; // @[riscvSingle.scala 335:26:@1661.10]
  assign _T_166 = io_opcode == 7'h23; // @[riscvSingle.scala 347:26:@1676.12]
  assign _T_179 = io_opcode == 7'h63; // @[riscvSingle.scala 359:26:@1691.14]
  assign _T_194 = _T_55 & io_zeroFlag; // @[riscvSingle.scala 371:37:@1705.16]
  assign _T_199 = io_zeroFlag == 1'h0; // @[riscvSingle.scala 373:57:@1711.18]
  assign _T_200 = _T_58 & _T_199; // @[riscvSingle.scala 373:43:@1712.18]
  assign _T_206 = _T_67 & io_lessThanFlag; // @[riscvSingle.scala 375:43:@1719.20]
  assign _T_212 = _T_70 & io_greaterThanFlag; // @[riscvSingle.scala 377:43:@1726.22]
  assign _T_218 = _T_73 & io_lessThanFlag; // @[riscvSingle.scala 379:43:@1733.24]
  assign _T_224 = _T_76 & io_greaterThanFlag; // @[riscvSingle.scala 381:43:@1740.26]
  assign _GEN_25 = _T_218 ? 1'h1 : _T_224; // @[riscvSingle.scala 379:70:@1734.24]
  assign _GEN_26 = _T_212 ? 1'h1 : _GEN_25; // @[riscvSingle.scala 377:73:@1727.22]
  assign _GEN_27 = _T_206 ? 1'h1 : _GEN_26; // @[riscvSingle.scala 375:70:@1720.20]
  assign _GEN_28 = _T_200 ? 1'h1 : _GEN_27; // @[riscvSingle.scala 373:66:@1713.18]
  assign _GEN_29 = _T_194 ? 1'h1 : _GEN_28; // @[riscvSingle.scala 371:59:@1706.16]
  assign _T_228 = io_opcode == 7'h6f; // @[riscvSingle.scala 387:26:@1749.16]
  assign _T_241 = io_opcode == 7'h67; // @[riscvSingle.scala 399:26:@1764.18]
  assign _T_254 = io_opcode == 7'h73; // @[riscvSingle.scala 411:26:@1779.20]
  assign _T_267 = io_opcode == 7'h53; // @[riscvSingle.scala 423:26:@1794.22]
  assign _T_282 = io_funct7 == 7'h4; // @[riscvSingle.scala 437:30:@1811.26]
  assign _T_286 = io_funct7 == 7'h8; // @[riscvSingle.scala 440:30:@1817.28]
  assign _GEN_30 = _T_286 ? 2'h2 : 2'h3; // @[riscvSingle.scala 440:48:@1818.28]
  assign _GEN_32 = _T_282 ? 2'h1 : _GEN_30; // @[riscvSingle.scala 437:48:@1812.26]
  assign _GEN_34 = _T_53 ? 2'h0 : _GEN_32; // @[riscvSingle.scala 434:42:@1806.24]
  assign _GEN_38 = _T_267 ? _GEN_34 : 2'h0; // @[riscvSingle.scala 423:44:@1795.22]
  assign _GEN_41 = _T_254 ? 1'h0 : _T_267; // @[riscvSingle.scala 411:44:@1780.20]
  assign _GEN_43 = _T_254 ? 2'h0 : _GEN_38; // @[riscvSingle.scala 411:44:@1780.20]
  assign _GEN_44 = _T_241 ? 3'h4 : 3'h0; // @[riscvSingle.scala 399:44:@1765.18]
  assign _GEN_46 = _T_241 ? 1'h1 : _GEN_41; // @[riscvSingle.scala 399:44:@1765.18]
  assign _GEN_48 = _T_241 ? 2'h2 : 2'h0; // @[riscvSingle.scala 399:44:@1765.18]
  assign _GEN_49 = _T_241 ? 1'h0 : _GEN_41; // @[riscvSingle.scala 399:44:@1765.18]
  assign _GEN_50 = _T_241 ? 2'h0 : _GEN_43; // @[riscvSingle.scala 399:44:@1765.18]
  assign _GEN_51 = _T_228 ? 3'h4 : _GEN_44; // @[riscvSingle.scala 387:44:@1750.16]
  assign _GEN_52 = _T_228 ? 2'h2 : 2'h0; // @[riscvSingle.scala 387:44:@1750.16]
  assign _GEN_53 = _T_228 ? 1'h1 : _GEN_46; // @[riscvSingle.scala 387:44:@1750.16]
  assign _GEN_55 = _T_228 ? 1'h1 : _T_241; // @[riscvSingle.scala 387:44:@1750.16]
  assign _GEN_56 = _T_228 ? 2'h1 : _GEN_48; // @[riscvSingle.scala 387:44:@1750.16]
  assign _GEN_57 = _T_228 ? 2'h0 : _GEN_48; // @[riscvSingle.scala 387:44:@1750.16]
  assign _GEN_58 = _T_228 ? 1'h0 : _GEN_49; // @[riscvSingle.scala 387:44:@1750.16]
  assign _GEN_59 = _T_228 ? 2'h0 : _GEN_50; // @[riscvSingle.scala 387:44:@1750.16]
  assign _GEN_60 = _T_179 ? 3'h0 : _GEN_51; // @[riscvSingle.scala 359:44:@1692.14]
  assign _GEN_61 = _T_179 ? 2'h1 : _GEN_52; // @[riscvSingle.scala 359:44:@1692.14]
  assign _GEN_62 = _T_179 ? 1'h0 : _GEN_53; // @[riscvSingle.scala 359:44:@1692.14]
  assign _GEN_64 = _T_179 ? 1'h0 : _GEN_55; // @[riscvSingle.scala 359:44:@1692.14]
  assign _GEN_65 = _T_179 ? 3'h4 : {{1'd0}, _GEN_57}; // @[riscvSingle.scala 359:44:@1692.14]
  assign _GEN_66 = _T_179 ? 1'h0 : _GEN_58; // @[riscvSingle.scala 359:44:@1692.14]
  assign _GEN_67 = _T_179 ? 2'h0 : _GEN_59; // @[riscvSingle.scala 359:44:@1692.14]
  assign _GEN_68 = _T_179 ? {{1'd0}, _GEN_29} : _GEN_56; // @[riscvSingle.scala 359:44:@1692.14]
  assign _GEN_69 = _T_166 ? 3'h0 : _GEN_60; // @[riscvSingle.scala 347:44:@1677.12]
  assign _GEN_70 = _T_166 ? 2'h0 : _GEN_61; // @[riscvSingle.scala 347:44:@1677.12]
  assign _GEN_71 = _T_166 ? 1'h1 : _GEN_62; // @[riscvSingle.scala 347:44:@1677.12]
  assign _GEN_73 = _T_166 ? 1'h0 : _GEN_64; // @[riscvSingle.scala 347:44:@1677.12]
  assign _GEN_75 = _T_166 ? 2'h0 : _GEN_68; // @[riscvSingle.scala 347:44:@1677.12]
  assign _GEN_76 = _T_166 ? 3'h0 : _GEN_65; // @[riscvSingle.scala 347:44:@1677.12]
  assign _GEN_77 = _T_166 ? 1'h0 : _GEN_66; // @[riscvSingle.scala 347:44:@1677.12]
  assign _GEN_78 = _T_166 ? 2'h0 : _GEN_67; // @[riscvSingle.scala 347:44:@1677.12]
  assign _GEN_79 = _T_153 ? 3'h0 : _GEN_69; // @[riscvSingle.scala 335:44:@1662.10]
  assign _GEN_80 = _T_153 ? 2'h0 : _GEN_70; // @[riscvSingle.scala 335:44:@1662.10]
  assign _GEN_81 = _T_153 ? 1'h1 : _GEN_71; // @[riscvSingle.scala 335:44:@1662.10]
  assign _GEN_84 = _T_153 ? 1'h1 : _GEN_73; // @[riscvSingle.scala 335:44:@1662.10]
  assign _GEN_85 = _T_153 ? 1'h0 : _T_166; // @[riscvSingle.scala 335:44:@1662.10]
  assign _GEN_86 = _T_153 ? 2'h0 : _GEN_75; // @[riscvSingle.scala 335:44:@1662.10]
  assign _GEN_87 = _T_153 ? 3'h2 : _GEN_76; // @[riscvSingle.scala 335:44:@1662.10]
  assign _GEN_88 = _T_153 ? 1'h0 : _GEN_77; // @[riscvSingle.scala 335:44:@1662.10]
  assign _GEN_89 = _T_153 ? 2'h0 : _GEN_78; // @[riscvSingle.scala 335:44:@1662.10]
  assign _GEN_90 = _T_112 ? 3'h0 : _GEN_79; // @[riscvSingle.scala 298:44:@1598.8]
  assign _GEN_91 = _T_112 ? 2'h0 : _GEN_80; // @[riscvSingle.scala 298:44:@1598.8]
  assign _GEN_92 = _T_112 ? 1'h1 : _GEN_81; // @[riscvSingle.scala 298:44:@1598.8]
  assign _GEN_94 = _T_112 ? 1'h0 : _T_153; // @[riscvSingle.scala 298:44:@1598.8]
  assign _GEN_95 = _T_112 ? 1'h1 : _GEN_84; // @[riscvSingle.scala 298:44:@1598.8]
  assign _GEN_96 = _T_112 ? 1'h0 : _GEN_85; // @[riscvSingle.scala 298:44:@1598.8]
  assign _GEN_97 = _T_112 ? 2'h0 : _GEN_86; // @[riscvSingle.scala 298:44:@1598.8]
  assign _GEN_98 = _T_112 ? 1'h0 : _GEN_88; // @[riscvSingle.scala 298:44:@1598.8]
  assign _GEN_99 = _T_112 ? 2'h0 : _GEN_89; // @[riscvSingle.scala 298:44:@1598.8]
  assign _GEN_100 = _T_112 ? _GEN_23 : {{1'd0}, _GEN_87}; // @[riscvSingle.scala 298:44:@1598.8]
  assign _GEN_101 = _T_99 ? 3'h0 : _GEN_90; // @[riscvSingle.scala 286:43:@1583.6]
  assign _GEN_102 = _T_99 ? 2'h2 : _GEN_91; // @[riscvSingle.scala 286:43:@1583.6]
  assign _GEN_103 = _T_99 ? 1'h1 : _GEN_92; // @[riscvSingle.scala 286:43:@1583.6]
  assign _GEN_105 = _T_99 ? 1'h0 : _GEN_94; // @[riscvSingle.scala 286:43:@1583.6]
  assign _GEN_106 = _T_99 ? 1'h1 : _GEN_95; // @[riscvSingle.scala 286:43:@1583.6]
  assign _GEN_107 = _T_99 ? 1'h0 : _GEN_96; // @[riscvSingle.scala 286:43:@1583.6]
  assign _GEN_108 = _T_99 ? 2'h0 : _GEN_97; // @[riscvSingle.scala 286:43:@1583.6]
  assign _GEN_109 = _T_99 ? 4'h2 : _GEN_100; // @[riscvSingle.scala 286:43:@1583.6]
  assign _GEN_110 = _T_99 ? 1'h0 : _GEN_98; // @[riscvSingle.scala 286:43:@1583.6]
  assign _GEN_111 = _T_99 ? 2'h0 : _GEN_99; // @[riscvSingle.scala 286:43:@1583.6]
  assign _T_305 = reset == 1'h0; // @[riscvSingle.scala 479:11:@1858.4]
  assign decoderMessage_regSrc = io_regSrc[0]; // @[riscvSingle.scala 233:30:@1487.4 riscvSingle.scala 466:27:@1844.4]
  assign io_regSrc = _T_41 ? 3'h0 : _GEN_101; // @[riscvSingle.scala 236:19:@1490.6 riscvSingle.scala 287:19:@1584.8 riscvSingle.scala 299:19:@1599.10 riscvSingle.scala 336:19:@1663.12 riscvSingle.scala 348:19:@1678.14 riscvSingle.scala 360:19:@1693.16 riscvSingle.scala 388:19:@1751.18 riscvSingle.scala 400:19:@1766.20 riscvSingle.scala 412:19:@1781.22 riscvSingle.scala 424:19:@1796.24 riscvSingle.scala 448:19:@1828.24]
  assign io_regWriteEnable = _T_41 ? 1'h1 : _GEN_106; // @[riscvSingle.scala 241:27:@1495.6 riscvSingle.scala 292:27:@1589.8 riscvSingle.scala 304:27:@1604.10 riscvSingle.scala 341:27:@1668.12 riscvSingle.scala 353:27:@1683.14 riscvSingle.scala 365:27:@1698.16 riscvSingle.scala 393:27:@1756.18 riscvSingle.scala 405:27:@1771.20 riscvSingle.scala 417:27:@1786.22 riscvSingle.scala 429:27:@1801.24 riscvSingle.scala 453:27:@1833.24]
  assign io_fpuRegWriteEnable = _T_41 ? 1'h0 : _GEN_110; // @[riscvSingle.scala 244:30:@1498.6 riscvSingle.scala 296:30:@1593.8 riscvSingle.scala 307:30:@1607.10 riscvSingle.scala 345:30:@1672.12 riscvSingle.scala 357:30:@1687.14 riscvSingle.scala 368:30:@1701.16 riscvSingle.scala 397:30:@1760.18 riscvSingle.scala 409:30:@1775.20 riscvSingle.scala 421:30:@1790.22 riscvSingle.scala 436:34:@1808.26 riscvSingle.scala 439:34:@1814.28 riscvSingle.scala 442:34:@1820.30 riscvSingle.scala 445:34:@1824.30 riscvSingle.scala 454:30:@1834.24 riscvSingle.scala 458:30:@1838.24]
  assign io_immSrc = _T_41 ? 2'h0 : _GEN_102; // @[riscvSingle.scala 237:19:@1491.6 riscvSingle.scala 288:19:@1585.8 riscvSingle.scala 300:19:@1600.10 riscvSingle.scala 337:19:@1664.12 riscvSingle.scala 349:19:@1679.14 riscvSingle.scala 361:19:@1694.16 riscvSingle.scala 389:19:@1752.18 riscvSingle.scala 401:19:@1767.20 riscvSingle.scala 413:19:@1782.22 riscvSingle.scala 425:19:@1797.24 riscvSingle.scala 449:19:@1829.24]
  assign io_aluSrc = _T_41 ? 1'h0 : _GEN_103; // @[riscvSingle.scala 238:19:@1492.6 riscvSingle.scala 289:19:@1586.8 riscvSingle.scala 301:19:@1601.10 riscvSingle.scala 338:19:@1665.12 riscvSingle.scala 350:19:@1680.14 riscvSingle.scala 362:19:@1695.16 riscvSingle.scala 390:19:@1753.18 riscvSingle.scala 402:19:@1768.20 riscvSingle.scala 414:19:@1783.22 riscvSingle.scala 426:19:@1798.24 riscvSingle.scala 450:19:@1830.24]
  assign io_pcSrc = _T_41 ? 1'h0 : _T_99; // @[riscvSingle.scala 239:18:@1493.6 riscvSingle.scala 290:18:@1587.8 riscvSingle.scala 302:18:@1602.10 riscvSingle.scala 339:18:@1666.12 riscvSingle.scala 351:18:@1681.14 riscvSingle.scala 363:18:@1696.16 riscvSingle.scala 391:18:@1754.18 riscvSingle.scala 403:18:@1769.20 riscvSingle.scala 415:18:@1784.22 riscvSingle.scala 427:18:@1799.24 riscvSingle.scala 451:18:@1831.24]
  assign io_aluControl = _T_41 ? _GEN_14 : _GEN_109; // @[riscvSingle.scala 249:31:@1504.10 riscvSingle.scala 251:31:@1509.12 riscvSingle.scala 253:31:@1514.14 riscvSingle.scala 255:31:@1519.16 riscvSingle.scala 257:31:@1524.18 riscvSingle.scala 259:31:@1529.20 riscvSingle.scala 261:31:@1534.22 riscvSingle.scala 263:31:@1539.24 riscvSingle.scala 265:31:@1542.24 riscvSingle.scala 269:31:@1550.12 riscvSingle.scala 271:31:@1555.14 riscvSingle.scala 273:31:@1558.14 riscvSingle.scala 277:31:@1566.14 riscvSingle.scala 279:31:@1571.16 riscvSingle.scala 281:31:@1574.16 riscvSingle.scala 284:27:@1578.12 riscvSingle.scala 295:23:@1592.8 riscvSingle.scala 312:31:@1614.14 riscvSingle.scala 314:31:@1617.14 riscvSingle.scala 318:31:@1623.14 riscvSingle.scala 320:31:@1628.16 riscvSingle.scala 322:31:@1633.18 riscvSingle.scala 324:31:@1638.20 riscvSingle.scala 326:31:@1643.22 riscvSingle.scala 328:31:@1648.24 riscvSingle.scala 330:31:@1653.26 riscvSingle.scala 332:31:@1656.26 riscvSingle.scala 344:23:@1671.12 riscvSingle.scala 356:23:@1686.14 riscvSingle.scala 367:23:@1700.16 riscvSingle.scala 396:23:@1759.18 riscvSingle.scala 408:23:@1774.20 riscvSingle.scala 420:23:@1789.22 riscvSingle.scala 432:23:@1804.24 riscvSingle.scala 457:23:@1837.24]
  assign io_fpuControl = _T_41 ? 2'h0 : _GEN_111; // @[riscvSingle.scala 245:23:@1499.6 riscvSingle.scala 297:23:@1594.8 riscvSingle.scala 308:23:@1608.10 riscvSingle.scala 346:23:@1673.12 riscvSingle.scala 358:23:@1688.14 riscvSingle.scala 369:23:@1702.16 riscvSingle.scala 398:23:@1761.18 riscvSingle.scala 410:23:@1776.20 riscvSingle.scala 422:23:@1791.22 riscvSingle.scala 435:27:@1807.26 riscvSingle.scala 438:27:@1813.28 riscvSingle.scala 441:27:@1819.30 riscvSingle.scala 444:27:@1823.30 riscvSingle.scala 459:23:@1839.24]
  assign io_memWriteEnable = _T_41 ? 1'h0 : _GEN_107; // @[riscvSingle.scala 242:27:@1496.6 riscvSingle.scala 293:27:@1590.8 riscvSingle.scala 305:27:@1605.10 riscvSingle.scala 342:27:@1669.12 riscvSingle.scala 354:27:@1684.14 riscvSingle.scala 366:27:@1699.16 riscvSingle.scala 394:27:@1757.18 riscvSingle.scala 406:27:@1772.20 riscvSingle.scala 418:27:@1787.22 riscvSingle.scala 430:27:@1802.24 riscvSingle.scala 455:27:@1835.24]
  assign io_memToReg = _T_41 ? 1'h0 : _GEN_105; // @[riscvSingle.scala 240:21:@1494.6 riscvSingle.scala 291:21:@1588.8 riscvSingle.scala 303:21:@1603.10 riscvSingle.scala 340:21:@1667.12 riscvSingle.scala 352:21:@1682.14 riscvSingle.scala 364:21:@1697.16 riscvSingle.scala 392:21:@1755.18 riscvSingle.scala 404:21:@1770.20 riscvSingle.scala 416:21:@1785.22 riscvSingle.scala 428:21:@1800.24 riscvSingle.scala 452:21:@1832.24]
  assign io_branchSrc = _T_41 ? 2'h0 : _GEN_108; // @[riscvSingle.scala 243:22:@1497.6 riscvSingle.scala 294:22:@1591.8 riscvSingle.scala 306:22:@1606.10 riscvSingle.scala 343:22:@1670.12 riscvSingle.scala 355:22:@1685.14 riscvSingle.scala 372:26:@1707.18 riscvSingle.scala 374:26:@1714.20 riscvSingle.scala 376:26:@1721.22 riscvSingle.scala 378:26:@1728.24 riscvSingle.scala 380:26:@1735.26 riscvSingle.scala 382:26:@1742.28 riscvSingle.scala 384:26:@1745.28 riscvSingle.scala 395:22:@1758.18 riscvSingle.scala 407:22:@1773.20 riscvSingle.scala 419:22:@1788.22 riscvSingle.scala 431:22:@1803.24 riscvSingle.scala 456:22:@1836.24]
  always @(posedge clk) begin
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_305) begin
          $fwrite(32'h80000002,"\n\n\n___________________________\n|decoder Module:\n|  branchSrc          : b%b\n|  opcode             : b%b\n|  funct3             : b%b\n|  regSrc             : b%b\n|  immSrc             : b%b\n|  aluSrc             : b%b\n|  pcSrc              : b%b\n|  regWriteEnable     : b%b\n|  aluControl         : b%b\n|  memToReg           : b%b\n|  memWriteEnable     : b%b\n|  zeroFlag           : b%b\n|  lessThanFlag       : b%b\n|  greaterThanFlag    : b%b\n|  fpuControl         : b%b\n|  fpuRegWriteEnable  : b%b\n|___________________________\n",io_branchSrc,io_opcode,io_funct3,decoderMessage_regSrc,io_immSrc,io_aluSrc,io_pcSrc,io_regWriteEnable,io_aluControl,io_memToReg,io_memWriteEnable,io_zeroFlag,io_lessThanFlag,io_greaterThanFlag,io_fpuControl,io_fpuRegWriteEnable); // @[riscvSingle.scala 479:11:@1860.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module riscv( // @[:@1863.2]
  input         clk, // @[:@1864.4]
  input         reset, // @[:@1865.4]
  input  [31:0] io_instr, // @[:@1866.4]
  input  [31:0] io_memReadData, // @[:@1866.4]
  output [31:0] io_pc, // @[:@1866.4]
  output        io_memWriteEnable, // @[:@1866.4]
  output [31:0] io_memAddress, // @[:@1866.4]
  output [31:0] io_memWriteData // @[:@1866.4]
);
  wire  dp_clk; // @[riscvSingle.scala 90:20:@1869.4]
  wire  dp_reset; // @[riscvSingle.scala 90:20:@1869.4]
  wire [2:0] dp_io_regSrc; // @[riscvSingle.scala 90:20:@1869.4]
  wire  dp_io_regWriteEnable; // @[riscvSingle.scala 90:20:@1869.4]
  wire  dp_io_fpuRegWriteEnable; // @[riscvSingle.scala 90:20:@1869.4]
  wire [1:0] dp_io_immSrc; // @[riscvSingle.scala 90:20:@1869.4]
  wire  dp_io_aluSrc; // @[riscvSingle.scala 90:20:@1869.4]
  wire  dp_io_pcSrc; // @[riscvSingle.scala 90:20:@1869.4]
  wire [3:0] dp_io_aluControl; // @[riscvSingle.scala 90:20:@1869.4]
  wire [1:0] dp_io_fpuControl; // @[riscvSingle.scala 90:20:@1869.4]
  wire  dp_io_memToReg; // @[riscvSingle.scala 90:20:@1869.4]
  wire [31:0] dp_io_instr; // @[riscvSingle.scala 90:20:@1869.4]
  wire [31:0] dp_io_memReadData; // @[riscvSingle.scala 90:20:@1869.4]
  wire [1:0] dp_io_branchSrc; // @[riscvSingle.scala 90:20:@1869.4]
  wire [31:0] dp_io_pc; // @[riscvSingle.scala 90:20:@1869.4]
  wire [31:0] dp_io_memAddress; // @[riscvSingle.scala 90:20:@1869.4]
  wire [31:0] dp_io_memWriteData; // @[riscvSingle.scala 90:20:@1869.4]
  wire  dp_io_zeroFlag; // @[riscvSingle.scala 90:20:@1869.4]
  wire  dp_io_lessThanFlag; // @[riscvSingle.scala 90:20:@1869.4]
  wire  dp_io_greaterThanFlag; // @[riscvSingle.scala 90:20:@1869.4]
  wire  d_clk; // @[riscvSingle.scala 91:19:@1872.4]
  wire  d_reset; // @[riscvSingle.scala 91:19:@1872.4]
  wire [6:0] d_io_opcode; // @[riscvSingle.scala 91:19:@1872.4]
  wire [6:0] d_io_funct7; // @[riscvSingle.scala 91:19:@1872.4]
  wire [2:0] d_io_funct3; // @[riscvSingle.scala 91:19:@1872.4]
  wire [2:0] d_io_regSrc; // @[riscvSingle.scala 91:19:@1872.4]
  wire  d_io_regWriteEnable; // @[riscvSingle.scala 91:19:@1872.4]
  wire  d_io_fpuRegWriteEnable; // @[riscvSingle.scala 91:19:@1872.4]
  wire [1:0] d_io_immSrc; // @[riscvSingle.scala 91:19:@1872.4]
  wire  d_io_aluSrc; // @[riscvSingle.scala 91:19:@1872.4]
  wire  d_io_pcSrc; // @[riscvSingle.scala 91:19:@1872.4]
  wire [3:0] d_io_aluControl; // @[riscvSingle.scala 91:19:@1872.4]
  wire [1:0] d_io_fpuControl; // @[riscvSingle.scala 91:19:@1872.4]
  wire  d_io_memWriteEnable; // @[riscvSingle.scala 91:19:@1872.4]
  wire  d_io_memToReg; // @[riscvSingle.scala 91:19:@1872.4]
  wire [1:0] d_io_branchSrc; // @[riscvSingle.scala 91:19:@1872.4]
  wire  d_io_zeroFlag; // @[riscvSingle.scala 91:19:@1872.4]
  wire  d_io_lessThanFlag; // @[riscvSingle.scala 91:19:@1872.4]
  wire  d_io_greaterThanFlag; // @[riscvSingle.scala 91:19:@1872.4]
  wire  _T_20; // @[riscvSingle.scala 100:11:@1881.4]
  datapath dp ( // @[riscvSingle.scala 90:20:@1869.4]
    .clk(dp_clk),
    .reset(dp_reset),
    .io_regSrc(dp_io_regSrc),
    .io_regWriteEnable(dp_io_regWriteEnable),
    .io_fpuRegWriteEnable(dp_io_fpuRegWriteEnable),
    .io_immSrc(dp_io_immSrc),
    .io_aluSrc(dp_io_aluSrc),
    .io_pcSrc(dp_io_pcSrc),
    .io_aluControl(dp_io_aluControl),
    .io_fpuControl(dp_io_fpuControl),
    .io_memToReg(dp_io_memToReg),
    .io_instr(dp_io_instr),
    .io_memReadData(dp_io_memReadData),
    .io_branchSrc(dp_io_branchSrc),
    .io_pc(dp_io_pc),
    .io_memAddress(dp_io_memAddress),
    .io_memWriteData(dp_io_memWriteData),
    .io_zeroFlag(dp_io_zeroFlag),
    .io_lessThanFlag(dp_io_lessThanFlag),
    .io_greaterThanFlag(dp_io_greaterThanFlag)
  );
  decoder d ( // @[riscvSingle.scala 91:19:@1872.4]
    .clk(d_clk),
    .reset(d_reset),
    .io_opcode(d_io_opcode),
    .io_funct7(d_io_funct7),
    .io_funct3(d_io_funct3),
    .io_regSrc(d_io_regSrc),
    .io_regWriteEnable(d_io_regWriteEnable),
    .io_fpuRegWriteEnable(d_io_fpuRegWriteEnable),
    .io_immSrc(d_io_immSrc),
    .io_aluSrc(d_io_aluSrc),
    .io_pcSrc(d_io_pcSrc),
    .io_aluControl(d_io_aluControl),
    .io_fpuControl(d_io_fpuControl),
    .io_memWriteEnable(d_io_memWriteEnable),
    .io_memToReg(d_io_memToReg),
    .io_branchSrc(d_io_branchSrc),
    .io_zeroFlag(d_io_zeroFlag),
    .io_lessThanFlag(d_io_lessThanFlag),
    .io_greaterThanFlag(d_io_greaterThanFlag)
  );
  assign _T_20 = reset == 1'h0; // @[riscvSingle.scala 100:11:@1881.4]
  assign io_pc = dp_io_pc; // @[riscvSingle.scala 122:11:@1906.4]
  assign io_memWriteEnable = d_io_memWriteEnable; // @[riscvSingle.scala 123:23:@1907.4]
  assign io_memAddress = dp_io_memAddress; // @[riscvSingle.scala 124:19:@1908.4]
  assign io_memWriteData = dp_io_memWriteData; // @[riscvSingle.scala 125:21:@1909.4]
  assign dp_clk = clk; // @[:@1870.4]
  assign dp_reset = reset; // @[:@1871.4]
  assign dp_io_regSrc = d_io_regSrc; // @[riscvSingle.scala 109:18:@1894.4]
  assign dp_io_regWriteEnable = d_io_regWriteEnable; // @[riscvSingle.scala 110:26:@1895.4]
  assign dp_io_fpuRegWriteEnable = d_io_fpuRegWriteEnable; // @[riscvSingle.scala 120:29:@1905.4]
  assign dp_io_immSrc = d_io_immSrc; // @[riscvSingle.scala 111:18:@1896.4]
  assign dp_io_aluSrc = d_io_aluSrc; // @[riscvSingle.scala 112:18:@1897.4]
  assign dp_io_pcSrc = d_io_pcSrc; // @[riscvSingle.scala 113:17:@1898.4]
  assign dp_io_aluControl = d_io_aluControl; // @[riscvSingle.scala 114:22:@1899.4]
  assign dp_io_fpuControl = d_io_fpuControl; // @[riscvSingle.scala 119:22:@1904.4]
  assign dp_io_memToReg = d_io_memToReg; // @[riscvSingle.scala 115:20:@1900.4]
  assign dp_io_instr = io_instr; // @[riscvSingle.scala 116:17:@1901.4]
  assign dp_io_memReadData = io_memReadData; // @[riscvSingle.scala 117:23:@1902.4]
  assign dp_io_branchSrc = d_io_branchSrc; // @[riscvSingle.scala 118:21:@1903.4]
  assign d_clk = clk; // @[:@1873.4]
  assign d_reset = reset; // @[:@1874.4]
  assign d_io_opcode = io_instr[6:0]; // @[riscvSingle.scala 102:17:@1886.4]
  assign d_io_funct7 = io_instr[31:25]; // @[riscvSingle.scala 103:17:@1888.4]
  assign d_io_funct3 = io_instr[14:12]; // @[riscvSingle.scala 104:17:@1890.4]
  assign d_io_zeroFlag = dp_io_zeroFlag; // @[riscvSingle.scala 105:19:@1891.4]
  assign d_io_lessThanFlag = dp_io_lessThanFlag; // @[riscvSingle.scala 106:23:@1892.4]
  assign d_io_greaterThanFlag = dp_io_greaterThanFlag; // @[riscvSingle.scala 107:26:@1893.4]
  always @(posedge clk) begin
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_20) begin
          $fwrite(32'h80000002,"___________________________\n|riscv Module:\n|  instr          : 0x%x\n|  memWriteEnable : b%b\n|  memWriteData   : b%b\n|  memAddress     : b%b\n|  memReadData    : 0x%x\n|___________________________\n",io_instr,io_memWriteEnable,io_memWriteData,io_memAddress,io_memReadData); // @[riscvSingle.scala 100:11:@1883.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module imem( // @[:@1911.2]
  input         clk, // @[:@1912.4]
  input  [31:0] io_instAddress, // @[:@1914.4]
  output [31:0] io_inst // @[:@1914.4]
);
  reg [31:0] MEM [0:1023]; // @[riscvSingle.scala 1033:18:@1916.4]
  reg [31:0] _RAND_0;
  wire [31:0] MEM__T_12_data; // @[riscvSingle.scala 1033:18:@1916.4]
  wire [9:0] MEM__T_12_addr; // @[riscvSingle.scala 1033:18:@1916.4]
  assign MEM__T_12_addr = io_instAddress[9:0];
  assign MEM__T_12_data = MEM[MEM__T_12_addr]; // @[riscvSingle.scala 1033:18:@1916.4]
  assign io_inst = MEM__T_12_data; // @[riscvSingle.scala 1036:13:@1919.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  _RAND_0 = {1{`RANDOM}};
  `ifdef RANDOMIZE_MEM_INIT
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    MEM[initvar] = _RAND_0[31:0];
  `endif // RANDOMIZE_MEM_INIT
  end
`endif // RANDOMIZE
endmodule
module dmem( // @[:@1921.2]
  input         clk, // @[:@1922.4]
  input         reset, // @[:@1923.4]
  input  [31:0] io_memAddress, // @[:@1924.4]
  input  [31:0] io_memWriteData, // @[:@1924.4]
  input         io_memWriteEnable, // @[:@1924.4]
  output [31:0] io_memReadData // @[:@1924.4]
);
  reg [31:0] mem [0:1023]; // @[riscvSingle.scala 1064:26:@1927.4]
  reg [31:0] _RAND_0;
  wire [31:0] mem__T_22_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_22_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [31:0] mem__T_29_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_29_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [31:0] mem__T_39_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_39_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [31:0] mem__T_49_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_49_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [31:0] mem__T_59_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_59_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [31:0] mem__T_69_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_69_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [31:0] mem__T_79_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_79_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [31:0] mem__T_89_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_89_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [31:0] mem__T_99_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_99_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [31:0] mem__T_109_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_109_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [31:0] mem__T_119_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_119_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [31:0] mem__T_129_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_129_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [31:0] mem__T_139_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_139_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [31:0] mem__T_149_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_149_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [31:0] mem__T_159_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_159_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [31:0] mem__T_169_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_169_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [31:0] mem__T_179_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_179_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [31:0] mem__T_189_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_189_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [31:0] mem__T_199_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_199_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [31:0] mem__T_209_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_209_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [31:0] mem__T_219_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_219_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [31:0] mem__T_229_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_229_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [31:0] mem__T_239_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_239_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [31:0] mem__T_249_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_249_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [31:0] mem__T_259_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_259_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [31:0] mem__T_269_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_269_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [31:0] mem__T_279_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_279_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [31:0] mem__T_289_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_289_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [31:0] mem__T_299_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_299_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [31:0] mem__T_309_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_309_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [31:0] mem__T_319_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_319_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [31:0] mem__T_329_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_329_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [31:0] mem__T_339_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_339_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [31:0] mem__T_20_data; // @[riscvSingle.scala 1064:26:@1927.4]
  wire [9:0] mem__T_20_addr; // @[riscvSingle.scala 1064:26:@1927.4]
  wire  mem__T_20_mask; // @[riscvSingle.scala 1064:26:@1927.4]
  wire  mem__T_20_en; // @[riscvSingle.scala 1064:26:@1927.4]
  wire  _T_16; // @[riscvSingle.scala 1066:28:@1928.4]
  wire [9:0] _T_19; // @[:@1931.6]
  wire  _GEN_3; // @[riscvSingle.scala 1066:33:@1930.4]
  wire  _T_25; // @[riscvSingle.scala 1072:11:@1939.4]
  wire [31:0] dmemMessage_memWriteEnable; // @[riscvSingle.scala 1063:27:@1926.4 riscvSingle.scala 1083:32:@2366.4]
  wire [31:0] _T_27; // @[riscvSingle.scala 1074:26:@1943.4 riscvSingle.scala 1075:16:@1945.4]
  wire [31:0] _T_37; // @[riscvSingle.scala 1074:26:@1956.4 riscvSingle.scala 1075:16:@1958.4]
  wire [31:0] _T_47; // @[riscvSingle.scala 1074:26:@1969.4 riscvSingle.scala 1075:16:@1971.4]
  wire [31:0] _T_57; // @[riscvSingle.scala 1074:26:@1982.4 riscvSingle.scala 1075:16:@1984.4]
  wire [31:0] _T_67; // @[riscvSingle.scala 1074:26:@1995.4 riscvSingle.scala 1075:16:@1997.4]
  wire [31:0] _T_77; // @[riscvSingle.scala 1074:26:@2008.4 riscvSingle.scala 1075:16:@2010.4]
  wire [31:0] _T_87; // @[riscvSingle.scala 1074:26:@2021.4 riscvSingle.scala 1075:16:@2023.4]
  wire [31:0] _T_97; // @[riscvSingle.scala 1074:26:@2034.4 riscvSingle.scala 1075:16:@2036.4]
  wire [31:0] _T_107; // @[riscvSingle.scala 1074:26:@2047.4 riscvSingle.scala 1075:16:@2049.4]
  wire [31:0] _T_117; // @[riscvSingle.scala 1074:26:@2060.4 riscvSingle.scala 1075:16:@2062.4]
  wire [31:0] _T_127; // @[riscvSingle.scala 1074:26:@2073.4 riscvSingle.scala 1075:16:@2075.4]
  wire [31:0] _T_137; // @[riscvSingle.scala 1074:26:@2086.4 riscvSingle.scala 1075:16:@2088.4]
  wire [31:0] _T_147; // @[riscvSingle.scala 1074:26:@2099.4 riscvSingle.scala 1075:16:@2101.4]
  wire [31:0] _T_157; // @[riscvSingle.scala 1074:26:@2112.4 riscvSingle.scala 1075:16:@2114.4]
  wire [31:0] _T_167; // @[riscvSingle.scala 1074:26:@2125.4 riscvSingle.scala 1075:16:@2127.4]
  wire [31:0] _T_177; // @[riscvSingle.scala 1074:26:@2138.4 riscvSingle.scala 1075:16:@2140.4]
  wire [31:0] _T_187; // @[riscvSingle.scala 1074:26:@2151.4 riscvSingle.scala 1075:16:@2153.4]
  wire [31:0] _T_197; // @[riscvSingle.scala 1074:26:@2164.4 riscvSingle.scala 1075:16:@2166.4]
  wire [31:0] _T_207; // @[riscvSingle.scala 1074:26:@2177.4 riscvSingle.scala 1075:16:@2179.4]
  wire [31:0] _T_217; // @[riscvSingle.scala 1074:26:@2190.4 riscvSingle.scala 1075:16:@2192.4]
  wire [31:0] _T_227; // @[riscvSingle.scala 1074:26:@2203.4 riscvSingle.scala 1075:16:@2205.4]
  wire [31:0] _T_237; // @[riscvSingle.scala 1074:26:@2216.4 riscvSingle.scala 1075:16:@2218.4]
  wire [31:0] _T_247; // @[riscvSingle.scala 1074:26:@2229.4 riscvSingle.scala 1075:16:@2231.4]
  wire [31:0] _T_257; // @[riscvSingle.scala 1074:26:@2242.4 riscvSingle.scala 1075:16:@2244.4]
  wire [31:0] _T_267; // @[riscvSingle.scala 1074:26:@2255.4 riscvSingle.scala 1075:16:@2257.4]
  wire [31:0] _T_277; // @[riscvSingle.scala 1074:26:@2268.4 riscvSingle.scala 1075:16:@2270.4]
  wire [31:0] _T_287; // @[riscvSingle.scala 1074:26:@2281.4 riscvSingle.scala 1075:16:@2283.4]
  wire [31:0] _T_297; // @[riscvSingle.scala 1074:26:@2294.4 riscvSingle.scala 1075:16:@2296.4]
  wire [31:0] _T_307; // @[riscvSingle.scala 1074:26:@2307.4 riscvSingle.scala 1075:16:@2309.4]
  wire [31:0] _T_317; // @[riscvSingle.scala 1074:26:@2320.4 riscvSingle.scala 1075:16:@2322.4]
  wire [31:0] _T_327; // @[riscvSingle.scala 1074:26:@2333.4 riscvSingle.scala 1075:16:@2335.4]
  wire [31:0] _T_337; // @[riscvSingle.scala 1074:26:@2346.4 riscvSingle.scala 1075:16:@2348.4]
  reg [9:0] mem__T_22_addr_pipe_0;
  reg [31:0] _RAND_1;
  reg [9:0] mem__T_29_addr_pipe_0;
  reg [31:0] _RAND_2;
  reg [9:0] mem__T_39_addr_pipe_0;
  reg [31:0] _RAND_3;
  reg [9:0] mem__T_49_addr_pipe_0;
  reg [31:0] _RAND_4;
  reg [9:0] mem__T_59_addr_pipe_0;
  reg [31:0] _RAND_5;
  reg [9:0] mem__T_69_addr_pipe_0;
  reg [31:0] _RAND_6;
  reg [9:0] mem__T_79_addr_pipe_0;
  reg [31:0] _RAND_7;
  reg [9:0] mem__T_89_addr_pipe_0;
  reg [31:0] _RAND_8;
  reg [9:0] mem__T_99_addr_pipe_0;
  reg [31:0] _RAND_9;
  reg [9:0] mem__T_109_addr_pipe_0;
  reg [31:0] _RAND_10;
  reg [9:0] mem__T_119_addr_pipe_0;
  reg [31:0] _RAND_11;
  reg [9:0] mem__T_129_addr_pipe_0;
  reg [31:0] _RAND_12;
  reg [9:0] mem__T_139_addr_pipe_0;
  reg [31:0] _RAND_13;
  reg [9:0] mem__T_149_addr_pipe_0;
  reg [31:0] _RAND_14;
  reg [9:0] mem__T_159_addr_pipe_0;
  reg [31:0] _RAND_15;
  reg [9:0] mem__T_169_addr_pipe_0;
  reg [31:0] _RAND_16;
  reg [9:0] mem__T_179_addr_pipe_0;
  reg [31:0] _RAND_17;
  reg [9:0] mem__T_189_addr_pipe_0;
  reg [31:0] _RAND_18;
  reg [9:0] mem__T_199_addr_pipe_0;
  reg [31:0] _RAND_19;
  reg [9:0] mem__T_209_addr_pipe_0;
  reg [31:0] _RAND_20;
  reg [9:0] mem__T_219_addr_pipe_0;
  reg [31:0] _RAND_21;
  reg [9:0] mem__T_229_addr_pipe_0;
  reg [31:0] _RAND_22;
  reg [9:0] mem__T_239_addr_pipe_0;
  reg [31:0] _RAND_23;
  reg [9:0] mem__T_249_addr_pipe_0;
  reg [31:0] _RAND_24;
  reg [9:0] mem__T_259_addr_pipe_0;
  reg [31:0] _RAND_25;
  reg [9:0] mem__T_269_addr_pipe_0;
  reg [31:0] _RAND_26;
  reg [9:0] mem__T_279_addr_pipe_0;
  reg [31:0] _RAND_27;
  reg [9:0] mem__T_289_addr_pipe_0;
  reg [31:0] _RAND_28;
  reg [9:0] mem__T_299_addr_pipe_0;
  reg [31:0] _RAND_29;
  reg [9:0] mem__T_309_addr_pipe_0;
  reg [31:0] _RAND_30;
  reg [9:0] mem__T_319_addr_pipe_0;
  reg [31:0] _RAND_31;
  reg [9:0] mem__T_329_addr_pipe_0;
  reg [31:0] _RAND_32;
  reg [9:0] mem__T_339_addr_pipe_0;
  reg [31:0] _RAND_33;
  assign mem__T_22_addr = mem__T_22_addr_pipe_0;
  assign mem__T_22_data = mem[mem__T_22_addr]; // @[riscvSingle.scala 1064:26:@1927.4]
  assign mem__T_29_addr = mem__T_29_addr_pipe_0;
  assign mem__T_29_data = mem[mem__T_29_addr]; // @[riscvSingle.scala 1064:26:@1927.4]
  assign mem__T_39_addr = mem__T_39_addr_pipe_0;
  assign mem__T_39_data = mem[mem__T_39_addr]; // @[riscvSingle.scala 1064:26:@1927.4]
  assign mem__T_49_addr = mem__T_49_addr_pipe_0;
  assign mem__T_49_data = mem[mem__T_49_addr]; // @[riscvSingle.scala 1064:26:@1927.4]
  assign mem__T_59_addr = mem__T_59_addr_pipe_0;
  assign mem__T_59_data = mem[mem__T_59_addr]; // @[riscvSingle.scala 1064:26:@1927.4]
  assign mem__T_69_addr = mem__T_69_addr_pipe_0;
  assign mem__T_69_data = mem[mem__T_69_addr]; // @[riscvSingle.scala 1064:26:@1927.4]
  assign mem__T_79_addr = mem__T_79_addr_pipe_0;
  assign mem__T_79_data = mem[mem__T_79_addr]; // @[riscvSingle.scala 1064:26:@1927.4]
  assign mem__T_89_addr = mem__T_89_addr_pipe_0;
  assign mem__T_89_data = mem[mem__T_89_addr]; // @[riscvSingle.scala 1064:26:@1927.4]
  assign mem__T_99_addr = mem__T_99_addr_pipe_0;
  assign mem__T_99_data = mem[mem__T_99_addr]; // @[riscvSingle.scala 1064:26:@1927.4]
  assign mem__T_109_addr = mem__T_109_addr_pipe_0;
  assign mem__T_109_data = mem[mem__T_109_addr]; // @[riscvSingle.scala 1064:26:@1927.4]
  assign mem__T_119_addr = mem__T_119_addr_pipe_0;
  assign mem__T_119_data = mem[mem__T_119_addr]; // @[riscvSingle.scala 1064:26:@1927.4]
  assign mem__T_129_addr = mem__T_129_addr_pipe_0;
  assign mem__T_129_data = mem[mem__T_129_addr]; // @[riscvSingle.scala 1064:26:@1927.4]
  assign mem__T_139_addr = mem__T_139_addr_pipe_0;
  assign mem__T_139_data = mem[mem__T_139_addr]; // @[riscvSingle.scala 1064:26:@1927.4]
  assign mem__T_149_addr = mem__T_149_addr_pipe_0;
  assign mem__T_149_data = mem[mem__T_149_addr]; // @[riscvSingle.scala 1064:26:@1927.4]
  assign mem__T_159_addr = mem__T_159_addr_pipe_0;
  assign mem__T_159_data = mem[mem__T_159_addr]; // @[riscvSingle.scala 1064:26:@1927.4]
  assign mem__T_169_addr = mem__T_169_addr_pipe_0;
  assign mem__T_169_data = mem[mem__T_169_addr]; // @[riscvSingle.scala 1064:26:@1927.4]
  assign mem__T_179_addr = mem__T_179_addr_pipe_0;
  assign mem__T_179_data = mem[mem__T_179_addr]; // @[riscvSingle.scala 1064:26:@1927.4]
  assign mem__T_189_addr = mem__T_189_addr_pipe_0;
  assign mem__T_189_data = mem[mem__T_189_addr]; // @[riscvSingle.scala 1064:26:@1927.4]
  assign mem__T_199_addr = mem__T_199_addr_pipe_0;
  assign mem__T_199_data = mem[mem__T_199_addr]; // @[riscvSingle.scala 1064:26:@1927.4]
  assign mem__T_209_addr = mem__T_209_addr_pipe_0;
  assign mem__T_209_data = mem[mem__T_209_addr]; // @[riscvSingle.scala 1064:26:@1927.4]
  assign mem__T_219_addr = mem__T_219_addr_pipe_0;
  assign mem__T_219_data = mem[mem__T_219_addr]; // @[riscvSingle.scala 1064:26:@1927.4]
  assign mem__T_229_addr = mem__T_229_addr_pipe_0;
  assign mem__T_229_data = mem[mem__T_229_addr]; // @[riscvSingle.scala 1064:26:@1927.4]
  assign mem__T_239_addr = mem__T_239_addr_pipe_0;
  assign mem__T_239_data = mem[mem__T_239_addr]; // @[riscvSingle.scala 1064:26:@1927.4]
  assign mem__T_249_addr = mem__T_249_addr_pipe_0;
  assign mem__T_249_data = mem[mem__T_249_addr]; // @[riscvSingle.scala 1064:26:@1927.4]
  assign mem__T_259_addr = mem__T_259_addr_pipe_0;
  assign mem__T_259_data = mem[mem__T_259_addr]; // @[riscvSingle.scala 1064:26:@1927.4]
  assign mem__T_269_addr = mem__T_269_addr_pipe_0;
  assign mem__T_269_data = mem[mem__T_269_addr]; // @[riscvSingle.scala 1064:26:@1927.4]
  assign mem__T_279_addr = mem__T_279_addr_pipe_0;
  assign mem__T_279_data = mem[mem__T_279_addr]; // @[riscvSingle.scala 1064:26:@1927.4]
  assign mem__T_289_addr = mem__T_289_addr_pipe_0;
  assign mem__T_289_data = mem[mem__T_289_addr]; // @[riscvSingle.scala 1064:26:@1927.4]
  assign mem__T_299_addr = mem__T_299_addr_pipe_0;
  assign mem__T_299_data = mem[mem__T_299_addr]; // @[riscvSingle.scala 1064:26:@1927.4]
  assign mem__T_309_addr = mem__T_309_addr_pipe_0;
  assign mem__T_309_data = mem[mem__T_309_addr]; // @[riscvSingle.scala 1064:26:@1927.4]
  assign mem__T_319_addr = mem__T_319_addr_pipe_0;
  assign mem__T_319_data = mem[mem__T_319_addr]; // @[riscvSingle.scala 1064:26:@1927.4]
  assign mem__T_329_addr = mem__T_329_addr_pipe_0;
  assign mem__T_329_data = mem[mem__T_329_addr]; // @[riscvSingle.scala 1064:26:@1927.4]
  assign mem__T_339_addr = mem__T_339_addr_pipe_0;
  assign mem__T_339_data = mem[mem__T_339_addr]; // @[riscvSingle.scala 1064:26:@1927.4]
  assign mem__T_20_data = io_memWriteData;
  assign mem__T_20_addr = io_memAddress[9:0];
  assign mem__T_20_mask = 1'h1;
  assign mem__T_20_en = _T_16 == 1'h0;
  assign _T_16 = ~ io_memWriteEnable; // @[riscvSingle.scala 1066:28:@1928.4]
  assign _T_19 = io_memAddress[9:0]; // @[:@1931.6]
  assign _GEN_3 = 1'h1; // @[riscvSingle.scala 1066:33:@1930.4]
  assign _T_25 = reset == 1'h0; // @[riscvSingle.scala 1072:11:@1939.4]
  assign dmemMessage_memWriteEnable = {{31'd0}, io_memWriteEnable}; // @[riscvSingle.scala 1063:27:@1926.4 riscvSingle.scala 1083:32:@2366.4]
  assign _T_27 = mem__T_29_data; // @[riscvSingle.scala 1074:26:@1943.4 riscvSingle.scala 1075:16:@1945.4]
  assign _T_37 = mem__T_39_data; // @[riscvSingle.scala 1074:26:@1956.4 riscvSingle.scala 1075:16:@1958.4]
  assign _T_47 = mem__T_49_data; // @[riscvSingle.scala 1074:26:@1969.4 riscvSingle.scala 1075:16:@1971.4]
  assign _T_57 = mem__T_59_data; // @[riscvSingle.scala 1074:26:@1982.4 riscvSingle.scala 1075:16:@1984.4]
  assign _T_67 = mem__T_69_data; // @[riscvSingle.scala 1074:26:@1995.4 riscvSingle.scala 1075:16:@1997.4]
  assign _T_77 = mem__T_79_data; // @[riscvSingle.scala 1074:26:@2008.4 riscvSingle.scala 1075:16:@2010.4]
  assign _T_87 = mem__T_89_data; // @[riscvSingle.scala 1074:26:@2021.4 riscvSingle.scala 1075:16:@2023.4]
  assign _T_97 = mem__T_99_data; // @[riscvSingle.scala 1074:26:@2034.4 riscvSingle.scala 1075:16:@2036.4]
  assign _T_107 = mem__T_109_data; // @[riscvSingle.scala 1074:26:@2047.4 riscvSingle.scala 1075:16:@2049.4]
  assign _T_117 = mem__T_119_data; // @[riscvSingle.scala 1074:26:@2060.4 riscvSingle.scala 1075:16:@2062.4]
  assign _T_127 = mem__T_129_data; // @[riscvSingle.scala 1074:26:@2073.4 riscvSingle.scala 1075:16:@2075.4]
  assign _T_137 = mem__T_139_data; // @[riscvSingle.scala 1074:26:@2086.4 riscvSingle.scala 1075:16:@2088.4]
  assign _T_147 = mem__T_149_data; // @[riscvSingle.scala 1074:26:@2099.4 riscvSingle.scala 1075:16:@2101.4]
  assign _T_157 = mem__T_159_data; // @[riscvSingle.scala 1074:26:@2112.4 riscvSingle.scala 1075:16:@2114.4]
  assign _T_167 = mem__T_169_data; // @[riscvSingle.scala 1074:26:@2125.4 riscvSingle.scala 1075:16:@2127.4]
  assign _T_177 = mem__T_179_data; // @[riscvSingle.scala 1074:26:@2138.4 riscvSingle.scala 1075:16:@2140.4]
  assign _T_187 = mem__T_189_data; // @[riscvSingle.scala 1074:26:@2151.4 riscvSingle.scala 1075:16:@2153.4]
  assign _T_197 = mem__T_199_data; // @[riscvSingle.scala 1074:26:@2164.4 riscvSingle.scala 1075:16:@2166.4]
  assign _T_207 = mem__T_209_data; // @[riscvSingle.scala 1074:26:@2177.4 riscvSingle.scala 1075:16:@2179.4]
  assign _T_217 = mem__T_219_data; // @[riscvSingle.scala 1074:26:@2190.4 riscvSingle.scala 1075:16:@2192.4]
  assign _T_227 = mem__T_229_data; // @[riscvSingle.scala 1074:26:@2203.4 riscvSingle.scala 1075:16:@2205.4]
  assign _T_237 = mem__T_239_data; // @[riscvSingle.scala 1074:26:@2216.4 riscvSingle.scala 1075:16:@2218.4]
  assign _T_247 = mem__T_249_data; // @[riscvSingle.scala 1074:26:@2229.4 riscvSingle.scala 1075:16:@2231.4]
  assign _T_257 = mem__T_259_data; // @[riscvSingle.scala 1074:26:@2242.4 riscvSingle.scala 1075:16:@2244.4]
  assign _T_267 = mem__T_269_data; // @[riscvSingle.scala 1074:26:@2255.4 riscvSingle.scala 1075:16:@2257.4]
  assign _T_277 = mem__T_279_data; // @[riscvSingle.scala 1074:26:@2268.4 riscvSingle.scala 1075:16:@2270.4]
  assign _T_287 = mem__T_289_data; // @[riscvSingle.scala 1074:26:@2281.4 riscvSingle.scala 1075:16:@2283.4]
  assign _T_297 = mem__T_299_data; // @[riscvSingle.scala 1074:26:@2294.4 riscvSingle.scala 1075:16:@2296.4]
  assign _T_307 = mem__T_309_data; // @[riscvSingle.scala 1074:26:@2307.4 riscvSingle.scala 1075:16:@2309.4]
  assign _T_317 = mem__T_319_data; // @[riscvSingle.scala 1074:26:@2320.4 riscvSingle.scala 1075:16:@2322.4]
  assign _T_327 = mem__T_329_data; // @[riscvSingle.scala 1074:26:@2333.4 riscvSingle.scala 1075:16:@2335.4]
  assign _T_337 = mem__T_339_data; // @[riscvSingle.scala 1074:26:@2346.4 riscvSingle.scala 1075:16:@2348.4]
  assign io_memReadData = mem__T_22_data; // @[riscvSingle.scala 1070:20:@1937.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  _RAND_0 = {1{`RANDOM}};
  `ifdef RANDOMIZE_MEM_INIT
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    mem[initvar] = _RAND_0[31:0];
  `endif // RANDOMIZE_MEM_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  mem__T_22_addr_pipe_0 = _RAND_1[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  mem__T_29_addr_pipe_0 = _RAND_2[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  mem__T_39_addr_pipe_0 = _RAND_3[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  mem__T_49_addr_pipe_0 = _RAND_4[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  mem__T_59_addr_pipe_0 = _RAND_5[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  mem__T_69_addr_pipe_0 = _RAND_6[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {1{`RANDOM}};
  mem__T_79_addr_pipe_0 = _RAND_7[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  mem__T_89_addr_pipe_0 = _RAND_8[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  mem__T_99_addr_pipe_0 = _RAND_9[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_10 = {1{`RANDOM}};
  mem__T_109_addr_pipe_0 = _RAND_10[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_11 = {1{`RANDOM}};
  mem__T_119_addr_pipe_0 = _RAND_11[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_12 = {1{`RANDOM}};
  mem__T_129_addr_pipe_0 = _RAND_12[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_13 = {1{`RANDOM}};
  mem__T_139_addr_pipe_0 = _RAND_13[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_14 = {1{`RANDOM}};
  mem__T_149_addr_pipe_0 = _RAND_14[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_15 = {1{`RANDOM}};
  mem__T_159_addr_pipe_0 = _RAND_15[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_16 = {1{`RANDOM}};
  mem__T_169_addr_pipe_0 = _RAND_16[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_17 = {1{`RANDOM}};
  mem__T_179_addr_pipe_0 = _RAND_17[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_18 = {1{`RANDOM}};
  mem__T_189_addr_pipe_0 = _RAND_18[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_19 = {1{`RANDOM}};
  mem__T_199_addr_pipe_0 = _RAND_19[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_20 = {1{`RANDOM}};
  mem__T_209_addr_pipe_0 = _RAND_20[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_21 = {1{`RANDOM}};
  mem__T_219_addr_pipe_0 = _RAND_21[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_22 = {1{`RANDOM}};
  mem__T_229_addr_pipe_0 = _RAND_22[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_23 = {1{`RANDOM}};
  mem__T_239_addr_pipe_0 = _RAND_23[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_24 = {1{`RANDOM}};
  mem__T_249_addr_pipe_0 = _RAND_24[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_25 = {1{`RANDOM}};
  mem__T_259_addr_pipe_0 = _RAND_25[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_26 = {1{`RANDOM}};
  mem__T_269_addr_pipe_0 = _RAND_26[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_27 = {1{`RANDOM}};
  mem__T_279_addr_pipe_0 = _RAND_27[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_28 = {1{`RANDOM}};
  mem__T_289_addr_pipe_0 = _RAND_28[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_29 = {1{`RANDOM}};
  mem__T_299_addr_pipe_0 = _RAND_29[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_30 = {1{`RANDOM}};
  mem__T_309_addr_pipe_0 = _RAND_30[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_31 = {1{`RANDOM}};
  mem__T_319_addr_pipe_0 = _RAND_31[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_32 = {1{`RANDOM}};
  mem__T_329_addr_pipe_0 = _RAND_32[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_33 = {1{`RANDOM}};
  mem__T_339_addr_pipe_0 = _RAND_33[9:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clk) begin
    if(mem__T_20_en & mem__T_20_mask) begin
      mem[mem__T_20_addr] <= mem__T_20_data; // @[riscvSingle.scala 1064:26:@1927.4]
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"\n\n\nMemory___________________________\n"); // @[riscvSingle.scala 1072:11:@1941.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"| mem(0) = "); // @[riscvSingle.scala 1076:15:@1949.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"%d\n",_T_27); // @[riscvSingle.scala 1077:15:@1954.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"| mem(1) = "); // @[riscvSingle.scala 1076:15:@1962.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"%d\n",_T_37); // @[riscvSingle.scala 1077:15:@1967.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"| mem(2) = "); // @[riscvSingle.scala 1076:15:@1975.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"%d\n",_T_47); // @[riscvSingle.scala 1077:15:@1980.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"| mem(3) = "); // @[riscvSingle.scala 1076:15:@1988.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"%d\n",_T_57); // @[riscvSingle.scala 1077:15:@1993.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"| mem(4) = "); // @[riscvSingle.scala 1076:15:@2001.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"%d\n",_T_67); // @[riscvSingle.scala 1077:15:@2006.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"| mem(5) = "); // @[riscvSingle.scala 1076:15:@2014.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"%d\n",_T_77); // @[riscvSingle.scala 1077:15:@2019.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"| mem(6) = "); // @[riscvSingle.scala 1076:15:@2027.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"%d\n",_T_87); // @[riscvSingle.scala 1077:15:@2032.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"| mem(7) = "); // @[riscvSingle.scala 1076:15:@2040.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"%d\n",_T_97); // @[riscvSingle.scala 1077:15:@2045.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"| mem(8) = "); // @[riscvSingle.scala 1076:15:@2053.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"%d\n",_T_107); // @[riscvSingle.scala 1077:15:@2058.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"| mem(9) = "); // @[riscvSingle.scala 1076:15:@2066.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"%d\n",_T_117); // @[riscvSingle.scala 1077:15:@2071.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"| mem(10) = "); // @[riscvSingle.scala 1076:15:@2079.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"%d\n",_T_127); // @[riscvSingle.scala 1077:15:@2084.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"| mem(11) = "); // @[riscvSingle.scala 1076:15:@2092.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"%d\n",_T_137); // @[riscvSingle.scala 1077:15:@2097.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"| mem(12) = "); // @[riscvSingle.scala 1076:15:@2105.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"%d\n",_T_147); // @[riscvSingle.scala 1077:15:@2110.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"| mem(13) = "); // @[riscvSingle.scala 1076:15:@2118.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"%d\n",_T_157); // @[riscvSingle.scala 1077:15:@2123.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"| mem(14) = "); // @[riscvSingle.scala 1076:15:@2131.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"%d\n",_T_167); // @[riscvSingle.scala 1077:15:@2136.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"| mem(15) = "); // @[riscvSingle.scala 1076:15:@2144.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"%d\n",_T_177); // @[riscvSingle.scala 1077:15:@2149.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"| mem(16) = "); // @[riscvSingle.scala 1076:15:@2157.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"%d\n",_T_187); // @[riscvSingle.scala 1077:15:@2162.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"| mem(17) = "); // @[riscvSingle.scala 1076:15:@2170.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"%d\n",_T_197); // @[riscvSingle.scala 1077:15:@2175.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"| mem(18) = "); // @[riscvSingle.scala 1076:15:@2183.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"%d\n",_T_207); // @[riscvSingle.scala 1077:15:@2188.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"| mem(19) = "); // @[riscvSingle.scala 1076:15:@2196.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"%d\n",_T_217); // @[riscvSingle.scala 1077:15:@2201.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"| mem(20) = "); // @[riscvSingle.scala 1076:15:@2209.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"%d\n",_T_227); // @[riscvSingle.scala 1077:15:@2214.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"| mem(21) = "); // @[riscvSingle.scala 1076:15:@2222.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"%d\n",_T_237); // @[riscvSingle.scala 1077:15:@2227.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"| mem(22) = "); // @[riscvSingle.scala 1076:15:@2235.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"%d\n",_T_247); // @[riscvSingle.scala 1077:15:@2240.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"| mem(23) = "); // @[riscvSingle.scala 1076:15:@2248.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"%d\n",_T_257); // @[riscvSingle.scala 1077:15:@2253.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"| mem(24) = "); // @[riscvSingle.scala 1076:15:@2261.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"%d\n",_T_267); // @[riscvSingle.scala 1077:15:@2266.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"| mem(25) = "); // @[riscvSingle.scala 1076:15:@2274.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"%d\n",_T_277); // @[riscvSingle.scala 1077:15:@2279.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"| mem(26) = "); // @[riscvSingle.scala 1076:15:@2287.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"%d\n",_T_287); // @[riscvSingle.scala 1077:15:@2292.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"| mem(27) = "); // @[riscvSingle.scala 1076:15:@2300.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"%d\n",_T_297); // @[riscvSingle.scala 1077:15:@2305.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"| mem(28) = "); // @[riscvSingle.scala 1076:15:@2313.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"%d\n",_T_307); // @[riscvSingle.scala 1077:15:@2318.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"| mem(29) = "); // @[riscvSingle.scala 1076:15:@2326.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"%d\n",_T_317); // @[riscvSingle.scala 1077:15:@2331.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"| mem(30) = "); // @[riscvSingle.scala 1076:15:@2339.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"%d\n",_T_327); // @[riscvSingle.scala 1077:15:@2344.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"| mem(31) = "); // @[riscvSingle.scala 1076:15:@2352.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"%d\n",_T_337); // @[riscvSingle.scala 1077:15:@2357.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"|________________________________\n"); // @[riscvSingle.scala 1079:11:@2362.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_25) begin
          $fwrite(32'h80000002,"\n\n\n___________________________\n|dmem Module:\n|  memAddress      : 0x%x\n|  memWriteData    : 0x%x\n|  memWriteEnable  : b%b\n|  memReadData     : 0x%x\n|___________________________\n",io_memAddress,io_memWriteData,dmemMessage_memWriteEnable,io_memReadData); // @[riscvSingle.scala 1085:11:@2371.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    if (_GEN_3) begin
      mem__T_22_addr_pipe_0 <= _T_19;
    end
    if (_GEN_3) begin
      mem__T_29_addr_pipe_0 <= 10'h0;
    end
    if (_GEN_3) begin
      mem__T_39_addr_pipe_0 <= 10'h1;
    end
    if (_GEN_3) begin
      mem__T_49_addr_pipe_0 <= 10'h2;
    end
    if (_GEN_3) begin
      mem__T_59_addr_pipe_0 <= 10'h3;
    end
    if (_GEN_3) begin
      mem__T_69_addr_pipe_0 <= 10'h4;
    end
    if (_GEN_3) begin
      mem__T_79_addr_pipe_0 <= 10'h5;
    end
    if (_GEN_3) begin
      mem__T_89_addr_pipe_0 <= 10'h6;
    end
    if (_GEN_3) begin
      mem__T_99_addr_pipe_0 <= 10'h7;
    end
    if (_GEN_3) begin
      mem__T_109_addr_pipe_0 <= 10'h8;
    end
    if (_GEN_3) begin
      mem__T_119_addr_pipe_0 <= 10'h9;
    end
    if (_GEN_3) begin
      mem__T_129_addr_pipe_0 <= 10'ha;
    end
    if (_GEN_3) begin
      mem__T_139_addr_pipe_0 <= 10'hb;
    end
    if (_GEN_3) begin
      mem__T_149_addr_pipe_0 <= 10'hc;
    end
    if (_GEN_3) begin
      mem__T_159_addr_pipe_0 <= 10'hd;
    end
    if (_GEN_3) begin
      mem__T_169_addr_pipe_0 <= 10'he;
    end
    if (_GEN_3) begin
      mem__T_179_addr_pipe_0 <= 10'hf;
    end
    if (_GEN_3) begin
      mem__T_189_addr_pipe_0 <= 10'h10;
    end
    if (_GEN_3) begin
      mem__T_199_addr_pipe_0 <= 10'h11;
    end
    if (_GEN_3) begin
      mem__T_209_addr_pipe_0 <= 10'h12;
    end
    if (_GEN_3) begin
      mem__T_219_addr_pipe_0 <= 10'h13;
    end
    if (_GEN_3) begin
      mem__T_229_addr_pipe_0 <= 10'h14;
    end
    if (_GEN_3) begin
      mem__T_239_addr_pipe_0 <= 10'h15;
    end
    if (_GEN_3) begin
      mem__T_249_addr_pipe_0 <= 10'h16;
    end
    if (_GEN_3) begin
      mem__T_259_addr_pipe_0 <= 10'h17;
    end
    if (_GEN_3) begin
      mem__T_269_addr_pipe_0 <= 10'h18;
    end
    if (_GEN_3) begin
      mem__T_279_addr_pipe_0 <= 10'h19;
    end
    if (_GEN_3) begin
      mem__T_289_addr_pipe_0 <= 10'h1a;
    end
    if (_GEN_3) begin
      mem__T_299_addr_pipe_0 <= 10'h1b;
    end
    if (_GEN_3) begin
      mem__T_309_addr_pipe_0 <= 10'h1c;
    end
    if (_GEN_3) begin
      mem__T_319_addr_pipe_0 <= 10'h1d;
    end
    if (_GEN_3) begin
      mem__T_329_addr_pipe_0 <= 10'h1e;
    end
    if (_GEN_3) begin
      mem__T_339_addr_pipe_0 <= 10'h1f;
    end
  end
endmodule
module top( // @[:@2374.2]
  input   clk, // @[:@2375.4]
  input   reset, // @[:@2376.4]
  output  io_valid // @[:@2377.4]
);
  wire  r_clk; // @[riscvSingle.scala 34:19:@2380.4]
  wire  r_reset; // @[riscvSingle.scala 34:19:@2380.4]
  wire [31:0] r_io_instr; // @[riscvSingle.scala 34:19:@2380.4]
  wire [31:0] r_io_memReadData; // @[riscvSingle.scala 34:19:@2380.4]
  wire [31:0] r_io_pc; // @[riscvSingle.scala 34:19:@2380.4]
  wire  r_io_memWriteEnable; // @[riscvSingle.scala 34:19:@2380.4]
  wire [31:0] r_io_memAddress; // @[riscvSingle.scala 34:19:@2380.4]
  wire [31:0] r_io_memWriteData; // @[riscvSingle.scala 34:19:@2380.4]
  wire  im_clk; // @[riscvSingle.scala 35:20:@2383.4]
  wire [31:0] im_io_instAddress; // @[riscvSingle.scala 35:20:@2383.4]
  wire [31:0] im_io_inst; // @[riscvSingle.scala 35:20:@2383.4]
  wire  dm_clk; // @[riscvSingle.scala 36:20:@2386.4]
  wire  dm_reset; // @[riscvSingle.scala 36:20:@2386.4]
  wire [31:0] dm_io_memAddress; // @[riscvSingle.scala 36:20:@2386.4]
  wire [31:0] dm_io_memWriteData; // @[riscvSingle.scala 36:20:@2386.4]
  wire  dm_io_memWriteEnable; // @[riscvSingle.scala 36:20:@2386.4]
  wire [31:0] dm_io_memReadData; // @[riscvSingle.scala 36:20:@2386.4]
  wire [31:0] topMessage_pc_pulled; // @[riscvSingle.scala 46:37:@2394.4]
  wire  _T_12; // @[riscvSingle.scala 51:11:@2401.4]
  wire [6:0] _T_15; // @[riscvSingle.scala 57:31:@2408.4]
  wire  _T_17; // @[riscvSingle.scala 57:38:@2409.4]
  wire [31:0] topMessage_instr_pulled; // @[riscvSingle.scala 33:26:@2379.4 riscvSingle.scala 45:29:@2393.4]
  wire  topMessage_memWriteEnable; // @[riscvSingle.scala 33:26:@2379.4 riscvSingle.scala 48:31:@2397.4]
  wire [31:0] topMessage_memWriteData; // @[riscvSingle.scala 33:26:@2379.4 riscvSingle.scala 47:29:@2396.4]
  wire [31:0] topMessage_memAddress; // @[riscvSingle.scala 33:26:@2379.4 riscvSingle.scala 49:27:@2398.4]
  wire [31:0] topMessage_memReadData; // @[riscvSingle.scala 33:26:@2379.4 riscvSingle.scala 50:28:@2399.4]
  riscv r ( // @[riscvSingle.scala 34:19:@2380.4]
    .clk(r_clk),
    .reset(r_reset),
    .io_instr(r_io_instr),
    .io_memReadData(r_io_memReadData),
    .io_pc(r_io_pc),
    .io_memWriteEnable(r_io_memWriteEnable),
    .io_memAddress(r_io_memAddress),
    .io_memWriteData(r_io_memWriteData)
  );
  imem im ( // @[riscvSingle.scala 35:20:@2383.4]
    .clk(im_clk),
    .io_instAddress(im_io_instAddress),
    .io_inst(im_io_inst)
  );
  dmem dm ( // @[riscvSingle.scala 36:20:@2386.4]
    .clk(dm_clk),
    .reset(dm_reset),
    .io_memAddress(dm_io_memAddress),
    .io_memWriteData(dm_io_memWriteData),
    .io_memWriteEnable(dm_io_memWriteEnable),
    .io_memReadData(dm_io_memReadData)
  );
  assign topMessage_pc_pulled = r_io_pc / 32'h4; // @[riscvSingle.scala 46:37:@2394.4]
  assign _T_12 = reset == 1'h0; // @[riscvSingle.scala 51:11:@2401.4]
  assign _T_15 = im_io_inst[6:0]; // @[riscvSingle.scala 57:31:@2408.4]
  assign _T_17 = _T_15 == 7'h73; // @[riscvSingle.scala 57:38:@2409.4]
  assign topMessage_instr_pulled = im_io_inst; // @[riscvSingle.scala 33:26:@2379.4 riscvSingle.scala 45:29:@2393.4]
  assign topMessage_memWriteEnable = r_io_memWriteEnable; // @[riscvSingle.scala 33:26:@2379.4 riscvSingle.scala 48:31:@2397.4]
  assign topMessage_memWriteData = r_io_memWriteData; // @[riscvSingle.scala 33:26:@2379.4 riscvSingle.scala 47:29:@2396.4]
  assign topMessage_memAddress = r_io_memAddress; // @[riscvSingle.scala 33:26:@2379.4 riscvSingle.scala 49:27:@2398.4]
  assign topMessage_memReadData = dm_io_memReadData; // @[riscvSingle.scala 33:26:@2379.4 riscvSingle.scala 50:28:@2399.4]
  assign io_valid = _T_17 ? 1'h0 : 1'h1; // @[riscvSingle.scala 57:14:@2411.4]
  assign r_clk = clk; // @[:@2381.4]
  assign r_reset = reset; // @[:@2382.4]
  assign r_io_instr = im_io_inst; // @[riscvSingle.scala 55:16:@2407.4]
  assign r_io_memReadData = dm_io_memReadData; // @[riscvSingle.scala 42:22:@2392.4]
  assign im_clk = clk; // @[:@2384.4]
  assign im_io_instAddress = r_io_pc / 32'h4; // @[riscvSingle.scala 53:23:@2406.4]
  assign dm_clk = clk; // @[:@2387.4]
  assign dm_reset = reset; // @[:@2388.4]
  assign dm_io_memAddress = r_io_memAddress; // @[riscvSingle.scala 38:22:@2389.4]
  assign dm_io_memWriteData = r_io_memWriteData; // @[riscvSingle.scala 39:24:@2390.4]
  assign dm_io_memWriteEnable = r_io_memWriteEnable; // @[riscvSingle.scala 40:26:@2391.4]
  always @(posedge clk) begin
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_12) begin
          $fwrite(32'h80000002,"\n\n\n___________________________\n|top Module:\n|  instr pulled       : 0x%x\n|  pc pulled          : b%b\n|  memWriteEnable     : b%b\n|  memWriteData       : 0x%x\n|  memAddress         : 0x%x\n|  memReadData        : 0x%x\n|___________________________\n",topMessage_instr_pulled,topMessage_pc_pulled,topMessage_memWriteEnable,topMessage_memWriteData,topMessage_memAddress,topMessage_memReadData); // @[riscvSingle.scala 51:11:@2403.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
