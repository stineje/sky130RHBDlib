***This is the model file for MIM Capacitor.  This doesn't conserve charge.
.subckt xcmimc c0 c1 b w=1 l=1 mf=1
*****via_spacing from S8TDR Rules = via2.1a + via.2 + capm.4
.param wc = 'w+m2_dw*1e6+tol_m2*1e6'
.param lc = 'l+m2_dw*1e6+tol_m2*1e6'
.param via_spacing = '(0.28+0.28+0.140)*(0.28+0.28+0.140)'  $area of a single via2 with spacing (physical) (from TDR*E)
.param num_contacts = '(wc*lc/via_spacing)'
.param r1 = 'rm3*(lc)/(wc)'
.param r2 = 'rcvia2/num_contacts'
.param vc1 = -25e-6   $$ Parts per million/Volts
.param vc2 = 90e-6    $$ Parts per million/Volts^2
.param carea = 'camimc*(wc)*(lc)' 
.param cperim = 'cpmimc*((wc)+(lc))*2'
.param czero  = 'carea + cperim' 
.param cpar_area = 'mcm2f_ca_w_1_120_s_3_500*(wc+0.28)*(lc+0.28)*1e-12'
.param cpar_perim = 'mcm2f_cf_w_1_120_s_3_500*((wc+0.28)+(lc+0.28))*2*1e-6'

c1      c0       a       'czero*(1+vc1*(v(c0)-v(c1))+vc2*(v(c0)-v(c1))*(v(c0)-v(c1)))'  tc1=0  tc2=0

rs1     a        b1       'r1' tc1=tc1rm2    tc2=tc2rm2   $$use M2 tco's
rs2     b1        c1      'r2' tc1=tc1rvia2 tc2=tc2rvia2  $$us3 rcvia2 tco's

***Use Rescap elements for the M1-Field Parasitic capacitance structures
***Must convert from w/l from um to m to align w/RESCAP element units of F/m^2, F/m
cox_1   c1       b     'cpar_area'  tc1=0  tc2=0
cox_2   c1       b     'cpar_perim'  tc1=0  tc2=0

.ends xcmimc

***** xcmimc2 is identical to xcmimc except it has not bulk terminal and no parasitic to bulk
.subckt xcmimc2 c0 c1 w=1 l=1 mf=1
*****via_spacing from S8TDR Rules = via2.1a + via.2 + capm.4
.param wc = 'w+m2_dw*1e6+tol_m2*1e6'
.param lc = 'l+m2_dw*1e6+tol_m2*1e6'
.param via_spacing = '(0.28+0.28+0.140)*(0.28+0.28+0.140)'  $area of a single via2 with spacing (physical) (from TDR*E)
.param num_contacts = '(wc*lc/via_spacing)'
.param r1 = 'rm3*(lc)/(wc)'
.param r2 = 'rcvia2/num_contacts'
.param vc1 = -25e-6   $$ Parts per million/Volts
.param vc2 = 90e-6    $$ Parts per million/Volts^2
.param carea = 'camimc*(wc)*(lc)' 
.param cperim = 'cpmimc*((wc)+(lc))*2'
.param czero  = 'carea + cperim' 

c1      c0       a       'czero*(1+vc1*(v(c0)-v(c1))+vc2*(v(c0)-v(c1))*(v(c0)-v(c1)))'  tc1=0  tc2=0

rs1     a        b1       'r1' tc1=tc1rm2    tc2=tc2rm2   $$use M2 tco's
rs2     b1        c1      'r2' tc1=tc1rvia2 tc2=tc2rvia2  $$us3 rcvia2 tco's

.ends xcmimc2
