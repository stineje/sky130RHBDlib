* BSIMTran Version 0.1.24, Created on 4-26-2002
* Username: hai
* Command Line: /home/hai/config/cydir/bin/lnx86/bsimtran diode.rf diode -p -nndiode_h ndiode_h_m31_iv.pm ndiode_h_m31_cv.pm ndiode_h.mod 
* Working Directory: /home/hai/models/s8/s8tee/models.3.1/nhv/combined
* Time: Tue Jun  5 10:11:40 2007
* Rule File:  diode.rf
* Output File:  ndiode_h.mod
* Input Files:
* (1) ndiode_h_m31_iv.pm
* (2) ndiode_h_m31_cv.pm
*copyright, Cypress Semiconductor, 2001
*BSIM3.V3 Diode Model

.model ndiode_h d
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
+cj         =        '0.0008512*1e-12*nhv_ajunction_mult'   $ farads/m^2
+mj         =        0.295                       
+pb         =        0.72468                     $ V
+cjsw       =        '8.5204e-011*1e-6*nhv_pjunction_mult'   $ farads/m
+mjsw       =        0.037586                    
+php        =        0.29067                     $ V
+cta        =        0.00067434                  $ 1/C
+ctp        =        0.0002493                   $ 1/C
+tpb        =        0.001344                    $ V/C
+tphp       =        0.00099005                  $ V/C
*
*DIODE IV PARAMETERS
*
+js         =        3.75e-016                   $ A/m^2
+jsw        =        5.84e-017                   $ A/m
+n          =        1.0773                      
+rs         =        981                         $ ohms (ohms/m^2 if area defined in netlist)
+ik         =        '1.3e-009/1e-12'            $ A/m^2
+ikr        =        '0/1e-12'                   $ A/m^2
+vb         =        12.636                      $ V
+ibv        =        0.00106                     $ A
+trs        =        0                           $ 1/C
+eg         =        0.92                        $ eV
+xti        =        0.76                        
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

.model ndiode_h_no_rs d
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
+cj         =        '0.0008512*1e-12*nhv_ajunction_mult'   $ farads/m^2
+mj         =        0.295
+pb         =        0.72468                     $ V
+cjsw       =        '8.5204e-011*1e-6*nhv_pjunction_mult'   $ farads/m
+mjsw       =        0.037586
+php        =        0.29067                     $ V
+cta        =        0.00067434                  $ 1/C
+ctp        =        0.0002493                   $ 1/C
+tpb        =        0.001344                    $ V/C
+tphp       =        0.00099005                  $ V/C
*
*DIODE IV PARAMETERS
*
+js         =        3.75e-016                   $ A/m^2
+jsw        =        5.84e-017                   $ A/m
+n          =        1.0773
+rs         =        0                           $ ohms (ohms/m^2 if area defined in netlist)
+ik         =        '1.3e-009/1e-12'            $ A/m^2
+ikr        =        '0/1e-12'                   $ A/m^2
+vb         =        12.636                      $ V
+ibv        =        0.00106                     $ A
+trs        =        0                           $ 1/C
+eg         =        0.92                        $ eV
+xti        =        0.76
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
                                                                                                                                   
.subckt xesd_ndiode_h_100 c0 c1 area=-1 pj=-1
ra   c0     a    r = 1.1101 
d1    a    c1    ndiode_h_no_rs area='area*1.54' pj=pj
.ends xesd_ndiode_h_100 

.subckt xesd_ndiode_h_200 c0 c1 area=-1 pj=-1
ra   c0     a    r = 0.97922
d1    a    c1    ndiode_h_no_rs area='area*1.48' pj=pj
.ends xesd_ndiode_h_200

.subckt xesd_ndiode_h_300 c0 c1 area=-1 pj=-1
ra   c0     a    r = 0.87392
d1    a    c1    ndiode_h_no_rs area='area*1.46' pj=pj
.ends xesd_ndiode_h_300
