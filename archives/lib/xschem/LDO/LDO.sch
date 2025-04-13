v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 220 300 420 300 {
lab=GND}
N 220 -90 420 -90 {
lab=#net1}
N 320 300 320 330 {
lab=GND}
N 320 -130 320 -90 {
lab=#net1}
N 220 190 280 190 {
lab=#net2}
N 280 190 280 240 {
lab=#net2}
N 260 240 380 240 {
lab=#net2}
N 220 -90 220 -50 {
lab=#net1}
N 220 10 220 90 {
lab=#net3}
N 220 150 220 170 {
lab=#net2}
N 220 170 220 190 {
lab=#net2}
N 220 190 220 210 {
lab=#net2}
N 220 270 220 300 {
lab=GND}
N 420 270 420 300 {
lab=GND}
N 420 240 460 240 {
lab=GND}
N 180 240 220 240 {
lab=GND}
N 420 150 420 210 {
lab=V_DIFF_OUT}
N 420 10 420 70 {
lab=#net4}
N 420 70 420 90 {
lab=#net4}
N 220 -20 260 -20 {
lab=VDD}
N 380 -20 420 -20 {
lab=VDD}
N 460 -20 480 -20 {
lab=PLUS_FB}
N 420 -90 420 -50 {
lab=#net1}
N 320 -280 320 -250 {
lab=VDD}
N 570 190 600 190 {
lab=GND}
N 570 -280 570 -250 {
lab=VDD}
N 570 220 570 240 {
lab=GND}
N 570 50 570 160 {
lab=V_COMSRC_OUT}
N 320 -220 360 -220 {
lab=VDD}
N 570 -220 610 -220 {
lab=VDD}
N 860 -310 860 -290 {
lab=VDD}
N 860 -310 900 -310 {
lab=VDD}
N 860 -230 860 -210 {
lab=GND}
N 130 80 130 100 {
lab=GND}
N 570 0 570 50 {
lab=V_COMSRC_OUT}
N 260 -220 280 -220 {
lab=V_BIAS}
N 500 -220 530 -220 {
lab=V_BIAS}
N 40 -220 80 -220 {
lab=V_BIAS}
N 0 -300 0 -250 {
lab=VDD}
N -10 -220 0 -220 {
lab=VDD}
N -10 -250 -10 -220 {
lab=VDD}
N -10 -250 0 -250 {
lab=VDD}
N 570 240 570 330 {
lab=GND}
N 900 80 900 100 {
lab=V_OUT}
N 420 190 530 190 {
lab=V_DIFF_OUT}
N 570 80 660 80 {
lab=V_COMSRC_OUT}
N 720 80 760 80 {
lab=#net5}
N 820 80 900 80 {
lab=V_OUT}
N 900 80 1100 80 {
lab=V_OUT}
N 1100 80 1100 180 {
lab=V_OUT}
N 1100 80 1280 80 {
lab=V_OUT}
N 1280 80 1330 80 {
lab=V_OUT}
N 860 40 860 80 {
lab=V_OUT}
N 860 30 860 40 {
lab=V_OUT}
N 570 -0 820 -0 {
lab=V_COMSRC_OUT}
N 860 -60 860 -30 {
lab=VDD}
N 130 -20 180 -20 {
lab=MINUS_BIAS}
N 130 -20 130 20 {
lab=MINUS_BIAS}
N 50 -220 50 -180 {
lab=V_BIAS}
N -0 -180 50 -180 {
lab=V_BIAS}
N -0 -190 -0 -170 {
lab=V_BIAS}
N 0 -110 0 -90 {
lab=GND}
N 570 -130 570 0 {
lab=V_COMSRC_OUT}
N 900 160 900 240 {
lab=PLUS_FB}
N 900 300 900 310 {
lab=#net6}
N 860 0 890 0 {
lab=VDD}
N 1260 80 1260 160 {
lab=V_OUT}
N 1260 220 1260 240 {
lab=#net7}
C {sky130_fd_pr/nfet_01v8.sym} 240 240 0 1 {name=M6
L=0.15
W=2
nf=1 
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} 400 240 0 0 {name=M5
L=0.15
W=2
nf=1 
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} 440 -20 0 1 {name=M7
L=0.15
W=5
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} 200 -20 0 0 {name=M10
L=0.15
W=5
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} 300 -220 0 0 {name=M11
L=0.15
W=5
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} 550 190 0 0 {name=M13
L=0.15
W=5
nf=1 
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} 550 -220 0 0 {name=M16
L=0.15
W=8
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {devices/vsource.sym} 130 50 0 0 {name=V2 value=0.6 only_toplevel=true}
C {devices/lab_pin.sym} 130 -20 0 0 {name=l35 sig_type=std_logic lab=MINUS_BIAS}
C {devices/vsource.sym} 860 -260 0 0 {name=V3 value=1.8 only_toplevel=true}
C {devices/vdd.sym} 900 -310 0 0 {name=l6 lab=VDD}
C {devices/vdd.sym} 320 -280 0 0 {name=l7 lab=VDD}
C {devices/vdd.sym} 570 -280 0 0 {name=l8 lab=VDD}
C {devices/vdd.sym} 610 -220 0 0 {name=l24 lab=VDD}
C {devices/vdd.sym} 360 -220 0 0 {name=l15 lab=VDD}
C {devices/vdd.sym} 260 -20 0 0 {name=l17 lab=VDD}
C {devices/vdd.sym} 380 -20 0 0 {name=l18 lab=VDD}
C {devices/gnd.sym} 180 240 0 0 {name=l10 lab=GND}
C {devices/gnd.sym} 320 330 0 0 {name=l11 lab=GND}
C {devices/gnd.sym} 460 240 0 0 {name=l12 lab=GND}
C {devices/gnd.sym} 600 190 0 0 {name=l13 lab=GND}
C {devices/gnd.sym} 860 -210 0 0 {name=l32 lab=GND}
C {devices/gnd.sym} 130 100 0 0 {name=l34 lab=GND}
C {devices/opin.sym} 1330 80 0 0 {name=p18 sig_type=std_logic lab=V_OUT}
C {devices/spice_probe.sym} 470 -20 0 0 {name=p2 attrs=""
voltage=
0.5896}
C {devices/spice_probe.sym} 170 -20 0 1 {name=p1 attrs=""
voltage=
0.6}
C {devices/spice_probe.sym} 420 70 0 1 {name=p6 attrs=""
voltage=0.6624}
C {devices/spice_probe.sym} 220 70 0 0 {name=p3 attrs=""
voltage=
0.6072}
C {devices/code.sym} 1000 -180 0 0 {name=STIMULI
only_toplevel=true
place=end
value="
.save all
.op
.dc V3 1 2 0.1
"
}
C {devices/code.sym} 1110 -180 0 0 {name=TT_MODULES
only_toplevel=true
format="tcleval( @value )"
value="
.lib $::SKYWATER_MODELS/sky130.lib.spice tt

"
}
C {devices/launcher.sym} 1110 -40 0 0 {name=h1
descr=Annotate 
tclcommand="ngspice::annotate"}
C {devices/launcher.sym} 1110 0 0 0 {name=h2
descr="View Raw file" 
tclcommand="textwindow $netlist_dir/[file tail [file rootname [ xschem get schname 0 ] ] ].raw"
}
C {devices/spice_probe.sym} 710 0 0 0 {name=p11 attrs=""
voltage=
0.7489}
C {devices/gnd.sym} 570 330 0 0 {name=l16 lab=GND}
C {devices/ammeter.sym} 220 120 0 0 {name=Vmeas_DIFFPAIR_LEFT
current=9.9965e-07}
C {devices/ammeter.sym} 420 120 0 0 {name=Vmeas_DIFFPAIR_RIGHT
current=1.0622e-06}
C {devices/ammeter.sym} 570 -160 0 0 {name=Vmeas_COMSRC
current=9.6676e-06}
C {devices/lab_pin.sym} 260 -220 0 0 {name=l4 sig_type=std_logic lab=V_BIAS}
C {devices/lab_pin.sym} 500 -220 0 0 {name=l5 sig_type=std_logic lab=V_BIAS}
C {devices/spice_probe.sym} 270 -220 0 1 {name=p4 attrs=""
voltage=
1.105}
C {devices/spice_probe.sym} 520 -220 0 1 {name=p5 attrs=""
voltage=
1.105}
C {devices/res.sym} 900 130 0 0 {name=Rdv1
value=10k
footprint=1206
device=resistor
m=1}
C {devices/res.sym} 900 340 0 0 {name=Rdv2
value=11k
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 900 370 0 0 {name=l14 lab=GND}
C {devices/lab_pin.sym} 900 200 0 1 {name=l19 sig_type=std_logic lab=PLUS_FB}
C {devices/ammeter.sym} 900 270 0 0 {name=Vmeas_RESDIV
current=5.3597e-05}
C {devices/ammeter.sym} 320 -160 0 0 {name=Vmeas_DIFFPAIR_TOP
current=2.0618e-06}
C {sky130_fd_pr/pfet_01v8.sym} 20 -220 0 1 {name=M2
L=0.15
W=5
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {devices/lab_pin.sym} 80 -220 0 1 {name=l1 sig_type=std_logic lab=V_BIAS}
C {devices/vdd.sym} 0 -300 0 0 {name=l3 lab=VDD}
C {devices/isource.sym} 0 -140 0 0 {name=I0 value=3u}
C {devices/gnd.sym} 0 -90 0 0 {name=l20 lab=GND}
C {devices/lab_pin.sym} 480 -20 0 1 {name=l2 sig_type=std_logic lab=PLUS_FB}
C {devices/res.sym} 690 80 1 0 {name=Rcs
value=1k
footprint=1206
device=resistor
m=1}
C {devices/capa.sym} 790 80 3 0 {name=Ccs
m=1
value=10p
footprint=1206
device="ceramic capacitor"}
C {devices/capa.sym} 1100 210 0 0 {name=Cload
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 1100 240 0 0 {name=l9 lab=GND}
C {sky130_fd_pr/pfet_01v8.sym} 840 0 0 0 {name=M1
L=0.15
W=8
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {devices/lab_pin.sym} 420 170 0 1 {name=l23 sig_type=std_logic lab=V_DIFF_OUT}
C {devices/lab_pin.sym} 570 20 0 1 {name=l25 sig_type=std_logic lab=V_COMSRC_OUT}
C {devices/vdd.sym} 860 -60 0 0 {name=l26 lab=VDD}
C {devices/vdd.sym} 890 0 0 0 {name=l22 lab=VDD}
C {devices/res.sym} 1260 270 0 0 {name=Rload
value=10k
footprint=1206
device=resistor
m=1}
C {devices/gnd.sym} 1260 300 0 0 {name=l21 lab=GND}
C {devices/spice_probe.sym} 50 -180 0 0 {name=p7 attrs=""
voltage=
1.105}
C {devices/ammeter.sym} 1260 190 0 0 {name=Vmeas_LOAD
current=1.1255e-04}
C {devices/spice_probe.sym} 1030 80 0 0 {name=p8 attrs=""
voltage=
1.126}
