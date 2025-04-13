v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 0 240 0 260 {
lab=VSS}
N 0 -20 -0 20 {
lab=Y}
N 0 -100 0 -80 {
lab=VDD}
N -0 80 0 100 {
lab=#net1}
N 0 160 -0 180 {
lab=#net2}
N 0 50 10 50 {
lab=VSS}
N 10 50 10 250 {
lab=VSS}
N 0 250 10 250 {
lab=VSS}
N 0 130 10 130 {
lab=VSS}
N 0 210 10 210 {
lab=VSS}
N 0 -80 60 -80 {
lab=VDD}
N 130 -80 190 -80 {
lab=VDD}
N 130 -20 190 -20 {
lab=Y}
N 0 -20 60 -20 {
lab=Y}
N -50 -50 -40 -50 {
lab=A}
N 80 -50 90 -50 {
lab=B}
N 220 -50 230 -50 {
lab=C}
N -50 50 -40 50 {
lab=C}
N -50 130 -40 130 {
lab=B}
N -50 210 -40 210 {
lab=A}
N 0 0 30 0 {
lab=Y}
N 60 -80 130 -80 {
lab=VDD}
N 60 -20 130 -20 {
lab=Y}
N 190 -80 270 -80 {
lab=VDD}
N 190 -20 270 -20 {
lab=Y}
N 270 -50 280 -50 {
lab=VDD}
N 280 -80 280 -50 {
lab=VDD}
N 270 -80 280 -80 {
lab=VDD}
N 130 -50 140 -50 {
lab=VDD}
N 140 -80 140 -50 {
lab=VDD}
N -0 -50 10 -50 {
lab=VDD}
N 10 -80 10 -50 {
lab=VDD}
C {sky130_fd_pr/nfet_01v8.sym} -20 210 0 0 {name=M1
L=0.15
W=3
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
C {sky130_fd_pr/pfet_01v8.sym} -20 -50 0 0 {name=M2
L=0.15
W=2
nf=1
mult=2
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {devices/lab_pin.sym} -50 210 0 0 {name=l1 sig_type=std_logic lab=A}
C {sky130_fd_pr/nfet_01v8.sym} -20 130 0 0 {name=M3
L=0.15
W=3
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
C {sky130_fd_pr/nfet_01v8.sym} -20 50 0 0 {name=M4
L=0.15
W=3
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
C {sky130_fd_pr/pfet_01v8.sym} 110 -50 0 0 {name=M5
L=0.15
W=2
nf=1
mult=2
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} 250 -50 0 0 {name=M6
L=0.15
W=2
nf=1
mult=2
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {devices/lab_pin.sym} -50 130 0 0 {name=l4 sig_type=std_logic lab=B}
C {devices/lab_pin.sym} -50 50 0 0 {name=l5 sig_type=std_logic lab=C}
C {devices/lab_pin.sym} -50 -50 0 0 {name=l6 sig_type=std_logic lab=A}
C {devices/lab_pin.sym} 80 -50 0 0 {name=l7 sig_type=std_logic lab=B}
C {devices/lab_pin.sym} 220 -50 0 0 {name=l8 sig_type=std_logic lab=C}
C {devices/lab_pin.sym} 0 -100 0 0 {name=l2 lab=VDD}
C {devices/lab_pin.sym} 0 260 0 0 {name=l3 lab=VSS}
C {devices/opin.sym} 30 0 0 0 {name=p1 lab=Y}
C {devices/ipin.sym} -130 0 0 0 {name=p2 lab=A}
C {devices/ipin.sym} -130 30 0 0 {name=p3 lab=B}
C {devices/ipin.sym} -130 60 0 0 {name=p4 lab=C}
