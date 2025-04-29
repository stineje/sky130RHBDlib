v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 80 -60 140 -60 {
lab=B}
N 80 -170 140 -170 {
lab=D}
N 80 -170 80 -150 {
lab=D}
N 80 -60 80 -40 {
lab=B}
N 270 -170 330 -170 {
lab=C}
N 270 -170 270 -150 {
lab=C}
N 270 -60 330 -60 {
lab=A}
N 270 -60 270 -40 {
lab=A}
N 30 80 40 80 {
lab=A}
N 30 160 40 160 {
lab=C}
N 30 200 40 200 {
lab=D}
N 30 120 40 120 {
lab=B}
N 300 140 310 140 {
lab=Y}
C {devices/lab_pin.sym} 30 80 0 0 {name=l8 sig_type=std_logic lab=A}
C {devices/code_shown.sym} -120 50 0 0 {name=NGSPICE
only_toplevel=true
place=end
value="
.tran 0.01n 90n
.save all
"}
C {devices/code.sym} -130 -110 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
.lib $::SKYWATER_MODELS/sky130.lib.spice tt

"}
C {devices/vsource.sym} 80 -10 0 0 {name=V2 value="pulse 0 1.8 0 1p 1p 4ns 8ns"  
		}
C {devices/lab_pin.sym} 140 -60 0 1 {name=l6 sig_type=std_logic lab=B}
C {devices/vsource.sym} 20 -10 0 0 {name=V1 value=1.8
		}
C {devices/vdd.sym} 20 -40 0 0 {name=l1 lab=VDD}
C {devices/gnd.sym} 80 20 0 0 {name=l2 lab=GND}
C {devices/gnd.sym} 20 20 0 0 {name=l3 lab=GND}
C {devices/vsource.sym} 80 -120 0 0 {name=V3 value="pulse 0 1.8 0 1p 1p 16ns 32ns"  
		}
C {devices/lab_pin.sym} 140 -170 0 1 {name=l5 sig_type=std_logic lab=D}
C {devices/gnd.sym} 80 -90 0 0 {name=l7 lab=GND}
C {devices/lab_pin.sym} 30 120 0 0 {name=l9 sig_type=std_logic lab=B}
C {devices/vsource.sym} 270 -120 0 0 {name=V4 value="pulse 0 1.8 0 1p 1p 8ns 16ns"
		}
C {devices/lab_pin.sym} 330 -170 0 1 {name=l10 sig_type=std_logic lab=C}
C {devices/gnd.sym} 270 -90 0 0 {name=l11 lab=GND}
C {devices/lab_pin.sym} 30 160 0 0 {name=l12 sig_type=std_logic lab=C}
C {devices/vsource.sym} 270 -10 0 0 {name=V5 value="pulse 0 1.8 0 1p 1p 2ns 4ns"
		}
C {devices/lab_pin.sym} 330 -60 0 1 {name=l13 sig_type=std_logic lab=A}
C {devices/gnd.sym} 270 20 0 0 {name=l14 lab=GND}
C {devices/lab_pin.sym} 30 200 0 0 {name=l15 sig_type=std_logic lab=D}
C {devices/lab_pin.sym} 310 140 0 1 {name=l4 sig_type=std_logic lab=Y}
C {AOAI4X1.sym} 130 140 0 0 {name=x1 VDD=VDD VSS=GND}
