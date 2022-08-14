v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N -60 -100 -60 -60 {
lab=#net1}
N -180 -140 -60 -100 {
lab=#net1}
N -180 -160 -180 -140 {
lab=#net1}
N -180 -100 -180 -80 {
lab=#net2}
N -180 -100 -60 -140 {
lab=#net2}
N -60 -180 -60 -140 {
lab=#net2}
N -60 140 -60 180 {
lab=#net3}
N -180 100 -60 140 {
lab=#net3}
N -180 80 -180 100 {
lab=#net3}
N -180 140 -180 160 {
lab=#net4}
N -180 140 -60 100 {
lab=#net4}
N -60 60 -60 100 {
lab=#net4}
N -60 -60 -60 -20 {
lab=#net1}
N -180 20 -60 -20 {
lab=#net1}
N -180 20 -180 40 {
lab=#net1}
N -200 -200 -180 -200 {
lab=#net3}
N 0 40 0 140 {
lab=#net5}
N 0 20 0 40 {
lab=#net5}
N 120 20 120 160 {
lab=Q}
N 0 20 120 -20 {
lab=#net5}
N 120 -160 120 -20 {
lab=#net5}
N 0 -20 120 20 {
lab=Q}
N 0 -140 0 -20 {
lab=Q}
N -200 200 -180 200 {
lab=CLK}
N -200 -180 -180 -180 {
lab=CLK}
N -200 -40 -180 -40 {
lab=D}
N -240 -200 -200 -200 {
lab=#net3}
N -240 -200 -240 80 {
lab=#net3}
N -240 80 -180 80 {
lab=#net3}
N -60 180 -0 180 {
lab=#net3}
N 120 160 140 160 {
lab=Q}
N -60 -180 0 -180 {
lab=#net2}
C {devices/lab_pin.sym} -200 -180 0 0 {name=l1 sig_type=std_logic lab=CLK}
C {devices/lab_pin.sym} -200 -40 0 0 {name=l2 sig_type=std_logic lab=D}
C {devices/lab_pin.sym} -200 200 0 0 {name=l3 sig_type=std_logic lab=CLK}
C {NAND3X1.sym} -120 -180 0 0 {name=x1 VDD=VDD VSS=VSS}
C {NAND2X1.sym} -120 -60 0 0 {name=x2 VDD=VDD VSS=VSS}
C {NAND2X1.sym} -120 60 0 0 {name=x3 VDD=VDD VSS=VSS}
C {NAND2X1.sym} -120 180 0 0 {name=x4 VDD=VDD VSS=VSS}
C {NAND2X1.sym} 60 -160 0 0 {name=x5 VDD=VDD VSS=VSS}
C {NAND2X1.sym} 60 160 0 0 {name=x6 VDD=VDD VSS=VSS}
C {devices/opin.sym} 140 160 0 0 {name=p1 lab=Q}
C {devices/ipin.sym} -310 -90 0 0 {name=p2 lab=D}
C {devices/ipin.sym} -310 -50 0 0 {name=p3 lab=CLK}
