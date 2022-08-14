v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 80 -60 140 -60 {
lab=C}
N 80 -170 140 -170 {
lab=B}
N 80 -170 80 -150 {
lab=B}
N 80 -60 80 -40 {
lab=C}
N 80 -280 140 -280 {
lab=A}
N 80 -280 80 -260 {
lab=A}
C {devices/lab_pin.sym} 40 80 0 0 {name=l8 sig_type=std_logic lab=A}
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
C {devices/lab_pin.sym} 160 100 0 1 {name=l4 sig_type=std_logic lab=YN}
C {devices/vsource.sym} 80 -10 0 0 {name=V2 value="pulse 0 1.8 0 1p 1p 20ns 40ns"  
		}
C {devices/lab_pin.sym} 140 -60 0 1 {name=l6 sig_type=std_logic lab=C}
C {devices/vsource.sym} 20 -10 0 0 {name=V1 value=1.8
		}
C {devices/vdd.sym} 20 -40 0 0 {name=l1 lab=VDD}
C {devices/gnd.sym} 80 20 0 0 {name=l2 lab=GND}
C {devices/gnd.sym} 20 20 0 0 {name=l3 lab=GND}
C {devices/vsource.sym} 80 -120 0 0 {name=V3 value="pulse 0 1.8 0 1p 1p 10ns 20ns"  
		}
C {devices/lab_pin.sym} 140 -170 0 1 {name=l5 sig_type=std_logic lab=B}
C {devices/gnd.sym} 80 -90 0 0 {name=l7 lab=GND}
C {devices/lab_pin.sym} 40 100 0 0 {name=l9 sig_type=std_logic lab=B}
C {devices/vsource.sym} 80 -230 0 0 {name=V4 value="pulse 0 1.8 0 1p 1p 5ns 10ns"
		}
C {devices/lab_pin.sym} 140 -280 0 1 {name=l10 sig_type=std_logic lab=A}
C {devices/gnd.sym} 80 -200 0 0 {name=l11 lab=GND}
C {devices/lab_pin.sym} 40 120 0 0 {name=l12 sig_type=std_logic lab=C}
C {VOTERN3X1.sym} 100 100 0 0 {name=x1 VDD=VDD VSS=GND}
