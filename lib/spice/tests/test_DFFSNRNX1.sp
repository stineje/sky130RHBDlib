** sch_path: /home/rjridle/OpenRadHardSCL/lib/xschem/test_DFFSNRNX1.sch
**.subckt test_DFFSNRNX1
V2 D GND pwl 0n 0 19.9n 0 20n 1.8
V1 VDD GND 1.8
V3 CLK GND pulse 0 1.8 0 1p 1p 5n 10n
V4 SN GND pwl 0n 1.8 6n 1.8 6.1 0 9.8n 0 9.9n 1.8
V5 RN GND pwl 0n 1.8 23n 1.8 23.1n 0 26n 0 26.1n 1.8
x1 Q QN D CLK SN RN VDD GND DFFSNRNX1
**** begin user architecture code

.lib /home/rjridle/OpenRadHardSCL/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.inc DFFSNRNX1.spice

.control
tran 0.01n 30n
meas tran trise TRIG v(Y) VAL=0.18 RISE=1 TARG v(Y) VAL=1.68 RISE=1
meas tran tfall TRIG v(Y) VAL=1.68 FALL=1 TARG v(Y) VAL=0.18 FALL=1
run
.endc

**** end user architecture code
.end
