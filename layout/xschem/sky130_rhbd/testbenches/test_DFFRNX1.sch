v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 60 -220 60 -190 { lab=CLK}
N 60 -220 130 -220 { lab=CLK}
N 60 -100 60 -60 {
lab=D}
N 60 -100 120 -100 {
lab=D}
N 230 -170 230 -130 {
lab=RN}
N 230 -170 290 -170 {
lab=RN}
N 130 60 150 60 {
lab=Q}
N 130 100 150 100 {
lab=QN}
C {devices/lab_pin.sym} 120 -100 0 1 {name=l18 sig_type=std_logic lab=D}
C {devices/vsource.sym} 0 -30 0 0 {name=V1 value=1.8
		}
C {devices/vdd.sym} 0 -60 0 0 {name=l19 lab=VDD}
C {devices/gnd.sym} 0 0 0 0 {name=l21 lab=GND}
C {devices/code_shown.sym} -170 0 0 0 {name=NGSPICE
only_toplevel=true
place=end
value="
.save all
.tran 0.01n 50n
"}
C {devices/code.sym} -180 -160 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
.lib $::SKYWATER_MODELS/sky130.lib.spice tt

"}
C {devices/vsource.sym} 60 -160 0 0 {name=V3 value="pulse 0 1.8 0 1p 1p 5n 10n"}
C {devices/gnd.sym} 60 -130 0 0 {name=l22 lab=GND}
C {devices/lab_pin.sym} 130 -220 0 1 {name=l23 sig_type=std_logic lab=CLK}
C {devices/lab_pin.sym} 10 60 0 0 {name=l1 sig_type=std_logic lab=D}
C {devices/lab_pin.sym} 10 100 0 0 {name=l2 sig_type=std_logic lab=CLK}
C {devices/lab_pin.sym} 150 60 0 1 {name=l3 sig_type=std_logic lab=Q}
C {devices/lab_pin.sym} 150 100 0 1 {name=l4 sig_type=std_logic lab=QN}
C {devices/lab_pin.sym} 290 -170 0 1 {name=l5 sig_type=std_logic lab=RN}
C {devices/lab_pin.sym} 70 140 0 1 {name=l7 sig_type=std_logic lab=RN}
C {DFFRNX1.sym} 70 80 0 0 {name=x1 VDD=VDD VSS=GND}
C {devices/vsource.sym} 60 -30 0 0 {name=V5 value="pwl 0n 0 6n 0 6.1n 1.8 16n 1.8 16.1n 0 22n 0 22.1n 1.8 32n 1.8 32.1n 0"}
C {devices/gnd.sym} 60 0 0 0 {name=l8 lab=GND}
C {devices/gnd.sym} 230 -70 0 0 {name=l9 lab=GND}
C {devices/vsource.sym} 230 -100 0 0 {name=V6 value="pwl 0n 1.8 33n 1.8 33.1n 0"}
