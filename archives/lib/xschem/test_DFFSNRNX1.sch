v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 60 -100 60 -60 {
lab=D}
N 60 -100 120 -100 {
lab=D}
N 60 -220 60 -190 { lab=CLK}
N 60 -220 130 -220 { lab=CLK}
N 190 50 190 90 {
lab=SN}
N 190 50 250 50 {
lab=SN}
N 230 -80 230 -40 {
lab=RN}
N 230 -80 290 -80 {
lab=RN}
C {devices/vsource.sym} 60 -30 0 0 {name=V2 value="pwl 0n 0 19.9n 0 20n 1.8"}
C {devices/lab_pin.sym} 120 -100 0 1 {name=l18 sig_type=std_logic lab=D}
C {devices/vsource.sym} 0 -30 0 0 {name=V1 value=1.8
		}
C {devices/vdd.sym} 0 -60 0 0 {name=l19 lab=VDD}
C {devices/gnd.sym} 60 0 0 0 {name=l20 lab=GND}
C {devices/gnd.sym} 0 0 0 0 {name=l21 lab=GND}
C {devices/code_shown.sym} -170 0 0 0 {name=NGSPICE
only_toplevel=true
place=end
value="
.tran 0.01n 45n
.save all
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
C {devices/lab_pin.sym} 10 80 0 0 {name=l1 sig_type=std_logic lab=D}
C {devices/lab_pin.sym} 10 120 0 0 {name=l2 sig_type=std_logic lab=CLK}
C {devices/lab_pin.sym} 130 80 0 1 {name=l3 sig_type=std_logic lab=Q}
C {devices/lab_pin.sym} 130 120 0 1 {name=l4 sig_type=std_logic lab=QN}
C {devices/lab_pin.sym} 250 50 0 1 {name=l5 sig_type=std_logic lab=SN}
C {devices/gnd.sym} 190 150 0 0 {name=l6 lab=GND}
C {devices/vsource.sym} 190 120 0 0 {name=V4 value="pwl 0n 1.8 6n 1.8 6.1 0 9.8n 0 9.9n 1.8"}
C {devices/lab_pin.sym} 70 40 0 0 {name=l7 sig_type=std_logic lab=SN}
C {devices/lab_pin.sym} 290 -80 0 1 {name=l8 sig_type=std_logic lab=RN}
C {devices/gnd.sym} 230 20 0 0 {name=l9 lab=GND}
C {devices/vsource.sym} 230 -10 0 0 {name=V5 value="pwl 0n 1.8 23n 1.8 23.1n 0 26n 0 26.1n 1.8"}
C {DFFSNRNX1.sym} 70 100 0 0 {name=x1 VDD=VDD VSS=GND}
C {devices/lab_pin.sym} 70 160 0 1 {name=l10 sig_type=std_logic lab=RN}
