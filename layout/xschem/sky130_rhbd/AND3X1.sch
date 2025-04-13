v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N -240 -20 -230 -20 {
lab=#net1}
N -240 0 -230 0 {
lab=#net2}
N -240 20 -230 20 {
lab=#net3}
N -30 0 -20 0 {
lab=Y}
C {NAND3X1.sym} -170 0 0 0 {name=x1 VDD=VDD VSS=VSS}
C {INVX1.sym} -70 0 0 0 {name=x2 VDD=VDD VSS=VSS}
C {devices/opin.sym} -20 0 0 0 {name=p1 lab=Y}
C {devices/ipin.sym} -240 -20 0 0 {name=p2 lab=A}
C {devices/ipin.sym} -240 0 0 0 {name=p3 lab=B}
C {devices/ipin.sym} -240 20 0 0 {name=p4 lab=C}
