** sch_path: /home/rjridle/OpenRadHardSCL/lib/xschem/test_HA.sch
**.subckt test_HA
V2 B GND pulse 0 1.8 1n 1p 1p 10n 20n
V1 VDD GND 1.8
V3 A GND pulse 0 1.8 0 1p 1p 5n 10n
x1 SUM COUT A B VDD GND HA
**** begin user architecture code

.lib /home/rjridle/OpenRadHardSCL/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.inc HA.spice


.save all
.tran 0.01n 50n

**** end user architecture code
.end
