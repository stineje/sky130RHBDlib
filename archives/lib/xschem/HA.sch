v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 120 -40 140 -40 {
lab=SUM}
N 120 40 140 40 {
lab=COUT}
N -20 -60 -20 20 {
lab=#net1}
N -20 20 -0 20 {
lab=#net1}
N -40 -20 -40 60 {
lab=#net2}
N -40 60 0 60 {
lab=#net2}
N -60 -60 0 -60 {
lab=#net1}
N -60 -20 -0 -20 {
lab=#net2}
C {XOR2X1.sym} 60 -40 0 0 {name=x1 VDD=VDD VSS=VSS}
C {AND2X1.sym} 60 40 0 0 {name=x2 VDD=VDD VSS=VSS}
C {devices/opin.sym} 140 -40 0 0 {name=p1 lab=SUM}
C {devices/opin.sym} 140 40 0 0 {name=p2 lab=COUT}
C {devices/ipin.sym} -60 -60 0 0 {name=p3 lab=A}
C {devices/ipin.sym} -60 -20 0 0 {name=p4 lab=B}
