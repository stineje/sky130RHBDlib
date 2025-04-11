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
.SUBCKT NOR2X1 GND VDD A B Y
** N=53 EP=5 IP=0 FDC=6
M0 Y A GND 53 nmos L=0.163346 W=2.31104 $X=840 $Y=825 $D=3
M1 Y B GND 53 nmos L=0.163129 W=2.31397 $X=1810 $Y=825 $D=3
M2 VDD A 6 51 pmos L=0.15 W=2 AD=0.57 AS=0.57 PD=2.57 PS=2.57 NRD=0 NRS=0 m=1 $X=935 $Y=5025 $D=27
M3 6 A VDD 51 pmos L=0.15 W=2 AD=0.58 AS=0.58 PD=2.58 PS=2.58 NRD=0 NRS=0 m=1 $X=1375 $Y=5025 $D=27
M4 Y B 6 51 pmos L=0.15 W=2 AD=0.58 AS=0.58 PD=2.58 PS=2.58 NRD=0 NRS=0 m=1 $X=1815 $Y=5025 $D=27
M5 6 B Y 51 pmos L=0.15 W=2 AD=0.56 AS=0.56 PD=2.56 PS=2.56 NRD=0 NRS=0 m=1 $X=2255 $Y=5025 $D=27
.ENDS
***************************************
