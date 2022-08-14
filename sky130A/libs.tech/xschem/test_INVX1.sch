v {xschem version=3.0.0 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 100 40 110 40 {
lab=out_q}
C {devices/vsource.sym} 30 -60 0 0 {name=V2 value="
pwl 1.8V 0n 1.8V 2n 0V 2.1n 0V 8n 1.8V 8.1n 1.8V 10n 0V 10.1n 0V 13.9n 1.8V 14n
"  
		}
C {devices/lab_pin.sym} 30 -90 0 0 {name=l6 sig_type=std_logic lab=inp}
C {devices/lab_pin.sym} 30 -30 0 0 {name=l7 sig_type=std_logic lab=0}
C {devices/lab_pin.sym} 20 40 0 0 {name=l8 sig_type=std_logic lab=inp}
C {devices/code_shown.sym} -120 50 0 0 {name=NGSPICE
only_toplevel=true
value="
.control
tran 1p 50n
plot inp out_q
.endc
"}
C {devices/opin.sym} 110 40 0 0 {name=p1 lab=out_q}
C {INVX1.sym} 60 40 0 0 {name=x1}
C {devices/code.sym} -130 -110 0 0 {name=TT_MODELS
only_toplevel=true
value="
.lib $::SKYWATER_MODELS/sky130.lib.spice tt

"}
