** sch_path: /home/rjridle/OpenRadHardSCL/lib/xschem/test_DFFSNX1.sch
**.subckt test_DFFSNX1
V2 D GND pwl 0n 0 5ns 0 5.1ns 1.8 10n 1.8 10.1n 0 22n 0 22.1n 1.8 27n 1.8 27.1n 0 34n 0 34.1n 1.8
V1 VDD GND 1.8
V3 CLK GND pulse 0 1.8 0 1p 1p 5n 10n
V4 SN GND pwl 0n 1.8 33ns 1.8 33.1ns 0
x1 Q QN D CLK SN VDD GND DFFSNX1
**** begin user architecture code

.lib /home/rjridle/OpenRadHardSCL/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.inv DFFSNX1.spice

.control
tran 0.01n 45n
meas tran trise TRIG v(Y) VAL=0.18 RISE=1 TARG v(Y) VAL=1.68 RISE=1
meas tran tfall TRIG v(Y) VAL=1.68 FALL=1 TARG v(Y) VAL=0.18 FALL=1
run
.endc
**** end user architecture code
.end
