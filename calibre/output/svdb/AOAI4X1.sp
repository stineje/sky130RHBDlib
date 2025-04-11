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
.SUBCKT AOAI4X1 GND VDD A B C D YN
** N=119 EP=7 IP=0 FDC=18
M0 GND A 7 119 nmos L=0.163119 W=2.35104 $X=840 $Y=785 $D=3
M1 3 B 7 119 nmos L=0.163346 W=2.31104 $X=1810 $Y=825 $D=3
M2 4 3 GND 119 nmos L=0.163346 W=2.31104 $X=4170 $Y=825 $D=3
M3 4 C GND 119 nmos L=0.163129 W=2.31397 $X=5140 $Y=825 $D=3
M4 GND 4 12 119 nmos L=0.163119 W=2.35104 $X=7500 $Y=785 $D=3
M5 YN D 12 119 nmos L=0.163346 W=2.31104 $X=8470 $Y=825 $D=3
M6 3 A VDD 117 pmos L=0.15 W=2 AD=0.57 AS=0.57 PD=2.57 PS=2.57 NRD=0 NRS=0 m=1 $X=935 $Y=5020 $D=27
M7 VDD A 3 117 pmos L=0.15 W=2 AD=0.58 AS=0.58 PD=2.58 PS=2.58 NRD=0 NRS=0 m=1 $X=1375 $Y=5020 $D=27
M8 3 B VDD 117 pmos L=0.15 W=2 AD=0.58 AS=0.58 PD=2.58 PS=2.58 NRD=0 NRS=0 m=1 $X=1815 $Y=5020 $D=27
M9 VDD B 3 117 pmos L=0.15 W=2 AD=0.56 AS=0.56 PD=2.56 PS=2.56 NRD=0 NRS=0 m=1 $X=2255 $Y=5020 $D=27
M10 VDD 3 9 117 pmos L=0.15 W=2 AD=0.57 AS=0.57 PD=2.57 PS=2.57 NRD=0 NRS=0 m=1 $X=4265 $Y=5025 $D=27
M11 9 3 VDD 117 pmos L=0.15 W=2 AD=0.58 AS=0.58 PD=2.58 PS=2.58 NRD=0 NRS=0 m=1 $X=4705 $Y=5025 $D=27
M12 4 C 9 117 pmos L=0.15 W=2 AD=0.58 AS=0.58 PD=2.58 PS=2.58 NRD=0 NRS=0 m=1 $X=5145 $Y=5025 $D=27
M13 9 C 4 117 pmos L=0.15 W=2 AD=0.56 AS=0.56 PD=2.56 PS=2.56 NRD=0 NRS=0 m=1 $X=5585 $Y=5025 $D=27
M14 YN 4 VDD 117 pmos L=0.15 W=2 AD=0.57 AS=0.57 PD=2.57 PS=2.57 NRD=0 NRS=0 m=1 $X=7595 $Y=5020 $D=27
M15 VDD 4 YN 117 pmos L=0.15 W=2 AD=0.58 AS=0.58 PD=2.58 PS=2.58 NRD=0 NRS=0 m=1 $X=8035 $Y=5020 $D=27
M16 YN D VDD 117 pmos L=0.15 W=2 AD=0.58 AS=0.58 PD=2.58 PS=2.58 NRD=0 NRS=0 m=1 $X=8475 $Y=5020 $D=27
M17 VDD D YN 117 pmos L=0.15 W=2 AD=0.56 AS=0.56 PD=2.56 PS=2.56 NRD=0 NRS=0 m=1 $X=8915 $Y=5020 $D=27
.ENDS
***************************************
