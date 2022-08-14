v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N -40 40 0 40 {
lab=GATE}
N -40 -120 -40 40 {
lab=GATE}
N -40 -120 -0 -120 {
lab=GATE}
N -160 -160 -160 -80 {
lab=#net1}
N -120 -160 -0 -160 {
lab=#net1}
N -120 80 -0 80 {
lab=D}
N -160 0 -160 80 {
lab=D}
N -180 80 -160 80 {
lab=D}
N -60 -40 -40 -40 {
lab=GATE}
N 120 -140 180 -140 {
lab=#net2}
N 120 60 180 60 {
lab=#net3}
N 300 0 300 40 {
lab=#net4}
N 180 -80 300 0 {
lab=#net4}
N 180 -100 180 -80 {
lab=#net4}
N 180 0 180 20 {
lab=Q}
N 180 0 300 -80 {
lab=Q}
N 300 -120 300 -80 {
lab=Q}
N 300 -120 360 -120 {
lab=Q}
N -160 -160 -120 -160 {}
N -160 80 -120 80 {}
C {INVX1.sym} -160 -40 3 0 {name=x1 VDD=VDD VSS=VSS}
C {AND2X1.sym} 60 -140 0 0 {name=x2 VDD=VDD VSS=VSS}
C {AND2X1.sym} 60 60 0 0 {name=x3 VDD=VDD VSS=VSS}
C {NOR2X1.sym} 240 -120 0 0 {name=x4 VDD=VDD VSS=VSS}
C {NOR2X1.sym} 240 40 0 0 {name=x5 VDD=VDD VSS=VSS}
C {devices/opin.sym} 360 -120 0 0 {name=p1 lab=Q}
C {devices/ipin.sym} -180 80 0 0 {name=p2 lab=D}
C {devices/ipin.sym} -60 -40 0 0 {name=p3 lab=GATE}
