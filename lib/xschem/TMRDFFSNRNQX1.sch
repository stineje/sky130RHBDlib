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
N 40 -20 80 -20 {
lab=#net3}
N 200 0 230 0 {
lab=Q}
N -70 260 -60 260 {
lab=RN}
N -60 250 -60 260 {
lab=RN}
N -60 120 -50 120 {
lab=SN}
N -60 120 -60 130 {
lab=SN}
N -70 90 -60 90 {
lab=RN}
N -60 80 -60 90 {
lab=RN}
N -60 -50 -50 -50 {
lab=SN}
N -60 -50 -60 -40 {
lab=SN}
N -70 -80 -60 -80 {
lab=RN}
N -60 -90 -60 -80 {
lab=RN}
N -60 -220 -50 -220 {
lab=SN}
N -60 -220 -60 -210 {
lab=SN}
N 40 20 40 170 {
lab=#net1}
N 0 170 40 170 {
lab=#net1}
N 40 -170 40 -20 {
lab=#net3}
N 0 -170 40 -170 {
lab=#net3}
C {DFFSNRNQX1.sym} -60 -150 0 0 {name=x1 VDD=VDD VSS=VSS}
C {DFFSNRNQX1.sym} -60 20 0 0 {name=x2 VDD=VDD VSS=VSS}
C {DFFSNRNQX1.sym} -60 190 0 0 {name=x3 VDD=VDD VSS=VSS}
C {devices/lab_pin.sym} -50 -220 0 1 {name=l1 sig_type=std_logic lab=SN}
C {devices/lab_pin.sym} -50 -50 0 1 {name=l2 sig_type=std_logic lab=SN}
C {devices/lab_pin.sym} -50 120 0 1 {name=l3 sig_type=std_logic lab=SN}
C {devices/lab_pin.sym} -70 90 0 0 {name=l4 sig_type=std_logic lab=RN}
C {devices/lab_pin.sym} -70 -80 0 0 {name=l5 sig_type=std_logic lab=RN}
C {devices/lab_pin.sym} -70 260 0 0 {name=l6 sig_type=std_logic lab=RN}
C {devices/lab_pin.sym} -120 -170 0 0 {name=l7 sig_type=std_logic lab=D}
C {devices/lab_pin.sym} -120 0 0 0 {name=l8 sig_type=std_logic lab=D}
C {devices/lab_pin.sym} -120 170 0 0 {name=l9 sig_type=std_logic lab=D}
C {devices/lab_pin.sym} -120 -130 0 0 {name=l10 sig_type=std_logic lab=CLK}
C {devices/lab_pin.sym} -120 40 0 0 {name=l11 sig_type=std_logic lab=CLK}
C {devices/lab_pin.sym} -120 210 0 0 {name=l12 sig_type=std_logic lab=CLK}
C {VOTER3X1.sym} 140 0 0 0 {name=x4 VDD=VDD VSS=VSS}
C {devices/opin.sym} 230 0 0 0 {name=p1 lab=Q}
C {devices/ipin.sym} -220 -170 0 0 {name=p2 lab=D}
C {devices/ipin.sym} -220 -140 0 0 {name=p3 lab=CLK}
C {devices/ipin.sym} -220 -110 0 0 {name=p4 lab=SN}
C {devices/ipin.sym} -220 -80 0 0 {name=p5 lab=RN}
