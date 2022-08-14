**
.subckt npnpar1x2 nc nb ne param: m=1
.model  npnpar1x2_mod  npn  level = 1
**************************************************************
*               GENERAL PARAMETERS 
**************************************************************
+tref    = 30            
**************************************************************
*               CAPACITANCE PARAMETERS 
**************************************************************
+dcap    = 2               cjc     = '1.60339e-014*dnwdiode_pw_ajunction_mult'    cje     = '10.30981e-015*nshort_ajunction_mult'  
+cjs     = '3.05951e-014*dnwdiode_psub_pjunction_mult'   fc      = 0.5             mjc     = 0.33982       mje     = 0.44         
+mjs     = 0.49            vjc     = 0.58758         vje     = 0.729           vjs     = 0.5348       
+xcjc    = 1               itf     = '2.6e-03+7e-3'              ptf     = 20              tf      = '6.34041e-011+4.5e-11'  
+tr      = 0               vtf     = '0.5+0.0'       xtf     = '2.0+0.9'     
**************************************************************
*               Noise PARAMETERS 
**************************************************************
+af      = 1.595       kf      = 3.5568689e-11
**************************************************************
*               DC PARAMETERS 
**************************************************************
+is      = '7.98e-018*dkisnpn1x2' 
+re      = 15.0            irb     = 4.424e-005       rc      = 61.677          rbm     = 256.08        
+bf      = '37.54*dkbfnpn1x2'  
+ise     = 5.77e-016       ne      = 1.7924           ns      = 1.0             br      = 1             
+ibc     = 0               iss     = 0               nr      = 0.96012       
+var     = 0               ikr     = 4.032e-008       nkf     = 0.5             isc     = 0             
+nc      = 2             
**************************************************************
*               TEMPERATURE PARAMETERS 
**************************************************************
+xtb     = 0               xti     = 1.0713          eg      = 1.188           gap1    = 0
+gap2    = 0               ctc     = 0
+cte     = 0               cts     = 0               tlev    = 0               tlevc   = 0
+tvjc    = 0               tvje    = 0               tvjs    = 0               
+tis1    = 0               tise1   = 0               tisc1   = 0
+tnf1    = 4.208e-005      tnr1    = -0.000522       tne1    = 0               tnc1    = 0
+tbf1    = 0.00776         tbr1    = 0               tiss1   = 0               tvaf1   = 0
+tvar1   = 0               tikf1   = -0.0074         tikr1   = 0               tns1    = 0
+trb1    = 0               trc1    = 0               tre1    = 0               tirb1   = 0
+trm1    = 0               tmjc1   = 0               tmje1   = 0               tmjs1   = 0
+ttf1    = 0               titf1   = 0               ttr1    = 0               tis2    = 4e-012
+tise2   = 0               tisc2   = 0               tnf2    = -3.372e-007     tnr2    = 1.8e-006
+tne2    = 0               tnc2    = 0               tbf2    = 6.48e-006       tbr2    = 0
+tiss2   = 0               tvaf2   = 0               tvar2   = 0               tikf2   = 4e-005
+tikr2   = 0               tns2    = 0               trb2    = 0               trc2    = 0
+tre2    = 0               tirb2   = 0               trm2    = 0               tmjc2   = 0
+tmje2   = 0               tmjs2   = 0               ttf2    = 0               titf2   = 0
**************************************************************
*               QUASI 
**************************************************************
qinst nc nb ne npnpar1x2_mod m=m
.ends
