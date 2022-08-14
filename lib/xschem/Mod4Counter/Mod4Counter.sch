v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N -100 20 -60 20 {
lab=Y[0]}
N -100 -80 -100 20 {
lab=Y[0]}
N -100 -80 60 -80 {
lab=Y[0]}
N 60 -80 60 -20 {
lab=Y[0]}
N 60 20 120 20 {
lab=#net1}
N 120 -80 120 -20 {
lab=Y[1]}
N 120 -80 240 -80 {
lab=Y[1]}
N 240 -80 240 -20 {
lab=Y[1]}
N 240 -120 240 -80 {
lab=Y[1]}
N 240 -120 250 -120 {
lab=Y[1]}
N 60 -100 60 -80 {
lab=Y[0]}
N 60 -110 60 -100 {
lab=Y[0]}
N 60 -110 70 -110 {
lab=Y[0]}
C {DFFX1.sym} 0 0 2 1 {name=x1 VDD=VDD VSS=VSS}
C {DFFQNX1.sym} 180 0 0 0 {name=x2 VDD=VDD VSS=VSS}
C {devices/lab_pin.sym} -60 -20 0 0 {name=l1 sig_type=std_logic lab=CLK}
C {devices/opin.sym} 290 -170 0 0 {name=p2 lab=Y[1:0]}
C {devices/ipin.sym} -40 -110 0 0 {name=p3 lab=CLK}
C {devices/lab_pin.sym} 70 -110 0 1 {name=l2 sig_type=std_logic lab=Y[0]}
C {devices/lab_pin.sym} 250 -120 0 1 {name=l3 sig_type=std_logic lab=Y[1]}
