v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 80 -120 80 -80 {
lab=A}
N 80 -120 140 -120 {
lab=A}
N 0 40 20 40 {
lab=A}
N 100 40 120 40 {
lab=Y}
C {devices/vsource.sym} 80 -50 0 0 {name=V2 value="pwl 0n VDD 2n VDD 2.1n GND 8n VDD 8.1n VDD 10n VDD 10.1n GND 13.9n GND 14n VDD"  
		}
C {devices/lab_pin.sym} 140 -120 0 1 {name=l6 sig_type=std_logic lab=A}
C {devices/lab_pin.sym} 0 40 0 0 {name=l8 sig_type=std_logic lab=A}
C {devices/code_shown.sym} -120 50 0 0 {name=NGSPICE
only_toplevel=true
place=end
value="

vvss vss 0 dc 0
vvdd vdd 0 pwl 0 0 10n 0 10.1n 1.8 20n 1.8 20.1n 0

.control
tran 0.01n 30n
plot A Y vdd
.endc
"}
C {devices/code.sym} -130 -110 0 0 {name=TT_MODELS
only_toplevel=true
place=start
format="tcleval( @value )"
value="
.lib $::SKYWATER_MODELS/sky130.lib.spice tt

"
spice_ignore=false}
C {devices/gnd.sym} 80 -20 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} 20 -50 0 0 {name=V1 value="1.8"  
		}
C {devices/vdd.sym} 20 -80 0 0 {name=l2 lab=VDD}
C {devices/gnd.sym} 20 -20 0 0 {name=l3 lab=GND}
C {devices/lab_pin.sym} 120 40 0 1 {name=l4 sig_type=std_logic lab=Y}
C {sky130_tests/INVX1.sym} 60 40 0 0 {name=x1                                                               
+ VDDPIN=VDD VSSPIN=VSS}
