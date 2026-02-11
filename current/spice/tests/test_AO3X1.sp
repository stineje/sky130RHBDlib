** magic
**.subckt test_NAND3X1
V2 A GND pulse(0 1.8 0 1p 1p 5n 10n)
V3 B GND pulse(0 1.8 0 1p 1p 10n 20n)
V4 C GND pulse(0 1.8 0 1p 1p 20n 40n)
V1 VDD GND 1.8

x1 Y A B C VDD GND AO3X1

**** begin user architecture code
.lib /home/rjridle/OpenRadHardSCL/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.inc MUX2X1.spice

.control
tran 0.01n 90n
meas tran trise TRIG v(Y) VAL=0.18 RISE=1 TARG v(Y) VAL=1.68 RISE=1
meas tran tfall TRIG v(Y) VAL=1.68 FALL=1 TARG v(Y) VAL=0.18 FALL=1
run
.endc

.end
