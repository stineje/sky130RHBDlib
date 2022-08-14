**
.subckt npn_1x1_2p0_hv c b e s m=1
rc c c1 '440/m' tc1=-4e-3
q1 c1 b e s npn_1x1_2p0_hv_base m=m
q2 s c1 b s pnppar_polyhv m=m
d1 s b dnwdiode_psub pj=0.6 area=1.34 m=m

***  Comment in thise diodes for extracted sims
*D1_noxref s c dnwdiode_psub pj=35.8 area=80.1025 m=m
*D2_noxref b c dnwdiode_pw pj=0.0 area=47.4721 m=m
*dD2_noxref_nwdiode b c nwdiode pj=27.56 area=0.0 m=m

.model  npn_1x1_2p0_hv_base  npn  level = 1
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
+xcjc    = 1               itf     = 9.6e-03         ptf     = 20              tf      = 10.84e-011 
+tr      = 0               vtf     = 0.5       xtf     = 2.9     
**************************************************************
*               Noise PARAMETERS 
**************************************************************
+af      = 1.9           kf      = 5.0e-010
**************************************************************
*               DC PARAMETERS 
**************************************************************
+is      = '1.1082e-017*dkisnpnpolyhv' 
+re      = 85             irb     = 4.424e-005      rc      = 1.0            rbm     = 400.07        
+bf      = '141.286*dkbfnpnpolyhv' 
+ise     = 5.3935e-016     ne      = 1.7527          ns      = 1               br      = 100             
+iss     = 0               nr      = 1.0262306
+var     = 0               ikr     = 0.00046731      nkf     = 0.31875         isc     = 0             
+nc      = 2             
**************************************************************
*               TEMPERATURE PARAMETERS 
**************************************************************
+xtb     = 0               xti     = 2.7498          eg      = 1.1714          gap1    = 0             
+gap2    = 0               ctc     = 0               cte     = 0               cts     = 0             
+tlev    = 0               tlevc   = 0               tvjc    = 0               tvje    = 0             
+tvjs    = 0               tis1    = 0               tise1   = 0               tisc1   = 0             
+tnf1    = 4.208e-005      tnr1    = -0.000522       tne1    = 0               tnc1    = 0             
+tbf1    = 7.4942e-003     tbr1    = 0               tiss1   = 0               tvaf1   = 0             
+tvar1   = 0               tikf1   = -0.012219846    tikr1   = 0               tns1    = 0             
+trb1    = -0.0029419354   trc1    = 3.7260032e-005  tre1    = 5e-3            tirb1   = 0             
+trm1    = 0.004459028     tmjc1   = 0               tmje1   = 0               tmjs1   = 0             
+ttf1    = 0               titf1   = 0               ttr1    = 0               tis2    = 4e-012        
+tise2   = 0               tisc2   = 0               tnf2    = -3.372e-007     tnr2    = 1.8e-006      
+tne2    = 0               tnc2    = 0               tbf2    = 7.633e-006      tbr2    = 0             
+tiss2   = 0               tvaf2   = 0               tvar2   = 0               tikf2   = 9.3646292e-005
+tikr2   = 0               tns2    = 0               trb2    = 3.4143764e-005  trc2    = 3.0650517e-007
+tre2    = 0.0             tirb2   = 0              trm2    = -4.9458296e-005  tmjc2   = 0             
+tmje2   = 0               tmjs2   = 0               ttf2    = 0               titf2   = 0             
+ttr2    = 0             
**************************************************************
*               QUASI 
**************************************************************
**


.model  pnppar_polyhv  pnp  level = 1
**************************************************************
*               GENERAL PARAMETERS 
**************************************************************
+tref    = 30            
**************************************************************
*               CAPACITANCE PARAMETERS 
**************************************************************
+dcap    = 2               cjc     = 0               cje     = 0             
+cjs     = 0               fc      = 0.5             mjc     = 0.33            mje     = 0.33          
+mjs     = 0.5             vjc     = 0.75            vje     = 0.75            vjs     = 0.75          
+xcjc    = 1               
+itf     = 0               ptf     = 0               tf      = 0               tr      = 0             
+vtf     = 0.5             xtf     = 0             
**************************************************************
*               Noise PARAMETERS 
**************************************************************
+af      = 1.9           kf      = 5.0e-09
**************************************************************
*               DC PARAMETERS 
**************************************************************
+is      = '1.2252871e-016*dkisnpnpolyhv' 
+re      = 6000           irb     = 0               rc      = 1                rbm     = 46.144        
+bf      = '25*dkbfnpnpolyhv' 
+ise     = 1e-016          ne      = 2               ns      = 1               br      = 1             
+ibc     = 0               iss     = 0               nr      = 1
+var     = 0               ikr     = 1e-10           nkf     = 0.41826         isc     = 0             
+nc      = 2             
**************************************************************
*               TEMPERATURE PARAMETERS 
**************************************************************
+xtb     = 0               xti     = 5.351377        eg      = 1.11            gap1    = 0
+gap2    = 0               ctc     = 0             
+cte     = 0               cts     = 0               tlev    = 0               tlevc   = 0             
+tvjc    = 0               tvje    = 0               tvjs    = 0                            
+tis1    = 0               tise1   = 0               tisc1   = 0             
+tnf1    = -6e-3           tnr1    = 0               tne1    = 0               tnc1    = 0             
+tbf1    = 0               tbr1    = 0               tiss1   = 0               tvaf1   = 0             
+tvar1   = 0               tikf1   = 0               tikr1   = 0               tns1    = 0             
+trb1    = 0               trc1    = 0               tre1    = -0.005          tirb1   = 0             
+trm1    = 0               tmjc1   = 0               tmje1   = 0               tmjs1   = 0             
+ttf1    = 0               titf1   = 0               ttr1    = 0               tis2    = 0             
+tise2   = 0               tisc2   = 0               tnf2    = 0               tnr2    = 0             
+tne2    = 0               tnc2    = 0               tbf2    = 0               tbr2    = 0             
+tiss2   = 0               tvaf2   = 0               tvar2   = 0               tikf2   = 0
+tikr2   = 0               tns2    = 0               trb2    = 0               trc2    = 0
+tre2    = 0               tirb2   = 0               trm2    = 0               tmjc2   = 0             
+tmje2   = 0               tmjs2   = 0               ttf2    = 0               titf2   = 0             
+ttr2    = 0             
**************************************************************
*               QUASI 
**************************************************************

.ends
