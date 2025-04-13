v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 20 -40 40 -40 {
lab=Q}
N 20 -40 20 -20 {
lab=Q}
N 20 -20 160 40 {
lab=Q}
N 160 40 160 60 {
lab=Q}
N 20 40 40 40 {
lab=QN}
N 20 20 20 40 {
lab=QN}
N 20 20 160 -40 {
lab=QN}
N 160 -60 160 -40 {
lab=QN}
N 160 60 180 60 {
lab=Q}
N 160 -60 180 -60 {
lab=QN}
N -100 -60 -80 -60 {
lab=E}
N -100 -60 -100 60 {
lab=E}
N -100 60 -80 60 {
lab=E}
C {devices/ipin.sym} -80 -100 0 0 {name=p1 lab=S}
C {devices/ipin.sym} -80 100 0 0 {name=p2 lab=R}
C {devices/opin.sym} 180 -60 0 0 {name=p3 lab=QN}
C {devices/opin.sym} 180 60 0 0 {name=p4 lab=Q}
C {devices/ipin.sym} -100 0 0 0 {name=p5 lab=E}
C {AND2X1.sym} -20 -80 0 0 {name=x1 VDD=VDD VSS=VSS}
C {AND2X1.sym} -20 80 0 0 {name=x2 VDD=VDD VSS=VSS}
C {NOR2X1.sym} 100 -60 0 0 {name=x3 VDD=VDD VSS=VSS}
C {NOR2X1.sym} 100 60 0 0 {name=x4 VDD=VDD VSS=VSS}
