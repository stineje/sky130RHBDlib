v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 90 -170 90 -140 {
lab=#net1}
N 90 -80 90 -50 {
lab=#net2}
N -30 -80 -30 -70 {
lab=#net1}
N -30 -80 90 -140 {
lab=#net1}
N -30 -150 -30 -140 {
lab=#net2}
N -30 -140 90 -80 {
lab=#net2}
N -30 140 -30 150 {
lab=#net3}
N -30 140 90 90 {
lab=#net3}
N 90 60 90 90 {
lab=#net3}
N -30 80 -30 90 {
lab=#net4}
N -30 90 90 140 {
lab=#net4}
N 90 140 90 170 {
lab=#net4}
N -30 30 -30 40 {
lab=#net1}
N -30 30 120 -20 {
lab=#net1}
N 120 -170 120 -20 {
lab=#net1}
N 90 -170 120 -170 {
lab=#net1}
N 90 170 120 170 {
lab=#net4}
N 120 30 120 170 {
lab=#net4}
N -30 -20 120 30 {
lab=#net4}
N -30 -30 -30 -20 {
lab=#net4}
N 90 -50 190 -50 {
lab=#net2}
N 310 60 310 90 {
lab=#net5}
N 190 0 310 60 {
lab=#net5}
N 190 -10 190 0 {
lab=#net5}
N 190 60 190 70 {
lab=QN}
N 190 60 310 0 {
lab=QN}
N 310 -30 310 0 {
lab=QN}
N 120 110 190 110 {
lab=#net4}
N 310 -30 330 -30 {
lab=QN}
C {NAND3X1.sym} 30 60 0 0 {name=x1 VDD=VDD VSS=VSS}
C {NAND2X1.sym} 30 170 0 0 {name=x2 VDD=VDD VSS=VSS}
C {NAND3X1.sym} 30 -50 0 0 {name=x3 VDD=VDD VSS=VSS}
C {NAND2X1.sym} 30 -170 0 0 {name=x4 VDD=VDD VSS=VSS}
C {NAND2X1.sym} 250 -30 0 0 {name=x5 VDD=VDD VSS=VSS}
C {NAND3X1.sym} 250 90 0 0 {name=x6 VDD=VDD VSS=VSS}
C {devices/lab_pin.sym} -30 -190 0 0 {name=l1 sig_type=std_logic lab=D}
C {devices/lab_pin.sym} -30 -50 0 0 {name=l2 sig_type=std_logic lab=CLK}
C {devices/lab_pin.sym} -30 60 0 0 {name=l3 sig_type=std_logic lab=SN}
C {devices/lab_pin.sym} -30 190 0 0 {name=l4 sig_type=std_logic lab=CLK}
C {devices/lab_pin.sym} 190 90 0 0 {name=l5 sig_type=std_logic lab=SN}
C {devices/opin.sym} 330 -30 0 0 {name=p1 lab=QN}
C {devices/ipin.sym} -90 -30 0 0 {name=p2 lab=D}
C {devices/ipin.sym} -90 0 0 0 {name=p3 lab=CLK}
C {devices/ipin.sym} -90 30 0 0 {name=p4 lab=SN}
