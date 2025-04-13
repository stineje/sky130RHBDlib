* BSIMTran Version 0.1.24, Created on 4-26-2002
* Username: hai
* Command Line: /home/hai/config/cydir/bin/lnx86/bsimtran diode.rf diode -p -ndnwdiode_psub dnw_psub_iv_m31.pm dnw_psub_cv_m31.pm dnwdiode_psub.mod 
* Working Directory: /home/hai/models/s8/s8tee/models.3.1/diodes/dnwell_psub
* Time: Fri May 18 11:05:27 2007
* Rule File:  diode.rf
* Output File:  dnwdiode_psub.mod
* Input Files:
* (1) dnw_psub_iv_m31.pm
* (2) dnw_psub_cv_m31.pm
*copyright, Cypress Semiconductor, 2001
*BSIM3.V3 Diode Model

.model dnwdiode_psub d
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
+cj         =        '7.8544e-005*1e-12*dnwdiode_psub_ajunction_mult'   $ farads/m^2
+mj         =        0.49                        
+pb         =        0.5348                      $ V
+cjsw       =        '8.1664e-010*1e-6*dnwdiode_psub_pjunction_mult'   $ farads/m
+mjsw       =        0.20024                     
+php        =        0.5348                      $ V
+cta        =        0.0016157                   $ 1/C
+ctp        =        0.0008                      $ 1/C
+tpb        =        0.0025003                   $ V/C
+tphp       =        0.001675                    $ V/C
*
*DIODE IV PARAMETERS
*
+js         =        6.1049e-017                 $ A/m^2
+jsw        =        8.1115e-016                 $ A/m
+n          =        1.0791                      
+rs         =        900                         $ ohms (ohms/m^2 if area defined in netlist)
+ik         =        '2.08e-009/1e-12'           $ A/m^2
+ikr        =        '0/1e-12'                   $ A/m^2
+vb         =        16.95                       $ V
+ibv        =        0.00106                     $ A
+trs        =        0                           $ 1/C
+eg         =        1.17                        $ eV
+xti        =        1.0                         
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

