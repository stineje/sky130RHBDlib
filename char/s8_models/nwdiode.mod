* BSIMTran Version 0.1.24, Created on 4-26-2002
* Username: hai
* Command Line: /home/hai/config/cydir/bin/lnx86/bsimtran diode.rf diode -p -nnwdiode nwdiode_iv_m31.pm nwdiode_cv_m31.pm nwdiode.mod 
* Working Directory: /home/hai/models/s8/s8tee/models.3.1/diodes/nwdiode
* Time: Thu May 17 17:51:49 2007
* Rule File:  diode.rf
* Output File:  nwdiode.mod
* Input Files:
* (1) nwdiode_iv_m31.pm
* (2) nwdiode_cv_m31.pm
*copyright, Cypress Semiconductor, 2001
*BSIM3.V3 Diode Model

.model nwdiode d
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
+cj         =        '9.155e-005*1e-12*nwdiode_ajunction_mult'   $ farads/m^2
+mj         =        0.4509                      
+pb         =        0.5348                      $ V
+cjsw       =        '5.822e-010*1e-6*nwdiode_pjunction_mult'   $ farads/m
+mjsw       =        0.2433                      
+php        =        0.5348                      $ V
+cta        =        0.00165                     $ 1/C
+ctp        =        0.0008                      $ 1/C
+tpb        =        0.0022563                   $ V/C
+tphp       =        0.00165                     $ V/C
*
*DIODE IV PARAMETERS
*
+js         =        4.21e-018                   $ A/m^2
+jsw        =        4.94e-018                   $ A/m
+n          =        1.0791                      
+rs         =        900                         $ ohms (ohms/m^2 if area defined in netlist)
+ik         =        '2.08e-009/1e-12'           $ A/m^2
+ikr        =        '0/1e-12'                   $ A/m^2
+vb         =        16.848                      $ V
+ibv        =        0.00106                     $ A
+trs        =        0                           $ 1/C
+eg         =        1.17                        $ eV
+xti        =        5.2                         
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

.model nwdiode_no_rs d
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
+cj         =        '9.155e-005*1e-12*nwdiode_ajunction_mult'   $ farads/m^2
+mj         =        0.4509                      
+pb         =        0.5348                      $ V
+cjsw       =        '5.822e-010*1e-6*nwdiode_pjunction_mult'   $ farads/m
+mjsw       =        0.2433                      
+php        =        0.5348                      $ V
+cta        =        0.00165                     $ 1/C
+ctp        =        0.0008                      $ 1/C
+tpb        =        0.0022563                   $ V/C
+tphp       =        0.00165                     $ V/C
*
*DIODE IV PARAMETERS
*
+js         =        4.21e-018                   $ A/m^2
+jsw        =        4.94e-018                   $ A/m
+n          =        1.0791                      
+rs         =        0                           $ ohms (ohms/m^2 if area defined in netlist)
+ik         =        '2.08e-009/1e-12'           $ A/m^2
+ikr        =        '0/1e-12'                   $ A/m^2
+vb         =        16.848                      $ V
+ibv        =        0.00106                     $ A
+trs        =        0                           $ 1/C
+eg         =        1.17                        $ eV
+xti        =        5.2                         
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

.subckt xnwdiode_rf c0 c1 area=-1 pj=-1
.param
+ra1 = 7.6e5
+ra2 = 2000
+rp1 = 3750
+wl  = 'sqrt(0.0625*pj*pj-area)'
+wi   = 'pj/4 + wl'
+le   = 'pj/4 - wl'
ra   c0     a    r ='(ra1/area + ra2/(le/wi+wi/le))*(9.8286e-01*2-nwdiode_ajunction_mult)'
rp   c0     p    r ='(rp1/pj)*(9.8954e-01*2-nwdiode_pjunction_mult)'
da    a    c1    nwdiode_no_rs area=area   pj=0
dp    p    c1    nwdiode_no_rs area=1e-18  pj=pj
.ends xnwdiode_rf

