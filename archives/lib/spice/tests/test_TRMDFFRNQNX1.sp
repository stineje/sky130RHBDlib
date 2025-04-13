** sch_path: /home/rjridle/OpenRadHardSCL/lib/xschem/test_TMRDFFRNQNX1.sch
**.subckt test_TMRDFFRNQNX1
V1 VDD GND 1.8
V3 CLK GND pulse 0 1.8 0 1p 1p 5n 10n
V4 D0 GND pulse 0 1.8 5n 1p 1p 10n 20n
V2 D1 GND pulse 0 1.8 5n 1p 1p 20n 40n
V5 D2 GND pulse 0 1.8 5n 1p 1p 40n 80n
x1 QN D0 RN CLK D1 D2 VDD GND TMRDFFRNQNX1
V6 RN GND pwl 0n 1.8 82n 1.8 82.1n 0
**** begin user architecture code

.lib /home/rjridle/OpenRadHardSCL/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.inc TMRDFFRNQNX1.spice

.save all
.tran 0.1n 170n


**** end user architecture code
.end
