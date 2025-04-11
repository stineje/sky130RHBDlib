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
.SUBCKT VOTERN3X1 GND VDD B C A YN
** N=118 EP=6 IP=0 FDC=18
M0 GND B 9 118 nmos L=0.163119 W=2.35104 $X=840 $Y=785 $D=3
M1 YN A 9 118 nmos L=0.163346 W=2.31104 $X=1810 $Y=825 $D=3
M2 GND B 10 118 nmos L=0.163119 W=2.35104 $X=4170 $Y=785 $D=3
M3 YN C 10 118 nmos L=0.163346 W=2.31104 $X=5140 $Y=825 $D=3
M4 GND C 11 118 nmos L=0.163119 W=2.35104 $X=7500 $Y=785 $D=3
M5 YN A 11 118 nmos L=0.163129 W=2.31397 $X=8470 $Y=825 $D=3
M6 3 B VDD 116 pmos L=0.15 W=2 AD=0.57 AS=0.57 PD=2.57 PS=2.57 NRD=0 NRS=0 m=1 $X=935 $Y=5025 $D=27
M7 VDD B 3 116 pmos L=0.15 W=2 AD=0.58 AS=0.58 PD=2.58 PS=2.58 NRD=0 NRS=0 m=1 $X=1375 $Y=5025 $D=27
M8 3 A VDD 116 pmos L=0.15 W=2 AD=0.58 AS=0.58 PD=2.58 PS=2.58 NRD=0 NRS=0 m=1 $X=1815 $Y=5025 $D=27
M9 VDD A 3 116 pmos L=0.15 W=2 AD=0.56 AS=0.56 PD=2.56 PS=2.56 NRD=0 NRS=0 m=1 $X=2255 $Y=5025 $D=27
M10 6 B 3 116 pmos L=0.15 W=2 AD=0.56 AS=0.56 PD=2.56 PS=2.56 NRD=0 NRS=0 m=1 $X=4255 $Y=5025 $D=27
M11 3 B 6 116 pmos L=0.15 W=2 AD=0.58 AS=0.58 PD=2.58 PS=2.58 NRD=0 NRS=0 m=1 $X=4695 $Y=5025 $D=27
M12 6 C 3 116 pmos L=0.15 W=2 AD=0.58 AS=0.58 PD=2.58 PS=2.58 NRD=0 NRS=0 m=1 $X=5135 $Y=5025 $D=27
M13 3 C 6 116 pmos L=0.15 W=2 AD=0.57 AS=0.57 PD=2.57 PS=2.57 NRD=0 NRS=0 m=1 $X=5575 $Y=5025 $D=27
M14 YN C 6 116 pmos L=0.15 W=2 AD=0.57 AS=0.57 PD=2.57 PS=2.57 NRD=0 NRS=0 m=1 $X=7595 $Y=5025 $D=27
M15 6 C YN 116 pmos L=0.15 W=2 AD=0.58 AS=0.58 PD=2.58 PS=2.58 NRD=0 NRS=0 m=1 $X=8035 $Y=5025 $D=27
M16 YN A 6 116 pmos L=0.15 W=2 AD=0.58 AS=0.58 PD=2.58 PS=2.58 NRD=0 NRS=0 m=1 $X=8475 $Y=5025 $D=27
M17 6 A YN 116 pmos L=0.15 W=2 AD=0.56 AS=0.56 PD=2.56 PS=2.56 NRD=0 NRS=0 m=1 $X=8915 $Y=5025 $D=27
.ENDS
***************************************
