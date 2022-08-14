** sch_path: /home/rjridle/OpenRadHardSCL/lib/xschem/test_TMRDFFRNQX1.sch
**.subckt test_TMRDFFRNQX1
V1 VDD GND 1.8
V3 CLK GND pulse 0 1.8 0 1p 1p 5n 10n
V4 D0 GND pulse 0 1.8 5n 1p 1p 10n 20n
V2 D1 GND pulse 0 1.8 5n 1p 1p 20n 40n
V5 D2 GND pulse 0 1.8 5n 1p 1p 40n 80n
V6 RN GND pwl 0n 1.8 82n 1.8 82.1n 0
x1 Q D0 D1 D2 CLK RN VDD GND TMRDFFRNQX1
**** begin user architecture code

.lib /home/rjridle/OpenRadHardSCL/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.inc TMRDFFRNQX1.spice

.tran 0.1n 170n
.save all


**** end user architecture code
.end
