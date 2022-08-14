* 4-terminal Vertical Parallel Plate Capacitor /w LI-M4 fingers and M5 Shield (for S8P ONLY)
* Fixed layout is here:
* //depot/icm/proj/s8rf2/dev/opus/s8rf2/s8rf2_xcmvpp11p5x11p7_m5shield

.subckt xcmvpp11p5x11p7_m5shield c0 c1 b m5 mf=1
.param
+ctot_a   =  '137.45e-15*xcmvpp11p5x11p7_m5shield_cor' 
+cm5_c0   =  '5.11e-15*c0m5m4_vpp'
+cm5_c1   =  '3.89e-15*c1m5m4_vpp'
+c0_sub   =  '(5.36e-15-0.58e-15)*cli2s_vpp'
+c1_sub   =  '2.34e-15*cli2s_vpp'
+rat_m4   =  0.1120
+rat_m3   =  0.1120
+rat_m2   =  0.2966
+rat_m1   =  0.2931
+rat_li   =  0.1863
+cap_m4   =  'rat_m4*ctot_a' 
+cap_m3   =  'rat_m3*ctot_a' 
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 
+cap_li   =  'rat_li*ctot_a' 

+ll1      =  5.070
+lm1      =  5.215
+lm2      =  5.095
+lm3      =  5.050
+lm4      =  4.910
+wl1      =  0.170
+wm1      =  0.140
+wm2      =  0.140
+wm3      =  0.300 
+wm4      =  0.300
+nfl1     =  62      
+nfm1     =  72      
+nfm2     =  72       
+nfm3     =  34
+nfm4     =  34
+nvia3_c0  = 103
+nvia3_c1  = 49
+nvia2_c0  = 104
+nvia2_c1  = 49
+nvia_c0  =  124      
+nvia_c1  =  62       
+ncon_c0  =  116
+ncon_c1  =  28 

cm5_0  m5 a0   'cm5_c0'
cm5_1  m5 a1   'cm5_c1'

rsm4  a0 a2   'rm4*lm4/wm4*(1/3)*(1/nfm4)'
cm4   a2 a1   'cap_m4'

rvia3_0 a0 b0   'rcvia3/nvia3_c0'
rvia3_1 a1 b1   'rcvia3/nvia3_c1'

rsm3   b0 b2   'rm3*lm3/wm3*(1/3)*(1/nfm3)'
cm3    b2 b1   'cap_m3'

rvia2_0 b0 c0   'rcvia2/nvia2_c0'
rvia2_1 b1 c1   'rcvia2/nvia2_c1'

rsm2   c0 c2   'rm2*lm2/wm2*(1/3)*(1/nfm2)'
cm2    c2 c1   'cap_m2'

rvia_0 c0 d0   'rcvia/nvia_c0'
rvia_1 c1 d1   'rcvia/nvia_c1'

rsm1   d0 d2   'rm1*lm1/wm1*(1/3)*(1/nfm1)'
cm1    d2 d1   'cap_m1'

rcon1 d0 e0   'rcl1/ncon_c0'
rcon2 d1 e1   'rcl1/ncon_c1'

rli1  e0 e2   'rl1*ll1/wl1*(1/3)*(1/nfl1)'
cli   e2 e1   'cap_li'

cli2b_0  e0 b  'c0_sub'
cli2b_1  e1 b  'c1_sub'

.ends xcmvpp11p5x11p7_m5shield

* 4-terminal Vertical Parallel Plate Capacitor /w LI-M4 fingers and Poly5 Shield (for S8P ONLY)
* Fixed layout is here:
* //depot/icm/proj/s8rf2/dev/opus/s8rf2/s8rf2_xcmvpp11p5x11p7_polym5shield

.subckt xcmvpp11p5x11p7_polym5shield c0 c1 b m5 mf=1
.param
+ctot_a   =  '141.23e-15*xcmvpp11p5x11p7_polym5shield_cor' 
+cm5_c0   =  '5.11e-15*c0m5m4_vpp'
+cm5_c1   =  '3.89e-15*c1m5m4_vpp'
+cpl2s    =  '(18.06e-15-2.14e-15)*cpl2s_vpp'
+rat_m4   =  0.1120
+rat_m3   =  0.1120
+rat_m2   =  0.2836
+rat_m1   =  0.2801
+rat_li   =  0.1863
+rat_li2p =  0.026
+cap_m4   =  'rat_m4*ctot_a' 
+cap_m3   =  'rat_m3*ctot_a' 
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 
+cap_li   =  'rat_li*ctot_a' 
+cap_li2p =  'rat_li2p*ctot_a' 

+ll1      =  5.070
+lm1      =  5.215
+lm2      =  5.095
+lm3      =  5.050
+lm4      =  4.910
+wl1      =  0.170
+wm1      =  0.140
+wm2      =  0.140
+wm3      =  0.300 
+wm4      =  0.300
+nfl1     =  62      
+nfm1     =  72      
+nfm2     =  72       
+nfm3     =  34
+nfm4     =  34
+nvia3_c0  = 103
+nvia3_c1  = 49
+nvia2_c0  = 104
+nvia2_c1  = 49
+nvia_c0  =  124      
+nvia_c1  =  62       
+ncon_c0  =  116
+ncon_c1  =  28 
+nlicon   =  126

cm5_0  m5 a0   'cm5_c0'
cm5_1  m5 a1   'cm5_c1'

rsm4  a0 a2   'rm4*lm4/wm4*(1/3)*(1/nfm4)'
cm4   a2 a1   'cap_m4'

rvia3_0 a0 b0   'rcvia3/nvia3_c0'
rvia3_1 a1 b1   'rcvia3/nvia3_c1'

rsm3   b0 b2   'rm3*lm3/wm3*(1/3)*(1/nfm3)'
cm3    b2 b1   'cap_m3'

rvia2_0 b0 c0   'rcvia2/nvia2_c0'
rvia2_1 b1 c1   'rcvia2/nvia2_c1'

rsm2   c0 c2   'rm2*lm2/wm2*(1/3)*(1/nfm2)'
cm2    c2 c1   'cap_m2'

rvia_0 c0 d0   'rcvia/nvia_c0'
rvia_1 c1 d1   'rcvia/nvia_c1'

rsm1   d0 d2   'rm1*lm1/wm1*(1/3)*(1/nfm1)'
cm1    d2 d1   'cap_m1'

rcon1 d0 e0   'rcl1/ncon_c0'
rcon2 d1 e1   'rcl1/ncon_c1'

rli1  e0 e2   'rl1*ll1/wl1*(1/3)*(1/nfl1)'
cli   e2 e1   'cap_li'

rlicon e0 f0  'rcp1/nlicon'
rpoly  f0 f2  'rp1'
cl12p  e1 f2  'cap_li2p'
cpl2b  f0 b   'cpl2s'

.ends xcmvpp11p5x11p7_polym5shield

* 4-terminal Vertical Parallel Plate Capacitor /w M1-M4 fingers and LI5 Shield (for S8P ONLY)
* Fixed layout is here:
* //depot/icm/proj/s8rf2/dev/opus/s8rf2/s8rf2_xcmvpp11p5x11p7_lim5shield

.subckt xcmvpp11p5x11p7_lim5shield c0 c1 b m5 mf=1
.param
+ctot_a   =  '116.75e-15*xcmvpp11p5x11p7_lim5shield_cor' 
+cm5_c0   =  '5.41e-15*c0m5m4_vpp'
+cm5_c1   =  '3.88e-15*c1m5m4_vpp'
+cli2s    =  '(7.59-0.58)*1e-15*cli2s_vpp'
+rat_m4   =  0.1376
+rat_m3   =  0.1376
+rat_m2   =  0.3485
+rat_m1   =  0.3442
+rat_m12li=  0.0321
+cap_m4   =  'rat_m4*ctot_a' 
+cap_m3   =  'rat_m3*ctot_a' 
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 
+cap_m12li=  'rat_m12li*ctot_a' 

+lm1      =  5.215
+lm2      =  5.095
+lm3      =  5.050
+lm4      =  4.910
+wm1      =  0.140
+wm2      =  0.140
+wm3      =  0.300 
+wm4      =  0.300
+nfm1     =  72      
+nfm2     =  72       
+nfm3     =  34
+nfm4     =  34
+nvia3_c0  = 103
+nvia3_c1  = 49
+nvia2_c0  = 104
+nvia2_c1  = 49
+nvia_c0  =  124      
+nvia_c1  =  62       
+nmcon    =  116

cm5_0  m5 a0   'cm5_c0'
cm5_1  m5 a1   'cm5_c1'

rsm4  a0 a2   'rm4*lm4/wm4*(1/3)*(1/nfm4)'
cm4   a2 a1   'cap_m4'

rvia3_0 a0 b0   'rcvia3/nvia3_c0'
rvia3_1 a1 b1   'rcvia3/nvia3_c1'

rsm3   b0 b2   'rm3*lm3/wm3*(1/3)*(1/nfm3)'
cm3    b2 b1   'cap_m3'

rvia2_0 b0 c0   'rcvia2/nvia2_c0'
rvia2_1 b1 c1   'rcvia2/nvia2_c1'

rsm2   c0 c2   'rm2*lm2/wm2*(1/3)*(1/nfm2)'
cm2    c2 c1   'cap_m2'

rvia_0 c0 d0   'rcvia/nvia_c0'
rvia_1 c1 d1   'rcvia/nvia_c1'

rsm1   d0 d2   'rm1*lm1/wm1*(1/3)*(1/nfm1)'
cm1    d2 d1   'cap_m1'

rmcon  d0 e0  'rcl1/nmcon'
rliw   e0 f0  'rl1'
cli2b  f0 b   'cli2s'
cm12li d1 f0  'cap_m12li'

.ends xcmvpp11p5x11p7_lim5shield


* 3-terminal Vertical Parallel Plate Capacitor /w M1-M4 fingers and No Shield (for S8P ONLY)
* Fixed layout is here:
* //depot/icm/proj/s8rf2/dev/opus/s8rf2/s8rf2_xcmvpp11p5x11p7_m1m4

.subckt xcmvpp11p5x11p7_m1m4 c0 c1 b mf=1 presim_flag=0
.param
+ctot_a   =  '110.19e-15*xcmvpp11p5x11p7_lim5shield_cor' 
+c02s     =  '(4.33 + presim_flag*0.54)*1e-15*cli2s_vpp'
+c12s     =  '1.87e-15*cli2s_vpp'
+rat_m4   =  0.1426
+rat_m3   =  0.1426
+rat_m2   =  0.3585
+rat_m1   =  0.3563
+cap_m4   =  'rat_m4*ctot_a' 
+cap_m3   =  'rat_m3*ctot_a' 
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 

+lm1      =  5.215
+lm2      =  5.095
+lm3      =  5.050
+lm4      =  4.910
+wm1      =  0.140
+wm2      =  0.140
+wm3      =  0.300 
+wm4      =  0.300
+nfm1     =  72      
+nfm2     =  72       
+nfm3     =  34
+nfm4     =  34
+nvia3_c0  = 103
+nvia3_c1  = 49
+nvia2_c0  = 104
+nvia2_c1  = 49
+nvia_c0  =  124      
+nvia_c1  =  62       

rsm4  a0 a2   'rm4*lm4/wm4*(1/3)*(1/nfm4)'
cm4   a2 a1   'cap_m4'

rvia3_0 a0 b0   'rcvia3/nvia3_c0'
rvia3_1 a1 b1   'rcvia3/nvia3_c1'

rsm3   b0 b2   'rm3*lm3/wm3*(1/3)*(1/nfm3)'
cm3    b2 b1   'cap_m3'

rvia2_0 b0 c0   'rcvia2/nvia2_c0'
rvia2_1 b1 c1   'rcvia2/nvia2_c1'

rsm2   c0 c2   'rm2*lm2/wm2*(1/3)*(1/nfm2)'
cm2    c2 c1   'cap_m2'

rvia_0 c0 d0   'rcvia/nvia_c0'
rvia_1 c1 d1   'rcvia/nvia_c1'

rsm1   d0 d2   'rm1*lm1/wm1*(1/3)*(1/nfm1)'
cm1    d2 d1   'cap_m1'

c0_sub  d0 b   'c02s'
c1_sub  d1 b   'c12s'

.ends xcmvpp11p5x11p7_m1m4


* 4-terminal Vertical Parallel Plate Capacitor /w M1-M4 fingers and M5 Shield (for S8P ONLY)
* Fixed layout is here:
* //depot/icm/proj/s8rf2/dev/opus/s8rf2/s8rf2_xcmvpp11p5x11p7_m1m4m5shield

.subckt xcmvpp11p5x11p7_m1m4m5shield c0 c1 b m5 mf=1 presim_flag=0
.param
+ctot_a   =  '108.40e-15*xcmvpp11p5x11p7_lim5shield_cor' 
+cm5_c0   =  '(5.04 + presim_flag*1.26)*1e-15*c0m5m4_vpp'
+cm5_c1   =  '3.88e-15*c1m5m4_vpp'
+c02s     =  '(3.69 + presim_flag*0.54)*1e-15*cli2s_vpp'
+c12s     =  '1.66e-15*cli2s_vpp'
+rat_m4   =  0.1426
+rat_m3   =  0.1426
+rat_m2   =  0.3585
+rat_m1   =  0.3563
+cap_m4   =  'rat_m4*ctot_a' 
+cap_m3   =  'rat_m3*ctot_a' 
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 

+lm1      =  5.215
+lm2      =  5.095
+lm3      =  5.050
+lm4      =  4.910
+wm1      =  0.140
+wm2      =  0.140
+wm3      =  0.300 
+wm4      =  0.300
+nfm1     =  72      
+nfm2     =  72       
+nfm3     =  34
+nfm4     =  34
+nvia3_c0  = 103
+nvia3_c1  = 49
+nvia2_c0  = 104
+nvia2_c1  = 49
+nvia_c0  =  124      
+nvia_c1  =  62       

cm5_0  m5 a0   'cm5_c0'
cm5_1  m5 a1   'cm5_c1'

rsm4  a0 a2   'rm4*lm4/wm4*(1/3)*(1/nfm4)'
cm4   a2 a1   'cap_m4'

rvia3_0 a0 b0   'rcvia3/nvia3_c0'
rvia3_1 a1 b1   'rcvia3/nvia3_c1'

rsm3   b0 b2   'rm3*lm3/wm3*(1/3)*(1/nfm3)'
cm3    b2 b1   'cap_m3'

rvia2_0 b0 c0   'rcvia2/nvia2_c0'
rvia2_1 b1 c1   'rcvia2/nvia2_c1'

rsm2   c0 c2   'rm2*lm2/wm2*(1/3)*(1/nfm2)'
cm2    c2 c1   'cap_m2'

rvia_0 c0 d0   'rcvia/nvia_c0'
rvia_1 c1 d1   'rcvia/nvia_c1'

rsm1   d0 d2   'rm1*lm1/wm1*(1/3)*(1/nfm1)'
cm1    d2 d1   'cap_m1'

c0_sub  d0 b   'c02s'
c1_sub  d1 b   'c12s'

.ends xcmvpp11p5x11p7_m1m4m5shield


* 3-terminal Vertical Parallel Plate Capacitor /w LI-M5 Shield (for S8P ONLY)
* This is the ~50fF fixed capacitor model
* Fixed layout is here:
* //depot/icm/proj/s8rf2/dev/opus/s8rf2/s8rf2_xcmvpp8p6x7p9_m3_lim5shield

.subckt xcmvpp8p6x7p9_m3_lim5shield c0 c1 b m5 mf=1
.param
+ctot_a   =  '42.11e-15*xcmvpp8p6x7p9_m3_lim5shield_cor' 
+cli2s    =  '(4.31-0.42)*1e-15*cli2s_vpp'   
+cm5_c0   =  '1.42e-15*c0m5m3_vpp'
+cm5_c1   =  '1.15e-15*c1m5m3_vpp'
+rat_m3   =  0.160 
+rat_m2   =  0.394 
+rat_m1   =  0.404 
+rat_m12li=  0.042
+cap_m3   =  'rat_m3*ctot_a' 
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 
+cap_m12li=  'rat_m12li*ctot_a' 

+lm3      =  3.125
+wm3      =  0.30
+nfm3     =  22     
+nvia2_c0 =  68    
+nvia2_c1 =  17     
+lm2      =  3.685
+wm2      =  0.140
+nfm2     =  48       
+nvia_c0  =  84      
+nvia_c1  =  42       
+lm1      =  3.290
+wm1      =  0.140
+nfm1     =  52      
+nmcon    =  84

cm5_0  m5 c0   'cm5_c0'
cm5_1  m5 c1   'cm5_c1'

rm31  c0 z1   'rm3*lm3/wm3*(1/3)*(1/nfm3)'
cm3   z1 c1   'cap_m3'

rvia2_1 c0 d0   'rcvia2/nvia2_c0'
rvia2_2 c1 d1   'rcvia2/nvia2_c1'

rm21  d0 a1   'rm2*lm2/wm2*(1/3)*(1/nfm2)'
cm2   a1 d1   'cap_m2'

rvia1 d0 e0   'rcvia/nvia_c0'
rvia2 d1 e1   'rcvia/nvia_c1'

rm11  e0 b1   'rm1*lm1/wm1*(1/3)*(1/nfm1)'
cm1   b1 e1   'cap_m1'

rmcon  e0 f0  'rcl1/nmcon'
rliw   f0 g0  'rl1'
cli2b  g0 b   'cli2s'
cm12li e1 g0  'cap_m12li'

.ends xcmvpp8p6x7p9_m3_lim5shield


* 3-terminal Vertical Parallel Plate Capacitor /w LI-M5 Shield (for S8P ONLY)
* This is the ~12fF fixed capacitor model
* Fixed layout is here:
* //depot/icm/proj/s8rf2/dev/opus/s8rf2/s8rf2_xcmvpp4p4x4p6_m3_lim5shield/layout

.subckt xcmvpp4p4x4p6_m3_lim5shield c0 c1 b m5 mf=1
.param
+ctot_a   =  '10.778e-15*xcmvpp4p4x4p6_m3_lishield_cor' 
+cli2s    =  '1.840e-15*cli2s_vpp'   
+rat_m3   =  0.1636 
+rat_m2   =  0.4604 
+rat_m1   =  0.3318 
+rat_m12li=  0.0442
+cap_m3   =  'rat_m3*ctot_a' 
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 
+cap_m12li=  'rat_m12li*ctot_a' 
+cm5_c0   =  '7.39e-16*c0m5m3_vpp'
+cm5_c1   =  '2.63e-16*c1m5m3_vpp'

+lm3      =  1.50
+wm3      =  0.30
+nfm3     =  10       
+nvia2_c0 =  32    
+nvia2_c1 =  13       
+lm2      =  1.585
+wm2      =  0.140
+nfm2     =  28       
+nvia_c0  =  40      
+nvia_c1  =  18       
+lm1      =  1.665
+wm1      =  0.140
+nfm1     =  20      
+nmcon    =  42

cm5_0  m5 c0   'cm5_c0'
cm5_1  m5 c1   'cm5_c1'

rm31  c0 z1   'rm3*lm3/wm3*(1/3)*(1/nfm3)'
cm3   z1 c1   'cap_m3'

rvia2_1 c0 d0   'rcvia2/nvia2_c0'
rvia2_2 c1 d1   'rcvia2/nvia2_c1'

rm21  d0 a1   'rm2*lm2/wm2*(1/3)*(1/nfm2)'
cm2   a1 d1   'cap_m2'

rvia1 d0 e0   'rcvia/nvia_c0'
rvia2 d1 e1   'rcvia/nvia_c1'

rm11  e0 b1   'rm1*lm1/wm1*(1/3)*(1/nfm1)'
cm1   b1 e1   'cap_m1'

rmcon  e0 f0  'rcl1/nmcon'
rliw   f0 g0  'rl1'
cli2b  g0 b   'cli2s'
cm12li e1 g0  'cap_m12li'

.ends xcmvpp4p4x4p6_m3_lim5shield


* 3-terminal Vertical Parallel Plate Capacitor /w LI-M5 Shield (for S8P ONLY)
* This is the ~100fF fixed capacitor model
* Fixed layout is here:
* //depot/icm/proj/s8rf2/dev/opus/s8rf2/s8rf2_xcmvpp11p5x11p7_m3_lim5shield/layout

.subckt xcmvpp11p5x11p7_m3_lim5shield c0 c1 b m5 mf=1
.param
+ctot_a   =  '97.328e-15*xcmvpp11p5x11p7_m3_lishield_cor' 
+cli2s    =  '7.433e-15*cli2s_vpp'   
+rat_m3   =  0.1539 
+rat_m2   =  0.4074 
+rat_m1   =  0.4025 
+rat_m12li=  0.0362
+cap_m3   =  'rat_m3*ctot_a' 
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 
+cap_m12li=  'rat_m12li*ctot_a' 
+cm5_c0   =  '3.20e-15*c0m5m3_vpp'
+cm5_c1   =  '1.97e-15*c1m5m3_vpp'

+lm3      =  5.05
+wm3      =  0.30
+nfm3     =  34     
+nvia2_c0 =  104   
+nvia2_c1 =  49     
+lm2      =  5.100
+wm2      =  0.140
+nfm2     =  76       
+nvia_c0  =  124      
+nvia_c1  =  62       
+lm1      =  5.215
+wm1      =  0.140
+nfm1     =  72      
+nmcon    =  116

cm5_0  m5 c0   'cm5_c0'
cm5_1  m5 c1   'cm5_c1'

rm31  c0 z1   'rm3*lm3/wm3*(1/3)*(1/nfm3)'
cm3   z1 c1   'cap_m3'

rvia2_1 c0 d0   'rcvia2/nvia2_c0'
rvia2_2 c1 d1   'rcvia2/nvia2_c1'

rm21  d0 a1   'rm2*lm2/wm2*(1/3)*(1/nfm2)'
cm2   a1 d1   'cap_m2'

rvia1 d0 e0   'rcvia/nvia_c0'
rvia2 d1 e1   'rcvia/nvia_c1'

rm11  e0 b1   'rm1*lm1/wm1*(1/3)*(1/nfm1)'
cm1   b1 e1   'cap_m1'

rmcon  e0 f0  'rcl1/nmcon'
rliw   f0 g0  'rl1'
cli2b  g0 b   'cli2s'
cm12li e1 g0  'cap_m12li'

.ends xcmvpp11p5x11p7_m3_lim5shield


* VPP over MOSCAP
.subckt xcmvppx4_2xnhvnative10x4 c0 c1 b m5 mf=1
.param
+ctot_a_toplevel   =  '48.188e-15*cvpp2_nhvnative10x4_cor' 
+cm5_c0_toplevel   =  '4.79e-15*c0m5m4_vpp'
+cm5_c1_toplevel   =  '5.02e-15*c1m5m4_vpp'
+rat_m3_toplevel   =  '0.5'
+rat_m4_toplevel   =  '0.5'
+cap_m3_toplevel   =  'rat_m3_toplevel*ctot_a_toplevel' 
+cap_m4_toplevel   =  'rat_m4_toplevel*ctot_a_toplevel' 

+lm3_toplevel      =  3.91
+lm4_toplevel      =  4.8
+wm3_toplevel      =  0.300 
+wm4_toplevel      =  0.300
+nfm3_toplevel     =  38
+nfm4_toplevel     =  30
+nvia3_c0_toplevel  = 43
+nvia3_c1_toplevel  = 96
+nvia2_c0_toplevel  = 43
+nvia2_c1_toplevel  = 44

cm5_0  m5 a0   'cm5_c0_toplevel'
cm5_1  m5 a1   'cm5_c1_toplevel'

rsm4  a0 a2   'rm4*lm4_toplevel/wm4_toplevel*(1/3)*(1/nfm4_toplevel)'
cm4   a2 a1   'cap_m4_toplevel'

rvia3_0 a0 b0   'rcvia3/nvia3_c0_toplevel'
rvia3_1 a1 b1   'rcvia3/nvia3_c1_toplevel'

rsm3   b0 b2   'rm3*lm3_toplevel/wm3_toplevel*(1/3)*(1/nfm3_toplevel)'
cm3    b2 b1   'cap_m3_toplevel'

rvia2_0 b0 c0   'rcvia2/nvia2_c0_toplevel'
rvia2_1 b1 c1   'rcvia2/nvia2_c1_toplevel'

.subckt xcmvpp2_nhvnative10x4_mod c0 c1 b mf=1
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

.ends xcmvpp2_nhvnative10x4_mod

.model vpp_nhvnative10x4 nmos
*
*DC IV MOS PARAMETERS
*
+lmin = 3.995e-06  lmax = 4.005e-06  wmin = 9.995e-06  wmax = 1.0005e-05
+level      =        54                          
+tnom       =        30                          
+version    =        4.5                         
+toxm       =        1.16e-008                   
+xj = 1.5e-007   
+lln        =        1                           
+lwn        =        1                           
+wln        =        1                           
+wwn        =        1                           
+lint       =        '6.93e-008+nhvnative_lint_diff' 
+ll         =        0                           
+lw         =        0                           
+lwl        =        0                           
+wint       =        '4.5e-008+nhvnative_wint_diff' 
+wl         =        0                           
+ww         =        0                           
+wwl        =        0                           
+xl         =        0                           
+xw         =        0                           
+mobmod     =        0                           
+binunit    =        2                           
+dwg = -4.6e-009   
+dwb = 1.92e-009   
*NEW BSIM4 Parameters(mfodel Selectors)
+igcmod     =        0                           
+igbmod     =        0                           
+rgatemod   =        0                           
+rbodymod   =        1                           
+trnqsmod   =        0                           
+acnqsmod   =        0                           
+fnoimod    =        1                           
+tnoimod    =        1                           
+permod     =        1                           
+geomod     =        0                           
+rdsmod     =        0                           
+tempmod    =        0                           
*******
*NEW BSIM4 Parameters(4.4 Version)
+lintnoi    =        0.0                           
+vfbsdoff   =        0                           
+lambda     =        0                           
+vtl        =        0                           
+lc         =        5e-009                      
+xn         =        3                           
+rnoia      =        0.8                       
+rnoib      =        0.38                      
+tnoia      =        7.6e6                         
+tnoib      =        7.2e6                         
*NEW BSIM4 Parameters(Process Parameters)
+epsrox     =        3.9                         
+toxe       =        '1.061*1.16e-008*nhvnative_toxe_mult'    
+dtox       =        0                           
+ndep = 1.7e+017   
+nsd = 1e+020   
+rshg       =        0.1                         
****
+rsh        =        '1*nhvnative_rshn_mult'     
*
* THRESHOLD VOLTAGE PARAMETERS
*
+vth0 = '0.06+nhvnative_vth0_diff_1'    
+k1 = 0.364   
+k2 = '0.043475+nhvnative_k2_diff_1'   
+k3 = 1.4   
+dvt0 = 5.7   
+dvt1 = 0.21851   
+dvt2 = 0.04   
+dvt0w = 7.7   
+dvt1w = 1272000   
+dvt2w = -0.032   
+w0 = 0   
+k3b = -0.58   
*NEW BSIM4 Parameters for Level 54
+phin = 0   
+lpe0 = -1.2362266e-014   
+lpeb = 0   
+vbm = -3   
+dvtp0 = 0   
+dvtp1 = 0   
*
* MOBILITY PARAMETERS
*
+vsat = '73076+nhvnative_vsat_diff_1'   
+ua = '8.4094e-010+nhvnative_ua_diff_1'   
+ub = '1.2348e-018+nhvnative_ub_diff_1'   
+uc = 2.9976e-011   
+rdsw = '430+nhvnative_rdsw_diff_1'   
+prwb = 0   
+prwg = 1e-012   
+wr = 1   
+u0 = '0.049769+nhvnative_u0_diff_1'   
+a0 = '0.0832+nhvnative_a0_diff_1'   
+keta = '-0.019904+nhvnative_keta_diff_1'   
+a1 = 0   
+a2 = 0.96293372   
+ags = '0.70396+nhvnative_ags_diff_1'   
+b0 = '3.3993e-007+nhvnative_b0_diff_1'   
+b1 = '0+nhvnative_b1_diff_1'   
*NEW BSIM4 Parameters(mfobility Parameters)
+eu         =        1.67                        
+rdswmin    =        0                           
+rdw = 0   
+rdwmin     =        0                           
+rsw = 0   
+rswmin     =        0                           
*****
*
* SUBTHRESHOLD CURRENT PARAMETERS
*
+voff = '0+nhvnative_voff_diff_1'    
+nfactor = '0.63313+nhvnative_nfactor_diff_1'    
+up = 0.0
+ud = 0.0
+lp = 1.0
+tvfbsdoff = 0.0
+tvoff = '0+nhvnative_tvoff_diff_1'
+cit = 9.2584123e-008   
+cdsc = 0   
+cdscb = 1.4150948e-007   
+cdscd = 1.5e-005   
+eta0 = '9+nhvnative_eta0_diff_1'   
+etab = -0.00021692   
+dsub = 0.42   
*NEW BSIM4 Parameters(Sub-threshold parameters)
+voffl = 1.9445332e-008   
+minv = 0   
*****
*
* ROUT PARAMETERS
*
+pclm = '0.11748+nhvnative_pclm_diff_1'   
+pdiblc1 = 8.833e-007   
+pdiblc2 = 0.0002   
+pdiblcb = 0   
+drout = 0.13139   
+pscbe1 = 2.4476e+008   
+pscbe2 = 3.84e-009   
+pvag = 4.5419436   
+delta = 0.007   
+alpha0 = 2.01e-006   
+alpha1 = 0.093632   
+beta0 = 19.448   
*NEW BSIM4 Parameters(ROUT Parameters)
+fprout = 0   
+pdits = '0.0068+nhvnative_pdits_diff_1'   
+pditsl     =        0                           
+pditsd = '0+nhvnative_pditsd_diff_1'   
****
*NEW BSIM4 Parameters(GATE INDUCED DRAIN LEAKAGE MODEL PARAMTERS)
+agidl = 0   
+bgidl = 2.3e+009   
+cgidl = 0.5   
+egidl = 0.8   
****
*NEW BSIM4 Parameters(Gate Leakage Current Parameters)
+aigbacc = 1   
+bigbacc = 0   
+cigbacc = 0   
+nigbacc = 1   
+aigbinv = 0.35   
+bigbinv = 0.03   
+cigbinv = 0.006   
+eigbinv = 1.1   
+nigbinv = 3   
+aigc = 0.43   
+bigc = 0.054   
+cigc = 0.075   
+nigc = 1   
+aigsd = 0.43   
+bigsd = 0.054   
+cigsd = 0.075   
+dlcig = 0   
+poxedge = 1   
+pigcd = 1   
+ntox = 1   
+toxref     =        1.16e-008                   
*****
*
* TEMPERATURE EFFECTS PARAMETERS
*
+kt1 = '-0.35858+nhvnative_kt1_diff_1'   
+kt2 = -0.016016   
+at = 22800   
+ute = -1.7861   
+ua1 = 4.4e-010   
+ub1 = -1.6252e-018   
+uc1 = -3.94e-011   
+kt1l = 0   
+prt = 0   
*NEW BSIM4 Parameters(HIGH SPEED RF MODEL PARAMETERS)
+xrcrg1 = 12   
+xrcrg2 = 1   
+rbpb       =        50                          
+rbpd       =        50                          
+rbps       =        50                          
+rbdb       =        50                          
+rbsb       =        50                          
+gbmin      =        1e-012                      
****
*NEW BSIM4 Parameters(FLICKER and THERMAL NOISE PARAMETERS)
+noia      =        2.5e+41                   
+noib      =        0.0                  
+noic      =         0.0                   
+em         =        4.1000000E+07                    
+af         =        1                           
+ef        =        1.0                           
+kf         =        0                           
+ntnoi      =        1                           
*****
*NEW BSIM4 Parameters(LAYOUT DEPENDENT PARASITIC MODEL PARAMETERS)
+dmcg       =        0                           
+dmcgt      =        0                           
+dmdg       =        0                           
+xgw        =        0                           
+xgl        =        0                           
+ngcon      =        1                           
****
*
*DIODE DC IV PARAMTERS
*
*NEW BSIM4 Parameters(DIODE DC IV parameters)
+diomod     =        1                           
+njs        =        1.5764                      
+jss        =        0.00042966                  
+jsws       =        8.040000000000001e-10       
+xtis       =        0                           
+bvs        =        12.69                       
+xjbvs      =        1                           
+ijthsrev   =        0.1                         
+ijthsfwd   =        0.1                         
*
* DIODE and FET CAPACITANCE PARAMETERS
*
+tpb        =        0.0019685                   
+tpbsw      =        0.001                       
+tpbswg     =        0                           
+tcj        =        0.00083                     
+tcjsw      =        0                           
+tcjswg     =        0                           
+cgdo       =        '3.473e-010*nhvnative_overlap_mult'   
+cgso       =        '3.473e-010*nhvnative_overlap_mult'   
+cgbo       =        0                           
+capmod     =        2                           
+xpart      =        0                           
+cgsl       =        '5e-011*nhvnative_overlap_mult'   
+cgdl       =        '5e-011*nhvnative_overlap_mult'   
+cf         =        0                           
+clc        =        1e-007                      
+cle        =        0.6                         
+dlc        =        '7.6493e-008+nhvnative_dlc_diff+nhvnative_dlc_rotweak'   
+dwc        =        '0+nhvnative_dwc_diff'      
+vfbcv      =        -1                          
+acde       =        1.16                        
+moin       =        15                          
+noff       =        4                           
+voffcv     =        0.216                       
+ngate      =        1e+023                      
+lwc        =        0                           
+llc        =        0                           
+lwlc       =        0                           
+wlc        =        0                           
+wwc        =        0                           
+wwlc       =        0                           
*NEW BSIM4 Parameters(FET and DIODE capacitance parameters)
+ckappas    =        0.6                         
+cjs        =        '0.0008602*nhvnative_ajunction_mult'   
+mjs        =        0.28329                     
+pbs        =        0.66345                     
+cjsws      =        '8.5152e-011*nhvnative_pjunction_mult'   
+mjsws      =        0.057926                    
+pbsws      =        1                           
+cjswgs     =        '3.58e-011*nhvnative_pjunction_mult'   
+mjswgs     =        0.33                        
+pbswgs     =        0.2442                      
* 
*STRESS PARAMETERS 
* 
+saref   = 3.0e-06
+sbref   = 3.0e-06
+wlod    = '0+nhvnative_wlod_diff'
+kvth0   = '0+nhvnative_kvth0_diff'
+lkvth0  = '0+nhvnative_lkvth0_diff'
+wkvth0  = '0+nhvnative_wkvth0_diff'
+pkvth0  = 0
+llodvth = 0
+wlodvth  = 1
+stk2    = 0
+lodk2   = 1
+lodeta0 = 1
+ku0     = '0+nhvnative_ku0_diff'
+lku0    = '0+nhvnative_lku0_diff'
+wku0    = '0+nhvnative_wku0_diff'
+pku0    = 0
+llodku0 = 0
+wlodku0  = 1
+kvsat   = '0+nhvnative_kvsat_diff'
+steta0  = 0
+tku0    = 0
******

xvpp c0 c1 c1 xcmvpp2_nhvnative10x4_mod m=4
mvpp c1 c0 c1 c1 vpp_nhvnative10x4 w=10 l=4 ad=3.15 as=4.75 pd=10.63 ps=20.95 m=2

.ends xcmvppx4_2xnhvnative10x4

* 4-terminal Vertical Parallel Plate Capacitor /w LI-M4 fingers and Poly5 Shield (for S8P ONLY)
* Fixed layout is here:
* //depot/icm/proj/s8rf2/dev/opus/s8rf2/s8rf2_xcmvpp11p5x11p7_polym50p4shield

.subckt xcmvpp11p5x11p7_polym50p4shield c0 c1 b m5 mf=1 presim_flag=0
.param
+ctot_a   =  '141.23e-15*xcmvpp11p5x11p7_polym5shield_cor' 
+cm5_c0   =  '((2.074e-15)*c0m5m4_vpp0p4shield+(2.916e-15*presim_flag))'
+cm5_c1   =  '((3.67e-15)*c1m5m4_vpp0p4shield)'
+cpl2s    =  '((15.22e-15)*cpl2s_vpp0p4shield+(2.84e-15*presim_flag))'
+rat_m4   =  0.1120
+rat_m3   =  0.1120
+rat_m2   =  0.2836
+rat_m1   =  0.2801
+rat_li   =  0.1863
+rat_li2p =  0.026
+cap_m4   =  'rat_m4*ctot_a' 
+cap_m3   =  'rat_m3*ctot_a' 
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 
+cap_li   =  'rat_li*ctot_a' 
+cap_li2p =  'rat_li2p*ctot_a' 

+ll1      =  5.070
+lm1      =  5.215
+lm2      =  5.095
+lm3      =  5.050
+lm4      =  4.910
+wl1      =  0.170
+wm1      =  0.140
+wm2      =  0.140
+wm3      =  0.300 
+wm4      =  0.300
+nfl1     =  62      
+nfm1     =  72      
+nfm2     =  72       
+nfm3     =  34
+nfm4     =  34
+nvia3_c0  = 103
+nvia3_c1  = 49
+nvia2_c0  = 104
+nvia2_c1  = 49
+nvia_c0  =  124      
+nvia_c1  =  62       
+ncon_c0  =  116
+ncon_c1  =  28 
+nlicon   =  126

cm5_0  m5 a0   'cm5_c0'
cm5_1  m5 a1   'cm5_c1'

rsm4  a0 a2   'rm4*lm4/wm4*(1/3)*(1/nfm4)'
cm4   a2 a1   'cap_m4'

rvia3_0 a0 b0   'rcvia3/nvia3_c0'
rvia3_1 a1 b1   'rcvia3/nvia3_c1'

rsm3   b0 b2   'rm3*lm3/wm3*(1/3)*(1/nfm3)'
cm3    b2 b1   'cap_m3'

rvia2_0 b0 c0   'rcvia2/nvia2_c0'
rvia2_1 b1 c1   'rcvia2/nvia2_c1'

rsm2   c0 c2   'rm2*lm2/wm2*(1/3)*(1/nfm2)'
cm2    c2 c1   'cap_m2'

rvia_0 c0 d0   'rcvia/nvia_c0'
rvia_1 c1 d1   'rcvia/nvia_c1'

rsm1   d0 d2   'rm1*lm1/wm1*(1/3)*(1/nfm1)'
cm1    d2 d1   'cap_m1'

rcon1 d0 e0   'rcl1/ncon_c0'
rcon2 d1 e1   'rcl1/ncon_c1'

rli1  e0 e2   'rl1*ll1/wl1*(1/3)*(1/nfl1)'
cli   e2 e1   'cap_li'

rlicon e0 f0  'rcp1/nlicon'
rpoly  f0 f2  'rp1'
cl12p  e1 f2  'cap_li2p'
cpl2b  f0 b   'cpl2s'

.ends xcmvpp11p5x11p7_polym50p4shield

* High Density 3-terminal Vertical Parallel Plate Capacitor (for S8P ONLY)
* Fixed layout is here:
* //depot/icm/proj/s8rf2/dev/opus/s8rf2/s8rf2_xcmvpp_hd5_atlas_fingercap2_l5

.subckt xcmvpp_hd5_atlas_fingercap2_l5 c0 c1 b mf=1
.param
+ctot_a   =  '12.65e-15*xcmvpp_atlas_cor' 
+c0_sub   =  '1.225e-15*cli2s_vpp'
+c1_sub   =  '0.712e-15*cli2s_vpp'
+rat_m4   =  0.125
+rat_m3   =  0.125
+rat_m2   =  0.375
+rat_m1   =  0.375
+cap_m4   =  'rat_m4*ctot_a' 
+cap_m3   =  'rat_m3*ctot_a' 
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 

+lm1      = '6.1-0.96' 
+lm2      = '6.1-0.96' 
+lm3      = '6.1-0.96'
+lm4      = '6.1-0.96'
+wm1      =  0.160
+wm2      =  0.160
+wm3      =  0.300 
+wm4      =  0.300
+nfm1     =  9
+nfm2     =  9
+nfm3     =  5
+nfm4     =  5
+nvia3    =  5
+nvia2    =  5
+nvia     =  5

rsm4  a0 a2   'rm4*lm4/wm4*(1/3)*(1/nfm4)'
cm4   a2 a1   'cap_m4'

rvia3_0 a0 b0   'rcvia3/nvia3'
rvia3_1 a1 b1   'rcvia3/nvia3'

rsm3   b0 b2   'rm3*lm3/wm3*(1/3)*(1/nfm3)'
cm3    b2 b1   'cap_m3'

rvia2_0 b0 c0   'rcvia2/nvia2'
rvia2_1 b1 c1   'rcvia2/nvia2'

rsm2   c0 c2   '(rm2*lm2/wm2*(1/3)*(1/nfm2)+rm2*lm2/wm2)'
cm2    c2 c1   'cap_m2'

rvia_0 c0 d0   'rcvia/nvia'
rvia_1 c1 d1   'rcvia/nvia'

rsm1   d0 d2   'rm1*lm1/wm1*(1/3)*(1/nfm1)'
cm1    d2 d1   'cap_m1'

cm12b_0  d0 b  'c0_sub'
cm12b_1  d1 b  'c1_sub'

.ends xcmvpp_hd5_atlas_fingercap2_l5

* High Density 3-terminal Vertical Parallel Plate Capacitor (for S8P ONLY)
* Fixed layout is here:
* //depot/icm/proj/s8rf2/dev/opus/s8rf2/s8rf2_xcmvpp_hd5_atlas_fingercap_l10

.subckt xcmvpp_hd5_atlas_fingercap_l10 c0 c1 b mf=1
.param
+ctot_a   =  '23.35e-15*xcmvpp_atlas_cor' 
+c0_sub   =  '1.506e-15*cli2s_vpp'
+c1_sub   =  '1.075e-15*cli2s_vpp'
+rat_m4   =  0.125
+rat_m3   =  0.125
+rat_m2   =  0.375
+rat_m1   =  0.375
+cap_m4   =  'rat_m4*ctot_a' 
+cap_m3   =  'rat_m3*ctot_a' 
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 

+lm1      = '11.1-0.96' 
+lm2      = '11.1-0.96' 
+lm3      = '11.1-0.96'
+lm4      = '11.1-0.96'
+wm1      =  0.160
+wm2      =  0.160
+wm3      =  0.300 
+wm4      =  0.300
+nfm1     =  9
+nfm2     =  9
+nfm3     =  5
+nfm4     =  5
+nvia3    =  5
+nvia2    =  5
+nvia     =  5

rsm4  a0 a2   'rm4*lm4/wm4*(1/3)*(1/nfm4)'
cm4   a2 a1   'cap_m4'

rvia3_0 a0 b0   'rcvia3/nvia3'
rvia3_1 a1 b1   'rcvia3/nvia3'

rsm3   b0 b2   'rm3*lm3/wm3*(1/3)*(1/nfm3)'
cm3    b2 b1   'cap_m3'

rvia2_0 b0 c0   'rcvia2/nvia2'
rvia2_1 b1 c1   'rcvia2/nvia2'

rsm2   c0 c2   '(rm2*lm2/wm2*(1/3)*(1/nfm2)+rm2*lm2/wm2)'
cm2    c2 c1   'cap_m2'

rvia_0 c0 d0   'rcvia/nvia'
rvia_1 c1 d1   'rcvia/nvia'

rsm1   d0 d2   'rm1*lm1/wm1*(1/3)*(1/nfm1)'
cm1    d2 d1   'cap_m1'

cm12b_0  d0 b  'c0_sub'
cm12b_1  d1 b  'c1_sub'

.ends xcmvpp_hd5_atlas_fingercap_l10

* High Density 3-terminal Vertical Parallel Plate Capacitor (for S8P ONLY)
* Fixed layout is here:
* //depot/icm/proj/s8rf2/dev/opus/s8rf2/s8rf2_xcmvpp_hd5_atlas_fingercap_l20

.subckt xcmvpp_hd5_atlas_fingercap_l20 c0 c1 b mf=1
.param
+ctot_a   =  '45.83e-15*xcmvpp_atlas_cor' 
+c0_sub   =  '2.489e-15*cli2s_vpp'
+c1_sub   =  '1.823e-15*cli2s_vpp'
+rat_m4   =  0.125
+rat_m3   =  0.125
+rat_m2   =  0.375
+rat_m1   =  0.375
+cap_m4   =  'rat_m4*ctot_a' 
+cap_m3   =  'rat_m3*ctot_a' 
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 

+lm1      = '21.1-0.96' 
+lm2      = '21.1-0.96' 
+lm3      = '21.1-0.96'
+lm4      = '21.1-0.96'
+wm1      =  0.160
+wm2      =  0.160
+wm3      =  0.300 
+wm4      =  0.300
+nfm1     =  9
+nfm2     =  9
+nfm3     =  5
+nfm4     =  5
+nvia3    =  5
+nvia2    =  5
+nvia     =  5

rsm4  a0 a2   'rm4*lm4/wm4*(1/3)*(1/nfm4)'
cm4   a2 a1   'cap_m4'

rvia3_0 a0 b0   'rcvia3/nvia3'
rvia3_1 a1 b1   'rcvia3/nvia3'

rsm3   b0 b2   'rm3*lm3/wm3*(1/3)*(1/nfm3)'
cm3    b2 b1   'cap_m3'

rvia2_0 b0 c0   'rcvia2/nvia2'
rvia2_1 b1 c1   'rcvia2/nvia2'

rsm2   c0 c2   '(rm2*lm2/wm2*(1/3)*(1/nfm2)+rm2*lm2/wm2)'
cm2    c2 c1   'cap_m2'

rvia_0 c0 d0   'rcvia/nvia'
rvia_1 c1 d1   'rcvia/nvia'

rsm1   d0 d2   'rm1*lm1/wm1*(1/3)*(1/nfm1)'
cm1    d2 d1   'cap_m1'

cm12b_0  d0 b  'c0_sub'
cm12b_1  d1 b  'c1_sub'

.ends xcmvpp_hd5_atlas_fingercap_l20

* High Density 3-terminal Vertical Parallel Plate Capacitor (for S8P ONLY)
* Fixed layout is here:
* //depot/icm/proj/s8rf2/dev/opus/s8rf2/s8rf2_xcmvpp_hd5_atlas_fingercap_l40

.subckt xcmvpp_hd5_atlas_fingercap_l40 c0 c1 b mf=1
.param
+ctot_a   =  '91.27e-15*xcmvpp_atlas_cor' 
+c0_sub   =  '4.434e-15*cli2s_vpp'
+c1_sub   =  '3.315e-15*cli2s_vpp'
+rat_m4   =  0.125
+rat_m3   =  0.125
+rat_m2   =  0.375
+rat_m1   =  0.375
+cap_m4   =  'rat_m4*ctot_a' 
+cap_m3   =  'rat_m3*ctot_a' 
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 

+lm1      = '41.1-0.96' 
+lm2      = '41.1-0.96' 
+lm3      = '41.1-0.96'
+lm4      = '41.1-0.96'
+wm1      =  0.160
+wm2      =  0.160
+wm3      =  0.300 
+wm4      =  0.300
+nfm1     =  9
+nfm2     =  9
+nfm3     =  5
+nfm4     =  5
+nvia3    =  5
+nvia2    =  5
+nvia     =  5

rsm4  a0 a2   'rm4*lm4/wm4*(1/3)*(1/nfm4)'
cm4   a2 a1   'cap_m4'

rvia3_0 a0 b0   'rcvia3/nvia3'
rvia3_1 a1 b1   'rcvia3/nvia3'

rsm3   b0 b2   'rm3*lm3/wm3*(1/3)*(1/nfm3)'
cm3    b2 b1   'cap_m3'

rvia2_0 b0 c0   'rcvia2/nvia2'
rvia2_1 b1 c1   'rcvia2/nvia2'

rsm2   c0 c2   '(rm2*lm2/wm2*(1/3)*(1/nfm2)+rm2*lm2/wm2)'
cm2    c2 c1   'cap_m2'

rvia_0 c0 d0   'rcvia/nvia'
rvia_1 c1 d1   'rcvia/nvia'

rsm1   d0 d2   'rm1*lm1/wm1*(1/3)*(1/nfm1)'
cm1    d2 d1   'cap_m1'

cm12b_0  d0 b  'c0_sub'
cm12b_1  d1 b  'c1_sub'

.ends xcmvpp_hd5_atlas_fingercap_l40

* High Density 3-terminal Vertical Parallel Plate Capacitor (for S8P ONLY)
* Fixed layout is here:
* //depot/icm/proj/s8rf2/dev/opus/s8rf2/s8rf2_xcmvpp_hd5_atlas_fingercap_l5

.subckt xcmvpp_hd5_atlas_fingercap_l5 c0 c1 b mf=1
.param
+ctot_a   =  '12.13e-15*xcmvpp_atlas_cor' 
+c0_sub   =  '0.998e-15*cli2s_vpp'
+c1_sub   =  '0.701e-15*cli2s_vpp'
+rat_m4   =  0.125
+rat_m3   =  0.125
+rat_m2   =  0.375
+rat_m1   =  0.375
+cap_m4   =  'rat_m4*ctot_a' 
+cap_m3   =  'rat_m3*ctot_a' 
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 

+lm1      = '6.1-0.96' 
+lm2      = '6.1-0.96' 
+lm3      = '6.1-0.96'
+lm4      = '6.1-0.96'
+wm1      =  0.160
+wm2      =  0.160
+wm3      =  0.300 
+wm4      =  0.300
+nfm1     =  9
+nfm2     =  9
+nfm3     =  5
+nfm4     =  5
+nvia3    =  5
+nvia2    =  5
+nvia     =  5

rsm4  a0 a2   'rm4*lm4/wm4*(1/3)*(1/nfm4)'
cm4   a2 a1   'cap_m4'

rvia3_0 a0 b0   'rcvia3/nvia3'
rvia3_1 a1 b1   'rcvia3/nvia3'

rsm3   b0 b2   'rm3*lm3/wm3*(1/3)*(1/nfm3)'
cm3    b2 b1   'cap_m3'

rvia2_0 b0 c0   'rcvia2/nvia2'
rvia2_1 b1 c1   'rcvia2/nvia2'

rsm2   c0 c2   '(rm2*lm2/wm2*(1/3)*(1/nfm2)+rm2*lm2/wm2)'
cm2    c2 c1   'cap_m2'

rvia_0 c0 d0   'rcvia/nvia'
rvia_1 c1 d1   'rcvia/nvia'

rsm1   d0 d2   'rm1*lm1/wm1*(1/3)*(1/nfm1)'
cm1    d2 d1   'cap_m1'

cm12b_0  d0 b  'c0_sub'
cm12b_1  d1 b  'c1_sub'

.ends xcmvpp_hd5_atlas_fingercap_l5

* High Density 3-terminal Vertical Parallel Plate Capacitor (for S8P ONLY)
* Fixed layout is here:
* //depot/icm/proj/s8rf2/dev/opus/s8rf2/s8rf2_xcmvpp_hd5_atlas_wafflecap1

.subckt xcmvpp_hd5_atlas_wafflecap1 c0 c1 b mf=1
.param
+ctot_a   =  '110.41e-15*xcmvpp_atlas_cor' 
+c0_sub   =  '5.993e-15*cli2s_vpp'
+c1_sub   =  '2.615e-15*cli2s_vpp'
+rat_m4   =  0.125
+rat_m3   =  0.125
+rat_m2   =  0.375
+rat_m1   =  0.375
+cap_m4   =  'rat_m4*ctot_a' 
+cap_m3   =  'rat_m3*ctot_a' 
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 

+lm1      = '11.33-0.96' 
+lm2      = '11.33-0.96' 
+lm3      = '11.33-0.96'
+lm4      = '11.33-0.96'
+wm1      =  0.160
+wm2      =  0.160
+wm3      =  0.300 
+wm4      =  0.300
+nfm1     =  9
+nfm2     =  9
+nfm3     =  5
+nfm4     =  5
+nvia3    =  5
+nvia2    =  5
+nvia     =  5

rsm4  a0 a2   'rm4*lm4/wm4*(1/3)*(1/nfm4)'
cm4   a2 a1   'cap_m4'

rvia3_0 a0 b0   'rcvia3/nvia3'
rvia3_1 a1 b1   'rcvia3/nvia3'

rsm3   b0 b2   'rm3*lm3/wm3*(1/3)*(1/nfm3)'
cm3    b2 b1   'cap_m3'

rvia2_0 b0 c0   'rcvia2/nvia2'
rvia2_1 b1 c1   'rcvia2/nvia2'

rsm2   c0 c2   '(rm2*lm2/wm2*(1/3)*(1/nfm2)+rm2*lm2/wm2)'
cm2    c2 c1   'cap_m2'

rvia_0 c0 d0   'rcvia/nvia'
rvia_1 c1 d1   'rcvia/nvia'

rsm1   d0 d2   'rm1*lm1/wm1*(1/3)*(1/nfm1)'
cm1    d2 d1   'cap_m1'

cm12b_0  d0 b  'c0_sub'
cm12b_1  d1 b  'c1_sub'

.ends xcmvpp_hd5_atlas_wafflecap1

* High Density 3-terminal Vertical Parallel Plate Capacitor (for S8P ONLY)
* Fixed layout is here:
* //depot/icm/proj/s8rf2/dev/opus/s8rf2/s8rf2_xcmvpp_hd5_atlas_wafflecap2

.subckt xcmvpp_hd5_atlas_wafflecap2 c0 c1 b mf=1
.param
+ctot_a   =  '27.78e-15*xcmvpp_atlas_cor' 
+c0_sub   =  '1.76e-15*cli2s_vpp'
+c1_sub   =  '1.447e-15*cli2s_vpp'
+rat_m4   =  0.125
+rat_m3   =  0.125
+rat_m2   =  0.375
+rat_m1   =  0.375
+cap_m4   =  'rat_m4*ctot_a' 
+cap_m3   =  'rat_m3*ctot_a' 
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 

+lm1      = '5.9-0.96' 
+lm2      = '5.9-0.96' 
+lm3      = '5.9-0.96'
+lm4      = '5.9-0.96'
+wm1      =  0.160
+wm2      =  0.160
+wm3      =  0.300 
+wm4      =  0.300
+nfm1     =  9
+nfm2     =  9
+nfm3     =  5
+nfm4     =  5
+nvia3    =  5
+nvia2    =  5
+nvia     =  5

rsm4  a0 a2   'rm4*lm4/wm4*(1/3)*(1/nfm4)'
cm4   a2 a1   'cap_m4'

rvia3_0 a0 b0   'rcvia3/nvia3'
rvia3_1 a1 b1   'rcvia3/nvia3'

rsm3   b0 b2   'rm3*lm3/wm3*(1/3)*(1/nfm3)'
cm3    b2 b1   'cap_m3'

rvia2_0 b0 c0   'rcvia2/nvia2'
rvia2_1 b1 c1   'rcvia2/nvia2'

rsm2   c0 c2   '(rm2*lm2/wm2*(1/3)*(1/nfm2)+rm2*lm2/wm2)'
cm2    c2 c1   'cap_m2'

rvia_0 c0 d0   'rcvia/nvia'
rvia_1 c1 d1   'rcvia/nvia'

rsm1   d0 d2   'rm1*lm1/wm1*(1/3)*(1/nfm1)'
cm1    d2 d1   'cap_m1'

cm12b_0  d0 b  'c0_sub'
cm12b_1  d1 b  'c1_sub'

.ends xcmvpp_hd5_atlas_wafflecap2

* 3-terminal Vertical Parallel Plate Capacitor /w M1-M4 fingers and No Shield (for S8P ONLY)
* Fixed layout is here:
* //depot/icm/proj/s8rf2/dev/opus/s8rf2/s8rf2_xcmvpp_hd5_6p8x6p1_m1m4

.subckt xcmvpp_hd5_6p8x6p1_m1m4 c0 c1 b mf=1 presim_flag=0
.param
+ctot_a   =  '30.80e-15*xcmvpp6p8x6p1_cor' 
+c02s     =  '(1.803 + presim_flag*0.305)*1e-15*cli2s_vpp'
+c12s     =  '0.50e-15*cli2s_vpp'
+rat_m4   =  0.1426
+rat_m3   =  0.1426
+rat_m2   =  0.3585
+rat_m1   =  0.3563
+cap_m4   =  'rat_m4*ctot_a' 
+cap_m3   =  'rat_m3*ctot_a' 
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 

+lm1      =  2.42
+lm2      =  2.77
+lm3      =  2.25
+lm4      =  2.25
+wm1      =  0.14
+wm2      =  0.14
+wm3      =  0.3
+wm4      =  0.3
+nfm1     =  42
+nfm2     =  38
+nfm3     =  22
+nfm4     =  22
+nvia3_c0  = 48
+nvia3_c1  = 23
+nvia2_c0  = 48
+nvia2_c1  = 23
+nvia_c0  =  60
+nvia_c1  =  32

rsm4  a0 a2   'rm4*lm4/wm4*(1/3)*(1/nfm4)'
cm4   a2 a1   'cap_m4'

rvia3_0 a0 b0   'rcvia3/nvia3_c0'
rvia3_1 a1 b1   'rcvia3/nvia3_c1'

rsm3   b0 b2   'rm3*lm3/wm3*(1/3)*(1/nfm3)'
cm3    b2 b1   'cap_m3'

rvia2_0 b0 c0   'rcvia2/nvia2_c0'
rvia2_1 b1 c1   'rcvia2/nvia2_c1'

rsm2   c0 c2   'rm2*lm2/wm2*(1/3)*(1/nfm2)'
cm2    c2 c1   'cap_m2'

rvia_0 c0 d0   'rcvia/nvia_c0'
rvia_1 c1 d1   'rcvia/nvia_c1'

rsm1   d0 d2   'rm1*lm1/wm1*(1/3)*(1/nfm1)'
cm1    d2 d1   'cap_m1'

c0_sub  d0 b   'c02s'
c1_sub  d1 b   'c12s'

.ends xcmvpp_hd5_6p8x6p1_m1m4
* High Density 3-terminal Vertical Parallel Plate Capacitor (for S8P ONLY)
* Fixed layout is here:
* //depot/icm/proj/s8rf2/dev/opus/s8rf2/s8rf2_xcmvpp_hd5_4x2

.subckt xcmvpp_hd5_4x2 c0 c1 b mf=1
.param
+ctot_a   =  '1.47e-12*xcmvpp_hd5_cor' 
+c0_sub   =  '5.17e-14*cli2s_vpp'
+c1_sub   =  '4.86e-14*cli2s_vpp'
+rat_m5   =  0.026
+rat_m4   =  0.1
+rat_m3   =  0.1
+rat_m2   =  0.259
+rat_m1   =  0.259
+rat_li   =  0.18
+rat_py   =  0.076
+cap_m5   =  'rat_m5*ctot_a' 
+cap_m4   =  'rat_m4*ctot_a' 
+cap_m3   =  'rat_m3*ctot_a' 
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 
+cap_li   =  'rat_li*ctot_a' 
+cap_py   =  'rat_py*ctot_a' 

+lpy      =  '23.05-2*0.33-0.21'
+ll1      =  '23.05-2*0.33-0.21'
+lm1      =  '23.05-2*0.33-0.21'
+lm2      =  '23.05-2*0.33-0.21'
+lm3      =  '23.05-2*0.33-0.21'
+lm4      =  '23.05-2*0.33-0.21'
+lm5      =  '23.05-3*1.6'
+wpy      =  0.150
+wl1      =  0.140
+wm1      =  0.140
+wm2      =  0.140
+wm3      =  0.300 
+wm4      =  0.300
+wm5      =  1.60
+nfpy     =  '32.28*4'      
+nfl1     =  '41.25*4'
+nfm1     =  '41.25*4'
+nfm2     =  '41.25*4'
+nfm3     =  '19.52*4'
+nfm4     =  '19.52*4'
+nfm5     =  '4.07*4'
+nvia4    =  2 
+nvia3    =  '28*4'
+nvia2    =  '10*4'
+nvia     =  '20*4'
+ncon     =  '31*4'
+nlicon   =  '33*4'

rsm5  z0 z2   'rm5*lm5/wm5*(1/3)*(1/nfm5)'
cm5   z2 z1   'cap_m5'

rvia4_0 z0 a0   'rcvia4/nvia4'
rvia4_1 z1 a1   'rcvia4/nvia4'

rsm4  a0 a2   'rm4*lm4/wm4*(1/3)*(1/nfm4)'
cm4   a2 a1   'cap_m4'

rvia3_0 a0 b0   'rcvia3/nvia3'
rvia3_1 a1 b1   'rcvia3/nvia3'

rsm3   b0 b2   'rm3*lm3/wm3*(1/3)*(1/nfm3)'
cm3    b2 b1   'cap_m3'

rvia2_0 b0 c0   'rcvia2/nvia2'
rvia2_1 b1 c1   'rcvia2/nvia2'

rsm2   c0 c2   '(rm2*lm2/wm2*(1/3)*(1/nfm2)+rm2*lm2/wm2)'
cm2    c2 c1   'cap_m2'

rvia_0 c0 d0   'rcvia/nvia'
rvia_1 c1 d1   'rcvia/nvia'

rsm1   d0 d2   'rm1*lm1/wm1*(1/3)*(1/nfm1)'
cm1    d2 d1   'cap_m1'

rcon1 d0 e0   'rcl1/ncon'
rcon2 d1 e1   'rcl1/ncon'

rli1  e0 e2   'rl1*ll1/wl1*(1/3)*(1/nfl1)'
cli   e2 e1   'cap_li'

rlicon1 e0 f0   'rcp1/nlicon'
rlicon2 e1 f1   'rcp1/nlicon'

rpy1  f0 f2   'rp1*lpy/wpy*(1/3)*(1/nfpy)'
cpy   f2 f1   'cap_py'

cpy2b_0  f0 b  'c0_sub'
cpy2b_1  f1 b  'c1_sub'

.ends xcmvpp_hd5_4x2
