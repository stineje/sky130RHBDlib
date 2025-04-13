* BSIMTran Version 0.1.24, Created on 4-26-2002
* Username: hai
* Command Line: /home/hai/config/cydir/bin/lnx86/bsimtran diode.rf diode -p -nndiode_lvt nlvt_diode_iv.pm nlvt_diode_cv.pm ndiode_lvt.mod 
* Working Directory: /home/hai/models/s8/s8tee/models.3.1/nlowvt/rev_model/combined
* Time: Thu May 10 12:49:02 2007
* Rule File:  diode.rf
* Output File:  ndiode_lvt.mod
* Input Files:
* (1) nlvt_diode_iv.pm
* (2) nlvt_diode_cv.pm
*copyright, Cypress Semiconductor, 2001
*BSIM3.V3 Diode Model

.model ndiode_lvt d
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
+cj         =        '0.001209*1e-12*nlowvt_ajunction_mult'   $ farads/m^2
+mj         =        0.42197                     
+pb         =        0.7477                      $ V
+cjsw       =        '3.6224e-011*1e-6*nlowvt_pjunction_mult'   $ farads/m
+mjsw       =        0.001                       
+php        =        0.1                         $ V
+cta        =        0.000792                    $ 1/C
+ctp        =        1e-005                      $ 1/C
+tpb        =        0.0012287                   $ V/C
+tphp       =        0                           $ V/C
*
*DIODE IV PARAMETERS
*
+js         =        2.75e-015                   $ A/m^2
+jsw        =        6e-016                      $ A/m
+n          =        1.2928                      
+rs         =        981                         $ ohms (ohms/m^2 if area defined in netlist)
+ik         =        '1.3e-009/1e-12'            $ A/m^2
+ikr        =        '0/1e-12'                   $ A/m^2
+vb         =        11.9                        $ V
+ibv        =        0.00106                     $ A
+trs        =        0                           $ 1/C
+eg         =        1.05                        $ eV
+xti        =        2                           
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

