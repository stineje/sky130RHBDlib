v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 20 10 40 10 {
lab=A}
N 120 10 140 10 {
lab=Y}
N 80 -170 80 -130 {
lab=A}
N 80 -170 140 -170 {
lab=A}
C {devices/lab_pin.sym} 20 10 0 0 {name=l8 sig_type=std_logic lab=A}
C {devices/code_shown.sym} -120 50 0 0 {name=NGSPICE
only_toplevel=true
place=end
value="
.control
save all
tran 0.01n 30n
plot A Y VDD
.endc
"}
C {devices/code.sym} -130 -110 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
.lib $::SKYWATER_MODELS/sky130.lib.spice tt

"}
C {devices/lab_pin.sym} 140 10 0 1 {name=l4 sig_type=std_logic lab=Y}
C {devices/vsource.sym} 80 -100 0 0 {name=V2 value="pwl 0n 1.8 10n 1.8 10.1n 0 20n 0 20.1n 1.8"  
		}
C {devices/lab_pin.sym} 140 -170 0 1 {name=l6 sig_type=std_logic lab=A}
C {devices/vsource.sym} 20 -100 0 0 {name=V1 value=1.8
		}
C {devices/vdd.sym} 20 -130 0 0 {name=l1 lab=VDD}
C {devices/gnd.sym} 80 -70 0 0 {name=l2 lab=GND}
C {devices/gnd.sym} 20 -70 0 0 {name=l3 lab=GND}
C {INVX1.sym} 80 10 0 0 {name=x1 VDD=VDD VSS=GND}
