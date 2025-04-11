;;; 
;;; $Id: devices.il 3 2018/06/05 17:31:37 GMT jszemiot Exp $
;;; 
;;; devices.il
;;; 
;;; Copyright (c) 2012 by Cypress Semiconductor
;;; Cypress Kentucky CAD Center (KYCC)
;;; 
;;; Date  : Apr 12, 2012
;;; Author: Srabosti Datta (osd) @ KYCC
;;; 
;;; Description:
;;; 
;;; Revision History:
;;; 
;;; 
;;;   osd 04/12/12  new file
;;;   osd 04/20/12  added rdl resistor
;;;   osd 04/24/12  added vppcaps
;;;   vun 09/20/12  added new RF FETS
;;;   cva 03/06/13  TDR rev CP
;;;   cva 09/26/13  Atlas VPP
;;;  mmwn 11/15/13  Adding pmedlvt devices (TDR CX)
;;;   cva 02/04/15  creating tech lib for support of shrunken macro
;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Define capacitors - parasitic
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;  multi_widths    x1       x32     
(setq poly_widths '(0.150 1.200))
(setq l1_widths   '(0.170 1.360))
(setq m1_widths   '(0.140 1.120))
(setq m2_widths   '(0.140 1.120))
(setq m3_widths   '(0.300 2.400))
(setq m4_widths   '(0.300 2.400))
(setq m5_widths   '(1.600 4.000))
(setq rdl_widths  '(10.00 40.00))

(setq poly_spacings '(0.210 0.263 0.315 0.420 0.525 0.630 0.840 1.260 2.310 5.250))
(setq l1_spacings   '(0.180 0.225 0.270 0.360 0.450 0.540 0.720 1.080 1.980 4.500))
(setq m1_spacings   '(0.140 0.175 0.210 0.280 0.350 0.420 0.560 0.840 1.540 3.500))
(setq m2_spacings   '(0.140 0.175 0.210 0.280 0.350 0.420 0.560 0.840 1.540 3.500))
(setq m3_spacings   '(0.300 0.360 0.450 0.600 0.800 1.000 1.200 2.100 3.300 9.000))
(setq m4_spacings   '(0.300 0.360 0.450 0.600 0.800 1.000 1.200 2.100 3.300 9.000))
(setq m5_spacings   '(1.600 1.700 1.900 2.000 2.400 2.800 3.200 4.800 10.000 12.000))
(setq rdl_spacings  '(5.000 8.000 10.000 12.000 30.000))

(setq rp1_caplist  '(cp1f cl1p1f cm1p1f cm2p1f cm3p1f ));cm4p1f cm5p1f crdlp1f ))
(setq rl1_caplist  '(cl1f cl1d cl1p1
                            cm1l1f cm1l1d cm1l1p1 
			    cm2l1f cm2l1d cm2l1p1  
			    cm3l1f cm3l1d cm3l1p1  
;			    cm4l1f cm4l1d cm4l1p1 
;			    cm5l1f cm5l1d cm5l1p1 
;			    crdll1f crdll1d crdll1p1    
                ) )
(setq rm1_caplist  '(cm1f cm1d cm1p1 cm1l1  
			    cm2m1f cm2m1d cm2m1p1 cm2m1l1 
			    cm3m1f cm3m1d cm3m1p1 cm3m1l1  
;			    cm4m1f cm4m1d cm4m1p1 cm4m1l1  
;			    cm5m1f cm5m1d cm5m1p1 cm5m1l1
;			    crdlm1f crdlm1d crdlm1p1 crdlm1l1  
                ) )
(setq rm2_caplist  '(cm2f cm2d cm2p1 cm2l1 cm2m1  
			    cm3m2l1 cm3m2d cm3m2p1 cm3m2f cm3m2m1  
;			    cm4m2l1 cm4m2d cm4m2p1 cm4m2f cm4m2m1  
;			    cm5m2l1 cm5m2d cm5m2p1 cm5m2f cm5m2m1
;			    crdlm2l1 crdlm2d crdlm2p1 crdlm2f crdlm2m1
                ) )
(setq rm3_caplist  '(cm3f cm3d cm3p1 cm3l1 cm3m1 cm3m2  
;			    cm4m3l1 cm4m3d cm4m3p1 cm4m3f cm4m3m1 cm4m3m2 
;			    cm5m3l1 cm5m3d cm5m3p1 cm5m3f cm5m3m1 cm5m3m2
;			     crdlm3l1 crdlm3d crdlm3p1 crdlm3f crdlm3m1 crdlm3m2
                ) )
(setq rm4_caplist  '(cm4f cm4d cm4p1 cm4l1 cm4m1 cm4m2 cm4m3  
			    cm5m4l1 cm5m4d cm5m4p1 cm5m4f cm5m4m1 cm5m4m2 cm5m4m3
			     ;crdlm4l1 
                 crdlm4d crdlm4p1 crdlm4f crdlm4m1 crdlm4m2 crdlm4m3) )
(setq rm5_caplist  '(cm5f cm5d cm5p1 cm5l1 cm5m1 cm5m2 cm5m3 cm5m4 
		     ;crdlm5l1 
             crdlm5d crdlm5p1 crdlm5m1 crdlm5m2 crdlm5m3 crdlm5m4) )
(setq rrdl_caplist   '(crdlf   crdld   crdlp1   crdlm1   crdlm2 crdlm3 crdlm4 crdlm5))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; LOAD common devices
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(TECHinclude (BOOTprependTechPath "../pcios/s8/s8x/info/devices.il"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Define RF fets
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(TECHdefMos ?name                  'nhv_W3p0_L0p5_M2_b
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nhvrf_3p50m2_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.50
	    ?minGateWidth          3.01
	    ?discreteWLs           '(("0.50" ("3.01"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=770mV  Vcc=5.0V"
	    ?rfDeviceInfo          "nhvrf_3p50m2_b"
	    ?mapToCell             "s8rf_nhv_W3p0_L0p5_M2_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nhv_W3p0_L0p5_M10_b
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nhvrf_3p50m10_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.50
	    ?minGateWidth          3.01
	    ?discreteWLs           '(("0.50" ("3.01"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=770mV  Vcc=5.0V"
	    ?rfDeviceInfo          "nhvrf_3p50m10_b"
	    ?mapToCell             "s8rf_nhv_W3p0_L0p5_M10_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nhv_W3p0_L0p5_M4_b
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nhvrf_3p50m4_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.50
	    ?minGateWidth          3.01
	    ?discreteWLs           '(("0.50" ("3.01"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=770mV  Vcc=5.0V"
	    ?rfDeviceInfo          "nhvrf_3p50m4_b"
	    ?mapToCell             "s8rf_nhv_W3p0_L0p5_M4_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nhv_W5p0_L0p5_M10_b
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nhvrf_5p50m10_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.50
	    ?minGateWidth          5.05
	    ?discreteWLs           '(("0.50" ("5.05"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=763mV  Vcc=5.0V"
	    ?rfDeviceInfo          "nhvrf_5p50m10_b"
	    ?mapToCell             "s8rf_nhv_W5p0_L0p5_M10_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nhv_W5p0_L0p5_M4_b
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nhvrf_5p50m4_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.50
	    ?minGateWidth          5.05
	    ?discreteWLs           '(("0.50" ("5.05"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=763mV  Vcc=5.0V"
	    ?rfDeviceInfo          "nhvrf_5p50m4_b"
	    ?mapToCell             "s8rf_nhv_W5p0_L0p5_M4_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nhv_W5p0_L0p5_M2_b
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nhvrf_5p50m2_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.50
	    ?minGateWidth          5.05
	    ?discreteWLs           '(("0.50" ("5.05"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=763mV  Vcc=5.0V"
	    ?rfDeviceInfo          "nhvrf_5p50m2_b"
	    ?mapToCell             "s8rf_nhv_W5p0_L0p5_M2_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nhv_W7p0_L0p5_M10_b
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nhvrf_7p50m10_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.50
	    ?minGateWidth          7.09
	    ?discreteWLs           '(("0.50" ("7.09"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=771mV  Vcc=5.0V"
	    ?rfDeviceInfo          "nhvrf_7p50m10_b"
	    ?mapToCell             "s8rf_nhv_W7p0_L0p5_M10_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nhv_W7p0_L0p5_M4_b
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nhvrf_7p50m4_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.50
	    ?minGateWidth          7.09
	    ?discreteWLs           '(("0.50" ("7.09"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=771mV  Vcc=5.0V"
	    ?rfDeviceInfo          "nhvrf_7p50m4_b"
	    ?mapToCell             "s8rf_nhv_W7p0_L0p5_M4_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nlowvt_W1p65_L0p15_M2_b                 
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nlrf_1p65p15m2_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          1.65
	    ?discreteWLs           '(("0.15" ("1.65")))
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=661.3mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nlrf_1p65p15m2_b"
	    ?mapToCell             "s8rf_nlowvt_W1p65_L0p15_M2_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nlowvt_W1p65_L0p15_M4_b                 
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nlrf_1p65p15m4_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          1.65
	    ?discreteWLs           '(("0.15" ("1.65")))
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=632.2mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nlrf_1p65p15m4_b"
	    ?mapToCell             "s8rf_nlowvt_W1p65_L0p15_M4_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nlowvt_W1p65_L0p18_M2_b                 
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nlrf_1p65p18m2_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.18
	    ?minGateWidth          1.65
	    ?discreteWLs           '(("0.18" ("1.65"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=649.6mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nlrf_1p65p18m2_b"
	    ?mapToCell             "s8rf_nlowvt_W1p65_L0p18_M2_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nlowvt_W1p65_L0p18_M4_b                 
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nlrf_1p65p18m4_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.18
	    ?minGateWidth          1.65
	    ?discreteWLs           '(("0.18" ("1.65"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=620.9mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nlrf_1p65p18m4_b"
	    ?mapToCell             "s8rf_nlowvt_W1p65_L0p18_M4_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nlowvt_W1p65_L0p25_M2_b                 
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nlrf_1p65p25m2_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.25
	    ?minGateWidth          1.65
	    ?discreteWLs           '(("0.25" ("1.65"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=623.4mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nlrf_1p65p25m2_b"
	    ?mapToCell             "s8rf_nlowvt_W1p65_L0p25_M2_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nlowvt_W1p65_L0p25_M4_b                 
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nlrf_1p65p25m4_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.25
	    ?minGateWidth          1.65
	    ?discreteWLs           '(("0.25" ("1.65"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=595.1mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nlrf_1p65p25m4_b"
	    ?mapToCell             "s8rf_nlowvt_W1p65_L0p25_M4_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nlowvt_W3p0_L0p15_M2_b                 
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nlrf_3p15m2_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          3.01
	    ?discreteWLs           '(("0.15" ("3.01"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=632.8mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nlrf_3p15m2_b"
	    ?mapToCell             "s8rf_nlowvt_W3p0_L0p15_M2_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nlowvt_W3p0_L0p15_M4_b                 
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nlrf_3p15m4_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          3.01
	    ?discreteWLs           '(("0.15" ("3.01"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=603.8mV Vcc=1.8V"
	    ?rfDeviceInfo          "nlrf_3p15m4_b"
	    ?mapToCell             "s8rf_nlowvt_W3p0_L0p15_M4_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nlowvt_W3p0_L0p18_M2_b                 
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nlrf_3p18m2_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.18
	    ?minGateWidth          3.01
	    ?discreteWLs           '(("0.18" ("3.01"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=647.3mV Vcc=1.8V"
	    ?rfDeviceInfo          "nlrf_3p18m2_b"
	    ?mapToCell             "s8rf_nlowvt_W3p0_L0p18_M2_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nlowvt_W3p0_L0p18_M4_b                 
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nlrf_3p18m4_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.18
	    ?minGateWidth          3.01
	    ?discreteWLs           '(("0.18" ("3.01"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=618.6mV Vcc=1.8V"
	    ?rfDeviceInfo          "nlrf_3p18m4_b"
	    ?mapToCell             "s8rf_nlowvt_W3p0_L0p18_M4_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nlowvt_W3p0_L0p25_M2_b                 
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nlrf_3p25m2_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.25
	    ?minGateWidth          3.01
	    ?discreteWLs           '(("0.25" ("3.01"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=617mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nlrf_3p25m2_b"
	    ?mapToCell             "s8rf_nlowvt_W3p0_L0p25_M2_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nlowvt_W3p0_L0p25_M4_b                 
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nlrf_3p25m4_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.25
	    ?minGateWidth          3.01
	    ?discreteWLs           '(("0.25" ("3.01"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=588.3mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nlrf_3p25m4_b"
	    ?mapToCell             "s8rf_nlowvt_W3p0_L0p25_M4_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nlowvt_W5p0_L0p15_M2_b
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nlrf_5p15m2_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          5.05
	    ?discreteWLs           '(("0.15" ("5.05"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=637.2mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nlrf_5p15m2_b"
	    ?mapToCell             "s8rf_nlowvt_W5p0_L0p15_M2_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nlowvt_W5p0_L0p15_M4_b
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nlrf_5p15m4_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          5.05
	    ?discreteWLs           '(("0.15" ("5.05"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=608mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nlrf_5p15m4_b"
	    ?mapToCell             "s8rf_nlowvt_W5p0_L0p15_M4_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nlowvt_W5p0_L0p18_M2_b
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nlrf_5p18m2_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.18
	    ?minGateWidth          5.05
	    ?discreteWLs           '(("0.18" ("5.05"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=633.6mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nlrf_5p18m2_b"
	    ?mapToCell             "s8rf_nlowvt_W5p0_L0p18_M2_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nlowvt_W5p0_L0p18_M4_b
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nlrf_5p18m4_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.18
	    ?minGateWidth          5.05
	    ?discreteWLs           '(("0.18" ("5.05"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=604.8mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nlrf_5p18m4_b"
	    ?mapToCell             "s8rf_nlowvt_W5p0_L0p18_M4_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nlowvt_W5p0_L0p25_M2_b
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nlrf_5p25m2_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.25
	    ?minGateWidth          5.05
	    ?discreteWLs           '(("0.25" ("5.05"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=609.8mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nlrf_5p25m2_b"
	    ?mapToCell             "s8rf_nlowvt_W5p0_L0p25_M2_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nlowvt_W5p0_L0p25_M4_b
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nlrf_5p25m4_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.25
	    ?minGateWidth          5.05
	    ?discreteWLs           '(("0.25" ("5.05"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=581.2mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nlrf_5p25m4_b"
	    ?mapToCell             "s8rf_nlowvt_W5p0_L0p25_M4_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )

;;MVO add
(TECHdefMos ?name                  'nlowvt_W0p42_L0p15_2F
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nlrf_p42p15nf2"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          0.42
	    ?discreteWLs           '(("0.15" ("0.42"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=648.0mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nlrf_p42p15nf2"
	    ?mapToCell             "s8rf_nlowvt_W0p42_L0p15_2F"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )

(TECHdefMos ?name                  'nlowvt_W0p84_L0p15_2F
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nlrf_p84p15nf2"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          0.84
	    ?discreteWLs           '(("0.15" ("0.84"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=656.0mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nlrf_p84p15nf2"
	    ?mapToCell             "s8rf_nlowvt_W0p84_L0p15_2F"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )


(TECHdefMos ?name                  'nlowvt_W0p84_L0p15_4F
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nlrf_p84p15nf4"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          0.84
	    ?discreteWLs           '(("0.15" ("0.84"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=647.0mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nlrf_p84p15nf4"
	    ?mapToCell             "s8rf_nlowvt_W0p84_L0p15_4F"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )

(TECHdefMos ?name                  'nlowvt_W0p84_L0p15_8F
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nlrf_p84p15nf8"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          0.84
	    ?discreteWLs           '(("0.15" ("0.84"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=640.0mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nlrf_p84p15nf8"
	    ?mapToCell             "s8rf_nlowvt_W0p84_L0p15_8F"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )

(TECHdefMos ?name                  'nlowvt_W3p0_L0p15_2F
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nlrf_3p15nf2"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          3.00
	    ?discreteWLs           '(("0.15" ("3.00"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=639.0mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nlrf_3p15nf2"
	    ?mapToCell             "s8rf_nlowvt_W3p0_L0p15_2F"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )

(TECHdefMos ?name                  'nlowvt_W3p0_L0p15_4F
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nlrf_3p15nf4"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          3.00
	    ?discreteWLs           '(("0.15" ("3.00"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=628.0mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nlrf_3p15nf4"
	    ?mapToCell             "s8rf_nlowvt_W3p0_L0p15_4F"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )

(TECHdefMos ?name                  'nlowvt_W3p0_L0p15_8F
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nlrf_3p15nf8"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          3.00
	    ?discreteWLs           '(("0.15" ("3.00"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=620.0mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nlrf_3p15nf8"
	    ?mapToCell             "s8rf_nlowvt_W3p0_L0p15_8F"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )


(TECHdefMos ?name                  'nshort_W1p65_L0p15_M2_b
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nsrf_1p65p15m2_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          1.65
	    ?discreteWLs           '(("0.15" ("1.65"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=741.8mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nsrf_1p65p15m2_b"
	    ?mapToCell             "s8rf_nshort_W1p65_L0p15_M2_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nshort_W1p65_L0p15_M4_b
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nsrf_1p65p15m4_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          1.65
	    ?discreteWLs           '(("0.15" ("1.65"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=722.1mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nsrf_1p65p15m4_b"
	    ?mapToCell             "s8rf_nshort_W1p65_L0p15_M4_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nshort_W1p65_L0p18_M2_b
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nsrf_1p65p18m2_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.18
	    ?minGateWidth          1.65
	    ?discreteWLs           '(("0.18" ("1.65"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=750.7mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nsrf_1p65p18m2_b"
	    ?mapToCell             "s8rf_nshort_W1p65_L0p18_M2_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nshort_W1p65_L0p18_M4_b
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nsrf_1p65p18m4_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.18
	    ?minGateWidth          1.65
	    ?discreteWLs           '(("0.18" ("1.65"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=731.1mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nsrf_1p65p18m4_b"
	    ?mapToCell             "s8rf_nshort_W1p65_L0p18_M4_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nshort_W1p65_L0p25_M2_b
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nsrf_1p65p25m2_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.25
	    ?minGateWidth          1.65
	    ?discreteWLs           '(("0.25" ("1.65"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=730.6mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nsrf_1p65p25m2_b"
	    ?mapToCell             "s8rf_nshort_W1p65_L0p25_M2_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nshort_W1p65_L0p25_M4_b
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nsrf_1p65p25m4_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.25
	    ?minGateWidth          1.65
	    ?discreteWLs           '(("0.25" ("1.65"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=711.1mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nsrf_1p65p25m4_b"
	    ?mapToCell             "s8rf_nshort_W1p65_L0p25_M4_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nshort_W3p0_L0p15_M2_b
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nsrf_3p15m2_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          3.01
	    ?discreteWLs           '(("0.15" ("3.01"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=721.8mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nsrf_3p15m2_b" 
	    ?mapToCell             "s8rf_nshort_W3p0_L0p15_M2_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nshort_W3p0_L0p15_M4_b
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nsrf_3p15m4_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          3.01
	    ?discreteWLs           '(("0.15" ("3.01"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=702.4mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nsrf_3p15m4_b"
	    ?mapToCell             "s8rf_nshort_W3p0_L0p15_M4_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nshort_W3p0_L0p18_M2_b
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nsrf_3p18m2_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.18
	    ?minGateWidth          3.01
	    ?discreteWLs           '(("0.18" ("3.01"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=730.8mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nsrf_3p18m2_b"
	    ?mapToCell             "s8rf_nshort_W3p0_L0p18_M2_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nshort_W3p0_L0p18_M4_b
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nsrf_3p18m4_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.18
	    ?minGateWidth          3.01
	    ?discreteWLs           '(("0.18" ("3.01"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=711.2mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nsrf_3p18m4_b"
	    ?mapToCell             "s8rf_nshort_W3p0_L0p18_M4_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nshort_W3p0_L0p25_M2_b
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nsrf_3p25m2_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.25
	    ?minGateWidth          3.01
	    ?discreteWLs           '(("0.25" ("3.01"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=710.6mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nsrf_3p25m2_b"
	    ?mapToCell             "s8rf_nshort_W3p0_L0p25_M2_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nshort_W3p0_L0p25_M4_b
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nsrf_3p25m4_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.25
	    ?minGateWidth          3.01
	    ?discreteWLs           '(("0.25" ("3.01"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=691mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nsrf_3p25m4_b"
	    ?mapToCell             "s8rf_nshort_W3p0_L0p25_M4_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nshort_W5p0_L0p15_M2_b
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nsrf_5p15m2_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          5.05
	    ?discreteWLs           '(("0.15" ("5.05"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=718mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nsrf_5p15m2_b"
	    ?mapToCell             "s8rf_nshort_W5p0_L0p15_M2_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nshort_W5p0_L0p15_M4_b
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nsrf_5p15m4_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          5.05
	    ?discreteWLs           '(("0.15" ("5.05"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=698.6mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nsrf_5p15m4_b"
	    ?mapToCell             "s8rf_nshort_W5p0_L0p15_M4_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nshort_W5p0_L0p18_M2_b
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nsrf_5p18m2_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.18
	    ?minGateWidth          5.05
	    ?discreteWLs           '(("0.18" ("5.05"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=718.6mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nsrf_5p18m2_b"
	    ?mapToCell             "s8rf_nshort_W5p0_L0p18_M2_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nshort_W5p0_L0p18_M4_b
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nsrf_5p18m4_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.18
	    ?minGateWidth          5.05
	    ?discreteWLs           '(("0.18" ("5.05"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=699mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nsrf_5p18m4_b"
	    ?mapToCell             "s8rf_nshort_W5p0_L0p18_M4_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nshort_W5p0_L0p25_M2_b
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nsrf_5p25m2_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.25
	    ?minGateWidth          5.05
	    ?discreteWLs           '(("0.25" ("5.05"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=700.9mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nsrf_5p25m2_b"
	    ?mapToCell             "s8rf_nshort_W5p0_L0p25_M2_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'nshort_W5p0_L0p25_M4_b
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "nsrf_5p25m4_b"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.25
	    ?minGateWidth          5.05
	    ?discreteWLs           '(("0.25" ("5.05"))) 
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deepNwell		   t
	    ?isSubckt              t
	    ?deviceInfo            "Vt=681.5mV  Vcc=1.8V"
	    ?rfDeviceInfo          "nsrf_5p25m4_b"
	    ?mapToCell             "s8rf_nshort_W5p0_L0p25_M4_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'pshort_W1p65_L0p15_M2_b
	    ?cellName              "pfet"
	    ?areaCap               (TECHgetRule "cgox_p_ca")
	    ?sidewallCap           (TECHgetRule "cgox_p_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_p")
	    ?diode                 'pdiode
	    ?hspiceModel           "psrf_1p65p15m2_b"
	    ?lsimModel             "TPS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          1.65
	    ?discreteWLs           '(("0.15" ("1.65"))) 
	    ?contactRes            (TECHgetRule "rcl1p")
	    ?diffSheetRes          (TECHgetRule "rsp")
	    ?isSubckt              t
	    ?deviceInfo            "Vt=-831mV  Vcc=1.8V"
	    ?rfDeviceInfo          "psrf_1p65p15m2_b"
	    ?mapToCell             "s8rf_pshort_W1p65_L0p15_M2_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'pshort_W1p65_L0p15_M4_b
	    ?cellName              "pfet"
	    ?areaCap               (TECHgetRule "cgox_p_ca")
	    ?sidewallCap           (TECHgetRule "cgox_p_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_p")
	    ?diode                 'pdiode
	    ?hspiceModel           "psrf_1p65p15m4_b"
	    ?lsimModel             "TPS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          1.65
	    ?discreteWLs           '(("0.15" ("1.65"))) 
	    ?contactRes            (TECHgetRule "rcl1p")
	    ?diffSheetRes          (TECHgetRule "rsp")
	    ?isSubckt              t
	    ?deviceInfo            "Vt=-831mV  Vcc=1.8V"
	    ?rfDeviceInfo          "psrf_1p65p15m4_b"
	    ?mapToCell             "s8rf_pshort_W1p65_L0p15_M4_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'pshort_W1p65_L0p18_M2_b
	    ?cellName              "pfet"
	    ?areaCap               (TECHgetRule "cgox_p_ca")
	    ?sidewallCap           (TECHgetRule "cgox_p_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_p")
	    ?diode                 'pdiode
	    ?hspiceModel           "psrf_1p65p18m2_b"
	    ?lsimModel             "TPS"
	    ?isElement             t
	    ?minGateLength         0.18
	    ?minGateWidth          1.65
	    ?discreteWLs           '(("0.18" ("1.65"))) 
	    ?contactRes            (TECHgetRule "rcl1p")
	    ?diffSheetRes          (TECHgetRule "rsp")
	    ?isSubckt              t
	    ?deviceInfo            "Vt=-870.8mV  Vcc=1.8V"
	    ?rfDeviceInfo          "psrf_1p65p18m2_b"
	    ?mapToCell             "s8rf_pshort_W1p65_L0p18_M2_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'pshort_W1p65_L0p18_M4_b
	    ?cellName              "pfet"
	    ?areaCap               (TECHgetRule "cgox_p_ca")
	    ?sidewallCap           (TECHgetRule "cgox_p_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_p")
	    ?diode                 'pdiode
	    ?hspiceModel           "psrf_1p65p18m4_b"
	    ?lsimModel             "TPS"
	    ?isElement             t
	    ?minGateLength         0.18
	    ?minGateWidth          1.65
	    ?discreteWLs           '(("0.18" ("1.65"))) 
	    ?contactRes            (TECHgetRule "rcl1p")
	    ?diffSheetRes          (TECHgetRule "rsp")
	    ?isSubckt              t
	    ?deviceInfo            "Vt=-870.8mV  Vcc=1.8V"
	    ?rfDeviceInfo          "psrf_1p65p18m4_b"
	    ?mapToCell             "s8rf_pshort_W1p65_L0p18_M4_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'pshort_W1p65_L0p25_M2_b
	    ?cellName              "pfet"
	    ?areaCap               (TECHgetRule "cgox_p_ca")
	    ?sidewallCap           (TECHgetRule "cgox_p_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_p")
	    ?diode                 'pdiode
	    ?hspiceModel           "psrf_1p65p25m2_b"
	    ?lsimModel             "TPS"
	    ?isElement             t
	    ?minGateLength         0.25
	    ?minGateWidth          1.65
	    ?discreteWLs           '(("0.25" ("1.65"))) 
	    ?contactRes            (TECHgetRule "rcl1p")
	    ?diffSheetRes          (TECHgetRule "rsp")
	    ?isSubckt              t
	    ?deviceInfo            "Vt=-908.6mV  Vcc=1.8V"
	    ?rfDeviceInfo          "psrf_1p65p25m2_b"
	    ?mapToCell             "s8rf_pshort_W1p65_L0p25_M2_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'pshort_W1p65_L0p25_M4_b
	    ?cellName              "pfet"
	    ?areaCap               (TECHgetRule "cgox_p_ca")
	    ?sidewallCap           (TECHgetRule "cgox_p_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_p")
	    ?diode                 'pdiode
	    ?hspiceModel           "psrf_1p65p25m4_b"
	    ?lsimModel             "TPS"
	    ?isElement             t
	    ?minGateLength         0.25
	    ?minGateWidth          1.65
	    ?discreteWLs           '(("0.25" ("1.65"))) 
	    ?contactRes            (TECHgetRule "rcl1p")
	    ?diffSheetRes          (TECHgetRule "rsp")
	    ?isSubckt              t
	    ?deviceInfo            "Vt=-908.6mV  Vcc=1.8V"
	    ?rfDeviceInfo          "psrf_1p65p25m4_b" 
	    ?mapToCell             "s8rf_pshort_W1p65_L0p25_M4_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'pshort_W3p0_L0p15_M2_b
	    ?cellName              "pfet"
	    ?areaCap               (TECHgetRule "cgox_p_ca")
	    ?sidewallCap           (TECHgetRule "cgox_p_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_p")
	    ?diode                 'pdiode
	    ?hspiceModel           "psrf_3p15m2_b"
	    ?lsimModel             "TPS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          3.01
	    ?discreteWLs           '(("0.15" ("3.01"))) 
	    ?contactRes            (TECHgetRule "rcl1p")
	    ?diffSheetRes          (TECHgetRule "rsp")
	    ?isSubckt              t
	    ?deviceInfo            "Vt=-839mV  Vcc=1.8V"
	    ?rfDeviceInfo          "psrf_3p15m2_b"
	    ?mapToCell             "s8rf_pshort_W3p0_L0p15_M2_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'pshort_W3p0_L0p15_M4_b
	    ?cellName              "pfet"
	    ?areaCap               (TECHgetRule "cgox_p_ca")
	    ?sidewallCap           (TECHgetRule "cgox_p_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_p")
	    ?diode                 'pdiode
	    ?hspiceModel           "psrf_3p15m4_b"
	    ?lsimModel             "TPS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          3.01
	    ?discreteWLs           '(("0.15" ("3.01"))) 
	    ?contactRes            (TECHgetRule "rcl1p")
	    ?diffSheetRes          (TECHgetRule "rsp")
	    ?isSubckt              t
	    ?deviceInfo            "Vt=-839mV  Vcc=1.8V"
	    ?rfDeviceInfo          "psrf_3p15m4_b"
	    ?mapToCell             "s8rf_pshort_W3p0_L0p15_M4_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'pshort_W3p0_L0p18_M2_b
	    ?cellName              "pfet"
	    ?areaCap               (TECHgetRule "cgox_p_ca")
	    ?sidewallCap           (TECHgetRule "cgox_p_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_p")
	    ?diode                 'pdiode
	    ?hspiceModel           "psrf_3p18m2_b"
	    ?lsimModel             "TPS"
	    ?isElement             t
	    ?minGateLength         0.18
	    ?minGateWidth          3.01
	    ?discreteWLs           '(("0.18" ("3.01"))) 
	    ?contactRes            (TECHgetRule "rcl1p")
	    ?diffSheetRes          (TECHgetRule "rsp")
	    ?isSubckt              t
	    ?deviceInfo            "Vt=-879mV  Vcc=1.8V"
	    ?rfDeviceInfo          "psrf_3p18m2_b" 
	    ?mapToCell             "s8rf_pshort_W3p0_L0p18_M2_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'pshort_W3p0_L0p18_M4_b
	    ?cellName              "pfet"
	    ?areaCap               (TECHgetRule "cgox_p_ca")
	    ?sidewallCap           (TECHgetRule "cgox_p_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_p")
	    ?diode                 'pdiode
	    ?hspiceModel           "psrf_3p18m4_b"
	    ?lsimModel             "TPS"
	    ?isElement             t
	    ?minGateLength         0.18
	    ?minGateWidth          3.01
	    ?discreteWLs           '(("0.18" ("3.01"))) 
	    ?contactRes            (TECHgetRule "rcl1p")
	    ?diffSheetRes          (TECHgetRule "rsp")
	    ?isSubckt              t
	    ?deviceInfo            "Vt=-879mV  Vcc=1.8V"
	    ?rfDeviceInfo          "psrf_3p18m4_b"
	    ?mapToCell             "s8rf_pshort_W3p0_L0p18_M4_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'pshort_W3p0_L0p25_M2_b
	    ?cellName              "pfet"
	    ?areaCap               (TECHgetRule "cgox_p_ca")
	    ?sidewallCap           (TECHgetRule "cgox_p_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_p")
	    ?diode                 'pdiode
	    ?hspiceModel           "psrf_3p25m2_b"
	    ?lsimModel             "TPS"
	    ?isElement             t
	    ?minGateLength         0.25
	    ?minGateWidth          3.01
	    ?discreteWLs           '(("0.25" ("3.01"))) 
	    ?contactRes            (TECHgetRule "rcl1p")
	    ?diffSheetRes          (TECHgetRule "rsp")
	    ?isSubckt              t
	    ?deviceInfo            "Vt=-917mV  Vcc=1.8V"
	    ?rfDeviceInfo          "psrf_3p25m2_b"
	    ?mapToCell             "s8rf_pshort_W3p0_L0p25_M2_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'pshort_W3p0_L0p25_M4_b
	    ?cellName              "pfet"
	    ?areaCap               (TECHgetRule "cgox_p_ca")
	    ?sidewallCap           (TECHgetRule "cgox_p_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_p")
	    ?diode                 'pdiode
	    ?hspiceModel           "psrf_3p25m4_b"
	    ?lsimModel             "TPS"
	    ?isElement             t
	    ?minGateLength         0.25
	    ?minGateWidth          3.01
	    ?discreteWLs           '(("0.25" ("3.01"))) 
	    ?contactRes            (TECHgetRule "rcl1p")
	    ?diffSheetRes          (TECHgetRule "rsp")
	    ?isSubckt              t
	    ?deviceInfo            "Vt=-917mV  Vcc=1.8V"
	    ?rfDeviceInfo          "psrf_3p25m4_b"
	    ?mapToCell             "s8rf_pshort_W3p0_L0p25_M4_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'pshort_W5p0_L0p15_M2_b
	    ?cellName              "pfet"
	    ?areaCap               (TECHgetRule "cgox_p_ca")
	    ?sidewallCap           (TECHgetRule "cgox_p_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_p")
	    ?diode                 'pdiode
	    ?hspiceModel           "psrf_5p15m2_b"
	    ?lsimModel             "TPS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          5.05
	    ?discreteWLs           '(("0.15" ("5.05"))) 
	    ?contactRes            (TECHgetRule "rcl1p")
	    ?diffSheetRes          (TECHgetRule "rsp")
	    ?isSubckt              t
	    ?deviceInfo            "Vt=-853mV  Vcc=1.8V"
	    ?rfDeviceInfo          "psrf_5p15m2_b"
	    ?mapToCell             "s8rf_pshort_W5p0_L0p15_M2_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'pshort_W5p0_L0p15_M4_b
	    ?cellName              "pfet"
	    ?areaCap               (TECHgetRule "cgox_p_ca")
	    ?sidewallCap           (TECHgetRule "cgox_p_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_p")
	    ?diode                 'pdiode
	    ?hspiceModel           "psrf_5p15m4_b"
	    ?lsimModel             "TPS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          5.05
	    ?discreteWLs           '(("0.15" ("5.05"))) 
	    ?contactRes            (TECHgetRule "rcl1p")
	    ?diffSheetRes          (TECHgetRule "rsp")
	    ?isSubckt              t
	    ?deviceInfo            "Vt=-853mV  Vcc=1.8V"
	    ?rfDeviceInfo          "psrf_5p15m4_b"
	    ?mapToCell             "s8rf_pshort_W5p0_L0p15_M4_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'pshort_W5p0_L0p18_M2_b
	    ?cellName              "pfet"
	    ?areaCap               (TECHgetRule "cgox_p_ca")
	    ?sidewallCap           (TECHgetRule "cgox_p_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_p")
	    ?diode                 'pdiode
	    ?hspiceModel           "psrf_5p18m2_b"
	    ?lsimModel             "TPS"
	    ?isElement             t
	    ?minGateLength         0.18
	    ?minGateWidth          5.05
	    ?discreteWLs           '(("0.18" ("5.05"))) 
	    ?contactRes            (TECHgetRule "rcl1p")
	    ?diffSheetRes          (TECHgetRule "rsp")
	    ?isSubckt              t
	    ?deviceInfo            "Vt=-890mV  Vcc=1.8V"
	    ?rfDeviceInfo          "psrf_5p18m2_b"
	    ?mapToCell             "s8rf_pshort_W5p0_L0p18_M2_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'pshort_W5p0_L0p18_M4_b
	    ?cellName              "pfet"
	    ?areaCap               (TECHgetRule "cgox_p_ca")
	    ?sidewallCap           (TECHgetRule "cgox_p_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_p")
	    ?diode                 'pdiode
	    ?hspiceModel           "psrf_5p18m4_b"
	    ?lsimModel             "TPS"
	    ?isElement             t
	    ?minGateLength         0.18
	    ?minGateWidth          5.05
	    ?discreteWLs           '(("0.18" ("5.05"))) 
	    ?contactRes            (TECHgetRule "rcl1p")
	    ?diffSheetRes          (TECHgetRule "rsp")
	    ?isSubckt              t
	    ?deviceInfo            "Vt=-890mV  Vcc=1.8V"
	    ?rfDeviceInfo          "psrf_5p18m4_b"
	    ?mapToCell             "s8rf_pshort_W5p0_L0p18_M4_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'pshort_W5p0_L0p25_M2_b
	    ?cellName              "pfet"
	    ?areaCap               (TECHgetRule "cgox_p_ca")
	    ?sidewallCap           (TECHgetRule "cgox_p_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_p")
	    ?diode                 'pdiode
	    ?hspiceModel           "psrf_5p25m2_b"
	    ?lsimModel             "TPS"
	    ?isElement             t
	    ?minGateLength         0.25
	    ?minGateWidth          5.05
	    ?discreteWLs           '(("0.25" ("5.05"))) 
	    ?contactRes            (TECHgetRule "rcl1p")
	    ?diffSheetRes          (TECHgetRule "rsp")
	    ?isSubckt              t
	    ?deviceInfo            "Vt=-935mV  Vcc=1.8V"
	    ?rfDeviceInfo          "psrf_5p25m2_b"
	    ?mapToCell             "s8rf_pshort_W5p0_L0p25_M2_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'pshort_W5p0_L0p25_M4_b
	    ?cellName              "pfet"
	    ?areaCap               (TECHgetRule "cgox_p_ca")
	    ?sidewallCap           (TECHgetRule "cgox_p_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_p")
	    ?diode                 'pdiode
	    ?hspiceModel           "psrf_5p25m4_b"
	    ?lsimModel             "TPS"
	    ?isElement             t
	    ?minGateLength         0.25
	    ?minGateWidth          5.05
	    ?discreteWLs           '(("0.25" ("5.05"))) 
	    ?contactRes            (TECHgetRule "rcl1p")
	    ?diffSheetRes          (TECHgetRule "rsp")
	    ?isSubckt              t
	    ?deviceInfo            "Vt=-935mV  Vcc=1.8V"
	    ?rfDeviceInfo          "psrf_5p25m4_b"
	    ?mapToCell             "s8rf_pshort_W5p0_L0p25_M4_b"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )

;;MVO add

(TECHdefMos ?name                  'pshort_W0p84_L0p15_2F
	    ?cellName              "pfet"
	    ?areaCap               (TECHgetRule "cgox_p_ca")
	    ?sidewallCap           (TECHgetRule "cgox_p_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_p")
	    ?diode                 'pdiode
	    ?hspiceModel           "psrf_p84p15nf2"
	    ?lsimModel             "TPS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          0.84
	    ?discreteWLs           '(("0.15" ("0.84"))) 
	    ?contactRes            (TECHgetRule "rcl1p")
	    ?diffSheetRes          (TECHgetRule "rsp")
	    ?isSubckt              t
	    ?deviceInfo            "Vt=-650mV  Vcc=1.8V"
	    ?rfDeviceInfo          "psrf_p84p15nf2"
	    ?mapToCell             "s8rf_pshort_W0p84_L0p15_2F"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )

(TECHdefMos ?name                  'pshort_W1p68_L0p15_2F
	    ?cellName              "pfet"
	    ?areaCap               (TECHgetRule "cgox_p_ca")
	    ?sidewallCap           (TECHgetRule "cgox_p_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_p")
	    ?diode                 'pdiode
	    ?hspiceModel           "psrf_1p68p15nf2"
	    ?lsimModel             "TPS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          1.68
	    ?discreteWLs           '(("0.15" ("1.68"))) 
	    ?contactRes            (TECHgetRule "rcl1p")
	    ?diffSheetRes          (TECHgetRule "rsp")
	    ?isSubckt              t
	    ?deviceInfo            "Vt=-674mV  Vcc=1.8V"
	    ?rfDeviceInfo          "psrf_1p68p15nf2"
	    ?mapToCell             "s8rf_pshort_W1p68_L0p15_2F"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )

(TECHdefMos ?name                  'pshort_W1p68_L0p15_4F
	    ?cellName              "pfet"
	    ?areaCap               (TECHgetRule "cgox_p_ca")
	    ?sidewallCap           (TECHgetRule "cgox_p_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_p")
	    ?diode                 'pdiode
	    ?hspiceModel           "psrf_1p68p15nf4"
	    ?lsimModel             "TPS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          1.68
	    ?discreteWLs           '(("0.15" ("1.68"))) 
	    ?contactRes            (TECHgetRule "rcl1p")
	    ?diffSheetRes          (TECHgetRule "rsp")
	    ?isSubckt              t
	    ?deviceInfo            "Vt=-710mV  Vcc=1.8V"
	    ?rfDeviceInfo          "psrf_1p68p15nf4"
	    ?mapToCell             "s8rf_pshort_W1p68_L0p15_4F"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'pshort_W3p0_L0p15_2F
	    ?cellName              "pfet"
	    ?areaCap               (TECHgetRule "cgox_p_ca")
	    ?sidewallCap           (TECHgetRule "cgox_p_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_p")
	    ?diode                 'pdiode
	    ?hspiceModel           "psrf_3p15nf2"
	    ?lsimModel             "TPS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          3.00
	    ?discreteWLs           '(("0.15" ("3.00"))) 
	    ?contactRes            (TECHgetRule "rcl1p")
	    ?diffSheetRes          (TECHgetRule "rsp")
	    ?isSubckt              t
	    ?deviceInfo            "Vt=-688mV  Vcc=1.8V"
	    ?rfDeviceInfo          "psrf_3p15nf2"
	    ?mapToCell             "s8rf_pshort_W3p0_L0p15_2F"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
(TECHdefMos ?name                  'pshort_W5p0_L0p15_2F
	    ?cellName              "pfet"
	    ?areaCap               (TECHgetRule "cgox_p_ca")
	    ?sidewallCap           (TECHgetRule "cgox_p_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_p")
	    ?diode                 'pdiode
	    ?hspiceModel           "psrf_5p15nf2"
	    ?lsimModel             "TPS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          5.00
	    ?discreteWLs           '(("0.15" ("5.00"))) 
	    ?contactRes            (TECHgetRule "rcl1p")
	    ?diffSheetRes          (TECHgetRule "rsp")
	    ?isSubckt              t
	    ?deviceInfo            "Vt=-696mV  Vcc=1.8V"
	    ?rfDeviceInfo          "psrf_5p15nf2"
	    ?mapToCell             "s8rf_pshort_W5p0_L0p15_2F"
	    ?useMultNF             t
	    ?mapToLib              "s8rf"
	    )
;;; pmedlvt
(TECHdefMos ?name                  'pmedlvt_W0p84_L0p15_2F
      ?cellName              "pfet"
      ?areaCap               (TECHgetRule "cgox_p_ca")
      ?sidewallCap           (TECHgetRule "cgox_p_csw")
      ?lDelta                (TECHgetRule "ldelta")
      ?wDelta                (TECHgetRule "wdelta_p")
      ?diode                 'pdiode
      ?hspiceModel           "pmedlvtrf_p84p15nf2"
      ?lsimModel             "TPS"
      ?isElement             t
      ?minGateLength         0.15
      ?minGateWidth          0.84
      ?discreteWLs           '(("0.15" ("0.84")))
      ?contactRes            (TECHgetRule "rcl1p")
      ?diffSheetRes          (TECHgetRule "rsp")
      ?isSubckt              t
      ?deviceInfo            "Vcc=1.8V"
      ?rfDeviceInfo          "pmedlvtrf_p84p15nf2"
      ?mapToCell             "s8rf_pmedlvt_W0p84_L0p15_2F"
      ?useMultNF             t
      ?mapToLib              "s8rf"
      )
(TECHdefMos ?name                  'pmedlvt_W1p68_L0p15_2F
      ?cellName              "pfet"
      ?areaCap               (TECHgetRule "cgox_p_ca")
      ?sidewallCap           (TECHgetRule "cgox_p_csw")
      ?lDelta                (TECHgetRule "ldelta")
      ?wDelta                (TECHgetRule "wdelta_p")
      ?diode                 'pdiode
      ?hspiceModel           "pmedlvtrf_1p68p15nf2"
      ?lsimModel             "TPS"
      ?isElement             t
      ?minGateLength         0.15
      ?minGateWidth          1.68
      ?discreteWLs           '(("0.15" ("1.68")))
      ?contactRes            (TECHgetRule "rcl1p")
      ?diffSheetRes          (TECHgetRule "rsp")
      ?isSubckt              t
      ?deviceInfo            "Vcc=1.8V"
      ?rfDeviceInfo          "pmedlvtrf_1p68p15nf2"
      ?mapToCell             "s8rf_pmedlvt_W1p68_L0p15_2F"
      ?useMultNF             t
      ?mapToLib              "s8rf"
      )
(TECHdefMos ?name                  'pmedlvt_W1p68_L0p15_4F
      ?cellName              "pfet"
      ?areaCap               (TECHgetRule "cgox_p_ca")
      ?sidewallCap           (TECHgetRule "cgox_p_csw")
      ?lDelta                (TECHgetRule "ldelta")
      ?wDelta                (TECHgetRule "wdelta_p")
      ?diode                 'pdiode
      ?hspiceModel           "pmedlvtrf_1p68p15nf4"
      ?lsimModel             "TPS"
      ?isElement             t
      ?minGateLength         0.15
      ?minGateWidth          1.68
      ?discreteWLs           '(("0.15" ("1.68")))
      ?contactRes            (TECHgetRule "rcl1p")
      ?diffSheetRes          (TECHgetRule "rsp")
      ?isSubckt              t
      ?deviceInfo            "Vcc=1.8V"
      ?rfDeviceInfo          "pmedlvtrf_1p68p15nf4"
      ?mapToCell             "s8rf_pmedlvt_W1p68_L0p15_4F"
      ?useMultNF             t
      ?mapToLib              "s8rf"
      )
(TECHdefMos ?name                  'sonosPnfet
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "sonos_p"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          0.35
	    ?sonos                 t
	    ?deepNwell		   t
	    ?ptype                 "programmed"
	    ?vtype                 "maxv"
	    ?latch                 nil
	    ?discreteWLs           sonos_pLWs
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deviceInfo            "Vt=1.00V"
	    ?fetGateSpacing        (TECHgetRuleWith "minSpacing" "poly")
)

(TECHdefMos ?name                  'sonosEnfet
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "sonos_e"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          0.35
	    ?sonos                 t
	    ?deepNwell		   t
	    ?ptype                 "erased"
	    ?vtype                 "maxv"
	    ?latch                 nil
	    ?discreteWLs           sonos_eLWs
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deviceInfo            "Vt=-1.00V"
	    ?fetGateSpacing        (TECHgetRuleWith "minSpacing" "poly")
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Define met4 capacitors - parasitic
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (TECHdefCap ?name           'cmimc1
        ?cellName       "cmimc"
        ?layers         '("capm" "met3")
        ?hspiceModel    "xcmimc1"
        ?areaCap        (TECHgetRule "camimc")
        ?perimCap       (TECHgetRule "cpmimc")
        ?isSubckt       t
  )
  (TECHdefCap ?name           'cmimc2
        ?cellName       "cmimc"
        ?layers         '("cap2m" "met4")
        ?hspiceModel    "xcmimc2"
        ?areaCap        (TECHgetRule "camimc")
        ?perimCap       (TECHgetRule "cpmimc")
        ?isSubckt       t
  )
  (TECHdefCap ?name           'cm4f
	      ?cellName       "cap2"
	      ?layers         '("met4" "field")
	      ?hspiceModel    "mcm4f"
	      ?spacings       m4_spacings
	      ?widths         m4_widths
              ?areaCap        (TECHgetRule "met4_psub_ca")
              ?spaceCap       (TECHgetRule "met4_psub_cs")
              ?perimCap       (TECHgetRule "met4_psub_cp")
  )
  (TECHdefCap ?name           'cm4d
	      ?cellName       "cap2"
	      ?layers         '("met4" "active")
	      ?hspiceModel    "mcm4d"
	      ?spacings       m4_spacings
	      ?widths         m4_widths
	      ?areaCap        (TECHgetRule "met4_pplus_ca")
	      ?perimCap       (TECHgetRule "met4_pplus_cp")
	      ?spaceCap       (TECHgetRule "met4_pplus_cs")
  )
  (TECHdefCap ?name           'cm4p1
	      ?cellName       "cap2"
	      ?layers         '("met4" "poly")
	      ?hspiceModel    "mcm4p1"
	      ?spacings       m4_spacings
	      ?widths         m4_widths
	      ?areaCap        (TECHgetRule "met4_poly_ca")
	      ?perimCap       (TECHgetRule "met4_poly_cp")
	      ?spaceCap       (TECHgetRule "met4_poly_cs")
  )
  (TECHdefCap ?name           'cm4l1
	      ?cellName       "cap2"
	      ?layers         '("met4" "li1")
	      ?hspiceModel    "mcm4l1"
	      ?spacings       m4_spacings
	      ?widths         m4_widths
	      ?areaCap        (TECHgetRule "met4_li1_ca")
	      ?perimCap       (TECHgetRule "met4_li1_cp")
	      ?spaceCap       (TECHgetRule "met4_li1_cs")
  )
  (TECHdefCap ?name           'cm4m1
	      ?cellName       "cap2"
	      ?layers         '("met4" "met1")
	      ?hspiceModel    "mcm4m1"
	      ?spacings       m4_spacings
	      ?widths         m4_widths
	      ?areaCap        (TECHgetRule "met4_met1_ca")
	      ?perimCap       (TECHgetRule "met4_met1_cp")
	      ?spaceCap       (TECHgetRule "met4_met1_cs")
  )
  (TECHdefCap ?name           'cm4m2
	      ?cellName       "cap2"
	      ?layers         '("met4" "met2")
	      ?hspiceModel    "mcm4m2"
	      ?spacings       m4_spacings
	      ?widths         m4_widths
	      ?areaCap        (TECHgetRule "met4_met2_ca")
	      ?perimCap       (TECHgetRule "met4_met2_cp")
	      ?spaceCap       (TECHgetRule "met4_met2_cs")
  )
  (TECHdefCap ?name           'cm4m3
	      ?cellName       "cap2"
	      ?layers         '("met4" "met3")
	      ?hspiceModel    "mcm4m3"
	      ?spacings       m4_spacings
	      ?widths         m4_widths
	      ?areaCap        (TECHgetRule "met4_met3_ca")
	      ?perimCap       (TECHgetRule "met4_met3_cp")
	      ?spaceCap       (TECHgetRule "met4_met3_cs")
  )
  (TECHdefCap ?name           'cm4p1f
	      ?cellName       "cap2"
	      ?layers         '("met4" "poly" "field")
	      ?hspiceModel    "mcm4p1f"
	      ?spacings       poly_spacings
	      ?widths         poly_widths
  )
  (TECHdefCap ?name           'cm4l1f
	      ?cellName       "cap2"
	      ?layers         '("met4" "li1" "field")
	      ?hspiceModel    "mcm4l1f"
	      ?spacings       l1_spacings
	      ?widths         l1_widths
  )
  (TECHdefCap ?name           'cm4l1d
	      ?cellName       "cap2"
	      ?layers         '("met4" "li1" "active")
	      ?hspiceModel    "mcm4l1d"
	      ?spacings       l1_spacings
	      ?widths         l1_widths
  )
  (TECHdefCap ?name           'cm4l1p1
	      ?cellName       "cap2"
	      ?layers         '("met4" "li1" "poly")
	      ?hspiceModel    "mcm4l1p1"
	      ?spacings       l1_spacings
	      ?widths         l1_widths
  )
  (TECHdefCap ?name           'cm4m1f
	      ?cellName       "cap2"
	      ?layers         '("met4" "met1" "field")
	      ?hspiceModel    "mcm4m1f"
	      ?spacings       m1_spacings
	      ?widths         m1_widths
  )
  (TECHdefCap ?name           'cm4m1d
	      ?cellName       "cap2"
	      ?layers         '("met4" "met1" "active")
	      ?hspiceModel    "mcm4m1d"
	      ?spacings       m1_spacings
	      ?widths         m1_widths
  )
  (TECHdefCap ?name           'cm4m1p1
	      ?cellName       "cap2"
	      ?layers         '("met4" "met1" "poly")
	      ?hspiceModel    "mcm4m1p1"
	      ?spacings       m1_spacings
	      ?widths         m1_widths
  )
  (TECHdefCap ?name           'cm4m1l1
	      ?cellName       "cap2"
	      ?layers         '("met4" "met1" "li1")
	      ?hspiceModel    "mcm4m1l1"
	      ?spacings       m1_spacings
	      ?widths         m1_widths
  )
  (TECHdefCap ?name           'cm4m2f
	      ?cellName       "cap2"
	      ?layers         '("met4" "met2" "field")
	      ?hspiceModel    "mcm4m2f"
	      ?spacings       m2_spacings
	      ?widths         m2_widths
  )
  (TECHdefCap ?name           'cm4m2d
	      ?cellName       "cap2"
	      ?layers         '("met4" "met2" "active")
	      ?hspiceModel    "mcm4m2d"
	      ?spacings       m2_spacings
	      ?widths         m2_widths
  )
  (TECHdefCap ?name           'cm4m2p1
	      ?cellName       "cap2"
	      ?layers         '("met4" "met2" "poly")
	      ?hspiceModel    "mcm4m2p1"
	      ?spacings       m2_spacings
	      ?widths         m2_widths
  )
  (TECHdefCap ?name           'cm4m2l1
	      ?cellName       "cap2"
	      ?layers         '("met4" "met2" "li1")
	      ?hspiceModel    "mcm4m2l1"
	      ?spacings       m2_spacings
	      ?widths         m2_widths
  )
  (TECHdefCap ?name           'cm4m2m1
	      ?cellName       "cap2"
	      ?layers         '("met4" "met2" "met1")
	      ?hspiceModel    "mcm4m2m1"
	      ?spacings       m2_spacings
	      ?widths         m2_widths
  )
  (TECHdefCap ?name           'cm4m3f
	      ?cellName       "cap2"
	      ?layers         '("met4" "met3" "field")
	      ?hspiceModel    "mcm4m3f"
	      ?spacings       m3_spacings
	      ?widths         m3_widths
  )
  (TECHdefCap ?name           'cm4m3d
	      ?cellName       "cap2"
	      ?layers         '("met4" "met3" "active")
	      ?hspiceModel    "mcm4m3d"
	      ?spacings       m3_spacings
	      ?widths         m3_widths
  )
  (TECHdefCap ?name           'cm4m3p1
	      ?cellName       "cap2"
	      ?layers         '("met4" "met3" "poly")
	      ?hspiceModel    "mcm4m3p1"
	      ?spacings       m3_spacings
	      ?widths         m3_widths
  )
  (TECHdefCap ?name           'cm4m3l1
	      ?cellName       "cap2"
	      ?layers         '("met4" "met3" "li1")
	      ?hspiceModel    "mcm4m3l1"
	      ?spacings       m3_spacings
	      ?widths         m3_widths
  )
  (TECHdefCap ?name           'cm4m3m1
	      ?cellName       "cap2"
	      ?layers         '("met4" "met3" "met1")
	      ?hspiceModel    "mcm4m3m1"
	      ?spacings       m3_spacings
	      ?widths         m3_widths
  )
  (TECHdefCap ?name           'cm4m3m2
	      ?cellName       "cap2"
	      ?layers         '("met4" "met3" "met2")
	      ?hspiceModel    "mcm4m3m2"
	      ?spacings       m3_spacings
	      ?widths         m3_widths
  )
  (TECHdefCap ?name           'cm5p1f
	      ?cellName       "cap2"
	      ?layers         '("met5" "poly" "field")
	      ?hspiceModel    "mcm5p1f"
	      ?spacings       poly_spacings
	      ?widths         poly_widths
  )

 (TECHdefCap ?name           'cm5l1f
	      ?cellName       "cap2"
	      ?layers         '("met5" "li1" "field")
	      ?hspiceModel    "mcm5l1f"
	      ?spacings       l1_spacings
	      ?widths         l1_widths
  )
(TECHdefCap ?name           'cm5l1d
	      ?cellName       "cap2"
	      ?layers         '("met5" "li1" "active")
	      ?hspiceModel    "mcm5l1d"
	      ?spacings       l1_spacings
	      ?widths         l1_widths
  )
  (TECHdefCap ?name           'cm5l1p1
	      ?cellName       "cap2"
	      ?layers         '("met5" "li1" "poly")
	      ?hspiceModel    "mcm5l1p1"
	      ?spacings       l1_spacings
	      ?widths         l1_widths
  )
(TECHdefCap ?name           'cm5m1f
	      ?cellName       "cap2"
	      ?layers         '("met5" "met1" "field")
	      ?hspiceModel    "mcm5m1f"
	      ?spacings       m1_spacings
	      ?widths         m1_widths
  )
  (TECHdefCap ?name           'cm5m1d
	      ?cellName       "cap2"
	      ?layers         '("met5" "met1" "active")
	      ?hspiceModel    "mcm5m1d"
	      ?spacings       m1_spacings
	      ?widths         m1_widths
  )
  (TECHdefCap ?name           'cm5m1p1
	      ?cellName       "cap2"
	      ?layers         '("met5" "met1" "poly")
	      ?hspiceModel    "mcm5m1p1"
	      ?spacings       m1_spacings
	      ?widths         m1_widths
  )
  (TECHdefCap ?name           'cm5m1l1
	      ?cellName       "cap2"
	      ?layers         '("met5" "met1" "li1")
	      ?hspiceModel    "mcm5m1l1"
	      ?spacings       m1_spacings
	      ?widths         m1_widths
  )
(TECHdefCap ?name           'cm5m2f
	      ?cellName       "cap2"
	      ?layers         '("met5" "met2" "field")
	      ?hspiceModel    "mcm5m2f"
	      ?spacings       m2_spacings
	      ?widths         m2_widths
  )
  (TECHdefCap ?name           'cm5m2d
	      ?cellName       "cap2"
	      ?layers         '("met5" "met2" "active")
	      ?hspiceModel    "mcm5m2d"
	      ?spacings       m2_spacings
	      ?widths         m2_widths
  )
  (TECHdefCap ?name           'cm5m2p1
	      ?cellName       "cap2"
	      ?layers         '("met5" "met2" "poly")
	      ?hspiceModel    "mcm5m2p1"
	      ?spacings       m2_spacings
	      ?widths         m2_widths
  )
  (TECHdefCap ?name           'cm5m2l1
	      ?cellName       "cap2"
	      ?layers         '("met5" "met2" "li1")
	      ?hspiceModel    "mcm5m2l1"
	      ?spacings       m2_spacings
	      ?widths         m2_widths
  )
  (TECHdefCap ?name           'cm5m2m1
	      ?cellName       "cap2"
	      ?layers         '("met5" "met2" "met1")
	      ?hspiceModel    "mcm5m2m1"
	      ?spacings       m2_spacings
	      ?widths         m2_widths
  )
  (TECHdefCap ?name           'cm5m3f
	      ?cellName       "cap2"
	      ?layers         '("met5" "met3" "field")
	      ?hspiceModel    "mcm5m3f"
	      ?spacings       m3_spacings
	      ?widths         m3_widths
  )
  (TECHdefCap ?name           'cm5m3d
	      ?cellName       "cap2"
	      ?layers         '("met5" "met3" "active")
	      ?hspiceModel    "mcm5m3d"
	      ?spacings       m3_spacings
	      ?widths         m3_widths
  )
  (TECHdefCap ?name           'cm5m3p1
	      ?cellName       "cap2"
	      ?layers         '("met5" "met3" "poly")
	      ?hspiceModel    "mcm5m3p1"
	      ?spacings       m3_spacings
	      ?widths         m3_widths
  )
  (TECHdefCap ?name           'cm5m3l1
	      ?cellName       "cap2"
	      ?layers         '("met5" "met3" "li1")
	      ?hspiceModel    "mcm5m3l1"
	      ?spacings       m3_spacings
	      ?widths         m3_widths
  )
  (TECHdefCap ?name           'cm5m3m1
	      ?cellName       "cap2"
	      ?layers         '("met5" "met3" "met1")
	      ?hspiceModel    "mcm5m3m1"
	      ?spacings       m3_spacings
	      ?widths         m3_widths
  )
  (TECHdefCap ?name           'cm5m3m2
	      ?cellName       "cap2"
	      ?layers         '("met5" "met3" "met2")
	      ?hspiceModel    "mcm5m3m2"
	      ?spacings       m3_spacings
	      ?widths         m3_widths
  )

(TECHdefCap ?name           'cm5m4f
	      ?cellName       "cap2"
	      ?layers         '("met5" "met4" "field")
	      ?hspiceModel    "mcm5m4f"
	      ?spacings       m4_spacings
	      ?widths         m4_widths
  )
  (TECHdefCap ?name           'cm5m4d
	      ?cellName       "cap2"
	      ?layers         '("met5" "met4" "active")
	      ?hspiceModel    "mcm5m4d"
	      ?spacings       m4_spacings
	      ?widths         m4_widths
  )
  (TECHdefCap ?name           'cm5m4p1
	      ?cellName       "cap2"
	      ?layers         '("met5" "met4" "poly")
	      ?hspiceModel    "mcm5m4p1"
	      ?spacings       m4_spacings
	      ?widths         m4_widths
  )
  (TECHdefCap ?name           'cm5m4l1
	      ?cellName       "cap2"
	      ?layers         '("met5" "met4" "li1")
	      ?hspiceModel    "mcm5m4l1"
	      ?spacings       m4_spacings
	      ?widths         m4_widths
  )
  (TECHdefCap ?name           'cm5m4m1
	      ?cellName       "cap2"
	      ?layers         '("met5" "met4" "met1")
	      ?hspiceModel    "mcm5m4m1"
	      ?spacings       m4_spacings
	      ?widths         m4_widths
  )
  (TECHdefCap ?name           'cm5m4m2
	      ?cellName       "cap2"
	      ?layers         '("met5" "met4" "met2")
	      ?hspiceModel    "mcm5m4m2"
	      ?spacings       m4_spacings
	      ?widths         m4_widths
  )
(TECHdefCap ?name           'cm5m4m3
	      ?cellName       "cap2"
	      ?layers         '("met5" "met4" "met3")
	      ?hspiceModel    "mcm5m4m3"
	      ?spacings       m4_spacings
	      ?widths         m4_widths
  )
  (TECHdefCap ?name           'cm5f
	      ?cellName       "cap2"
	      ?layers         '("met5" "field")
	      ?hspiceModel    "mcm5f"
	      ?spacings       m5_spacings
	      ?widths         m5_widths
              ?areaCap        (TECHgetRule "met5_psub_ca")
              ?spaceCap       (TECHgetRule "met5_psub_cs")
              ?perimCap       (TECHgetRule "met5_psub_cp")
  )
  (TECHdefCap ?name           'cm5d
	      ?cellName       "cap2"
	      ?layers         '("met5" "active")
	      ?hspiceModel    "mcm5d"
	      ?spacings       m5_spacings
	      ?widths         m5_widths
	      ?areaCap        (TECHgetRule "met5_pplus_ca")
	      ?perimCap       (TECHgetRule "met5_pplus_cp")
	      ?spaceCap       (TECHgetRule "met5_pplus_cs")
  )
  (TECHdefCap ?name           'cm5p1
	      ?cellName       "cap2"
	      ?layers         '("met5" "poly")
	      ?hspiceModel    "mcm5p1"
	      ?spacings       m5_spacings
	      ?widths         m5_widths
	      ?areaCap        (TECHgetRule "met5_poly_ca")
	      ?perimCap       (TECHgetRule "met5_poly_cp")
	      ?spaceCap       (TECHgetRule "met5_poly_cs")
  )
  (TECHdefCap ?name           'cm5l1
	      ?cellName       "cap2"
	      ?layers         '("met5" "li1")
	      ?hspiceModel    "mcm5l1"
	      ?spacings       m5_spacings
	      ?widths         m5_widths
	      ?areaCap        (TECHgetRule "met5_li1_ca")
	      ?perimCap       (TECHgetRule "met5_li1_cp")
	      ?spaceCap       (TECHgetRule "met5_li1_cs")
  )
  (TECHdefCap ?name           'cm5m1
	      ?cellName       "cap2"
	      ?layers         '("met5" "met1")
	      ?hspiceModel    "mcm5m1"
	      ?spacings       m5_spacings
	      ?widths         m5_widths
	      ?areaCap        (TECHgetRule "met5_met1_ca")
	      ?perimCap       (TECHgetRule "met5_met1_cp")
	      ?spaceCap       (TECHgetRule "met5_met1_cs")
  )
  (TECHdefCap ?name           'cm5m2
	      ?cellName       "cap2"
	      ?layers         '("met5" "met2")
	      ?hspiceModel    "mcm5m2"
	      ?spacings       m5_spacings
	      ?widths         m5_widths
	      ?areaCap        (TECHgetRule "met5_met2_ca")
	      ?perimCap       (TECHgetRule "met5_met2_cp")
	      ?spaceCap       (TECHgetRule "met5_met2_cs")
  )
  (TECHdefCap ?name           'cm5m3
	      ?cellName       "cap2"
	      ?layers         '("met5" "met3")
	      ?hspiceModel    "mcm5m3"
	      ?spacings       m5_spacings
	      ?widths         m5_widths
	      ?areaCap        (TECHgetRule "met5_met3_ca")
	      ?perimCap       (TECHgetRule "met5_met3_cp")
	      ?spaceCap       (TECHgetRule "met5_met3_cs")
  )
   (TECHdefCap ?name           'cm5m4
	      ?cellName       "cap2"
	      ?layers         '("met5" "met4")
	      ?hspiceModel    "mcm5m4"
	      ?spacings       m5_spacings
	      ?widths         m5_widths
	      ?areaCap        (TECHgetRule "met5_met4_ca")
	      ?perimCap       (TECHgetRule "met5_met4_cp")
	      ?spaceCap       (TECHgetRule "met5_met4_cs")
  )


(TECHdefCap ?name           'crdlp1f
            ?cellName       "cap2"
            ?layers         '("rdl" "poly" "field")
            ?hspiceModel    "mcrdlp1f"
            ?spacings       poly_spacings
            ?widths         poly_widths
            )

(TECHdefCap ?name           'crdlm1f
          ?cellName       "cap2"
          ?layers         '("rdl" "met1" "field")
          ?hspiceModel    "mcrdlm1f"
          ?spacings       m1_spacings
          ?widths         m1_widths
          )
(TECHdefCap ?name           'crdlm1d
            ?cellName       "cap2"
            ?layers         '("rdl" "met1" "active")
            ?hspiceModel    "mcrdlm1d"
            ?spacings       m1_spacings
            ?widths         m1_widths
            )
(TECHdefCap ?name           'crdlm1p1
            ?cellName       "cap2"
            ?layers         '("rdl" "met1" "poly")
            ?hspiceModel    "mcrdlm1p1"
            ?spacings       m1_spacings
            ?widths         m1_widths
            )

(TECHdefCap ?name           'crdlm2f
          ?cellName       "cap2"
          ?layers         '("rdl" "met2" "field")
          ?hspiceModel    "mcrdlm2f"
          ?spacings       m2_spacings
          ?widths         m2_widths
          )
(TECHdefCap ?name           'crdlm2d
            ?cellName       "cap2"
            ?layers         '("rdl" "met2" "active")
            ?hspiceModel    "mcrdlm2d"
            ?spacings       m2_spacings
            ?widths         m2_widths
            )
(TECHdefCap ?name           'crdlm2p1
            ?cellName       "cap2"
            ?layers         '("rdl" "met2" "poly")
            ?hspiceModel    "mcrdlm2p1"
            ?spacings       m2_spacings
            ?widths         m2_widths
            )
(TECHdefCap ?name           'crdlm2m1
            ?cellName       "cap2"
            ?layers         '("rdl" "met2" "met1")
            ?hspiceModel    "mcrdlm2m1"
            ?spacings       m2_spacings
            ?widths         m2_widths
            )

(TECHdefCap ?name           'crdlm3f
          ?cellName       "cap2"
          ?layers         '("rdl" "met3" "field")
          ?hspiceModel    "mcrdlm3f"
          ?spacings       m3_spacings
          ?widths         m3_widths
          )
(TECHdefCap ?name           'crdlm3d
            ?cellName       "cap2"
            ?layers         '("rdl" "met3" "active")
            ?hspiceModel    "mcrdlm3d"
            ?spacings       m3_spacings
            ?widths         m3_widths
            )
(TECHdefCap ?name           'crdlm3p1
            ?cellName       "cap2"
            ?layers         '("rdl" "met3" "poly")
            ?hspiceModel    "mcrdlm3p1"
            ?spacings       m3_spacings
            ?widths         m3_widths
            )
(TECHdefCap ?name           'crdlm3m1
            ?cellName       "cap2"
            ?layers         '("rdl" "met3" "met1")
            ?hspiceModel    "mcrdlm3m1"
            ?spacings       m3_spacings
            ?widths         m3_widths
            )
(TECHdefCap ?name           'crdlm3m2
            ?cellName       "cap2"
            ?layers         '("rdl" "met3" "met2")
            ?hspiceModel    "mcrdlm3m2"
            ?spacings       m3_spacings
            ?widths         m3_widths
            )
(TECHdefCap ?name           'crdlm4f
          ?cellName       "cap2"
          ?layers         '("rdl" "met4" "field")
          ?hspiceModel    "mcrdlm4f"
          ?spacings       m4_spacings
          ?widths         m4_widths
          )
(TECHdefCap ?name           'crdlm4d
            ?cellName       "cap2"
            ?layers         '("rdl" "met4" "active")
            ?hspiceModel    "mcrdlm4d"
            ?spacings       m4_spacings
            ?widths         m4_widths
            )
(TECHdefCap ?name           'crdlm4p1
            ?cellName       "cap2"
            ?layers         '("rdl" "met4" "poly")
            ?hspiceModel    "mcrdlm4p1"
            ?spacings       m4_spacings
            ?widths         m4_widths
            )
(TECHdefCap ?name           'crdlm4m1
            ?cellName       "cap2"
            ?layers         '("rdl" "met4" "met1")
            ?hspiceModel    "mcrdlm4m1"
            ?spacings       m4_spacings
            ?widths         m4_widths
            )
(TECHdefCap ?name           'crdlm4m2
            ?cellName       "cap2"
            ?layers         '("rdl" "met4" "met2")
            ?hspiceModel    "mcrdlm4m2"
            ?spacings       m4_spacings
            ?widths         m4_widths
            )
(TECHdefCap ?name           'crdlm4m3
            ?cellName       "cap2"
            ?layers         '("rdl" "met4" "met3")
            ?hspiceModel    "mcrdlm4m3"
            ?spacings       m4_spacings
            ?widths         m4_widths
            )

(TECHdefCap ?name           'crdlm5f
          ?cellName       "cap2"
          ?layers         '("rdl" "met5" "field")
          ?hspiceModel    "mcrdlm5f"
          ?spacings       m5_spacings
          ?widths         m5_widths
          )
(TECHdefCap ?name           'crdlm5d
            ?cellName       "cap2"
            ?layers         '("rdl" "met5" "active")
            ?hspiceModel    "mcrdlm5d"
            ?spacings       m5_spacings
            ?widths         m5_widths
            )
(TECHdefCap ?name           'crdlm5p1
            ?cellName       "cap2"
            ?layers         '("rdl" "met5" "poly")
            ?hspiceModel    "mcrdlm5p1"
            ?spacings       m5_spacings
            ?widths         m5_widths
            )
(TECHdefCap ?name           'crdlm5m1
            ?cellName       "cap2"
            ?layers         '("rdl" "met5" "met1")
            ?hspiceModel    "mcrdlm5m1"
            ?spacings       m5_spacings
            ?widths         m5_widths
            )
(TECHdefCap ?name           'crdlm5m2
            ?cellName       "cap2"
            ?layers         '("rdl" "met5" "met2")
            ?hspiceModel    "mcrdlm5m2"
            ?spacings       m5_spacings
            ?widths         m5_widths
            )
(TECHdefCap ?name           'crdlm5m3
            ?cellName       "cap2"
            ?layers         '("rdl" "met5" "met3")
            ?hspiceModel    "mcrdlm5m3"
            ?spacings       m5_spacings
            ?widths         m5_widths
            )
(TECHdefCap ?name           'crdlm5m4
            ?cellName       "cap2"
            ?layers         '("rdl" "met5" "met4")
            ?hspiceModel    "mcrdlm5m4"
            ?spacings       m5_spacings
            ?widths         m5_widths
            )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;RDL cap
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(TECHdefCap ?name           'crdlf
            ?cellName       "cap2"
            ?layers         '("rdl" "field")
            ?hspiceModel    "mcrdlf"
            ?spacings       rdl_spacings
            ?widths         rdl_widths
            ;;?areaCap        (TECHgetRule "rrdl_psub_ca")
            ;;?spaceCap       (TECHgetRule "rrdl_psub_cs")
            ;;?perimCap       (TECHgetRule "rrdl_psub_cp")
            )
(TECHdefCap ?name           'crdld
            ?cellName       "cap2"
            ?layers         '("rdl" "active")
            ?hspiceModel    "mcrdld"
            ?spacings       rdl_spacings
            ?widths         rdl_widths
            ;;?areaCap        (TECHgetRule "rrdl_pplus_ca")
            ;;?perimCap       (TECHgetRule "rrdl_pplus_cp")
            ;;?spaceCap       (TECHgetRule "rrdl_pplus_cs")
            )
(TECHdefCap ?name           'crdlp1
            ?cellName       "cap2"
            ?layers         '("rdl" "poly")
            ?hspiceModel    "mcrdlp1"
            ?spacings       rdl_spacings
            ?widths         rdl_widths
            ;;?areaCap        (TECHgetRule "rrdl_poly_ca")
            ;;?perimCap       (TECHgetRule "rrdl_poly_cp")
            ;;?spaceCap       (TECHgetRule "rrdl_poly_cs")
            )
(TECHdefCap ?name           'crdlm1
            ?cellName       "cap2"
            ?layers         '("rdl" "met1")
            ?hspiceModel    "mcrdlm1"
            ?spacings       rdl_spacings
            ?widths         rdl_widths
            ;;?areaCap        (TECHgetRule "rrdl_met1_ca")
            ;;?perimCap       (TECHgetRule "rrdl_met1_cp")
            ;;?spaceCap       (TECHgetRule "rrdl_met1_cs")
            )
(TECHdefCap ?name           'crdlm2
            ?cellName       "cap2"
            ?layers         '("rdl" "met2")
            ?hspiceModel    "mcrdlm2"
            ?spacings       rdl_spacings
            ?widths         rdl_widths
            ;;?areaCap        (TECHgetRule "rrdl_met2_ca")
            ;;?perimCap       (TECHgetRule "rrdl_met2_cp")
            ;;?spaceCap       (TECHgetRule "rrdl_met2_cs")
            )
(TECHdefCap ?name           'crdlm3
            ?cellName       "cap2"
            ?layers         '("rdl" "met3")
            ?hspiceModel    "mcrdlm3"
            ?spacings       rdl_spacings
            ?widths         rdl_widths
            ;;?areaCap        (TECHgetRule "rrdl_met2_ca")
            ;;?perimCap       (TECHgetRule "rrdl_met2_cp")
            ;;?spaceCap       (TECHgetRule "rrdl_met2_cs")
            )
(TECHdefCap ?name           'crdlm4
            ?cellName       "cap2"
            ?layers         '("rdl" "met4")
            ?hspiceModel    "mcrdlm4"
            ?spacings       rdl_spacings
            ?widths         rdl_widths
            ;;?areaCap        (TECHgetRule "rrdl_met2_ca")
            ;;?perimCap       (TECHgetRule "rrdl_met2_cp")
            ;;?spaceCap       (TECHgetRule "rrdl_met2_cs")
            )
(TECHdefCap ?name           'crdlm5
            ?cellName       "cap2"
            ?layers         '("rdl" "met5")
            ?hspiceModel    "mcrdlm5"
            ?spacings       rdl_spacings
            ?widths         rdl_widths
            ;;?areaCap        (TECHgetRule "rrdl_met2_ca")
            ;;?perimCap       (TECHgetRule "rrdl_met2_cp")
            ;;?spaceCap       (TECHgetRule "rrdl_met2_cs")
            )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Define parasitic met5, via4, met4, via3 resistance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(TECHdefResistor ?name         'rrdl
		 ?description  "RDL resistor"
		 ?cellName     "res"
		 ?layer        "rdl"
		 ?sheet        (TECHgetRule "rsrdl")
         	 ?sheetLow     (TECHgetRule "rsrdl_min")
		 ?sheetHigh    (TECHgetRule "rsrdl_max")
		 ?capacitor    rrdl_caplist  
		 ?hspiceModel  "mrmrdl"
	 	 ?contactModel "mrcvia4"
                 ?deltaW       (TECHgetRule "rrdl_dw")
)

(TECHdefResistor ?name         'rm5
		 ?description  "Met5 resistor"
		 ?cellName     "res"
		 ?layer        "met5"
		 ?sheet        (TECHgetRule "rsm5")
         	 ?sheetLow     (TECHgetRule "rsm5_min")
		 ?sheetHigh    (TECHgetRule "rsm5_max")
		 ?capacitor    rm5_caplist  
		 ?hspiceModel  "mrm5"
	 	 ?contactModel "mrcvia4"
                 ?deltaW       (TECHgetRule "rm5_dw")
)

(TECHdefRcon ?name             'rcvia4
	     ?cellName         "rcon"
	     ?layerDown        "met4"
	     ?layerUp          "met5"
	     ?hspiceModel      "mrcvia4"
	     ?contactRes       (TECHgetRule "rcvia4")
	     ?contactResHigh   (TECHgetRule "rcvia4_max")
	     ?contactResLow    (TECHgetRule "rcvia4_min")
)


(TECHdefResistor ?name         'rm4
		 ?description  "Met4 resistor"
		 ?cellName     "res"
		 ?layer        "met4"
		 ?sheet        (TECHgetRule "rsm4")
         	 ?sheetLow     (TECHgetRule "rsm4_min")
		 ?sheetHigh    (TECHgetRule "rsm4_max")
		 ?capacitor    rm4_caplist  
		 ?hspiceModel  "mrm4"
	 	 ?contactModel "mrcvia3"
                 ?deltaW       (TECHgetRule "rm4_dw")
)

(TECHdefRcon ?name             'rcvia3
	     ?cellName         "rcon"
	     ?layerDown        "met3"
	     ?layerUp          "met4"
	     ?hspiceModel      "mrcvia3"
	     ?contactRes       (TECHgetRule "rcvia3")
	     ?contactResHigh   (TECHgetRule "rcvia3_max")
	     ?contactResLow    (TECHgetRule "rcvia3_min")
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; LOAD common devices
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;(TECHinclude (BOOTprependTechPath "../s8x/info/devices.il"))

;;The pfet is not common to the s8tnv-10r flow
(TECHdefMos ?name                  'pfet
	    ?enableLOD             t
	    ?useMultNF             t
	    ?cellName              "pfet"
	    ?areaCap               (TECHgetRule "cgox_p_ca")
	    ?sidewallCap           (TECHgetRule "cgox_p_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_p")
	    ?diode                 'pdiode
	    ?hspiceModel           "pshort"
	    ?lsimModel             "TPS"
	    ?isElement             t
	    ?minGateLength         (TECHgetRule "poly_1a")
	    ?minGateWidth          (TECHgetRule "difftap_2")
	    ?discreteWLs           pshortLWs
	    ?contactRes            (TECHgetRule "rcl1p")
	    ?diffSheetRes          (TECHgetRule "rsp")
	    ?deviceInfo            "Vt=-790mV  Vcc=1.8V"
	    ?pcellIdLayerInfo      "none"
	    ?fetGateSpacing        (TECHgetRuleWith "minSpacing" "poly")
)

(TECHdefMos ?name                  'pfet_dnw
	    ?enableLOD             t
	    ?useMultNF             t
	    ?cellName              "pfet"
	    ?areaCap               (TECHgetRule "cgox_p_ca")
	    ?sidewallCap           (TECHgetRule "cgox_p_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_p")
	    ?diode                 'pdiode
	    ?hspiceModel           "pshort"
	    ?lsimModel             "TPS"
	    ?isElement             t
	    ?minGateLength         (TECHgetRule "poly_1a")
	    ?minGateWidth          (TECHgetRule "difftap_2")
	    ?discreteWLs           pshortLWs
	    ?contactRes            (TECHgetRule "rcl1p")
	    ?diffSheetRes          (TECHgetRule "rsp")
	    ?deepNwell		   t
	    ?deviceInfo            "Vt=-790mV  Vcc=1.8V"
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Define highVt fets
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;The pfet is not common to the s8tnv-10r flow
(TECHdefMos ?name                  'hvtpfet
	    ?enableLOD             t
	    ?useMultNF             t
	    ?cellName              "pfet"
	    ?areaCap               (TECHgetRule "cgox_p_ca")
	    ?sidewallCap           (TECHgetRule "cgox_p_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_p")
	    ?diode                 'pdiode_hvt
	    ?hspiceModel           "phighvt"
	    ?lsimModel             "TPS"
	    ?isElement             t
	    ?highVt                t
	    ?minGateLength         (TECHgetRule "poly_1a")
	    ?minGateWidth          (TECHgetRule "difftap_2")
	    ?discreteWLs           phighVtLWs
	    ?contactRes            (TECHgetRule "rcl1p")
	    ?diffSheetRes          (TECHgetRule "rsp")
	    ?deviceInfo            "Vt=-942mV  Vcc=1.8V"
	    ?pcellIdLayerInfo      (list (list "hvtp" (list 
						      (TECHgetRule "hvtp_3")
						      (TECHgetRule "hvtp_3")
						      (TECHgetRule "hvtp_3")
						      )))
	    ?fetGateSpacing        (TECHgetRuleWith "minSpacing" "poly")
)

(TECHdefMos ?name                  'hvtpfet_dnw
	    ?enableLOD             t
	    ?useMultNF             t
	    ?cellName              "pfet"
	    ?areaCap               (TECHgetRule "cgox_p_ca")
	    ?sidewallCap           (TECHgetRule "cgox_p_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_p")
	    ?diode                 'pdiode_hvt
	    ?hspiceModel           "phighvt"
	    ?lsimModel             "TPS"
	    ?isElement             t
	    ?highVt                t
	    ?minGateLength         (TECHgetRule "poly_1a")
	    ?minGateWidth          (TECHgetRule "difftap_2")
	    ?discreteWLs           phighVtLWs
	    ?contactRes            (TECHgetRule "rcl1p")
	    ?diffSheetRes          (TECHgetRule "rsp")
	    ?deepNwell		   t
	    ?deviceInfo            "Vt=-942mV  Vcc=1.8V"
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Define hv fets
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(TECHdefMos ?name                  'hvpfet
	    ?enableLOD             t
	    ?useMultNF             t
            ?cellName              "pfet"
            ?areaCap               (TECHgetRule "cgox_ph_ca")
            ?sidewallCap           (TECHgetRule "cgox_ph_csw")
            ?lDelta                (TECHgetRule "ldelta")
            ?wDelta                (TECHgetRule "wdelta_p")
            ?diode                 'pdiode_h
            ?hspiceModel           "phv"
	    ?voltageChoices        (list "beyond 0 to 5.5V")
            ?lsimModel             "TNS"
            ?isElement             t
            ?minGateLength         (TECHgetRuleWith "minWidthPolyP" "v5")
            ?minGateWidth          (TECHgetRuleWith "minGateWidth"  "diff")
            ?vtype                 "maxv"
	    ?discreteWLs           phvLWs 
	    ?contactRes            (TECHgetRule "rcl1p")
	    ?diffSheetRes          (TECHgetRule "rsphv")
	    ?deviceInfo            "Vt=-961mV  Vcc=5.0V"
	    ?pcellIdLayerInfo      (list (list "v5" (list 
						      (TECHgetRuleWith "minEnclosureHV" "diff" "nwell") 
						      (TECHgetRuleWith "minEnclosureHV" "diff" "nwell") 
						      (TECHgetRuleWith "minEnclosureHV" "diff" "nwell") 
						      ))
					 (list "nwell" (list 
							(TECHgetRuleWith "minEnclosureHV" "diff" "nwell") 
							(TECHgetRuleWith "minEnclosureHV" "diff" "nwell") 
							(TECHgetRuleWith "minEnclosureHV" "diff" "nwell") 
							)))
	    ?pcellSecIdLayerInfo   (list 
				    (list  (list "diff" "hv") (list
							       (TECHgetRuleWith "minEnclosureHV" "diff" "nwell") 
							       (TECHgetRuleWith "minEnclosureHV" "diff" "nwell") 
							       (TECHgetRuleWith "minEnclosureHV" "diff" "nwell") 
							       )))
	    ?fetGateSpacing        (TECHgetRuleWith "minSpacing" "poly")
)

(TECHdefMos ?name                  'hvpfet_dnw
	    ?enableLOD             t
	    ?useMultNF             t
            ?cellName              "pfet"
            ?areaCap               (TECHgetRule "cgox_ph_ca")
            ?sidewallCap           (TECHgetRule "cgox_ph_csw")
            ?lDelta                (TECHgetRule "ldelta")
            ?wDelta                (TECHgetRule "wdelta_p")
            ?diode                 'pdiode_h
            ?hspiceModel           "phv"
            ?lsimModel             "TNS"
            ?isElement             t
            ?minGateLength         (TECHgetRuleWith "minWidthPolyP" "v5")
            ?minGateWidth          (TECHgetRuleWith "minGateWidth"  "diff")
            ?vtype                 "maxv"
	    ?discreteWLs           phvLWs 
	    ?contactRes            (TECHgetRule "rcl1p")
	    ?diffSheetRes          (TECHgetRule "rsphv")
	    ?deepNwell		   t
	    ?deviceInfo            "Vt=-961mV  Vcc=5.0V"
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Define Core fets
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(TECHdefMos ?name                  'npass
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "npass"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          0.14
	    ?deepNwell		   nil
	    ?vtype                 "corenpass"
	    ?discreteWLs          '(("0.15" ( "0.14")))
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deviceInfo            "none"
)
(TECHdefMos ?name                  'fnpass
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "fnpass"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          0.35
	    ?deepNwell		   nil
	    ?vtype                 "corefnpass"
	    ?discreteWLs          '(("0.15" ( "0.35")))
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deviceInfo            "none"
)

(TECHdefMos ?name                  'npd
	    ?cellName              "nfet"
	    ?areaCap               (TECHgetRule "cgox_n_ca")
	    ?sidewallCap           (TECHgetRule "cgox_n_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_n")
	    ?diode                 'ndiode
	    ?hspiceModel           "npd"
	    ?lsimModel             "TNS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          0.21
	    ?deepNwell		   nil
	    ?vtype                 "corenpd"
	    ?discreteWLs          '(("0.15" ( "0.21")))
	    ?contactRes            (TECHgetRule "rcl1n")
	    ?diffSheetRes          (TECHgetRule "rsn")
	    ?deviceInfo            "none"
)

(TECHdefMos ?name                  'ppu
	    ?cellName              "pfet"
	    ?areaCap               (TECHgetRule "cgox_p_ca")
	    ?sidewallCap           (TECHgetRule "cgox_p_csw")
	    ?lDelta                (TECHgetRule "ldelta")
	    ?wDelta                (TECHgetRule "wdelta_p")
	    ?diode                 'pdiode
	    ?hspiceModel           "ppu"
	    ?lsimModel             "TPS"
	    ?isElement             t
	    ?minGateLength         0.15
	    ?minGateWidth          0.14
	    ?vtype                 "coreppu"
	    ?discreteWLs          '(("0.15" ( "0.14")))
	    ?contactRes            (TECHgetRule "rcl1p")
	    ?diffSheetRes          (TECHgetRule "rsp")
	    ?deviceInfo            "none"
)

(TECHdefCapNotInList ?name           'vppcap_hd5_1
		     ?cellName       "cap_int3"
		     ?description    "12fF"
		     ?layers         '("met1" "met2" "met3" "met4" )
		     ?hspiceModel    "xcmvpp_hd5_1x1"
		     ?isSubckt       t
		     )
(TECHdefCapNotInList ?name           'vppcap_hd5_2
		     ?cellName       "cap_int3"
		     ?description    "12fF"
		     ?layers         '("met1" "met2" "met3" "met4" )
		     ?hspiceModel    "xcmvpp_hd5_1x2"
		     ?isSubckt       t
		     )
(TECHdefCapNotInList ?name           'vppcap_hd5_3
		     ?cellName       "cap_int3"
		     ?description    "12fF"
		     ?layers         '("met1" "met2" "met3" "met4" )
		     ?hspiceModel    "xcmvpp_hd5_2x1"
		     ?isSubckt       t
		     )
(TECHdefCapNotInList ?name           'vppcap_hd5_4
		     ?cellName       "cap_int3"
		     ?description    "12fF"
		     ?layers         '("met1" "met2" "met3" "met4" )
		     ?hspiceModel    "xcmvpp_hd5_2x2"
		     ?isSubckt       t
		     )
(TECHdefCapNotInList ?name           'vppcap_hd5_5
		     ?cellName       "cap_int3"
		     ?description    "12fF"
		     ?layers         '("met1" "met2" "met3" "met4" )
		     ?hspiceModel    "xcmvpp_hd5_3x1"
		     ?isSubckt       t
		     )
(TECHdefCapNotInList ?name           'vppcap_hd5_6
		     ?cellName       "cap_int3"
		     ?description    "12fF"
		     ?layers         '("met1" "met2" "met3" "met4" )
		     ?hspiceModel    "xcmvpp_hd5_3x2"
		     ?isSubckt       t
		     )
(TECHdefCapNotInList ?name           'vppcap_hd5_7
		     ?cellName       "cap_int3"
		     ?description    "12fF"
		     ?layers         '("met1" "met2" "met3" "met4" )
		     ?hspiceModel    "xcmvpp_hd5_4x1"
		     ?isSubckt       t
		     )
(TECHdefCapNotInList ?name           'vppcap_hd5_8
		     ?cellName       "cap_int3"
		     ?description    "12fF"
		     ?layers         '("met1" "met2" "met3" "met4" )
		     ?hspiceModel    "xcmvpp_hd5_4x2"
		     ?isSubckt       t
		     )
(TECHdefCapNotInList ?name           'vppcap_hd5_9
		     ?cellName       "cap_int3"
		     ?description    "12fF"
		     ?layers         '("met1" "met2" "met3" "met4" )
		     ?hspiceModel    "xcmvpp_hd5_5x1"
		     ?isSubckt       t
		     )
(TECHdefCapNotInList ?name           'vppcap_hd5_10
		     ?cellName       "cap_int3"
		     ?description    "12fF"
		     ?layers         '("met1" "met2" "met3" "met4" )
		     ?hspiceModel    "xcmvpp_hd5_5x2"
		     ?isSubckt       t
		     )
(TECHdefCapNotInList ?name           'vppcap_hd5_11
		     ?cellName       "cap_int3"
		     ?description    "12fF"
		     ?layers         '("met1" "met2" "met3" "met4" )
		     ?hspiceModel    "xcmvpp_hd5_5x1_met5pullin"
		     ?isSubckt       t
		     )
(TECHdefCapNotInList ?name           'vppcap_hd5_12
		     ?cellName       "cap_int3"
		     ?description    "12fF"
		     ?layers         '("met1" "met2" "met3" "met4" )
		     ?hspiceModel    "xcmvpp_hd5_5x2_met5pullin"
		     ?isSubckt       t
		     )
(TECHdefCapNotInList ?name           'vppcap_hd5_13
		     ?cellName       "cap_int3"
		     ?description    "12fF"
		     ?layers         '("met1" "met2" "met3" "met4" )
		     ?hspiceModel    "xcmvpp_hd5_atlas_fingercap_l5"
		     ?isSubckt       t
		     )
(TECHdefCapNotInList ?name           'vppcap_hd5_14
		     ?cellName       "cap_int3"
		     ?description    "12fF"
		     ?layers         '("met1" "met2" "met3" "met4" )
		     ?hspiceModel    "xcmvpp_hd5_atlas_fingercap2_l5"
		     ?isSubckt       t
		     )
(TECHdefCapNotInList ?name           'vppcap_hd5_15
		     ?cellName       "cap_int3"
		     ?description    "12fF"
		     ?layers         '("met1" "met2" "met3" "met4" )
		     ?hspiceModel    "xcmvpp_hd5_atlas_fingercap_l10"
		     ?isSubckt       t
		     )
(TECHdefCapNotInList ?name           'vppcap_hd5_16
		     ?cellName       "cap_int3"
		     ?description    "12fF"
		     ?layers         '("met1" "met2" "met3" "met4" )
		     ?hspiceModel    "xcmvpp_hd5_atlas_fingercap_l20"
		     ?isSubckt       t
		     )
(TECHdefCapNotInList ?name           'vppcap_hd5_17
		     ?cellName       "cap_int3"
		     ?description    "12fF"
		     ?layers         '("met1" "met2" "met3" "met4" )
		     ?hspiceModel    "xcmvpp_hd5_atlas_fingercap_l40"
		     ?isSubckt       t
		     )
(TECHdefCapNotInList ?name           'vppcap_hd5_18
		     ?cellName       "cap_int3"
		     ?description    "12fF"
		     ?layers         '("met1" "met2" "met3" "met4" )
		     ?hspiceModel    "xcmvpp_hd5_atlas_wafflecap1"
		     ?isSubckt       t
		     )
(TECHdefCapNotInList ?name           'vppcap_hd5_19
		     ?cellName       "cap_int3"
		     ?description    "12fF"
		     ?layers         '("met1" "met2" "met3" "met4" )
		     ?hspiceModel    "xcmvpp_hd5_atlas_wafflecap2"
		     ?isSubckt       t
		     )
(TECHdefCapNotInList ?name           'vppcap1_lishield
                     ?cellName       "cap_int3"
                     ?description    "100fF"
                     ?layers         '("li1" "met1" "met2" "met3" )
                     ?hspiceModel    "xcmvpp11p5x11p7_m3_lishield"
                     ?isSubckt       t
)
(TECHdefCapNotInList ?name           'vppcap2_lishield
                     ?cellName       "cap_int3"
                     ?description    "50fF"
                     ?layers         '("li1" "met1" "met2" "met3" )
                     ?hspiceModel    "xcmvpp8p6x7p9_m3_lishield"
                     ?isSubckt       t
)
(TECHdefCapNotInList ?name           'vppcap3_lishield
                     ?cellName       "cap_int3"
                     ?description    "12fF"
                     ?layers         '("li1" "met1" "met2" "met3" )
                     ?hspiceModel    "xcmvpp4p4x4p6_m3_lishield"
                     ?isSubckt       t
)

(TECHdefCapNotInList ?name           'vppcap1_met5
		     ?cellName       "vppcap"
		     ?layers         '("li1" "met1" "met2" "met3" "met4" "met5")
                     ?hspiceModel    "xcmvpp11p5x11p7_m5shield"
		     ?isSubckt       t
		     )
(TECHdefCapNotInList ?name           'vppcap2_met5
		     ?cellName       "vppcap"
		     ?layers         '("li1" "met1" "met2" "met3" "met4" "met5")
		     ?hspiceModel    "xcmvpp11p5x11p7_polym5shield"
		     ?isSubckt       t
		     )
(TECHdefCapNotInList ?name           'vppcap3_met5
                     ?cellName       "vppcap"
                     ?layers         '("li1" "met1" "met2" "met3" "met4" "met5")
                     ?hspiceModel    "xcmvpp11p5x11p7_lim5shield"
                     ?isSubckt       t
		     )
(TECHdefCapNotInList ?name           'vppcap4_met5
                     ?cellName       "vppcap"
                     ?layers         '("li1" "met1" "met2" "met3" "met4" "met5")
                     ?hspiceModel    "xcmvpp8p6x7p9_m3_lim5shield"
                     ?isSubckt       t
		     )
(TECHdefCapNotInList ?name           'vppcap5_met5
                     ?cellName       "vppcap"
                     ?layers         '("li1" "met1" "met2" "met3" "met4" "met5")
                     ?hspiceModel    "xcmvpp11p5x11p7_m3_lim5shield"
                     ?isSubckt       t
)
(TECHdefCapNotInList ?name           'vppcap6_met5
                     ?cellName       "vppcap"
                     ?layers         '("li1" "met1" "met2" "met3" "met4" "met5")
                     ?hspiceModel    "xcmvpp4p4x4p6_m3_lim5shield"
                     ?isSubckt       t
)

(TECHdefCapNotInList ?name           'vppcap5_met4
		     ?cellName       "vppcap"
		     ?layers         '("li1" "met1" "met2" "met3" "met4" "met5")
		     ?hspiceModel    "xcmvpp11p5x11p7_m4shield"
		     ?isSubckt       t
		     )
(TECHdefCapNotInList ?name           'vppcap6_met4
		     ?cellName       "vppcap"
		     ?layers         '("li1" "met1" "met2" "met3" "met4" "met5")
		     ?hspiceModel    "xcmvpp11p5x11p7_polym4shield"
		     ?isSubckt       t
		     )
(TECHdefCapNotInList ?name           'vppcap7_met4
		     ?cellName       "vppcap"
		     ?layers         '("li1" "met1" "met2" "met3" "met4" "met5")
		     ?hspiceModel    "xcmvpp6p8x6p1_polym4shield"
		     ?isSubckt       t
		     )
(TECHdefCapNotInList ?name           'vppcap8_met4
		     ?cellName       "vppcap"
		     ?layers         '("li1" "met1" "met2" "met3" "met4" "met5")
		     ?hspiceModel    "xcmvpp6p8x6p1_lim4shield"
		     ?isSubckt       t
		     )
(TECHdefCapNotInList ?name           'vppcap_nhvnative
		     ?cellName       "vppcap"
		     ?layers         '("li1" "met1" "met2" "met3" "met4" "met5")
		     ?hspiceModel    "xcmvppx4_2xnhvnative10x4"
		     ?isSubckt       t
		     )
;;add 3 term elements
(TECHdefCapNotInList ?name           'vppcap11_m1m4
		     ?cellName       "cap_int3"
		     ?description    "12fF"
		     ?layers         '("met1" "met2" "met3" "met4" )
		     ?hspiceModel    "xcmvpp11p5x11p7_m1m4"
		     ?isSubckt       t
		     )
;;add 4 term elements
(TECHdefCapNotInList ?name           'vppcap11_m1m4m5shield
		     ?cellName       "vppcap"
		     ?description    "100fF"
		     ?layers         '("met1" "met2" "met3" "met4" "met5")
		     ?hspiceModel    "xcmvpp11p5x11p7_m1m4m5shield"
		     ?isSubckt       t
		     )

(TECHdefCapNotInList ?name           'vppcap11_met4
		     ?cellName       "vppcap"
		     ?description    "100fF"
		     ?layers         '("li1" "met1" "met2" "met3" "met4" "met5")
		     ?hspiceModel    "xcmvpp11p5x11p7_polym50p4shield"
		     ?isSubckt       t
		     )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Define Inductors
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(TECHdefInd4 ?name           'xind4_01
	     ?cellName       "ind4"
	     ?hspiceModel    "xind4_01"
	     ?isSubckt       t
)
(TECHdefInd4 ?name           'xind4_02
	     ?cellName       "ind4"
	     ?hspiceModel    "xind4_02"
	     ?isSubckt       t
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Define Precision Resistors
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(TECHdefRes3 ?name          'rpm1
		 ?description   "Precision Poly resistor"
 		 ?cellName      "res3"
		 ?layer         "poly"
		 ?sheet         (TECHgetRule "wxr1hrpoly_1_1")
         	 ?sheetLow      (TECHgetRule "rspgpvdp_min")
		 ?sheetHigh     (TECHgetRule "rspgpvdp_max")
		 ?hspiceModel   "xhrpoly_0p35"
		 ?mapToCell     "hrpoly_0p35"
                 ?constantWidth (TECHgetRule "rpm_1b")
                 ?headRes       (times 2.0 (TECHgetRule "r0hrpoly_1_1"))
                 ?headResHigh   (times 2.0 (TECHgetRule "r0hrpoly_1_1_max"))
                 ?headResLow    (times 2.0 (TECHgetRule "r0hrpoly_1_1_min"))
                 ?isSubckt      t
                 ?subcktDevices '("rbody" "rend1" "rend2")
                 ;;?deltaW        0.0
)


(TECHdefRes3 ?name          'rpm2
		 ?description   "Precision Poly resistor"
 		 ?cellName      "res3"
		 ?layer         "poly"
		 ?sheet         (TECHgetRule "wxr1hrpoly_2_1")
         	 ?sheetLow      (TECHgetRule "rspgpvdp_min")
		 ?sheetHigh     (TECHgetRule "rspgpvdp_max")
		 ?hspiceModel   "xhrpoly_0p69"
		 ?mapToCell     "hrpoly_0p69"
                 ?constantWidth (TECHgetRule "rpm_1c")
                 ?headRes       (times 2.0 (TECHgetRule "r0hrpoly_2_1"))
                 ?headResHigh   (times 2.0 (TECHgetRule "r0hrpoly_2_1_max"))
                 ?headResLow    (times 2.0 (TECHgetRule "r0hrpoly_2_1_min"))
                 ?isSubckt      t
                 ?subcktDevices '("rbody" "rend1" "rend2")
                 ;;?deltaW        0.0
)

(TECHdefRes3 ?name          'rpm3
		 ?description   "Precision Poly resistor"
 		 ?cellName      "res3"
		 ?layer         "poly"
		 ?sheet         (TECHgetRule "wxr1hrpoly_4_1")
         	 ?sheetLow      (TECHgetRule "rspgpvdp_min")
		 ?sheetHigh     (TECHgetRule "rspgpvdp_max")
		 ?hspiceModel   "xhrpoly_1p41"
		 ?mapToCell     "hrpoly_1p41"
                 ?constantWidth (TECHgetRule "rpm_1d")
                 ?headRes       (times 2.0 (TECHgetRule "r0hrpoly_4_1"))
                 ?headResHigh   (times 2.0 (TECHgetRule "r0hrpoly_4_1_max"))
                 ?headResLow    (times 2.0 (TECHgetRule "r0hrpoly_4_1_min"))
                 ?isSubckt      t
                 ?subcktDevices '("rbody" "rend1" "rend2")
                 ;;?deltaW        0.0
)

(TECHdefRes3 ?name          'rpm4
		 ?description   "Precision Poly resistor"
 		 ?cellName      "res3"
		 ?layer         "poly"
		 ?sheet         (TECHgetRule "wxr1hrpoly_8_2")
         	 ?sheetLow      (TECHgetRule "rspgpvdp_min")
		 ?sheetHigh     (TECHgetRule "rspgpvdp_max")
		 ?hspiceModel   "xhrpoly_2p85"
		 ?mapToCell     "hrpoly_2p85"
                 ?constantWidth (TECHgetRule "rpm_1e")
                 ?headRes       (times 2.0 (TECHgetRule "r0hrpoly_8_2"))
                 ?headResHigh   (times 2.0 (TECHgetRule "r0hrpoly_8_2_max"))
                 ?headResLow    (times 2.0 (TECHgetRule "r0hrpoly_8_2_min"))
                 ?isSubckt      t
                 ?subcktDevices '("rbody" "rend1" "rend2")
                 ;;?deltaW        0
)

(TECHdefRes3 ?name          'rpm5
		 ?description   "Precision Poly resistor"
 		 ?cellName      "res3"
		 ?layer         "poly"
		 ?sheet         (TECHgetRule "wxr1hrpoly_16_2")
         	 ?sheetLow      (TECHgetRule "rspgpvdp_min")
		 ?sheetHigh     (TECHgetRule "rspgpvdp_max")
		 ?hspiceModel   "xhrpoly_5p73"
		 ?mapToCell     "hrpoly_5p73"
                 ?constantWidth (TECHgetRule "rpm_1f")
                 ?headRes       (times 2.0 (TECHgetRule "r0hrpoly_16_2"))
                 ?headResHigh   (times 2.0 (TECHgetRule "r0hrpoly_16_2_max"))
                 ?headResLow    (times 2.0 (TECHgetRule "r0hrpoly_16_2_min"))
                 ?isSubckt      t
                 ?subcktDevices '("rbody" "rend1" "rend2")
                 ;;?deltaW        0
)
(TECHdefRes3 ?name          'rpm6
		 ?description   "Precision Poly resistor"
 		 ?cellName      "res3"
		 ?layer         "poly"
		 ?sheet         (TECHgetRule "wxr1uhrpoly_1_1")
         	 ?sheetLow      (TECHgetRule "rspgpvdp_min")
		 ?sheetHigh     (TECHgetRule "rspgpvdp_max")
		 ?hspiceModel   "xuhrpoly_0p35"
		 ?mapToCell     "uhrpoly_0p35"
                 ?constantWidth (TECHgetRule "rpm_1b")
                 ?headRes       (times 2.0 (TECHgetRule "r0hrpoly_1_1"))
                 ?headResHigh   (times 2.0 (TECHgetRule "r0hrpoly_1_1_max"))
                 ?headResLow    (times 2.0 (TECHgetRule "r0hrpoly_1_1_min"))
                 ?isSubckt      t
                 ?subcktDevices '("rbody" "rend1" "rend2")
                 ;;?deltaW        0.0
)
(TECHdefRes3 ?name          'rpm7
		 ?description   "Precision Poly resistor"
 		 ?cellName      "res3"
		 ?layer         "poly"
		 ?sheet         (TECHgetRule "wxr1uhrpoly_2_1")
         	 ?sheetLow      (TECHgetRule "rspgpvdp_min")
		 ?sheetHigh     (TECHgetRule "rspgpvdp_max")
		 ?hspiceModel   "xuhrpoly_0p69"
		 ?mapToCell     "uhrpoly_0p69"
                 ?constantWidth (TECHgetRule "rpm_1c")
                 ?headRes       (times 2.0 (TECHgetRule "r0hrpoly_2_1"))
                 ?headResHigh   (times 2.0 (TECHgetRule "r0hrpoly_2_1_max"))
                 ?headResLow    (times 2.0 (TECHgetRule "r0hrpoly_2_1_min"))
                 ?isSubckt      t
                 ?subcktDevices '("rbody" "rend1" "rend2")
                 ;;?deltaW        0.0
)
(TECHdefRes3 ?name          'rpm8
		 ?description   "Precision Poly resistor"
 		 ?cellName      "res3"
		 ?layer         "poly"
		 ?sheet         (TECHgetRule "wxr1uhrpoly_4_1")
         	 ?sheetLow      (TECHgetRule "rspgpvdp_min")
		 ?sheetHigh     (TECHgetRule "rspgpvdp_max")
		 ?hspiceModel   "xuhrpoly_1p41"
		 ?mapToCell     "uhrpoly_1p41"
                 ?constantWidth (TECHgetRule "rpm_1d")
                 ?headRes       (times 2.0 (TECHgetRule "r0hrpoly_4_1"))
                 ?headResHigh   (times 2.0 (TECHgetRule "r0hrpoly_4_1_max"))
                 ?headResLow    (times 2.0 (TECHgetRule "r0hrpoly_4_1_min"))
                 ?isSubckt      t
                 ?subcktDevices '("rbody" "rend1" "rend2")
                 ;;?deltaW        0.0
)

(TECHdefRes3 ?name          'rpm9
		 ?description   "Precision Poly resistor"
 		 ?cellName      "res3"
		 ?layer         "poly"
		 ?sheet         (TECHgetRule "wxr1uhrpoly_8_2")
         	 ?sheetLow      (TECHgetRule "rspgpvdp_min")
		 ?sheetHigh     (TECHgetRule "rspgpvdp_max")
		 ?hspiceModel   "xuhrpoly_2p85"
		 ?mapToCell     "uhrpoly_2p85"
                 ?constantWidth (TECHgetRule "rpm_1e")
                 ?headRes       (times 2.0 (TECHgetRule "r0hrpoly_8_2"))
                 ?headResHigh   (times 2.0 (TECHgetRule "r0hrpoly_8_2_max"))
                 ?headResLow    (times 2.0 (TECHgetRule "r0hrpoly_8_2_min"))
                 ?isSubckt      t
                 ?subcktDevices '("rbody" "rend1" "rend2")
                 ;;?deltaW        0
)

(TECHdefRes3 ?name          'rpm10
		 ?description   "Precision Poly resistor"
 		 ?cellName      "res3"
		 ?layer         "poly"
		 ?sheet         (TECHgetRule "wxr1uhrpoly_16_2")
         	 ?sheetLow      (TECHgetRule "rspgpvdp_min")
		 ?sheetHigh     (TECHgetRule "rspgpvdp_max")
		 ?hspiceModel   "xuhrpoly_5p73"
		 ?mapToCell     "uhrpoly_5p73"
                 ?constantWidth (TECHgetRule "rpm_1f")
                 ?headRes       (times 2.0 (TECHgetRule "r0hrpoly_16_2"))
                 ?headResHigh   (times 2.0 (TECHgetRule "r0hrpoly_16_2_max"))
                 ?headResLow    (times 2.0 (TECHgetRule "r0hrpoly_16_2_min"))
                 ?isSubckt      t
                 ?subcktDevices '("rbody" "rend1" "rend2")
                 ;;?deltaW        0
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Define Fuse - lvs'able
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  
(TECHdefFuse     ?name         'm4fuse
		 ?cellName     "fuse"
		 ?resistor     'rm4
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 20V defet
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;nvhv WL values are kept for Etest module purposes
(setq nvhv20LWs      '(("1.0" ("30.00"))))
(setq pvhv20LWs      '(("1.0" ("30.00"))))
(setq nvhv20ZvtLWs      '(("5.5" ("30.00"))))

(TECHdefExtDrainMos ?name            'nExtDrainFet20V
        ?cellName        "nfetextd"
        ?enableLOD       t
        ?areaCap         (TECHgetRule "cgox_nh_ca")
        ?sidewallCap     (TECHgetRule "cgox_nh_csw")
        ?lDelta          (TECHgetRule "ldelta")
        ?wDelta          (TECHgetRule "wdelta_n")
        ?srcdiode        'ndiode_h
        ?drndiode        'nwdiode
        ?hspiceModel     "n20vhv1"
        ?isSubckt         t
        ?lsimModel       "TNS"
        ?isElement       t
        ?minGateLength   1.00
        ?minGateWidth    30.00
        ?vtype           "20V"
        ?discreteWLs     nvhv20LWs
        ?contactRes      (TECHgetRule "rcl1n")
        ?diffSheetRes    (TECHgetRule "rsnhv")
        ?drainwellEnclosure (TECHgetRule "denmos_10")
        ?drainTapWidth   (TECHgetRule "denmos_4")
        ?LOCOS           (TECHgetRule "denmos_6")
        ?srcwellOverlap  (TECHgetRule "denmos_5")
        ?mapToCell       "extDnTran"
)

(TECHdefExtDrainMos ?name            'nExtDrainFet20Viso
        ?cellName        "nfetextdiso"
        ?enableLOD       t
        ?areaCap         (TECHgetRule "cgox_nh_ca")
        ?sidewallCap     (TECHgetRule "cgox_nh_csw")
        ?lDelta          (TECHgetRule "ldelta")
        ?wDelta          (TECHgetRule "wdelta_n")
        ?srcdiode        'ndiode_h
        ?drndiode        'nwdiode
        ?hspiceModel     "n20vhviso1"
        ?isSubckt         t
        ?lsimModel       "TNS"
        ?isElement       t
        ?minGateLength   1.00
        ?minGateWidth    30.00
        ?vtype           "20V"
        ?discreteWLs     nvhv20LWs
        ?contactRes      (TECHgetRule "rcl1n")
        ?diffSheetRes    (TECHgetRule "rsnhv")
        ?drainwellEnclosure (TECHgetRule "denmos_10")
        ?drainTapWidth   (TECHgetRule "denmos_4")
        ?LOCOS           (TECHgetRule "denmos_6")
        ?srcwellOverlap  (TECHgetRule "denmos_5")
        ?mapToCell       "extDnTran"
        ?fiveTerm        t
)


(TECHdefExtDrainMos ?name            'nExtDrainFetNative20V
        ?cellName        "nfetextd"
        ?enableLOD       t
        ?areaCap         (TECHgetRule "cgox_nh_ca")
        ?sidewallCap     (TECHgetRule "cgox_nh_csw")
        ?lDelta          (TECHgetRule "ldelta")
       ?wDelta          (TECHgetRule "wdelta_n")
        ?srcdiode        'ndiode_h
        ?drndiode        'nwdiode
        ?hspiceModel     "n20nativevhv1"
        ?isSubckt         t
        ?lsimModel       "TNS"
        ?isElement       t
        ?minGateLength   1.00
        ?minGateWidth    30.00
        ?vtype           "20Vnative"
        ?discreteWLs     nvhv20LWs
        ?contactRes      (TECHgetRule "rcl1n")
        ?diffSheetRes    (TECHgetRule "rsnhv")
        ?drainwellEnclosure (TECHgetRule "denmos_10")
        ?drainTapWidth   (TECHgetRule "denmos_4")
        ?LOCOS           (TECHgetRule "denmos_6")
        ?srcwellOverlap  (TECHgetRule "denmos_5")
        ?mapToCell       "extDnTran"
)

;;change min gate length to 5 
(TECHdefExtDrainMos ?name            'nExtDrainFetZvt20V
        ?cellName        "nfetextd"
        ?enableLOD       t
        ?areaCap         (TECHgetRule "cgox_nh_ca")
        ?sidewallCap     (TECHgetRule "cgox_nh_csw")
        ?lDelta          (TECHgetRule "ldelta")
       ?wDelta          (TECHgetRule "wdelta_n")
        ?srcdiode        'ndiode_h
        ?drndiode        'nwdiode
        ?hspiceModel     "n20zvtvhv1"
        ?isSubckt         t
        ?lsimModel       "TNS"
        ?isElement       t
        ?minGateLength   5.50
        ?minGateWidth    30.00
        ?vtype           "20VZvt"
        ?discreteWLs     nvhv20ZvtLWs
        ?contactRes      (TECHgetRule "rcl1n")
        ?diffSheetRes    (TECHgetRule "rsnhv")
        ?drainwellEnclosure (TECHgetRule "denmos_10")
        ?drainTapWidth   (TECHgetRule "denmos_4")
        ?LOCOS           (TECHgetRule "denmos_6")
        ?srcwellOverlap  (TECHgetRule "denmos_5")
        ?mapToCell       "extDnTran"
)


(TECHdefExtDrainMos ?name            'nExtDrainFetNative20Viso
        ?cellName        "nfetextdiso"
        ?enableLOD       t
        ?areaCap         (TECHgetRule "cgox_nh_ca")
        ?sidewallCap     (TECHgetRule "cgox_nh_csw")
        ?lDelta          (TECHgetRule "ldelta")
        ?wDelta          (TECHgetRule "wdelta_n")
        ?srcdiode        'ndiode_h
        ?drndiode        'nwdiode
        ?hspiceModel     "n20nativevhviso1"
        ?isSubckt         t
        ?lsimModel       "TNS"
        ?isElement       t
        ?minGateLength   1.00
        ?minGateWidth    30.00
        ?vtype           "20Vnative"
        ?discreteWLs     nvhv20LWs
        ?contactRes      (TECHgetRule "rcl1n")
        ?diffSheetRes    (TECHgetRule "rsnhv")
        ?drainwellEnclosure (TECHgetRule "denmos_10")
        ?drainTapWidth   (TECHgetRule "denmos_4")
        ?LOCOS           (TECHgetRule "denmos_6")
        ?srcwellOverlap  (TECHgetRule "denmos_5")
        ?mapToCell       "extDnTran"
        ?fiveTerm        t
)

(TECHdefExtDrainMos ?name            'pExtDrainFet20V
        ?cellName        "pfetextd"
        ?enableLOD       t
        ?areaCap         (TECHgetRule "cgox_p_ca")
        ?sidewallCap     (TECHgetRule "cgox_p_csw")
        ?lDelta          (TECHgetRule "ldelta")
        ?wDelta          (TECHgetRule "wdelta_p")
        ?srcdiode        'pdiode_h
        ?drndiode        'dnwdiode_pw
        ?hspiceModel     "p20vhv1"
        ?isSubckt         t
        ?lsimModel       "TPS"
        ?isElement       t
        ?minGateLength   1.00
        ?minGateWidth    30.00
        ?vtype           "20V"
        ?discreteWLs     pvhv20LWs
        ?contactRes      (TECHgetRule "rcl1p")
        ?diffSheetRes    (TECHgetRule "rsphv")
        ?drainwellEnclosure (TECHgetRule "depmos_10")
        ?drainTapWidth   (TECHgetRule "depmos_4")
        ?LOCOS           (TECHgetRule "depmos_6")
        ?srcwellOverlap  (TECHgetRule "depmos_5")
        ?mapToCell       "extDpTran"
)
(TECHdefDiode ?name                 'dnwhvdiode_psub
              ?cellName             "diode"
              ?areaCoef             (TECHgetRule "cjaw_dnwpw")
              ?areaExponent         (TECHgetRule "exaw_dnwpw")
              ?areaPotential        (TECHgetRule "pbaw_dnwpw")
              ?sidewallCoef         (TECHgetRule "cjpw_dnwpw")
              ?sidewallExponent     (TECHgetRule "expw_dnwpw")
              ?sidewallPotential    (TECHgetRule "pbpw_dnwpw")
              ?hspiceModel          "dnwhvdiode_psub"
              ?lsimModel            "CDN"
              ?doping               "n"
              ?isElement            t
	      ?isConDiode           t
)


