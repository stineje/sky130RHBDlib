** INVX1 (Magic)
**.subckt test_INVX1
V2 A GND pwl(0p 0 1p 0 17.667p 1.8)
V1 VDD GND 1.8
xinv12 Y A GND VDD INVX12

**** begin user architecture code
.lib /home/rjridle/OpenRadHardSCL/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.inc INVX12.spice

.control
tran 0.1p 3p
meas tran trise TRIG v(Y) VAL=0.18 RISE=1 TARG v(Y) VAL=1.68 RISE=1
meas tran tfall TRIG v(Y) VAL=1.68 FALL=1 TARG v(Y) VAL=0.18 FALL=1
run
.endc

.end
