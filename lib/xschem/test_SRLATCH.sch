v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 80 -60 140 -60 {
lab=R}
N 80 -190 140 -190 {
lab=S}
N 80 -190 80 -170 {
lab=S}
N 80 -60 80 -40 {
lab=R}
C {devices/lab_pin.sym} 40 80 0 0 {name=l8 sig_type=std_logic lab=S}
C {devices/code_shown.sym} -120 50 0 0 {name=NGSPICE
only_toplevel=true
place=end
value="
.control
tran 0.01n 35n
plot Q
plot QN
plot S
plot R
.endc
"}
C {devices/code.sym} -130 -110 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
.lib $::SKYWATER_MODELS/sky130.lib.spice tt

"}
C {devices/lab_pin.sym} 160 80 0 1 {name=l4 sig_type=std_logic lab=Q}
C {devices/vsource.sym} 80 -10 0 0 {name=V2 value="pwl 0n 1.8 2n 1.8 2.1n 0 20n 0 20.1n 1.8 25n 1.8 25.1n 0"  
		}
C {devices/lab_pin.sym} 140 -60 0 1 {name=l6 sig_type=std_logic lab=R}
C {devices/vsource.sym} 20 -10 0 0 {name=V1 value=1.8
		}
C {devices/vdd.sym} 20 -40 0 0 {name=l1 lab=VDD}
C {devices/gnd.sym} 80 20 0 0 {name=l2 lab=GND}
C {devices/gnd.sym} 20 20 0 0 {name=l3 lab=GND}
C {devices/vsource.sym} 80 -140 0 0 {name=V3 value="pwl 0n 0 5n 0 5.1n 1.8 10n 1.8 10.1n 0 30n 0 30.1n 1.8"  
		}
C {devices/lab_pin.sym} 140 -190 0 1 {name=l5 sig_type=std_logic lab=S}
C {devices/gnd.sym} 80 -110 0 0 {name=l7 lab=GND}
C {devices/lab_pin.sym} 40 120 0 0 {name=l9 sig_type=std_logic lab=R}
C {SRLATCH.sym} 100 100 0 0 {name=x1 VDD=VDD VSS=GND}
C {devices/lab_pin.sym} 160 120 0 1 {name=l10 sig_type=std_logic lab=QN}
