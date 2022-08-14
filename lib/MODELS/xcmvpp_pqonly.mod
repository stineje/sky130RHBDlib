* 3-terminal Vertical Parallel Plate Capacitor /w LI Shield (for S8Q/S8P ONLY)
* This is the ~50fF fixed capacitor model
* Fixed layout is here:
* /proj/tlib/s8rf/golden/s8rf/opus/s8rf/s8rf_xcmvpp8p6x7p9_m3_lishield/layout

.subckt xcmvpp8p6x7p9_m3_lishield c0 c1 b mf=1
.param
+ctot_a   =  '42.752e-15*xcmvpp8p6x7p9_m3_lishield_cor' 
+cli2s    =  '4.241e-15*cli2s_vpp'   
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

.ends xcmvpp8p6x7p9_m3_lishield


* 3-terminal Vertical Parallel Plate Capacitor /w LI Shield (for S8Q/S8P ONLY)
* This is the ~12fF fixed capacitor model
* Fixed layout is here:
* /proj/tlib/s8rf/golden/s8rf/opus/s8rf/s8rf_xcmvpp4p4x4p6_m3_lishield/layout

.subckt xcmvpp4p4x4p6_m3_lishield c0 c1 b mf=1
.param
+ctot_a   =  '10.694e-15*xcmvpp4p4x4p6_m3_lishield_cor' 
+cli2s    =  '1.840e-15*cli2s_vpp'   
+rat_m3   =  0.1636 
+rat_m2   =  0.4604 
+rat_m1   =  0.3318 
+rat_m12li=  0.0442
+cap_m3   =  'rat_m3*ctot_a' 
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 
+cap_m12li=  'rat_m12li*ctot_a' 

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

.ends xcmvpp4p4x4p6_m3_lishield


* 3-terminal Vertical Parallel Plate Capacitor /w LI Shield (for S8Q/S8P ONLY)
* This is the ~115fF fixed capacitor model
* Fixed layout is here:
* /proj/tlib/s8rf/golden/s8rf/opus/s8rf/s8rf_xcmvpp11p5x11p7_m3_lishield/layout

.subckt xcmvpp11p5x11p7_m3_lishield c0 c1 b mf=1
.param
+ctot_a   =  '96.986e-15*xcmvpp11p5x11p7_m3_lishield_cor' 
+cli2s    =  '7.433e-15*cli2s_vpp'   
+rat_m3   =  0.1539 
+rat_m2   =  0.4074 
+rat_m1   =  0.4025 
+rat_m12li=  0.0362
+cap_m3   =  'rat_m3*ctot_a' 
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 
+cap_m12li=  'rat_m12li*ctot_a' 

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

.ends xcmvpp11p5x11p7_m3_lishield


* 4-terminal Vertical Parallel Plate Capacitor /w LI-M3 fingers and M4 Shield (for S8Q/S8P ONLY)
* Fixed layout is here:
* //depot/icm/proj/s8rf2/dev/opus/s8rf2/s8rf2_xcmvpp11p5x11p7_m4shield

.subckt xcmvpp11p5x11p7_m4shield c0 c1 b m4 mf=1
.param
+ctot_a   =  '118.52e-15*xcmvpp11p5x11p7_m4shield_cor' 
+cm4_c0   =  '7.48e-15*c0m4m3_vpp'
+cm4_c1   =  '5.06e-15*c1m4m3_vpp'
+c0_sub   =  '(4.99e-15-5.84e-16)*cli2s_vpp'
+c1_sub   =  '2.34e-15*cli2s_vpp'
+rat_m3   =  0.1539
+rat_m2   =  0.4074
+rat_m1   =  0.4025
+rat_li   =  0.0362
+cap_m3   =  'rat_m3*ctot_a' 
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 
+cap_li   =  'rat_li*ctot_a' 

+ll1      =  5.070
+lm1      =  5.215
+lm2      =  5.095
+lm3      =  5.050
+wl1      =  0.170
+wm1      =  0.140
+wm2      =  0.140
+wm3      =  0.300 
+nfl1     =  62      
+nfm1     =  72      
+nfm2     =  72       
+nfm3     =  34
+nvia2_c0  = 104
+nvia2_c1  = 49
+nvia_c0  =  124      
+nvia_c1  =  62       
+ncon_c0  =  116
+ncon_c1  =  28 

cm4_0  m4 b0   'cm4_c0'
cm4_1  m4 b1   'cm4_c1'

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

.ends xcmvpp11p5x11p7_m4shield


* 4-terminal Vertical Parallel Plate Capacitor /w LI-M3 fingers and Poly4 Shield (for S8Q/S8P ONLY)
* Fixed layout is here:
* //depot/icm/proj/s8rf2/dev/opus/s8rf2/s8rf2_xcmvpp11p5x11p7_polym4shield

.subckt xcmvpp11p5x11p7_polym4shield c0 c1 b m4 mf=1
.param
+ctot_a   =  '121.89e-15*xcmvpp11p5x11p7_m4shield_cor' 
+cm4_c0   =  '7.49e-15*c0m4m3_vpp'
+cm4_c1   =  '5.06e-15*c1m4m3_vpp'
+cpl2s    =  '(17.7e-15-1.88e-15)*cpl2s_vpp'
+rat_m3   =  0.12
+rat_m2   =  0.37
+rat_m1   =  0.37
+rat_li   =  0.12
+rat_li2p =  0.02
+cap_m3   =  'rat_m3*ctot_a' 
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 
+cap_li   =  'rat_li*ctot_a' 
+cap_li2p =  'rat_li2p*ctot_a' 

+ll1      =  5.070
+lm1      =  5.215
+lm2      =  5.095
+lm3      =  5.050
+wl1      =  0.170
+wm1      =  0.140
+wm2      =  0.140
+wm3      =  0.300 
+nfl1     =  62      
+nfm1     =  72      
+nfm2     =  72       
+nfm3     =  34
+nvia2_c0  = 104
+nvia2_c1  = 49
+nvia_c0  =  124      
+nvia_c1  =  62       
+ncon_c0  =  116
+ncon_c1  =  28 
+nlicon   =  126

cm4_0  m4 b0   'cm4_c0'
cm4_1  m4 b1   'cm4_c1'

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

.ends xcmvpp11p5x11p7_polym4shield


* 4-terminal Vertical Parallel Plate Capacitor /w LI-M3 fingers and Poly4 Shield (for S8Q/S8P ONLY)
* Fixed layout is here:
* //depot/icm/proj/s8rf2/dev/opus/s8rf2/s8rf2_xcmvpp6p8x6p1_polym4shield

.subckt xcmvpp6p8x6p1_polym4shield c0 c1 b m4 mf=1
.param
+ctot_a   =  '33.819e-15*xcmvpp6p8x6p1_cor' 
+cm4_c0   =  '2.75e-15*c0m4m3_vpp'
+cm4_c1   =  '1.53e-15*c1m4m3_vpp'
+cpl2s    =  '(6.51e-15-1.05e-15)*cpl2s_vpp'
+rat_m3   =  0.12
+rat_m2   =  0.37
+rat_m1   =  0.37
+rat_li   =  0.12
+rat_li2p =  0.02
+cap_m3   =  'rat_m3*ctot_a' 
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 
+cap_li   =  'rat_li*ctot_a' 
+cap_li2p =  'rat_li2p*ctot_a' 

+ll1      =  2.73
+lm1      =  2.42
+lm2      =  2.77
+lm3      =  2.25
+wl1      =  0.170
+wm1      =  0.140
+wm2      =  0.140
+wm3      =  0.300 
+nfl1     =  34
+nfm1     =  42
+nfm2     =  38
+nfm3     =  22
+nvia2_c0  = 48
+nvia2_c1  = 23
+nvia_c0  =  60
+nvia_c1  =  32
+ncon_c0  =  64
+ncon_c1  =  13 
+nlicon   =  68

cm4_0  m4 b0   'cm4_c0'
cm4_1  m4 b1   'cm4_c1'

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

.ends xcmvpp6p8x6p1_polym4shield


* 4-terminal Vertical Parallel Plate Capacitor /w M1-M3 fingers and LI4 Shield (for S8Q/S8P ONLY)
* Fixed layout is here:
* //depot/icm/proj/s8rf2/dev/opus/s8rf2/s8rf2_xcmvpp6p8x6p1_lim4shield

.subckt xcmvpp6p8x6p1_lim4shield c0 c1 b m4 mf=1
.param
+ctot_a   =  '26.560e-15*xcmvpp6p8x6p1_cor' 
+cm4_c0   =  '2.74e-15*c0m4m3_vpp'
+cm4_c1   =  '1.53e-15*c1m4m3_vpp'
+cli2s    =  '(3.00e-15-3.26e-16)*cli2s_vpp'   
+rat_m3   =  0.160 
+rat_m2   =  0.394 
+rat_m1   =  0.404 
+rat_m12li=  0.042
+cap_m3   =  'rat_m3*ctot_a' 
+cap_m2   =  'rat_m2*ctot_a' 
+cap_m1   =  'rat_m1*ctot_a' 
+cap_m12li=  'rat_m12li*ctot_a' 

+lm1      =  2.42
+lm2      =  2.77
+lm3      =  2.25
+wm1      =  0.140
+wm2      =  0.140
+wm3      =  0.300 
+nfm1     =  42
+nfm2     =  38
+nfm3     =  22
+nvia2_c0  = 48
+nvia2_c1  = 23
+nvia_c0  =  60
+nvia_c1  =  32
+nmcon  = 64 

cm4_0  m4 c0   'cm4_c0'
cm4_1  m4 c1   'cm4_c1'

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

.ends xcmvpp6p8x6p1_lim4shield
