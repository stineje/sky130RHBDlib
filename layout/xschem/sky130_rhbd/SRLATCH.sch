v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N -80 -20 -60 -20 {
lab=Q}
N -80 -20 -80 0 {
lab=Q}
N -80 0 60 60 {
lab=Q}
N 60 60 60 80 {
lab=Q}
N -80 60 -60 60 {
lab=QN}
N -80 40 -80 60 {
lab=QN}
N -80 40 60 -20 {
lab=QN}
N 60 -40 60 -20 {
lab=QN}
N 60 80 80 80 {
lab=Q}
N 60 -40 80 -40 {
lab=QN}
C {devices/ipin.sym} -60 -60 0 0 {name=p1 lab=S}
C {devices/ipin.sym} -60 100 0 0 {name=p2 lab=R}
C {devices/opin.sym} 80 -40 0 0 {name=p3 lab=QN}
C {devices/opin.sym} 80 80 0 0 {name=p4 lab=Q}
C {NOR2X1.sym} 0 -40 0 0 {name=x1 VDD=VDD VSS=VSS}
C {NOR2X1.sym} 0 80 0 0 {name=x2 VDD=VDD VSS=VSS}
