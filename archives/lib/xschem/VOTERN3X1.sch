v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 0 -20 -0 20 {
lab=#net1}
N 0 -100 0 -80 {
lab=VDD}
N 0 350 0 370 {
lab=#net2}
N 0 430 0 450 {
lab=VSS}
N 0 320 10 320 {
lab=VSS}
N 0 400 10 400 {
lab=VSS}
N -50 -50 -40 -50 {
lab=A}
N 200 -50 210 -50 {
lab=B}
N -50 320 -40 320 {
lab=A}
N -50 400 -40 400 {
lab=B}
N 0 80 0 120 {
lab=#net3}
N -50 50 -40 50 {
lab=B}
N -50 150 -40 150 {
lab=C}
N 250 80 250 120 {
lab=#net3}
N 200 50 210 50 {
lab=C}
N 200 150 210 150 {
lab=A}
N 250 -20 250 20 {
lab=#net1}
N 150 350 150 370 {
lab=#net4}
N 150 320 160 320 {
lab=VSS}
N 150 400 160 400 {
lab=VSS}
N 100 320 110 320 {
lab=C}
N 100 400 110 400 {
lab=B}
N 310 350 310 370 {
lab=#net5}
N 310 320 320 320 {
lab=VSS}
N 310 400 320 400 {
lab=VSS}
N 260 320 270 320 {
lab=A}
N 260 400 270 400 {
lab=C}
N 0 430 310 430 {
lab=VSS}
N 10 320 10 430 {
lab=VSS}
N 160 320 160 430 {
lab=VSS}
N 320 320 320 430 {
lab=VSS}
N 310 430 320 430 {
lab=VSS}
N 0 -90 250 -90 {
lab=VDD}
N 250 -90 250 -80 {
lab=VDD}
N -0 -0 250 0 {
lab=#net1}
N 0 100 250 100 {
lab=#net3}
N 0 200 250 200 {
lab=YN}
N 0 260 0 290 {
lab=YN}
N 0 260 310 260 {
lab=YN}
N 310 260 310 290 {
lab=YN}
N 150 260 150 290 {
lab=YN}
N -0 180 0 200 {
lab=YN}
N 250 180 250 200 {
lab=YN}
N 150 200 150 260 {
lab=YN}
N -0 150 10 150 {
lab=VDD}
N 10 50 10 150 {
lab=VDD}
N -0 50 10 50 {
lab=VDD}
N 10 -50 10 50 {
lab=VDD}
N -0 -50 10 -50 {
lab=VDD}
N 10 -90 10 -50 {
lab=VDD}
N 250 150 260 150 {
lab=VDD}
N 260 50 260 150 {
lab=VDD}
N 250 50 260 50 {
lab=VDD}
N 260 -50 260 50 {
lab=VDD}
N 250 -50 260 -50 {
lab=VDD}
N 260 -90 260 -50 {
lab=VDD}
N 250 -90 260 -90 {
lab=VDD}
N 150 230 350 230 {
lab=YN}
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
C {devices/lab_pin.sym} -50 320 0 0 {name=l1 sig_type=std_logic lab=A}
C {sky130_fd_pr/nfet_01v8.sym} -20 400 0 0 {name=M3
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
C {sky130_fd_pr/nfet_01v8.sym} -20 320 0 0 {name=M4
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
C {sky130_fd_pr/pfet_01v8.sym} 230 -50 0 0 {name=M1
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
C {devices/lab_pin.sym} -50 400 0 0 {name=l4 sig_type=std_logic lab=B}
C {devices/lab_pin.sym} -50 -50 0 0 {name=l6 sig_type=std_logic lab=A}
C {devices/lab_pin.sym} 200 -50 0 0 {name=l7 sig_type=std_logic lab=B}
C {devices/lab_pin.sym} 0 -100 0 0 {name=l2 lab=VDD}
C {devices/lab_pin.sym} 0 450 0 0 {name=l3 lab=VSS}
C {sky130_fd_pr/pfet_01v8.sym} -20 50 0 0 {name=M5
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
C {devices/lab_pin.sym} -50 50 0 0 {name=l9 sig_type=std_logic lab=B}
C {sky130_fd_pr/pfet_01v8.sym} -20 150 0 0 {name=M6
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
C {devices/lab_pin.sym} -50 150 0 0 {name=l10 sig_type=std_logic lab=C}
C {sky130_fd_pr/pfet_01v8.sym} 230 50 0 0 {name=M7
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
C {devices/lab_pin.sym} 200 50 0 0 {name=l11 sig_type=std_logic lab=C}
C {sky130_fd_pr/pfet_01v8.sym} 230 150 0 0 {name=M10
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
C {devices/lab_pin.sym} 200 150 0 0 {name=l12 sig_type=std_logic lab=A}
C {devices/lab_pin.sym} 100 320 0 0 {name=l8 sig_type=std_logic lab=C}
C {sky130_fd_pr/nfet_01v8.sym} 130 400 0 0 {name=M8
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
C {sky130_fd_pr/nfet_01v8.sym} 130 320 0 0 {name=M9
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
C {devices/lab_pin.sym} 100 400 0 0 {name=l13 sig_type=std_logic lab=B}
C {devices/lab_pin.sym} 260 320 0 0 {name=l14 sig_type=std_logic lab=A}
C {sky130_fd_pr/nfet_01v8.sym} 290 400 0 0 {name=M11
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
C {sky130_fd_pr/nfet_01v8.sym} 290 320 0 0 {name=M12
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
C {devices/lab_pin.sym} 260 400 0 0 {name=l15 sig_type=std_logic lab=C}
C {devices/opin.sym} 350 230 0 0 {name=p1 lab=YN}
C {devices/ipin.sym} -120 190 0 0 {name=p2 lab=A}
C {devices/ipin.sym} -120 220 0 0 {name=p3 lab=B}
C {devices/ipin.sym} -120 250 0 0 {name=p4 lab=C}
