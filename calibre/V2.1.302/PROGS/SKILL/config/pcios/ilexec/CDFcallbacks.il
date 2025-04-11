;;; 
;;; $Id: CDFcallbacks.il 10 2018/06/18 21:10:40 GMT jszemiot Exp $
;;; 
;;; CDFcallbacks.il
;;; 
;;; Copyright (c) 1998 by Cypress Semiconductor
;;; 
;;; Date  : Aug 04, 1998
;;; Author: David Roberts/CAD (dlr) @ CSDC
;;; 
;;; Description:
;;; 
;;; Revision History:
;;;   dlr 08/10/98  Adding NPN and PNP callbacks for current monitoring
;;;   gtc 08/11/98  Adding CDFfetGetFetDevice, CDFfetSetDefaultLength,
;;;                 and CDFfetToggleNative
;;;   akr 08/20/98  added resistor models for met4 and met5 met6
;;;   gtc 08/28/98  fixing where it rounded the length of R driven resistors
;;;   gtc 09/04/98  added CDFcreateHideProps and CDFcreateAsymProps & called
;;;                 them in the fet & logic callbacks
;;;   dlr 10/06/98  Adding CDFverilogTrTfDoneCheck to the logic elements
;;;   dgn 10/22/98  Changed calculation of rl/R for subckt res
;;;   dgn 11/05/98  Changed CDFfetSetDefaultLength() to leave property value if correct
;;;   dgn 12/02/98  Tweaked constant width resistors callback
;;;   akr 12/08/98  Adding Capability to select cap model on rescap device
;;;   gtc 01/15/99  added functions to check range of mfactor
;;;   gtc 02/08/99  adding check for "isParasitic" property on resistors
;;;   gtc 02/23/99  added CDFsetCapSpaceProps
;;;   gtc 03/08/99  first entry in a cap's spacing may not be min space
;;;   gtc 03/22/99  rcon updates
;;;   dgn 05/07/99  Added threshold types (ttype) to CDFfetGetFetDevice()
;;;   axg 08/25/99  Added CDFsetRconModelInfo, CDFrconInit, CDFrconDone
;;;   gtc 08/31/99  Updated CDFsetRconModelInfo to use new TECHgetRconDevices
;;;   gtc 08/31/99  tweaks for rcon
;;;   dgn 10/13/99  Updates for sonos
;;;   dgn 10/19/99  Added CDFgetToggleSonos() to ensure correct vtype
;;;   xgs 11/11/99  Added capability to choose cap segments for rescap
;;;   dgn 01/13/99  Fixed CDFgetCapTechrepDevice() to handle user def. rescap
;;;   gtc 02/29/00  added manual spice model specification for fets
;;;   akg 02/29/00  added latch property for sonos fet
;;;   akg 03/30/00  added esd property for fets - changed to deepNwell (04/17)
;;;   gtc 08/24/00  AEL updates38424
;;;   kgr 08/25/00  Modified CDFfetToggleSonos to force all sonos devices to have deepNwell true
;;;   gtc 09/01/00  updated fet m-factor check to enforce >= 1
;;;   mzy 09/11/00  added pwell resistor support (respw)
;;;   gtc 09/20/00  added CDFcswDone
;;;   gtc 09/26/00  duct tape kludge for csw_p callback
;;;   gtc 09/26/00  duct tape kludge for einv_p callback
;;;   gtc 09/26/00  tweaking cap callback for setting the spacing values
;;;                 regarding thinox caps
;;;   gtc 10/26/00  added CDFdiodeMethodMap
;;;   gtc 11/09/00  added CDFdMM wrapper around CDFdiodeMethodMap
;;;   gtc 12/12/00  updating cap2 callback to create/delete the isSubckt prop
;;;   gtc 01/29/01  support for AELs in xtor & logic gate widths & lengths
;;;   gtc 02/01/01  moved in callback functions from CDFtools, and did a
;;;                 minor tweak to CDFcapbnCalculateDiodes
;;;   gtc 02/15/01  Updates to mfactor check to handle AEL numbers, but it will
;;;                 insist on it being an integer, not an equation/expression
;;;   dxj 02/19/01  Updates for SONOS TDR *G
;;;   gtc 03/02/01  fixing asym props when m-factor is a string on logic gates
;;;   gtc 03/12/01  Temporarily commenting out dxj's last change until he is
;;;                 ready to maprel.
;;;                 Updates to support string/parameterized rw, rl, rm for res
;;;   dxj 03/13/01  SONOS TDR *G changes ready for maprel. Putting them back.
;;;   gtc 03/13/01  fixed one bug for w,l based resistors
;;;   gtc 03/15/01  updates to handle AEL parameters in a couple of more places
;;;   gtc 03/16/01  removed bcdiode callback
;;;   gtc 03/30/01  absolute caps now delete isSubckt property, and some
;;;                 elements now use CDFverInit initialiaztion function
;;;   gtc 04/06/01  fixed references from cdf vtype and ttype to vtype2, ttype2
;;;   gtc 04/09/01  Splitting CDFfetGetFetDevice into two functions:  one that
;;;                 is called from CDF props, another from instance props.
;;;   gtc 04/10/01  fixing rescap cw/cl bug when mfactor > 1
;;;   gtc 04/10/01  fixed false warning about constant width resistors
;;;   gtc 04/11/01  fixed cap of rescap when using R driven resistors
;;;   gtc 04/12/01  logic gate subcktMult properties -> m
;;;   gtc 04/12/01  updating capbn_b callback to derive either cw or cl when
;;;                 given a total cap and one dimension
;;;   gtc 04/19/01  moving CDFevalString in here
;;;   gtc 04/24/01  not doing CDFcommonDone for icecaps; SPR 8788
;;;   dxj 04/27/01  Modified nfet device (tsmc25, kept for future use in ram7?)
;;;   gtc 05/14/01  enhancements to capbn_b device
;;;   gtc 07/27/01  adding capacitor width lookup table support
;;;   gtc 08/31/01  adjusting init CDF call for inductor to change the old
;;;                 "Initial Current" indType to "Normal"
;;;   dxj 09/19/01  added code for d17ld-3 flow
;;;   lpn 12/11/01  added code for res3
;;;   dxj 12/10/01  Added code for T013 flow
;;;   cry 01/24/02  Updated npn4 (and pnp4 for free) to allow subckt models
;;;   cry 02/21/02  Added CDfmtjInit and CDFmtjDone and CDFmtjCallback
;;;   dxj 02/28/02  Allow use of general res device with subckt
;;;   gtc 03/27/02  added CDFcalculateCapacitors for cmimc, and rearranged
;;;                 how it is called for the capbn_b
;;;   cry 03/28/02  added ltype (leakage type) to CDFfetDeviceFromParams
;;;                 may need to add a toggle
;;;   gtc 05/03/02  removed lsim features
;;;   jtv 05/10/02  updated CDFfetSetDefaultLength to also get default width
;;;   gtc 05/10/02  not creating the "hide_" properties anymore.
;;;   kgr 05/24/02  Updated CDFnpn4Done to update pnp params based on modelName
;;;   gtc 05/28/02  updated capbn_b diode calculations to include nwell
;;;   kgr 05/31/02  Added threeTermNetlist, mim3c, and ind3
;;;   kgr 06/19/02  Added CDFcmim3cDone, CDFcapbn_bDone, and CDFind4Done
;;;   kmi 08/02/02  Added CDFfetToggleRam7
;;;   kmi 08/23/02  Corrected CDFfetToggleTech()  (SPR 13124)
;;;   ymx 08/23/02  Added CDFfetToggleC8Q
;;;   gtc 11/01/02  Added delta width support for resistor callbacks
;;;   dxj 11/12/02  Update T013 callbacks for SPR 13391
;;;   gtc 12/17/02  including contact res. in calculation of poly resistors
;;;   dxj 02/25/03  T013 ggnmos made legal
;;;   dxj 02/27/03  Add metd as a new resType
;;;   gtc 03/27/03  Added minimum fet width/length check (optional)
;;;   gtc 05/16/03  Added CDFhitCallbacks
;;;   cva 06/13/03  c9fp updates ddli/litr parasitic res, diff res3
;;;   gtc 08/21/03  Updated minimum fet width/length check when w/l is empty
;;;   kmi 08/21/03  Adding CDFfetToggleC9F
;;;   cva 09/03/03  added resnw resistor
;;;   gtc 11/26/03  fet mfactor callback, resetting to "1" if it is empty
;;;   cva 12/11/03  iglv updates lm1/lmcon
;;;   kgr 03/22/04  added extendedDrain to fets
;;;   gtc 03/31/04  looking at resistor width for width interpolation of caps
;;;   gtc 04/09/04  handling isSubckt creation/deletion for fets and diodes
;;;   sti 06/02/04  Added CDfmtj5Init and CDFmtj5Done and CDFmtj5Callback
;;;   sti 06/28/04  Added CDFfetToggleLvNative
;;;   vun 07/01/04  added resnd, respd, and resnw to res3
;;;   sti 07/18/04  add Cap_int3
;;;   sti 08/15/04  update Cap_int3
;;;   akg 09/07/04  added CDFafuseDone
;;;   pvn 10/14/04  Added code for gres3 element 
;;;   pvn 11/12/04  Modified code for gres3 to mimic GR process
;;;   gtc 11/17/04  added verilog tr/tf support for einv_p
;;;   cva 03/09/05  added isHV hv diff res
;;;   dxj 05/26/05  Fix the capbn calculation for variables (SPR 22916)
;;;   vun 07/21/05  added refCell and memCell
;;;   bae 08/11/05  added CDF functionality for discrete FET models
;;;   rnh 08/24/05  Added CDFupdateDiscreteWchoice functionality for layout Pcells.
;;;   bae 08/26/05  added CDF functionality for logic gates
;;;   bae 09/20/05  updated CDFfetDiscContactsCallback, 
;;;                 added CDFupdateFetDiscContactNum and CDFupdateManualWL
;;;   bae 09/23/05  allowed deepNwell to devices other than sonos 
;;;   rnh 10/06/05  Updated CDFupdateDiscreteWchoice to accept default Width values.
;;;   bub 10/06/05  changed ToggleSonos function
;;;   bub 10/14/05  added CDFcondiodeDone
;;;   rnh 10/20/05  Updated CDFupdateRadioID CDFradioUpdateDiscreteWchoice for radio
;;;                 button selected devies from the form.
;;;   bae 10/28/05  added CDFfetToggleHighVt and updated CDFfetToggleESD
;;;   bub 11/04/05  updated CDF for res3
;;;   kuc 11/16/05  Added CDFvaractorDone
;;;   bae 12/01/05  added CDF functionality/callbacks for discrete pcells
;;;   kuc 12/02/05  Added CDFmExtDrainTranDone
;;;   txi 12/20/05  Added CDFfetgateresvalue callback. Update CDFupdateFetLengthParameter
;;;                 and CDFupdateFetWidthParameter callbacks
;;;   txi 01/02/06  fixed the bug in CDFfetgateresvalue callback.
;;;   bae 01/12/06  Added CDFfetextdCallback and CDFfetextdDone
;;;   osd 02/03/06  updated CDFfetToggleHighVt,CDFfetToggleNlowVt
;;;   bae 05/04/06  updated CDFupdateFetDiscContactNum, CDFfetDiscContactsCallback
;;;                 fixed CDFfetToggleNlowVt
;;;   bae 05/11/06  added CDFsetFetDeviceParams CDFupdateDeviceInfo
;;;                 removed CDFfetToggleNative CDFfetToggleLvNative CDFfetToggleNtvNative
;;;                 CDFfetToggleESD CDFfetToggleNlowVt CDFfetToggleHighVt CDFfetToggleSonos
;;;                 CDFfetToggleExtendedDrain CDFupdateDiscreteWchoice CDFupdateRadioID
;;;                 CDFradioUpdateDiscreteWchoice
;;;   ipr 07/19/06  fixes related to rfDeviceInfo (SPR 31232)
;;;   kuc 07/27/06  updated CDFvaractorDone for new varactor device
;;;   bae 09/25/06  added CDFupdateDiscreteFetWL
;;;   bae 10/27/06  modified CDFsetFetDeviceParams
;;;   bae 03/05/07  updated CDFfetDiscContactsCallback to set offsets if needed
;;;   kuc 04/03/07  updated condiode callbacks
;;;   cry 04/03/07  updated discrete fet callback code to handle flows without licon/ddlicon
;;;                 updated resistor code to handle rdl resistors
;;;   cry 05/16/07  updates for LOD/WPE and for NRD/NRS (SPR 36742)
;;;   vun 06/21/07  updates  NRD/NRS
;;;   cry 06/21/07  updates for RESCAP3
;;;   vun 08/30/07  added CDFefuseDone
;;;   cry 09/04/07  RC fix for SPR 38271 and others - ensuring tech lib cells are not renamed.
;;;   xba 10/17/07  Updating CDFfetCallback for resetting enableLOD based on hspiceModel.
;;;   cry 10/18/07  updates for absolute resistor with a model, 
;;;                 added isSubckt setting to CDFcmim3cDone so CDFhitCallbacks can set it
;;;   kuc 10/25/07  added accurate calculations for varactors in CDFcalculateCapacitors
;;;   cry 10/26/07  added isSubckt to CDFcapbn_bDone, updated how it's done in CDFcmim3cDone
;;;   xba 11/20/07  Fxing calculateCapacitors for varactors. SPR 40756
;;;   kuc 12/12/07  updated number of contacts calculation when using parameterized w
;;;   kuc 01/22/08  added Mult callback
;;;   kuc 01/24/08  added deltaL for resistors
;;;   osd 04/17/08  added vppcap
;;;   kuc 04/22/08  added CDFconstantCcap2Callback, CDFgetCapSpaceProps,
;;;                       CDFgetCapWidthProps, CDFinterpolate
;;;   kuc 08/11/08  fixed CDFconstantCcap2Callback to handle parameterized inputs
;;;   vun 12/05/08  fixed cap_int3 and vppcap cap display.
;;;   cva 04/15/09  added callback for pnp4 to use userDefined model
;;;   osd 08/14/09  added callback for npn4 to use userDefined model
;;;   vun 08/21/09  added reslocsub
;;;   cry 12/15/09  renamed CDFinterpolate to CDFinterpolateS to avoid conflict with CDFlabels (SPR 61979)
;;;



(putpropqq CDFcallbacks "$Id: CDFcallbacks.il 10 2018/06/18 21:10:40 GMT jszemiot Exp $" SCCS)


;;; 
;;; CDFsetPnp4DeviceParams --
;;;   This function will set the device parameters based on the techrep fet definition for the selected model
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFsetPnp4DeviceParams  (cellName "t")
  (let (thePNPdevice)
    (cond
     ((and cdfgData~>hspiceModelMenu (equal cdfgData~>hspiceModelMenu~>value "userDefined"))        
      ;;manualSpiceModel is always defined and should be true when model selection is "userDefined"
      cdfgData->manualSpiceModel->value = t
      )
     (t	
      ;; get the device that matches the hspiceModel as defined in TECHrep
      (setq thePNPdevice cdfgData->hspiceModelMenu->value)
      cdfgData->modelName->value = cdfgData~>hspiceModelMenu~>value
      ;;manualSpiceModel is always defined and should be false when model selection is not "userDefined"
      cdfgData->manualSpiceModel->value = nil
      (unless thePNPdevice
	(warn "CDFsetPNP4DeviceParams: the %L model is defined in TECHrep \n" cdfgData~>hspiceModelMenu~>value)
	)
      )
     )
    ;;Update the device information field based on the new model selection
    (CDFupdateDeviceInfo cellName)  
    )
  )

;;; 
;;; CDFsetFetDeviceParams --
;;;   This function will set the device parameters based on the techrep fet definition for the selected model
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFsetFetDeviceParams  (cellName "t")
  (let (theFetDevice (fetTypes '(vtype ttype ltype))
		     (fetPropNames '(sonos latch ptype native lvNative ntvNative deepNwell extendedDrain nlowVt highVt 
					   pullType array isSubckt isESD rfDeviceInfo enableLOD))
		     )
    
    (when (and (nequal cdfgData~>topography~>value "normal") cdfgData~>hspiceModelMenu)
      (warn "CDFsetFetDeviceParams: Topographies are not supported in TECHrep \n")
      (warn "CDFsetFetDeviceParams: Forcing model to userDefined \n")
      (warn "CDFsetFetDeviceParams: Please type model in \"Spice model name\" field \n")
      cdfgData~>hspiceModelMenu~>value = "userDefined"
      )
    
    (cond
     ((and cdfgData~>hspiceModelMenu (equal cdfgData~>hspiceModelMenu~>value "userDefined"))
      
      ;;manualSpiceModel is always defined and should be true when model selection is "userDefined"
      cdfgData->manualSpiceModel->value = t
      
      ;;manualWL is only defined for discrete fets
      (when (cdfgData~>manualWL) cdfgData~>manualWL~>value = t)
      
      ;;When userDefined models are used, the W/L menus should be disabled and manual entry of W/L is required
      (CDFupdateManualWL)
      )
     
     (t	
      ;; get the device that matches the hspiceModel as defined in TECHrep
      (setq theFetDevice (TECHgetDeviceWithModel cellName cdfgData~>hspiceModelMenu~>value))
      
      ;;manualSpiceModel is always defined and should be false when model selection is not "userDefined"
      cdfgData->manualSpiceModel->value = nil
      
      ;;manualWL is only defined for discrete fets
      (when (cdfgData~>manualWL) cdfgData~>manualWL~>value = nil)
      
      (unless theFetDevice
	(warn "CDFsetFetDeviceParams: the %L model is defined in TECHrep \n" cdfgData~>hspiceModelMenu~>value)
	)
      
      (foreach fetType fetTypes
	       (setq typeValue (TECHgetDeviceParam theFetDevice fetType))
	       
	       ;;For some reason the types' names differ between TECHrep and CDFs
	       ;;CDFs has types with a "2" appended to the end of the symbol
	       ;;i.e. TECHrep has vtype while CDFs has vtype2
	       (when (get cdfgData (concat fetType '2))
		 (putprop (get cdfgData (concat fetType '2)) typeValue 'value)
		 )
	       )
      
      (foreach propName fetPropNames
	       (setq propValue (TECHgetDeviceParam theFetDevice propName))
	       (when (get cdfgData propName)
		 (putprop (get cdfgData propName) propValue 'value)
		 )
	       )
      )
     );; end of cond
    
    
    ;;Update the device information field based on the new model selection
    (CDFupdateDeviceInfo cellName)
    ;;Update the widths and length values at this stage
    (CDFupdateFetLengthParameter (strcat (concat cdfgData~>hspiceModelMenu~>value "_l")))
    )
)

;;; 
;;; CDFfetDeviceFromParams --
;;;   This function will return the techrep fet device for the fet described
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFfetDeviceFromParams
  ;; these parameters are all the things it uses to match against the
  ;; techrep device
  (cellName vtype nlowVt highVt isESD native lvNative ntvNative ttype sonos ptype 
	    latch deepNwell extendedDrain pullType array ltype rfDeviceInfo)
  
  (let (fetDevices targetVoltage targetNlowVt targetESD targetNative targetLvNative targetNtvNative 
		   targetHighVt targetThreshold targetLeakage targetdnw targetArray targetExtendedDrain targetRfFet)
    
    ;; first, get the devices that match the cellname
    (setq fetDevices (TECHgetDevice ?cellName cellName))
    
    ;; second, match the voltage type
    (setq targetVoltage vtype)
    (when (equal "normal" targetVoltage)
      (setq targetVoltage nil)
      )
    (setq fetDevices
	  (setof x fetDevices
		 (equal (TECHgetDeviceParam x 'vtype) targetVoltage)
		 )
	  )
    
    ;; third, match the native boolean
    (setq targetNative
	  ;; double negative to get a t or a nil
	  (null (null (and native (nequal "FALSE" native))))
	  )
    (setq fetDevices
	  (setof x fetDevices
		 (equal (TECHgetDeviceParam x 'native) targetNative)
		 )
	  )
    
    ;; thirdB, match the lvNative boolean
    (setq targetLvNative
	  ;; double negative to get a t or a nil
	  (null (null (and lvNative (nequal "FALSE" lvNative))))
	  )
    (setq fetDevices
	  (setof x fetDevices
		 (equal (TECHgetDeviceParam x 'lvNative) targetLvNative)
		 )
	  )
    
    ;; thirdC, match the ntvNative boolean
    (setq targetNtvNative
	  ;; double negative to get a t or a nil
	  (null (null (and ntvNative (nequal "FALSE" ntvNative))))
	  )
    (setq fetDevices
	  (setof x fetDevices
		 (equal (TECHgetDeviceParam x 'ntvNative) targetNtvNative)
		 )
	  )
    
    ;; fourth, match the threshold type
    (setq targetThreshold ttype)
    (when (equal "normal" targetThreshold)
      (setq targetThreshold nil)
      )
    (setq fetDevices
	  (setof x fetDevices
		 (equal (TECHgetDeviceParam x 'ttype) targetThreshold)
		 )
	  )
    
    ;; fifth, match the ptype & latch type
    (cond 
     ((and sonos (nequal "FALSE" sonos))
      (setq targetPtype ptype)
      (setq latchType nil)
      )
     ((and latch (nequal "FALSE" latch))
      (setq latchType (null (null (and latch (nequal "FALSE" latch)))))
	     (setq targetPtype ptype)
	     )
     (t
      (setq targetPtype nil)
      (setq latchType   nil)
      )
     )
    (setq fetDevices
	  (setof x fetDevices
		 (equal (TECHgetDeviceParam x 'ptype) targetPtype)
		 )
	  )
    (setq fetDevices
	  (setof x fetDevices
		 (equal (TECHgetDeviceParam x 'latch) latchType)
		 )
	  )
    
    ;; sixth, match deep nwell property
    (setq targetdnw
	  ;; double negative to get a t or a nil
	  (null (null (and deepNwell (nequal "FALSE" deepNwell))))
	  )
    (setq fetDevices
	  (setof x fetDevices
		 (equal (TECHgetDeviceParam x 'deepNwell) targetdnw)
		 )
	  )
	
    ;; seventh, match the npass and npulldown devices (pullType property)
    (setq targetPullType pullType)
    (when (equal "normal" targetPullType)
      (setq targetPullType nil))
    (setq fetDevices
	  (setof x fetDevices
		 (equal (TECHgetDeviceParam x 'pullType) targetPullType)
		 )
	  )
    
    ;; eighth, match the array fet devices
    (setq targetArray
	  (null (null (and array (nequal "FALSE" array))))
	  )
    (setq fetDevices
	  (setof x fetDevices
		 (equal (TECHgetDeviceParam x 'array) targetArray)
		 )
	  )
    
    ;; ninth, match the leakage type
    (setq targetLeakage ltype)
    (when (equal "normal" targetLeakage)
      (setq targetLeakage nil)
      )
    (setq fetDevices
	  (setof x fetDevices
		 (equal (TECHgetDeviceParam x 'ltype) targetLeakage)
		 )
	  )
    
    ;; tenth, match the extendedDrain boolean
	(setq targetExtendedDrain
	      ;; double negative to get a t or a nil
	      (null (null (and extendedDrain (nequal "FALSE" extendedDrain))))
	      )
	
	(setq fetDevices
	      (setof x fetDevices
		     (equal (TECHgetDeviceParam x 'extendedDrain) targetExtendedDrain)
		     )
	      )
	
	;; eleventh, match the nlowVt boolean
	(setq targetNlowVt
	      ;; double negative to get a t or a nil
	      (null (null (and nlowVt (nequal "FALSE" nlowVt))))
	      )
	
	(setq fetDevices
	      (setof x fetDevices
		     (equal (TECHgetDeviceParam x 'nlowVt) targetNlowVt)
		     )
	      )
	
	;; twelveth, match the isESD boolean
	(setq targetESD
	      ;; double negative to get a t or a nil
	      (null (null (and isESD (nequal "FALSE" isESD))))
	      )
	
	(setq fetDevices
	      (setof x fetDevices
		     (equal (TECHgetDeviceParam x 'isESD) targetESD)
		     )
	      )
	
	;; thirteenth, match the highVt boolean
	(setq targetHighVt
	      ;; double negative to get a t or a nil
	      (null (null (and highVt (nequal "FALSE" highVt))))
	      )
	
	(setq fetDevices
	      (setof x fetDevices
		     (equal (TECHgetDeviceParam x 'highVt) targetHighVt)
		     )
	      )
	
	;;fourteenth, match an rf fet
	;;an RF fet is distinguished by the presence of string 
	;;which is the modelname of the RF Fet.
	;;This string is in the RF Fet field of the
	;;CDFproperty of the FET
	;;This string is matched against the rfDeviceInfo stored in the 
	;;techrep to pick up the correct type of RFdevice.
	(when (equal rfDeviceInfo "") (setq rfDeviceInfo nil))
	(setq fetDevices
	      (setof x fetDevices
		     (equal (TECHgetDeviceParam x 'rfDeviceInfo) rfDeviceInfo)
		     )
	      )
	
	(cond
	 ((null fetDevices)
	  (warn "CDFfetDeviceFromParams: failed to match CDF to a techrep device\n")
	  nil
	  )
	 ((greaterp (length fetDevices) 1)
	  (warn "CDFfetDeviceFromParams: multiple matches of CDF to techrep devices.\n")
	  (warn "CDFfetDeviceFromParams: picking first one found\n")
	  (car fetDevices)
	  )
	 (t (car fetDevices))
	 )
	)
  )

;;; 
;;; CDFfetGetFetDevice --
;;;   This function will get the CY techrep device for a fet for the current
;;; CDF as defined by cdfgData
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFfetGetFetDevice (cellName "t")
    (CDFfetDeviceFromParams cellName
			    cdfgData->vtype2->value
			    cdfgData->nlowVt->value
			    cdfgData->highVt->value
			    cdfgData->isESD->value
			    cdfgData->native->value
			    cdfgData->lvNative->value
			    cdfgData->ntvNative->value
			    cdfgData->ttype2->value
			    cdfgData->sonos->value
			    cdfgData->ptype->value
			    cdfgData->latch->value
			    cdfgData->deepNwell->value
			    cdfgData->extendedDrain->value
			    cdfgData->pullType->value
			    cdfgData->array->value
			    cdfgData->ltype2->value
			    cdfgData->rfDeviceInfo->value
    )
)

;;; ;;; CDFfetDeviceFromDbid --
;;;   This is very similar to CDFfetGetFetDevice, except that it will get the
;;; CY techrep device for a fet for a given instance.
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFfetDeviceFromDbid (dbid cellName "dt")
    (CDFfetDeviceFromParams cellName
			    dbid~>vtype
			    dbid~>nlowVt
			    dbid~>highVt
			    dbid~>isESD
			    dbid~>native
			    dbid~>lvNative
			    dbid~>ntvNative
			    dbid~>ttype
			    dbid~>sonos
			    dbid~>ptype
			    dbid~>latch
			    dbid~>deepNwell
			    dbid~>extendedDrain
			    dbid~>pullType
			    dbid~>array
			    dbid~>ltype
			    dbid~>rfDeviceInfo
    )
)

;;; 
;;; CDFfetSetDefaultLength --
;;;   This function will set the length/width to the default minimum gate 
;;; length/width as defined by the techrep device for the fet.  This is 
;;; called when changing the voltage type property.
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFfetSetDefaultLength (cellName "t")

  ;; property based on isESD type
  (CDFfetToggleESD)

  (let (fetDevice fetLength fetWidth discreteWLs)
    (setq fetDevice (CDFfetGetFetDevice cellName))
    (setq discreteWLs (TECHgetDeviceParam fetDevice 'discreteWLs))
    
    (when fetDevice
      (setq fetLength (aelNumber cdfgData->l->value))
      (when (numberp fetLength)
	(cond
	 (discreteWLs
	  (setq fetLength (TECHgetDeviceParam fetDevice 'minGateLength))
	  )
	 (t
	  (setq fetLength (max fetLength (TECHgetDeviceParam fetDevice 
							     'minGateLength)))
	  )
	 )
	
	(cond
	 ((equal "float" cdfgData->l->paramType)
	  cdfgData->l->value = fetLength
	  )
	 ((equal "string" cdfgData->l->paramType)
	  cdfgData->l->value = (sprintf nil "%g" fetLength)
	  )
	 )
	
	)
      (setq fetWidth (aelNumber cdfgData->w->value))
      (when (numberp fetWidth)
	(cond
	 (discreteWLs
	  (setq fetWidth (TECHgetDeviceParam fetDevice 'minGateWidth))
	  )
	 (t
	  (setq fetWidth (max fetWidth (TECHgetDeviceParam fetDevice 
							   'minGateWidth)))
	  )
	 )
	
	(cond
	 ((equal "float" cdfgData->w->paramType)
	  cdfgData->w->value = fetWidth
	  )
	 ((equal "string" cdfgData->w->paramType)
	  cdfgData->w->value = (sprintf nil "%g" fetWidth)
	  )
	 )
	)
      )
    )
)

;;; 
;;; CDFupdateGateLengthParameter --
;;;
;;; Input: The name of the discrete length parameter to be updated
;;; Output: 
;;; Globals: 
;;; Side Effects: Updates the golden W and L values, and rederives the Area and Perimeter
;;; Return: 
;;; 
(defun CDFupdateGateLengthParameter (Ln Wn nLength @key NSCprop NDCprop)
  (let (lengthValue lengthChoices lengthIndex nWidth priorLengthValue)
    (setq priorLengthValue (get (get cdfgData Ln) 'value))
    (putprop (get cdfgData Ln) (get (get cdfgData nLength) 'value) 'value)
    
    (setq lengthValue (get (get cdfgData nLength) 'value))
    (setq lengthChoices (get (get cdfgData nLength) 'choices))
    
    (setq lengthIndex (difference (length lengthChoices) (length (member lengthValue lengthChoices))))
    
    ;;The proper modelName_l=Value_w and the golden w needs to be updated.
    (setq nWidth (strcat (concat nLength lengthIndex "_w")))
    
    ;;Updating the golden W
    (putprop (get cdfgData Wn) (get (get cdfgData nWidth) 'value) 'value)
    
    ;;If the length value has been updated, then the width would be updated and
    ;;therefore, we have to update NSC & NDC 
    (when (and (TECHisPropSet doNrdNrsOhms) (TECHgetProp doNrdNrsOhms))
    (unless  (equal priorLengthValue lengthValue)
      (CDFupdateFetDiscContactNum ?wProp Wn ?NSCprop NSCprop ?NDCprop NDCprop)
      )
      )
    )
  )

;;; 
;;; CDFupdateFetLengthParameter --
;;;
;;; Input: The name of the discrete length parameter to be updated
;;; Output: 
;;; Globals: 
;;; Side Effects: Updates the golden W and L values, and rederives the Area and Perimeter
;;; Return: 
;;; 
(defun CDFupdateFetLengthParameter (nLength)
  (let (fetDevice discreteWLs priorLengthValue lengthValue lengthChoices nWidth)

    priorLengthValue = cdfgData~>l->value

    (unless (cdfgData~>manualWL~>value)

      cdfgData~>l->value =  (get (get cdfgData nLength) 'value)

      (setq lengthValue cdfgData~>l->value)
      (setq lengthChoices (get (get cdfgData nLength) 'choices))
      
      (setq lengthIndex (difference (length lengthChoices) (length (member lengthValue lengthChoices))))

      ;;The proper modelName_l=Value_w and the golden w needs to be updated.
      (setq nWidth (strcat (concat nLength lengthIndex "_w")))
      
      ;;Updating the golden W
      cdfgData~>w->value = (get (get cdfgData nWidth) 'value)

      (when cdfgData~>totalW
       cdfgData~>totalW->value = (sprintf nil "%L"   (evalstring (get (get cdfgData 'w) 'value)) * (evalstring (get (get cdfgData 'm) 'value)))
       )

      ;;If the length value has been updated, then the width would be updated and
      ;;therefore, we have to update NSC & NDC 
 (when (and (TECHisPropSet doNrdNrsOhms) (TECHgetProp doNrdNrsOhms))
      (unless  (equal priorLengthValue lengthValue)
	(CDFupdateFetDiscContactNum)
        )
	)
      
      ;;If the manualWL is turned on then the "w" and "l" callbacks will call CDFderiveAreaAndPerim
      (CDFderiveAreaAndPerim cdfgData)
      ;;update gate resistance value as well
      (CDFfetgateresvalue)
      )
  )
)

;;; 
;;; CDFupdateDeviceInfo --
;;;
;;; Input: 
;;; Output: 
;;; Globals: cdfgData
;;; Side Effects: Updates the device information as defined in TECHrep
;;; Return: String containing the new device information
;;; 
(defun CDFupdateDeviceInfo (cellName)
  (let (theDevice theDeviceInfo)
     
    (cond
     ((equal cdfgData~>hspiceModelMenu~>value "userDefined")
      cdfgData~>deviceInfo~>value = "user defined model"
     )
     (t
       (setq theDevice (TECHgetDeviceWithModel cellName cdfgData~>hspiceModelMenu~>value))
       (setq theDeviceInfo (TECHgetDeviceParam theDevice 'deviceInfo))
       cdfgData~>deviceInfo~>value = (or theDeviceInfo "No info available")
       )
     )
   )
)

;;; 
;;; CDFupdateLdisplay --
;;;
;;; Input: The name of the discrete length parameter to be display, and the cellName (i.e. nfet)
;;; Output: 
;;; Globals: 
;;; Side Effects: Toggles the proper length parameter to be displayed and calls CDFupdateFetLengthParameter
;;; Return: 
;;; 
(defun CDFupdateLdisplay (nLength cellName)
  (let (fetDevice hspiceModel modelName)

    ;;This cannot be a simple parse to prevent mis-reading models that have "_" in their name
    ;;So, parse using "_" then get rid of the last element which is "l" and rebuild the string
    (setq modelName (buildString (reverse (cdr (reverse (parseString nLength "_")))) "_"))
    (setq fetDevice (CDFfetGetFetDevice cellName))

    ;; get the correct hspice model from the technology representation
    (setq hspiceModel (TECHgetDeviceParam fetDevice 'hspiceModel))

    (when (equal modelName hspiceModel)
      ;;Need to update the Golden "l" parameter every time the length is updated
      (CDFupdateFetLengthParameter nLength)
      )

    (and (equal modelName hspiceModel) !(cdfgData~>manualWL~>value))
 )
)

;;; 
;;; CDFupdateFetWidthParameter --
;;;
;;; Input: The name of the discrete width parameter to be updated
;;; Output: 
;;; Globals: 
;;; Side Effects: Rederives the Area and Perimeter, and defaults NDC and NSC parameters to max
;;; Return: 
;;; 
(defun CDFupdateFetWidthParameter (nWidth)

  (unless (cdfgData~>manualWL~>value)
    cdfgData~>w->value = (get (get cdfgData nWidth) 'value)
    (when (and (get cdfgData nWidth)  (get cdfgData 'm))
      (when cdfgData~>totalW
        cdfgData~>totalW->value = (sprintf nil "%L"   (evalstring (get (get cdfgData 'w) 'value)) * (evalstring (get (get cdfgData 'm) 'value)))
       ) 
    ) 
    ;;If the manualWL is turned on then the "w" and "l" callbacks will call CDFderiveAreaAndPerim
    (CDFderiveAreaAndPerim cdfgData)
    (CDFfetgateresvalue)
  )
 (when (and (TECHisPropSet doNrdNrsOhms) (TECHgetProp doNrdNrsOhms))
  (CDFupdateFetDiscContactNum)
  )
)

;;; 
;;; CDFupdateWdisplay --
;;;
;;; Input: The model name, the value of the discrete length parameter, and the cellName (i.e. nfet)
;;; Output: 
;;; Globals: 
;;; Side Effects: displays the proper width parameter
;;; Return: 
;;; 
(defun CDFupdateWdisplay (modelName nLengthValue cellName)

  (let (fetDevice hspiceModel widthString widthFunc nWidthValue)

    (setq fetDevice (CDFfetGetFetDevice cellName))
    ;; get the correct hspice model from the technology representation
    (setq hspiceModel (TECHgetDeviceParam fetDevice 'hspiceModel))

    (and 
     !(cdfgData~>manualWL~>value)
     (equal nLengthValue cdfgData->l->value)
     (equal modelName hspiceModel))
  )
)

;;; 
;;; CDFupdateManualWL --
;;;
;;; Input: The model name, the value of the discrete length parameter, and the cellName (i.e. nfet)
;;; Output: 
;;; Globals: 
;;; Side Effects: displays the proper width parameter
;;; Return: 
;;; 
(defun CDFupdateManualWL ()

  ;;When the model is manually specified, then all properties that 
  ;;are model specific should be reset to nil
  ;;i.e. "native" is model specific but "deepNwell" may not necessarily be so
  (when (and (cdfgData->manualWL) (cdfgData->manualSpiceModel->value))
    cdfgData->manualWL->value = t

    (when cdfgData->manualWL->value

      (when (and cdfgData->sonos cdfgData->sonos->value)
	cdfgData->sonos->value = nil
	)
      (when (and cdfgData->deepNwell cdfgData->deepNwell->value)
	cdfgData->deepNwell->value = nil
	)
      (when (and cdfgData->lvNative cdfgData->native->value)
	cdfgData->lvNative->value = nil
	)
      (when (and cdfgData->native cdfgData->native->value)
	cdfgData->native->value = nil
	)
      (when (and cdfgData->ntvNative cdfgData->native->value)
	cdfgData->ntvNative->value = nil
	)
      (when (and cdfgData->nlowVt cdfgData->nlowVt->value)
	cdfgData->nlowVt->value = nil
	)
      (when (and cdfgData->highVt cdfgData->highVt->value)
	cdfgData->highVt->value = nil
	)
      )
  )
)

;;; 
;;; CDFupdateTranModelParameter --
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: model name parameter is updated and CDFupdateTranLengthParameter is called
;;; Return: 
;;; 
(defun CDFupdateTranModelParameter (cdfgData)
  (let (Lparam modelNameParam modelNameValue)

    ;;The model name needs to be determined based on the 
    ;;idLayer and modelName parameter values
    (setq modelNameParam cdfgData~>idLayer->value)
    (setq modelNameValue (get (get cdfgData modelNameParam) 'value))
    (setq Lparam (strcat modelNameValue "_l"))
    ;;Update the L and W values
    (CDFupdateTranLengthParameter cdfgData Lparam)
    )
)

;;; 
;;; CDFupdateTranModelDisplay --
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: Turns the display on for the matching model parameter based on 
;;;               the selection of the idLayer. Updates the value of model parameter.
;;; Return: 
;;; 
(defun CDFupdateTranModelDisplay (cdfgData idLayerName)
  (when (equal idLayerName cdfgData~>idLayer->value)
    ;;Need to update the model name every time the idLayer is updated
    (CDFupdateTranModelParameter cdfgData)
   )
  (equal idLayerName cdfgData~>idLayer->value)
)

;;; 
;;; CDFupdateTranLengthParameter --
;;;
;;; Input: The name of the discrete length parameter to be updated
;;; Output: 
;;; Globals: 
;;; Side Effects: Updates the golden W and L values
;;; Return: 
;;; 
(defun CDFupdateTranLengthParameter (cdfgData nLength)
  (let (lengthValue lengthChoices nWidth)
    ;;The value in the "l" field must be of dataType float
    cdfgData~>l->value =  (aelNumber (get (get cdfgData nLength) 'value))
    
    (setq lengthValue   (get (get cdfgData nLength) 'value))
    (setq lengthChoices (get (get cdfgData nLength) 'choices))
    
    (setq lengthIndex (difference (length lengthChoices) (length (member lengthValue lengthChoices))))
    
    ;;The proper modelName_l=Value_w and the golden w needs to be updated.
    (setq nWidth (strcat (concat nLength lengthIndex "_w")))

    ;;Updating the golden W
    cdfgData~>w->value = (aelNumber (get (get cdfgData nWidth) 'value))
    )
)



;;; 
;;; CDFupdateTranLdisplay --
;;;
;;; Input: The name of the discrete length parameter to be display
;;; Output: 
;;; Globals: 
;;; Side Effects: Toggles the proper length parameter to be displayed and 
;;;               calls CDFupdateTranLengthParameter
;;; Return: 
;;; 
(defun CDFupdateTranLdisplay (cdfgData nLength)
  (let (nLengthModelName modelParamName modelName)
    ;;This cannot be a simple parse to prevent mis-reading idLayers that have "_" in their name
    ;;So, parse using "_" then get rid of the last element which is "l" and rebuild the string
    (setq nLengthModelName (buildString (reverse (cdr (reverse (parseString nLength "_")))) "_"))
    (setq modelParamName cdfgData~>idLayer->value)
    (setq modelName (get (get cdfgData modelParamName) 'value))

    (when (equal modelName nLengthModelName)
      ;;Need to update the Golden "l" parameter every time the length is updated
      (CDFupdateTranLengthParameter cdfgData nLength)
     )
    (equal modelName nLengthModelName)
 )
)

;;; 
;;; CDFupdateTranWidthParameter --
;;;
;;; Input: The name of the discrete width parameter to be updated
;;; Output: 
;;; Globals: 
;;; Side Effects: Updates the golden W
;;; Return: 
;;; 
(defun CDFupdateTranWidthParameter (cdfgData nWidth)
    cdfgData~>w->value = (aelNumber (get (get cdfgData nWidth) 'value))
)

;;; 
;;; CDFupdateTranWdisplay --
;;;
;;; Input: The model name, the value of the discrete length parameter
;;; Output: 
;;; Globals: 
;;; Side Effects: displays the proper width parameter
;;; Return: 
;;; 
(defun CDFupdateTranWdisplay (cdfgData modelName nLengthValue)
  (let (modelParamName modelNameValue)
    (setq modelParamName cdfgData~>idLayer->value)
    (setq modelNameValue (get (get cdfgData modelParamName) 'value))

    (and 
     (equal (aelNumber nLengthValue) cdfgData->l->value)
     (equal modelName modelNameValue))
    )
)

;;; 
;;; CDFupdateFetDiscContactNum --
;;;  This function checks that the number of conacts is a valid entry.
;;;  If the entered value is invalid, the parameters will be reset to the default value.
;;; Input: 
;;; Output: Updates the number of the Drain and Source contacts based on the Width of the FET
;;; Globals: 
;;; Side Effects: NDC and NSC parameters will be updated
;;; Return: 
;;; 
(defun CDFupdateFetDiscContactNum (@key (wProp 'w) (NSCprop 'NSC) (NDCprop 'NDC))
    (let (fetWidth fetWidthEff contactNum contactWidth contactSpace contactEnclosure contactPitch contactLayer
                   (wp (get cdfgData wProp)) (NDCp (get cdfgData NDCprop)) (NSCp (get cdfgData NSCprop))
                   )
      (cond
       ((TECHresolveLayer  "licon1")
        (setq contactLayer "licon1")
        )
       ((TECHresolveLayer  "ddlicon1")
        (setq contactLayer "ddlicon1")
        )
       ((TECHresolveLayer  "mcon")
        (setq contactLayer "mcon")
        )
       (t
        (error "CDFupdateFetDiscContactNum: unable to resolve contact layer for discrete fets..\n")
        )
       )
      
      (setq contactWidth (TECHgetRuleWith "minWidth" contactLayer))
      (unless contactWidth 
        (error "CDFupdateFetDiscContactNum: %s width must be defined in TECHrep using minWidth parameter" contactLayer))
      (setq contactSpace (TECHgetRuleWith "minSpacing" contactLayer))
      (unless contactSpace
        (error "CDFupdateFetDiscContactNum: %s space must be defined in TECHrep using minSpace parameter" contactLayer))
      (setq contactEnclosure 
            (TECHgetRuleWith "minEnclosureAdj" "diff" contactLayer))
      (unless contactEnclosure
        (error "CDFupdateFetDiscContactNum: %s enclosure by diff must be defined in TECHrep using minSpace parameter" contactLayer))
      (setq contactPitch (plus contactWidth contactSpace))
      
      (setq fetWidth (aelNumber (get wp 'value)))
      (cond
       ((and (numberp (aelNumber fetWidth)) (and (TECHisPropSet doNrdNrsOhms) (TECHgetProp doNrdNrsOhms)))
        (setq fetWidthEff (difference (plus fetWidth contactSpace) (times 2.0 contactEnclosure)))
        (setq contactNum (fix (plus (quotient fetWidthEff contactPitch) 1e-6)))
        (putprop NSCp (sprintf nil "%d" contactNum) 'value)
        (putprop NDCp (sprintf nil "%d" contactNum) 'value)
        )
       (t ;;if the width is parameterized then give equation for contacts
	(setq fetWidth (get wp 'value))
	(setq fetWidth (strcat "(" fetWidth ")"))
	(setq fetWidthEff `(difference (plus ,fetWidth ,contactSpace) (times 2.0 ,contactEnclosure)))
	(setq contactNum `(int (quotient ,fetWidthEff ,contactPitch)))
	(putprop NDCp (sprintf nil "%s" (SCHprefixToInfix contactNum)) 'value)
	(putprop NSCp (sprintf nil "%s" (SCHprefixToInfix contactNum)) 'value)
        )
       )
      )
    )

;;; 
;;; CDFfetDiscContactsCallback --
;;;  This function checks that the number of conacts is a valid entry.
;;;  If the entered value is invalid, the parameters will be reset to the default value.
;;; Input: 
;;; Output: Updates the number of the Drain and Source contacts based on the Width of the FET
;;; Globals: 
;;; Side Effects: NDC and NSC parameters will be updated
;;; Return: 
;;; 
(defun CDFfetDiscContactsCallback (@key (wProp 'w) (NDCprop 'NDC) (NSCprop 'NSC))
  (let (fetWidth fetWidthEff contactLayer contactNum contactWidth contactSpace contactEnclosure contactPitch NDCvalue NSCvalue
                 cellName drnOffsetVal srcOffsetVal
                 (wp (get cdfgData wProp)) (NDCp (get cdfgData NDCprop)) (NSCp (get cdfgData NSCprop))
                 )
    (cond
     ((TECHresolveLayer  "licon1")
      (setq contactLayer "licon1")
      )
     ((TECHresolveLayer  "ddlicon1")
      (setq contactLayer "ddlicon1")
      )
     ((TECHresolveLayer  "mcon")
      (setq contactLayer "mcon")
      )
     (t
      (error "CDFfetDiscContactsCallback: unable to resolve contact layer for discrete fets..\n")
      )
     )

    (setq cellName          cdfgData~>id~>name)
    (setq contactWidth     (TECHgetRuleWith "minWidth"               contactLayer))
    (setq contactSpace     (TECHgetRuleWith "minSpacing"             contactLayer))
    (setq contactEnclosure (TECHgetRuleWith "minEnclosureAdj" "diff" contactLayer))
    (setq contactPitch     (plus contactWidth contactSpace))
    
    (setq fetWidth (aelNumber (get wp 'value)))

    (when (numberp (aelNumber fetWidth))
      
      (setq fetWidthEff (difference (plus fetWidth contactSpace) (times 2.0 contactEnclosure)))
      (setq contactNum (fix (plus (quotient fetWidthEff contactPitch) 1e-6)))
      
      ;;Verify validity of "Number of Drain Contacts"
      (cond
       ((numberp (aelNumber (get NDCp 'value)))
        (putprop NDCp (sprintf nil "%d" (atoi (get NDCp 'value))) 'value)
        
        (setq NDCvalue (fix (aelNumber (get NDCp 'value))))
        (when (minusp NDCvalue)
          (putprop NDCp (sprintf nil "%d" (minus NDCvalue)) 'value)
          (warn "Negative Number of Drain Contacts entered: %d is invalid. Setting to %d\n" 
                NDCvalue (minus NDCvalue))
          )
        )
       (t
        (warn "Number of Drain Contacts entered: %s is invalid. Setting to %d\n" (get NDCp 'value) contactNum)
        (putprop NDCp (sprintf nil "%d" contactNum) 'value)
        )
       )
      (when (greaterp (aelNumber (get NDCp 'value)) contactNum)
        (warn "Number of Drain Contacts entered: %s exceeds maximum. Setting to %d\n" (get NDCp 'value) contactNum)
        (warn "Max contact number allowed is determined by the device width and contact size/space\n")
        (putprop NDCp (sprintf nil "%d" contactNum) 'value)
        )
      (when (and cdfgData~>hspiceModel cdfgData~>drnOffset (equal (aelNumber (get NDCp 'value)) 0))
        ;; logic gates won't have a top level hspiceModel or drnOffset, and it's not worth the trouble to adjust drnOffset for them
        (setq drnOffsetVal (times 0.5
                                  (TECHgetDeviceParam 
                                   (TECHgetDeviceWithModel cellName cdfgData~>hspiceModel~>value)
                                   'fetGateSpacing)))
        
        (warn "Number of Drain Contacts entered is %s . Setting drain offset to %3.3f\n" (get NDCp 'value) drnOffsetVal)
        cdfgData->drnOffset->value = (sprintf nil "%3.3f" drnOffsetVal)
        )
      
      ;;Verify validity of "Number of Source Contacts"
      (cond
       ((numberp (aelNumber (get NSCp 'value)))
        (putprop NSCp (sprintf nil "%d" (atoi (get NSCp 'value))) 'value)
        
        (setq NSCvalue (fix (aelNumber (get NSCp 'value))))
        (when (minusp NSCvalue)
          (putprop NSCp (sprintf nil "%d" (minus NSCvalue)) 'value)
          (warn "Negative Number of Source Contacts entered: %d is invalid. Setting to %d\n" 
                NSCvalue (minus NSCvalue))
          )
        )
       (t
        (warn "Number of Drain Contacts entered: %s is invalid. Setting to %d\n" (get NSCp 'value) contactNum)
        (putprop NSCp (sprintf nil "%d" contactNum) 'value)
        )
       )
      
      (when (greaterp (aelNumber (get NSCp 'value)) contactNum)
        (warn "Number of Source Contacts entered: %s exceeds maximum. Setting to %d\n" (get NSCp 'value) contactNum)
        (warn "Max contact number allowed is determined by the device width and contact size/space\n")
        (putprop NSCp (sprintf nil "%d" contactNum) 'value)
        )
      (when (and cdfgData~>hspiceModel cdfgData~>srcOffset (equal (aelNumber (get NSCp 'value)) 0))
        ;; logic gates won't have a top level hspiceModel or srcOffset, and it's not worth the trouble to adjust srcOffset for them
        (setq srcOffsetVal (times 0.5
                                  (TECHgetDeviceParam 
                                   (TECHgetDeviceWithModel cellName cdfgData~>hspiceModel~>value)
                                   'fetGateSpacing)))
        
        (warn "Number of Source Contacts entered is %s . Setting source offset to %3.3f\n" (get NSCp 'value) srcOffsetVal)
        cdfgData->srcOffset->value = (sprintf nil "%3.3f" srcOffsetVal)
        )
      )

    ;; place # of contacts equation in form
    (unless (numberp (aelNumber fetWidth))
      (setq fetWidth (get wp 'value))
      (setq fetWidth (strcat "(" fetWidth ")"))
      (setq fetWidthEff `(difference (plus ,fetWidth ,contactSpace) (times 2.0 ,contactEnclosure)))
      (setq contactNum `(int (quotient ,fetWidthEff ,contactPitch)))
      (putprop NDCp (sprintf nil "%s" (SCHprefixToInfix contactNum)) 'value)
      (putprop NSCp (sprintf nil "%s" (SCHprefixToInfix contactNum)) 'value)
      )
    
    )
  )

;;; 
;;; CDFfetToggleESD --
;;;   This function does a sanity check to only allow the ESD toggle
;;; to be turned on if the voltage type is maxv.
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFfetToggleESD ()
  (let ((isESD t) theDevices cellName)
    (setq theDevices        (TECHgetMosDevices))
    (setq cellName cdfgData~>id~>name)
    
    (cond 
     ((and cdfgData->vtype2 (equal "maxv" cdfgData->vtype2->value))
      (setq isESD
	    (car (remq nil (mapcar (lambda (x) 
				     (when (and (TECHgetDeviceParam x 'isESD)
						(equal (TECHgetDeviceParam x 'vtype) "maxv")
						(equal (TECHgetDeviceParam x 'cellName) cellName))
				       (TECHgetDeviceParam x 'isESD)))
				   theDevices))))
      )
     (t
      (setq isESD
	    (car (remq nil (mapcar (lambda (x) 
				     (when (and (TECHgetDeviceParam x 'isESD)
						(or (equal (TECHgetDeviceParam x 'vtype) "normal")
						    (equal (TECHgetDeviceParam x 'vtype) nil))
						(equal (TECHgetDeviceParam x 'cellName) cellName))
				       (TECHgetDeviceParam x 'isESD)))
				   theDevices))))
      )
     )

    (when !isESD
      (when (and cdfgData->isESD cdfgData->isESD->value)
	cdfgData->isESD->value = nil
	)
      )

    (when (and cdfgData->sonos cdfgData->isESD)
      (when (and cdfgData->sonos->value cdfgData->isESD->value)
	(info "Info: The \"Is sonos array?\" option must be turned off to select a different device\n")
	cdfgData->isESD->value = nil
	)
      )
    (when (and cdfgData->isESD cdfgData->native)
      (when (and cdfgData->isESD->value cdfgData->native->value)
	(info "Info: The \"Is ESD?\" option must be turned off to select a different device\n")
	cdfgData->native->value = nil
	)
      )
    (when (and cdfgData->isESD cdfgData->highVt)
      (when (and cdfgData->isESD->value cdfgData->highVt->value)
	(info "Info: The \"Is ESD?\" option must be turned off to select a different device\n")
	cdfgData->highVt->value = nil
	)
      )
    )
)
		 
;;; 
;;; CDFfetCallback --
;;;   This is the CDF callback for the fet devices.  It will create/update
;;; the hspiceModel and diodeModel properties on the fet instance. This will
;;; also update the enableLOD prop depending on the hspiceModel value.
;;; 
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFfetCallback (CDFdbid "d")
    (let (fetDevice hspiceModel diodeModel minWidth minLength enableLOD)
      
      (cond
       ;; if they manually specify the spice model
       ((and CDFdbid~>manualSpiceModel
	     (nequal "FALSE" CDFdbid~>manualSpiceModel))
	
	(setq hspiceModel CDFdbid~>hspiceModel)
	
	;; find the techrep device by model name
	(foreach mosDev (TECHgetMosDevices)
		 (when (equal hspiceModel (TECHgetDeviceParam mosDev 'hspiceModel))
		   (setq fetDevice mosDev)
		   )
		 )
	(when fetDevice
	  ;; get the correct diode model from the technology representation
	  (setq diodeModel
		(TECHgetDeviceParam
		 (TECHgetDevice ?name (TECHgetDeviceParam fetDevice 'diode))
		 'hspiceModel)
		)
	  )
	
	)
       ;; if they don't manually specify the spice model
       (t
	;; get the techrep device
	(setq fetDevice (CDFfetGetFetDevice CDFdbid~>cellName))
	
	;; get the correct hspice model from the technology representation
	(setq hspiceModel (TECHgetDeviceParam fetDevice 'hspiceModel))
	
	;; get the minimum gate width and length
	(setq minWidth (TECHgetDeviceParam fetDevice 'minGateWidth))
	(setq minLength (TECHgetDeviceParam fetDevice 'minGateLength))
	
	;; This could be slightly dangerous by overwriting a property that
	;; the user manually defined.
	(when hspiceModel
	  (dbReplaceProp CDFdbid "hspiceModel" "string" hspiceModel)
	)
	
	;; get the correct diode model from the technology representation
	(setq diodeModel
	      (TECHgetDeviceParam
	       (TECHgetDevice ?name (TECHgetDeviceParam fetDevice 'diode))
	       'hspiceModel)
	      )
	
	;; make sure the isSubckt property is set or deleted
	(cond
	 ((TECHgetDeviceParam fetDevice 'isSubckt)
	  (dbReplaceProp CDFdbid "isSubckt" "boolean" "TRUE")
	  )
	 (t
	  (dbDeletePropByName CDFdbid "isSubckt")
	  )
	 )
	)
       )

      ;;resolve enableLOD based on the fetDevice. The last (cond) should set fetDevice.
      (when fetDevice
	  (setq enableLOD (TECHgetDeviceParam fetDevice 'enableLOD))
	  (dbReplaceProp CDFdbid "enableLOD" "boolean" enableLOD)
      )
     
      (cond
       (diodeModel
	;; ShowAll will not work correctly if this does not exist.
	;; Also, the hvacell & hvscell use this property because they
	;; netlist discrete diodes.
	(dbReplaceProp CDFdbid "diodeModel" "string" diodeModel)
	)
       (t
	(warn "Failed to find diodeModel associated with '%L'.  ShowAll will not work with this xtor.\n" hspiceModel)
	;; this is so that the previous warn will actually print
	(warn "Foo...this is just to get the previous warning to print\n")
	(dbDeletePropByName CDFdbid "diodeModel")
	)
       )
      
	;; for those who need training wheels, sanity check the minimum
	;; device size
	(when (ENVgetVal "schematic" "checkFetMinSize")
	    (when minWidth
		(cond
		    ((aelIsNumberP CDFdbid~>w)
		     (when (lessp (aelNumber CDFdbid~>w) minWidth)
			 (warn "Instance %L: Width (%L) is less than minimum (%L); increasing to minimum\n"
			       CDFdbid~>name CDFdbid~>w minWidth
			 )
			 (dbReplaceProp CDFdbid "w" "float" minWidth)
		     )
		    )
		    ;; if it is an empty string, set it to min
		    ((and (stringp CDFdbid~>w)
			  (null (parseString CDFdbid~>w " \t\n")))
		     (warn "Instance %L: Empty width is illegal; setting to minimum (%L)\n"
			   CDFdbid~>name minWidth
		     )
		     (dbReplaceProp CDFdbid "w" "float" minWidth)
		    )
		    ;; if it is an expression that is not directly a number,
		    ;; do nothing
		    (t nil)
		)
	    )
	    (when minLength
		(cond
		    ((aelIsNumberP CDFdbid~>l)
		     (when (lessp (aelNumber CDFdbid~>l) minLength)
			 (warn "Instance %L: Length (%L) is less than minimum (%L); increasing to minimum\n"
			       CDFdbid~>name CDFdbid~>l minLength
			 )
			 (dbReplaceProp CDFdbid "l" "float" minLength)
		     )
		    )
		    ((and (stringp CDFdbid~>l)
			  (null (parseString CDFdbid~>l " \t\n")))
		     (warn "Instance %L: Empty length is illegal; setting to minimum (%L)\n"
			   CDFdbid~>name minLength
		     )
		     (dbReplaceProp CDFdbid "l" "float" minLength)
		    )
		    ;; if it is an expression that is not directly a number,
		    ;; do nothing
		    (t nil)
		)
	    )
	)

	(CDFcreateHideProps CDFdbid)

    )
)

;;; 
;;; CDFfetextdCallback --
;;;   This is the CDF callback for the fetextd devices.  It will create/update
;;; the hspiceModel and diodeModel properties on the fet instance.
;;; 
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFfetextdCallback (CDFdbid "d")
    (let (fetDevice hspiceModel srcDiodeModel drnDiodeModel minWidth minLength)

	(cond
	    ;; if they manually specify the spice model
	    ((and CDFdbid~>manualSpiceModel
		  (nequal "FALSE" CDFdbid~>manualSpiceModel))

	     (setq hspiceModel CDFdbid~>hspiceModel)

	     ;; find the techrep device by model name
	     (foreach extdDev (TECHgetExtDrainDevices)
		 (when (equal hspiceModel (TECHgetDeviceParam extdDev 'hspiceModel))
		     (setq fetDevice extdDev)
		 )
	     )
	     (when fetDevice
		 ;; get the correct source diode model from the technology representation
		 (setq srcDiodeModel
		       (TECHgetDeviceParam
			(TECHgetDevice ?name (TECHgetDeviceParam fetDevice 'srcdiode))
			'hspiceModel)
		 )
		 ;; get the correct drain diode model from the technology representation
		 (setq drnDiodeModel
		       (TECHgetDeviceParam
			(TECHgetDevice ?name (TECHgetDeviceParam fetDevice 'drndiode))
			'hspiceModel)
		 )

	     )

	    )
	    ;; if they don't manually specify the spice model
	    (t
	     ;; get the techrep device
	     (setq fetDevice (CDFfetGetFetDevice CDFdbid~>cellName))

	     ;; get the correct hspice model from the technology representation
	     (setq hspiceModel (TECHgetDeviceParam fetDevice 'hspiceModel))

	     ;; get the minimum gate width and length
	     (setq minWidth (TECHgetDeviceParam fetDevice 'minGateWidth))
	     (setq minLength (TECHgetDeviceParam fetDevice 'minGateLength))

	     ;; This could be slightly dangerous by overwriting a property that
	     ;; the user manually defined.
	     (when hspiceModel
		 (dbReplaceProp CDFdbid "hspiceModel" "string" hspiceModel)
	     )

	     ;; get the correct source diode model from the technology representation
	     (setq srcDiodeModel
		   (TECHgetDeviceParam
		    (TECHgetDevice ?name (TECHgetDeviceParam fetDevice 'srcdiode))
		    'hspiceModel)
		   )
	     ;; get the correct drain diode model from the technology representation
	     (setq drnDiodeModel
		   (TECHgetDeviceParam
		    (TECHgetDevice ?name (TECHgetDeviceParam fetDevice 'drndiode))
		    'hspiceModel)
		   )

;;	     ;; make sure the isSubckt property is set or deleted
;;	     (cond
;;		 ((TECHgetDeviceParam fetDevice 'isSubckt)
;;		  (dbReplaceProperty CDFdbid "isSubckt" "boolean" "TRUE")
;;		 )
;;		 (t
;;		  (dbDeletePropByName CDFdbid "isSubckt")
;;		 )
;;	     )
	    )
	)

	(cond
	    (srcDiodeModel
	     ;; ShowAll will not work correctly if this does not exist.
	     (dbReplaceProp CDFdbid "srcDiodeModel" "string" srcDiodeModel)
	    )
	    (t
	     (warn "Failed to find source diodeModel associated with '%L'.  ShowAll will not work with this xtor.\n" hspiceModel)
	     ;; this is so that the previous warn will actually print
	     (warn "Foo...this is just to get the previous warning to print\n")
	     (dbDeletePropByName CDFdbid "srcDiodeModel")
	    )
	)

	(cond
	    (drnDiodeModel
	     ;; ShowAll will not work correctly if this does not exist.
	     ;; Also, the hvacell & hvscell use this property because they
	     ;; netlist discrete diodes.
	     (dbReplaceProp CDFdbid "drnDiodeModel" "string" drnDiodeModel)
	    )
	    (t
	     (warn "Failed to find drain diodeModel associated with '%L'.  ShowAll will not work with this xtor.\n" hspiceModel)
	     ;; this is so that the previous warn will actually print
	     (warn "Foo...this is just to get the previous warning to print\n")
	     (dbDeletePropByName CDFdbid "drnDiodeModel")
	    )
	)

	;; for those who need training wheels, sanity check the minimum
	;; device size
	(when (ENVgetVal "schematic" "checkFetMinSize")
	    (when minWidth
		(cond
		    ((aelIsNumberP CDFdbid~>w)
		     (when (lessp (aelNumber CDFdbid~>w) minWidth)
			 (warn "Instance %L: Width (%L) is less than minimum (%L); increasing to minimum\n"
			       CDFdbid~>name CDFdbid~>w minWidth
			 )
			 (dbReplaceProp CDFdbid "w" "float" minWidth)
		     )
		    )
		    ;; if it is an empty string, set it to min
		    ((and (stringp CDFdbid~>w)
			  (null (parseString CDFdbid~>w " \t\n")))
		     (warn "Instance %L: Empty width is illegal; setting to minimum (%L)\n"
			   CDFdbid~>name minWidth
		     )
		     (dbReplaceProp CDFdbid "w" "float" minWidth)
		    )
		    ;; if it is an expression that is not directly a number,
		    ;; do nothing
		    (t nil)
		)
	    )
	    (when minLength
		(cond
		    ((aelIsNumberP CDFdbid~>l)
		     (when (lessp (aelNumber CDFdbid~>l) minLength)
			 (warn "Instance %L: Length (%L) is less than minimum (%L); increasing to minimum\n"
			       CDFdbid~>name CDFdbid~>l minLength
			 )
			 (dbReplaceProp CDFdbid "l" "float" minLength)
		     )
		    )
		    ((and (stringp CDFdbid~>l)
			  (null (parseString CDFdbid~>l " \t\n")))
		     (warn "Instance %L: Empty length is illegal; setting to minimum (%L)\n"
			   CDFdbid~>name minLength
		     )
		     (dbReplaceProp CDFdbid "l" "float" minLength)
		    )
		    ;; if it is an expression that is not directly a number,
		    ;; do nothing
		    (t nil)
		)
	    )
	)

	(CDFcreateHideProps CDFdbid)

    )
)

;;; 
;;; CDFlogicCallback --
;;; 
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFlogicCallback (CDFdbid "d")
    (let (diodeModel propId)

	;; the hspice model is not needed now that we hardcode default
	;; fet model names in the hspice netlister.  It will see an nlp
	;; expression for the hspiceModel prop of each fet in the logic
	;; schematic, and then use the fet's default hspice model

	;; get the correct diode model from the technology representation.
	;; ShowAll will not work correctly if these do not exist.
	(setq diodeModel
	      (TECHgetDeviceParam
	       (TECHgetDevice ?name (TECHgetDeviceParam
				     (TECHgetDevice ?name 'nfet)
				     'diode))
	       'hspiceModel)
	)
	(when diodeModel
	    (dbReplaceProp CDFdbid "nfetDiodeModel" "string" diodeModel)
	)

	;; get the correct diode model from the technology representation.
	;; ShowAll will not work correctly if these do not exist
	(setq diodeModel
	      (TECHgetDeviceParam
	       (TECHgetDevice ?name (TECHgetDeviceParam
				     (TECHgetDevice ?name 'pfet)
				     'diode))
	       'hspiceModel)
	)
	(when diodeModel
	    (dbReplaceProp CDFdbid "pfetDiodeModel" "string" diodeModel)
	)

	;; we have changed the property "subcktMult" to now be "m".
	;; Purge away the old subcktMult properties.  It is unnecessary
	;; to create the "m" properties here because "m" is now in the
	;; CDF, and the CDF initialization procedure will grab the value
	;; of the subcktMult property and stuff it into the m field
	;;
	(when (setq propId (dbFindProp CDFdbid "subcktMult"))
	    (dbDeleteObject propId)
	)

	;; create the current monitor property HSPmonitorTerms if the
	;; currentMonitor boolean is set for this logic gate
	(cond (
	       (and CDFdbid~>currentMonitor
		    (nequal "FALSE" CDFdbid~>currentMonitor))
	       (cond
		   ((equal "csw_p" CDFdbid~>cellName)
		    (dbReplaceProp CDFdbid "HSPmonitorTerms" "ILList"
				   (list "vpb" "vnb"))
		   )
		   (t
		    (dbReplaceProp CDFdbid "HSPmonitorTerms" "ILList"
				   (list "vpwr" "vpb" "vnb" "vgnd"))
		   )
	       )
	      )
	    (t
	     (dbDeletePropByName CDFdbid "HSPmonitorTerms")
	    )
	)
	(CDFcreateHideProps CDFdbid)
	(CDFcreateAsymProps CDFdbid)
        ;; if we have parameters named <something>NSC<something> or <something>NDC<something>,
        ;; we need to hit the callback for CDFhitCallbacks to store the desired properties
        (foreach param cdfgData~>parameters
                 (when (and (rexMatchp "N[SD]C" param~>name) param~>callback)
                   (CDFevalString param~>callback) 
                   )
                 )
        t
    )
)

;;; 
;;; CDFhspiceStringToFloat --
;;;   Converts a string to a floating point, comprehending hspice unit
;;; abbreviations.
;;; 
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFhspiceStringToFloat (str)
    (cond
	;; if AEL knows how do deal with this number, deal with it
	((aelIsNumberP str)
	 (aelNumber str)
	)
	(t
	 (let (upstr numPart lenNumPart suffixPart suffix)
	     (setq upstr (upperCase str))
	     (setq numPart (car (parseString upstr "ABCDEFGHIJKLMNOPQRSTUVWXYZ")))
	     (cond
		 (numPart
		  (setq lenNumPart (strlen numPart))
		  (setq suffixPart (substring upstr (xplus 1 lenNumPart)
					      (xdifference (strlen upstr) lenNumPart)
				   )
		  )
		  (when (member suffixPart '(nil "MEG" "MI" "F" "P"
						 "N" "U" "M" "K" "G"))
		      (setq suffix
			    (cond
				((null suffixPart) 1)
				((zerop (strncmp suffixPart "MEG" 3)) 1e6)
				((zerop (strncmp suffixPart "MI" 2)) 25.4e-6)
				((zerop (strncmp suffixPart "F" 1)) 1e-15)
				((zerop (strncmp suffixPart "P" 1)) 1e-12)
				((zerop (strncmp suffixPart "N" 1)) 1e-9)
				((zerop (strncmp suffixPart "U" 1)) 1e-6)
				((zerop (strncmp suffixPart "M" 1)) 1e-3)
				((zerop (strncmp suffixPart "K" 1)) 1e3)
				((zerop (strncmp suffixPart "G" 1)) 1e9)
				(t 1.0)
			    )
		      )
		  )
		 )
	     )
	     (cond
		 ((and numPart (aelIsNumberP numPart) suffix)
		  (times (aelNumber numPart) suffix)
		 )
		 (t str)
	     )
	 )
	)
    )
)
 
;;; 
;;; CDFhspiceFloatToString --
;;;   Converts a floating point to a string, setting hspice unit abbreviations
;;; in the string.
;;; 
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFhspiceFloatToString (flt "f")
    (let ((absFlt (abs flt))
          suffixPair
         )
        (setq suffixPair
              (cond
		  ((lessp absFlt 1e-12) '("F" 1e-15))
		  ((and (lessp absFlt 1e-9) (geqp absFlt 1e-12)) '("p" 1e-12))
		  ((and (lessp absFlt 1e-6) (geqp absFlt 1e-9)) '("n" 1e-9))
		  ((and (lessp absFlt 1e-3) (geqp absFlt 1e-6)) '("u" 1e-6))
		  ((and (lessp absFlt 1) (geqp absFlt 1e-3)) '("m" 1e-3))
		  ((and (lessp absFlt 1e3) (geqp absFlt 1)) '("" 1))
		  ((and (lessp absFlt 1e6) (geqp absFlt 1e3)) '("K" 1e3))
		  ((and (lessp absFlt 1e9) (geqp absFlt 1e6)) '("M" 1e6))
		  ((geqp absFlt 1e9) '("G" 1e9))
              )
        )
        (sprintf nil "%g%s" (quotient flt (cadr suffixPair)) (car suffixPair))
    )
)

;;; 
;;; CDFgetResTechrepDevice --
;;; 
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFgetResTechrepDevice (cellName cdfgData "to")
    (let (resLayer doping cdf_well1 cdf_diff1 cdf_diff2 cdf_diff3 cdf_poly1
	 cdf_li1 cdf_nwell cdf_ddli cdf_lm1 cdf_litr cdf_met1 cdf_met2)
	(setq cdf_well1 (car (TECHresolveLayer "cdf_well1")))
	(setq cdf_diff1 (car (TECHresolveLayer "cdf_diff1")))
	(setq cdf_diff2 (car (TECHresolveLayer "cdf_diff2")))
	(setq cdf_diff3 (car (TECHresolveLayer "cdf_diff3")))
	(setq cdf_poly1 (car (TECHresolveLayer "cdf_poly1")))
	(setq cdf_li1   (car (TECHresolveLayer "cdf_li1")))
        (setq cdf_nwell (car (TECHresolveLayer "cdf_nwell")))
	(setq cdf_ddli  (car (TECHresolveLayer "cdf_ddli")))
	(setq cdf_lm1   (car (TECHresolveLayer "cdf_lm1")))
	(setq cdf_litr  (car (TECHresolveLayer "cdf_litr")))
	(setq cdf_met1  (car (TECHresolveLayer "cdf_met1")))
	(setq cdf_met2  (car (TECHresolveLayer "cdf_met2")))

	(car
	 (remq nil
	       (mapcar
		(lambda (x)
		  (when
		        ;; when we find a res that matches the layer
			;; do further conditions per layer
			(equal cdfgData->resistorType->value
			       (setq resLayer
				     (TECHgetDeviceParam x 'layer)))

			(cond
			    ((equal resLayer "diff")
			     (setq doping
				    (TECHgetDeviceParam
				       (TECHgetDevice
					?name (TECHgetDeviceParam x 'diode))
				       'doping))
			     (setq hv (TECHgetDeviceParam x 'isHV)) 

	
			     ;; 1. when it is a resn & doping is n
			     ;; 2. when it is a res & isPtype is nil
			     ;; 3. when it is a resp & doping is p
			     ;; 4. when it is a res & isPtype is t
			     ;; then this device matches!
			     (when (or  (and (equal doping "n")
					    (equal cellName "resn")
					    (equal hv cdfgData->isHV->value))
                                       (and (equal doping "n")
					    (equal cellName "res")
					    (or (null  cdfgData->isPtype->value)
						(equal cdfgData->isPtype->value "FALSE")))
				       (and (equal doping "p")
					    (equal cellName "resp")
					    (equal hv cdfgData->isHV->value))
				       (and (equal doping "p")
					    (equal cellName "res")
					    (and cdfgData->isPtype->value
						 (nequal "FALSE" cdfgData->isPtype->value)))
				       )
			       x
			       )
			     )
			    ;; match the model name for diff1
			    ((and cdfgData->diff1mod->use
				  (evalstring cdfgData->diff1mod->use)
				  (equal resLayer cdf_diff1))
			     (when (equal cdfgData->diff1mod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )
			    
			    ;; match the model name for diff2
			    ((and cdfgData->diff2mod->use
				  (evalstring cdfgData->diff2mod->use)
				  (equal resLayer cdf_diff2))
			     (when (equal cdfgData->diff2mod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )
			    
			    ;; match the model name for diff3
			    ((and cdfgData->diff3mod->use
				  (evalstring cdfgData->diff3mod->use)
				  (equal resLayer cdf_diff3))
			     (when (equal cdfgData->diff3mod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )

			    ;; match the model name for well1
			    ((and cdfgData->well1mod->use
				  (evalstring cdfgData->well1mod->use)
				  (equal resLayer cdf_well1))
			     (when (equal cdfgData->well1mod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )			    
			    
			    ;; match the model name for poly
			    ((and cdfgData->rpmod->use
				  (evalstring cdfgData->rpmod->use)
				  (member resLayer `("poly" ,cdf_poly1)))
			     (when (equal cdfgData->rpmod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )

			    ;; match the model name for rpoly
			    ((and cdfgData->rpolymod->use
				  (evalstring cdfgData->rpolymod->use)
				  (equal resLayer "rpoly"))
			     (when (equal cdfgData->rpolymod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )
			     ;; match the model name for ad
			    ((and cdfgData->admod->use
				  (evalstring cdfgData->admod->use)
				  (equal resLayer "ad"))
			     (when (equal cdfgData->admod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )
			     ;; match the model name for nd
			    ((and cdfgData->ndmod->use
				  (evalstring cdfgData->ndmod->use)
				  (equal resLayer "nd"))
			     (when (equal cdfgData->ndmod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )
			     ;; match the model name for pd
			    ((and cdfgData->pdmod->use
				  (evalstring cdfgData->pdmod->use)
				  (equal resLayer "pd"))
			     (when (equal cdfgData->pdmod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )
			     ;; match the model name for nw 
			    ((and cdfgData->nwmod->use
				  (evalstring cdfgData->nwmod->use)
				  (equal resLayer "wn"))
			     (when (equal cdfgData->nwmod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )
			    ;; match the model name for tfr
			    ((and cdfgData->tfrmod->use
				  (evalstring cdfgData->tfrmod->use)
				  (equal resLayer "tfr"))
			     (when (equal cdfgData->tfrmod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )

			    ;; match the model name for pwell
			    ((and cdfgData->pwellmod->use
				  (evalstring cdfgData->pwellmod->use)
				  (equal resLayer "pwell"))
			     (when (equal cdfgData->pwellmod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )

			    ;; match the model name for li1
			    ((and cdfgData->limod->use
				  (evalstring cdfgData->limod->use)
				  (member resLayer `("li1" ,cdf_li1)))
			     (when (equal cdfgData->limod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )

			    ;; match the model name for nwell
			    ((and cdfgData->nwellmod->use
				  (evalstring cdfgData->nwellmod->use)
				  (member resLayer `("nwell" ,cdf_nwell)))
			     (when (and 
				    (equal cdfgData->nwellmod->value
					   (TECHgetDeviceParam x 'hspiceModel)
					   )
				    (equal cdfgData->isHV->value (TECHgetDeviceParam x 'isHV))
				    )
				    
			       x
			       )
			     )

			    ;; match the model name for ddli
			    ((and cdfgData->ddlimod->use
				  (evalstring cdfgData->ddlimod->use)
				  (member resLayer `("ddli" ,cdf_ddli)))
			     (when (equal cdfgData->ddlimod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )

			    ;; match the model name for lm1
			    ((and cdfgData->lm1mod->use
				  (evalstring cdfgData->lm1mod->use)
				  (member resLayer `("lm1" ,cdf_lm1)))
			     (when (equal cdfgData->lm1mod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )

			    ;; match the model name for litr
			    ((and cdfgData->litrmod->use
				  (evalstring cdfgData->litrmod->use)
				  (member resLayer `("litr" ,cdf_litr)))
			     (when (equal cdfgData->litrmod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )

			    ;; match the model name for met1
			    ((and cdfgData->met1mod->use
				  (evalstring cdfgData->met1mod->use)
				  (member resLayer `("met1" ,cdf_met1)))
			     (when (equal cdfgData->met1mod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )

			    ;; match the model name for met2
			    ((and cdfgData->met2mod->use
				  (evalstring cdfgData->met2mod->use)
				  (member resLayer `("met2" ,cdf_met2)))
			     (when (equal cdfgData->met2mod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )

			    ;; match the model name for met3
			    ((and cdfgData->met3mod->use
				  (evalstring cdfgData->met3mod->use)
				  (equal resLayer "met3"))
			     (when (equal cdfgData->met3mod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )

			    ;; match the model name for met4
			    ((and cdfgData->met4mod->use
				  (evalstring cdfgData->met4mod->use)
				  (equal resLayer "met4"))
			     (when (equal cdfgData->met4mod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )

			    ;; match the model name for met5
			    ((and cdfgData->met5mod->use
				  (evalstring cdfgData->met5mod->use)
				  (equal resLayer "met5"))
			     (when (equal cdfgData->met5mod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )

			    ;; match the model name for met6
			    ((and cdfgData->met6mod->use
				  (evalstring cdfgData->met6mod->use)
				  (equal resLayer "met6"))
			     (when (equal cdfgData->met6mod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )			  

			    ;; match the model name for met7
			    ((and cdfgData->met7mod->use
				  (evalstring cdfgData->met7mod->use)
				  (equal resLayer "met7"))
			     (when (equal cdfgData->met7mod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )

			    ;; match the model name for met8
			    ((and cdfgData->met8mod->use
				  (evalstring cdfgData->met8mod->use)
				  (equal resLayer "met8"))
			     (when (equal cdfgData->met8mod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )
			    
			    ;; match the model name for metd
			    ((and cdfgData->metdmod->use
				  (evalstring cdfgData->metdmod->use)
				  (equal resLayer "metd"))
			     (when (equal cdfgData->metdmod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )

			    ;; match the model name for rdl
			    ((and cdfgData->rdlmod->use
				  (evalstring cdfgData->rdlmod->use)
				  (equal resLayer "rdl"))
			     (when (equal cdfgData->rdlmod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )
			) ; closing cond on layers
		    ) ; closing when layer matches
		) ; closing lambda

		;; apply all the resistor devices to the lambda function
		(TECHgetResistorDevices)
	       )
	 )
	)
    )
)




;;; 
;;; CDFgetRes3TechrepDevice --
;;; 
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFgetRes3TechrepDevice (cellName cdfgData "to")
    (let (resLayer)
	(car
	 (remq nil
	       (mapcar
		(lambda (x)
		    (when
			;; when we find a res that matches the layer
			;; do further conditions per layer
			(equal cdfgData->resistorType->value
			       (setq resLayer
				     (TECHgetDeviceParam x 'layer)))
			
			(cond
			    ;; match the model name for diff
			    ((and cdfgData->diffmod->use
				  (evalstring cdfgData->diffmod->use)
				  (equal resLayer "diff"))
			     (when (equal cdfgData->diffmod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )
			    ;; match the model name for rpoly
			    ((and cdfgData->rpolymod->use
				  (evalstring cdfgData->rpolymod->use)
				  (equal resLayer "rpoly"))
			     (when (equal cdfgData->rpolymod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )
                            ;; match the model name for rpoly
			    ((and cdfgData->polymod->use
				  (evalstring cdfgData->polymod->use)
				  (equal resLayer "poly"))
			     (when (equal cdfgData->polymod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )

			     ;; match the model name for ad
			    ((and cdfgData->admod->use
				  (evalstring cdfgData->admod->use)
				  (equal resLayer "ad"))
			     (when (equal cdfgData->admod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )
			     ;; match the model name for nd
			    ((and cdfgData->ndmod->use
				  (evalstring cdfgData->ndmod->use)
				  (equal resLayer "nd"))
			     (when (equal cdfgData->ndmod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )
			     ;; match the model name for pd
			    ((and cdfgData->pdmod->use
				  (evalstring cdfgData->pdmod->use)
				  (equal resLayer "pd"))
			     (when (equal cdfgData->pdmod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )
			     ;; match the model name for nw
			    ((and cdfgData->nwmod->use
				  (evalstring cdfgData->nwmod->use)
				  (equal resLayer "wn"))
			     (when (equal cdfgData->nwmod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )
			    ;; match the model name for tfr
			    ((and cdfgData->tfrmod->use
				  (evalstring cdfgData->tfrmod->use)
				  (equal resLayer "tfr"))
			     (when (equal cdfgData->tfrmod->value
					  (TECHgetDeviceParam x 'hspiceModel)
				   )
				 x
			     )
			    )
			) ; closing cond on layers
		    ) ; closing when layer matches
		) ; closing lambda
		
		;; apply all the resistor devices to the lambda function
		(TECHgetRes3Devices)
	       )
	 )
	)
    )
)






;;; 
;;; CDFgetCapTechrepDevice --
;;; 
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFgetCapTechrepDevice (cellName cdfgData "to")
    (let (resLayer doping cdf_well1 cdf_diff1 cdf_diff2 cdf_diff3 cdf_poly1
	 cdf_li1 cdf_nwell cdf_ddli cdf_lm1 cdf_litr cdf_met1 cdf_met2)
	(setq cdf_well1 (car (TECHresolveLayer "cdf_well1")))
	(setq cdf_diff1 (car (TECHresolveLayer "cdf_diff1")))
        (setq cdf_nwell (car (TECHresolveLayer "cdf_nwell")))
	(setq cdf_diff2 (car (TECHresolveLayer "cdf_diff2")))
	(setq cdf_diff3 (car (TECHresolveLayer "cdf_diff3")))
	(setq cdf_poly1 (car (TECHresolveLayer "cdf_poly1")))
	(setq cdf_li1   (car (TECHresolveLayer "cdf_li1")))
	(setq cdf_ddli  (car (TECHresolveLayer "cdf_ddli")))
	(setq cdf_lm1   (car (TECHresolveLayer "cdf_lm1")))
	(setq cdf_litr  (car (TECHresolveLayer "cdf_litr")))
	(setq cdf_met1  (car (TECHresolveLayer "cdf_met1")))
	(setq cdf_met2  (car (TECHresolveLayer "cdf_met2")))

	(car
	 (remq nil
	       (mapcar
		(lambda (x)
		    (when
			;; when we find a res that matches the layer
			;; do further conditions per layer
			(or 
			 (equal cdfgData->resistorType->value
				(setq resLayer
				      (TECHgetDeviceParam x 'layer)))
			 (equal cdfgData->resistorType->value
				 (setq resLayer "User"))
			 )

			(cond
			    ;; match the model name for poly
			    ((member resLayer `("poly" ,cdf_poly1))
			     cdfgData->rpcmod->value
			    )

			    ;; match the model name for rpoly
			    ((equal resLayer "rpoly")
			     cdfgData->rpolycmod->value
			    )
			     ;; match the model name for ad
			    ((equal resLayer "ad")
			     cdfgData->admod->value
			    )
			     ;; match the model name for nd
			    ((equal resLayer "nd")
			     cdfgData->ndmod->value
			    )
			     ;; match the model name for pd
			    ((equal resLayer "pd")
			     cdfgData->pdmod->value
			    )
			     ;; match the model name for nw
			    ((equal resLayer "wn")
			     cdfgData->nwmod->value
			    )
			    ;; match the model name for tfr
			    ((equal resLayer "tfr")
			     cdfgData->tfrcmod->value
			    )

			    ;; match the model name for li1
			    ((member resLayer `("li1" ,cdf_li1))
			     cdfgData->licmod->value
			    )

			    ;; match the model name for nwell
			    ((member resLayer `("nwell" ,cdf_nwell))
			     cdfgData->nwellcmod->value
			    )

			    ;; match the model name for ddli
			    ((member resLayer `("ddli" ,cdf_ddli))
			     cdfgData->ddlicmod->value
			    )

			    ;; match the model name for lm1
			    ((member resLayer `("lm1" ,cdf_lm1))
			     cdfgData->lm1cmod->value
			    )

			    ;; match the model name for litr
			    ((member resLayer `("litr" ,cdf_litr))
			     cdfgData->litrcmod->value
			    )

			    ;; match the model name for met1
			    ((member resLayer `("met1" ,cdf_met1))
			     cdfgData->met1cmod->value
			    )

			    ;; match the model name for met2
			    ((member resLayer `("met2" ,cdf_met2))
			     cdfgData->met2cmod->value
			    )

			    ;; match the model name for met3
			    ((equal resLayer "met3")
			     cdfgData->met3cmod->value
			    )

			    ;; match the model name for met4
			    ((equal resLayer "met4")
			     cdfgData->met4cmod->value
			    )

			    ;; match the model name for met5
			    ((equal resLayer "met5")
			     cdfgData->met5cmod->value
			    )

			    ;; match the model name for met6
			    ((equal resLayer "met6")
			     cdfgData->met6cmod->value
			    )

			    ;; match the model name for met7
			    ((equal resLayer "met7")
			     cdfgData->met7cmod->value
			    )

			    ;; match the model name for met8
			    ((equal resLayer "met8")
			     cdfgData->met8cmod->value
			    )

			    ;; match the model name for metd
			    ((equal resLayer "metd")
			     cdfgData->metdcmod->value
			    )

			    ;; match the model name for rdl
			    ((equal resLayer "rdl")
			     cdfgData->rdlcmod->value
			    )

			    ;; match the model name for User defined res
			    ((equal resLayer "User")
			     cdfgData->userRcapModel->value
			    )

			) ; closing cond on layers
		    ) ; closing when layer matches
		) ; closing lambda

		;; apply all the resistor devices to the lambda function
		(TECHgetResistorDevices)
	       )
	 )
	)
    )
)
;;; 
;;; CDFcalculateRes --
;;;   This is the callback function that will actually calculate the
;;; resistance or resistor length when a resistor is placed.
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFcalculateRes (isRdriven r rm rw rl resDevice cdfgData
				  @optional rcon0m rcon1m)
    (let (R
	  sheetResistance
	  (resGrid (or (TECHgetLayerProp
			(TECHgetDeviceParam resDevice 'layer) 'snapGrid)
		       (TECHgetProp snapGrid)))
	  (isSubcktRes (TECHgetDeviceParam resDevice 'isSubckt))
	  (headRes (TECHgetDeviceParam resDevice 'headRes))
	  (deltaW (TECHgetDeviceParam resDevice 'deltaW))
	  (deltaL (TECHgetDeviceParam resDevice 'deltaL))
	  (contactRes 0.0)
	  rconDevice contactModel
	 )

	;; try to get the properties as floats, not strings
	(when (nequal r "")
	    (setq R (CDFhspiceStringToFloat r))
	)
	(foreach x '(rm rw rl rcon0m rcon1m)
	    (when (and (stringp (eval x)) (aelIsNumberP (eval x)))
		(set x (aelNumber (eval x)))
	    )
	)

	(when (and (equal "poly" (TECHgetDeviceParam resDevice 'layer))
		   (setq contactModel
			 (TECHgetDeviceParam resDevice 'contactModel))
	      )
	    (foreach x (TECHgetRconDevices)
		(when (equal contactModel (TECHgetDeviceParam x 'hspiceModel))
		    (setq contactRes (TECHgetDeviceParam x 'contactRes))
		)
	    )
	    (unless rcon0m (setq rcon0m 0))
	    (unless rcon1m (setq rcon1m 0))
	    (cond
		;; if the contact resistance was not a number
		((null contactRes)
		 (setq contactRes 0.0)
		)
		;; if all the contact resistances are numbers
		((and (numberp contactRes) (numberp rcon0m) (numberp rcon1m))
		 (setq contactRes (times contactRes (plus rcon0m rcon1m)))
		)
		;; if some of the contact resistances are parameters
		(t
		 (foreach x '(contactRes rcon0m rcon1m)
		     (when (numberp (eval x))
			 (set x (sprintf nil "%L" (eval x)))
		     )
		 )
		 (setq contactRes (sprintf nil "(%s*(%s+%s))"))
		)
	    )
	)

	;; make sure that the width delta is defined.  In the spice
	;; world, dw is assumed to be per side.  However, the EDR has
	;; the total deltaW.  Therefore, there is not a need to multiply
	;; by two here.  However, the spice models should have half of
	;; this deltaW.  (Also, positive deltaW means that the actual
	;; fabbed line is smaller, and a negative deltaW means that the
	;; fabbed line is larger.)
	;;
	(unless deltaW (setq deltaW 0.0))
	(unless deltaL (setq deltaL 0.0))

	;; get the sheet resistance.  User defined resistors have a
	;; separate field for the user to specify the sheetres.
	;; Regular devices have their sheet res defined in the techrep.
	;; Also, see if there is a high or low resistance sheetres.
	;;
	(cond
	    ((and cdfgData->usermod->value
		  (evalstring cdfgData->usermod->use))
	     (setq sheetResistance cdfgData->userSheetRes->value)
	    )
	    (t
	     (setq sheetResistance (TECHgetDeviceParam resDevice 'sheet))
	    )
	)

	(cond
	    ;; when resistance driven, calculate resistor length
	    (isRdriven
	     (cond 
	      ((and isSubcktRes headRes)
	       (cond
		   ;; if everything is a number, do real math
		   ((and (numberp R)
			 (numberp rm)
			 (numberp headRes)
			 (numberp rw)
			 (numberp sheetResistance))
		    (setq rl (plus (quotient (times (difference (times R rm) headRes) (difference rw deltaW)) sheetResistance) deltaL))
		   )
		   (t
		    ;; otherwise, if at least one thing was a string,  make
		    ;; sure that everything is a string, and build an equation
		    ;;
		    (when (numberp R) (setq R (sprintf nil "%g" R)))
		    (when (floatp rm) (setq rm (sprintf nil "%g" rm)))
		    (when (integerp rm) (setq rm (sprintf nil "%d" rm)))
		    (when (numberp headRes)
			(setq headRes (sprintf nil "%g" headRes)))
		    (when (numberp rw) (setq rw (sprintf nil "%g" rw)))
		    (when (numberp sheetResistance)
			(setq sheetResistance (sprintf nil "%g" sheetResistance)))
		    (when (numberp deltaW)
			(setq deltaW (sprintf nil "%g" deltaW)))
		    (when (numberp deltaL)
		        (setq deltaL (sprintf nil "%g" deltaL)))
		    (setq rl (sprintf nil "(((((%s*%s)-%s)*(%s-%s))/%s)+%s)"
				      R rm headRes rw deltaW sheetResistance deltaL)
		    )
		   )
	       )
	      )
	      ;; if it is not a subckt resistor
	      (t
	       (cond
		   ;; if everything is a number, do real math
		   ((and (numberp R)
			 (numberp rm)
			 (numberp rw)
			 (numberp sheetResistance)
			 (numberp contactRes))
		    (setq rl (plus (quotient (times (difference (times R rm) contactRes) (difference rw deltaW))
				       sheetResistance) deltaL))
		   )
		   (t
		    ;; otherwise, if at least one thing was a string,  make
		    ;; sure that everything is a string, and build an equation
		    ;;
		    (foreach x '(R rm rw sheetResistance deltaW deltaL contactRes)
			(when (numberp (eval x))
			    (set x (sprintf nil "%L" (eval x)))
			)
		    )
		    (setq rl (sprintf nil "(((((%s*%s)-%s)*(%s-%s))/%s)+%s)"
				      R rm contactRes rw deltaW
				      sheetResistance deltaL))
		   )
	       )
	      )
	     )
	     ;; snap it to a grid if it is a number.  If it is an expression,
	     ;; we have no chance of snapping it to grid
	     (when (numberp rl)
		 (setq rl (times (round (quotient rl resGrid)) resGrid))
	     )
	     ;; return the length
	     rl
	    )
	    ;; when length driven, calculate resistor resistance
	    (t
	     (cond 
	      ((and isSubcktRes headRes)
	       (cond
		   ((and (numberp headRes)
			 (numberp rm)
			 (numberp rl)
			 (numberp sheetResistance)
			 (numberp rw))
		    (setq R (plus
			     (quotient headRes rm)
			     (quotient (times (difference rl deltaL) sheetResistance)
				       (difference rw deltaW)
				       rm)
			    )
		    )
		   )
		   (t
		    (when (numberp headRes)
			(setq headRes (sprintf nil "%g" headRes)))
		    (when (floatp rm) (setq rm (sprintf nil "%g" rm)))
		    (when (integerp rm) (setq rm (sprintf nil "%d" rm)))
		    (when (numberp rl) (setq rl (sprintf nil "%g" rl)))
		    (when (numberp sheetResistance)
			(setq sheetResistance (sprintf nil "%g" sheetResistance)))
		    (when (numberp rw) (setq rw (sprintf nil "%g" rw)))
		    (when (numberp deltaW)
			(setq deltaW (sprintf nil "%g" deltaW)))
		    (when (numberp deltaL)
		        (setq deltaL (sprintf nil "%g" deltaL)))
		    (setq R (sprintf nil "((%s/%s)+(((%s-%s)*%s)/((%s-%s)*%s)))"
				     headRes rm rl deltaL sheetResistance
				     rw deltaW rm))
		   )
	       )
	      )
	      (t
	       (cond
		   ((and (numberp rm)
			 (numberp rl)
			 (numberp sheetResistance)
			 (numberp rw)
			 (numberp contactRes))
		    (setq R (plus (quotient (times (difference rl deltaL) sheetResistance) (times rm (difference rw deltaW))) contactRes))
		   )
		   (t
		    (foreach x '(rm rl rw sheetResistance deltaW deltaL contactRes)
			(when (numberp (eval x))
			    (set x (sprintf nil "%L" (eval x)))
			)
		    )
		    (setq R (sprintf nil "((((%s-%s)*%s)/(%s*(%s-%s)))+)"
				     rl deltaL sheetResistance rm rw deltaW
				     contactRes))
		   )
	       )
	      )
	     )
	     (when (numberp R)
		 (CDFhspiceFloatToString R)
	     )
	     R
	   )
	)
    )
)

;;; 
;;; CDFresRconModel --
;;;     This function returns the rcon model name for the resistor currently
;;;    being edited in the cdf editor.
;;; Input: 
;;; Output: 
;;; Globals: cdfgData
;;; Side Effects: 
;;; Return: string rcon model name
;;; 
(defun CDFresRconModel ()
    (let (instmod hspmod rconmod resdevice cdf_this)
	(setq cdf_this (car (TECHresolveLayer cdfgData->resistorType->value)))
	(cond
	    ((equal "diff" cdfgData->resistorType->value)
	     (setq resdevice
		   (TECHgetDevice ?name (or (and cdfgData->isPtype->value "rdp")
					    "rdn")))
	     (setq rconmod (TECHgetDeviceParam resdevice 'contactModel))
	    )
	    ((equal "User" cdfgData->resistorType->value)
	     (setq rconmod cdfgData->userRconModel->value)
	    )
	    (t
	     (setq instmod
		   (case cdfgData->resistorType->value
		       ("poly" cdfgData->rpmod->value)
		       ("li1"  cdfgData->limod->value)
                       ("nwell" cdfgData->nwellmod->value)
		       ("ddli" cdfgData->ddlimod->value)
		       ("lm1"  cdfgData->lm1mod->value)
		       ("litr" cdfgData->litrmod->value)
		       ("met1" cdfgData->met1mod->value)
		       ("met2" cdfgData->met2mod->value)
		       ("met3" cdfgData->met3mod->value)
		       ("met4" cdfgData->met4mod->value)
		       ("met5" cdfgData->met5mod->value)
		       ("met6" cdfgData->met6mod->value)
		       ("met7" cdfgData->met7mod->value)
		       ("met8" cdfgData->met8mod->value)
		       ("metd" cdfgData->metdmod->value)
		       ("rdl"  cdfgData->rdlmod->value )
		   )
	     )
	     (when (exists x (TECHgetLayerProp cdf_this 'aliases)
			   ((strncmp x "cdf_" 4) == 0))
		 (setq instmod
		       (case (car (exists x (TECHgetLayerProp cdf_this 'aliases)
					  ((strncmp x "cdf_" 4) == 0)))
		 	   ("cdf_poly1" cdfgData->rpmod->value)
                           ("cdf_nwell" cdfgData->nwellmod->value)
			   ("cdf_li1"   cdfgData->limod->value)
			   ("cdf_ddli"  cdfgData->ddlimod->value)
			   ("cdf_lm1"  cdfgData->lm1mod->value)
			   ("cdf_litr"  cdfgData->litrmod->value)
			   ("cdf_met1" cdfgData->met1mod->value)
			   ("cdf_met2" cdfgData->met2mod->value)
			   ("cdf_met3" cdfgData->met3mod->value)
			   ("cdf_met4" cdfgData->met4mod->value)
			   ("cdf_met5" cdfgData->met5mod->value)
			   ("cdf_met6" cdfgData->met6mod->value)
			   ("cdf_met7" cdfgData->met7mod->value)
			   ("cdf_met8" cdfgData->met8mod->value)
			   ("cdf_metd" cdfgData->metdmod->value)
			   ("cdf_rdl"  cdfgData->rdlmod->value)
		       )
		 )
	     )
	     (foreach x (TECHgetResistorDevices)
		 (setq hspmod (TECHgetDeviceParam x 'hspiceModel))
		 (when (equal hspmod instmod)
		     (setq rconmod (TECHgetDeviceParam x 'contactModel))
		 )
	     )
	    )
	)
	rconmod
    )
)

;;; 
;;; CDFresEnableRcons --
;;;     This function returns nil if rcons are not currently enabled.
;;;     Otherwise it returns a non-nil value.
;;; Input: 
;;; Output: 
;;; Globals: cdfgData
;;; Side Effects: 
;;; Return: t or nil
;;; 
(defun CDFresEnableRcons ()
    (case cdfgData->resistorType->value
	("User"
	 (nequal "" cdfgData->userRconModel->value)
	)
	("Absolute" nil)
	(t
	 (null (null (CDFresRconModel)))
	)
    )
)

;;; 
;;; CDFresCallback --
;;;   This function is the CDF callback for when it needs to calculate
;;; the resistance for the resistor.  Depending upon if it is resistance
;;; driven or length driven, it will calculate and set either the "rl" or
;;; the "r" parameter.
;;;   It will also update the parasitics if the res has parasitics.
;;; 
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFresCallback (CDFdbid cdfgData)
  (let (
        resDevice
        isRdriven
        (r cdfgData->r->value)
        (rm (or cdfgData->rm->value 1))
        (rw cdfgData->rw->value)
        (rl cdfgData->rl->value)
;	  (rcon0m cdfgData->rcon0m->value)
;	  (rcon1m cdfgData->rcon1m->value)
        parasiticDevice
        parasiteModel
        nlSegNum
        tmprw tmprl tmprm
        cwtype cwval cltype clval
        cdf_well1 cdf_diff1 cdf_diff2 cdf_diff3 cdf_poly1
        cdf_li1 cdf_nwell cdf_ddli cdf_lm1 cdf_litr cdf_met1 cdf_met2)
    
    (setq cdf_well1 (car (TECHresolveLayer "cdf_well1")))
    (setq cdf_diff1 (car (TECHresolveLayer "cdf_diff1")))
    (setq cdf_diff2 (car (TECHresolveLayer "cdf_diff2")))
    (setq cdf_diff3 (car (TECHresolveLayer "cdf_diff3")))
    (setq cdf_poly1 (car (TECHresolveLayer "cdf_poly1")))
    (setq cdf_nwell (car (TECHresolveLayer "cdf_nwell")))
    (setq cdf_li1   (car (TECHresolveLayer "cdf_li1")))
    (setq cdf_ddli  (car (TECHresolveLayer "cdf_ddli"))) 
    (setq cdf_lm1   (car (TECHresolveLayer "cdf_lm1"))) 
    (setq cdf_litr  (car (TECHresolveLayer "cdf_litr")))        
    (setq cdf_met1  (car (TECHresolveLayer "cdf_met1")))
    (setq cdf_met2  (car (TECHresolveLayer "cdf_met2")))
    (setq cdf_this  (car (TECHresolveLayer cdfgData->resistorType->value)))
    
    (when cdfgData->nlSegNum
      (setq nlSegNum cdfgData->nlSegNum->value)
      )
    
    ;; try to work with numbers, not strings
    (when (stringp r)
      (cond ((aelIsNumberP r)
             (setq r (aelNumber r))
             )
            (t (setq r (strcat "(" r ")")))
	    )
      )
    (when (stringp rm)
      (cond ((aelIsNumberP rm)
             (setq rm (evalstring rm))
             )
            (t (setq rm (strcat "(" rm ")")))
	    )
      )
    (when (stringp rw)
      (cond ((aelIsNumberP rw)
             (setq rw (aelNumber rw))
             )
            (t (setq rw (strcat "(" rw ")")))
	    )
      )
    (when (stringp rl)
      (cond ((aelIsNumberP rl)
             (setq rl (aelNumber rl))
             )
            (t (setq rl (strcat "(" rl ")")))
	    )
      )
    ;; we may need these values as strings
    (when (numberp rl) (setq tmprl (sprintf nil "%g" rl)))
    (when (numberp rw) (setq tmprw (sprintf nil "%g" rw)))
    (when (numberp rm) (setq tmprm (sprintf nil "%d" rm)))
    
    (setq resDevice
          (CDFgetResTechrepDevice CDFdbid~>master~>cellName cdfgData))
    
    (when (member CDFdbid~>master~>cellName '("resn" "resp" "resnw"))
      (setq parasiticDevice 
            (TECHgetDevice ?name (TECHgetDeviceParam resDevice 'diode)))
      )
    
    (when (member CDFdbid~>master~>cellName '("rescap"))
      (setq parasiticDevice 
            (TECHgetDevice ?name
                           (concat (CDFgetCapTechrepDevice CDFdbid~>master~>cellName cdfgData))))
      (CDFsetCapSpaceProps CDFdbid parasiticDevice)
      )
    
    (when (member CDFdbid~>master~>cellName '("rescap" "res" "resn" "resp"))
      (CDFsetResSpaceProps CDFdbid resDevice)
      )
    
    (when parasiticDevice    
      (setq parasiteModel
            (or (TECHgetDeviceParam parasiticDevice 'hspiceModel) ""))
      )
    
    ;; Update the resistance or resistor length, depending upon whether
    ;; the resistor is resistance driven or length driven.
    ;;
    (when (nequal cdfgData->resistorType->value "Absolute")
      (dbDeletePropByName CDFdbid "isAbsoluteRes")
      (dbDeletePropByName CDFdbid "hide_rlwm")
      (setq isRdriven (equal cdfgData->lrDriven->value "R Driven"))
      (cond (isRdriven
             (setq rl (CDFcalculateRes isRdriven r rm rw rl resDevice cdfgData CDFdbid~>rcon0m CDFdbid~>rcon1m))
             (cond
              ((equal "string" cdfgData->rl->paramType)
               (unless (stringp rl)
                 (setq rl (sprintf nil "%g" rl))
                 )
               (dbReplaceProp CDFdbid "rl" "string" rl)
               cdfgData->rl->value = rl
               )
              ;; the old floating point case
              (t
               ;; it should not get a string for rl if the CDF
               ;; has not been updated to be a string
               (unless (numberp rl)
                 (warn "Resistor CDF type screwup\n")
                 )
               (dbReplaceProp CDFdbid "rl" "float" rl)
               cdfgData->rl->value = rl
               )
              )
             ;; now that we have an updated rl, make sure that the
             ;; tmprl does not override it with old data
             (setq tmprl nil)
             (when (and (stringp rl) (aelIsNumberP rl))
               (setq tmprl rl)
               (setq rl (aelNumber rl))
               )
             )
            (t ; is length driven
             (setq r (CDFcalculateRes isRdriven r rm rw rl resDevice cdfgData CDFdbid~>rcon0m CDFdbid~>rcon1m))
             (cond
              ((equal "string" cdfgData->r->paramType)
               (unless (stringp r)
                 (setq r (sprintf nil "%g" r))
                 )
               (dbReplaceProp CDFdbid "r" "string" r)
               cdfgData->r->value = r
               )
              (t
               (unless (numberp r)
                 (warn "Resistor CDF type screwup\n")
                 )
               (dbReplaceProp CDFdbid "r" "float" r)
               cdfgData->r->value = r
               )
              )
             )
	    )
      )
    
    ;; Diff resistors "resn" and "resp" have diode parasitics.
    ;; Nwell resistors "resnw" have diode parasitics also.
    ;; Calculate the diode parasitics
    (when (or (equal "resn" CDFdbid~>master~>cellName)
              (equal "resp" CDFdbid~>master~>cellName)
              (equal "resnw" CDFdbid~>master~>cellName))
      
      ;; resistor model
      (dbReplaceProp CDFdbid "model" "string"
                     (TECHgetDeviceParam resDevice 'hspiceModel))
      ;; diode area
      (cond
       ((and (numberp rl) (numberp rw) (numberp rm))
        (dbReplaceProp CDFdbid "area" "float" (rl / 2.0 * rw * rm))
        )
       (t
        (dbReplaceProp CDFdbid "area" "string"
                       (sprintf nil "(%s*%s*%s/2.0)"
                                (or tmprw rw)
                                (or tmprm rm)
                                (or tmprl rl)
				)
                       )
        )
       )
      ;; diode perimeter
      (cond
       ((and (numberp rl) (numberp rm))
        (dbReplaceProp CDFdbid "perim" "float" (times rl rm))
        )
       (t
        (dbReplaceProp CDFdbid "perim" "string"
                       (sprintf nil "(%s*%s)"
                                (or tmprl rl)
                                (or tmprm rm))
                       )
        )
       )
      ;; parasitic diode model
      (dbReplaceProp CDFdbid "parasiteModel" "string" parasiteModel)
      )
    
    (when (and (equal "res" CDFdbid~>master~>cellName)
               (exists x (TECHgetLayerProp cdf_this 'aliases)
                       ((strncmp x "cdf_well" 8) == 0)))
      (dbReplaceProp CDFdbid "model" "string"
                     (case (car (exists x (TECHgetLayerProp cdf_this 'aliases)
                                        ((strncmp x "cdf_well" 8) == 0)))
                       ("cdf_well1" cdfgData->well1mod->value)
                       ))
      )
    
    ;; diff resistor with no parasitic diodes
    (when (and (equal "res" CDFdbid~>master~>cellName)
               (equal "diff" cdfgData->resistorType->value))
      (dbReplaceProp CDFdbid "model" "string"
                     (TECHgetDeviceParam resDevice 'hspiceModel))
      )
    
    (when (and (equal "res" CDFdbid~>master~>cellName)
               (exists x (TECHgetLayerProp cdf_this 'aliases)
                       ((strncmp x "cdf_diff" 8) == 0)))
      (dbReplaceProp CDFdbid "model" "string"
                     (case (car (exists x (TECHgetLayerProp cdf_this 'aliases)
                                        ((strncmp x "cdf_diff" 8) == 0)))
                       ("cdf_diff1" cdfgData->diff1mod->value)
                       ("cdf_diff2" cdfgData->diff2mod->value)
                       ("cdf_diff3" cdfgData->diff3mod->value)
                       ))
      )
    (when (and (equal "resnw" CDFdbid~>master~>cellName)
               (exists x (TECHgetLayerProp cdf_this 'aliases)
                       ((strncmp x "cdf_nwell" 8) == 0)))
      (dbReplaceProp CDFdbid "model" "string"
                     (case (car (exists x (TECHgetLayerProp cdf_this 'aliases)
                                        ((strncmp x "cdf_nwell" 8) == 0)))
                       ("cdf_nwell" cdfgData->nwellmod->value)
                       ))
      )
    
    ;; if it is a rescap, calculate the common cw and cl properties
    (when (equal "rescap" CDFdbid~>master~>cellName)
      ;; first, the cl.  We do not multiply the mfactor by the length
      ;; because we only multiply it by the width
      (cond
       ((numberp rl)
        (setq cltype "float")
        (setq clval (quotient rl 2.0))
        )
       (t
        (setq cltype "string")
        (setq clval (sprintf nil "(%s/2.0)"
                             (or tmprl rl)
			     )
              )
        )
       )
      ;; second, the cw
      (cond
       ((and (numberp rm) (numberp rw))
        (setq cwtype "float")
        (setq cwval (times rm rw))
        )
       (t
        (setq cwtype "string")
        (setq cwval (sprintf nil "(%s*%s)"
                             (or tmprm rm)
                             (or tmprw rw)
			     )
              )
        )
       )
      )
    
    ;; If it is a poly resistor with capacitor parasitics
    (when (and (equal "rescap" CDFdbid~>master~>cellName)
               (member cdfgData->resistorType->value `("poly" ,cdf_poly1)))
      ;; cap segments
      (when cdfgData->nlSegNum
        (dbReplaceProp CDFdbid "cSegNum" "int" nlSegNum)   
        )
      ;; cap length
      (dbReplaceProp CDFdbid "cl" cltype clval)
      ;; cap width
      (dbReplaceProp CDFdbid "cw" cwtype cwval)
      ;; parasitic cap model
      (dbReplaceProp CDFdbid "parasiteModel" "string" parasiteModel)
      (dbReplaceProp CDFdbid "model" "string" cdfgData->rpmod->value)
      )
    ;; poly resistor with no parasitic caps
    (when (and (equal "res" CDFdbid~>master~>cellName)
               (member cdfgData->resistorType->value `("poly" ,cdf_poly1)))
      (dbReplaceProp CDFdbid "model" "string" cdfgData->rpmod->value)
      )
    ;; If it is a rpoly resistor with capacitor parasitics
    (when (and (equal "rescap" CDFdbid~>master~>cellName)
               (equal "rpoly" cdfgData->resistorType->value))
      ;; cap length
      (dbReplaceProp CDFdbid "cl" cltype clval)
      ;; cap width
      (dbReplaceProp CDFdbid "cw" cwtype cwval)
      ;; parasitic cap model
      (dbReplaceProp CDFdbid "parasiteModel" "string" parasiteModel)
      (dbReplaceProp CDFdbid "model" "string" cdfgData->rpolymod->value)
      )
    
    ;; rpoly resistor with no parasitic caps
    (when (and (equal "res" CDFdbid~>master~>cellName)
               (equal "rpoly" cdfgData->resistorType->value))
      (dbReplaceProp CDFdbid "model" "string" cdfgData->rpolymod->value)
      )
    ;; ad resistor with no parasitic caps
    (when (and (equal "res3" CDFdbid~>master~>cellName)
               (equal "ad" cdfgData->resistorType->value))
      (dbReplaceProp CDFdbid "model" "string" cdfgData->rpolymod->value)
      )
    
    ;; If it is a tfr resistor with capacitor parasitics
    (when (and (equal "rescap" CDFdbid~>master~>cellName)
               (equal "tfr" cdfgData->resistorType->value))
      ;; cap length
      (dbReplaceProp CDFdbid "cl" cltype clval)
      ;; cap width
      (dbReplaceProp CDFdbid "cw" cwtype cwval)
      ;; parasitic cap model
      (dbReplaceProp CDFdbid "parasiteModel" "string" parasiteModel)
      (dbReplaceProp CDFdbid "model" "string" cdfgData->tfrmod->value)
      )
    ;; tfr resistor with no parasitic caps
    (when (and (equal "res" CDFdbid~>master~>cellName)
               (equal "tfr" cdfgData->resistorType->value))
      (dbReplaceProp CDFdbid "model" "string" cdfgData->tfrmod->value)
      )
    
    ;; pwell resistor
    (when (equal "respw" CDFdbid~>master~>cellName)
      (dbReplaceProp CDFdbid "model" "string" cdfgData->pwellmod->value)
      ) 
    ;; If it is a li1 resistor with capacitor parasitics
    (when (and (equal "rescap" CDFdbid~>master~>cellName)
               (member cdfgData->resistorType->value `("li1" ,cdf_li1))) 
      ;; cap segments
      (when cdfgData->nlSegNum
        (dbReplaceProp CDFdbid "cSegNum" "int" nlSegNum)  
        )
      ;; cap length
      (dbReplaceProp CDFdbid "cl" cltype clval)
      ;; cap width
      (dbReplaceProp CDFdbid "cw" cwtype cwval)
      ;; parasitic cap model
      (dbReplaceProp CDFdbid "parasiteModel" "string" parasiteModel)
      (dbReplaceProp CDFdbid "model" "string" cdfgData->limod->value)
      )
    ;; li1 resistor with no parasitic caps
    (when (and (equal "res" CDFdbid~>master~>cellName)
               (member cdfgData->resistorType->value `("li1" ,cdf_li1)))
      (dbReplaceProp CDFdbid "model" "string" cdfgData->limod->value)
      )
    
    ;; If it is a nwell resistor with capactor parasitics
    (when (and (equal "rescap" CDFdbid~>master~>cellName)
               (member cdfgData->resistorType->value `("nwell" ,cdf_nwell))) 
      ;; cap segments
      (when cdfgData->nlSegNum
        (dbReplaceProp CDFdbid "cSegNum" "int" nlSegNum)  
        )
      ;; cap length
      (dbReplaceProp CDFdbid "cl" cltype clval)
      ;; cap width
      (dbReplaceProp CDFdbid "cw" cwtype cwval)
      ;; parasitic cap model
      (dbReplaceProp CDFdbid "parasiteModel" "string" parasiteModel)
      (dbReplaceProp CDFdbid "model" "string" cdfgData->nwellmod->value)
      )
    ;; nwell resistor with no parasitic caps
    (when (and (equal "res" CDFdbid~>master~>cellName)
               (member cdfgData->resistorType->value `("nwell" ,cdf_nwell)))
      (dbReplaceProp CDFdbid "model" "string" cdfgData->nwellmod->value)
      )
    
    ;; If it is a ddli resistor with capacitor parasitics
    (when (and (equal "rescap" CDFdbid~>master~>cellName)
               (member cdfgData->resistorType->value `("ddli" ,cdf_ddli))) 
      ;; cap segments
      (when cdfgData->nlSegNum
        (dbReplaceProp CDFdbid "cSegNum" "int" nlSegNum)  
        )
      ;; cap length
      (dbReplaceProp CDFdbid "cl" cltype clval)
      ;; cap width
      (dbReplaceProp CDFdbid "cw" cwtype cwval)
      ;; parasitic cap model
      (dbReplaceProp CDFdbid "parasiteModel" "string" parasiteModel)
      (dbReplaceProp CDFdbid "model" "string" cdfgData->ddlimod->value)
      )
    ;; ddli resistor with no parasitic caps
    (when (and (equal "res" CDFdbid~>master~>cellName)
               (member cdfgData->resistorType->value `("ddli" ,cdf_ddli)))
      (dbReplaceProp CDFdbid "model" "string" cdfgData->ddlimod->value)
      )
    
    ;; If it is a lm1 resistor with capacitor parasitics
    (when (and (equal "rescap" CDFdbid~>master~>cellName)
               (member cdfgData->resistorType->value `("lm1" ,cdf_lm1))) 
      ;; cap segments
      (when cdfgData->nlSegNum
        (dbReplaceProp CDFdbid "cSegNum" "int" nlSegNum)  
        )
      ;; cap length
      (dbReplaceProp CDFdbid "cl" cltype clval)
      ;; cap width
      (dbReplaceProp CDFdbid "cw" cwtype cwval)
      ;; parasitic cap model
      (dbReplaceProp CDFdbid "parasiteModel" "string" parasiteModel)
      (dbReplaceProp CDFdbid "model" "string" cdfgData->lm1mod->value)
      )
    ;; lm1 resistor with no parasitic caps
    (when (and (equal "res" CDFdbid~>master~>cellName)
               (member cdfgData->resistorType->value `("lm1" ,cdf_lm1)))
      (dbReplaceProp CDFdbid "model" "string" cdfgData->lm1mod->value)
      )
    
    ;; If it is a litr resistor with capacitor parasitics
    (when (and (equal "rescap" CDFdbid~>master~>cellName)
               (member cdfgData->resistorType->value `("litr" ,cdf_litr))) 
      ;; cap segments
      (when cdfgData->nlSegNum
        (dbReplaceProp CDFdbid "cSegNum" "int" nlSegNum)  
        )
      ;; cap length
      (dbReplaceProp CDFdbid "cl" cltype clval)
      ;; cap width
      (dbReplaceProp CDFdbid "cw" cwtype cwval)
      ;; parasitic cap model
      (dbReplaceProp CDFdbid "parasiteModel" "string" parasiteModel)
      (dbReplaceProp CDFdbid "model" "string" cdfgData->litrmod->value)
      )
    ;; litr resistor with no parasitic caps
    (when (and (equal "res" CDFdbid~>master~>cellName)
               (member cdfgData->resistorType->value `("litr" ,cdf_litr)))
      (dbReplaceProp CDFdbid "model" "string" cdfgData->litrmod->value)
      )
    
    ;; If it is a metal resistor with capacitor parasitics
    (when (and (equal "rescap" CDFdbid~>master~>cellName)
               (equal 0 (strncmp "met" cdfgData->resistorType->value 3)))
      ;; cap segments
      (when cdfgData->nlSegNum
        (dbReplaceProp CDFdbid "cSegNum" "int" nlSegNum)
        )
      ;; cap length
      (dbReplaceProp CDFdbid "cl" cltype clval)
      ;; cap width
      (dbReplaceProp CDFdbid "cw" cwtype cwval)
      ;; parasitic cap model
      (dbReplaceProp CDFdbid "parasiteModel" "string" parasiteModel)
      (dbReplaceProp CDFdbid "model" "string"
                     (case cdfgData->resistorType->value
                       ("met1" cdfgData->met1mod->value)
                       ("met2" cdfgData->met2mod->value)
                       ("met3" cdfgData->met3mod->value)
                       ("met4" cdfgData->met4mod->value)
                       ("met5" cdfgData->met5mod->value)
                       ("met6" cdfgData->met6mod->value)
                       ("met7" cdfgData->met7mod->value)
                       ("met8" cdfgData->met8mod->value)
                       ("metd" cdfgData->metdmod->value)
                       )
                     )
      )
    
    ;; If it is a metal resistor with capacitor parasitics
    (when (and (equal "rescap" CDFdbid~>master~>cellName)
               (equal 0 (strncmp "m" cdfgData->resistorType->value 1))
               (exists x (TECHgetLayerProp cdf_this 'aliases)
                       ((strncmp x "cdf_met" 7) == 0)))
      ;; cap segments
      (when cdfgData->nlSegNum
        (dbReplaceProp CDFdbid "cSegNum" "int" nlSegNum)
        )
      ;; cap length
      (dbReplaceProp CDFdbid "cl" cltype clval)
      ;; cap width
      (dbReplaceProp CDFdbid "cw" cwtype cwval)
      ;; parasitic cap model
      (dbReplaceProp CDFdbid "parasiteModel" "string" parasiteModel)
      (dbReplaceProp CDFdbid "model" "string"
                     (case (car (exists x (TECHgetLayerProp cdf_this 'aliases)
                                        ((strncmp x "cdf_met" 7) == 0)))
                       ("cdf_met1" cdfgData->met1mod->value)
                       ("cdf_met2" cdfgData->met2mod->value)
                       ("cdf_met3" cdfgData->met3mod->value)
                       ("cdf_met4" cdfgData->met4mod->value)
                       ("cdf_met5" cdfgData->met5mod->value)
                       ("cdf_met6" cdfgData->met6mod->value)
                       ("cdf_met7" cdfgData->met7mod->value)
                       ("cdf_met8" cdfgData->met8mod->value)
                       ("cdf_metd" cdfgData->metdmod->value)
                       )
                     )
      )
    
    ;; metal resistor with no parasitic caps
    (when (and (equal "res" CDFdbid~>master~>cellName)
               (equal 0 (strncmp "met" cdfgData->resistorType->value 3)))
      (dbReplaceProp CDFdbid "model" "string"
                     (case cdfgData->resistorType->value
                       ("met1" cdfgData->met1mod->value)
                       ("met2" cdfgData->met2mod->value)
                       ("met3" cdfgData->met3mod->value)
                       ("met4" cdfgData->met4mod->value)
                       ("met5" cdfgData->met5mod->value)
                       ("met6" cdfgData->met6mod->value)
                       ("met7" cdfgData->met7mod->value)
                       ("met8" cdfgData->met8mod->value)
                       ("metd" cdfgData->metdmod->value)
                       )
                     )
      )
    
    ;; metal resistor with no parasitic caps
    (when (and (equal "res" CDFdbid~>master~>cellName)
               (equal 0 (strncmp "m" cdfgData->resistorType->value 1))
               (exists x (TECHgetLayerProp cdf_this 'aliases)
                       ((strncmp x "cdf_met" 7) == 0)))
      (dbReplaceProp CDFdbid "model" "string"
                     (case (car (exists x (TECHgetLayerProp cdf_this 'aliases)
                                        ((strncmp x "cdf_met" 7) == 0)))
                       ("cdf_met1" cdfgData->met1mod->value)
                       ("cdf_met2" cdfgData->met2mod->value)
                       ("cdf_met3" cdfgData->met3mod->value)
                       ("cdf_met4" cdfgData->met4mod->value)
                       ("cdf_met5" cdfgData->met5mod->value)
                       ("cdf_met6" cdfgData->met6mod->value)
                       ("cdf_met7" cdfgData->met7mod->value)
                       ("cdf_met8" cdfgData->met8mod->value)
                       ("cdf_metd" cdfgData->metdmod->value)
                       (t (warn "Unidentified metal layer"))
                       )
                     )
      )
    
    ;; If it is a rdl resistor with capacitor parasitics
    (when (and (equal "rescap" CDFdbid~>master~>cellName)
               (equal "rdl" cdfgData->resistorType->value))
      ;; cap segments
      (when cdfgData->nlSegNum
        (dbReplaceProp CDFdbid "cSegNum" "int" nlSegNum)
        )
      ;; cap length
      (dbReplaceProp CDFdbid "cl" cltype clval)
      ;; cap width
      (dbReplaceProp CDFdbid "cw" cwtype cwval)
      ;; parasitic cap model
      (dbReplaceProp CDFdbid "parasiteModel" "string" parasiteModel)
      (dbReplaceProp CDFdbid "model" "string"  cdfgData->rdlmod->value)
      )
    
    ;; rdl resistor with no parasitic caps
    (when (and (equal "res" CDFdbid~>master~>cellName)
               (equal "rdl" cdfgData->resistorType->value)
               )
      (dbReplaceProp CDFdbid "model" "string" cdfgData->rdlmod->value)
      )
    
    ;; If it is a user defined resistor with capacitor parasitics
    (when (and (equal "rescap" CDFdbid~>master~>cellName)
               (equal "User" cdfgData->resistorType->value))
      ;; cap segments
      (when cdfgData->nlSegNum
        (dbReplaceProp CDFdbid "cSegNum" "int" nlSegNum)
        )
      ;; cap length
      (dbReplaceProp CDFdbid "cl" cltype clval)
      ;; cap width
      (dbReplaceProp CDFdbid "cw" cwtype cwval)
      ;; parasitic cap model
      (dbReplaceProp CDFdbid "parasiteModel" "string" cdfgData->userRcapModel->value)
      (dbReplaceProp CDFdbid "model" "string" cdfgData->usermod->value)
      (dbReplaceProp CDFdbid "rconUserValue" "string" cdfgData->userRconModel->value)
      )
    ;; user defined resistor with no parasitic caps
    (when (and (equal "res" CDFdbid~>master~>cellName)
               (equal "User" cdfgData->resistorType->value))
      (dbReplaceProp CDFdbid "model" "string" cdfgData->usermod->value)
      )
    
    (when (equal "Absolute" cdfgData->resistorType->value)
      (dbDeletePropByName CDFdbid "rconUserValue")
      (dbDeletePropByName CDFdbid "rl")
      (dbDeletePropByName CDFdbid "rw")
      (dbDeletePropByName CDFdbid "isPtype")
      (dbDeletePropByName CDFdbid "perim")
      (dbDeletePropByName CDFdbid "parasiteModel")
      (if (and cdfgData->usermod->value
               (stringp cdfgData->usermod->value)
               (rexMatchp "[A-Za-z0-9]" cdfgData->usermod->value)
               ) then
        (dbReplaceProp CDFdbid "model" "string" cdfgData->usermod->value)
        else
	(dbReplaceProp CDFdbid "model" "string" "res_abs")
	)
      (dbReplaceProp CDFdbid "isAbsoluteRes" "boolean" t)
      (dbReplaceProp CDFdbid "hide_rlwm" "boolean" t)
      )
    (cond ((and (CDFresEnableRcons)
                (or CDFdbid~>rcon0m CDFdbid~>rcon1m)
                )
           CDFdbid~>rconModel=(CDFresRconModel)
           )
          ;; Get rid of the rcon properties when they aren't needed
          (t
           (dbDeletePropByName CDFdbid "rcon0m")
           (dbDeletePropByName CDFdbid "rcon1m")
           (dbDeletePropByName CDFdbid "userRconModel")
           (dbDeletePropByName CDFdbid "rconModel")
           )
          )
    
    (when (and (equal CDFdbid~>cellView~>viewName "schematic")
               CDFdbid~>isParasitic
               (nequal "FALSE" CDFdbid~>isParasitic)
               )
      (dbDeletePropByName CDFdbid "isParasitic")
      (warn (sprintf nil "CDFresCallback:  isParasitic property is illegal inside 'schematic'.  Deleting property.\n"))
      )
    
    ;; after it may have adjusted the cw and cl properties, adjust the
    ;; cw1 and cw2 properties for those caps that use width value lookup
    ;; tables in the spice simulator.
    (when (member CDFdbid~>master~>cellName '("rescap"))
      (CDFsetCapWidthProps CDFdbid parasiticDevice)
      )
    (when (member CDFdbid~>master~>cellName '("rescap" "res" "resn" "resp"))
      ;; some resistors have formulas - if so, we set rw1 and rw2
      (CDFsetResWidthProps CDFdbid resDevice)
      )
    )
  )


;;; 
;;; CDFgres3Callback --
;;;   This function is the CDF callback for when it needs to calculate
;;; the resistance for the resistor.  Depending upon if it is resistance
;;; driven or length driven, series/parallel it will calculate and set 
;;; either the "rl" or the "r" parameter.
;;; 
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 

(defun CDFgres3Callback ()
  (let (
	(res cdfgData->res->value)  
	(seriesSegment cdfgData->seriesSegment->value)  
	(parallelSegment cdfgData->parallelSegment->value)
	(contRes cdfgData->contRes->value) 
	(rl cdfgData->rl->value) 
	(rw cdfgData->rw->value) 
	(sheetR cdfgData->sheetR->value) 
	(deltaW cdfgData->deltaW->value) resGrid edgeCap areaCap )
    
    (setq dev ,(TECHgetDevice ?name stringToSymbol(lowerCase(cdfgData->rtype->value)))) 
    (setq resGrid ,(TECHgetLayerProp "rpoly" 'snapGrid))
    ;; (setq sheetR ,(TECHgetDeviceParam dev 'sheet))
    (setq edgeCap ,(TECHgetRule "rpoly_nsub_cp"))
    (setq areaCap ,(TECHgetRule "rpoly_nsub_ca"))
    (unless deltaW (setq deltaW 0.0))
    
    (if cdfgData->ser_par->value == "Series" then
	cdfgData->invseriesSegment->value = (quotient 1.0  cdfgData->seriesSegment->value) 
	cdfgData->parallelSegment->value = 1
	else
	cdfgData->seriesSegment->value = 1
	cdfgData->invseriesSegment->value = (quotient 1.0  cdfgData->seriesSegment->value) 
	)
    
    (if cdfgData->res_len_dr->value == "Resistance" then
	
	;; rl = (R*rm - headRes)*(rw - deltaW)/sheetResistance 
        (setq rle (quotient (times (difference (times (quotient res seriesSegment) parallelSegment)  
					       contRes) (difference rw deltaW)) sheetR))
	(setq rle (times (round (quotient rle resGrid)) resGrid))
        cdfgData->rl->value = rle
        (setq Res (quotient (times (plus (quotient (times rle sheetR) (difference rw deltaW)) contRes) seriesSegment) parallelSegment))
	
        cdfgData->cres->value = Res 
        cdfgData->segRes->value = (quotient (times Res parallelSegment) seriesSegment)
        cdfgData->TcontRes->value = quotient( times(contRes seriesSegment) parallelSegment)
        cdfgData->area_cap->value = (times areaCap (difference rw deltaW) rle parallelSegment seriesSegment)
        cdfgData->edge_cap->value = (times edgeCap rle parallelSegment seriesSegment)
        cdfgData->total_cap->value = (plus (times 2 cdfgData->edge_cap->value) cdfgData->area_cap->value)
	else
	;; R = (headRes/rm)+(rl*sheetR)/(( rw - deltaW)*rm)
        ;; Res = (((rl*sheetR)/(rw - deltaW) + contRes)*seriesSegment)/parallelSegment
        (setq Res (quotient (times (plus (quotient (times rl sheetR) (difference rw deltaW)) contRes) seriesSegment) parallelSegment))
	cdfgData->cres->value = Res 
	cdfgData->res->value = Res
	cdfgData->segRes->value = (quotient (times Res parallelSegment) seriesSegment)
	cdfgData->TcontRes->value = (quotient (times contRes seriesSegment) parallelSegment)
	cdfgData->area_cap->value = (times areaCap (difference rw deltaW) rl parallelSegment seriesSegment)
	cdfgData->edge_cap->value = (times edgeCap rl parallelSegment seriesSegment)
	cdfgData->total_cap->value = (plus (times 2 cdfgData->edge_cap->value) cdfgData->area_cap->value)
	)
    )
  )


;;; 
;;; CDFres3Callback --
;;;   This function is the CDF callback for when it needs to calculate
;;; the resistance for the resistor.  Depending upon if it is resistance
;;; driven or length driven, it will calculate and set either the "rl" or
;;; the "r" parameter.
;;;   It will also update the parasitics if the res has parasitics.
;;; 
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFres3Callback (CDFdbid cdfgData)
    (let (res3Device
	  isRdriven
	  (r cdfgData->r->value)
	  (rm (or cdfgData->rm->value 1))
	  (rw cdfgData->rw->value)
	  (rl cdfgData->rl->value)
	  nlSegNum
	  tmprw tmprl tmprm
	  cwtype cwval cltype clval
	 )
      
        (when cdfgData->nlSegNum
	    (setq nlSegNum cdfgData->nlSegNum->value)
        )
	
	;; try to work with numbers, not strings
	(when (stringp r)
	    (cond ((aelIsNumberP r)
		   (setq r (aelNumber r))
		  )
		(t (setq r (strcat "(" r ")")))
	    )
	)
	(when (stringp rm)
	    (cond ((aelIsNumberP rm)
		   (setq rm (evalstring rm))
		  )
		(t (setq rm (strcat "(" rm ")")))
	    )
	)
	(when (stringp rw)
	    (cond ((aelIsNumberP rw)
		   (setq rw (aelNumber rw))
		  )
		(t (setq rw (strcat "(" rw ")")))
	    )
	)
	(when (stringp rl)
	    (cond ((aelIsNumberP rl)
		   (setq rl (aelNumber rl))
		  )
		(t (setq rl (strcat "(" rl ")")))
	    )
	)
	;; we may need these values as strings
	(when (numberp rl) (setq tmprl (sprintf nil "%g" rl)))
	(when (numberp rw) (setq tmprw (sprintf nil "%g" rw)))
	(when (numberp rm) (setq tmprm (sprintf nil "%d" rm)))
	
	
	(setq res3Device
	      (CDFgetRes3TechrepDevice CDFdbid~>master~>cellName cdfgData))
	
	
	
	;; Update the resistance or resistor length, depending upon whether
	;; the resistor is resistance driven or length driven.
	;;

	    (setq isRdriven (equal cdfgData->lrDriven->value "R Driven"))
	    (cond (isRdriven
		   (setq rl (CDFcalculateRes isRdriven r rm rw rl res3Device cdfgData CDFdbid~>rcon0m CDFdbid~>rcon1m))
		   (cond
		       ((equal "string" cdfgData->rl->paramType)
			(unless (stringp rl)
			    (setq rl (sprintf nil "%g" rl))
			)
			(dbReplaceProp CDFdbid "rl" "string" rl)
			cdfgData->rl->value = rl
		       )
		       ;; the old floating point case
		       (t
			;; it should not get a string for rl if the CDF
			;; has not been updated to be a string
			(unless (numberp rl)
			    (warn "Resistor CDF type screwup\n")
			)
			(dbReplaceProp CDFdbid "rl" "float" rl)
			cdfgData->rl->value = rl
		       )
		   )
		   ;; now that we have an updated rl, make sure that the
		   ;; tmprl does not override it with old data
		   (setq tmprl nil)
		   (when (and (stringp rl) (aelIsNumberP rl))
		       (setq tmprl rl)
		       (setq rl (aelNumber rl))
		   )
		  )
		(t ; is length driven
		 (setq r (CDFcalculateRes isRdriven r rm rw rl res3Device cdfgData CDFdbid~>rcon0m CDFdbid~>rcon1m))
		 (cond
		     ((equal "string" cdfgData->r->paramType)
		      (unless (stringp r)
			  (setq r (sprintf nil "%g" r))
		      )
		      (dbReplaceProp CDFdbid "r" "string" r)
		      cdfgData->r->value = r
		     )
		     (t
		      (unless (numberp r)
			  (warn "Resistor CDF type screwup\n")
		      )
		      (dbReplaceProp CDFdbid "r" "float" r)
		      cdfgData->r->value = r
		     )
		 )
		)
	    )


	
	;; rpoly resistor with no parasitic caps
	(when (and (equal "res3" CDFdbid~>master~>cellName)
		   (equal "diff" cdfgData->resistorType->value))
	    (dbReplaceProp CDFdbid "model" "string" cdfgData->diffmod->value)
	)
        (when (and (equal "res3" CDFdbid~>master~>cellName)
		   (equal "poly" cdfgData->resistorType->value))
	    (dbReplaceProp CDFdbid "model" "string" cdfgData->polymod->value)
	)
	(when (and (equal "res3" CDFdbid~>master~>cellName)
		   (equal "rpoly" cdfgData->resistorType->value))
	    (dbReplaceProp CDFdbid "model" "string" cdfgData->rpolymod->value)
	)
	(when (and (equal "res3" CDFdbid~>master~>cellName)
		   (equal "ad" cdfgData->resistorType->value))
	    (dbReplaceProp CDFdbid "model" "string" cdfgData->admod->value)
	)
	(when (and (equal "res3" CDFdbid~>master~>cellName)
		   (equal "nd" cdfgData->resistorType->value))
	    (dbReplaceProp CDFdbid "model" "string" cdfgData->ndmod->value)
	)
	(when (and (equal "res3" CDFdbid~>master~>cellName)
		   (equal "pd" cdfgData->resistorType->value))
	    (dbReplaceProp CDFdbid "model" "string" cdfgData->pdmod->value)
	)
	(when (and (equal "res3" CDFdbid~>master~>cellName)
		   (equal "wn" cdfgData->resistorType->value))
	    (dbReplaceProp CDFdbid "model" "string" cdfgData->nwmod->value)
	)
	(when (and (equal "res3" CDFdbid~>master~>cellName)
		   (equal "tfr" cdfgData->resistorType->value))
	    (dbReplaceProp CDFdbid "model" "string" cdfgData->tfrmod->value)
	)

  
  	(cond ((and (CDFresEnableRcons)
		    (or CDFdbid~>rcon0m CDFdbid~>rcon1m)
	       )
	       CDFdbid~>rconModel=(CDFresRconModel)
	      )
	    ;; Get rid of the rcon properties when they aren't needed
	    (t
	     (dbDeletePropByName CDFdbid "rcon0m")
	     (dbDeletePropByName CDFdbid "rcon1m")
	     (dbDeletePropByName CDFdbid "userRconModel")
	     (dbDeletePropByName CDFdbid "rconModel")
	    )
	)
	
	(when (and (equal CDFdbid~>cellView~>viewName "schematic")
		   CDFdbid~>isParasitic
		   (nequal "FALSE" CDFdbid~>isParasitic)
	      )
	    (dbDeletePropByName CDFdbid "isParasitic")
	    (warn (sprintf nil "CDFres3Callback:  isParasitic property is illegal inside 'schematic'.  Deleting property.\n"))
	)
    )
)






;;; 
;;; CDFsetCapSpaceProps --
;;;   Some of our capacitor models have different values for the coefficients
;;; of the capacitor equation based on the space to the neighbor.  This
;;; function will look at the techrep device for a capacitor and get the
;;; values of "space" for which we have discrete datapoints.
;;;   It will then create or delete the properties "capSpace1" and "capSpace2".
;;; If neither get defined, this cap model does not support space values.
;;; If only capSpace1 is defined, it is the datapoint closest to this value.
;;; If both capSpace1 and capSpace2 are defined, this capacitor falls somewhere
;;; between the values for these two discrete datapoints.
;;;
;;; Input: CDFdbid - dbid of the instance to create/delete props on
;;;        capDevice - techrep device for this capacitor
;;; Output: 
;;; Globals: 
;;; Side Effects: creates/deletes "capSpace1" and "capSpace2" values
;;; Return: t
;;; 
(defun CDFsetCapSpaceProps (CDFdbid capDevice "dl")
    (let
	(spaceVals
	 prevSpace
	 thisSpace
	 targetSpace
	 thisLayer
	)

	(setq spaceVals (TECHgetDeviceParam capDevice 'spacings))
	(setq thisLayer (TECHgetDeviceParam capDevice 'layers))
	(cond
	    ;; if it is a triple layer cap, the main layer is the middle one
	    ((equal 3 (length thisLayer))
	     (setq thisLayer (cadr thisLayer))
	    )
	    ;; if it is a two layer cap, the main layer is the first one
	    ((equal 2 (length thisLayer))
	     (setq thisLayer (car thisLayer))
	    )
	)
	(setq targetSpace
	      (or CDFdbid~>space (TECHgetRuleWith "minSpacing" thisLayer) 0.0))
	(when (and (stringp targetSpace) (aelIsNumberP targetSpace))
	    (setq targetSpace (aelNumber targetSpace))
	)

	(cond
	    ;; if this cap does not support multiple values for different
	    ;; spaces, delete the properties that store the spaces
	    ((null spaceVals)
	     (dbDeletePropByName CDFdbid "capSpace1")
	     (dbDeletePropByName CDFdbid "capSpace2")
	    )
	    ;; we do support various spaces for this cap model
	    (t
	     ;; the spaceVals parameter should be sorted in increasing order.
	     (setq thisSpace (car spaceVals))
	     (setq spaceVals (cdr spaceVals))
	     (while (and spaceVals
			 (greaterp targetSpace
				   (plus thisSpace 1e-5)))
		 (setq prevSpace thisSpace)
		 (setq thisSpace (car spaceVals))
		 (setq spaceVals (cdr spaceVals))
	     )

	     (cond
		 ;; 1. if this is > the last space value in the list, or
		 ;; 2. if this is <= the first space value in the list, or
		 ;; 3. if this is close enough to the current value in the list
		 ;; use last space value it saw
		 ((or (greaterp targetSpace thisSpace)
		      (null prevSpace)
		      (null (greaterp (abs (difference targetSpace thisSpace))
				      1e-5)))
		  (dbReplaceProp CDFdbid "capSpace1" "float" thisSpace)
		  (dbDeletePropByName CDFdbid "capSpace2")
		 )
		 ;; if this is between two spacing values
		 (t
		  (dbReplaceProp CDFdbid "capSpace1" "float" thisSpace)
		  (dbReplaceProp CDFdbid "capSpace2" "float" prevSpace)
		  ;; with two space values, it will use an equation and it is
		  ;; required to have the "space" property
		  (unless CDFdbid~>space
		      (dbReplaceProp CDFdbid "space" "float" targetSpace)
		  )
		 )
	     )
	    )
	)
    )

    ;; be happy?
    t
)

;;; 
;;; CDFsetCapWidthProps --
;;;   Very similar to CDFsetCapSpaceProps, but it works on the cap width.
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFsetCapWidthProps (CDFdbid capDevice "dl")
    (let
	(thisLayer
	 widthVals
	 prevWidth
	 thisWidth
	 targetWidth
	)

	(setq widthVals (TECHgetDeviceParam capDevice 'widths))
	(setq thisLayer (TECHgetDeviceParam capDevice 'layers))
	(cond
	    ;; if it is a triple layer cap, the main layer is the middle one
	    ((equal 3 (length thisLayer))
	     (setq thisLayer (cadr thisLayer))
	    )
	    ;; if it is a two layer cap, the main layer is the first one
	    ((equal 2 (length thisLayer))
	     (setq thisLayer (car thisLayer))
	    )
	)

	;; unfortunately, they may have tried to optimize the width.  If they
	;; did, the cw property is not a number, but a parameterized equation.
	;; Just default to the more inaccurate min width if they tried that.
	;; It will interpolate from the evaluated width in the spice sim.
	;;
	(setq targetWidth (or CDFdbid~>rw CDFdbid~>cw))
	(when (and (stringp targetWidth) (aelIsNumberP targetWidth))
	    (setq targetWidth (aelNumber targetWidth))
	)
	(when (or (null targetWidth) (stringp targetWidth))
	    (setq targetWidth (or (TECHgetRuleWith "minWidth" thisLayer) 0.0))
	)

	(cond
	    ;; if this cap does not support multiple values for different
	    ;; widths, delete the properties that store the widths
	    ((null widthVals)
	     (dbDeletePropByName CDFdbid "cw1")
	     (dbDeletePropByName CDFdbid "cw2")
	    )
	    ;; we do support various widths for this cap model
	    (t
	     ;; the widthVals parameter should be sorted in increasing order.
	     (setq thisWidth (car widthVals))
	     (setq widthVals (cdr widthVals))
	     (while (and widthVals
			 (greaterp targetWidth
				   (plus thisWidth 1e-5)))
		 (setq prevWidth thisWidth)
		 (setq thisWidth (car widthVals))
		 (setq widthVals (cdr widthVals))
	     )

	     (cond
		 ;; 1. if this is > the last width value in the list, or
		 ;; 2. if this is <= the first width value in the list, or
		 ;; 3. if this is close enough to the current value in the list
		 ;; use last width value it saw
		 ((or (greaterp targetWidth thisWidth)
		      (null prevWidth)
		      (null (greaterp (abs (difference targetWidth thisWidth))
				      1e-5)))
		  (dbReplaceProp CDFdbid "cw1" "float" thisWidth)
		  (dbDeletePropByName CDFdbid "cw2")
		 )
		 ;; if this is between two spacing values
		 (t
		  (dbReplaceProp CDFdbid "cw1" "float" thisWidth)
		  (dbReplaceProp CDFdbid "cw2" "float" prevWidth)
		  ;; with two width values, it will use an equation and it is
		  ;; required to have the "width" property
		  (unless CDFdbid~>cw
		      (dbReplaceProp CDFdbid "cw" "float" targetWidth)
		  )
		 )
	     )
	    )
	)
    )

    ;; be happy?
    t
)

;;; 
;;; CDFsetResSpaceProps --
;;;   Some of our resistor models have different values for the coefficients
;;; of the resistor equation based on the space to the neighbor.  This
;;; function will look at the techrep device for a resistor and get the
;;; values of "space" for which we have discrete datapoints.
;;;   It will then create or delete the properties "resSpace1" and "resSpace2".
;;; If neither get defined, this res model does not support space values.
;;; If only resSpace1 is defined, it is the datapoint closest to this value.
;;; If both resSpace1 and resSpace2 are defined, this resistor falls somewhere
;;; between the values for these two discrete datapoints.
;;;
;;; Input: CDFdbid - dbid of the instance to create/delete props on
;;;        resDevice - techrep device for this resistor
;;; Output: 
;;; Globals: 
;;; Side Effects: creates/deletes "resSpace1" and "resSpace2" values
;;; Return: t
;;; 
(defun CDFsetResSpaceProps (CDFdbid resDevice "dl")
    (let
	(spaceVals
	 prevSpace
	 thisSpace
	 targetSpace
	 thisLayer
	)

	(setq spaceVals (TECHgetDeviceParam resDevice 'spacings))
	(setq thisLayer (TECHgetDeviceParam resDevice 'layer))
        
	(setq targetSpace
	      (or CDFdbid~>space (TECHgetRuleWith "minSpacing" thisLayer) 0.0))
	(when (and (stringp targetSpace) (aelIsNumberP targetSpace))
	    (setq targetSpace (aelNumber targetSpace))
	)

	(cond
	    ;; if this res does not support multiple values for different
	    ;; spaces, delete the properties that store the spaces
	    ((null spaceVals)
	     (dbDeletePropByName CDFdbid "resSpace1")
	     (dbDeletePropByName CDFdbid "resSpace2")
	    )
	    ;; we do support various spaces for this res model
	    (t
	     ;; the spaceVals parameter should be sorted in increasing order.
	     (setq thisSpace (car spaceVals))
	     (setq spaceVals (cdr spaceVals))
	     (while (and spaceVals
			 (greaterp targetSpace
				   (plus thisSpace 1e-5)))
		 (setq prevSpace thisSpace)
		 (setq thisSpace (car spaceVals))
		 (setq spaceVals (cdr spaceVals))
	     )

	     (cond
		 ;; 1. if this is > the last space value in the list, or
		 ;; 2. if this is <= the first space value in the list, or
		 ;; 3. if this is close enough to the current value in the list
		 ;; use last space value it saw
		 ((or (greaterp targetSpace thisSpace)
		      (null prevSpace)
		      (null (greaterp (abs (difference targetSpace thisSpace))
				      1e-5)))
		  (dbReplaceProp CDFdbid "resSpace1" "float" thisSpace)
		  (dbDeletePropByName CDFdbid "resSpace2")
		 )
		 ;; if this is between two spacing values
		 (t
		  (dbReplaceProp CDFdbid "resSpace1" "float" thisSpace)
		  (dbReplaceProp CDFdbid "resSpace2" "float" prevSpace)
		  ;; with two space values, it will use an equation and it is
		  ;; required to have the "space" property
		  (unless CDFdbid~>space
		      (dbReplaceProp CDFdbid "space" "float" targetSpace)
		  )
		 )
	     )
	    )
	)
    )

    ;; be happy?
    t
)

;;; 
;;; CDFsetResWidthProps --
;;;   Very similar to CDFsetResSpaceProps, but it works on the res width.
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFsetResWidthProps (CDFdbid resDevice "dl")
    (let
	(thisLayer
	 widthVals
	 prevWidth
	 thisWidth
	 targetWidth
	)

	(setq widthVals (TECHgetDeviceParam resDevice 'widths))
	(setq thisLayer (TECHgetDeviceParam resDevice 'layer))
        
	;; unfortunately, they may have tried to optimize the width.  If they
	;; did, the cw property is not a number, but a parameterized equation.
	;; Just default to the more inaccurate min width if they tried that.
	;; It will interpolate from the evaluated width in the spice sim.
	;;
	(setq targetWidth CDFdbid~>rw)
	(when (and (stringp targetWidth) (aelIsNumberP targetWidth))
	    (setq targetWidth (aelNumber targetWidth))
	)
	(when (or (null targetWidth) (stringp targetWidth))
	    (setq targetWidth (or (TECHgetRuleWith "minWidth" thisLayer) 0.0))
	)
        
	(cond
	    ;; if this res does not support multiple values for different
	    ;; widths, delete the properties that store the widths
	    ((null widthVals)
	     (dbDeletePropByName CDFdbid "rw1")
	     (dbDeletePropByName CDFdbid "rw2")
	    )
	    ;; we do support various widths for this res model
	    (t
	     ;; the widthVals parameter should be sorted in increasing order.
	     (setq thisWidth (car widthVals))
	     (setq widthVals (cdr widthVals))
	     (while (and widthVals
			 (greaterp targetWidth
				   (plus thisWidth 1e-5)))
		 (setq prevWidth thisWidth)
		 (setq thisWidth (car widthVals))
		 (setq widthVals (cdr widthVals))
	     )

	     (cond
		 ;; 1. if this is > the last width value in the list, or
		 ;; 2. if this is <= the first width value in the list, or
		 ;; 3. if this is close enough to the current value in the list
		 ;; use last width value it saw
		 ((or (greaterp targetWidth thisWidth)
		      (null prevWidth)
		      (null (greaterp (abs (difference targetWidth thisWidth))
				      1e-5)))
		  (dbReplaceProp CDFdbid "rw1" "float" thisWidth)
		  (dbDeletePropByName CDFdbid "rw2")
		 )
		 ;; if this is between two spacing values
		 (t
		  (dbReplaceProp CDFdbid "rw1" "float" thisWidth)
		  (dbReplaceProp CDFdbid "rw2" "float" prevWidth)
		 )
	     )
	    )
	)
    )

    ;; be happy?
    t
)

(defun CDFcapCallback (CDFdbid cdfgData "do")

    (cond
	;; if it is an absolute cap, make sure the isSubckt is blown away
	((and CDFdbid~>isAbsoluteCap (nequal "FALSE" CDFdbid~>isAbsoluteCap))
	 (dbDeletePropByName CDFdbid "isSubckt")
	 (dbDeletePropByName CDFdbid "capSpace1")
	 (dbDeletePropByName CDFdbid "capSpace2")
	)
	;; if it is not an absolute cap, get the cap spacing and isSubckt
	;; properties squared away
	(t

	 (let (capDevices thisCap)
	     (setq capDevices (TECHgetCapDevices))
	     (setq thisCap (car capDevices))

	     ;; loop through all the caps looking for the one with this model
	     (while (and thisCap
			 (nequal CDFdbid~>ctype
				 (TECHgetDeviceParam thisCap 'hspiceModel))
		    )

		 (setq thisCap (car capDevices))
		 (setq capDevices (cdr capDevices))
	     )

	     (cond
		 (thisCap
		  ;; set the "space" properties if applicable
		  (CDFsetCapSpaceProps CDFdbid thisCap)
		  (CDFsetCapWidthProps CDFdbid thisCap)

		  ;; see if this is a subckt cap model, and create or delete
		  ;; the isSubckt property accordingly
		  (cond
		      ((TECHgetDeviceParam thisCap 'isSubckt)
		       (dbReplaceProp CDFdbid "isSubckt" "boolean" t)
		      )
		      (t
		       (dbDeletePropByName CDFdbid "isSubckt")
		      )
		  )

		 )
		 (t
		  (dbDeletePropByName CDFdbid "capSpace1")
		  (dbDeletePropByName CDFdbid "capSpace2")
		  (dbDeletePropByName CDFdbid "isSubckt")
		 )

		 )
	     
	 )
	)
    )
)

;;; 
;;; CDFthinoxCapCallback --
;;;   This function is for the thinoxide capacitor devices (ncap2/pcap2).
;;; It will calculate the w & l based on the area and perimeter.
;;; 
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFthinoxCapCallback (CDFdbid cdfgData "do")

    ;; call the CDFcapCallback callback
    (CDFcapCallback CDFdbid cdfgData)

    ;; Derive missing parameters.  When deriving w/l from a/p, we solve
    ;; quadratic if possible, assigning larger dimension to length.  If
    ;; no solution, we make up something the same way extraction does.
    (cond
	((cdfgData->apMode->value == "Width & Length")
	 (let (wval lval)
	     (setq wval cdfgData->cw->value)
	     (setq lval cdfgData->cl->value)
	     (cond
		 ((and (aelIsNumberP wval) (aelIsNumberP lval))
		  (setq wval (aelNumber wval))
		  (setq lval (aelNumber lval))

		  (dbReplaceProp CDFdbid "a" "float" (times wval lval))
		  (dbReplaceProp CDFdbid "p" "float"
				 (times 2 (plus wval lval))
		  )
		 )
		 (t
		  (cond
		      ((numberp wval) (setq wval (sprintf nil "%g" wval)))
		      ((null (aelIsNumberP wval) (setq wval (strcat "(" wval ")"))))
		      (t t)
		  )
		  (cond
		      ((numberp lval) (setq lval (sprintf nil "%g" lval)))
		      ((null (aelIsNumberP lval) (setq lval (strcat "(" lval ")"))))
		      (t t)
		  )
		  (dbReplaceProp CDFdbid "a" "string"
				 (sprintf nil "(%s*%s)" wval lval))
		  (dbReplaceProp CDFdbid "p" "string"
				 (sprintf nil "((2*%s)+(2*%s))" wval lval))
		 )
	     )
	 )
	)
	(t
	 (let ((a cdfgData->a->value)
	       (p cdfgData->p->value)
	       (w 0.0)
	       (l 0.0)
	       det)
	     (when (and (stringp a) (aelIsNumberP a))
		 (setq a (aelNumber a))
	     )
	     (when (and (stringp p) (aelIsNumberP p))
		 (setq p (aelNumber p))
	     )
	     (cond
		 ;; if they are both numbers, do what we always have done
		 ((and (numberp a) (numberp p))
		  det = p ** 2.0 - 16.0 * a
		  (cond
		      ((and (det >= 0) ((setq det (sqrt det)) < p)) ; quadratic has real solutions
		       w = (p - det) / 4.0
		       l = (p + det) / 4.0)
		      ((p > 0) ; bogus derivation, matches extraction algorthim
		       l = p / 6.0
		       w = a / l))
		  (dbReplaceProp CDFdbid "cw" "float" w)
		  (dbReplaceProp CDFdbid "cl" "float" l)
		 )
		 ;; if one or both of a/p are params, do it as an equation
		 (t
		  ;; make sure a and p are strings
		  (when (numberp a)
		      (setq a (sprintf nil "%g" a))
		  )
		  (when (numberp p)
		      (setq p (sprintf nil "%g" p))
		  )
		  ;; taking a sqrt of what may be a negative number, but
		  ;; let the users shoot themselves in the foot
		  (setq det (sprintf nil "sqrt((%s*%s)-(16.0*%s))" p p a))
		  (setq w (sprintf nil "((%s-%s)/4.0)" p det))
		  (setq l (sprintf nil "((%s+%s)/4.0)" p det))
		  (dbReplaceProp CDFdbid "cw" "string" w)
		  (dbReplaceProp CDFdbid "cl" "string" l)
		 )
	     )
	 )
	)
    )
)

;;; 
;;; CDFshowNameKludge --
;;; 
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFshowNameKludge (cdfDbid showName "dg")
    (cond (showName
	   (dbReplaceProp cdfDbid "showName" "boolean" t)
	  )
	(t
	 (dbDeletePropByName cdfDbid "showName")
	)
    )
)

;;; 
;;; CDFsetAllResModelInfo --
;;;   This function is called when the restype/model has changed for
;;; a resistor without parasitics.  It will update the model description
;;; field with the correct description of the resistor chosen.
;;;   It will also check if the model has a constant width.  It will
;;; make the "rw" field editable/noneditable accordingly.
;;; 
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFsetAllResModelInfo (resCellName cdfgData "to")
    (let (resDevice res3Device resModelDescription tmpW constantW)

	;; get the tech rep resistor device
	(setq resDevice (CDFgetResTechrepDevice resCellName cdfgData))
	(setq res3Device (CDFgetRes3TechrepDevice resCellName cdfgData))
	
	(cond
	    (resDevice
	     (setq resModelDescription
		   (or (TECHgetDeviceParam resDevice 'description)
		       "No description available"))
	     (setq constantW (TECHgetDeviceParam resDevice 'constantWidth))
	    )
 
	    (res3Device
	     (setq resModelDescription
		   (or (TECHgetDeviceParam res3Device 'description)
		       "No description available"))
	     (setq constantW  (TECHgetDeviceParam res3Device 'constantWidth))
	    )
	    
	    ((equal "Absolute" cdfgData->resistorType->value)
	     (setq resModelDescription "Absolute resistor")
	    )
	    (t
	     (setq resModelDescription "Error: cannot find resistor")
	    )
	)

	;; set the resistor model description into the cdf form
	cdfgData->resistorModelInfo->value = resModelDescription

	;; If the resistor selected is a constant width resistor,
	;; set the rw and make the field default to only one value.
	(when  constantW 
	    (when (aelIsNumberP cdfgData->rw->value)
		(setq tmpW (aelNumber cdfgData->rw->value))
	    )
	    (when (nequal tmpW constantW)
;		(warn "Value of the constant width resistor can not be changed\n")
		;; rw field is a string now that we have AEL expressions,
		;; but still support it if it is a float field
		(cond
		    ((equal "float" cdfgData->rw->paramType)
		     cdfgData->rw->value = (aelNumber constantW)
		    )
		    ((equal "string" cdfgData->rw->paramType)
		     cdfgData->rw->value = (sprintf nil "%g" (aelNumber constantW))
		    )
		)
	    )
	)
	(cond
	 ((TECHgetDeviceParam resDevice 'isSubckt)
	  cdfgData->isSubckt->value = t
	  )

	 ((TECHgetDeviceParam res3Device 'isSubckt)
	  cdfgData->isSubckt->value = t
	 )
	 
	 (t
	  cdfgData->isSubckt->value = nil
	  )
	 )
    )
)

(defun CDFsetResModelInfo (cdfgData "o")
    (CDFsetAllResModelInfo "res" cdfgData)
)
(defun CDFsetRescapModelInfo (cdfgData "o")
    (CDFsetAllResModelInfo "rescap" cdfgData)
)
(defun CDFsetResnModelInfo (cdfgData "o")
    (CDFsetAllResModelInfo "resn" cdfgData)
)
(defun CDFsetResnwModelInfo (cdfgData "o")
    (CDFsetAllResModelInfo "resnw" cdfgData)
)
(defun CDFsetRespModelInfo (cdfgData "o")
    (CDFsetAllResModelInfo "resp" cdfgData)
)
(defun CDFsetRespwModelInfo (cdfgData "o")
    (CDFsetAllResModelInfo "respw" cdfgData)
)
(defun CDFsetReslocsubModelInfo (cdfgData "o")
    (CDFsetAllResModelInfo "reslocsub" cdfgData)
)
(defun CDFsetRes3ModelInfo (cdfgData "o")
    (CDFsetAllResModelInfo "res3" cdfgData)
)
;; Hardcoding sheetR, deltaW & contactRes to mimic b53d-3GR process
;; Eventually will be removed when the templates are in place

(defun CDFsetGres3ModelInfo ()
  let((dev)
      case( cdfgData->rtype->value
	    ("RA1"  
	     dev = (TECHgetDevice ?name stringToSymbol(lowerCase(cdfgData->rtype->value)))
	     cdfgData->rw->value = (TECHgetDeviceParam dev 'constantWidth)
	     ;;cdfgData->contRes->value = (TECHgetDeviceParam dev 'headRes) 
	     cdfgData->rpolymod->value = (TECHgetDeviceParam dev 'hspiceModel)
	     ;;cdfgData->deltaW->value = (TECHgetDeviceParam dev 'deltaW)
	     cdfgData->contRes->value = 120.0 
	     cdfgData->deltaW->value = 0.4518 
	     cdfgData->sheetR->value =  270.0 
	     cdfgData->isSubckt->value = (TECHgetDeviceParam dev 'isSubckt)
	     cdfgData->contactNames->value = "RAconRPL1 RAconL1M1"
	     )
	    
	    ("RA2"  
	     dev = (TECHgetDevice ?name stringToSymbol(lowerCase(cdfgData->rtype->value)))
             cdfgData->rw->value = (TECHgetDeviceParam dev 'constantWidth)
	     ;;cdfgData->contRes->value = (TECHgetDeviceParam dev 'headRes) 
	     cdfgData->rpolymod->value = (TECHgetDeviceParam dev 'hspiceModel)
	     ;;cdfgData->deltaW->value = (TECHgetDeviceParam dev 'deltaW)
	     cdfgData->isSubckt->value = (TECHgetDeviceParam dev 'isSubckt)
	     cdfgData->contRes->value = 60.0 
	     cdfgData->deltaW->value = 0.8358 
	     cdfgData->sheetR->value =  270.0 
	     cdfgData->contactNames->value = "RAconRPL1 RAconL1M1"
	     )
	    ("RD1"  
	     dev = (TECHgetDevice ?name stringToSymbol(lowerCase(cdfgData->rtype->value)))
             cdfgData->rw->value = (TECHgetDeviceParam dev 'constantWidth)
	     ;;cdfgData->contRes->value = (TECHgetDeviceParam dev 'headRes) 
	     cdfgData->rpolymod->value = (TECHgetDeviceParam dev 'hspiceModel)
	     ;;cdfgData->deltaW->value = (TECHgetDeviceParam dev 'deltaW)
	     cdfgData->isSubckt->value = (TECHgetDeviceParam dev 'isSubckt)
	     cdfgData->contactNames->value = "RDconRPL1 RDconL1M1"
	     cdfgData->contRes->value = 200.0 
	     cdfgData->deltaW->value = 0.25 
	     cdfgData->sheetR->value =  270.0 
	     )
	    )
      CDFgres3Callback()
      )
  )

(defun CDFsetRconModelInfo (cdfgData "o")
    (let (rconModel doping tmpParse layerDown layerUp)
	(setq rconModel
	      (car
	       (remq nil
		     (mapcar
		      (lambda (x)
			  (setq tmpParse (parseString (or cdfgData->resistorType->value "") " -"))
			  (when (equal 2 (length tmpParse))
			      (setq layerDown (car tmpParse))
			      (setq layerUp (cadr tmpParse))

			      (when (and (equal layerDown
						(TECHgetDeviceParam x 'layerDown))
					 (equal layerUp
						(TECHgetDeviceParam x 'layerUp)))
				  (cond
				      ((equal layerDown "diff")
				       (setq doping 
					     (TECHgetDeviceParam x 'doping))
				       (when (or (and (equal doping "n")
						      (or (null cdfgData->isPtype->value)
							  (equal cdfgData->isPtype->value "FALSE")))
						 (and (equal doping "p")
						      (and cdfgData->isPtype->value
							   (nequal "FALSE" cdfgData->isPtype->value)))
					     )
					   (TECHgetDeviceParam x 'hspiceModel)
				       )
				      )
				      (t (TECHgetDeviceParam x 'hspiceModel))
				  )
			      ) ; closing when layers match
			  ) ; closing when parse returned two layers
		      ) ;closing lambda
		      (TECHgetRconDevices)
		     )
	       )
	      )
	)
	cdfgData->model->value = rconModel
    )
)

;;; 
;;; CDFrconCallback --
;;;   This function is the callback for the rcon device.  If it is in a simsch,
;;; everything is ok.  If it is in a schematic, have a cow, because it will
;;; never lvs.
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFrconCallback (CDFdbid)

    (when (or (null CDFdbid~>isParasitic)
	      (equal "FALSE" CDFdbid~>isParasitic)
	  )
	(dbReplaceProp CDFdbid "isParasitic" "boolean" "TRUE")
	(warn (sprintf nil "CDFrconCallback:  isParasitic must be set for a rcon.  Resetting property.\n"))
    )

    (when (and (equal CDFdbid~>cellView~>viewName "schematic")
	       CDFdbid~>isParasitic
	       (nequal "FALSE" CDFdbid~>isParasitic)
	  )
	(dbDeleteObject CDFdbid)
	(warn (sprintf nil "CDFrconCallback:  rcon instances are illegal inside 'schematic'.  Deleting instance.\n"))
    )
)

;;; 
;;; CDFadjustHspiceToAel --
;;;   This is an ugly kludgy transition function between the ol Hspice days
;;; and the newer CDF AEL expression days.  It will look at old string values
;;; that probably represented numbers.  Because Hspice is an antique case
;;; insensitive program, it could not distinguish between the unit suffixes
;;; of "m" or "M".  Therefore, it treated either "m" or "M" as milli-units,
;;; and "Meg" (and permutations) as mega-units.
;;;   We had let the users manually type in these values, but now as we
;;; move some of the CDF fields to do the AEL parseAsNumber and parseAsCel
;;; dance, we have to correctly distinguish between "m" and "M".  This is
;;; a hassle for preexisting instances.  This should be called as a part of
;;; the CDF init procedures to automagically update the CDF fields to have
;;; the new syntax, and to store a property that will tell the Hspice
;;; netlister that it should replace the "M" with "Meg".
;;;   In order to prevent the update happening repeatedly for the same
;;; instance, it will remember if it has already adjusted this instance
;;; with the "updatedForAel" property.
;;;
;;; Input: cdfId and the symbols of properties to be examined/updated
;;; Output: 
;;; Globals: 
;;; Side Effects: nothing if "updatedForAel" is already set
;;; Return: 
;;; 
(defun CDFadjustHspiceToAel (cdfId theProps)
    (let
	(propVal doneit value tmpStr tmpNum)

	(setq doneit cdfgData->updatedForAel->value)
	(when (equal "FALSE" doneit) (setq doneit nil))
	(unless doneit
	    (unless (listp theProps)
		(setq theProps (list theProps))
	    )
	    (foreach prop theProps
		(setq propVal (get (get cdfgData prop) 'value))
		(when (stringp propVal)

		    ;; update the old "M" suffix to be "m"
		    (when (aelIsNumberP propVal)
			(when (setq tmpStr (index propVal "M"))
			    (setq propVal (strcat (substring propVal 1 (difference (strlen propVal) (strlen tmpStr))) "m" (or (substring tmpStr 2) "")))
			    (get cdfgData prop)->value = propVal
			)
		    )

		    ;; update the old "meg" suffix to be "M"
		    (foreach meg '("meg" "Meg" "mEg" "meG" "MEg" "MeG" "mEG" "MEG")
			(when (setq tmpStr (index propVal meg))
			    (setq propVal (strcat (substring propVal 1 (difference (strlen propVal) (strlen tmpStr))) "M" (or (substring tmpStr 4) "")))
			    (get cdfgData prop)->value = propVal
			)
		    )

		    ;; update the old mils suffix to be a number
		    (foreach mi '("mi" "Mi" "mI" "MI")
			(when (setq tmpStr (index propVal mi))
			    (setq tmpNum (atof (substring propVal 1 (difference (strlen propVal) (strlen tmpStr)))))
			    (when tmpNum
				(setq tmpNum (times 25.4e-6 tmpNum))
				(setq propVal (sprintf nil "%g" tmpNum))
				(get cdfgData prop)->value = propVal
			    )
			)
		    )

		)
	    )
	    cdfgData->updatedForAel->value = t
	)
    )
)

(defun CDFcap2Init (cdfId "o")
    (CDFadjustHspiceToAel cdfId 'c)
    (CDFcommonInit cdfId)
)

(defun CDFcap_int3Init (cdfId "o")
    (CDFadjustHspiceToAel cdfId 'c)
    (CDFcommonInit cdfId)
)

(defun CDFvppcapInit (cdfId "o")
    (CDFadjustHspiceToAel cdfId 'c)
    (CDFcommonInit cdfId)
)


(defun CDFsoiInit (cdfId "o")
    (CDFadjustHspiceToAel cdfId '(DCValue ACMag ACPhase))
    (CDFcommonInit cdfId)
)

(defun CDFsovInit (cdfId "o")
    (CDFadjustHspiceToAel cdfId '(DCValue ACMag ACPhase))
    (CDFcommonInit cdfId)
)

(defun CDFtransLineInit (cdfId "o")
    (CDFadjustHspiceToAel cdfId '(TD L Z0))
    (CDFcommonInit cdfId)
)

(defun CDFinductorInit (cdfId "o")
    (CDFadjustHspiceToAel cdfId '(l k ic))
    ;; we're obsoleting initial current as a separate type, and allowing
    ;; ic to be set for all the basic inductors.  If it was ic, set it
    ;; to type "Normal"
    (when (equal "Initial Current" cdfgForm~>objId~>indType)
	cdfgData->indType->value = "Normal"
    )
    (CDFcommonInit cdfId)
)

(defun CDFresInit (cdfId "o")
    (CDFsetResModelInfo cdfId)
    (CDFadjustHspiceToAel cdfId 'r)
    (CDFverInit cdfId)
    (CDFcommonInit cdfId)
)

(defun CDFrconInit (cdfId "o")
    (CDFsetRconModelInfo cdfId)
    (CDFverInit cdfId)
    (CDFcommonInit cdfId)
)

(defun CDFrescapInit (cdfId "o")
    (CDFsetRescapModelInfo cdfId)
    (CDFverInit cdfId)
    (CDFcommonInit cdfId)
)

(defun CDFresnwInit (cdfId "o")
    (CDFsetResnwModelInfo cdfId)
    (CDFverInit cdfId)
    (CDFcommonInit cdfId)
)

(defun CDFresnInit (cdfId "o")
    (CDFsetResnModelInfo cdfId)
    (CDFverInit cdfId)
    (CDFcommonInit cdfId)
)

(defun CDFrespInit (cdfId "o")
    (CDFsetRespModelInfo cdfId)
    (CDFverInit cdfId)
    (CDFcommonInit cdfId)
)

(defun CDFrespwInit (cdfId "o")
    (CDFsetRespwModelInfo cdfId)
    (CDFverInit cdfId)
    (CDFcommonInit cdfId)
)
(defun CDFreslocsubInit (cdfId "o")
    (CDFsetReslocsubModelInfo cdfId)
    (CDFverInit cdfId)
    (CDFcommonInit cdfId)
)

(defun CDFres3Init (cdfId "o")
    (CDFsetRes3ModelInfo cdfId)
    (CDFverInit cdfId)
    (CDFcommonInit cdfId)
)

(defun CDFgres3Init (cdfId "o")
    (CDFsetGres3ModelInfo)
    ;;(CDFverInit cdfId)
    (CDFcommonInit cdfId)
)

(defun CDFresDone (CDFdbid "d")
    (CDFresCallback CDFdbid cdfgData)
    (CDFverilogTrTfDoneCheck CDFdbid)
    (CDFcommonDone CDFdbid)
)


(defun CDFres3Done (CDFdbid "d")
    (CDFres3Callback CDFdbid cdfgData)
    (CDFverilogTrTfDoneCheck CDFdbid)
    (CDFcommonDone CDFdbid)
)

(defun CDFgres3Done (CDFdbid "d")
    nil
    ;;(CDFres3Callback CDFdbid cdfgData) ;; Removed since has field callback
    ;;(CDFverilogTrTfDoneCheck CDFdbid)
    ;;(CDFcommonDone CDFdbid)            ;; Removed since does not have preShowName field
)
(defun CDFrconDone (CDFdbid "d")
    (CDFverilogTrTfDoneCheck CDFdbid)
    (CDFcommonDone CDFdbid)
    (CDFrconCallback CDFdbid)
)

;;; 
;;; CDFdiodeModelChange --
;;;     When the model changes, update other fields on the form
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFdiodeModelChange ()
    (let ((device (TECHgetDevice ?cellName "diode" ?name
				 (concat cdfgData->model->value)
		  )
	  )
	 )
	cdfgData->isPtype->value = (equal "p" (TECHgetDeviceParam device 'doping))
    )
)

;;; 
;;; CDFcondiodeModelChange --
;;;     When the model changes, update other fields on the form
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFcondiodeModelChange ()
    (let ((device (TECHgetDevice ?cellName "diode" ?name
				 (concat cdfgData->simmodel->value)
		  )
	  )
	 )
	cdfgData->isPtype->value = (equal "p" (TECHgetDeviceParam device 'doping))
    )
)

;;; 
;;; CDFdiodeCallback --
;;;    The diode has cases where the device name and the hspice model name
;;;    are not equal.  When this happens, an hspiceModel property is created.
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFdiodeCallback (CDFdbid "d")
    (let ((device (TECHgetDevice ?cellName "diode" ?name
				 (concat cdfgData->model->value)
		  )
	  )
	  isSubckt
	 )
	(cond
	    ((equal (strcat (TECHgetDeviceParam device 'name))
		    (TECHgetDeviceParam device 'hspiceModel)
	     )
	     ;; Remove any hspice specific model property
	     (dbDeletePropByName CDFdbid "hspiceModel")
	    )
	    (t
	     CDFdbid~>hspiceModel=(TECHgetDeviceParam device 'hspiceModel)
	    )
	)
	;; create or delete the isSubckt property
	(setq isSubckt (TECHgetDeviceParam device 'isSubckt))
	(cond
	    (isSubckt
	     (dbReplaceProp CDFdbid "isSubckt" "boolean" "TRUE")
	    )
	    (t (dbDeletePropByName CDFdbid "isSubckt"))
	)
    )    
)

;;; 
;;; CDFconDiodeCallback --
;;;    The diode has cases where the device name and the hspice model name
;;;    are not equal.  When this happens, an hspiceModel property is created.
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFconDiodeCallback (CDFdbid "d")
    (let ((device (TECHgetDevice ?cellName "diode" ?name
				 (concat cdfgData->simmodel->value)
		  )
	  )
	  isSubckt
	 )
	(cond
	    ((equal (strcat (TECHgetDeviceParam device 'name))
		    (TECHgetDeviceParam device 'hspiceModel)
	     )
	     ;; Remove any hspice specific model property
	     (dbDeletePropByName CDFdbid "hspiceModel")
	    )
	    (t
	     CDFdbid~>hspiceModel=(TECHgetDeviceParam device 'hspiceModel)
	    )
	)
	;; create or delete the isSubckt property
	(setq isSubckt (TECHgetDeviceParam device 'isSubckt))
	(cond
	    (isSubckt
	     (dbReplaceProp CDFdbid "isSubckt" "boolean" "TRUE")
	    )
	    (t (dbDeletePropByName CDFdbid "isSubckt"))
	)
    )    
)

(defun CDFdiodeDone (CDFdbid "d")
    (CDFdiodeCallback CDFdbid)
    (CDFcommonDone CDFdbid)
)
(defun CDFcondiodeDone (CDFdbid "d")
    (CDFconDiodeCallback CDFdbid)
    (CDFcommonDone CDFdbid)
)
(defun CDFthinoxCapDone (CDFdbid "d")
    (CDFthinoxCapCallback CDFdbid cdfgData)
    (CDFcommonDone CDFdbid)
)

(defun CDFcapDone (CDFdbid "d")
    (CDFcapCallback CDFdbid cdfgData)
    (CDFcommonDone CDFdbid)
)

(defun CDFfetDone (CDFdbid "d")
    (CDFfetCallback CDFdbid)
    (CDFverilogTrTfDoneCheck CDFdbid)
    (CDFcommonDone CDFdbid)
)

(defun CDFfetextdDone (CDFdbid "d")
    (CDFfetextdCallback CDFdbid)
    (CDFverilogTrTfDoneCheck CDFdbid)
    (CDFcommonDone CDFdbid)
)

(defun CDFlogicDone (CDFdbid "d")
    (CDFlogicCallback CDFdbid)
    (cond
	((null (member CDFdbid~>cellName '("csw_p" "bkeep_p" "einv_p")))
	 (CDFverilogTrTfDoneCheck CDFdbid)
	)
	((member CDFdbid~>cellName '("einv_p"))
	 (CDFverilogTrTfDoneCheckBehavioral CDFdbid)
	)
    )
    (CDFcommonDone CDFdbid)
)

(defun CDFcswDone (CDFdbid "d")
    (CDFlogicCallback CDFdbid)
    (CDFcommonDone CDFdbid)
)

(defun CDFbcdiodeDone (CDFdbid "d")
    (CDFbcdiodeCallback CDFdbid)
    (CDFcommonDone CDFdbid)
)

;;; 
;;; CDFmNormTranDone --
;;;    This callback is applied to the CDFs for the mNormTranClass
;;; device library elements.  It sets the contact fields based off
;;; the descriptive names given in the CDFs.
;;;
(defun CDFmNormTranDone (cdfDbId)
    (let ((techFileId (techGetTechFile cdfDbId~>master~>lib)))
	(dbReplaceProp cdfDbId "firstContact" "string"
		       (DLgetSDcontactWithDescription techFileId
				  cdfgData->firstContactParam->value))
	(dbReplaceProp cdfDbId "lastContact" "string"
		       (DLgetSDcontactWithDescription techFileId
				  cdfgData->lastContactParam->value))
	(dbReplaceProp cdfDbId "sharedSource" "string"
		       (DLgetSDcontactWithDescription techFileId
				  cdfgData->shSrcParam->value))
	(dbReplaceProp cdfDbId "sharedDrain" "string"
		       (DLgetSDcontactWithDescription techFileId
				  cdfgData->shDrnParam->value))
	t
    )
)

;;; 
;;; CDFmNormTranInit --
;;;    This callback is applied to intialize the CDFs for the mNormTranClass
;;; device library elements when used in disctret modes.  
;;; It sets the model name, and W/L pull down menu based on the 
;;; idLayer, length and width values.
;;;
(defun CDFmNormTranInit (cdfgData)
  (let ((techFileId (techGetTechFile cdfgData~>id~>lib)) (cellName cdfgData~>id~>name)
	modelName modelChoices idLayerName Lparam Wparam lengthIndex
	lengthValue lengthChoices widthValue widthChoices)

    (setq idLayerName cdfgData~>idLayer->value)
    (setq modelChoices 
	  (parseString 
	   (techGetDeviceProp techFileId cellName "symbolic" 
			      (strcat idLayerName "Models")) " "))

    (foreach model modelChoices
	 ;;Construct the Lparam name
	 (setq Lparam (strcat (concat model "_l")))
	 (setq lengthChoices (get (get cdfgData Lparam) 'choices))

	 ;;Need to do this to grab the values with the decimal precision as stored 
	 (mapcar (lambda (x) (when (equal (atof x) cdfgData->l->value)
			       (setq lengthValue x)))
		 lengthChoices)
	 
	 (when (member lengthValue lengthChoices)
	   (setq lengthIndex (difference (length lengthChoices) (length (member lengthValue lengthChoices))))
	   ;;Construct the Wparam name
	   (setq Wparam (strcat (concat Lparam lengthIndex "_w")))
	   (setq widthChoices  (get (get cdfgData Wparam) 'choices))

	   (mapcar (lambda (x) (when (equal (atof x) cdfgData->w->value)
				 (setq widthValue x)))
		   widthChoices)

	   (when (member widthValue widthChoices)
	     (putprop (get cdfgData idLayerName) model  'value)
	     (putprop (get cdfgData Lparam) lengthValue 'value)
	     (putprop (get cdfgData Wparam) widthValue  'value)
	     )
	   )
     )
    t
    )
)

;;; 
;;; CDFmExtDrainTranDone --
;;;    This callback is applied to the CDFs for the mExtDrainTranClass
;;; device library elements.  It sets the contact fields based off
;;; the descriptive names given in the CDFs.
;;;
(defun CDFmExtDrainTranDone (cdfDbId)
    (let ((techFileId (techGetTechFile cdfDbId~>master~>lib)))
	(dbReplaceProp cdfDbId "contacts" "string" cdfgData->contactParam->value)
	t
    )
)

;;; 
;;; CDFvaractorDone --
;;;    This callback is applied to the CDFs for the varactorClass
;;; device library elements.  It sets the contact fields based off
;;; the descriptive names given in the CDFs.
;;;
(defun CDFvaractorDone (cdfDbId)
    (let ((techFileId (techGetTechFile cdfDbId~>master~>lib)))
	(dbReplaceProp cdfDbId "contacts" "string"
		       (DLgetSDcontactWithDescription techFileId
				  cdfgData->contactParam->value))
	(dbReplaceProp cdfDbId "gateContact" "string"
		       (DLgetSDcontactWithDescription techFileId
				  cdfgData->gateParam->value))
	t
    )
)

;;; 
;;; CDFdrainOnlyDone --
;;;    This callback is applied to the CDFs for the drainOnlyClass
;;; device library elements.  It sets the contact fields based off
;;; the descriptive names given in the CDFs.
;;; 
(defun CDFdrainOnlyDone (cdfDbId)
    (let ((techFileId (techGetTechFile cdfDbId~>master~>lib)))
	(dbReplaceProp cdfDbId "drainContact" "string"
		       (DLgetSDcontactWithDescription techFileId
				  cdfgData->drnContactParam->value))
	(dbReplaceProp cdfDbId "sourceContact" "string"
		       (DLgetSDcontactWithDescription techFileId
				  cdfgData->srcContactParam->value))
	t
    )
)

;;; 
;;; CDFind3Done --
;;;     This function
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFind3Done (CDFdbid "d")
    ;; create isSubckt property when the model calls for it
    (let ( thisInd3 ind3Devices )
      (setq ind3Devices (TECHgetInd3Devices CDFdbid~>cellName))
      (setq thisInd3 (car ind3Devices))
      ;; loop through all the ind3s looking for the one with this model
      (while (and thisInd3
		  (nequal CDFdbid~>modelName
			  (TECHgetDeviceParam thisInd3 'hspiceModel))
		  )
	(setq thisInd3 (car ind3Devices))
	(setq ind3Devices (cdr ind3Devices))
	)
      
      (cond
       ((TECHgetDeviceParam thisInd3 'isSubckt)
	(dbReplaceProp CDFdbid "isSubckt" "boolean" t)
	)
       (t
	(dbDeletePropByName CDFdbid "isSubckt")
	)
       )
    )

    (CDFcommonDone CDFdbid)
)

;;; 
;;; CDFind4Done --
;;;     This function
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFind4Done (CDFdbid "d")
    ;; create isSubckt property when the model calls for it
    (let ( thisInd4 ind4Devices )
      (setq ind4Devices (TECHgetInd4Devices CDFdbid~>cellName))
      (setq thisInd4 (car ind4Devices))
      ;; loop through all the ind4s looking for the one with this model
      (while (and thisInd4
		  (nequal CDFdbid~>modelName
			  (TECHgetDeviceParam thisInd4 'hspiceModel))
		  )
	(setq thisInd4 (car ind4Devices))
	(setq ind4Devices (cdr ind4Devices))
	)
      
      (cond
       ((TECHgetDeviceParam thisInd4 'isSubckt)
	(dbReplaceProp CDFdbid "isSubckt" "boolean" t)
	)
       (t
	(dbDeletePropByName CDFdbid "isSubckt")
	)
       )
    )

    (CDFcommonDone CDFdbid)
)

;;; 
;;; CDFcapbn_bDone --
;;;     This function
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFcapbn_bDone (cdfId )
  (foreach
   cap (TECHgetCapDevices "capbn_b")
   (when (equal cdfId->ctype
                (TECHgetDeviceParam cap 'hspiceModel)  )
     ;; see if this is a 3 term netlist, and create or delete
     ;; the threeTermNetlist property accordingly
     cdfId->threeTermNetlist = (TECHgetDeviceParam cap 'threeTermNetlist)
     cdfId->isSubckt         = (TECHgetDeviceParam cap 'isSubckt)
     )
   ) ;;end foreach
  (CDFcommonDone cdfId)
  )

;;; 
;;; CDFcapbn_bDone --
;;;     This function
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFcmim3cDone (cdfId )
  (foreach
   cap (TECHgetCapDevices "cmim3c")
   (when (equal cdfId->ctype (TECHgetDeviceParam cap 'hspiceModel))
     ;; see if this is a 3 term netlist, and create or delete
     ;; the threeTermNetlist property accordingly
     cdfId->threeTermNetlist = (TECHgetDeviceParam cap 'threeTermNetlist)
     cdfId->isSubckt         = (TECHgetDeviceParam cap 'isSubckt)
     ) ;; when
   ) ;;end foreach
  
  (CDFcommonDone cdfId)
  )

;;; 
;;; CDFnpn4Done --
;;;     This function places current monitoring properties on the npn and pnp
;;;    library elements.
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFnpn4Done (CDFdbid "d")
    (let ((oldMonitorTerms CDFdbid~>HSPmonitorTerms)
	  monitorTerms
	 )
	(foreach (propName termName) '("cvs" "bvs" "evs") '("c" "b" "e")
	    (when (get cdfgData propName)->value
		(setq monitorTerms (cons termName monitorTerms))
	    )
	)
	(cond ((and monitorTerms
		    (nequal monitorTerms oldMonitorTerms)
	       )
	       (dbReplaceProp CDFdbid "HSPmonitorTerms" "ILList"
			      monitorTerms
	       )
	      )
	    ((and oldMonitorTerms (null monitorTerms))
	     (dbDeletePropByName CDFdbid "HSPmonitorTerms")
	    )
	)
    )
    ;; create isSubckt property when the model calls for it
    (let ( thisBjt bjtDevices )
      (setq bjtDevices (TECHgetBjtDevices CDFdbid~>cellName))
      (setq thisBjt (car bjtDevices))
      ;; loop through all the bjts looking for the one with this model
      (while (and thisBjt
		  (nequal CDFdbid~>modelName
			  (TECHgetDeviceParam thisBjt 'hspiceModel))
		  )
	(setq thisBjt (car bjtDevices))
	(setq bjtDevices (cdr bjtDevices))
	)
      
      (cond
       ((TECHgetDeviceParam thisBjt 'isSubckt)
	(dbReplaceProp CDFdbid "isSubckt" "boolean" t)
	)
       (t
	(dbDeletePropByName CDFdbid "isSubckt")
	)
       )

    )
      
    ;; update pnp params based on model
    (foreach dev (TECHgetBjtDevices "pnp4")
	     
	(when (equal CDFdbid~>modelName (TECHgetDeviceParam dev 'hspiceModel))
	    
	  (cond
	   ((TECHgetDeviceParam dev 'baseArea)
	    (dbReplaceProp CDFdbid "bArea" "float" (TECHgetDeviceParam dev 'baseArea))
	    )
	   (t
	    (dbDeletePropByName CDFdbid "bArea")
	    )
	   )
	  (cond
	   ((TECHgetDeviceParam dev 'basePerim)
	    (dbReplaceProp CDFdbid "bPeri" "float" (TECHgetDeviceParam dev 'basePerim))
	    )
	   (t
	    (dbDeletePropByName CDFdbid "bPeri")
	    )
	   )
	  (cond 
	   ((TECHgetDeviceParam dev 'emitterArea)
	    (dbReplaceProp CDFdbid "eArea" "float" (TECHgetDeviceParam dev 'emitterArea))
	    )
	   (t
	    (dbDeletePropByName CDFdbid "eArea")
	    )
	   )
	  (cond
	   ((TECHgetDeviceParam dev 'emitterPerim)
	    (dbReplaceProp CDFdbid "ePeri" "float" (TECHgetDeviceParam dev 'emitterPerim))
	    )
	   (t
	    (dbDeletePropByName CDFdbid "ePeri")
	    )
	   )
      )) ;;end when/foreach

    (foreach dev (TECHgetBjtDevices "npn4")
	     
	(when (equal CDFdbid~>modelName (TECHgetDeviceParam dev 'hspiceModel))
	    
	  (cond
	   ((TECHgetDeviceParam dev 'baseArea)
	    (dbReplaceProp CDFdbid "bArea" "float" (TECHgetDeviceParam dev 'baseArea))
	    )
	   (t
	    (dbDeletePropByName CDFdbid "bArea")
	    )
	   )
	  (cond
	   ((TECHgetDeviceParam dev 'basePerim)
	    (dbReplaceProp CDFdbid "bPeri" "float" (TECHgetDeviceParam dev 'basePerim))
	    )
	   (t
	    (dbDeletePropByName CDFdbid "bPeri")
	    )
	   )
	  (cond 
	   ((TECHgetDeviceParam dev 'emitterArea)
	    (dbReplaceProp CDFdbid "eArea" "float" (TECHgetDeviceParam dev 'emitterArea))
	    )
	   (t
	    (dbDeletePropByName CDFdbid "eArea")
	    )
	   )
	  (cond
	   ((TECHgetDeviceParam dev 'emitterPerim)
	    (dbReplaceProp CDFdbid "ePeri" "float" (TECHgetDeviceParam dev 'emitterPerim))
	    )
	   (t
	    (dbDeletePropByName CDFdbid "ePeri")
	    )
	   )
      ))

    (CDFcommonDone CDFdbid)
)

(defun CDFpnp4Done (CDFdbid "d")
    (CDFnpn4Done CDFdbid)
)

;;; 
;;; CDFafuseDone --
;;;     This function sets the model name based off the cyclic
;;;     modelList selection.
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;;
(defun CDFafuseDone (CDFdbid "d")

    (CDFcommonDone CDFdbid)
)

;;; 
;;; CDFefuseDone --
;;;     This function sets the model name based off the cyclic
;;;     modelList selection.
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;;
(defun CDFefuseDone (CDFdbid "d")

    (CDFcommonDone CDFdbid)
)


;;; 
;;; CDFmtjInit --
;;;     This function doesn't do much of anything, just
;;;     calls the shared init function
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFmtjInit (cdfId "o")
  (CDFcommonInit cdfId)
)

;;; 
;;; CDFmtjDone --
;;;     This function sets the isSubckt and the model description
;;;     on a mtj instance.
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFmtjDone (CDFdbid "d")
  ;; create isSubckt property when the model calls for it (probably always)
  ;; create model information
  (let ( thisMtj mtjDevices mtjModelDescription )
    (setq mtjDevices (TECHgetMtjDevices CDFdbid~>cellName))
    (setq thisMtj (car mtjDevices))
    ;; loop through all the mtjs looking for the one with this model
    (while (and thisMtj
		(nequal CDFdbid~>model
			(TECHgetDeviceParam thisMtj 'hspiceModel))
		)
      (setq thisMtj (car mtjDevices))
      (setq mtjDevices (cdr mtjDevices))
      )
    
    ;; now that we know which device we have, set
    ;; the isSubckt property or delete it, as needed
    (cond
     ((TECHgetDeviceParam thisMtj 'isSubckt)
      (dbReplaceProp CDFdbid "isSubckt" "boolean" t)
      )
     (t
      (dbDeletePropByName CDFdbid "isSubckt")
      )
     ) ;; cond
    
    ;; set the model description
    ;; although already done dynamically in the callback,
    ;; there are reasons to do it again.
    (setq mtjModelDescription
	  (or (TECHgetDeviceParam thisMtj 'description)
	      "No description available"))
    ;; set the mtj model description into the cdf form
    cdfgData->mtjModelInfo->value = mtjModelDescription
    
    ) ;; let
  (CDFcommonDone CDFdbid)
)

;;; 
;;; CDFmtj5Init --
;;;     This function doesn't do much of anything, just
;;;     calls the shared init function
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFmtj5Init (cdfId "o")
  (CDFcommonInit cdfId)
)

;;; 
;;; CDFmtj5Done --
;;;     This function sets the isSubckt and the model description
;;;     on a mtj5 instance.
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFmtj5Done (CDFdbid "d")
  ;; create isSubckt property when the model calls for it (probably always)
  ;; create model information
  (let ( thisMtj5 mtj5Devices mtj5ModelDescription )
    (setq mtj5Devices (TECHgetMtj5Devices CDFdbid~>cellName))
    (setq thisMtj5 (car mtj5Devices))
    ;; loop through all the mtj5s looking for the one with this model
    (while (and thisMtj5
		(nequal CDFdbid~>model
			(TECHgetDeviceParam thisMtj5 'hspiceModel))
		)
      (setq thisMtj5 (car mtj5Devices))
      (setq mtj5Devices (cdr mtj5Devices))
      )
    
;;    ;; now that we know which device we have, set
;;    ;; the isSubckt property or delete it, as needed
;;    (cond
;;     ((TECHgetDeviceParam thisMtj5 'isSubckt)
;;      (dbReplaceProp CDFdbid "isSubckt" "boolean" t)
;;      )
;;     (t
;;      (dbDeletePropByName CDFdbid "isSubckt")
;;      )
;;     ) ;; cond
    
    ;; set the model description
    ;; although already done dynamically in the callback,
    ;; there are reasons to do it again.
    (setq mtj5ModelDescription
	  (or (TECHgetDeviceParam thisMtj5 'description)
	      "No description available"))
    ;; set the mtj5 model description into the cdf form
    cdfgData->mtj5ModelInfo->value = mtj5ModelDescription
    
    ) ;; let
  (CDFcommonDone CDFdbid)
)

;;; 
;;; CDFrefCellInit --
;;;     This function doesn't do much of anything, just
;;;     calls the shared init function
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFrefCellInit (cdfId "o")
  (CDFcommonInit cdfId)
)


;;; 
;;; CDFrefCellDone --
;;;     This function sets the isSubckt and the model description
;;;     on a refCell instance.
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFrefCellDone (CDFdbid "d")
  ;; create isSubckt property when the model calls for it (probably always)
  ;; create model information
  (let ( thisrefCell refCellDevices refCellModelDescription )
    (setq refCellDevices (TECHgetrefCellDevices CDFdbid~>cellName))
    (setq thisrefCell (car refCellDevices))
    ;; loop through all the refCels looking for the one with this model
    (while (and thisrefCell
		(nequal CDFdbid~>model
			(TECHgetDeviceParam thisrefCell 'hspiceModel))
		)
      (setq thisrefCell (car refCellDevices))
      (setq refCellDevices (cdr refCellDevices))
      )
    ) ;; let
  (CDFcommonDone CDFdbid)
)


;;; 
;;; CDFmemCellInit --
;;;     This function doesn't do much of anything, just
;;;     calls the shared init function
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFmemCellInit (cdfId "o")
  (CDFcommonInit cdfId)
)


;;; 
;;; CDFmemCellDone --
;;;     This function sets the isSubckt and the model description
;;;     on a memCell instance.
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFmemCellDone (CDFdbid "d")
  ;; create isSubckt property when the model calls for it (probably always)
  ;; create model information
  (let ( thismemCell memCellDevices memCellModelDescription )
    (setq memCellDevices (TECHgetmemCellDevices CDFdbid~>cellName))
    (setq thismemCell (car memCellDevices))
    ;; loop through all the memCells looking for the one with this model
    (while (and thismemCell
		(nequal CDFdbid~>model
			(TECHgetDeviceParam thismemCell 'hspiceModel))
		)
      (setq thismemCell (car memCellDevices))
      (setq memCellDevices (cdr memCellDevices))
      )
   ) ;; let
  (CDFcommonDone CDFdbid)
)


;;; 
;;; CDFsetInd3ModelName --
;;;     This function sets the model name based off the cyclic
;;;     modelList selection.
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;;
(defun CDFsetInd3ModelName (cdfgData "o")
    (when cdfgData->modelList->value
      cdfgData->modelName->value = cdfgData->modelList->value
    )
)


;;; 
;;; CDFsetInd4ModelName --
;;;     This function sets the model name based off the cyclic
;;;     modelList selection.
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;;
(defun CDFsetInd4ModelName (cdfgData "o")
    (when cdfgData->modelList->value
      cdfgData->modelName->value = cdfgData->modelList->value
    )
)

;;; 
;;; CDFmtjCallback --
;;;     This function sets the model description dynamically
;;;     on a mtj instance as the model is changed.
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFmtjCallback (mtjCellName cdfgData "to")
  (let (mtjModelDescription mtjDevices thisMtj)
    (setq mtjDevices (TECHgetMtjDevices mtjCellName))
    (setq thisMtj (car mtjDevices))
    ;; loop through all the mtjs looking for the one with this model
    (while (and thisMtj
		(nequal cdfgData->model->value
			(TECHgetDeviceParam thisMtj 'hspiceModel))
		)
      (setq thisMtj (car mtjDevices))
      (setq mtjDevices (cdr mtjDevices))
      )
    ;; set the model description
    (setq mtjModelDescription
	  (or (TECHgetDeviceParam thisMtj 'description)
	      "No description available"))
    ;; set the mtj model description into the cdf form
    cdfgData->mtjModelInfo->value = mtjModelDescription
    )
)



;;; 
;;; CDFmtj5Callback --
;;;     This function sets the model description dynamically
;;;     on a mtj5 instance as the model is changed.
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFmtj5Callback (mtj5CellName cdfgData "to")
  (let (mtj5ModelDescription mtj5Devices thisMtj5)
		(setq mtj5Devices (TECHgetMtj5Devices mtj5CellName))
		(setq thisMtj5 (car mtj5Devices))
		;; loop through all the mtj5s looking for the one with this model
		(while (and thisMtj5 (nequal cdfgData->modelName->value
		                     (TECHgetDeviceParam thisMtj5 'hspiceModel)))
			(setq thisMtj5    (car mtj5Devices))
			(setq mtj5Devices (cdr mtj5Devices))
		)
		;; set the model description
		(setq mtj5ModelDescription  (or (TECHgetDeviceParam thisMtj5 'description)
		                            "No description available"))
		;; set the mtj5 model description into the cdf form
		cdfgData->mtj5ModelInfo->value = mtj5ModelDescription
;;(printf "value -- %L\n" mtj5ModelDescription)
	)
)


;;; 
;;; CDFcommonInit --
;;; 
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFcommonInit (cdfId "o")
;    (foreach x cdfgData->cyInit
;	(errset (LISTeval x) t))
    nil
)

;;; 
;;; CDFcommonDone --
;;; 
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFcommonDone (cdfDbid "d")
  (unless (equal cdfDbid~>cellName cdfDbid~>techLibCellName)
    (warn "Instance %L of %L was originally placed as an instance of %L.  Delete and re-place the instance.\n"
          cdfDbid~>name cdfDbid~>cellName cdfDbid~>techLibCellName)
    )
  ;; do not do anything for icecaps
  (unless (equal "icecap" cdfDbid~>cellName)
    ;; kludge around the "showName" parameter
    (CDFshowNameKludge cdfDbid cdfgData->preShowName->value)
    )
  )

;;; 
;;; CDFcreateHideProps --
;;;   This function used to create the "hide_XXX" properties that were
;;; used by the NLP expressions of the tech lib element symbols to prevent
;;; the display of parameters which were default values.  This function
;;; should have been called by the CDF callback for the elements.
;;;   The cdf for the element has the property CDFhideProps, which is a list
;;; of symbols of the property names that can be hidden.
;;;   Now, the symbols displays are ILLabels, which dynamically determine
;;; what needs to be displayed without the use of the "hide_XXX" properties.
;;; Therefore, if old properties are lingering, delete them.
;;;
;;; Input: dbid: database id of the instance that was just modified
;;; Output: 
;;; Globals: cdfgData
;;; Side Effects: deletes "hide_XXX" properties
;;; Return: 
;;; 
(defun CDFcreateHideProps (dbid "d")
    (let (propVal defVal actVal)
	(foreach prop cdfgData->CDFhideProps
	    ;; Labels have been updated to dynamically determine this.
	    ;; Therefore, blow away the bloat of these excess properties
	    ;; if they exist.
	    (when (dbGet dbid (concat "hide_" prop))
		(dbDeletePropByName dbid (strcat "hide_" prop))
	    )
	)
    )
)

;;; 
;;; CDFcreateAsymProps --
;;;   This function used to create the "asymX" properties that were
;;; used by the NLP expressions of the logic gate tech lib element symbols.
;;; If the property existed, it means that the w/l/m properties were not
;;; consistent for all of the pfets in a logic gate, for example.  The
;;; NLP expressions would have printed out a w/l*m entry for each pfet if
;;; the properties are asymmetric, or only one.
;;;   Now, the symbols displays are ILLabels, which dynamically determine
;;; what needs to be displayed without the use of the "asymX" properties.
;;; Therefore, if old properties are lingering, delete them.
;;; 
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFcreateAsymProps (dbid "d")
    (let (suffix pname)
	(foreach prefix cdfgData->CDFasymPrefixes
	    (cond
		((listp prefix)
		 (setq suffix (cadr prefix))
		 (setq prefix (car prefix))
		)
		(t (setq suffix ""))
	    )
	    (setq pname (strcat "asym" (upperCase (strcat prefix suffix))))
	    (when (dbGet dbid pname)
		(dbDeletePropByName dbid pname)
	    )
	)
    )
)

;;; 
;;; CDFfetMfactorCallback --
;;;   This function will verify that the mfactor is >= 1
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFfetMfactorCallback ()
    (let (theNum)
        (setq theNum atoi(cdfgData->m->value))   
		    ;; don't let them specify an empty string for the mfactor.
		    ;; that would introduce equation errors for diodes during
		    ;; schematic extraction, but won't be caught until
		    ;; simulation
;		    ((null (parseString theNum " \t\n"))
;		     (get cdfgData param)->value = "1"
;		     (setq theNum 1)
;		    )
	    (when (or (null (integerp theNum))
		    (lessp theNum 1))
		    (warn (sprintf nil "CDFmfactorCallback: m has illegal value %L; you are begging for trouble.\n" (cdfgData->m->value)))
            cdfgData->m->value = "1"
	    )
    )
)

;;; 
;;; CDFfetMultCallback --
;;;   This function will verify that mult is >= 1
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFfetMultCallback ()
    (let (theNum)
        (setq theNum atoi(cdfgData->mult->value))   
		    ;; don't let them specify an empty string for the mfactor.
		    ;; that would introduce equation errors for diodes during
		    ;; schematic extraction, but won't be caught until
		    ;; simulation
;		    ((null (parseString theNum " \t\n"))
;		     (get cdfgData param)->value = "1"
;		     (setq theNum 1)
;		    )
	    (when (or (null (integerp theNum))
		    (lessp theNum 1))
		    (warn (sprintf nil "CDFfetMultCallback: mult has illegal value %L; you are begging for trouble.\n" (cdfgData->mult->value)))
            cdfgData->mult->value = "1"
	    )
    )
)

;;; 
;;; CDFrmfactorCallback --
;;;   This function will verify that the mfactor is >= 1
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFrmfactorCallback ()
    (let (aNum)
        (setq aNum atoi(cdfgData->rm->value))   
		    ;; don't let them specify an empty string for the mfactor.
		    ;; that would introduce equation errors for diodes during
		    ;; schematic extraction, but won't be caught until
		    ;; simulation
;		    ((null (parseString theNum " \t\n"))
;		     (get cdfgData param)->value = "1"
;		     (setq theNum 1)
;		    )
	    (when (or (null (integerp aNum))
		    (lessp aNum 1))
		    (warn (sprintf nil "CDFmfactorCallback: rm has illegal value %L; you are begging for trouble.\n" (cdfgData->rm->value)))
            cdfgData->rm->value = "1"
	    )
    )
)



;;; 
;;; CDFcmfactorCallback --
;;;   This function will verify that the mfactor is >= 1
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFcmfactorCallback ()
    (let (theNum)
        (setq theNum atoi(cdfgData->cm->value))   
		    ;; don't let them specify an empty string for the mfactor.
		    ;; that would introduce equation errors for diodes during
		    ;; schematic extraction, but won't be caught until
		    ;; simulation
;		    ((null (parseString theNum " \t\n"))
;		     (get cdfgData param)->value = "1"
;		     (setq theNum 1)
;		    )
	    (when (or (null (integerp theNum))
		    (lessp theNum 1))
		    (warn (sprintf nil "CDFmfactorCallback: cm has illegal value %L; you are begging for trouble.\n" (cdfgData->cm->value)))
            cdfgData->cm->value = "1"
	    )
    )
)

;;; 
;;; CDFdiodeMethodMap --
;;;   This function will map a diode method name into something shorter.
;;; For example, "insideContact" will be abbreviated "iC", etc.
;;;
;;; Input: a string or nil
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: abbreviated string or nil
;;; 
(defun CDFdiodeMethodMap (diodeMethod)
    (cond
	((null diodeMethod)
	 nil
	)
	((equal "insideContact" diodeMethod)
	 (or (ENVgetVal "schematic" "diodeInsideContact") "insideContact")
	)
	((equal "insideNoContact" diodeMethod)
	 (or (ENVgetVal "schematic" "diodeInsideNoContact") "insideNoContact")
	)
	((equal "outsideContact" diodeMethod)
	 (or (ENVgetVal "schematic" "diodeOutsideContact") "outsideContact")
	)
	((equal "none" diodeMethod)
	 (or (ENVgetVal "schematic" "diodeNone") "none")
	)
	(t nil)
    )
)

;; just a shorter alias for CDFdiodeMethodMap
(defun CDFdMM (diodeMethod)
    (CDFdiodeMethodMap diodeMethod)
)

;;; 
;;; CDFcapbnCanParamModel --
;;;   When they are trying to toggle on the "constantCap" field of a capbn_b
;;; instance, make sure that we know the ca and cp (or alternatively c0 to c3)
;;; parameters in order to support deriving the cw and cl.
;;;   This has been extended to support the cmimc devices in an identical
;;; method.
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFcapbnCanParamModel (cdfId)
    (let (ca cp c0 c1 c2 c3 varactor)

	;; if they are trying to turn it on, make sure that we know the
	;; ca and cp parameters for this cap
	(when cdfId->constantCap->value
	    (foreach cap (append (append (TECHgetCapDevices "capbn_b")
				 (TECHgetCapDevices "cmimc"))
				 (TECHgetCapDevices "cmim3c"))
		(when
		    (equal
		     (TECHgetDeviceParam cap 'hspiceModel)
		     cdfId->ctype->value
		    )
		    (setq ca (TECHgetDeviceParam cap 'areaCap))
		    (setq cp (TECHgetDeviceParam cap 'perimCap))
		    (setq c0 (TECHgetDeviceParam cap 'c0))
		    (setq c1 (TECHgetDeviceParam cap 'c1))
		    (setq c2 (TECHgetDeviceParam cap 'c2))
		    (setq c3 (TECHgetDeviceParam cap 'c3))
		    (setq varactor (TECHgetDeviceParam cap 'varactor))
		)
	    )
	    (unless varactor
	      (unless (and ca cp)
		cdfId->constantCap->value = nil
		(warn "Unknown ca and cp parameters for this cap model\n")
		)
	      )
	    (when varactor
	      (unless (and c0 c1 c2 c3)
		cdfId->constantCap->value = nil
		(warn "Unknown c0, c1, c2, and c3 parameters for this cap model\n")
		)
	      )
	    )
	)
    )

;;; 
;;; CDFcalculateCapacitors --
;;;   This function does some neat calculations on capacitors.  When it is
;;; an constant cap, it will calculate the width, or the length, or a square
;;; width and length that closest comes to the specified cap value.  If they
;;; specify the width and length, it will calculate the total cap value.
;;; Currently, this can work for capbn_b and cmimc capacitors
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFcalculateCapacitors (cdfId @optional changedParam)
    (let (capName cw cl ca cp c cm scale grid calcDimension c0 c1 c2 c3 varactor deltaW deltaL hsp)
        (setq deltaL 0)
        (setq deltaW 0)

	;; when it is a constant capacitor, determine whether the fixed
	;; dimension is width, length, or square (equal w & l)
	;;
	(when (and cdfId->constantCap->value
		   (nequal "FALSE" cdfId->constantCap->value))
	    (setq calcDimension cdfId->calcDimension->value)
	)

	(foreach cap (append (append (TECHgetCapDevices "capbn_b")
			     (TECHgetCapDevices "cmimc"))
			     (TECHgetCapDevices "cmim3c"))
        (setq hsp (TECHgetDeviceParam cap 'hspiceModel))
	    (when
		(equal
		 (TECHgetDeviceParam cap 'hspiceModel)
		 cdfId->ctype->value
		)
;        (warn "TECHgetDeviceParam hspiceModel: hspiceModel = %L ctype = %L\n" hsp cdfId->ctype->value)
		(setq capName   (TECHgetDeviceParam cap 'name))
		(setq ca (TECHgetDeviceParam cap 'areaCap))
		(setq cp (TECHgetDeviceParam cap 'perimCap))
		(setq c0 (TECHgetDeviceParam cap 'c0))
		(setq c1 (TECHgetDeviceParam cap 'c1))
		(setq c2 (TECHgetDeviceParam cap 'c2))
		(setq c3 (TECHgetDeviceParam cap 'c3))
		(setq varactor (TECHgetDeviceParam cap 'varactor)) ;; use c0, c1, c2, c3 for
		                                                   ;; cap calculation when true
		(setq deltaW (TECHgetDeviceParam cap 'deltaW))
		(unless deltaW
		  (setq deltaW 0)
		  )
		(setq deltaL (TECHgetDeviceParam cap 'deltaL))
		(unless deltaL
		  (setq deltaL 0)
		  )

;		;; see if this is a 3 term netlist, and create or delete
;		;; the threeTermNetlist property accordingly
;		(cond
;		 ((TECHgetDeviceParam cap 'threeTermNetlist)
;		  cdfId->threeTermNetlist->value = t
;		  )
;		 (t
;		  cdfId->threeTermNetlist->value = nil
;		)
;	    )
		
	    )
	)

	;; try to get the cw, cl, and c cdf fields as numbers.  Apply the
	;; shrink factors to cw and cl.  When deriving cw and cl, round it
	;; to the snap grid
	(setq scale (or (TECHgetProp scaleFactor) 1.0))
	(setq grid (TECHgetProp snapGrid))

	(setq cw cdfId->cw->value)
	(cond
	    ((and (stringp cw) (aelIsNumberP cw))
	     (setq cw (times scale (difference (aelNumber cw) deltaW)))
	    )
	    ((and (stringp cw) (nequal "" cw))
	     (setq cw (sprintf nil "(((%s)-%g)*%g)" cw deltaW scale))
	    )
	    ((numberp cw)
	     (setq cw (times scale (difference cw deltaW)))
	    )
	)
	(setq cl cdfId->cl->value)
	(cond
	    ((and (stringp cl) (aelIsNumberP cl))
	     (setq cl (times scale (difference (aelNumber cl) deltaL)))
	    )
	    ((and (stringp cl) (nequal "" cl))
	     (setq cl (sprintf nil "(((%s)-%g)*%g)" cl deltaL scale))
	    )
	    ((numberp cl)
	     (setq cl (times scale (difference cl deltaL)))
	    )
	)

	;; the total C is cm * (cap for w & l).  Because we do our
	;; calculations for the w and l, divide the C by cm.  Also, the
	;; parameters defined in the edr assume fF, but the cdf should work
	;; with plain F.  Therefore, multiply the C by 1e15 here.
	(setq cm cdfId->cm->value)
	(cond
	    ((and (stringp cm) (aelIsNumberP cm))
	     (setq cm (aelNumber cm))
	    )
	    ((and (stringp cm) (nequal "" cm))
	     (setq cm (sprintf nil "(%s)" cm))
	    )
	    ((equal "" cm)
	     (setq cm 1.0)
	    )
	)
	(setq c cdfId->c->value)
 	(when (and (stringp c) (aelIsNumberP c))
 	    (setq c (aelNumber c))
 	)
	;; if the number > 1e-3, assume that they meant to enter it in pF
	(when (and (numberp c) (greaterp c 1e-3))
	    (setq c (times 1e-12 c))
	)
	(cond
	    ;; if c and cm are numbers, divide c by cm
	    ((and (numberp c) (numberp cm))
	     (setq c (quotient (times c 1e15) cm))
	    )
	    ;; if c or cm are strings, set c to an expression
	    ((or (and (stringp c) (nequal "" c))
		 (and (stringp cm) (nequal "" cm)))
	     ;; get both c and cm as strings
	     (cond
		 ((numberp c) (setq c (sprintf nil "%g" c)))
		 ((stringp c) (setq c (strcat "(" c ")" "*1e-12")))
	     )
	     (when (numberp cm) (setq cm (sprintf nil "%g" cm)))
	     (setq c (sprintf nil "(%s*1e15/%s)" c cm))
	    )
	)

	;; first, get the cap width and length under control.  We may have
	;; to derive them if they specify the capacitance
	(cond
	    ;; if this is a constant capacitance capbn, derive the correct
	    ;; cw or cl parameter and stuff it back into the CDF
	    ;;
	    ((or (and cdfId->constantCap->value ca cp c (nequal "" c))
		 (and cdfId->constantCap->value c0 c1 c2 c3 c (nequal "" c)))
	     (cond
		 ;; if c is a number, try to derive the cw and cl as numbers
		 ((numberp c)
		  (cond
		      ;; if they changed the cap value, calculate derived
		      ;; cw=cl to satisfy the equation
		      ((and (equal changedParam 'cap)
			    (equal calcDimension "Square"))
		       (unless varactor 
			 (setq cl (quotient (plus (times -4.0 cp) (sqrt (plus (times 16 cp cp) (times 4.0 ca c))))
					    (times 2.0 ca scale)
					    )
			       )
			 )
		       (when varactor
			 (let (a b c_) ;; have to use goofy c_ because c is taken
			   (setq a (aelNumber c3))
			   (setq b (plus (aelNumber c1) (aelNumber c2)))
			   (setq c_ (difference (aelNumber c0) (aelNumber c)))
			   (setq cl (quotient (plus -b (sqrt (difference (times b b) (times 4 a c_))))
					      (times 2.0 a scale)
					      )
				 )
			   )
			 )
		       ;; round it onto grid
		       (setq cw (times (round (quotient (plus cl deltaW) grid)) grid))
		       (setq cl (times (round (quotient (plus cl deltaL) grid)) grid))
		       ;; cdf field should always be a string now
		       (setq cl (sprintf nil "%g" cl))
		       (setq cw (sprintf nil "%g" cw))
		       cdfId->cl->value = cl
		       cdfId->cw->value = cw
		      )
		      ;; if they changed the cw, adjust the length
		      ;; correspondingly
		      ((or (equal calcDimension "Length")
			   (equal changedParam 'cw))
		       (cond
			   ;; if cw is a number, calculate cl
			   ((numberp cw)
			    (unless varactor
			      (setq cl
				    (quotient (difference c (times 2 cp (difference cw deltaW)))
					      (times scale (plus (times ca (difference cw deltaW)) (times 2 cp)))))
			      )
			    (when varactor
			      (setq cl (quotient (difference c c0 (times c2 (difference cw deltaW)))
						 (times scale (plus c1 (times c3 (difference cw deltaW))))
						 )
				    )
			      )
			    ;; round it onto grid
			    (setq cl (times (round (quotient (plus cl deltaL) grid)) grid))
			    ;; cdf field should always be a string now
			    (setq cl (sprintf nil "%g" cl))
			    cdfId->cl->value = cl
			   )
			   ;; if cw is a param, do cl as an equation
			   ((and (stringp cw) (nequal "" cw))
			    (unless varactor
			      (setq cl (sprintf nil "((%g-(2*%g*(%s-%g)))/(%g*(%g*(%s-%g)+2*%g)))+%g"
						c cp cw deltaW scale ca cw deltaW cp deltaL)
				    )
			      )
			    (when varactor
			      (setq cl (sprintf nil "((%g-%g-(%g*(%s-%g)))/(%g*(%g+(%g*(%s-%g)))))+%g"
						c c0 c2 cw deltaW scale c1 c3 cw deltaW deltaL)
				    )
			      )
			    cdfId->cl->value = cl
			   )
		       )
		      )
		      ;; if they changed the cl, adjust the cw
		      ((or (equal calcDimension "Width")
			   (equal changedParam 'cl))
		       (cond
			   ;; if cl is a number, calculate cw
			   ((numberp cl)
			    (unless varactor
			      (setq cw
				    (quotient (difference c (times 2 cp (difference cl deltaL)))
					      (times scale (plus (times ca (difference cl deltaL)) (times 2 cp)))))
			      )
			    (when varactor
			      (setq cw (quotient (difference c c0 (times c1 (difference cl deltaL)))
						 (times scale (plus c2 (times c3 (difference cl deltaL))))
						 )
				    )
			      )
			    ;; round it onto grid
			    (setq cw (times (round (quotient (plus cw deltaW) grid)) grid))
			    ;; cdf field should always be a string now
			    (setq cw (sprintf nil "%g" cw))
			    cdfId->cw->value = cw
			   )
			   ((and (stringp cl) (nequal "" cl))
			    (unless varactor
			      (setq cw (sprintf nil "((%g-(2*%g*(%s-%g)))/(%g*(%g*(%s-%g)+2*%g)))+%g"
						c cp cl deltaL scale ca cl deltaL cp deltaW)
				    )
			      )
			    (when varactor
			      (setq cw (sprintf nil "((%g-%g-(%g*(%s-%g)))/(%g*(%g+(%g*(%s-%g)))))+%g"
						c c0 c1 cl deltaL scale c2 c3 cl deltaL deltaW)
				    )
			      )
			    cdfId->cw->value = cw
			   )
		       )
		      )
		      (t nil) ; should not get here; I dunno what changed
		  )
		 )
		 ;;
		 ;; else, if c is a parameter, derive equations
		 ;;
		 ((and (stringp c) (nequal "" c))
		  ;; for simplicity, get cw, cl, ca, cp, and scale as strings
		  (unless varactor
		    (foreach param '(cw cl ca cp scale)
			     (when (numberp (eval param))
			       (set param (sprintf nil "%g" (eval param)))
			       )
			     )
		    )
		  (when varactor
		    (foreach param '(c0 c1 c2 c3 scale)
			     (when (numberp (eval param))
			       (set param (sprintf nil "%g" (eval param)))
			       )
			     )
		    )
		  (cond
		      ;; if they changed the cap value, calculate derived
		      ;; cw=cl to satisfy the equation
		      ((and (equal changedParam 'cap)
			    (equal calcDimension "Square"))
		       (unless varactor
			 (setq cl (sprintf nil "(((-4*%s)+sqrt((16*%s*%s)+(4*%s*%s)))/(2*%s*%s))+%g"
					   cp cp cp ca c ca scale deltaL
					   )
			       )
			 (setq cw (sprintf nil "(((-4*%s)+sqrt((16*%s*%s)+(4*%s*%s)))/(2*%s*%s))+%g"
					   cp cp cp ca c ca scale deltaW
					   )
			       )
			 )
		       (when varactor
			 (let (a b c_)
			   (setq a (aelNumber c3))
			   (setq b (plus (aelNumber c1) (aelNumber c2)))

			   ;;SPR 40756. 'c' is a param so build a string
			   (setq c_ (sprintf nil "(%s-%s)" c0 c))

			   ;;SPR 40756. As far as I can see a, b and deltL and deltaW are numbers and c_ and scale are strings
			   ;;But the format descriptors are a problem down the road for the varactor case and I am not sure of 
			   ;;all the possible cases that may cause a variable to be a string or a number.
			   ;;So for now I will use the catch all %L.
			   (setq cl (sprintf nil "((-%L+sqrt((%L*%L)-(4*%L*%L)))/(2*%L*%L))+%L"
					     b b b a c_ a scale deltaL
					     )
				 )
			   (setq cw (sprintf nil "((-%L+sqrt((%L*%L)-(4*%L*%L)))/(2*%L*%L))+%L"
					     b b b a c_ a scale deltaW
					     )
				 )
			   )
			 )

		       cdfId->cl->value = cl
		       cdfId->cw->value = cw
		      )
		      ;; if they changed the cw, adjust the length
		      ;; correspondingly
		      ((or (equal calcDimension "Length")
			   (equal changedParam 'cw))
		       (when (nequal "" cw)
			 (unless varactor
			   (setq cl (sprintf nil "((%s-(2*%s*%s))/(%s*(%s*%s+2*%s)))+%g"
					     c cp cw scale ca cw cp deltaL)
				 )
			   )
			 (when varactor

			     ;;SPR 40756. Changing %s to %L
			   (setq cl (sprintf nil "((%L-%L-(%L*(%L-%L)))/(%L*(%L+(%L*(%L-%L)))))+%L"
					     c c0 c2 cw deltaW scale c1 c3 cw deltaW deltaL
					     )
				 )
			   )
			 cdfId->cl->value = cl
		       )
		      )
		      ;; if they changed the cl, adjust the cw
		      ((or (equal calcDimension "Width")
			   (equal changedParam 'cl))
		       (when (nequal "" cl)
			 (unless varactor
			   (setq cw (sprintf nil "((%s-(2*%s*%s))/(%s*(%s*%s+2*%s)))+%g"
					     c cp cl scale ca cl cp deltaW)
				 )
			   )
			 (when varactor

			     ;;SPR 40756. Changing %s to %L
			   (setq cw (sprintf nil "((%L-%L-(%L*(%L-%L)))/(%L*(%L+(%L*(%L-%L)))))+%L"
					     c c0 c1 cl deltaL scale c2 c3 cl deltaL deltaW
					     )
				 )
			   )
			 cdfId->cw->value = cw
		       )
		      )
		      (t nil) ; should not get here; I dunno what changed
		  )
		 )
	     )
	    )
	)

	;; start fresh with the cw and cl fields from the CDF.  They will
	;; have to be scaled if we can calculate the total capacitance.
	;; Get the cw and cl fields as numbers.
	;;
	(setq cw cdfId->cw->value)
	(setq cl cdfId->cl->value)
	(when (and (stringp cw) (aelIsNumberP cw)) (setq cw (aelNumber cw)))
	(when (and (stringp cl) (aelIsNumberP cl)) (setq cl (aelNumber cl)))

	(cond
	    ;; if we have the ca and cp fields, and the cw and cl are numbers,
	    ;; update the capacitance field.  Remember to divide the c by 1e15
	    ;; because the field is in F, but ca and cf are in terms of fF
	    ;;
	    ((or (and ca cp (numberp cw) (numberp cl) (numberp cm))
		 (and c0 c1 c2 c3 (numberp cw) (numberp cl) (numberp cm)))
	     (setq cw (difference cw deltaW))
	     (setq cl (difference cl deltaL))
	     (unless varactor
	       (setq c (plus (times cw scale cl scale ca)
			     (times 2.0 cp scale (plus cw cl))))
	       )
	     (when varactor
	       (setq c (plus c0
			     (times c1 cl)
			     (times c2 cw)
			     (times c3 cl cw)
			     )
		     )
	       )
	     (setq c (quotient (times cm c) 1e15))
	     cdfId->actualC->value = (sprintf nil "%g" c)

	     ;; If they specified a constant capacitance, do not change the
	     ;; constant capacitance that they specify.
	     (when (null cdfgData->constantCap->value)
		 cdfId->c->value = (sprintf nil "%g" c)
	     )
	    )
	    ;; otherwise, clear out the cap field, but not when they have
	    ;; entered a parameter for C
	    ((null cdfId->constantCap->value)
	     cdfId->c->value = ""
	     cdfId->actualC->value = ""
	    )
	)

	cdfId->isSubckt->value = (TECHgetDeviceParam (TECHgetDevice ?name capName) 'isSubckt)
    )
)



;;; 
;;; CDFcalculateCap_int3 --
;;;   This function does some neat calculations on capacitors.  When it is
;;; an constant cap, it will calculate the width, or the length, or a square
;;; width and length that closest comes to the specified cap value.  If they
;;; specify the width and length, it will calculate the total cap value.
;;; Currently, this can work for capbn_b and cmimc capacitors
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFcalculateCap_int3 ()
	(let (capName c cm cap_type)
		(foreach cap (TECHgetCapNotInListDevices "cap_int3")
			(when	(equal (TECHgetDeviceParam cap 'hspiceModel) cdfgData->ctype->value)
				(setq capName   (TECHgetDeviceParam cap 'name))
;		        (warn "cap name is %L\n" capName)
			)
		)
		
	;; the parameters defined in the edr assume fF, but the cdf should work
	;; with plain F.  Therefore, multiply the C by 1e15 here.
		(setq cm cdfgData->cm->value)
		(cond
			((and (stringp cm) (aelIsNumberP cm))
				(setq cm (aelNumber cm))
			)
			((and (stringp cm) (nequal "" cm))
				(setq cm (sprintf nil "(%s)" cm))
			)
			((equal "" cm)
				(setq cm 1.0)
			)
		)
		(setq c (sprintf nil "%L" (TECHgetRule (sprintf nil "%s" capName))))
		
		(when (and (stringp c) (aelIsNumberP c))
			(setq c (aelNumber c))
		)
		;; if the number > 1e-3, assume that they meant to enter it in fF
		(cond 
      ((and (numberp c) (greaterp c 1e-3))
			(setq c (times 1e-15 c))
      )
      (t (setq c (times 1e-12 c))
      )
		)
		(cond
			;; if c and cm are numbers, divide c by cm
			;; if c or cm are strings, set c to an expression
			((or (and (stringp c) (nequal "" c)) (and (stringp cm) (nequal "" cm)))
				;; get both c and cm as strings
				(cond
					((numberp c) (setq c (sprintf nil "%g" c)))
					((stringp c) (setq c (strcat "(" c ")")))
				)
				(when (numberp cm) (setq cm (sprintf nil "%g" cm)))
				(setq c (sprintf nil "(%s)" c))
			)
		)
		cdfgData->c->value = (sprintf nil "%g" c)
		;;(printf "value -- %L\n" c)
	)
)


;;; 
;;; CDFcalculatevppcap --
;;;   This function does some neat calculations on capacitors.  When it is
;;; an constant cap, it will calculate the width, or the length, or a square
;;; width and length that closest comes to the specified cap value.  If they
;;; specify the width and length, it will calculate the total cap value.
;;; Currently, this can work for capbn_b and cmimc capacitors
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 

(defun CDFcalculatevppcap ()
	(let (capName c cm cap_type)
		(foreach cap (TECHgetCapNotInListDevices "vppcap")
			(when	(equal (TECHgetDeviceParam cap 'hspiceModel) cdfgData->ctype->value)
				(setq capName   (TECHgetDeviceParam cap 'name))
			)
		)
		
	;; the parameters defined in the edr assume fF, but the cdf should work
	;; with plain F.  Therefore, multiply the C by 1e15 here.
		(setq cm cdfgData->cm->value)
		(cond
			((and (stringp cm) (aelIsNumberP cm))
				(setq cm (aelNumber cm))
			)
			((and (stringp cm) (nequal "" cm))
				(setq cm (sprintf nil "(%s)" cm))
			)
			((equal "" cm)
				(setq cm 1.0)
			)
		)
		(setq c (sprintf nil "%L" (TECHgetRule (sprintf nil "%s" capName))))
		
		(when (and (stringp c) (aelIsNumberP c))
			(setq c (aelNumber c))
		)
		;; if the number > 1e-3, assume that they meant to enter it in fF
	;;(when (and (numberp c) (greaterp c 1e-3))
	;;	(setq c (times 1e-12 c))
	;;)
   (cond 
      ((and (numberp c) (greaterp c 1e-3))
			(setq c (times 1e-15 c))
      )
      (t (setq c (times 1e-12 c))
      )
		)

		(cond
			;; if c and cm are numbers, divide c by cm
			;; if c or cm are strings, set c to an expression
			((or (and (stringp c) (nequal "" c)) (and (stringp cm) (nequal "" cm)))
				;; get both c and cm as strings
				(cond
					((numberp c) (setq c (sprintf nil "%g" c)))
					((stringp c) (setq c (strcat "(" c ")")))
				)
				(when (numberp cm) (setq cm (sprintf nil "%g" cm)))
				(setq c (sprintf nil "(%s)" c))
			)
		)
		cdfgData->c->value = (sprintf nil "%g" c)
		;;(printf "value -- %L\n" c)
		
		)
	)







;;; 
;;; CDFcapbnCalculateDiodes --
;;;   This function has grown to be greater than its namesake.  Originally,
;;; this would calculate the diode area and perimeter properties from the
;;; capacitor's width and length.
;;;   From SPR 8287, this will also allow the total capacitance to be specified
;;; and it will derive the cap width and length from it.
;;;   The diode area/perim that it calculates is for the nwell.  This is
;;; quite a bit different from the normal schxtr way of having the diode
;;; area/perim be for the diffusion.
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFcapbnCalculateDiodes (cdfId @optional changedParam)
    (let (cw cl diodeWidth diodeLength diodeArea diodePerimeter
	     diodeName additionalWidth additionalLength contactLayer)

	(CDFcalculateCapacitors cdfId changedParam)

	(foreach cap (TECHgetCapDevices "capbn_b")
	    (when
		(equal
		 (TECHgetDeviceParam cap 'hspiceModel)
		 cdfId->ctype->value
		)
		(setq diodeName (TECHgetDeviceParam cap 'diode))


		 ;; see if this is a 3 term netlist, and create or delete
		 ;; the threeTermNetlist property accordingly
;		 (cond
;		  ((TECHgetDeviceParam cap 'threeTermNetlist)
;		   ;(dbReplaceProp cdfId "threeTermNetlist" "boolean" t)
;		   cdfId->threeTermNetlist->value = t
;		   )
;		  (t
;		   ;(dbDeletePropByName cdfId "threeTermNetlist")
;		   cdfId->threeTermNetlist->value = nil
;		   )
;		 )
	    )

	)

	;; after we have the cap width and length under control, get the
	;; diode width and length in shape
	;;
	(cond
	    ((or (null cdfId->manualDiode->value)
		 (equal "FALSE" cdfId->manualDiode->value))

	     (cond
		 ((TECHresolveLayer "litr")
		  (setq contactLayer "litr")
		 )
		 ((TECHresolveLayer "ddlicon")
		  (setq contactLayer "ddlicon")
		 )
		 ((TECHresolveLayer "lmcon")
		  (setq contactLayer "lmcon")
		 )
		 ((TECHresolveLayer "licon1")
		  (setq contactLayer "licon1")
		 )
		 (t (setq contactLayer "mcon"))
	     )

	     (cond
		 ;; the cpwc has a tap thrown into the nwell separate from diff
		 ((equal "xcpwc" cdfId->ctype->value)

		  (setq additionalLength
			(plus
			 (TECHgetRuleWith "minEnclosure" "nwell" "diff")
			 (times 2.0
				(plus
				 (TECHgetRuleWith "minEnclosure"
						  "diff" contactLayer)
				 (TECHgetRuleWith "minWidth" contactLayer)
				 (TECHgetRuleWith "minGateSpacing"
						  contactLayer "poly")
				)
			 )
			 (TECHgetRuleWith "minSpacing" "diff" "tap")
			 (times 2.0 (TECHgetRuleWith "minEnclosure"
						     "tap" contactLayer))
			 (TECHgetRuleWith "minWidth" contactLayer)
			 (TECHgetRuleWith "minEnclosure" "nwell" "tap")
			)
		  )

		  (setq additionalWidth
			(times 2.0 (TECHgetRuleWith "minEnclosure"
						    "nwell" "diff"))
		  )

		 )

		 ;; the cpnc cap has the tap enclose the poly on all 4 sides,
		 ;; and has an odd enclosure of nwell
		 ((equal "xcpnc" cdfId->ctype->value)

		  (setq additionalLength
			(times 2.0
			       (plus
				(or (TECHgetRuleWith "tap_nwell_1a")
				    (TECHgetRuleWith "minEnclosure"
						     "nwell" "tap")
				)
				(TECHgetRuleWith "minEnclosure"
						 "tap" contactLayer)
				(TECHgetRuleWith "minWidth" contactLayer)
				(TECHgetRuleWith "minEnclosure" "tap" "rpoly")
			       )
			)
		  )

		  (setq additionalWidth
			(times 2.0
			       (plus
				(or (TECHgetRuleWith "tap_nwell_1a")
				    (TECHgetRuleWith "minEnclosure"
						     "nwell" "tap")
				)
				(TECHgetRuleWith "minEnclosure" "tap" "rpoly")
			       )
			)
		  )

		 )

		 ;; for the other types of capbn devices
		 (t

		  (setq additionalLength
			(times 2.0
			       (plus
				(TECHgetRuleWith "minEnclosure" "nwell" "tap")
				(TECHgetRuleWith "minEnclosure"
						 "tap" contactLayer)
				(TECHgetRuleWith "minWidth" contactLayer)
				(TECHgetRuleWith "minGateSpacing"
						 contactLayer "poly")
			       )
			)
		  )

		  (setq additionalWidth
			(times 2.0 (TECHgetRuleWith "minEnclosure"
						    "nwell" "tap"))
		  )

		 )
	     )

	     ;; get a fresh start of the cw and cl fields from the CDF
	     (setq cw cdfId->cw->value)
	     (when (and (stringp cw) (aelIsNumberP cw))
		 (setq cw (aelNumber cw))
	     )
	     (setq cl cdfId->cl->value)
	     (when (and (stringp cl) (aelIsNumberP cl))
		 (setq cl (aelNumber cl))
	     )
	     (cond
		 ;; if they are both numbers, great
		 ((and (numberp cw) (numberp cl))
		  (setq diodeWidth (plus cw additionalWidth))
		  (setq diodeLength (plus cl additionalLength))
		 )
		 ;; else, use equations
		 (t
		  (when (numberp cw) (setq cw (sprintf nil "%g" cw)))
		  (when (numberp cl) (setq cl (sprintf nil "%g" cl)))
		  (setq additionalWidth (sprintf nil "%g" additionalWidth))
		  (setq additionalLength (sprintf nil "%g" additionalLength))
		  (setq diodeWidth (sprintf nil "%s+%s" cw additionalWidth))
		  (setq diodeLength (sprintf nil "%s+%s" cl additionalLength))
		 )
	     )
	    )

	    ;; if they did manually specify the diode manually
	    (t
	     (setq diodeWidth cdfId->dw->value)
	     (setq diodeLength cdfId->dl->value)

	     ;; try to work with numbers
	     (when (and (stringp diodeWidth) (aelIsNumberP diodeWidth))
		 (setq diodeWidth (aelNumber diodeWidth))
	     )
	     (when (and (stringp diodeLength) (aelIsNumberP diodeLength))
		 (setq diodeLength (aelNumber diodeLength))
	     )
	    )
	)

	(cond
	    ;; if they manually specify the diode area and perimeter,
	    ;; do not do anything
	    ((equal "Area & Perim" cdfId->manDiodeMethod->value)
	     t
	    )
	    ;; if working with numbers
	    ((and (numberp diodeWidth) (numberp diodeLength))
	     (setq diodeArea (times diodeWidth diodeLength))
	     (setq diodePerimeter (times 2 (plus diodeWidth diodeLength)))
	     (when (equal "string" cdfId->area->paramType)
		 (setq diodeArea (sprintf nil "%g" diodeArea))
	     )
	     cdfId->area->value = diodeArea
	     (when (equal "string" cdfId->perim->paramType)
		 (setq diodePerimeter (sprintf nil "%g" diodePerimeter))
	     )
	     cdfId->perim->value = diodePerimeter
	    )
	    ;; if working with expressions
	    (t
	     (when (numberp diodeWidth)
		 (setq diodeWidth (sprintf nil "%g" diodeWidth)))
	     (when (numberp diodeLength)
		 (setq diodeLength (sprintf nil "%g" diodeLength)))
	     (setq diodeArea (sprintf nil "((%s)*(%s))"
				      diodeWidth diodeLength))
	     (setq diodePerimeter (sprintf nil "(2*((%s)+(%s)))"
					   diodeWidth diodeLength))
	     (cond
		 ((nequal "string" cdfId->area->paramType)
		  (warn "Capbn CDF type screwup\n")
		 )
		 (t cdfId->area->value = diodeArea)
	     )
	     (cond
		 ((nequal "string" cdfId->perim->paramType)
		  (warn "Capbn CDF type screwup\n")
		 )
		 (t cdfId->perim->value = diodePerimeter)
	     )
	    )
	)
	cdfId->model->value = (TECHgetDeviceParam
			       (TECHgetDevice ?name (or diodeName 'bndiode))
			       'hspiceModel
			       )
    )
)

;;; 
;;; CDFsetModSubckt --
;;; 
;;; Input: cdfId   - the cdfId of the device
;;;        devname - string with the cell name of the device
;;; Output: 
;;; Globals: 
;;; Side Effects: sets the isSubckt cdf parameter based on cellname passed
;;;               and device declaration
;;; Return: 
;;;
;;; Algorithm:
;;; Finds the device name associated with the hspice model currently selected
;;; on the cell name passed as an argument, and uses the isSubckt paramter of that
;;; device to set the isSubckt cdf property.  Written for cppc element, but
;;; should be general enough for other elements with a ctype parameter.
;;;
(defun CDFsetModSubckt (cdfId devname "ot")
    (let (capName isSubckt)
      (foreach cap (TECHgetDevice ?cellName devname)
	       (when
		   (equal
		    (TECHgetDeviceParam cap 'hspiceModel)
		    cdfId->ctype->value
		    )
		 (setq capName   (TECHgetDeviceParam cap 'name))
	       )
      )

      cdfId->isSubckt->value = (TECHgetDeviceParam (TECHgetDevice ?name capName) 'isSubckt)
    )
)

;;; 
;;; CDFderiveAreaAndPerim --
;;;   This is the width and length field callback for a transistor.
;;; Check the minimum gate width and length if that check is enabled.
;;;   Also, for drain only topography transistors, it will calculate the
;;; area and perimiter properties "area" and "perim" for LVS.
;;;
;;; Input: cdfId - the cdfId of the transistor
;;; Output: 
;;; Globals: 
;;; Side Effects: For "drainOnly" topography transistors, it will update
;;;               the "area" and "perim" properties if derivAP is true
;;; Return: 
;;; 
(defun CDFderiveAreaAndPerim (cdfId)
    ;; for those who need training wheels, sanity check the minimum
    ;; device size
    (when (ENVgetVal "schematic" "checkFetMinSize")
	(let (fetDevice minWidth minLength adjustSize)

	    (setq fetDevice (CDFfetGetFetDevice cdfId->id->name))

	    ;; get the minimum gate width and length
	    (setq minWidth (TECHgetDeviceParam fetDevice 'minGateWidth))
	    (setq minLength (TECHgetDeviceParam fetDevice 'minGateLength))

	    (when (and minWidth (floatp minWidth))
		(setq adjustSize nil)
		(cond
		    ((aelIsNumberP cdfId->w->value)
		     (when (lessp (aelNumber cdfId->w->value) minWidth)
			 (warn "Width (%L) is less than minimum (%L); increasing to minimum\n"
			       cdfId->w->value minWidth
			 )
			 (setq adjustSize t)
		     )
		    )
		    ((and (stringp cdfId->w->value)
			  (null (parseString cdfId->w->value " \t\n")))
		     (warn "Empty width is illegal; setting to minimum (%L)\n"
			   minWidth)
		     (setq adjustSize t)
		    )
		    ;; if it is an expression that is not directly a number,
		    ;; do nothing
		    (t nil)
		)
		(when adjustSize
		    (cond
			((equal "string" cdfId->w->paramType)
			 cdfId->w->value = (sprintf nil "%g" minWidth)
			)
			(t cdfId->w->value = minWidth)
		    )
		)
	    )
	    (when (and minLength (floatp minLength))
		(setq adjustSize nil)
		(cond
		    ((aelIsNumberP cdfId->l->value)
		     (when (lessp (aelNumber cdfId->l->value) minLength)
			 (warn "Length (%L) is less than minimum (%L); increasing to minimum\n"
			       cdfId->l->value minLength
			 )
			 (setq adjustSize t)
		     )
		    )
		    ((and (stringp cdfId->l->value)
			  (null (parseString cdfId->l->value " \t\n")))
		     (warn "Empty length is illegal; setting to minimum (%L)\n"
			   minLength)
		     (setq adjustSize t)
		    )
		    ;; if it is an expression that is not directly a number,
		    ;; do nothing
		    (t nil)
		)
		(when adjustSize
		    (cond
			((equal "string" cdfId->l->paramType)
			 cdfId->l->value = (sprintf nil "%g" minLength)
			)
			(t cdfId->l->value = minLength)
		    )
		)
	    )

	)
    )

    (case cdfId->topography->value
	("normal" t
	)
	("ring" t
	)
	("fieldless" t
	)
	("halfFieldless" t
	)
	("drainOnly"
	 (when (and cdfId->deriveAP->value
		    (nequal "FALSE" cdfId->deriveAP->value)
	       )
	     (let (w l area perim)
		 (setq w cdfId->w->value)
		 (setq l cdfId->l->value)
		 (when (and (stringp w) (aelIsNumberP w))
		     (setq w (aelNumber w))
		 )
		 (when (and (stringp l) (aelIsNumberP l))
		     (setq l (aelNumber l))
		 )
		 (cond
		     ((and (numberp w) (numberp l))
		      (setq area (times w l))
		      (setq perim (times 2.0 (plus w l)))
		     )
		     (t
		      (when (numberp w) (setq w (sprintf nil "%g" w)))
		      (when (numberp l) (setq l (sprintf nil "%g" l)))
		      (setq area (sprintf nil "((%s)*(%s))" w l))
		      (setq perim (sprintf nil "(2.0*((%s)+(%s)))" w l))
		     )
		 )
		 ;; store the area
		 (cond
		     ((equal "string" cdfId->area->paramType)
		      (when (numberp area) (setq area (sprintf nil "%g" area)))
		      cdfId->area->value = area
		     )
		     ((null (numberp area))
		      (warn "xtor CDF type screwup\n")
		     )
		     (t cdfId->area->value = area)
		 )
		 ;; store the perim
		 (cond
		     ((equal "string" cdfId->perim->paramType)
		      (when (numberp perim)
			  (setq perim (sprintf nil "%g" perim))
		      )
		      cdfId->perim->value = perim
		     )
		     ((null (numberp perim))
		      (warn "xtor CDF type screwup\n")
		     )
		     (t cdfId->perim->value = perim)
		 )
	     )
	 )
	)
	(t nil)
    )
)

;;; 
;;; CDFbuildNpnModelName --
;;; 
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFbuildNpnModelName (cdfgData "o")
    cdfgData->modelName->value = (sprintf nil "q%dc%db%de%fx%f"
					  cdfgData->numCollectors->value
					  cdfgData->baseLocation->value
					  cdfgData->numEmitters->value
					  cdfgData->emitterWidth->value
					  cdfgData->emitterLength->value)
)

;;; 
;;; CDFreverseNpnModelName --
;;; 
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFreverseNpnModelName (cdfId "o")
;    (let (nc bl ne ew el parsed)
;	(setq parsed (parseString cdfId->modelName->value "qcbex"))
	;; this could get real recursive real fast.
	t
;    )
)


;;; 
;;; CDFupdateDiscreteFetWL --
;;; 
;;; Input: instance Id and CDF data
;;; Output: 
;;; Globals: None
;;; Side Effects: Update the discrete width/length CDF parameters if W/L are valid choices
;;;               Print warnings if W/L values are not valid choices
;;; Return: 
;;; 
(defun CDFupdateDiscreteFetWL (instCDF instId)
  (let ( 
	(widthChoices nil) (widthChoicesNumbers nil) 
	(widthIndex nil) (lengthChoices nil) (lengthChoicesNumbers nil)
	(lengthIndex nil) (Lparam nil) (Wparam nil) 
	(length (aelNumber instId~>l)) (width (aelNumber instId~>w))
	)

    (setq Lparam (strcat (concat instId~>hspiceModel "_l")))

    (setq lengthChoices (get (get instCDF Lparam) 'choices))
    (foreach Li lengthChoices
	     (setq lengthChoicesNumbers (cons (atof Li) lengthChoicesNumbers))
	     )
    (setq lengthChoicesNumbers (reverse lengthChoicesNumbers))
    (cond
     ((member length lengthChoicesNumbers)
      (setq lengthIndex (difference (length lengthChoicesNumbers) (length (member length lengthChoicesNumbers))))
      (putprop (get instCDF Lparam) (nth lengthIndex lengthChoices) 'value)
      (setq Wparam (strcat (concat Lparam lengthIndex "_w")))
      )
     (t
      (warn "Length value %L of instance %L is not a valid choice\n" instId~>l instId~>name)
      )
     )

    (when (member length lengthChoicesNumbers)
      (setq widthChoices (get (get instCDF Wparam) 'choices))
      (foreach Wi widthChoices
	       (setq widthChoicesNumbers (cons (atof Wi) widthChoicesNumbers))
	       )
      (setq widthChoicesNumbers (reverse widthChoicesNumbers))
    )
    (cond
     ((member width widthChoicesNumbers)
      (setq widthIndex (difference (length widthChoicesNumbers) (length (member width widthChoicesNumbers))))
      (putprop (get instCDF Wparam) (nth widthIndex widthChoices) 'value)
      )
     (t
      (warn "Width value %L of instance %L is not a valid choice\n" instId~>w instId~>name)
      )
     )
    )
)

;;; 
;;; CDFevalString --
;;;
;;; This function reads a string (converts to a list form), appends the args
;;; if any, and then evals the resultant list.  I wish I can find the Cadence
;;; function that does this for all of their callbacks but I had no luck.  This
;;; routine is breakable in many ways but it currently works as long as only
;;; the first form in the string is expected to be evaled.
;;;
;;; Input:
;;;  str     - A string or nil
;;;  rest    - arguments to a function name in str if str is a function name
;;; Side Effects:
;;;  Determined by the evaluation of the callback
;;; 
(procedure (CDFevalString str @rest args)
    (when (stringp str)
	;; This returns a list containing the contents of str
	(setq str (linereadstring str))
	(when (and str (dtpr str))
	    ;; str can be either a list containing a symbol, or a list
	    ;; containing a list which is a function symbol with
	    ;; arguments.
	    (when (dtpr (car str))
		(setq str (car str))
	    )
	    (eval (append str args))
	)
    )
)

;;; 
;;; CDFhitCallbacks --
;;;   This function will hit the CDF callbacks for all of the instances in
;;; a given cellview.
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFhitCallbacks (schDbid)
    (cond
	;; if it is a valid database object
	((and (dbobjectp schDbid) (dbValidP schDbid) schDbid~>mode)

	 (cond
	     ((equal "r" schDbid~>mode)
	      (warn "CDFhitCallbacks: cell is not writable, %L %L %L\n"
		    schDbid~>libName schDbid~>cellName schDbid~>viewName)
	     )
	     (t
	      ;; must have cdfgForm listed and set to nil, even though it is
	      ;; unused.  Some tech lib CDF callbacks require this.
	      (let (cdfgData cdfgForm)

		  ;; loop through all of the instance headers
		  (foreach instH schDbid~>instHeaders

		      ;; if there is at least one instance and it has a CDF
		      (when (and (car instH~>instances)
				 (setq cdfgData (cdfGetInstCDF (car instH~>instances))))

			  (foreach inst instH~>instances
			      ;; get the CDF info for this particular instance
			      (when (setq cdfgData (cdfGetInstCDF inst))
				  (CDFevalString cdfgData->formInitProc cdfgData)
				  (CDFevalString cdfgData->doneProc inst)
			      )
			  )
		      )
		  )
	      )
	     )
	 )
	)
	(t
	 (warn "CDFhitCallbacks: Invalid database object '%L' passed in; ignored\n" schDbid)
	 nil
	)
    )
)


;;; CDFfetgateresvalue --
;;;    This function is a callback to determine the gate resistance
;;;
(defun CDFfetgateresvalue ()
    (let (W L M RSP1)
	(if (nequal cdfgData->resType->value "custom")
	   then 
	    (setq W (atof cdfgData->w->value))
	    (setq L (atof cdfgData->l->value))
	    (setq M (atof cdfgData->m->value))
	    (setq RSP1 (TECHgetDeviceParam (TECHgetDevice ?name 'nfet) 'gateSheetRes))
	    (cond
		((equal cdfgData->resType->value "single")
		cdfgData->gateresValue->value = (sprintf nil "%g" RSP1*W/L/M/3))
		((equal cdfgData->resType->value "double")
		cdfgData->gateresValue->value = (sprintf nil "%g" RSP1*W/L/M/12))
	    )
	  )
    )
)

;;; 
;;; CDFconstantCcap2Callback --
;;;   This function calculates values given a constant C
;;; for the cap2 tech element.
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFconstantCcap2Callback (cdfgData "o")
  ;; copy a pile of this from CDFcapCallback
  ;; we can ignore checking for absolute cap as this callback
  ;; is only called when constant C is selected (hopefully)

  (let (capDevices thisCap subCkt ctype cw cm space capSpaceData capWidthData coupling temp
       width1 width2 space1 space2 capModel Ca Cc1 Cc2 Cf1 Cf2 Cc3 Cf3 Cc4 Cf4 linearCc linearCf
       scale localKswitch globalCoupling scale L)

    (setq capDevices (TECHgetCapDevices))
    (setq thisCap (car capDevices))

    ;; loop through all the caps looking for the one with this model
    (while (and thisCap
		(nequal cdfgData~>ctype~>value
			(TECHgetDeviceParam thisCap 'hspiceModel))
		)
      
      (setq thisCap (car capDevices))
      (setq capDevices (cdr capDevices))
      )

    (setq subCkt (TECHgetDeviceParam thisCap 'isSubckt))

    (when (and thisCap (not subCkt) (boundp 'TECHcapParams))
      ;; set the "space" properties if applicable
      (setq capSpaceData (CDFgetCapSpaceProps cdfgData thisCap))
      (setq capWidthData (CDFgetCapWidthProps cdfgData thisCap))

      (setq c              cdfgData~>c~>value)
      (setq width1         capWidthData->cw1)
      (setq width2         capWidthData->cw2)
      (setq ctype          cdfgData~>ctype~>value)
      (setq cw             (or cdfgData~>cw~>value capWidthData->cw))
      (setq cm             (or cdfgData~>cm~>value 1))
      (setq space          (or cdfgData~>space~>value capSpaceData->space))
      (setq space1         capSpaceData->capSpace1)
      (setq space2         capSpaceData->capSpace2)
      (setq coupling       (or cdfgData~>coupling~>value 1.0))

      ;; these parameters are the same across all rescap models
      ;; (if these eventually change bad things will happen)

      (setq localKswitch   "1")
      (setq globalCoupling "1")
      (setq scale          "1e-06")
      (setq capModel       thisCap->hspiceModel)

      ;; this part ripped out of hspice.il
      (cond
       (width1
	(setq temp (TECHcapParams[(list capModel space1 width1)]))
	(setq Ca (car temp))
	(setq Cc1 (cadr temp))
	(setq Cf1 (caddr temp))
	(when space2
	  (setq temp (TECHcapParams[(list capModel space2 width1)]))
	  (setq Cc2 (cadr temp))
	  (setq Cf2 (caddr temp))
	  )
	(when (and (null space2) width2)
	  (setq temp (TECHcapParams[(list capModel space1 width2)]))
	  (setq Cc2 (cadr temp))
	  (setq Cf2 (caddr temp))
	  )
	(when (and space2 width2)
	  (setq temp (TECHcapParams[(list capModel space1 width2)]))
	  (setq Cc3 (cadr temp))
	  (setq Cf3 (caddr temp))
	  (setq temp (TECHcapParams[(list capModel space2 width2)]))
	  (setq Cc4 (cadr temp))
	  (setq Cf4 (caddr temp))
	  )
	)
       ;; if we do not use width as a table lookup (only space)
       (t
	(setq temp (TECHcapParams[(list capModel space1)]))
	(setq Ca (car temp))
	(setq Cc1 (cadr temp))
	(setq Cf1 (caddr temp))
	(when space2
	  (setq temp (TECHcapparams[(list capModel space2)]))
	  (setq Cc2 (cadr temp))
	  (setq Cf2 (caddr temp))
	  )
	)
       )
      (foreach var '(Ca Cc1 Cf1 Cc2 Cf2 Cc3 Cf3 Cc4 Cf4 cw globalCoupling coupling localKswitch scale)
        (unless (or (stringp (eval var)) (null (eval var)))
	  (set var (sprintf nil "%L" (eval var)))
	  )
	)

      (cond
       ;; if there are 4 data points to do a 2D interpolation between
       ;; both width and space
       ;;
       (Cc4
	(setq linearCc
	      (CDFinterpolateS cw
			      width1
			      (CDFinterpolateS space space1 Cc1 space2 Cc2)
			      width2
			      (CDFinterpolateS space space1 Cc3 space2 Cc4)
			      )
	      )
	(setq linearCf
	      (CDFinterpolateS cw
			      width1
			      (CDFinterpolateS space space1 Cf1 space2 Cf2)
			      width2
			      (CDFinterpolateS space space1 Cf3 space2 Cf4)
			      )
	      )
	)
       ;; if there are 2 data points, and it is width based
       ((and Cc2 width2)
	(setq linearCc (CDFinterpolateS cw width1 Cc1 width2 Cc2))
	(setq linearCf (CDFinterpolateS cw width1 Cf1 width2 Cf2))
	)
       ;; if there are 2 data points, and it is space based
       ((and Cc2 space2)
	(setq linearCc (CDFinterpolateS space space1 Cc1 space2 Cc2))
	(setq linearCf (CDFinterpolateS space space1 Cf1 space2 Cf2))
	)
       ;; if it is an exact match on both width and space
       (t
	(setq linearCc Cc1)
	(setq linearCf Cf1)
	)
       )

      ;; solve for L
      (sprintf neighborFringeBuffer
	       "(%s * (%s * (%s + 1) / 2 + (2 - %s) * (1 - %s) / 2) * %s)"
	       globalCoupling
	       coupling
	       localKswitch
	       coupling
	       localKswitch
	       linearCc)
      (sprintf perimCapTemp
	       "(%s + %s)"
	       neighborFringeBuffer linearCf)
      (sprintf Lequation_top
	       "((%s / %s) - (2 * %s * %s * %s))"
	       c cm scale perimCapTemp cw)
      (sprintf Lequation_bottom
	       "((%s * %s * %s * %s) + (2 * %s * %s))"
	       cw scale scale Ca scale perimCapTemp)
      (sprintf Lequation
	       "(%s / %s)"
	       Lequation_top Lequation_bottom)
      (unless (errset (setq L (evalstring Lequation)))
	(setq L Lequation))
      (when (equal (type L) 'string)
	(sprintf L "%s" L)
	)
      (when (nequal (type L) 'string)
	(sprintf L "%L" L)
	)
      cdfgData~>cl~>value=L

      ;; end hspice.il section
      )

    (unless (boundp 'TECHcapParams)
      (info "Info: Rescap data missing or in wrong format. Constant C option not available\n")
      )

    (when subCkt
      (info "Info: Constant C option does not work for subcircuit model \"%s\"\n" thisCap->hspiceModel)
      cdfgData->isConstantC->value=nil
      )
    ) ;; let
  )


;;; 
;;; CDFgetCapSpaceProps --
;;; 
;;; Description: Returns cap space props for cap2 callback.
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFgetCapSpaceProps (cdfgData capDevice)
  (let
      (spaceVals
       prevSpace
       thisSpace
       targetSpace
       thisLayer
       returnVals
       )
    
    (setq returnVals (list nil))
    (setq spaceVals (TECHgetDeviceParam capDevice 'spacings))
    (setq thisLayer (TECHgetDeviceParam capDevice 'layers))
    (cond
     ;; if it is a triple layer cap, the main layer is the middle one
     ((equal 3 (length thisLayer))
      (setq thisLayer (cadr thisLayer))
      )
     ;; if it is a two layer cap, the main layer is the first one
     ((equal 2 (length thisLayer))
      (setq thisLayer (car thisLayer))
      )
     )
    (setq targetSpace
	  (or cdfgData~>space~>value (TECHgetRuleWith "minSpacing" thisLayer) 0.0))
    (when (and (stringp targetSpace) (aelIsNumberP targetSpace))
      (setq targetSpace (aelNumber targetSpace))
      )
    
    (when spaceVals
      ;; the spaceVals parameter should be sorted in increasing order.
      (setq thisSpace (car spaceVals))
      (setq spaceVals (cdr spaceVals))
      (while (and spaceVals
		  (greaterp targetSpace
			    (plus thisSpace 1e-5)))
	(setq prevSpace thisSpace)
	(setq thisSpace (car spaceVals))
	  (setq spaceVals (cdr spaceVals))
	  )
      (cond
       ;; 1. if this is > the last space value in the list, or
       ;; 2. if this is <= the first space value in the list, or
       ;; 3. if this is close enough to the current value in the list
       ;; use last space value it saw
       ((or (greaterp targetSpace thisSpace)
	    (null prevSpace)
	    (null (greaterp (abs (difference targetSpace thisSpace))
			    1e-5)))
	(setq returnVals (append returnVals (list 'capSpace1 thisSpace)))
	)
       ;; if this is between two spacing values
       (t
	(setq returnVals (append returnVals (list 'capSpace1 thisSpace 'capSpace2 prevSpace)))
	;; with two space values, it will use an equation and it is
	;; required to have the "space" property
	(unless cdfgData~>space~>value
	  (setq returnVals (append returnVals (list 'space targetSpace)))
	  )
	)
       )
      )
    returnVals
    )
  )

;;; 
;;; CDFgetCapWidthProps --
;;; 
;;; Description: Returns cap width props for cap2 callback.
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFgetCapWidthProps (cdfgData capDevice)
  (let
      (thisLayer
       widthVals
       prevWidth
       thisWidth
       targetWidth
       returnVals
       )
    
    (setq returnVals (list nil))
    (setq widthVals (TECHgetDeviceParam capDevice 'widths))
    (setq thisLayer (TECHgetDeviceParam capDevice 'layers))
    (cond
     ;; if it is a triple layer cap, the main layer is the middle one
     ((equal 3 (length thisLayer))
      (setq thisLayer (cadr thisLayer))
      )
     ;; if it is a two layer cap, the main layer is the first one
     ((equal 2 (length thisLayer))
      (setq thisLayer (car thisLayer))
      )
     )
    
    ;; unfortunately, they may have tried to optimize the width.  If they
    ;; did, the cw property is not a number, but a parameterized equation.
    ;; Just default to the more inaccurate min width if they tried that.
    ;; It will interpolate from the evaluated width in the spice sim.
    ;;
    (setq targetWidth cdfgData~>cw~>value)
    (when (and (stringp targetWidth) (aelIsNumberP targetWidth))
      (setq targetWidth (aelNumber targetWidth))
      )
    (when (or (null targetWidth) (stringp targetWidth))
      (setq targetWidth (or (TECHgetRuleWith "minWidth" thisLayer) 0.0))
      )
    
    (when widthVals
      ;; the widthVals parameter should be sorted in increasing order.
      (setq thisWidth (car widthVals))
      (setq widthVals (cdr widthVals))
      (while (and widthVals
		  (greaterp targetWidth
			    (plus thisWidth 1e-5)))
	(setq prevWidth thisWidth)
	(setq thisWidth (car widthVals))
	(setq widthVals (cdr widthVals))
	)
      
      (cond
       ;; 1. if this is > the last width value in the list, or
       ;; 2. if this is <= the first width value in the list, or
       ;; 3. if this is close enough to the current value in the list
       ;; use last width value it saw
       ((or (greaterp targetWidth thisWidth)
	    (null prevWidth)
	    (null (greaterp (abs (difference targetWidth thisWidth))
			    1e-5)))
	(setq returnVals (append returnVals (list 'cw1 thisWidth)))
	)
       ;; if this is between two spacing values
       (t
	(setq returnVals (append returnVals (list 'cw1 thisWidth 'cw2 prevWidth)))
	;; with two width values, it will use an equation and it is
	;; required to have the "width" property
	(unless cdfgData~>cw~>value
	  (setq returnVals (append returnVals (list 'cw targetWidth)))
	  )
	)
       )
      )
    returnVals
    )
  )

;;; 
;;; CDFinterpolateS --
;;;   This function will return a string equation of a linear interpolation.
;;;   Copied from hspice.il
;;;
;;; Input: xi - x axis point between x1 and x2 for which it should
;;;             interpolate a y value
;;;        x1 - x axis value of first point
;;;        y1 - y axis value of first point
;;;        x2 - x axis value of second point
;;;        y2 - y axis value of second point
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: string equation of interpolated value
;;; 
(defun CDFinterpolateS (xi x1 y1 x2 y2)

    ;; get everything as a string
    (foreach param '(xi x1 y1 x2 y2)
	(when (floatp (eval param))
	    (set param (sprintf nil "%g" (eval param)))
	)
    )
    (cond
	;; do not divide by 0
	((or (null x2) (equal x1 x2)) y1)

	(t
	 (sprintf nil "(%s + (%s - %s) * (%s - %s) / (%s - %s))"
		  y1
		  xi
		  x1
		  y2
		  y1
		  x2
		  x1
	 )
	)
    )
)



;;;
;;; res3Max
;;; This function checks the range of res3.

(procedure res3Max()
    (let ( length lengthF)
        (setq lengthF atof(cdfgData->rl->value))
        (setq length (cdfgData->rl->value))
        if( (lengthF < 0.35) then
            artError("Resistor length minimum is 0.35um. Snapped length to 0.35um.")
            length = "0.35"
        )
        if( (lengthF > 1000) then
            artError("Resistor length maximum is 1000um. Snapped length to 1000um.")
            length = "1000"
        )
        cdfgData->rl->value = length
    )
)



;;;
;;; resMax
;;; This function checks the range of res.

(procedure resMax()
    (let ( length lengthF widthF width resT)
        (setq lengthF atof(cdfgData->rl->value))
        (setq widthF atof(cdfgData->rw->value))
        (setq length (cdfgData->rl->value))
        (setq width (cdfgData->rw->value))
        (setq resT (cdfgData->resistorType->value))
        if(  (resT == "li1") then
            if( (widthF < 0.72) then
                artError("Resistor width minimum is 0.72um. Snapped width to 0.72um.")
                width = "0.72"
            )
            if( (widthF > 1000) then
                artError("Resistor width maximum is 1000um. Snapped width to 1000um.")
                width = "1000"
            )
            if( (lengthF < 0.29) then
                artError("Resistor length minimum is 0.29um. Snapped length to 0.29um.")
                length = "0.29"
            )
            if( (lengthF > 1000) then
                artError("Resistor length maximum is 1000um. Snapped length to 1000um.")
                length = "1000"
            )
        )
        if(  (resT == "poly") then
            if( (widthF < 0.33) then
                artError("Resistor width minimum is 0.33um. Snapped width to 0.33um.")
                width = "0.33"
            )
            if( (widthF > 1000) then
                artError("Resistor width maximum is 1000um. Snapped width to 1000um.")
                width = "1000"
            )
            if( (lengthF < 0.47) then
                artError("Resistor length minimum is 0.47um. Snapped length to 0.47um.")
                length = "0.47"
            )
            if( (lengthF > 1000) then
                artError("Resistor length maximum is 1000um. Snapped length to 1000um.")
                length = "1000"
            )
        )
        cdfgData->rl->value = length
        cdfgData->rw->value = width
    )
)



;;;
;;; resnpMax
;;; This function checks the range of resn and resp.

(procedure resnpMax()
    (let ( length lengthF widthF width)
        (setq lengthF atof(cdfgData->rl->value))
        (setq length (cdfgData->rl->value))
        (setq widthF atof(cdfgData->rw->value))
        (setq width (cdfgData->rw->value))
        if( (widthF < 0.15) then
            artError("Resistor width minimum is 0.15um. Snapped width to 0.15um.")
            width = "0.15"
        )
        if( (widthF > 1000) then
            artError("Resistor width maximum is 1000um. Snapped width to 1000um.")
            width = "1000"
        )
        if( (lengthF < 0.27) then
            artError("Resistor length minimum is 0.27um. Snapped length to 0.27um.")
            length = "0.27"
        )
        if( (lengthF > 1000) then
            artError("Resistor length maximum is 1000um. Snapped length to 1000um.")
            length = "1000"
        )
        cdfgData->rl->value = length
        cdfgData->rw->value = width
    )
)




;;;
;;; respwMax
;;; This function checks the range of respw.

(procedure respwMax()
    (let ( length lengthF)
        (setq lengthF atof(cdfgData->rl->value))
        (setq length (cdfgData->rl->value))
        if( (lengthF < 26.5) then
            artError("Resistor length minimum is 26.5um. Snapped length to 26.5um.")
            length = "26.5"
        )
        if( (lengthF > 1000) then
            artError("Resistor length maximum is 1000um. Snapped length to 1000um.")
            length = "1000"
        )
        cdfgData->rl->value = length
    )
)



;;;
;;; mfactorMiM
;;; This function calculates the MiM mfactor from the product of rows and columns. 

(procedure mfactorMiM()
    (let ( ro col )
        (setq ro  cdfgData->nrow->value)
        (setq col  cdfgData->ncol->value)

        cdfgData->cm->value = (sprintf nil "%d" ro*col) 
    )
)



;;; AsPsPdAdNr --
;;; This function calculates the area and perimeter of source and drain of an NFET and PFET using approximations for simulation of parasitics. It also calculates the number of squares.
(procedure AsPsPdAdNr(cellName "t")
  (let (cell width lengthS lengthD nf p even odd internal internalS internalD right leftS rightS rightD sourceExt drainExt sourceExtF drainExtF eso edo rcn rcp nc rsn rsp)
	(if (equal cdfgData->manualDiodes->value t)
    then
        (setq width atof(cdfgData->w->value))
        (setq nf atoi(cdfgData->m->value))
        p = 0.17 ;; LICON pitch on diffusion
        internal = 0.28
        rightS = 0
        rightD = 0
;;; Edge effects
;        (cond ((equal cdfgData->bodyContact->value "none")
            leftS = 0.265
            right = 0.265
;            )
;        ((equal cdfgData->bodyContact->value "leftDetached")
;            leftS = 0.195
;            right = 0.195
;            )
;        ((equal cdfgData->bodyContact->value "rightDetached")
;            leftS = 0.195
;            right = 0.195
;            )
;        ((equal cdfgData->bodyContact->value "leftAttached")
;            leftS = 0.26
;            right = 0.195
;            )
;        ((equal cdfgData->bodyContact->value "rightAttached")
;            leftS = 0.195
;            right = 0.26
;            )
;        )

        even = evenp(nf)
        odd = oddp(nf)
        if( even then 
            rightS=right
            internalD = (nf/2)
            internalS = (nf/2)-1
        )
        if( odd then
            rightD=right
            internalD = (nf-1)/2
            internalS = (nf-1)/2
        )

        nc = (floor width/(2*p))

        lengthS = leftS + internal*internalS + rightS
        lengthD = internal*internalD + rightD
        sourceExt = cdfgData->srcOffset->value
        sourceExtF = atof(cdfgData->srcOffset->value)
        eso = sourceExtF
        drainExt = cdfgData->drnOffset->value
        drainExtF = atof(cdfgData->drnOffset->value)
        edo = drainExtF
        
        (if (equal cellName "pfet")
        then
            (if (equal  cdfgData->hspiceModelMenu->value "pshort")
            then

                rsp = 197
                rcp = 600
            )
            (if (equal  cdfgData->hspiceModelMenu->value "phighvt")
            then

                rsp = 197
                rcp = 600
            )
            (if (equal  cdfgData->hspiceModelMenu->value "plowvt")
            then

                rsp = 197
                rcp = 600
            )
            (if (equal  cdfgData->hspiceModelMenu->value "phv")
            then

                rsp = 191
                rcp = 600
            )
            (if (equal  cdfgData->hspiceModelMenu->value "phvesd")
            then

                rsp = 191
                rcp = 600
            )

            cdfgData->nrs->value = (sprintf nil "%g" eso*rsp+rcp/nc)
            cdfgData->nrd->value = (sprintf nil "%g" edo*rsp+rcp/nc)
        )            

        (if (equal cellName "nfet")
        then
            (if (equal  cdfgData->hspiceModelMenu->value "nshort")
            then

                rsn = 120
                rcn = 182
            )
            (if (equal  cdfgData->hspiceModelMenu->value "nlowvt")
            then

                rsn = 120
                rcn = 182
            )
            (if (equal  cdfgData->hspiceModelMenu->value "nhv")
            then

                rsn = 114
                rcn = 182
            )
            (if (equal  cdfgData->hspiceModelMenu->value "nhvesd")
            then

                rsn = 114
                rcn = 182
            )
            (if (equal  cdfgData->hspiceModelMenu->value "nhvnative")
            then

                rsn = 114
                rcn = 182
            )
            (if (equal  cdfgData->hspiceModelMenu->value "ntvnative")
            then

                rsn = 114
                rcn = 182
            )
            (if (equal  cdfgData->hspiceModelMenu->value "nhvnativeesd")
            then

                rsn = 114
                rcn = 182
            )
            (if (equal  cdfgData->hspiceModelMenu->value "sonos_e")
            then

                rsn = 114
                rcn = 182
            )
            (if (equal  cdfgData->hspiceModelMenu->value "sonos_p")
            then

                rsn = 114
                rcn = 182
            )

        
            cdfgData->nrs->value = (sprintf nil "%g" eso*rsn+rcn/nc)
            cdfgData->nrd->value = (sprintf nil "%g" edo*rsn+rcn/nc)
        )            

        cdfgData->as->value = (sprintf nil "%g" lengthS*width)
        cdfgData->ps->value = (sprintf nil "%g" 2*(lengthS+width))
        cdfgData->ad->value = (sprintf nil "%g" lengthD*width)
        cdfgData->pd->value = (sprintf nil "%g" 2*(lengthD+width))
             
    )
  )
)
