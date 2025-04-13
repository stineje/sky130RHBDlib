v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 0 130 40 130 {
lab=#net1}
N 200 0 230 0 {
lab=QN}
N -60 80 -60 90 {
lab=SN}
N -60 80 -50 80 {
lab=SN}
N -60 -50 -60 -40 {
lab=SN}
N -60 -50 -50 -50 {
lab=SN}
N -60 -180 -60 -170 {
lab=SN}
N -60 -180 -50 -180 {
lab=SN}
N 0 -130 20 -130 {}
N 40 20 40 130 {}
N 40 20 80 20 {}
N 0 0 80 0 {}
N 20 -130 20 -20 {}
N 20 -20 80 -20 {}
C {VOTERN3X1.sym} 140 0 0 0 {name=x4 VDD=VDD VSS=VSS}
C {DFFSNQX1.sym} -60 -110 0 0 {name=x1 VDD=VDD VSS=VSS}
C {DFFSNQX1.sym} -60 20 0 0 {name=x2 VDD=VDD VSS=VSS}
C {DFFSNQX1.sym} -60 150 0 0 {name=x3 VDD=VDD VSS=VSS}
C {devices/opin.sym} 230 0 0 0 {name=p1 lab=QN}
C {devices/ipin.sym} -180 -30 0 0 {name=p2 lab=D}
C {devices/ipin.sym} -180 0 0 0 {name=p3 lab=CLK}
C {devices/ipin.sym} -180 30 0 0 {name=p4 lab=SN}
C {devices/lab_pin.sym} -50 -180 0 1 {name=l1 sig_type=std_logic lab=SN}
C {devices/lab_pin.sym} -50 -50 0 1 {name=l2 sig_type=std_logic lab=SN}
C {devices/lab_pin.sym} -50 80 0 1 {name=l3 sig_type=std_logic lab=SN}
C {devices/lab_pin.sym} -120 -130 0 0 {name=l4 sig_type=std_logic lab=D}
C {devices/lab_pin.sym} -120 -90 0 0 {name=l7 sig_type=std_logic lab=CLK}
C {devices/lab_pin.sym} -120 40 0 0 {name=l8 sig_type=std_logic lab=CLK}
C {devices/lab_pin.sym} -120 170 0 0 {name=l9 sig_type=std_logic lab=CLK}
C {devices/lab_pin.sym} -120 0 0 0 {name=l5 sig_type=std_logic lab=D}
C {devices/lab_pin.sym} -120 130 0 0 {name=l6 sig_type=std_logic lab=D}
