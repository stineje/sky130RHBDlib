v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 140 80 140 100 {
lab=#net1}
N 140 50 150 50 {
lab=VSS}
N 150 50 150 160 {
lab=VSS}
N 140 160 150 160 {
lab=VSS}
N 140 130 150 130 {
lab=VSS}
N -50 -50 -40 -50 {
lab=A}
N 90 -50 100 -50 {
lab=B}
N 90 50 100 50 {
lab=B}
N 90 130 100 130 {
lab=A}
N 0 -110 0 -80 {
lab=VDD}
N 140 160 140 190 {
lab=VSS}
N 0 -80 140 -80 {
lab=VDD}
N -0 -50 10 -50 {
lab=VDD}
N 10 -80 10 -50 {
lab=VDD}
N 140 -50 150 -50 {
lab=VDD}
N 150 -80 150 -50 {
lab=VDD}
N 140 -80 150 -80 {
lab=VDD}
N 0 -20 140 -20 {
lab=Y}
N 140 -20 140 20 {
lab=Y}
N 140 0 170 0 {
lab=Y}
C {sky130_fd_pr/pfet_01v8.sym} -20 -50 0 0 {name=M1
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
C {sky130_fd_pr/nfet_01v8.sym} 120 50 0 0 {name=M5
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
C {sky130_fd_pr/pfet_01v8.sym} 120 -50 0 0 {name=M2
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
C {sky130_fd_pr/nfet_01v8.sym} 120 130 0 0 {name=M3
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
C {devices/lab_pin.sym} 90 -50 0 0 {name=l3 sig_type=std_logic lab=B}
C {devices/lab_pin.sym} -50 -50 0 0 {name=l4 sig_type=std_logic lab=A}
C {devices/lab_pin.sym} 90 130 0 0 {name=l5 sig_type=std_logic lab=A}
C {devices/lab_pin.sym} 90 50 0 0 {name=l6 sig_type=std_logic lab=B}
C {devices/lab_pin.sym} 0 -110 0 0 {name=l1 sig_type=std_logic lab=VDD}
C {devices/lab_pin.sym} 140 190 0 0 {name=l2 lab=VSS}
C {devices/opin.sym} 170 0 0 0 {name=p1 lab=Y}
C {devices/ipin.sym} 40 30 0 0 {name=p2 lab=A}
C {devices/ipin.sym} 40 70 0 0 {name=p3 lab=B}
