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
.SUBCKT AND3X1 GND VDD A B C Y
** N=88 EP=6 IP=0 FDC=12
M0 GND A 6 88 nmos L=0.163119 W=2.35104 $X=735 $Y=795 $D=3
M1 8 B 6 88 nmos L=0.160516 W=2.29447 $X=1710 $Y=830 $D=3
M2 3 C 8 88 nmos L=0.163346 W=2.31104 $X=3245 $Y=835 $D=3
M3 Y 3 GND 88 nmos L=0.163346 W=2.31104 $X=5585 $Y=830 $D=3
M4 3 A VDD 86 pmos L=0.15 W=2 AD=0.57 AS=0.57 PD=2.57 PS=2.57 NRD=0 NRS=0 m=1 $X=1235 $Y=5020 $D=27
M5 VDD A 3 86 pmos L=0.15 W=2 AD=0.58 AS=0.58 PD=2.58 PS=2.58 NRD=0 NRS=0 m=1 $X=1675 $Y=5020 $D=27
M6 3 B VDD 86 pmos L=0.15 W=2 AD=0.58 AS=0.58 PD=2.58 PS=2.58 NRD=0 NRS=0 m=1 $X=2115 $Y=5020 $D=27
M7 VDD B 3 86 pmos L=0.15 W=2 AD=0.58 AS=0.58 PD=2.58 PS=2.58 NRD=0 NRS=0 m=1 $X=2555 $Y=5020 $D=27
M8 3 C VDD 86 pmos L=0.15 W=2 AD=0.58 AS=0.58 PD=2.58 PS=2.58 NRD=0 NRS=0 m=1 $X=2995 $Y=5020 $D=27
M9 VDD C 3 86 pmos L=0.15 W=2 AD=0.56 AS=0.56 PD=2.56 PS=2.56 NRD=0 NRS=0 m=1 $X=3435 $Y=5020 $D=27
M10 Y 3 VDD 86 pmos L=0.15 W=2 AD=0.57 AS=0.57 PD=2.57 PS=2.57 NRD=0 NRS=0 m=1 $X=5630 $Y=5020 $D=27
M11 VDD 3 Y 86 pmos L=0.15 W=2 AD=0.56 AS=0.56 PD=2.56 PS=2.56 NRD=0 NRS=0 m=1 $X=6070 $Y=5020 $D=27
.ENDS
***************************************
