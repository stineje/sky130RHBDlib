* BSIMTran Version 0.1.24, Created on 4-26-2002
* Username: pxg
* Command Line: /home/pxg/config/cydir/bin/lnx86/bsimtran diode.rf diode -p -nndiode_native ndiode_nativeiv.pmd ndiode_nativecv.pmd ndiode_native.mod 
* Working Directory: /home/pxg/rams/s8/models.3.1/rev_model/diode/ndiode_native
* Time: Fri May 11 12:39:47 2007
* Rule File:  diode.rf
* Output File:  ndiode_native.mod
* Input Files:
* (1) ndiode_nativeiv.pmd
* (2) ndiode_nativecv.pmd
*copyright, Cypress Semiconductor, 2001
*BSIM3.V3 Diode Model

.model ndiode_native d
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
+cj         =        '0.0008602*1e-12*nhvnative_ajunction_mult'   $ farads/m^2
+mj         =        0.28329                     
+pb         =        0.66345                     $ V
+cjsw       =        '8.5152e-011*1e-6*nhvnative_pjunction_mult'   $ farads/m
+mjsw       =        0.057926                    
+php        =        1                           $ V
+cta        =        0.00083                     $ 1/C
+ctp        =        0                           $ 1/C
+tpb        =        0.0019685                   $ V/C
+tphp       =        0.001                       $ V/C
*
*DIODE IV PARAMETERS
*
+js         =        4.2966e-016                 $ A/m^2
+jsw        =        8.04e-016                   $ A/m
+n          =        1.5764                      
+rs         =        600                         $ ohms (ohms/m^2 if area defined in netlist)
+ik         =        '4.76e-008/1e-12'           $ A/m^2
+ikr        =        '0/1e-12'                   $ A/m^2
+vb         =        12.69                       $ V
+ibv        =        0.00106                     $ A
+trs        =        0                           $ 1/C
+eg         =        1.05                        $ eV
+xti        =        0                           
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

