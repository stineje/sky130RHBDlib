v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 80 -60 140 -60 {
lab=B}
N 80 -190 140 -190 {
lab=A}
N 80 -190 80 -170 {
lab=A}
N 80 -60 80 -40 {
lab=B}
C {devices/lab_pin.sym} 70 80 0 0 {name=l8 sig_type=std_logic lab=A}
C {devices/code_shown.sym} -120 50 0 0 {name=NGSPICE
only_toplevel=true
place=end
value="
.control
save all
tran 0.01n 50n
plot A B SUM COUT
.endc
"}
C {devices/code.sym} -130 -110 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
.lib $::SKYWATER_MODELS/sky130.lib.spice tt

"}
C {devices/lab_pin.sym} 190 80 0 1 {name=l4 sig_type=std_logic lab=SUM}
C {devices/vsource.sym} 80 -10 0 0 {name=V2 value="pulse 0 1.8 1n 1p 1p 10n 20n"  
		}
C {devices/lab_pin.sym} 140 -60 0 1 {name=l6 sig_type=std_logic lab=B}
C {devices/vsource.sym} 20 -10 0 0 {name=V1 value=1.8
		}
C {devices/vdd.sym} 20 -40 0 0 {name=l1 lab=VDD}
C {devices/gnd.sym} 80 20 0 0 {name=l2 lab=GND}
C {devices/gnd.sym} 20 20 0 0 {name=l3 lab=GND}
C {devices/vsource.sym} 80 -140 0 0 {name=V3 value="pulse 0 1.8 0 1p 1p 5n 10n"  
		}
C {devices/lab_pin.sym} 140 -190 0 1 {name=l5 sig_type=std_logic lab=A}
C {devices/gnd.sym} 80 -110 0 0 {name=l7 lab=GND}
C {devices/lab_pin.sym} 70 120 0 0 {name=l9 sig_type=std_logic lab=B}
C {devices/lab_pin.sym} 190 120 0 1 {name=l10 sig_type=std_logic lab=COUT}
C {HA.sym} 130 100 0 0 {name=x1 VDD=VDD VSS=GND}
