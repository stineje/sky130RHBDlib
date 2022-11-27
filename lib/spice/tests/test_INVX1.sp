** INVX1 (Magic)
**.subckt test_INVX1
V1 PWR GND 1.8
V2 A GND 1.8 PWL(0n 0 1n 0 5n 1.8 20n 1.8 25n 0)
xinv1 Y A PWR GND INVX1

**** begin user architecture code
.lib /home/rjridle/OpenRadHardSCL/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.inc ../spice/INVX1.spice

.control
tran 0.1n 30n
meas tran trise TRIG v(Y) VAL=0.18 RISE=1 TARG v(Y) VAL=1.68 RISE=1
meas tran tfall TRIG v(Y) VAL=1.68 FALL=1 TARG v(Y) VAL=0.18 FALL=1
plot A Y
run
.endc

.end
