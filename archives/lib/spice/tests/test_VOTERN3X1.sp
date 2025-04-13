** sch_path: /home/rjridle/OpenRadHardSCL/lib/xschem/test_VOTERN3X1.sch

**.subckt test_VOTERN3X1
V2 A GND pulse 0 1.8 0 1p 1p 20ns 40ns
V1 VDD GND 1.8
x1 YN A A A VDD GND VOTERN3X1

**** begin user architecture code

.lib /home/rjridle/OpenRadHardSCL/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.inc VOTERN3X1.spice


.control
tran 0.01n 90n
meas tran trise TRIG v(YN) VAL=0.18 RISE=1 TARG v(YN) VAL=1.68 RISE=1
meas tran tfall TRIG v(YN) VAL=1.68 FALL=1 TARG v(YN) VAL=0.18 FALL=1
run
.endc


**** end user architecture code
.end
