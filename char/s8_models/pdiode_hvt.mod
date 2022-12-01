* BSIMTran Version 0.1.24, Created on 4-26-2002
* Username: hai
* Command Line: /home/hai/config/cydir/bin/lnx86/bsimtran diode.rf diode -p -npdiode_hvt PhDIV1.mod phighvt_cv.pmd pdiode_hvt.pmd 
* Working Directory: /home/hai/models/s8/s8tee/models.3.1/phighvt/combined
* Time: Wed Feb 28 12:25:48 2007
* Rule File:  diode.rf
* Output File:  pdiode_hvt.pmd
* Input Files:
* (1) PhDIV1.mod
* (2) phighvt_cv.pmd
*copyright, Cypress Semiconductor, 2001
*BSIM3.V3 Diode Model

.model pdiode_hvt d
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
+cj         =        '0.00075561*1e-12*phighvt_ajunction_mult'   $ farads/m^2
+mj         =        0.34629                     
+pb         =        0.6587                      $ V
+cjsw       =        '9.2435e-011*1e-6*phighvt_pjunction_mult'   $ farads/m
+mjsw       =        0.26859                     
+php        =        0.7418                      $ V
+cta        =        0.0012407                   $ 1/C
+ctp        =        0                           $ 1/C
+tpb        =        0.0019551                   $ V/C
+tphp       =        0.00014242                  $ V/C
*
*DIODE IV PARAMETERS
*
+js         =        2.17e-017                   $ A/m^2
+jsw        =        8.2e-016                    $ A/m
+n          =        1.2556                      
+rs         =        600                         $ ohms (ohms/m^2 if area defined in netlist)
+ik         =        '4.76e-008/1e-12'           $ A/m^2
+ikr        =        '0/1e-12'                   $ A/m^2
+vb         =        12.8                        $ V
+ibv        =        0.00106                     $ A
+trs        =        0                           $ 1/C
+eg         =        1.05                        $ eV
+xti        =        2.0                         
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

