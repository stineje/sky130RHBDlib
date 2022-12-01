* BSIMTran Version 0.1.24, Created on 4-26-2002
* Username: hai
* Command Line: /home/hai/config/cydir/bin/lnx86/bsimtran diode.rf diode -p -ndnwdiode_pw dnw_pw_iv_m31.pm dnw_pw_cv_m31.pm dnwdiode_pw.mod 
* Working Directory: /home/hai/models/s8/s8tee/models.3.1/diodes/dnwell_pw
* Time: Fri May 18 11:15:28 2007
* Rule File:  diode.rf
* Output File:  dnwdiode_pw.mod
* Input Files:
* (1) dnw_pw_iv_m31.pm
* (2) dnw_pw_cv_m31.pm
*copyright, Cypress Semiconductor, 2001
*BSIM3.V3 Diode Model

.model dnwdiode_pw d
+level      =        3                           
*
*PARAMETERS TO MAKE MODEL INTO CADFLOW
*
+tlevc      =        1                           
+scalm      =        1e-6                        
+area       =        1e12                        
*
*JUNCTION CAPACITANCE PARAMETERS
*
+cj         =        '0.00038945*1e-12*dnwdiode_pw_ajunction_mult'   $ farads/m^2
+mj         =        0.33982                     
+pb         =        0.58758                     $ V
+cjsw       =        '3.743e-010*1e-6*dnwdiode_pw_pjunction_mult'   $ farads/m
+mjsw       =        0.23357                     
+php        =        0.5348                      $ V
+cta        =        0.0016157                   $ 1/C
+ctp        =        0.0008                      $ 1/C
+tpb        =        0.0025003                   $ V/C
+tphp       =        0.001675                    $ V/C
*
*DIODE IV PARAMETERS
*
+js         =        1.4693e-017                 $ A/m^2
+jsw        =        7.41e-018                   $ A/m
+n          =        1.0791                      
+rs         =        900                         $ ohms (ohms/m^2 if area defined in netlist)
+ik         =        '2.08e-009/1e-12'           $ A/m^2
+ikr        =        '0/1e-12'                   $ A/m^2
+vb         =        16.38                       $ V
+ibv        =        0.00106                     $ A
+trs        =        0                           $ 1/C
+eg         =        1.17                        $ eV
+xti        =        3.0                         
+tref       =        30                          $ C
*
*DEFAULT PARAMETERS
*
+tcv        =        0                           $ 1/C
+gap1       =        0.000473                    $ eV/C
+gap2       =        1110                        
+ttt1       =        0                           $ 1/C
+ttt2       =        0                           $ 1/C^2
+tm1        =        0                           $ 1/C
+tm2        =        0                           $ 1/C^2
+lm         =        0                           $ m
+lp         =        0                           $ m
+wm         =        0                           $ m
+wp         =        0                           $ m
+xm         =        0                           $ m
+xoi        =        10000                       
+xom        =        10000                       $ Angstrom
+xp         =        0                           $ m
+xw         =        0                           $ m

.model dnwdiode_pw_no_rs d
+level      =        3                           
*
*PARAMETERS TO MAKE MODEL INTO CADFLOW
*
+tlevc      =        1                           
+scalm      =        1e-6                        
+area       =        1e12                        
*
*JUNCTION CAPACITANCE PARAMETERS
*
+cj         =        '0.00038945*1e-12*dnwdiode_pw_ajunction_mult'   $ farads/m^2
+mj         =        0.33982                     
+pb         =        0.58758                     $ V
+cjsw       =        '3.743e-010*1e-6*dnwdiode_pw_pjunction_mult'   $ farads/m
+mjsw       =        0.23357                     
+php        =        0.5348                      $ V
+cta        =        0.0016157                   $ 1/C
+ctp        =        0.0008                      $ 1/C
+tpb        =        0.0025003                   $ V/C
+tphp       =        0.001675                    $ V/C
*
*DIODE IV PARAMETERS
*
+js         =        1.4693e-017                 $ A/m^2
+jsw        =        7.41e-018                   $ A/m
+n          =        1.0791                      
+rs         =        0                           $ ohms (ohms/m^2 if area defined in netlist)
+ik         =        '2.08e-009/1e-12'           $ A/m^2
+ikr        =        '0/1e-12'                   $ A/m^2
+vb         =        16.38                       $ V
+ibv        =        0.00106                     $ A
+trs        =        0                           $ 1/C
+eg         =        1.17                        $ eV
+xti        =        3.0                         
+tref       =        30                          $ C
*
*DEFAULT PARAMETERS
*
+tcv        =        0                           $ 1/C
+gap1       =        0.000473                    $ eV/C
+gap2       =        1110                        
+ttt1       =        0                           $ 1/C
+ttt2       =        0                           $ 1/C^2
+tm1        =        0                           $ 1/C
+tm2        =        0                           $ 1/C^2
+lm         =        0                           $ m
+lp         =        0                           $ m
+wm         =        0                           $ m
+wp         =        0                           $ m
+xm         =        0                           $ m
+xoi        =        10000                       
+xom        =        10000                       $ Angstrom
+xp         =        0                           $ m
+xw         =        0                           $ m

.subckt xdnwdiode_pwell_rf c0 c1 area=-1 pj=-1
.param
+ra1 = 4.94e4
+ra2 = 130
+rp1 = 7920
+wl  = 'sqrt(0.0625*pj*pj-area)'
+wi   = 'pj/4 + wl'
+le   = 'pj/4 - wl'
ra   c0     a    r ='(ra1/area + ra2/(le/wi+wi/le))*(9.82e-01*2-dnwdiode_pw_ajunction_mult)'
rp   c0     p    r ='(rp1/pj)*(9.6304e-01*2-dnwdiode_pw_pjunction_mult)'
da    a    c1    dnwdiode_pw_no_rs area=area pj=0
dp    p    c1    dnwdiode_pw_no_rs area=1e-18 pj=pj
.ends xdnwdiode_pwell_rf

.subckt xesd_ndiode_h_dnwl_100 c0 c1 area=-1 pj=-1
ra   c0     a    r = 13.25
d1    a    c1    dnwdiode_pw_no_rs area='area*1.76' pj=pj
.ends xesd_ndiode_h_dnwl_100

.subckt xesd_ndiode_h_dnwl_200 c0 c1 area=-1 pj=-1
ra   c0     a    r = 5.82
d1    a    c1    dnwdiode_pw_no_rs area='area*1.65' pj=pj
.ends xesd_ndiode_h_dnwl_200

.subckt xesd_ndiode_h_dnwl_300 c0 c1 area=-1 pj=-1
ra   c0     a    r = 3.29
d1    a    c1    dnwdiode_pw_no_rs area='area*1.6'  pj=pj
.ends xesd_ndiode_h_dnwl_300
