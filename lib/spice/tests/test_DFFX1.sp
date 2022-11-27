** sch_path: /home/rjridle/OpenRadHardSCL/lib/xschem/test_DFFX1.sch
**.subckt test_DFFX1
V2 D GND pwl 0n 1.8 10n 1.8 10.1n 0 20n 0 20.1n 1.8 27n 1.8 27.1n 0 34n 0 34.1n 1.8
V1 VDD GND 1.8
V3 CLK GND pulse 0 1.8 0 1p 1p 5n 10n
x1 Q QN D CLK VDD GND DFFX1
**** begin user architecture code

.lib /home/rjridle/OpenRadHardSCL/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.inc DFFX1.spice

.control
tran 0.01n 45n
run
.endc
**** end user architecture code
.end
