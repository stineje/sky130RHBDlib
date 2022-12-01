* Place holder for Isolated pwell resistor 
.subckt xpwres r0 r1 b l=-1 
.param w=2.65
.param dl=0.52 
.param av=0.0133
.param bv=0.0302
.param tref=30.0
.param vt=3.531e-3
.param ut=7.238e-6

rpw1 r0 r1
+r='rspwres*((l+dl)/w)*(1-av*(max(v(r0),v(r1))-min(v(r0),v(r1))))*(1+bv*(v(b)-min(v(r0),v(r1))))*(1+vt*(temper-tref)+ut*(temper-tref)*(temper-tref))'

.ends xpwres

