** sch_path: /home/rjridle/OpenRadHardSCL/lib/xschem/test_NOR2X1.sch
**.subckt test_NOR2X1
V1 VDD GND 1.8
V2 A GND pwl 0n 1.8 1n 1.8 1.01n 0 2n 0 2.01n 1.8
V3 B GND pwl 0n 1.8 1n 1.8 1.01n 0 2n 0 2.01n 1.8
x1 Y A B VDD GND NOR2X1
**** begin user architecture code

.lib /home/rjridle/OpenRadHardSCL/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.inc NOR2X1.spice


.control
tran 0.01n 50n
meas tran trise TRIG v(Y) VAL=0.18 RISE=1 TARG v(Y) VAL=1.68 RISE=1
meas tran tfall TRIG v(Y) VAL=1.68 FALL=1 TARG v(Y) VAL=0.18 FALL=1
run
.endc

**** end user architecture code
.end
