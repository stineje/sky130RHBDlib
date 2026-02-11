v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 40 20 80 20 {
lab=#net1}
N 0 0 80 0 {
lab=#net2}
N 40 20 40 130 {
lab=#net1}
N 0 130 40 130 {
lab=#net1}
N 0 -130 40 -130 {
lab=#net3}
N 40 -130 40 -20 {
lab=#net3}
N 40 -20 80 -20 {
lab=#net3}
N 200 0 230 0 {
lab=Q}
C {DFFQX1.sym} -60 -110 0 0 {name=x1 VDD=VDD VSS=VSS}
C {DFFQX1.sym} -60 20 0 0 {name=x2 VDD=VDD VSS=VSS}
C {DFFQX1.sym} -60 150 0 0 {name=x3 VDD=VDD VSS=VSS}
C {VOTER3X1.sym} 140 0 0 0 {name=x4 VDD=VDD VSS=VSS}
C {devices/opin.sym} 230 0 0 0 {name=p1 lab=Q}
C {devices/ipin.sym} -160 -20 0 0 {name=p2 lab=D}
C {devices/ipin.sym} -160 0 0 0 {name=p3 lab=CLK}
C {devices/lab_pin.sym} -120 -130 0 0 {name=l1 sig_type=std_logic lab=D}
C {devices/lab_pin.sym} -120 -90 0 0 {name=l4 sig_type=std_logic lab=CLK}
C {devices/lab_pin.sym} -120 40 0 0 {name=l5 sig_type=std_logic lab=CLK}
C {devices/lab_pin.sym} -120 170 0 0 {name=l6 sig_type=std_logic lab=CLK}
C {devices/lab_pin.sym} -120 0 0 0 {name=l2 sig_type=std_logic lab=D}
C {devices/lab_pin.sym} -120 130 0 0 {name=l3 sig_type=std_logic lab=D}
