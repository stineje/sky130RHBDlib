v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 60 -130 60 -100 { lab=CLK}
N 240 -210 240 -180 { lab=D0}
N 60 -130 80 -130 {
lab=CLK}
N 240 -210 260 -210 {
lab=D0}
N 240 -90 240 -60 { lab=D1}
N 240 -90 260 -90 {
lab=D1}
N 240 30 240 60 { lab=D2}
N 240 30 260 30 {
lab=D2}
N 150 130 150 160 { lab=SN}
N 150 130 170 130 {
lab=SN}
N 70 10 70 20 {
lab=SN}
N 70 10 80 10 {
lab=SN}
C {devices/lab_pin.sym} 260 -210 0 1 {name=l18 sig_type=std_logic lab=D0}
C {devices/vsource.sym} 0 -70 0 0 {name=V1 value=1.8
		}
C {devices/vdd.sym} 0 -100 0 0 {name=l19 lab=VDD}
C {devices/gnd.sym} 240 -120 0 0 {name=l20 lab=GND}
C {devices/gnd.sym} 0 -40 0 0 {name=l21 lab=GND}
C {devices/code_shown.sym} -170 0 0 0 {name=NGSPICE
only_toplevel=true
place=end
value="
.tran 0.1n 170n
.save all
"}
C {devices/code.sym} -180 -160 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
.lib $::SKYWATER_MODELS/sky130.lib.spice tt

"}
C {devices/vsource.sym} 60 -70 0 0 {name=V3 value="pulse 0 1.8 0 1p 1p 5n 10n"}
C {devices/gnd.sym} 60 -40 0 0 {name=l22 lab=GND}
C {devices/lab_pin.sym} 80 -130 0 1 {name=l23 sig_type=std_logic lab=CLK}
C {devices/lab_pin.sym} 10 50 0 0 {name=l1 sig_type=std_logic lab=D0}
C {devices/lab_pin.sym} 10 100 0 0 {name=l2 sig_type=std_logic lab=CLK}
C {devices/lab_pin.sym} 130 60 0 1 {name=l3 sig_type=std_logic lab=QN}
C {devices/vsource.sym} 240 -150 0 0 {name=V4 value="pulse 0 1.8 5n 1p 1p 10n 20n"}
C {devices/lab_pin.sym} 260 -90 0 1 {name=l5 sig_type=std_logic lab=D1}
C {devices/gnd.sym} 240 0 0 0 {name=l6 lab=GND}
C {devices/vsource.sym} 240 -30 0 0 {name=V2 value="pulse 0 1.8 5n 1p 1p 20n 40n"}
C {devices/lab_pin.sym} 260 30 0 1 {name=l7 sig_type=std_logic lab=D2}
C {devices/gnd.sym} 240 120 0 0 {name=l8 lab=GND}
C {devices/vsource.sym} 240 90 0 0 {name=V5 value="pulse 0 1.8 5n 1p 1p 40n 80n"}
C {devices/lab_pin.sym} 10 60 0 0 {name=l9 sig_type=std_logic lab=D1}
C {devices/lab_pin.sym} 10 70 0 0 {name=l10 sig_type=std_logic lab=D2}
C {devices/gnd.sym} 150 220 0 0 {name=l4 lab=GND}
C {devices/vsource.sym} 150 190 0 0 {name=V6 value="pwl 0n 1.8 82n 1.8 82.1n 0"}
C {devices/lab_pin.sym} 170 130 0 1 {name=l11 sig_type=std_logic lab=SN}
C {devices/lab_pin.sym} 80 10 0 1 {name=l12 sig_type=std_logic lab=SN}
C {TMRDFFSNQNX1.sym} 70 80 0 0 {name=x1 VDD=VDD VSS=GND}
