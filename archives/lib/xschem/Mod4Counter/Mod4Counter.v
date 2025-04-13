// sch_path: /home/rjridle/OpenRadHardSCL/lib/xschem/Mod4Counter/Mod4Counter.sch
module Mod4Counter (
  output wire [1:0] Y,
  input wire CLK
);

wire net1  ;

DFFX1
#(
.VDD ( VDD ) ,
.VSS ( VSS )
)
x1 ( 
 .Q( net1 ),
 .QN( Y[0] ),
 .D( Y[0] ),
 .CLK( CLK )
);


DFFQNX1
#(
.VDD ( VDD ) ,
.VSS ( VSS )
)
x2 ( 
 .CLK( net1 ),
 .QN( Y[1] ),
 .D( Y[1] )
);

endmodule

// expanding   symbol:  DFFX1.sym # of pins=4
// sym_path: /home/rjridle/OpenRadHardSCL/lib/xschem/DFFX1.sym
// sch_path: /home/rjridle/OpenRadHardSCL/lib/xschem/DFFX1.sch
module DFFX1 (
  output wire Q,
  output wire QN,
  input wire D,
  input wire CLK
);
parameter VDD = VDD ;
parameter VSS = VSS ;
wire net1  ;
wire net2  ;
wire net3  ;
wire net4  ;


NAND3X1
#(
.VDD ( VDD ) ,
.VSS ( VSS )
)
x1 ( 
 .Y( net2 ),
 .A( net3 ),
 .B( CLK ),
 .C( net1 )
);


NAND2X1
#(
.VDD ( VDD ) ,
.VSS ( VSS )
)
x2 ( 
 .Y( net1 ),
 .A( net2 ),
 .B( D )
);


NAND2X1
#(
.VDD ( VDD ) ,
.VSS ( VSS )
)
x3 ( 
 .Y( net4 ),
 .A( net1 ),
 .B( net3 )
);


NAND2X1
#(
.VDD ( VDD ) ,
.VSS ( VSS )
)
x4 ( 
 .Y( net3 ),
 .A( net4 ),
 .B( CLK )
);


NAND2X1
#(
.VDD ( VDD ) ,
.VSS ( VSS )
)
x5 ( 
 .Y( QN ),
 .A( net2 ),
 .B( Q )
);


NAND2X1
#(
.VDD ( VDD ) ,
.VSS ( VSS )
)
x6 ( 
 .Y( Q ),
 .A( QN ),
 .B( net3 )
);

endmodule

// expanding   symbol:  DFFQNX1.sym # of pins=3
// sym_path: /home/rjridle/OpenRadHardSCL/lib/xschem/DFFQNX1.sym
// sch_path: /home/rjridle/OpenRadHardSCL/lib/xschem/DFFQNX1.sch
module DFFQNX1 (
  input wire CLK,
  output wire QN,
  input wire D
);
parameter VDD = VDD ;
parameter VSS = VSS ;
wire net1  ;
wire net2  ;
wire net3  ;
wire net4  ;
wire net5  ;


NAND3X1
#(
.VDD ( VDD ) ,
.VSS ( VSS )
)
x1 ( 
 .Y( net2 ),
 .A( net3 ),
 .B( CLK ),
 .C( net1 )
);


NAND2X1
#(
.VDD ( VDD ) ,
.VSS ( VSS )
)
x2 ( 
 .Y( net1 ),
 .A( net2 ),
 .B( D )
);


NAND2X1
#(
.VDD ( VDD ) ,
.VSS ( VSS )
)
x3 ( 
 .Y( net4 ),
 .A( net1 ),
 .B( net3 )
);


NAND2X1
#(
.VDD ( VDD ) ,
.VSS ( VSS )
)
x4 ( 
 .Y( net3 ),
 .A( net4 ),
 .B( CLK )
);


NAND2X1
#(
.VDD ( VDD ) ,
.VSS ( VSS )
)
x5 ( 
 .Y( QN ),
 .A( net2 ),
 .B( net5 )
);


NAND2X1
#(
.VDD ( VDD ) ,
.VSS ( VSS )
)
x6 ( 
 .Y( net5 ),
 .A( QN ),
 .B( net3 )
);

endmodule

// expanding   symbol:  NAND3X1.sym # of pins=4
// sym_path: /home/rjridle/OpenRadHardSCL/lib/xschem/NAND3X1.sym
// sch_path: /home/rjridle/OpenRadHardSCL/lib/xschem/NAND3X1.sch
module NAND3X1 (
  output wire Y,
  input wire A,
  input wire B,
  input wire C
);
parameter VDD = VDD ;
parameter VSS = VSS ;
wire VDD  ;
wire VSS  ;
wire net1  ;
wire net2  ;


nfet_01v8
#(
.L ( 0.15 ) ,
.W ( 3 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( "'int((nf+1)/2) ) ,
.pd ( "'2*int((nf+1)/2) ) ,
.as ( "'int((nf+2)/2) ) ,
.ps ( "'2*int((nf+2)/2) ) ,
.nrd ( "'0.29 ) ,
.nrs ( "'0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M1 ( 
 .D( net2 ),
 .G( A ),
 .S( VSS ),
 .B( VSS )
);


pfet_01v8
#(
.L ( 0.15 ) ,
.W ( 2 ) ,
.nf ( 1 ) ,
.mult ( 2 ) ,
.ad ( "'int((nf+1)/2) ) ,
.pd ( "'2*int((nf+1)/2) ) ,
.as ( "'int((nf+2)/2) ) ,
.ps ( "'2*int((nf+2)/2) ) ,
.nrd ( "'0.29 ) ,
.nrs ( "'0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M2 ( 
 .D( Y ),
 .G( A ),
 .S( VDD ),
 .B( VDD )
);


nfet_01v8
#(
.L ( 0.15 ) ,
.W ( 3 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( "'int((nf+1)/2) ) ,
.pd ( "'2*int((nf+1)/2) ) ,
.as ( "'int((nf+2)/2) ) ,
.ps ( "'2*int((nf+2)/2) ) ,
.nrd ( "'0.29 ) ,
.nrs ( "'0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M3 ( 
 .D( net1 ),
 .G( B ),
 .S( net2 ),
 .B( VSS )
);


nfet_01v8
#(
.L ( 0.15 ) ,
.W ( 3 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( "'int((nf+1)/2) ) ,
.pd ( "'2*int((nf+1)/2) ) ,
.as ( "'int((nf+2)/2) ) ,
.ps ( "'2*int((nf+2)/2) ) ,
.nrd ( "'0.29 ) ,
.nrs ( "'0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M4 ( 
 .D( Y ),
 .G( C ),
 .S( net1 ),
 .B( VSS )
);


pfet_01v8
#(
.L ( 0.15 ) ,
.W ( 2 ) ,
.nf ( 1 ) ,
.mult ( 2 ) ,
.ad ( "'int((nf+1)/2) ) ,
.pd ( "'2*int((nf+1)/2) ) ,
.as ( "'int((nf+2)/2) ) ,
.ps ( "'2*int((nf+2)/2) ) ,
.nrd ( "'0.29 ) ,
.nrs ( "'0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M5 ( 
 .D( Y ),
 .G( B ),
 .S( VDD ),
 .B( VDD )
);


pfet_01v8
#(
.L ( 0.15 ) ,
.W ( 2 ) ,
.nf ( 1 ) ,
.mult ( 2 ) ,
.ad ( "'int((nf+1)/2) ) ,
.pd ( "'2*int((nf+1)/2) ) ,
.as ( "'int((nf+2)/2) ) ,
.ps ( "'2*int((nf+2)/2) ) ,
.nrd ( "'0.29 ) ,
.nrs ( "'0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M6 ( 
 .D( Y ),
 .G( C ),
 .S( VDD ),
 .B( VDD )
);

endmodule

// expanding   symbol:  NAND2X1.sym # of pins=3
// sym_path: /home/rjridle/OpenRadHardSCL/lib/xschem/NAND2X1.sym
// sch_path: /home/rjridle/OpenRadHardSCL/lib/xschem/NAND2X1.sch
module NAND2X1 (
  output wire Y,
  input wire A,
  input wire B
);
parameter VDD = VDD ;
parameter VSS = VSS ;
wire VDD  ;
wire VSS  ;
wire net1  ;


pfet_01v8
#(
.L ( 0.15 ) ,
.W ( 2 ) ,
.nf ( 1 ) ,
.mult ( 2 ) ,
.ad ( "'int((nf+1)/2) ) ,
.pd ( "'2*int((nf+1)/2) ) ,
.as ( "'int((nf+2)/2) ) ,
.ps ( "'2*int((nf+2)/2) ) ,
.nrd ( "'0.29 ) ,
.nrs ( "'0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M1 ( 
 .D( Y ),
 .G( A ),
 .S( VDD ),
 .B( VDD )
);


nfet_01v8
#(
.L ( 0.15 ) ,
.W ( 3 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( "'int((nf+1)/2) ) ,
.pd ( "'2*int((nf+1)/2) ) ,
.as ( "'int((nf+2)/2) ) ,
.ps ( "'2*int((nf+2)/2) ) ,
.nrd ( "'0.29 ) ,
.nrs ( "'0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M5 ( 
 .D( Y ),
 .G( B ),
 .S( net1 ),
 .B( VSS )
);


pfet_01v8
#(
.L ( 0.15 ) ,
.W ( 2 ) ,
.nf ( 1 ) ,
.mult ( 2 ) ,
.ad ( "'int((nf+1)/2) ) ,
.pd ( "'2*int((nf+1)/2) ) ,
.as ( "'int((nf+2)/2) ) ,
.ps ( "'2*int((nf+2)/2) ) ,
.nrd ( "'0.29 ) ,
.nrs ( "'0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( pfet_01v8 ) ,
.spiceprefix ( X )
)
M2 ( 
 .D( Y ),
 .G( B ),
 .S( VDD ),
 .B( VDD )
);


nfet_01v8
#(
.L ( 0.15 ) ,
.W ( 3 ) ,
.nf ( 1 ) ,
.mult ( 1 ) ,
.ad ( "'int((nf+1)/2) ) ,
.pd ( "'2*int((nf+1)/2) ) ,
.as ( "'int((nf+2)/2) ) ,
.ps ( "'2*int((nf+2)/2) ) ,
.nrd ( "'0.29 ) ,
.nrs ( "'0.29 ) ,
.sa ( 0 ) ,
.sb ( 0 ) ,
.sd ( 0 ) ,
.model ( nfet_01v8 ) ,
.spiceprefix ( X )
)
M3 ( 
 .D( net1 ),
 .G( A ),
 .S( VSS ),
 .B( VSS )
);

endmodule
