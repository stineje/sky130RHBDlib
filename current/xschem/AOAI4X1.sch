v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 360 0 380 0 {
lab=YN}
N 80 -40 100 -40 {
lab=#net1}
N 220 -20 240 -20 {
lab=#net2}
C {devices/opin.sym} 380 0 0 0 {name=p1 lab=YN}
C {devices/ipin.sym} -130 -60 0 0 {name=p2 lab=A}
C {devices/ipin.sym} -130 -30 0 0 {name=p3 lab=B}
C {devices/ipin.sym} -130 0 0 0 {name=p4 lab=C}
C {devices/ipin.sym} -130 30 0 0 {name=p5 lab=D}
C {devices/lab_pin.sym} -40 -60 0 0 {name=l1 sig_type=std_logic lab=A}
C {devices/lab_pin.sym} -40 -20 0 0 {name=l2 sig_type=std_logic lab=B}
C {devices/lab_pin.sym} 100 0 0 0 {name=l3 sig_type=std_logic lab=C}
C {devices/lab_pin.sym} 240 20 0 0 {name=l4 sig_type=std_logic lab=D}
C {NAND2X1.sym} 20 -40 0 0 {name=x1 VDD=VDD VSS=VSS}
C {NOR2X1.sym} 160 -20 0 0 {name=x2 VDD=VDD VSS=VSS}
C {NAND2X1.sym} 300 0 0 0 {name=x3 VDD=VDD VSS=VSS}
