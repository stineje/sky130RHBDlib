* 3-terminal Vertical Parallel Plate Capacitor /w No Shield
* This is the ~50fF fixed capacitor model
* Fixed layout is here:
* /proj/tlib/s8rf/golden/s8rf/opus/s8rf/s8rf_xcmvpp8p6x7p9/layout

.subckt xcmvpp8p6x7p9 c0 c1 b mf=1
.param
+ctot_a   =  '40.728e-15*xcmvpp8p6x7p9_cor' 
+c0_sub   =  '3.241e-15*cli2s_vpp'  
+c1_sub   =  '1.307e-15*cli2s_vpp'  
+rat_m2   =  0.3761
+rat_m1   =  0.3856
+rat_li   =  0.2383
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 
+cap_li   =  'rat_li*ctot_a' 

+lm2      =  3.685
+wm2      =  0.140
+nfm2     =  44       
+nvia_c0  =  84      
+nvia_c1  =  42       
+lm1      =  3.290
+wm1      =  0.140
+nfm1     =  52      
+ncon_c0  =  84
+ncon_c1  =  16 
+ll1      =  3.655
+wl1      =  0.170
+nfl1     =  38      

rm21  c0 a1   'rm2*lm2/wm2*(1/3)*(1/nfm2)'
cm2   a1 c1   'cap_m2'

rvia1 c0 d0   'rcvia/nvia_c0'
rvia2 c1 d1   'rcvia/nvia_c1'

rm11  d0 b1   'rm1*lm1/wm1*(1/3)*(1/nfm1)'
cm1   b1 d1   'cap_m1'

rcon1 d0 e0   'rcl1/ncon_c0'
rcon2 d1 e1   'rcl1/ncon_c1'

rli1  e0 f1   'rl1*ll1/wl1*(1/3)*(1/nfl1)'
cli   f1 e1   'cap_li'

cli1_b  e0 b  'c0_sub'
cli2_b  e1 b  'c1_sub'

.ends xcmvpp8p6x7p9


* 3-terminal Vertical Parallel Plate Capacitor /w No Shield
* This is the ~12fF fixed capacitor model
* Fixed layout is here:
* /proj/tlib/s8rf/golden/s8rf/opus/s8rf/s8rf_xcmvpp4p4x4p6/layout

.subckt xcmvpp4p4x4p6 c0 c1 b mf=1
.param
+ctot_a   =  '9.81e-15*xcmvpp4p4x4p6_cor'
+c0_sub   =  '1.528e-15*cli2s_vpp'  
+c1_sub   =  '0.440e-15*cli2s_vpp'  
+rat_m2   =  0.447 
+rat_m1   =  0.320 
+rat_li   =  0.233
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 
+cap_li   =  'rat_li*ctot_a' 

+lm2      =  1.585
+wm2      =  0.140
+nfm2     =  24       
+nvia_c0  =  40      
+nvia_c1  =  18       
+lm1      =  1.665
+wm1      =  0.140
+nfm1     =  20      
+ncon_c0  =  42
+ncon_c1  =  8  
+ll1      =  1.555
+wl1      =  0.170
+nfl1     =  20      

rm21  c0 a1   'rm2*lm2/wm2*(1/3)*(1/nfm2)'
cm2   a1 c1   'cap_m2'

rvia1 c0 d0   'rcvia/nvia_c0'
rvia2 c1 d1   'rcvia/nvia_c1'

rm11  d0 b1   'rm1*lm1/wm1*(1/3)*(1/nfm1)'
cm1   b1 d1   'cap_m1'

rcon1 d0 e0   'rcl1/ncon_c0'
rcon2 d1 e1   'rcl1/ncon_c1'

rli1  e0 f1   'rl1*ll1/wl1*(1/3)*(1/nfl1)'
cli   f1 e1   'cap_li'

cli1_b  e0 b  'c0_sub'
cli2_b  e1 b  'c1_sub'

.ends xcmvpp4p4x4p6


* 3-terminal Vertical Parallel Plate Capacitor /w No Shield
* This is the ~115fF fixed capacitor model
* Fixed layout is here:
* /proj/tlib/s8rf/golden/s8rf/opus/s8rf/s8rf_xcmvpp11p5x11p7/layout

.subckt xcmvpp11p5x11p7 c0 c1 b mf=1
.param
+ctot_a   =  '94.178e-15*xcmvpp11p5x11p7_cor' 
+c0_sub   =  '5.222e-15*cli2s_vpp'  
+c1_sub   =  '2.528e-15*cli2s_vpp'  
+rat_m2   =  0.3823
+rat_m1   =  0.3777
+rat_li   =  0.2400
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 
+cap_li   =  'rat_li*ctot_a' 

+lm2      =  5.100
+wm2      =  0.140
+nfm2     =  72       
+nvia_c0  =  124      
+nvia_c1  =  62       
+lm1      =  5.215
+wm1      =  0.140
+nfm1     =  72      
+ncon_c0  =  116
+ncon_c1  =  28 
+ll1      =  3.655
+wl1      =  0.170
+nfl1     =  62      

rm21  c0 a1   'rm2*lm2/wm2*(1/3)*(1/nfm2)'
cm2   a1 c1   'cap_m2'

rvia1 c0 d0   'rcvia/nvia_c0'
rvia2 c1 d1   'rcvia/nvia_c1'

rm11  d0 b1   'rm1*lm1/wm1*(1/3)*(1/nfm1)'
cm1   b1 d1   'cap_m1'

rcon1 d0 e0   'rcl1/ncon_c0'
rcon2 d1 e1   'rcl1/ncon_c1'

rli1  e0 f1   'rl1*ll1/wl1*(1/3)*(1/nfl1)'
cli   f1 e1   'cap_li'

cli1_b  e0 b  'c0_sub'
cli2_b  e1 b  'c1_sub'

.ends xcmvpp11p5x11p7


* 3-terminal Vertical Parallel Plate Capacitor /w No Shield
* This is the ~1fF fixed capacitor model
* Fixed layout is here:
* /proj/tlib/s8rf/golden/s8rf/opus/s8rf/s8rf_xcmvpp1p8x1p8/layout

.subckt xcmvpp1p8x1p8 c0 c1 b mf=1
.param
+ctot_a   =  '7.833e-16*xcmvpp1p8x1p8_cor' 
+cli2s    =  '4.548e-17*cli2s_vpp'
+rat_m2   =  0.596 
+rat_m1   =  0.387 
+rat_m1li =  0.017
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 
+cap_m1li =  'rat_m1li*ctot_a' 

+nvia_c0  =  8      
+nvia_c1  =  4        
+ncon_c0  =  16

rm21  c0 a1   '28*rm2'  
cm2   a1 c1   'cap_m2'

rvia1 c0 d0   'rcvia/nvia_c0'
rvia2 c1 d1   'rcvia/nvia_c1'

rm11  d0 b1   '22*rm1'
cm1   b1 d1   'cap_m1'

rcon  d0 e0   'rcl1/ncon_c0'

rli1  e0 f0   'rl1'
cli2b  f0 b   'cli2s'
cm1li  d1 e0  'cap_m1li'

.ends xcmvpp1p8x1p8


* 3-terminal Vertical Parallel Plate Capacitor /w LI Shield
* This is the ~50fF fixed capacitor model
* Fixed layout is here:
* /proj/tlib/s8rf/golden/s8rf/opus/s8rf/s8rf_xcmvpp8p6x7p9_lishield/layout

.subckt xcmvpp8p6x7p9_lishield c0 c1 b mf=1
.param
+ctot_a   =  '33.778e-15*xcmvpp8p6x7p9_lishield_cor' 
+cli2s    =  '4.362e-15*cli2s_vpp'  
+rat_m2   =  0.4690
+rat_m1   =  0.4805
+rat_m12li=  0.0505
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 
+cap_m12li=  'rat_m12li*ctot_a' 

+lm2      =  3.685
+wm2      =  0.140
+nfm2     =  44       
+nvia_c0  =  84      
+nvia_c1  =  42       
+lm1      =  3.290
+wm1      =  0.140
+nfm1     =  52      
+nmcon    =  84

rm21  c0 a1   'rm2*lm2/wm2*(1/3)*(1/nfm2)'
cm2   a1 c1   'cap_m2'

rvia1 c0 d0   'rcvia/nvia_c0'
rvia2 c1 d1   'rcvia/nvia_c1'

rm11  d0 b1   'rm1*lm1/wm1*(1/3)*(1/nfm1)'
cm1   b1 d1   'cap_m1'

rmcon  d0 e0  'rcl1/nmcon'
rliw   e0 f0  'rl1'
cli2b  f0 b   'cli2s'
cm12li d1 f0  'cap_m12li'

.ends xcmvpp8p6x7p9_lishield


* 3-terminal Vertical Parallel Plate Capacitor /w LI Shield
* This is the ~12fF fixed capacitor model
* Fixed layout is here:
* /proj/tlib/s8rf/golden/s8rf/opus/s8rf/s8rf_xcmvpp4p4x4p6_lishield/layout

.subckt xcmvpp4p4x4p6_lishield c0 c1 b mf=1
.param
+ctot_a   =  '8.450e-15*xcmvpp4p4x4p6_lishield_cor' 
+cli2s    =  '1.864e-15*cli2s_vpp'
+rat_m2   =  0.552
+rat_m1   =  0.395 
+rat_m12li=  0.053
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 
+cap_m12li=  'rat_m12li*ctot_a' 

+lm2      =  1.585
+wm2      =  0.140
+nfm2     =  24       
+nvia_c0  =  40      
+nvia_c1  =  18       
+lm1      =  1.665
+wm1      =  0.140
+nfm1     =  20      
+nmcon    =  42

rm21  c0 a1   'rm2*lm2/wm2*(1/3)*(1/nfm2)'
cm2   a1 c1   'cap_m2'

rvia1 c0 d0   'rcvia/nvia_c0'
rvia2 c1 d1   'rcvia/nvia_c1'

rm11  d0 b1   'rm1*lm1/wm1*(1/3)*(1/nfm1)'
cm1   b1 d1   'cap_m1'

rmcon  d0 e0  'rcl1/nmcon'
rliw   e0 f0  'rl1'
cli2b  f0 b   'cli2s'
cm12li d1 f0  'cap_m12li'

.ends xcmvpp4p4x4p6_lishield


* 3-terminal Vertical Parallel Plate Capacitor /w LI Shield
* This is the ~115fF fixed capacitor model
* Fixed layout is here:
* /proj/tlib/s8rf/golden/s8rf/opus/s8rf/s8rf_xcmvpp11p5x11p7_lishield/layout

.subckt xcmvpp11p5x11p7_lishield c0 c1 b mf=1
.param
+ctot_a   =  '76.393e-15*xcmvpp11p5x11p7_lishield_cor' 
+cli2s    =  '7.521e-15*cli2s_vpp'
+rat_m2   =  0.481 
+rat_m1   =  0.476 
+rat_m12li=  0.043
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 
+cap_m12li=  'rat_m12li*ctot_a' 

+lm2      =  5.100
+wm2      =  0.140
+nfm2     =  72       
+nvia_c0  =  124      
+nvia_c1  =  62       
+lm1      =  5.215
+wm1      =  0.140
+nfm1     =  72      
+nmcon    =  116

rm21  c0 a1   'rm2*lm2/wm2*(1/3)*(1/nfm2)'
cm2   a1 c1   'cap_m2'

rvia1 c0 d0   'rcvia/nvia_c0'
rvia2 c1 d1   'rcvia/nvia_c1'

rm11  d0 b1   'rm1*lm1/wm1*(1/3)*(1/nfm1)'
cm1   b1 d1   'cap_m1'

rmcon  d0 e0  'rcl1/nmcon'
rliw   e0 f0  'rl1'
cli2b  f0 b   'cli2s'
cm12li d1 f0  'cap_m12li'

.ends xcmvpp11p5x11p7_lishield


* 4-terminal Vertical Parallel Plate Capacitor /w Poly + MET3 Shield
* This is the ~50fF fixed capacitor model
* Fixed layout is here:
* /proj/tlib/s8rf/golden/s8rf/opus/s8rf/s8rf_xcmvpp8p6x7p9_m3shield/layout

.subckt xcmvpp8p6x7p9_m3shield c0 c1 b m3 mf=1
.param
+ctot_a   =  '40.812e-15*xcmvpp8p6x7p9_m3shield_cor' 
+cm3_c0   =  '3.508e-15*cm3m2_vpp'
+cm3_c1   =  '2.772e-15*cm3m2_vpp'
+cpl2s    =  '8.065e-15*cpl2s_vpp'   
+rat_m2   =  0.360 
+rat_m1   =  0.376 
+rat_li   =  0.234
+rat_li2p =  0.030
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 
+cap_li   =  'rat_li*ctot_a' 
+cap_li2p =  'rat_li2p*ctot_a' 

+lm2      =  3.685
+wm2      =  0.140
+nfm2     =  44       
+nvia_c0  =  84      
+nvia_c1  =  42       
+lm1      =  3.290
+wm1      =  0.140
+nfm1     =  52      
+ncon_c0  =  84
+ncon_c1  =  16 
+ll1      =  3.655
+wl1      =  0.170
+nfl1     =  38      
+nlicon   =  84

cm3_0  m3 c0   'cm3_c0'
cm3_1  m3 c1   'cm3_c1'

rm21  c0 a1   'rm2*lm2/wm2*(1/3)*(1/nfm2)'
cm2   a1 c1   'cap_m2'

rvia1 c0 d0   'rcvia/nvia_c0'
rvia2 c1 d1   'rcvia/nvia_c1'

rm11  d0 b1   'rm1*lm1/wm1*(1/3)*(1/nfm1)'
cm1   b1 d1   'cap_m1'

rcon1 d0 e0   'rcl1/ncon_c0'
rcon2 d1 e1   'rcl1/ncon_c1'

rli1  e0 f1   'rl1*ll1/wl1*(1/3)*(1/nfl1)'
cli   f1 e1   'cap_li'

rlicon e0 g0  'rcp1/nlicon'
rpoly  g0 h0  'rp1'
cpl2b  h0 b   'cpl2s'
cl12p  e1 h0  'cap_li2p'

.ends xcmvpp8p6x7p9_m3shield


* 4-terminal Vertical Parallel Plate Capacitor /w Poly + MET3 Shield
* This is the ~12fF fixed capacitor model
* Fixed layout is here:
* /proj/tlib/s8rf/golden/s8rf/opus/s8rf/s8rf_xcmvpp4p4x4p6_m3shield/layout

.subckt xcmvpp4p4x4p6_m3shield c0 c1 b m3 mf=1
.param
+ctot_a   =  '9.766e-15*xcmvpp4p4x4p6_m3shield_cor'
+cm3_c0   =  '1.386e-15*cm3m2_vpp'
+cm3_c1   =  '0.745e-15*cm3m2_vpp'
+cpl2s    =  '2.838e-15*cpl2s_vpp'
+rat_m2   =  0.300 
+rat_m1   =  0.385 
+rat_li   =  0.280
+rat_li2p =  0.035
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 
+cap_li   =  'rat_li*ctot_a' 
+cap_li2p =  'rat_li2p*ctot_a' 

+lm2      =  1.585
+wm2      =  0.140
+nfm2     =  24       
+nvia_c0  =  40      
+nvia_c1  =  18       
+lm1      =  1.665
+wm1      =  0.140
+nfm1     =  20      
+ncon_c0  =  42
+ncon_c1  =  8  
+ll1      =  1.555
+wl1      =  0.170
+nfl1     =  20      
+nlicon   =  44

cm3_0  m3 c0   'cm3_c0'
cm3_1  m3 c1   'cm3_c1'

rm21  c0 a1   'rm2*lm2/wm2*(1/3)*(1/nfm2)'
cm2   a1 c1   'cap_m2'

rvia1 c0 d0   'rcvia/nvia_c0'
rvia2 c1 d1   'rcvia/nvia_c1'

rm11  d0 b1   'rm1*lm1/wm1*(1/3)*(1/nfm1)'
cm1   b1 d1   'cap_m1'

rcon1 d0 e0   'rcl1/ncon_c0'
rcon2 d1 e1   'rcl1/ncon_c1'

rli1  e0 f1   'rl1*ll1/wl1*(1/3)*(1/nfl1)'
cli   f1 e1   'cap_li'

rlicon e0 g0  'rcp1/nlicon'
rpoly  g0 h0  'rp1'
cpl2b  h0 b   'cpl2s'
cl12p  e1 h0  'cap_li2p'

.ends xcmvpp4p4x4p6_m3shield


* 4-terminal Vertical Parallel Plate Capacitor /w Poly + MET3 Shield
* This is the ~115fF fixed capacitor model
* Fixed layout is here:
* /proj/tlib/s8rf/golden/s8rf/opus/s8rf/s8rf_xcmvpp11p5x11p7_m3shield/layout

.subckt xcmvpp11p5x11p7_m3shield c0 c1 b m3 mf=1
.param
+ctot_a   =  '93.41e-15*xcmvpp11p5x11p7_m3shield_cor' 
+cm3_c0   =  '7.160e-15*cm3m2_vpp'
+cm3_c1   =  '5.080e-15*cm3m2_vpp'
+cpl2s    =  '15.567e-15*cpl2s_vpp'
+rat_m2   =  0.435 
+rat_m1   =  0.250 
+rat_li   =  0.275
+rat_li2p =  0.040
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 
+cap_li   =  'rat_li*ctot_a' 
+cap_li2p =  'rat_li2p*ctot_a' 

+lm2      =  5.100
+wm2      =  0.140
+nfm2     =  72       
+nvia_c0  =  124      
+nvia_c1  =  62       
+lm1      =  5.215
+wm1      =  0.140
+nfm1     =  72      
+ncon_c0  =  116
+ncon_c1  =  28 
+ll1      =  3.655
+wl1      =  0.170
+nfl1     =  62      
+nlicon   =  126

cm3_0  m3 c0   'cm3_c0'
cm3_1  m3 c1   'cm3_c1'

rm21  c0 a1   'rm2*lm2/wm2*(1/3)*(1/nfm2)'
cm2   a1 c1   'cap_m2'

rvia1 c0 d0   'rcvia/nvia_c0'
rvia2 c1 d1   'rcvia/nvia_c1'

rm11  d0 b1   'rm1*lm1/wm1*(1/3)*(1/nfm1)'
cm1   b1 d1   'cap_m1'

rcon1 d0 e0   'rcl1/ncon_c0'
rcon2 d1 e1   'rcl1/ncon_c1'

rli1  e0 f1   'rl1*ll1/wl1*(1/3)*(1/nfl1)'
cli   f1 e1   'cap_li'

rlicon e0 g0  'rcp1/nlicon'
rpoly  g0 h0  'rp1'
cpl2b  h0 b   'cpl2s'
cl12p  e1 h0  'cap_li2p'

.ends xcmvpp11p5x11p7_m3shield


* 4-terminal Vertical Parallel Plate Capacitor /w LI + MET3 Shield
* This is the ~1fF fixed capacitor model
* Fixed layout is here:
* /proj/tlib/s8rf/golden/s8rf/opus/s8rf/s8rf_xcmvpp1p8x1p8_m3shield/layout

.subckt xcmvpp1p8x1p8_m3shield c0 c1 b m3 mf=1
.param
+ctot_a   =  '578.275e-18*xcmvpp1p8x1p8_m3shield_cor' 
+cm3_c0   =  '0.444e-15*cm3m2_vpp'
+cm3_c1   =  '0.179e-15*cm3m2_vpp'
+cli2s    =  '0.104e-15*cli2s_vpp'
+rat_m2   =  0.596 
+rat_m1   =  0.387 
+rat_m1li =  0.017
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 
+cap_m1li =  'rat_m1li*ctot_a' 

+nvia_c0  =  8      
+nvia_c1  =  4        
+ncon_c0  =  16

cm3_0  m3 c0   'cm3_c0'
cm3_1  m3 c1   'cm3_c1'

rm21  c0 a1   '28*rm2'  
cm2   a1 c1   'cap_m2'

rvia1 c0 d0   'rcvia/nvia_c0'
rvia2 c1 d1   'rcvia/nvia_c1'

rm11  d0 b1   '22*rm1'
cm1   b1 d1   'cap_m1'

rcon  d0 e0   'rcl1/ncon_c0'

rli1  e0 f0   'rl1'
cli2b  f0 b   'cli2s'
cm1li  d1 e0  'cap_m1li'

.ends xcmvpp1p8x1p8_m3shield

* Vertical Parallel Plate Capacitor #1
* This is the 7.5x7.5 um ~50fF fixed capacitor model
* Fixed layout is here:
* /proj/tlib/s8/golden/s8cell/opus/s8rf/xcmvpp1/layout

.subckt xcmvpp c0 c1 b mf=1
.param
+lvpp=7.5 wm1=0.14 wm2=0.14 wli=0.17
+ctot_a  =  '0.850e-15*lvpp*lvpp*cvpp_cor' 
+rat_m2  =  0.4325
+rat_m1  =  0.3175
+rat_li  =  0.25
+cap_m2  =  'rat_m2*ctot_a' 
+cap_m1  =  'rat_m1*ctot_a' 
+cap_li  =  'rat_li*ctot_a' 
*+caps_m2 =  4.67e-20 $ Negligible
*+caps_m1 =  4.67e-20 $ Negligible
+caps_li =  1.27e-17

+nvia    =  25        $ Each side
+ncon    =  19        $ Each side
+nf      =  14        $ Each side

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

csli1 e0 b    'caps_li*nf*lvpp'
csli2 e1 b    'caps_li*nf*lvpp'

.ends xcmvpp


* Vertical Parallel Plate Capacitor #2
* This is the 3.6x3.6 um ~12fF fixed capacitor model
* Fixed layout is here:
* /proj/tlib/s8/golden/s8cell/opus/s8rf/xcmvpp2/layout

* THIS MODEL IS CURRENTLY PRE-SILICON

.subckt xcmvpp_2 c0 c1 b mf=1
.param
+lvpp=3.6 wm1=0.14 wm2=0.14 wli=0.17
+ctot_a  =  '0.988e-15*lvpp*lvpp*cvpp_cor' 
+rat_m2  =  0.4325
+rat_m1  =  0.3175
+rat_li  =  0.25
+cap_m2  =  'rat_m2*ctot_a' 
+cap_m1  =  'rat_m1*ctot_a' 
+cap_li  =  'rat_li*ctot_a' 
*+caps_m2 =  4.67e-20 $ Negligible
*+caps_m1 =  4.67e-20 $ Negligible
+caps_li =  1.27e-17

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

csli1 e0 b    'caps_li*nf*lvpp'
csli2 e1 b    'caps_li*nf*lvpp'

.ends xcmvpp_2

* Vertical Parallel Plate Capacitor (Symmetric style)
* This is the 7.8x8.6um ~35fF M12 finger capacitor model
* Fixed layout is here:
* //depot/icm/proj/s8rf2/dev/opus/s8rf2/s8rf2_xcmvpp3

.subckt xcmvpp3 c0 c1 b mf=1 presim_flag=0
.param
+lvpp=7.06 wm1=0.14 wm2=0.14
+ctot_a  =  '35.0e-15*cvpp3_cor' 
+rat_m2  =  0.5767
+rat_m1  =  0.4233
+cap_m2  =  'rat_m2*ctot_a' 
+cap_m1  =  'rat_m1*ctot_a' 
+caps_m1 =  '(1.65 + presim_flag*0.19)*1e-15*cli2s_vpp'

+nvia    =  47        $ Each side
+nf      =  14        $ Each side

rm21  c0 a1   '2*rm2*lvpp/wm2*(1/3)*(1/nf)'
cm2   a1 c1   'cap_m2'

rvia1 c0 d0   'rcvia/nvia'
rvia2 c1 d1   'rcvia/nvia'

rm11  d0 b1   '2*rm1*lvpp/wm1*(1/3)*(1/nf)'
cm1   b1 d1   'cap_m1'

csli1 d0 b    'caps_m1'
csli2 d1 b    'caps_m1'

.ends xcmvpp3

* Vertical Parallel Plate Capacitor (Symmetric style)
* This is the 4.38x4.59um ~10fF M12 finger capacitor model
* Fixed layout is here:
* //depot/icm/proj/s8rf2/dev/opus/s8rf2/s8rf2_xcmvpp4

.subckt xcmvpp4 c0 c1 b mf=1 presim_flag=0
.param
+lvpp=3.81 wm1=0.14 wm2=0.14
+ctot_a  =  '9.48e-15*cvpp4_cor' 
+rat_m2  =  0.5767
+rat_m1  =  0.4233
+cap_m2  =  'rat_m2*ctot_a' 
+cap_m1  =  'rat_m1*ctot_a' 
+caps_m1 =  '(0.72 + presim_flag*0.10)*1e-15*cli2s_vpp'

+nvia    =  25        $ Each side
+nf      =   7        $ Each side

rm21  c0 a1   '2*rm2*lvpp/wm2*(1/3)*(1/nf)'
cm2   a1 c1   'cap_m2'

rvia1 c0 d0   'rcvia/nvia'
rvia2 c1 d1   'rcvia/nvia'

rm11  d0 b1   '2*rm1*lvpp/wm1*(1/3)*(1/nf)'
cm1   b1 d1   'cap_m1'

csli1 d0 b    'caps_m1'
csli2 d1 b    'caps_m1'

.ends xcmvpp4

* Vertical Parallel Plate Capacitor (Symmetric style)
* This is the 4.38x2.69um ~5fF M12 finger capacitor model
* Fixed layout is here:
* //depot/icm/proj/s8rf2/dev/opus/s8rf2/s8rf2_xcmvpp5

.subckt xcmvpp5 c0 c1 b mf=1 presim_flag=0
.param
+lvpp=3.81 wm1=0.14 wm2=0.14
+ctot_a  =  '4.37e-15*cvpp5_cor' 
+rat_m2  =  0.5767
+rat_m1  =  0.4233
+cap_m2  =  'rat_m2*ctot_a' 
+cap_m1  =  'rat_m1*ctot_a' 
+capc0_m1 =  '(0.27 + presim_flag*0.02)*1e-15*cli2s_vpp'
+capc1_m1 =  '(0.72 + presim_flag*0.12)*1e-15*cli2s_vpp'

+nvia    =  17        $ Each side
+nf      =   7        $ Each side

rm21  c0 a1   '2*rm2*lvpp/wm2*(1/3)*(1/nf)'
cm2   a1 c1   'cap_m2'

rvia1 c0 d0   'rcvia/nvia'
rvia2 c1 d1   'rcvia/nvia'

rm11  d0 b1   '2*rm1*lvpp/wm1*(1/3)*(1/nf)'
cm1   b1 d1   'cap_m1'

csli1 d0 b    'capc0_m1'
csli2 d1 b    'capc1_m1'

.ends xcmvpp5

* Vertical Parallel Plate Capacitor (Asymmetric style)
* This is the 4.4x4.6um ~8fF M12 finger capacitor model
* Fixed layout is here:
* //depot/icm/proj/s8rf2/dev/opus/s8rf2/s8rf2_xcmvpp4p4x4p6_m1m2

.subckt xcmvpp4p4x4p6_m1m2 c0 c1 b mf=1 presim_flag=0
.param
+lvpp=1.585 wm1=0.14 wm2=0.14
+ctot_a  =  '7.81e-15*xcmvpp4p4x4p6_m3_lishield_cor' 
+rat_m2  =  0.5767
+rat_m1  =  0.4233
+cap_m2  =  'rat_m2*ctot_a' 
+cap_m1  =  'rat_m1*ctot_a' 
+caps_c0 =  '(1.02 + presim_flag*0.22)*1e-15*cli2s_vpp'
+caps_c1 =  '0.39e-15*cli2s_vpp'

+nvia_c0 =  40        $ Each side
+nvia_c1 =  18        $ Each side
+nf      =  16        $ Each side

rm21  c0 a1   '2*rm2*lvpp/wm2*(1/3)*(1/nf)'
cm2   a1 c1   'cap_m2'

rvia1 c0 d0   'rcvia/nvia_c0'
rvia2 c1 d1   'rcvia/nvia_c1'

rm11  d0 b1   '2*rm1*lvpp/wm1*(1/3)*(1/nf)'
cm1   b1 d1   'cap_m1'

csli1 d0 b    'caps_c0'
csli2 d1 b    'caps_c1'

.ends xcmvpp4p4x4p6_m1m2

* Vertical Parallel Plate Capacitor (Asymmetric style)
* This is the 11.5x11.7um ~75fF M12 finger capacitor model
* Fixed layout is here:
* //depot/icm/proj/s8rf2/dev/opus/s8rf2/s8rf2_xcmvpp11p5x11p7_m1m2

.subckt xcmvpp11p5x11p7_m1m2 c0 c1 b mf=1 presim_flag=0
.param
+lvpp=5.1 wm1=0.14 wm2=0.14
***  Using the variation from the 4.4x4.6 because the 11.5x11.7 with LI shield is too tight.  This is not a typo. 
+ctot_a  =  '74.6e-15*xcmvpp4p4x4p6_m3_lishield_cor' 
+rat_m2  =  0.5767
+rat_m1  =  0.4233
+cap_m2  =  'rat_m2*ctot_a' 
+cap_m1  =  'rat_m1*ctot_a' 
+caps_c0 =  '(3.56 + presim_flag*0.55)*1e-15*cli2s_vpp'
+caps_c1 =  '2.01e-15*cli2s_vpp'

+nvia_c0 =  124        $ Each side
+nvia_c1 =   62        $ Each side
+nf      =   40        $ Each side

rm21  c0 a1   '2*rm2*lvpp/wm2*(1/3)*(1/nf)'
cm2   a1 c1   'cap_m2'

rvia1 c0 d0   'rcvia/nvia_c0'
rvia2 c1 d1   'rcvia/nvia_c1'

rm11  d0 b1   '2*rm1*lvpp/wm1*(1/3)*(1/nf)'
cm1   b1 d1   'cap_m1'

csli1 d0 b    'caps_c0'
csli2 d1 b    'caps_c1'

.ends xcmvpp11p5x11p7_m1m2

