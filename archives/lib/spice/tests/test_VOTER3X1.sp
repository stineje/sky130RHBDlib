** sch_path: /home/rjridle/OpenRadHardSCL/lib/xschem/test_VOTERN3X1.sch

**.subckt test_VOTERN3X1
V2 A GND pulse 0 1.8 0 1p 1p 2ns 4ns
V1 VDD GND 1.8
x1 Y A A A VDD GND VOTER3X1

**** begin user architecture code

.lib /home/rjridle/OpenRadHardSCL/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.inc VOTER3X1.spice


.control
tran 0.01n 90n
meas tran trise TRIG v(Y) VAL=0.18 RISE=1 TARG v(Y) VAL=1.68 RISE=1
meas tran tfall TRIG v(Y) VAL=1.68 FALL=1 TARG v(Y) VAL=0.18 FALL=1
run
.endc


**** end user architecture code
.end
