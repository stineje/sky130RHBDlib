** sch_path: /home/rjridle/OpenRadHardSCL/lib/xschem/test_DFFX1.sch
**.subckt test_DFFX1
V1 VDD GND 1.8
V3 CLK GND pulse 0 1.8 0 1p 1p 5n 10n
x1 y0 y1 CLK VDD GND Mod4Counter
**** begin user architecture code

.lib /home/rjridle/OpenRadHardSCL/sky130A/libs.tech/ngspice/sky130.lib.spice tt

.subckt Mod4Counter y0 y1 CLK VDD VSS
X0 VDD a_1845_1050 a_147_187 VDD sky130_fd_pr__pfet_01v8 ad=2.132p pd=1.7332u as=0p ps=0u w=2u l=0.15u M=2
X1 y0 a_277_1050 VDD VDD sky130_fd_pr__pfet_01v8 ad=1.16p pd=9.16u as=0p ps=0u w=2u l=0.15u M=2
X2 VSS a_6137_1050 a_6698_101 VSS sky130_fd_pr__nfet_01v8 ad=2.1492p pd=1.884u as=0p ps=0u w=3u l=0.15u
X3 VDD y1 a_4891_989 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2u l=0.15u M=2
X4 VDD y1 a_7595_411 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2u l=0.15u M=2
X5 VSS a_277_1050 a_3072_101 VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=3u l=0.15u
X6 VDD CLK a_277_1050 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2u l=0.15u M=2
X7 VSS a_4891_989 a_6032_101 VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=3u l=0.15u
X8 y0 a_3303_411 VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2u l=0.15u M=2
X9 a_3303_411 a_147_187 a_3738_101 VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=3u l=0.15u
X10 y1 a_7595_411 a_7364_101 VSS sky130_fd_pr__nfet_01v8 ad=1.791p pd=1.57u as=0p ps=0u w=3u l=0.15u
X11 VDD CLK a_147_187 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2u l=0.15u M=2
X12 VDD a_3303_411 a_4439_187 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2u l=0.15u M=2
X13 VDD a_599_989 a_277_1050 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2u l=0.15u M=2
X14 a_3303_411 y0 VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2u l=0.15u M=2
X15 VDD a_277_1050 a_599_989 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2u l=0.15u M=2
X16 VDD a_147_187 a_3303_411 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2u l=0.15u M=2
X17 a_4569_1050 a_4891_989 VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2u l=0.15u M=2
X18 VDD a_4569_1050 y1 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=1.16p ps=9.16u w=2u l=0.15u M=2
X19 a_599_989 y0 a_1074_101 VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=3u l=0.15u
X20 VSS y1 a_8030_101 VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=3u l=0.15u
X21 a_1845_1050 a_147_187 VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2u l=0.15u M=2
X22 VDD a_4439_187 a_4569_1050 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2u l=0.15u M=2
X23 a_6137_1050 a_4439_187 VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2u l=0.15u M=2
X24 a_277_1050 a_599_989 a_372_210 VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=3u l=0.15u
X25 VSS a_1845_1050 a_2406_101 VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=3u l=0.15u
X26 a_4569_1050 a_4891_989 a_4664_210 VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=3u l=0.15u
X27 VDD y0 a_599_989 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2u l=0.15u M=2
X28 a_277_1050 a_147_187 VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2u l=0.15u M=2
X29 a_4439_187 a_6137_1050 VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2u l=0.15u M=2
X30 VDD a_7595_411 y1 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2u l=0.15u M=2
X31 y0 a_3303_411 a_3072_101 VSS sky130_fd_pr__nfet_01v8 ad=1.791p pd=1.57u as=0p ps=0u w=3u l=0.15u
X32 VDD a_3303_411 a_4569_1050 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2u l=0.15u M=2
X33 VSS a_147_187 a_91_103 VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=3u l=0.15u
X34 a_6137_1050 a_4439_187 a_6032_101 VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=3u l=0.15u
X35 a_4439_187 a_3303_411 a_6698_101 VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=3u l=0.15u
X36 VDD a_599_989 a_1845_1050 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2u l=0.15u M=2
X37 VSS a_4439_187 a_4383_103 VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=3u l=0.15u
X38 VSS a_599_989 a_1740_101 VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=3u l=0.15u
X39 VSS a_4569_1050 a_5366_101 VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=3u l=0.15u
X40 a_7595_411 a_4439_187 a_8030_101 VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=3u l=0.15u
X41 a_4891_989 a_4569_1050 VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2u l=0.15u M=2
X42 a_372_210 CLK a_91_103 VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=3u l=0.15u
X43 a_7595_411 a_4439_187 VDD VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2u l=0.15u M=2
X44 a_147_187 CLK a_2406_101 VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=3u l=0.15u
X45 a_4664_210 a_3303_411 a_4383_103 VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=3u l=0.15u
X46 VDD a_4891_989 a_6137_1050 VDD sky130_fd_pr__pfet_01v8 ad=0p pd=0u as=0p ps=0u w=2u l=0.15u M=2
X47 VSS y0 a_3738_101 VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=3u l=0.15u
X48 VSS a_4569_1050 a_7364_101 VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=3u l=0.15u
X49 VSS a_277_1050 a_1074_101 VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=3u l=0.15u
X50 a_1845_1050 a_147_187 a_1740_101 VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=3u l=0.15u
X51 a_4891_989 y1 a_5366_101 VSS sky130_fd_pr__nfet_01v8 ad=0p pd=0u as=0p ps=0u w=3u l=0.15u
C0 VDD a_4891_989 2.47fF
C1 VDD a_4569_1050 3.17fF
C2 VDD a_599_989 2.47fF
C3 a_4439_187 a_3303_411 3.59fF
C4 VDD a_277_1050 3.17fF
C5 VDD a_1845_1050 2.20fF
C6 VDD a_7595_411 2.20fF
C7 a_4569_1050 a_4439_187 3.03fF
C8 VDD a_4439_187 6.38fF
C9 VDD a_147_187 6.38fF
C10 VDD y0 2.52fF
C11 VDD y1 2.52fF
C12 a_147_187 a_277_1050 3.03fF
C13 CLK a_147_187 3.16fF
C14 VDD a_6137_1050 2.20fF
C15 VDD a_3303_411 4.06fF
C16 VDD VSS 13.47fF
.ends

**** end user architecture code
**.ends
.GLOBAL VDD
.GLOBAL GND
**** begin user architecture code

.tran 0.01n 45n
.save all
**** end user architecture code
.end
