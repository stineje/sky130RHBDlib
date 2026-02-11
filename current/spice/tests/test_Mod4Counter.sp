** sch_path: /home/rjridle/OpenRadHardSCL/lib/xschem/test_DFFX1.sch
**.subckt test_DFFX1
V1 VDD GND 1.8
V2 CLK GND pulse 0 1.8 0 1p 1p 5n 10n
x1 y0 y1 CLK VDD GND Mod4Counter
**** begin user architecture code

.lib /home/rjridle/OpenRadHardSCL/sky130A/libs.tech/ngspice/sky130.lib.spice tt

.inc Mod4Counter.spice

**** end user architecture code
**.ends
.GLOBAL VDD
.GLOBAL GND
**** begin user architecture code

.tran 0.01n 45n
.save all
**** end user architecture code
.end
