**********************
*** P+ Poly preres ***
**********************

.subckt xhrpoly_0p35 r0 r1 b w=0.350 l=5 mf=1
.param 
+body_pelgrom = 0.0347
+rend_mm = 0.085
+rcon = 589.99
+rsheet = 1112.41    $ ohms per length
+tc1_voltco = -7.1e-3
+vc1_body = -8.46e-3
+vc2_body =  1.97e-3 
+vc3_body =  3.30e-5
+vc1_raw_end = -2.02e-2 
+vc2_raw_end =  1.55e-1
+vc3_raw_end =  4.61e-2
+r0_var = 50.97
+r1_var = 34.74
+vc1_end = 'vc1_raw_end/pwr(l,0.5)*(1+tc1_voltco*(temper-30))'
+vc2_end = 'vc2_raw_end/pwr(l,0.5)*(1+tc1_voltco*(temper-30))'
+vc3_end = 'vc3_raw_end/pwr(l,0.5)*(1+tc1_voltco*(temper-30))'
+rtot_var   = 'hrpoly_var_mult*sqrt(2*pow(r0_var,2)+pow((r1_var*l),2))'
+rend_var   = 'hrpoly_var_mult*sqrt(2)*r0_var'
+rbody_var  = 'rtot_var-rend_var'
+rend       = '(rcon+rend_var)' 
+rbody      = '(l*rsheet+rbody_var)' 
.model mrbody r tc1=tc1rpolybody tc2=tc2rpolybody tnom=30
rend  r0 ra r='rend*(1+min((abs(v(r0,r1))-1.7),0.3)*vc1_end+pow(min(abs(v(r0,r1))-1.7,0.3),2)*vc2_end+pow(min(abs(v(r0,r1))-1.7,0.3),3)*vc3_end)'
rbody ra r1 mrbody r='rbody*(1+abs(v(r0,r1))*vc1_body+pow(abs(v(r0,r1)),2)*vc2_body+pow(abs(v(r0,r1)),3)*vc3_body)'
c1     r0      b     '((l+2*2.08)*w*crpf_precision*1e-12 + 2*(l+2*2.08+w)*crpfsw_precision_1_1*1e-6)/2'
c2     r1      b     '((l+2*2.08)*w*crpf_precision*1e-12 + 2*(l+2*2.08+w)*crpfsw_precision_1_1*1e-6)/2'
.ends xhrpoly_0p35

.subckt xhrpoly_0p69 r0 r1 b w=0.690 l=5 mf=1
.param
+body_pelgrom = 0.0317
+rend_mm = 0.064
+rcon = 389.90
+rsheet = 491.36  $ ohms per length
+tc1_voltco = -4.27e-3
+vc1_body = 1.92e-4
+vc2_body = 2.86e-4 
+vc3_body = 3.48e-5 
+vc1_raw_end = -3.90e-4
+vc2_raw_end =  1.37e-1
+vc3_raw_end =  4.52e-2
+r0_var = 28.13
+r1_var = 15.71
+vc1_end = 'vc1_raw_end/l*(1+tc1_voltco*(temper-30))'
+vc2_end = 'vc2_raw_end/l*(1+tc1_voltco*(temper-30))'
+vc3_end = 'vc3_raw_end/l*(1+tc1_voltco*(temper-30))'
+rtot_var   = 'hrpoly_var_mult*sqrt(2*pow(r0_var,2)+pow((r1_var*l),2))'
+rend_var   = 'hrpoly_var_mult*sqrt(2)*r0_var'
+rbody_var  = 'rtot_var-rend_var'
+rend       = '(rcon+rend_var)' 
+rbody      = '(l*rsheet+rbody_var)' 
.model mrbody r tc1=tc1rpolybody tc2=tc2rpolybody tnom=30
rend  r0 ra r='rend*(1+min((abs(v(r0,r1))-1.7),0.3)*vc1_end+pow(min(abs(v(r0,r1))-1.7,0.3),2)*vc2_end+pow(min(abs(v(r0,r1))-1.7,0.3),3)*vc3_end)'
rbody ra r1 mrbody r='rbody*(1+abs(v(r0,r1))*vc1_body+pow(abs(v(r0,r1)),2)*vc2_body+pow(abs(v(r0,r1)),3)*vc3_body)'
c1      r0      b     '((l+2*2.08)*w*crpf_precision*1e-12 + 2*(l+2*2.08+w)*crpfsw_precision_2_1*1e-6)/2'
c2      r1      b     '((l+2*2.08)*w*crpf_precision*1e-12 + 2*(l+2*2.08+w)*crpfsw_precision_2_1*1e-6)/2'
.ends xhrpoly_0p69

.subckt xhrpoly_1p41 r0 r1 b w=1.410 l=5 mf=1
.param 
+body_pelgrom = 0.0354
+rend_mm = 0.033
+rcon = 254.77
+rsheet = 230.05  $ ohms per length
+tc1_voltco = -4.68e-3
+vc1_body = -1.24e-4
+vc2_body =  2.41e-4
+vc1_raw_end = -7.62e-2
+vc2_raw_end =  0.198
+vc3_raw_end =  8.81e-2
+r0_var = 15.43
+r1_var =  6.96
+vc1_end = 'vc1_raw_end*0.705/l*(1+tc1_voltco*(temper-30))'
+vc2_end = 'vc2_raw_end*0.705/l*(1+tc1_voltco*(temper-30))'
+vc3_end = 'vc3_raw_end*0.705/l*(1+tc1_voltco*(temper-30))'
+rtot_var   = 'hrpoly_var_mult*sqrt(2*pow(r0_var,2)+pow((r1_var*l),2))'
+rend_var   = 'hrpoly_var_mult*sqrt(2)*r0_var'
+rbody_var  = 'rtot_var-rend_var'
+rend       = '(rcon+rend_var)' 
+rbody      = '(l*rsheet+rbody_var)' 
.model mrbody r tc1=tc1rpolybody tc2=tc2rpolybody tnom=30
rend  r0 ra r='rend*(1+min((abs(v(r0,r1))-1.4),0.6)*vc1_end+pow(min(abs(v(r0,r1))-1.4,0.6),2)*vc2_end+pow(min(abs(v(r0,r1))-1.4,0.6),3)*vc3_end)'
rbody ra r1 mrbody r='rbody*(1+abs(v(r0,r1))*vc1_body+pow(abs(v(r0,r1)),2)*vc2_body)'
c1      r0      b     '((l+2*2.08)*w*crpf_precision*1e-12 + 2*(l+2*2.08+w)*crpfsw_precision_4_1*1e-6)/2'
c2      r1      b     '((l+2*2.08)*w*crpf_precision*1e-12 + 2*(l+2*2.08+w)*crpfsw_precision_4_1*1e-6)/2'
.ends xhrpoly_1p41

.subckt xhrpoly_2p85 r0 r1 b w=2.850 l=5 mf=1
.param
+body_pelgrom = 0.0388
+rend_mm = 0.015
+rcon = 130.36
+rsheet = 113.56  $ ohms per length
+tc1_voltco = -9.36e-3
+vc1_body = 3.21e-4
+vc2_body = 4.95e-5
+vc1_raw_end = 1.47e-2
+vc2_raw_end = 0.136
+vc3_raw_end =  5.29e-2
+r0_var = 8.23
+r1_var = 3.29
+vc1_end = 'vc1_raw_end*1.425/l*(1+tc1_voltco*min((temper-30),0))'
+vc2_end = 'vc2_raw_end*1.425/l*(1+tc1_voltco*min((temper-30),0))'
+vc3_end = 'vc3_raw_end*1.425/l*(1+tc1_voltco*min((temper-30),0))'
+rtot_var   = 'hrpoly_var_mult*sqrt(2*pow(r0_var,2)+pow((r1_var*l),2))'
+rend_var   = 'hrpoly_var_mult*sqrt(2)*r0_var'
+rbody_var  = 'rtot_var-rend_var'
+rend       = '(rcon+rend_var)' 
+rbody      = '(l*rsheet+rbody_var)' 
.model mrbody r tc1=tc1rpolybody tc2=tc2rpolybody tnom=30
rend  r0 ra r='rend*(1+min((abs(v(r0,r1))-1.6),0.4)*vc1_end+pow(min(abs(v(r0,r1))-1.6,0.4),2)*vc2_end+pow(min(abs(v(r0,r1))-1.6,0.4),3)*vc3_end)'
rbody ra r1 mrbody r='rbody*(1+abs(v(r0,r1))*vc1_body+pow(abs(v(r0,r1)),2)*vc2_body)'
c1      r0      b     '((l+2*2.08)*w*crpf_precision*1e-12 + 2*(l+2*2.08+w)*crpfsw_precision_8_2*1e-6)/2'
c2      r1      b     '((l+2*2.08)*w*crpf_precision*1e-12 + 2*(l+2*2.08+w)*crpfsw_precision_8_2*1e-6)/2'
.ends xhrpoly_2p85

.subckt xhrpoly_5p73 r0 r1 b w=5.730 l=5 mf=1
.param 
+body_pelgrom = 0.037
+rend_mm = 0.01
+rcon = 68.05
+rsheet = 56.46  $ ohms per length
+tc1_voltco = 2.35e-2
+vc1_body = -2.62e-5
+vc2_body =  2.25e-5
+vc1_raw_end =  8.74e-4 
+vc2_raw_end = -1.34e-2
+vc3_raw_end =  1.72e-2
+r0_var = 4.29
+r1_var = 1.6
+vc1_end = 'vc1_raw_end*2.865/l*(1+(tc1_voltco*min((temper-30),0)))'
+vc2_end = 'vc2_raw_end*2.865/l*(1+(tc1_voltco*min((temper-30),0)))'
+vc3_end = 'vc3_raw_end*2.865/l*(1+(tc1_voltco*min((temper-30),0)))'
+rtot_var   = 'hrpoly_var_mult*sqrt(2*pow(r0_var,2)+pow((r1_var*l),2))'
+rend_var   = 'hrpoly_var_mult*sqrt(2)*r0_var'
+rbody_var  = 'rtot_var-rend_var'
+rend       = '(rcon+rend_var)' 
+rbody      = '(l*rsheet+rbody_var)' 
.model mrbody r tc1=tc1rpolybody tc2=tc2rpolybody tnom=30
rend  r0 ra r='rend*(1+min(abs(v(r0,r1)),2.0)*vc1_end+pow(min(abs(v(r0,r1)),2.0),2)*vc2_end+pow(min(abs(v(r0,r1)),2.0),3)*vc3_end)'
rbody ra r1 mrbody r='rbody*(1+abs(v(r0,r1))*vc1_body+pow(abs(v(r0,r1)),2)*vc2_body)'
c1      r0      b     '((l+2*2.08)*w*crpf_precision*1e-12 + 2*(l+2*2.08+w)*crpfsw_precision_16_2*1e-6)/2'
c2      r1      b     '((l+2*2.08)*w*crpf_precision*1e-12 + 2*(l+2*2.08+w)*crpfsw_precision_16_2*1e-6)/2'
.ends xhrpoly_5p73
