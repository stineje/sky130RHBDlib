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
+cm1=4.775e-16 
+cm2=2.019e-16 
+cm3='6.529e-16*cnwvc_cdepmult' 
+cx0=6.261e-16 
+cx1=5.75e-16 
+cx2=1.712e-16 
+cx3='8.854e-14*3.9/cnwvc_tox' 

.param cmin='cm0+cm1*ld+cm2*wd+cm3*wd*(ld-ldd)+cx3*wd*ldd' 
.param cmax='cx0+cx1*ld+cx2*wd+cx3*wd*ld' 
.param cval1='0.5*(cmax+cmin)'
.param cval2='0.5*(cmax-cmin)'

*cg c0 p2 c='(cval1+cval2*(1/1.9)*(tanh((v(c0)-v(c1)-cnwvc_vt1)/cnwvc_slope1)+0.9*tanh((v(c0)-v(c1)-cnwvc_vt2)/cnwvc_slope2)))*vm'

*c3 and c4 are the tuning capacitors 
*c3 c0 b c=0.15e-15
*c4 c1 b c=0.15e-15  

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

.param cnwvc_a='apoly*rp1*wl/cnwvc_k+apolyc*rcp1/n_pocon+acon*rcn/n_con+anwell*rnw*wlwdiff'
.param cnwvc_b1='bnwell*rnw*wlwdiff'
.param cnwvc_c='cnwell*rnw*((0.5*(ld-2*dlr))+cnwvc_ldiff)/(2*(wd-2*dwp))'

*rg p2 c1 r='(cnwvc_a+cnwvc_b1*(0.5*tanh((v(c0)-v(c1)-cnwvc_vtr)/cnwvc_n1)+0.5)+20*cnwvc_c*(0.5*tanh((v(c0)-v(c1)-cnwvc_vtr)/cnwvc_n1)+0.5)*exp(-abs((v(c0)-v(c1)-cnwvc_vtr)/cnwvc_n2)))/vm' tc1=3e-3 tc2=0

***Verilog A Model Call HERE
     .use_veriloga xcnwvc.ai
     .model xcnwvc_va macro lang=veriloga
     Yvaractor xcnwvc_va c0 c1 b generic: w=w l=l vm=vm cnwvc_tox=cnwvc_tox cnwvc_cdepmult=cnwvc_cdepmult cnwvc_cintmult=cnwvc_cintmult cnwvc_vt1=cnwvc_vt1 cnwvc_vt2=cnwvc_vt2 cnwvc_vtr=cnwvc_vtr cnwvc_dwc=cnwvc_dwc cnwvc_dlc=cnwvc_dlc cnwvc_dld=cnwvc_dld rp1=rp1 rcn=rcn rcp1=rcp1 rnw=rnw cm0=cm0 cm1=cm1 cm2=cm2 cm3=cm3 cx0=cx0 cx1=cx1 cx2=cx2 cx3=cx3


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

.param cmin='cm0+cm1*ld+cm2*wd+cm3*wd*(ld-ldd)+cx3*wd*ldd'
.param cmax='cx0+cx1*ld+cx2*wd+cx3*wd*ld'
.param cval1='0.5*(cmax+cmin)'
.param cval2='0.5*(cmax-cmin)'

*cg c0 p2 c='(cval1+cval2*(1/1.9)*(tanh((v(c0)-v(c1)-cnwvc2_vt1)/cnwvc_slope1)+0.9*tanh((v(c0)-v(c1)-cnwvc2_vt2)/cnwvc_slope2)))*vm'

*c3 and c4 are the tuning capacitors 
*c3 c0 b c=0.15e-15
*c4 c1 b c=0.15e-15  

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

.param cnwvc_a='apoly*rp1*wl/cnwvc_k+apolyc*rcp1/n_pocon+acon*rcn/n_con+anwell*rnw*wlwdiff'
.param cnwvc_b1='bnwell*rnw*cnwvc_ldiff/(2*(wd-2*dwr))'
.param cnwvc_c='cnwell*rnw*cnwvc_ldiff/(2*(wd-2*dwp))'

*rg p2 c1 r='(cnwvc_a+cnwvc_b1*(0.5*tanh((v(c0)-v(c1)-cnwvc2_vtr)/cnwvc_n1)+0.5)+20*cnwvc_c*(0.5*tanh((v(c0)-v(c1)-cnwvc2_vtr)/cnwvc_n1)+0.5)*exp(-abs((v(c0)-v(c1)-cnwvc2_vtr)/cnwvc_n2)))/vm' tc1=3e-3 tc2=0

***Verilog A Model Call HERE
     .use_veriloga xcnwvc.ai
     .model xcnwvc2_va macro lang=veriloga
     Yvaractor xcnwvc2_va c0 c1 b generic: w=w l=l vm=vm cnwvc2_tox=cnwvc2_tox cnwvc2_cdepmult=cnwvc2_cdepmult cnwvc2_cintmult=cnwvc2_cintmult cnwvc2_vt1=cnwvc2_vt1 cnwvc2_vt2=cnwvc2_vt2 cnwvc2_vtr=cnwvc2_vtr cnwvc2_dwc=cnwvc2_dwc cnwvc2_dlc=cnwvc2_dlc cnwvc2_dld=cnwvc2_dld rp1=rp1 rcn=rcn rcp1=rcp1 rnw=rnw cm0=cm0 cm1=cm1 cm2=cm2 cm3=cm3 cx0=cx0 cx1=cx1 cx2=cx2 cx3=cx3

.ends xcnwvc2
***************************************************************************************
