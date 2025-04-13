* BSIMTran Version 0.1.24, Created on 4-26-2002
* Username: hai
* Command Line: /home/hai/config/cydir/bin/lnx86/bsimtran diode.rf diode -p -npdiode_h phv_iv_pxg.pm phv_cv_pxg.pm pdiode_h.mod 
* Working Directory: /home/hai/models/s8/s8tee/models.3.1/phv/combined
* Time: Wed Mar 21 14:28:54 2007
* Rule File:  diode.rf
* Output File:  pdiode_h.mod
* Input Files:
* (1) phv_iv_pxg.pm
* (2) phv_cv_pxg.pm
*copyright, Cypress Semiconductor, 2001
*BSIM3.V3 Diode Model

.model pdiode_h d
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
+cj         =        '0.00077547*1e-12*phv_ajunction_mult'   $ farads/m^2
+mj         =        0.33956                     
+pb         =        0.6587                      $ V
+cjsw       =        '9.8717e-011*1e-6*phv_pjunction_mult'   $ farads/m
+mjsw       =        0.24676                     
+php        =        1                           $ V
+cta        =        0.00096                     $ 1/C
+ctp        =        3e-005                      $ 1/C
+tpb        =        0.001671                    $ V/C
+tphp       =        0                           $ V/C
*
*DIODE IV PARAMETERS
*
+js         =        2.1483e-017                 $ A/m^2
+jsw        =        4.02e-018                   $ A/m
+n          =        1.3632                      
+rs         =        600                         $ ohms (ohms/m^2 if area defined in netlist)
+ik         =        '4.76e-008/1e-12'           $ A/m^2
+ikr        =        '0/1e-12'                   $ A/m^2
+vb         =        12.69                       $ V
+ibv        =        0.00106                     $ A
+trs        =        0                           $ 1/C
+eg         =        1.05                        $ eV
+xti        =        10                          
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

.model pdiode_h_no_rs d
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
+cj         =        '0.00077547*1e-12*phv_ajunction_mult'   $ farads/m^2
+mj         =        0.33956
+pb         =        0.6587                      $ V
+cjsw       =        '9.8717e-011*1e-6*phv_pjunction_mult'   $ farads/m
+mjsw       =        0.24676
+php        =        1                           $ V
+cta        =        0.00096                     $ 1/C
+ctp        =        3e-005                      $ 1/C
+tpb        =        0.001671                    $ V/C
+tphp       =        0                           $ V/C
*
*DIODE IV PARAMETERS
*
+js         =        2.1483e-017                 $ A/m^2
+jsw        =        4.02e-018                   $ A/m
+n          =        1.3632
+rs         =        0                           $ ohms (ohms/m^2 if area defined in netlist)
+ik         =        '4.76e-008/1e-12'           $ A/m^2
+ikr        =        '0/1e-12'                   $ A/m^2
+vb         =        12.69                       $ V
+ibv        =        0.00106                     $ A
+trs        =        0                           $ 1/C
+eg         =        1.05                        $ eV
+xti        =        10
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

.subckt xesd_pdiode_h_100 c0 c1 area=-1 pj=-1
ra   c0     a    r = 1.1994 
d1    a    c1    pdiode_h_no_rs area='area*1.8' pj=pj
.ends xesd_pdiode_h_100

.subckt xesd_pdiode_h_200 c0 c1 area=-1 pj=-1
ra   c0     a    r = 0.86977
d1    a    c1    pdiode_h_no_rs area='area*1.76' pj=pj
.ends xesd_pdiode_h_200
                                                                                                                                   
.subckt xesd_pdiode_h_300 c0 c1 area=-1 pj=-1
ra   c0     a    r = 0.74299
d1    a    c1    pdiode_h_no_rs area='area*1.73' pj=pj
.ends xesd_pdiode_h_300

