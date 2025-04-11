* SPICE NETLIST
***************************************

.SUBCKT pad_bond pin0
.ENDS
***************************************
.SUBCKT pad_microprobe pin0
.ENDS
***************************************
.SUBCKT pad_probe pin0
.ENDS
***************************************
.SUBCKT nmos_de_iso_v20 src gate drn b sub
.ENDS
***************************************
.SUBCKT XNOR2X1 GND VDD A Y B
** N=136 EP=5 IP=0 FDC=18
M0 4 A GND 136 nmos L=0.163346 W=2.31104 $X=775 $Y=830 $D=3
M1 GND A 9 136 nmos L=0.163119 W=2.35104 $X=3060 $Y=785 $D=3
M2 Y 6 9 136 nmos L=0.163346 W=2.31104 $X=4030 $Y=825 $D=3
M3 GND B 11 136 nmos L=0.163119 W=2.35104 $X=6390 $Y=785 $D=3
M4 Y 4 11 136 nmos L=0.163346 W=2.31104 $X=7360 $Y=825 $D=3
M5 6 B GND 136 nmos L=0.163346 W=2.31104 $X=9645 $Y=830 $D=3
M6 4 A VDD 134 pmos L=0.15 W=2 AD=0.57 AS=0.57 PD=2.57 PS=2.57 NRD=0 NRS=0 m=1 $X=820 $Y=5020 $D=27
M7 VDD A 4 134 pmos L=0.15 W=2 AD=0.56 AS=0.56 PD=2.56 PS=2.56 NRD=0 NRS=0 m=1 $X=1260 $Y=5020 $D=27
M8 VDD A 8 134 pmos L=0.15 W=2 AD=0.57 AS=0.57 PD=2.57 PS=2.57 NRD=0 NRS=0 m=1 $X=3155 $Y=5020 $D=27
M9 8 A VDD 134 pmos L=0.15 W=2 AD=0.58 AS=0.58 PD=2.58 PS=2.58 NRD=0 NRS=0 m=1 $X=3595 $Y=5020 $D=27
M10 Y B 8 134 pmos L=0.15 W=2 AD=0.58 AS=0.58 PD=2.58 PS=2.58 NRD=0 NRS=0 m=1 $X=4035 $Y=5020 $D=27
M11 8 B Y 134 pmos L=0.15 W=2 AD=0.56 AS=0.56 PD=2.56 PS=2.56 NRD=0 NRS=0 m=1 $X=4475 $Y=5020 $D=27
M12 VDD 6 10 134 pmos L=0.15 W=2 AD=0.57 AS=0.57 PD=2.57 PS=2.57 NRD=0 NRS=0 m=1 $X=6485 $Y=5020 $D=27
M13 10 6 VDD 134 pmos L=0.15 W=2 AD=0.58 AS=0.58 PD=2.58 PS=2.58 NRD=0 NRS=0 m=1 $X=6925 $Y=5020 $D=27
M14 Y 4 10 134 pmos L=0.15 W=2 AD=0.58 AS=0.58 PD=2.58 PS=2.58 NRD=0 NRS=0 m=1 $X=7365 $Y=5020 $D=27
M15 10 4 Y 134 pmos L=0.15 W=2 AD=0.56 AS=0.56 PD=2.56 PS=2.56 NRD=0 NRS=0 m=1 $X=7805 $Y=5020 $D=27
M16 6 B VDD 134 pmos L=0.15 W=2 AD=0.56 AS=0.56 PD=2.56 PS=2.56 NRD=0 NRS=0 m=1 $X=9690 $Y=5020 $D=27
M17 VDD B 6 134 pmos L=0.15 W=2 AD=0.57 AS=0.57 PD=2.57 PS=2.57 NRD=0 NRS=0 m=1 $X=10130 $Y=5020 $D=27
.ENDS
***************************************
