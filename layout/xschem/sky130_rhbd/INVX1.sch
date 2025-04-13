v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N -40 -50 -40 50 {
lab=A}
N 0 -20 0 20 {
lab=Y}
N 0 0 20 0 {
lab=Y}
N -60 0 -40 0 {
lab=A}
N -0 -50 20 -50 {
lab=VDD}
N -0 50 20 50 {
lab=VSS}
N 20 50 20 80 {
lab=VSS}
N 20 -80 20 -50 {
lab=VDD}
N -0 -120 -0 -80 {
lab=VDD}
N 0 80 -0 120 {
lab=VSS}
N 20 80 20 90 {
lab=VSS}
N 0 90 20 90 {
lab=VSS}
N 20 -90 20 -80 {
lab=VDD}
N 0 -90 20 -90 {
lab=VDD}
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
C {devices/lab_pin.sym} 0 -120 0 0 {name=l1 lab=VDD}
C {devices/lab_pin.sym} 0 120 0 0 {name=l2 lab=VSS}
C {devices/opin.sym} 20 0 0 0 {name=p1 lab=Y}
C {devices/ipin.sym} -60 0 0 0 {name=p2 lab=A}
