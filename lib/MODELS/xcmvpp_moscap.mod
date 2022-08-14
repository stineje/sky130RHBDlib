.subckt xcmvpp2_nhvnative10x4 c0 c1 b mf=1
.param
+lvpp=3.6 wm1=0.14 wm2=0.14 wli=0.17
+ctot_a  =  '0.988e-15*lvpp*lvpp*cvpp2_nhvnative10x4_cor' 
***Note:  The 
+rat_m2  =  0.4325
+rat_m1  =  0.3175
+rat_li  =  0.25
+cap_m2  =  'rat_m2*ctot_a' 
+cap_m1  =  'rat_m1*ctot_a' 
+cap_li  =  'rat_li*ctot_a' 
*+caps_m2 =  4.67e-20 $ Negligible
*+caps_m1 =  4.67e-20 $ Negligible
+caps_li =  'cvpp2_nhvnative10x4_sub'

+nvia    =  11        $ Each side
+ncon    =  10        $ Each side
+nf      =   6        $ Each side

rm21  c0 a1   '2*rm2*lvpp/wm2*(1/3)*(1/nf)'
cm2   a1 c1   'cap_m2'

rvia1 c0 d0   'rcvia/nvia'
rvia2 c1 d1   'rcvia/nvia'

rm11  d0 b1   '2*rm1*lvpp/wm1*(1/3)*(1/nf)'
cm1   b1 d1   'cap_m1'

rcon1 d0 e0   'rcl1/ncon'
rcon2 d1 e1   'rcl1/ncon'

rli1  e0 f1   '2*rl1*lvpp/wli*(1/3)*(1/nf)'
cli   f1 e1   'cap_li'

*Shunt Caps
*csm21 c0 b    'caps_m2*nf*lvpp'
*csm22 c1 b    'caps_m2*nf*lvpp'
                                                         
*csm11 d0 b    'caps_m1*nf*lvpp'
*csm12 d1 b    'caps_m1*nf*lvpp'

csli1 e0 b    'caps_li'
csli2 e1 b    'caps_li'

.ends xcmvpp2_nhvnative10x4

.subckt xcmvpp2_phv5x4 c0 c1 b mf=1
.param
+lvpp=3.6 wm1=0.14 wm2=0.14 wli=0.17
+ctot_a  =  '0.988e-15*lvpp*lvpp*cvpp2_phv5x4_cor' 
***Note:  The 
+rat_m2  =  0.4325
+rat_m1  =  0.3175
+rat_li  =  0.25
+cap_m2  =  'rat_m2*ctot_a' 
+cap_m1  =  'rat_m1*ctot_a' 
+cap_li  =  'rat_li*ctot_a' 
*+caps_m2 =  4.67e-20 $ Negligible
*+caps_m1 =  4.67e-20 $ Negligible
+caps_li =  'cvpp2_phv5x4_sub'

+nvia    =  11        $ Each side
+ncon    =  10        $ Each side
+nf      =   6        $ Each side

rm21  c0 a1   '2*rm2*lvpp/wm2*(1/3)*(1/nf)'
cm2   a1 c1   'cap_m2'

rvia1 c0 d0   'rcvia/nvia'
rvia2 c1 d1   'rcvia/nvia'

rm11  d0 b1   '2*rm1*lvpp/wm1*(1/3)*(1/nf)'
cm1   b1 d1   'cap_m1'

rcon1 d0 e0   'rcl1/ncon'
rcon2 d1 e1   'rcl1/ncon'

rli1  e0 f1   '2*rl1*lvpp/wli*(1/3)*(1/nf)'
cli   f1 e1   'cap_li'

*Shunt Caps
*csm21 c0 b    'caps_m2*nf*lvpp'
*csm22 c1 b    'caps_m2*nf*lvpp'
                                                         
*csm11 d0 b    'caps_m1*nf*lvpp'
*csm12 d1 b    'caps_m1*nf*lvpp'

csli1 e0 b    'caps_li'
csli2 e1 b    'caps_li'

.ends xcmvpp2_phv5x4

