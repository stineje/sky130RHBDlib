** sch_path: /home/rjridle/OpenRadHardSCL/lib/xschem/test_NAND3X1.sch
**.subckt test_AND3X1
V1 PWR GND 1.8
V2 A GND pulse 0 1.8 0 1n 1n 20n 40n
V3 B GND pulse 0 1.8 0 1n 1n 39n 80n
V4 C GND pulse 0 1.8 0 1n 1n 79n 160n
x1 Y A B C PWR GND AND3X1
**** begin user architecture code

.lib /home/rjridle/OpenRadHardSCL/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.inc ../spice/AND3X1.spice


.control
tran 0.1n 200n
meas tran trise TRIG v(Y) VAL=0.18 RISE=2 TARG v(Y) VAL=1.68 RISE=2
meas tran tfall TRIG v(Y) VAL=1.68 FALL=1 TARG v(Y) VAL=0.18 FALL=1
plot Y
plot A
plot B
plot C
run
.endc
**** end user architecture code
.end
