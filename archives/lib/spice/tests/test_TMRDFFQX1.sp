** magic
** 20% = 0.36
** 80% = 1.44
** min rise time = 0.01n
** min load cap = 0.09p
** SIM Results
** 0.36v @ 8.328p
** 1.44V @ 18.34p
** 50% input @ 13.34p
** 50% output @ 179.9p
** cell rise = 166.56p
**.subckt test_TMRDFFQX1


V1 VDD GND 1.8
V2 CLK GND pwl 0p 0 5p 0 21.67p 1.8
V3 D GND pwl 0p 1.8

x1 Q D CLK VDD GND TMRDFFQX1
C1 Q GND 0.09p
**** begin user architecture code

.lib /home/rjridle/OpenRadHardSCL/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.inc TMRDFFQX1.spice

.tran 0.1p 500p
.meas tran cell_rise TRIG v(Q) VAL=0.9 RISE=LAST TARG v(CLK) VAL=0.9 RISE=LAST 


.control
.endc


**** end user architecture code
.end
