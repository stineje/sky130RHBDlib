v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 160 80 160 100 {
lab=#net1}
N 160 -20 160 20 {
lab=Y}
N 300 80 300 100 {
lab=#net2}
N 160 160 160 180 {
lab=VSS}
N 160 -100 160 -80 {
lab=#net3}
N 300 -100 300 -80 {
lab=#net4}
N 340 -130 350 -130 {
lab=B}
N 340 -50 350 -50 {
lab=A_b}
N 230 180 230 200 {
lab=VSS}
N 160 -130 170 -130 {
lab=VDD}
N 160 -50 170 -50 {
lab=VDD}
N 170 -130 170 -50 {
lab=VDD}
N 290 -50 300 -50 {
lab=VDD}
N 290 -130 290 -50 {
lab=VDD}
N 290 -130 300 -130 {
lab=VDD}
N 340 130 350 130 {
lab=B_b}
N 300 0 300 20 {
lab=Y}
N 300 -20 300 0 {
lab=Y}
N 160 0 300 0 {
lab=Y}
N 300 0 390 0 {
lab=Y}
N 290 50 300 50 {
lab=VSS}
N 290 130 300 130 {
lab=VSS}
N 160 50 170 50 {
lab=VSS}
N 160 130 170 130 {
lab=VSS}
N -80 -30 -70 -30 {
lab=B}
N -80 30 -70 30 {
lab=A}
N 110 -130 120 -130 {
lab=A}
N 110 -50 120 -50 {
lab=B_b}
N 110 50 120 50 {
lab=B}
N 110 130 120 130 {
lab=A}
N 340 50 350 50 {
lab=A_b}
N 300 160 300 180 {
lab=VSS}
N 160 180 300 180 {
lab=VSS}
N 170 50 170 130 {
lab=VSS}
N 170 130 170 180 {
lab=VSS}
N 290 50 290 130 {
lab=VSS}
N 290 130 290 180 {
lab=VSS}
N 300 -180 300 -160 {
lab=VDD}
N 160 -180 300 -180 {
lab=VDD}
N 160 -180 160 -160 {
lab=VDD}
N 230 -200 230 -180 {
lab=VDD}
N 170 -180 170 -130 {
lab=VDD}
N 290 -180 290 -130 {
lab=VDD}
N 10 -30 20 -30 {
lab=B_b}
N 10 30 20 30 {
lab=A_b}
C {devices/lab_pin.sym} 350 -130 0 1 {name=l8 sig_type=std_logic lab=B}
C {devices/lab_pin.sym} 230 -200 0 1 {name=l3 lab=VDD}
C {devices/lab_pin.sym} 230 200 0 1 {name=l4 lab=VSS}
C {INVX1.sym} -30 30 0 0 {name=x1 VDD=VDD VSS=VSS}
C {INVX1.sym} -30 -30 0 0 {name=x2 VDD=VDD VSS=VSS}
C {sky130_fd_pr/pfet_01v8.sym} 140 -130 0 0 {name=M1
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
C {sky130_fd_pr/pfet_01v8.sym} 140 -50 0 0 {name=M2
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
C {sky130_fd_pr/pfet_01v8.sym} 320 -130 0 1 {name=M3
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
C {sky130_fd_pr/pfet_01v8.sym} 320 -50 0 1 {name=M4
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
C {devices/opin.sym} 390 0 0 0 {name=p1 lab=Y}
C {sky130_fd_pr/nfet_01v8.sym} 140 50 0 0 {name=M5
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
C {sky130_fd_pr/nfet_01v8.sym} 140 130 0 0 {name=M6
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
C {sky130_fd_pr/nfet_01v8.sym} 320 50 0 1 {name=M7
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
C {sky130_fd_pr/nfet_01v8.sym} 320 130 0 1 {name=M8
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
C {devices/lab_pin.sym} 110 130 0 0 {name=l2 sig_type=std_logic lab=A}
C {devices/lab_pin.sym} 110 -130 0 0 {name=l5 sig_type=std_logic lab=A}
C {devices/ipin.sym} -80 30 0 0 {name=p2 lab=A}
C {devices/ipin.sym} -80 -30 0 0 {name=p3 lab=B}
C {devices/lab_pin.sym} 20 -30 0 1 {name=l6 sig_type=std_logic lab=B_b}
C {devices/lab_pin.sym} 20 30 0 1 {name=l7 sig_type=std_logic lab=A_b}
C {devices/lab_pin.sym} 350 130 0 1 {name=l10 sig_type=std_logic lab=B_b}
C {devices/lab_pin.sym} 350 -50 0 1 {name=l11 sig_type=std_logic lab=A_b}
C {devices/lab_pin.sym} 350 50 0 1 {name=l12 sig_type=std_logic lab=A_b}
C {devices/lab_pin.sym} 110 50 0 0 {name=l9 sig_type=std_logic lab=B}
C {devices/lab_pin.sym} 110 -50 0 0 {name=l1 sig_type=std_logic lab=B_b}
