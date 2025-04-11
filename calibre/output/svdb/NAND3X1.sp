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
.SUBCKT NAND3X1 GND VDD A B C Y
** N=63 EP=6 IP=0 FDC=9
M0 GND A 5 63 nmos L=0.163119 W=2.35104 $X=735 $Y=795 $D=3
M1 8 B 5 63 nmos L=0.160516 W=2.29447 $X=1710 $Y=830 $D=3
M2 Y C 8 63 nmos L=0.163346 W=2.31104 $X=3245 $Y=835 $D=3
M3 Y A VDD 61 pmos L=0.15 W=2 AD=0.57 AS=0.57 PD=2.57 PS=2.57 NRD=0 NRS=0 m=1 $X=1235 $Y=5020 $D=27
M4 VDD A Y 61 pmos L=0.15 W=2 AD=0.58 AS=0.58 PD=2.58 PS=2.58 NRD=0 NRS=0 m=1 $X=1675 $Y=5020 $D=27
M5 Y B VDD 61 pmos L=0.15 W=2 AD=0.58 AS=0.58 PD=2.58 PS=2.58 NRD=0 NRS=0 m=1 $X=2115 $Y=5020 $D=27
M6 VDD B Y 61 pmos L=0.15 W=2 AD=0.58 AS=0.58 PD=2.58 PS=2.58 NRD=0 NRS=0 m=1 $X=2555 $Y=5020 $D=27
M7 Y C VDD 61 pmos L=0.15 W=2 AD=0.58 AS=0.58 PD=2.58 PS=2.58 NRD=0 NRS=0 m=1 $X=2995 $Y=5020 $D=27
M8 VDD C Y 61 pmos L=0.15 W=2 AD=0.56 AS=0.56 PD=2.56 PS=2.56 NRD=0 NRS=0 m=1 $X=3435 $Y=5020 $D=27
.ENDS
***************************************
