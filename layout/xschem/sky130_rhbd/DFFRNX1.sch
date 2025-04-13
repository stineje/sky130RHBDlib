v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N -30 -80 -30 -70 {
lab=#net1}
N -30 -80 90 -140 {
lab=#net1}
N -30 140 -30 150 {
lab=#net2}
N -30 140 90 90 {
lab=#net2}
N 90 60 90 90 {
lab=#net2}
N -30 80 -30 90 {
lab=#net3}
N -30 90 90 140 {
lab=#net3}
N 90 140 90 170 {
lab=#net3}
N 90 -170 90 -140 {
lab=#net1}
N 90 -80 90 -50 {
lab=#net4}
N -30 -140 90 -80 {
lab=#net4}
N -30 -150 -30 -140 {
lab=#net4}
N -30 30 -30 40 {
lab=#net4}
N -30 30 90 -20 {
lab=#net4}
N 90 -50 90 -20 {
lab=#net4}
N 90 -170 190 -170 {
lab=#net1}
N 90 170 190 170 {
lab=#net3}
N 190 20 190 130 {
lab=QN}
N 190 20 310 -20 {
lab=QN}
N 310 -150 310 -20 {
lab=QN}
N 310 20 310 150 {
lab=Q}
N 190 -20 310 20 {
lab=Q}
N 190 -130 190 -20 {
lab=Q}
N 310 -150 340 -150 {
lab=QN}
N 310 150 340 150 {
lab=Q}
N -80 -190 -30 -190 {
lab=#net3}
N -80 -190 -80 80 {
lab=#net3}
N -80 80 -30 80 {
lab=#net3}
C {NAND3X1.sym} 30 -50 0 0 {name=x2 VDD=VDD VSS=VSS}
C {devices/lab_pin.sym} -30 -170 0 0 {name=l2 sig_type=std_logic lab=CLK}
C {devices/lab_pin.sym} -30 190 0 0 {name=p6 lab=RN}
C {devices/lab_pin.sym} -30 170 0 0 {name=l4 sig_type=std_logic lab=CLK}
C {devices/lab_pin.sym} 190 -150 0 0 {name=p7 lab=RN}
C {NAND3X1.sym} 30 -170 0 0 {name=x1 VDD=VDD VSS=VSS}
C {devices/lab_pin.sym} -30 -30 0 0 {name=p8 lab=RN}
C {devices/lab_pin.sym} -30 -50 0 0 {name=l3 sig_type=std_logic lab=D}
C {NAND2X1.sym} 30 60 0 0 {name=x3 VDD=VDD VSS=VSS}
C {NAND3X1.sym} 30 170 0 0 {name=x4 VDD=VDD VSS=VSS}
C {NAND3X1.sym} 250 -150 0 0 {name=x5 VDD=VDD VSS=VSS}
C {NAND2X1.sym} 250 150 0 0 {name=x6 VDD=VDD VSS=VSS}
C {devices/opin.sym} 340 150 0 0 {name=p1 lab=Q}
C {devices/opin.sym} 340 -150 0 0 {name=p2 lab=QN}
C {devices/ipin.sym} -150 -170 0 0 {name=p3 lab=D}
C {devices/ipin.sym} -150 -140 0 0 {name=p4 lab=CLK}
C {devices/ipin.sym} -150 -110 0 0 {name=p5 lab=RN}
