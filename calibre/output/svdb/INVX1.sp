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
.SUBCKT INVX1 GND VDD A Y
** N=45 EP=4 IP=0 FDC=3
M0 Y A GND 45 nmos L=0.163346 W=2.31104 $X=775 $Y=830 $D=3
M1 Y A VDD 43 pmos L=0.15 W=2 AD=0.57 AS=0.57 PD=2.57 PS=2.57 NRD=0 NRS=0 m=1 $X=820 $Y=5020 $D=27
M2 VDD A Y 43 pmos L=0.15 W=2 AD=0.56 AS=0.56 PD=2.56 PS=2.56 NRD=0 NRS=0 m=1 $X=1260 $Y=5020 $D=27
.ENDS
***************************************
