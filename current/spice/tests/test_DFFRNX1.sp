** sch_path: /home/rjridle/OpenRadHardSCL/lib/xschem/test_DFFRNX1.sch
**.subckt test_DFFRNX1
V2 D GND pwl 0n 1.8 9.9n 1.8 10n 0 19.9n 0 20n 1.8
V1 VDD GND 1.8
V3 CLK GND pulse 0 1.8 0 1p 1p 5n 10n
V4 RN GND pwl 0n 1.8 25.1n 1.8 26n 0
x1 Q QN D CLK RN VDD GND DFFRNX1
**** begin user architecture code

.lib /home/rjridle/OpenRadHardSCL/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.inc DFFRNX1.spice

.control
tran 0.01n 40n
meas tran trise TRIG v(Y) VAL=0.18 RISE=1 TARG v(Y) VAL=1.68 RISE=1
meas tran tfall TRIG v(Y) VAL=1.68 FALL=1 TARG v(Y) VAL=0.18 FALL=1
run
.endc

**** end user architecture code
.end
