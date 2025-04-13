v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N -20 120 -0 120 {
lab=VSS}
N -0 80 0 120 {
lab=VSS}
N -20 -120 -0 -120 {
lab=VDD}
N -0 -120 0 -80 {
lab=VDD}
N -0 -50 10 -50 {
lab=VDD}
N 10 -90 10 -50 {
lab=VDD}
N 0 -90 10 -90 {
lab=VDD}
N -0 50 10 50 {
lab=VSS}
N 10 50 10 90 {
lab=VSS}
N 0 90 10 90 {
lab=VSS}
N 0 -10 -0 0 {
lab=Y}
N -0 0 50 0 {
lab=Y}
N 0 -20 0 -10 {
lab=Y}
N -40 -50 -40 50 {}
N -40 20 0 20 {}
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
C {devices/lab_pin.sym} -20 120 0 0 {name=l1 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} -20 -120 0 0 {name=l2 sig_type=std_logic lab=VDD}
C {devices/opin.sym} 50 0 0 0 {name=p1 lab=Y}
