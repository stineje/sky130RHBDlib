v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N -0 80 0 100 {
lab=VSS}
N 150 -200 150 -180 {
lab=VDD}
N 0 20 110 20 {
lab=Y}
N 150 -60 160 -60 {
lab=VDD}
N 0 50 10 50 {
lab=VSS}
N 10 50 10 80 {
lab=VSS}
N 150 50 160 50 {
lab=VSS}
N 160 50 160 80 {
lab=VSS}
N 150 80 160 80 {
lab=VSS}
N 100 -150 110 -150 {
lab=A}
N 100 -60 110 -60 {
lab=B}
N 160 -180 160 -60 {
lab=VDD}
N 150 -150 160 -150 {
lab=VDD}
N 110 20 150 20 {
lab=Y}
N 150 -20 150 20 {
lab=Y}
N 150 0 180 0 {
lab=Y}
N -50 50 -40 50 {
lab=A}
N 100 50 110 50 {
lab=B}
N 0 80 150 80 {
lab=VSS}
N 150 -120 150 -90 {
lab=#net1}
N 150 -180 160 -180 {
lab=VDD}
N 150 -30 150 -20 {
lab=Y}
C {sky130_fd_pr/nfet_01v8.sym} -20 50 0 0 {name=M1
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
C {sky130_fd_pr/pfet_01v8.sym} 130 -150 0 0 {name=M2
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
C {sky130_fd_pr/nfet_01v8.sym} 130 50 0 0 {name=M3
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
C {sky130_fd_pr/pfet_01v8.sym} 130 -60 0 0 {name=M4
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
C {devices/lab_pin.sym} 100 -60 0 0 {name=l3 sig_type=std_logic lab=B}
C {devices/lab_pin.sym} 100 -150 0 0 {name=l4 sig_type=std_logic lab=A}
C {devices/lab_pin.sym} -50 50 0 0 {name=l5 sig_type=std_logic lab=A}
C {devices/lab_pin.sym} 100 50 0 0 {name=l6 sig_type=std_logic lab=B}
C {devices/lab_pin.sym} 0 100 0 0 {name=l1 lab=VSS}
C {devices/lab_pin.sym} 150 -200 0 0 {name=l2 lab=VDD}
C {devices/opin.sym} 180 0 0 0 {name=p1 lab=Y}
C {devices/ipin.sym} 50 -80 0 0 {name=p2 lab=A}
C {devices/ipin.sym} 50 -50 0 0 {name=p3 lab=B}
