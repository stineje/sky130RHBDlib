.subckt xcnwvc c0 c1 b w=5 l=0.5 vm=1
+ wc='w*1' lc='l*1' 

** Corner Parameters
*.param cnwvc_tox=41.6503
*.param cnwvc_cdepmult=1
*.param cnwvc_cintmult=1
*.param cnwvc_vt1=0.3333
*.param cnwvc_vt2=0.2380952
*.param cnwvc_vtr=0.16
*.param cnwvc_dwc=0.0    $ in microns each side
*.param cnwvc_dlc=0.0    $ in microns each side
*.param cnwvc_dld=0.0    $ in microns each side

*Geometry Parameters
.param
+cnwvc_ldiff=0.15
+wd='wc+2*cnwvc_dwc'
+ld='lc+2*cnwvc_dlc'
+ldd='0.018+2*cnwvc_dld'
+dwr=-0.02
+dwp=-0.5
+dlr=0.02
+wl='(wd-2*dwr)/(ld-2*dlr)'
+wlwdiff='((0.5*(ld-2*dlr))+cnwvc_ldiff)/(2*(wd-2*dwr))'

*Mismatch Parameters
+xcnwvc_cmin_slope_l=1.1e-16
+xcnwvc_cmin_slope_w=1.5e-16
+xcnwvc_cmin_slope_wl=3.5e-16
+xcnwvc_cmax_slope_l=7.0e-16
+xcnwvc_cmax_slope_w=7.0e-16
+xcnwvc_cmax_slope_wl=1.5e-15

** Capacitance Model Parameters
.param cnwvc_slope1=0.21875
.param cnwvc_slope2=0.125
.param
+cm0='5.571e-16*cnwvc_cintmult'
+cm1='4.775e-16' 
+cm2='2.019e-16' 
+cm3='6.529e-16*cnwvc_cdepmult' 
+cx0=6.261e-16 
+cx1='5.75e-16' 
+cx2='1.712e-16' 
+cx3='8.854e-14*3.9/cnwvc_tox' 

*******************************
*SOA Model
+xcnwvc_vgs_min_1 = '-2.071'
+xcnwvc_vgs_max_1 = '-1*-2.071'
+xcnwvc_tmax_vgs_1 = '100.001n'
+xcnwvc_vgs_min_2 = '-2.161'
+xcnwvc_vgs_max_2 = '-1*-2.161'
+xcnwvc_tmax_vgs_2 = '20.001n'
+xcnwvc_vgs_min = '-2.301'
+xcnwvc_vgs_max = '-1*-2.301'
***** xcnwvc VG CHECKS *****NOTE: this device is a subcircuit
*******************************

.param 
+tref=30.0
+cmin='cm0+cm1*ld+cm2*wd+cm3*wd*(ld-ldd)+cx3*wd*ldd'
+cmax='cx0+cx1*ld+cx2*wd+cx3*wd*ld'

cg c0 p2 q='cmin*vm*(v(c0)-v(p2))+((0.5*(cmax+cmin)-cmin)*(v(c0)-v(p2))+0.5*(cmax-cmin)*(1/1.9)*(cnwvc_slope1*log(cosh((v(c0)-v(p2)-cnwvc_vt1)/cnwvc_slope1))+0.9*cnwvc_slope2*log(cosh((v(c0)-v(p2)-cnwvc_vt2)/cnwvc_slope2))))*vm' 

*c3 and c4 are the tuning capacitors 
c3 c0 b c=0.15e-15
c4 c1 b c=0.15e-15  

** Resistance Model Parameters
.param con_sp=0.17
.param cnwvc_k=12                $contacts on both sides
.param cnwvc_n1=0.1              $fitting parameter for r
.param cnwvc_n2=0.28             $fitting parameter for r
.param apoly=1.15
.param apolyc=1
.param acon=1
.param anwell=1
.param bnwell=0.6
.param cnwell=2
.param n_pocon='max((lc-0.14)/(2*con_sp),1)'        $numbers of poly contact
.param n_con='(wc-2*0.06+con_sp)/(2*con_sp)'        $numbers of contacts
.param rg_tc1=3e-3
.param rg_tc2=0.0
.param rg_tcmult='1+(temper-tref)*rg_tc1+(temper-tref)*(temper-tref)*rg_tc2'

.param cnwvc_a='apoly*rp1*wl/cnwvc_k+apolyc*rcp1/n_pocon+acon*rcn/n_con+anwell*rnw*wlwdiff'
.param cnwvc_b1='bnwell*rnw*wlwdiff'
.param cnwvc_c='cnwell*rnw*((0.5*(ld-2*dlr))+cnwvc_ldiff)/(2*(wd-2*dwp))'

rg p2 c1 r='(cnwvc_a+cnwvc_b1*(0.5*tanh((v(c0)-v(p2)-cnwvc_vtr)/cnwvc_n1)+0.5)+20*cnwvc_c*(0.5*tanh((v(c0)-v(p2)-cnwvc_vtr)/cnwvc_n1)+0.5)*exp(-abs((v(c0)-v(p2)-cnwvc_vtr)/cnwvc_n2)))/vm*rg_tcmult' 


.ends xcnwvc
***************************************************************************************
.subckt xcnwvc2 c0 c1 b w=5 l=0.5 vm=1
+ wc='w*1' lc='l*1'

** Corner Parameters
*.param cnwvc2_tox=41.7642
*.param cnwvc2_cdepmult=1
*.param cnwvc2_cintmult=1
*.param cnwvc2_vt1=0.2
*.param cnwvc2_vt2=0.33
*.param cnwvc2_vtr=0.14
*.param cnwvc2_dwc=0.0    $ in microns each side
*.param cnwvc2_dlc=0.0    $ in microns each side
*.param cnwvc2_dld=0.0    $ in microns each side
*
*Geometry Parameters
.param
+cnwvc_ldiff=0.15
+wd='wc+2*cnwvc2_dwc'
+ld='lc+2*cnwvc2_dlc'
+ldd='0.015+2*cnwvc2_dld'
+dwr=0.00
+dwp=0.0
+dlr=0.03
+wl='(wd-2*dwr)/(ld-2*dlr)'
+wlwdiff='((0.5*(ld-2*dlr))+cnwvc_ldiff)/(2*(wd-2*dwr))'

*Mismatch Parameters
+xcnwvc2_cmin_slope_l=2.4e-16
+xcnwvc2_cmin_slope_w=1.0e-16
+xcnwvc2_cmin_slope_wl=4.0e-16
+xcnwvc2_cmax_slope_l=3.0e-16
+xcnwvc2_cmax_slope_w=7.0e-16
+xcnwvc2_cmax_slope_wl=1.0e-15

** Capacitance Model Parameters
.param cnwvc_slope1=0.15
.param cnwvc_slope2=0.35
.param
+cm0='5.828e-16*cnwvc2_cintmult'
+cm1=4.596e-16 
+cm2=1.614e-16 
+cm3='1.541e-15*cnwvc2_cdepmult' 
+cx0=6.778e-16
+cx1=6.461e-16 
+cx2=1.517e-16 
+cx3='8.854e-14*3.9/cnwvc2_tox' 

*******************************
*SOA Model
+xcnwvc2_vgs_min_1 = '-2.071'
+xcnwvc2_vgs_max_1 = '-1*-2.071'
+xcnwvc2_tmax_vgs_1 = '100.001n'
+xcnwvc2_vgs_min_2 = '-2.161'
+xcnwvc2_vgs_max_2 = '-1*-2.161'
+xcnwvc2_tmax_vgs_2 = '20.001n'
+xcnwvc2_vgs_min = '-2.301'
+xcnwvc2_vgs_max = '-1*-2.301'
***** xcnwvc2 VG CHECKS *****NOTE: this device is a subcircuit
*******************************

.param 
+tref=30.0
+cmin='cm0+cm1*ld+cm2*wd+cm3*wd*(ld-ldd)+cx3*wd*ldd'
+cmax='cx0+cx1*ld+cx2*wd+cx3*wd*ld'
+slope_0=1.808e-17
+slope_0_tc1=7.2181e-20
+slope_0_tc2=-1.9745e-21
+cmin_slope_0='slope_0+(temper-tref)*slope_0_tc1+(temper-tref)*(temper-tref)*slope_0_tc2'
+slope_w=-3.169e-17
+slope_w_tc1=-1.4465e-19
+slope_w_tc2=3.5187e-21
+cmin_slope_w='slope_w+(temper-tref)*slope_w_tc1+(temper-tref)*(temper-tref)*slope_w_tc2'
+slope_l=-7.435e-17
+slope_l_tc1=-4.4474e-19
+slope_l_tc2=7.3824e-21
+cmin_slope_l='slope_l+(temper-tref)*slope_l_tc1+(temper-tref)*(temper-tref)*slope_l_tc2'
+slope_wl=2.509e-16
+slope_wl_tc1=-1.0793e-18
+slope_wl_tc2=-2.2625e-20
+cmin_slope_wl='slope_wl+(temper-tref)*slope_wl_tc1+(temper-tref)*(temper-tref)*slope_wl_tc2'
+cmin_slope='cmin_slope_0+cmin_slope_w*wd+cmin_slope_l*ld+cmin_slope_wl*wd*ld'

cg c0 p2 q='cmin*vm*(v(c0)-v(p2))+0.5*cmin_slope*vm*min((v(c0)-v(p2)+0.8),0)*min((v(c0)-v(p2)+0.8),0)+((0.5*(cmax+cmin)-cmin)*(v(c0)-v(p2))+0.5*(cmax-cmin)*(1/1.9)*(cnwvc_slope1*log(cosh((v(c0)-v(p2)-cnwvc2_vt1)/cnwvc_slope1))+0.9*cnwvc_slope2*log(cosh((v(c0)-v(p2)-cnwvc2_vt2)/cnwvc_slope2))))*vm' 

*c3 and c4 are the tuning capacitors 
c3 c0 b c=0.15e-15
c4 c1 b c=0.15e-15  

** Resistance Model Parameters
.param con_sp=0.17
.param cnwvc_k=12                $contacts on both sides
.param cnwvc_n1=0.2              $fitting parameter for r
.param cnwvc_n2=0.35             $fitting parameter for r
.param apoly=1.1
.param apolyc=1.1
.param acon=1
.param anwell=1
.param bnwell=0.5
.param cnwell=0.3
.param n_pocon='max((lc-0.14)/(2*con_sp),1)'        $numbers of poly contact
.param n_con='(wc-2*0.06+con_sp)/(2*con_sp)'        $numbers of contacts
.param rg_tc1=9.611e-4
.param rg_tc2=5.523e-6
.param rg_tcmult='1+(temper-tref)*rg_tc1+(temper-tref)*(temper-tref)*rg_tc2'

.param cnwvc_a='apoly*rp1*wl/cnwvc_k+apolyc*rcp1/n_pocon+acon*rcn/n_con+anwell*rnw*wlwdiff'
.param cnwvc_b1='bnwell*rnw*cnwvc_ldiff/(2*(wd-2*dwr))'
.param cnwvc_c='cnwell*rnw*cnwvc_ldiff/(2*(wd-2*dwp))'

rg p2 c1 r='(cnwvc_a+cnwvc_b1*(0.5*tanh((v(c0)-v(p2)-cnwvc2_vtr)/cnwvc_n1)+0.5)+20*cnwvc_c*(0.5*tanh((v(c0)-v(p2)-cnwvc2_vtr)/cnwvc_n1)+0.5)*exp(-abs((v(c0)-v(p2)-cnwvc2_vtr)/cnwvc_n2)))/vm*rg_tcmult' 

.ends xcnwvc2
***************************************************************************************
