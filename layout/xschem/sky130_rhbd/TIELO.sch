v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N -20 -100 -0 -100 {
lab=VDD}
N -0 -100 0 -80 {
lab=VDD}
N -20 100 -0 100 {
lab=VSS}
N -0 80 -0 100 {
lab=VSS}
N -0 50 10 50 {
lab=VSS}
N 10 50 10 80 {
lab=VSS}
N 0 80 10 80 {
lab=VSS}
N -0 -50 10 -50 {
lab=VDD}
N 10 -80 10 -50 {
lab=VDD}
N 0 -80 10 -80 {
lab=VDD}
N -0 -0 -0 20 {
lab=YN}
N -0 -0 40 -0 {
lab=YN}
N -40 -50 -40 50 {}
N -40 -20 0 -20 {}
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
C {devices/lab_pin.sym} -20 100 0 0 {name=l1 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} -20 -100 0 0 {name=l2 sig_type=std_logic lab=VDD}
C {devices/opin.sym} 40 0 0 0 {name=p1 lab=YN}
