;;; 
;;; $Id: CDFlabels.il 1 2018/01/29 21:02:55 GMT jszemiot Exp $
;;; 
;;; CDFlabels.il
;;; 
;;; Copyright (c) 2001 by Cypress Semiconductor
;;; 
;;; Date  : Feb 23, 2001
;;; Author: Gordon Carskadon/CAD (gtc)
;;; 
;;; Description:
;;;   As we move from NLPExpr displays on symbols to ILLabel displays,
;;; we need to define the functions that the ILLabels call.  This file
;;; defines those functions.
;;; 
;;;   There is heavy use of the global variable "ilInst" in these functions.
;;; This is a Cadence controlled variable defining the current instance to
;;; be displayed.
;;;
;;; Revision History:
;;;   gtc 03/09/01  initial release of just a subset of elements
;;;   gtc 03/16/01  first pass of all non-lvs'd elements
;;;   gtc 03/19/01  debugging Wavemaster back annotation
;;;   gtc 03/20/01  being less aggressive in sheet rev block insult
;;;   tkw 03/22/01  modified to give wm op font control
;;;   gtc 03/27/01  first pass of almost all tech lib elements
;;;   tkw 03/30/01  updated CDFwmOpBa for better font control
;;;   gtc 03/30/01  adding npn4/pnp4 back annotation in here, and NOT showing
;;;                 back annotation prop="not found" when data is not found
;;;   gtc 04/03/01  minor tweaks for npn4/pnp4 m-factor, and sheet out of date
;;;   gtc 04/06/01  adding a few more elements, and a few minor tweaks
;;;   gtc 04/09/01  xtor spice model will do a sanity check vs. techrep
;;;   tkw 04/10/01  better checking of values before use in CDFwmOpBa
;;;   gtc 04/11/01  added patch, pins, and titles
;;;   gtc 04/11/01  fixing asym logic for wlm chains
;;;   gtc 04/11/01  added nwcap
;;;   gtc 04/13/01  tweaking capbn_b display
;;;   gtc 05/14/01  more tweaks to capbn_b per additional frills
;;;   dxj 04/30/01  modifying nfet display (for tsmc25)
;;;   lpn 05/30/01  Changed the appearance of Symmetric nand and nor gates 
;;;                 for SPR 8892
;;;   gtc 05/25/01  correcting may sources CDFterm calls, and updating CDFterm
;;;                 for Antrim back annotation
;;;   gtc 06/22/01  first pass of actual Antrim opba support
;;;   gtc 06/28/01  bunch of additional Antrim opba support
;;;   gtc 07/10/01  more additional Antrim opba support
;;;   gtc 07/11/01  minor tweaks for CY sch display options
;;;   kgr 08/07/01  added cmimc to passive list
;;;   dxj 09/19/01  added code for d17ld-3 flow
;;;   gtc 11/08/01  adding nfetesd/pfetesd to be just like nfet/pfet
;;;   cry 01/24/02  update to npn4 for subckt model compatability
;;;   lpn 01/25/02  Added res3 element
;;;   gtc 02/21/02  Updated terminal display to call default "cdsTerm" function.
;;;                 This allows Antrim's own OPBA results to be displayed when
;;;                 the CY custom Antrim OPBA is not being used.
;;;   cry 02/21/02  added mtj (magnetic tunnel junction) element
;;;   gtc 02/25/02  Support for Antrim subckt port current display
;;;   gtc 03/05/02  Not showing duplicate w/l/m in stacked nfets/pfets in the
;;;                 logic gates.
;;;   gtc 03/27/02  cmimc and capbn_b updates
;;;   cry 03/28/02  updated fet labels for ltype (leakage type)
;;;   gtc 04/04/02  minor cmimc label update
;;;   gtc 04/04/02  support for wmvp with Antrim OPBA
;;;   gtc 04/12/02  batm also works with Spectre OPBA
;;;   gtc 05/03/02  removed lsim param displays
;;;   gtc 05/10/02  Updates to show/hide L of xtors and logic gates based on
;;;                 whether it is the current technology's default L
;;;   kgr 05/31/02  Added cmim3c and ind3
;;;   gtc 06/14/02  fixed cmimc/cmim3c back annotation
;;;   kgr 06/19/02  Added ind4 and updated ind3
;;;   gtc 06/27/02  showing Antrim disciplines on ipin/opin/iopin
;;;   gtc 10/10/02  fixed 2* around pfets, not nfets, for nor2s_p
;;;   gtc 10/11/02  showed "open" around parasitic res that are opens.
;;;   dxj 10/16/02  added moscap to capbn_b display
;;;   gtc 11/15/02  removed old optimization displays
;;;   gtc 12/17/02  added typ/high/low resistance display options
;;;   gtc 01/16/03  added res3 dynamic resistance display support
;;;   gtc 01/21/03  added a "changed" label to resistors if the r is different
;;;                 from what it was when the R-driven resistor was placed
;;;   cva 09/03/03  added resnw resistor
;;;   gtc 04/09/04  cap updates for rescaps
;;;   sti 06/02/04  added mtj5 (magnetic tunnel junction) 5 term element
;;;   gtc 07/30/04  Adjusting significant digits when using Cadence cdsTerm
;;;   sti 08/04/04  added CDFcap_int3Labels
;;;   gtc 08/05/04  fixing CDFwlmChain
;;;   sti 09/10/04  changed CDFcap_int3Labels
;;;   pvn 10/18/04  Added gres3 labels display
;;;   adj 10/30/04  Added ifour, vfour, and sstprobe labels display
;;;   adj 11/05/04  Added imodsst, vmodsst, iphnoise, and vphnoise labels display
;;;   pvn 11/12/04  Tweaked capbn_b display
;;;   gtc 12/01/04  fixing manual diode method display of fets
;;;   cva 03/09/05  adding isHV diff resistors
;;;   dxj 05/26/05  Display dnwell prop (SPR 23534)
;;;   vun 07/21/05  Added refCell and memCell.  Updated display for HV res
;;;   bae 08/24/05  Added ntvNative, ESD and nlowVt
;;;   bae 09/23/05  Added deepNwell to the pfet
;;;   bub 10/14/05  added labels to new element condiode
;;;   bae 10/19/05  added highVt to the pfet and modified CDFwlm (SPR 27869)
;;;   bae 01/12/06  added nfetextd/pfetextd to use CDFnfetLabels/CDFpfetLabels respectively
;;;   xba 01/12/06  added vfoursst, ifoursst. Modified vfour, ifour and imodsst. 
;;;   osd 02/03/06  updated label for plowvt
;;;   xba 01/31/06  added elo RF elemnt labels. 
;;;   bae 05/11/06  modified CDFnfetLabels/CDFpfetLabels/CDFspiceModel to 
;;;                 display spice model name rather than properties
;;;                 Removed CDFvtype CDFttype CDFltype CDFnlowVt CDFplowVt 
;;;                 CDFhighVt CDFpullType CDFarray
;;;   kuc 04/03/07  added labels for condiode simulatable version
;;;   cva 06/01/07  condiode on grid
;;;   cry 06/04/07  added LOD/WPE support to fets
;;;   cry 10/16/07  added comp and compd
;;;   cry 10/24/07  updated icecap to designate when doing layout values
;;;   cry 11/05/07  added sd to CDFmanualLOD
;;;   cry 11/07/07  updated layout icecap display as per code review
;;;   kuc 01/22/08  added LOD/diode parameter size labels, mult
;;;   kuc 01/24/08  added deltaL to CDFdisplayCalculateR
;;;   bae 03/25/08  added CDFlvtransLabels
;;;   kuc 03/28/08  updated mult display
;;;   osd 04/17/08  added vppcap
;;;   ipr 06/24/08  fixed inverted CDFlabels for cmim3c (SPR 45080)
;;;   ipr 01/28/10  added CDFloc 133 for displaying no noise labels SPR 61318
;;;   cva 09/09/10  added LOD for extDrain devices
;;;   vun 07/11/12  updated message for condiode SPR 80139
;;;   dlr 12/11/13  SPR 85882: pvhv and nvhv devices were missing
;;;                   Also needed to specify "M" on ANTdevOpba for fet for subckt based instances
;;;

(putpropqq CDFlabels "$Id: CDFlabels.il 1 2018/01/29 21:02:55 GMT jszemiot Exp $" SCCS)


;;;
;;; Font size control
;;;
(setq CY_OP_FontSizeLst (list "0.0625" "0.04375" "0.03125"))
(unless (boundp 'CY_OP_FontSizeStr)
  (setq CY_OP_FontSizeStr (caddr CY_OP_FontSizeLst)))
(unless (boundp 'CY_OPV_FontSizeStr)
  (setq CY_OPV_FontSizeStr (caddr CY_OP_FontSizeLst)))
(unless (boundp 'CY_OPPV_FontSizeStr)
  (setq CY_OPPV_FontSizeStr (cadr CY_OP_FontSizeLst)))

;; initialize values for LOD/Diode labels
(unless (boundp 'SCHfontSet)
  (when (null (ENVgetVal "schematic" "LODFontSize"))
    (ENVsetVal "schematic" "LODFontSize" "string" "large")
    )
  (when (null (ENVgetVal "schematic" "diodeFontSize"))
    (ENVsetVal "schematic" "diodeFontSize" "string" "large")
    )
  (when (null (ENVgetVal "schematic" "symbolicLOD"))
    (ENVsetVal "schematic" "symbolicLOD" "string" "symbolic")
    )
  (setq SCHfontSet t)
  )

;;; 
;;; CDFloc --
;;;   This is a CY function similar to the cdsParam function that Cadence
;;; provides.  However, there are somethings that we have to do that Cadence
;;; cannot do by default:
;;;   1.  Display both parameters and back annotated data at the same time
;;;   2.  We want to do things more sophisticated than have a list of the
;;;       parameters to display.  For example, we want w, l, & m on one line.
;;;
;;; Input: an integer
;;; Output: 
;;; Globals: ilInst (current instance for display)
;;; Side Effects: 
;;; Return: string of what should be displayed for this label
;;; 
(defun CDFloc (num "x")
    (let (cellName tmpVal1 tmpVal2 tmpVal3 isSubckt s)
	(setq cellName ilInst~>master~>cellName)

	(cond
	    ;; global catch all to hide everything
	    ((ENVgetVal "schematic" "hideEverything")
	     ""
	    )

	    ;; begin sheets
	    ;;
	    ((member cellName '("Asize" "Bsize" "Csize" "Dsize" "Esize"))
	     (case num
		 ;; icecap disable box
		 (1 (or ilInst~>icecapDisable ""))

		 ;; revBlock
		 ;;
		 ;; locations 2, 13, and 14 directly overlap each other.
		 ;; 2 is used for a normal up to date extraction
		 ;; 13 is used for an out of date extraction
		 ;; 14 is used when they used Cadence's extraction instead
		 ;;    of CY's schxtr
		 ;;
		 (2
		  (setq tmpVal1 ilInst~>schlastSchematicExtraction)
		  (setq tmpVal2 ilInst~>cellView~>SCHlastSchematicExtraction)
		  (setq tmpVal3 ilInst~>cellView~>lastSchematicExtraction)
		  (cond
		      ;; if lastSchematicExtraction does not exist, it is
		      ;; simply not extracted
		      ((null tmpVal3) "")

		      ;; if it was extracted a long time ago, it does not
		      ;; have the CY schxtr prop of SCHlastSchematicExtraction,
		      ;; display it if it is up to date
		      ((null tmpVal2)
		       (cond
			   ((equal (or tmpVal1 tmpVal3)
				   ilInst~>cellView~>instancesLastChanged)
			    (or tmpVal1 tmpVal2)
			   )
			   (t "")
		       )
		      )

		      ;; if they ran the Cadence Check & Save instead of the
		      ;; CY extraction.  Give them a 3 second buffer due to
		      ;; an old bug in the way it created SCHlastSchematiExt.
		      ((greaterp (compareTime tmpVal3 tmpVal2) 3)
		       ""
		      )

		      ;; Otherwise, only display it when it is up to date
		      ((null (plusp (compareTime
				     ilInst~>cellView~>instancesLastChanged
				     tmpVal3)))
		       tmpVal3
		      )
		  )
		 )
		 (13
		  (setq tmpVal1 ilInst~>cellView~>lastSchematicExtraction)
		  (setq tmpVal2 ilInst~>cellView~>instancesLastChanged)
		  (cond
		      ((null tmpVal1) "not extracted")
		      ((and tmpVal1 tmpVal2
			    (plusp (compareTime tmpVal2 tmpVal1))
		       )
		       "out of date"
		      )
		      (t "")
		  )
		 )
		 (14
		  (setq tmpVal1 ilInst~>cellView~>SCHlastSchematicExtraction)
		  (setq tmpVal2 ilInst~>cellView~>lastSchematicExtraction)
		  (setq tmpVal3 ilInst~>cellView~>instancesLastChanged)
		  (cond
		      ;; if it is out of date, do nothing
		      ((or (null tmpVal2)
			   (plusp (compareTime tmpVal3 tmpVal2)))
		       ""
		      )

		      ;; if SCHlastSchematicExtraction is not up to date,
		      ;; they cheated and used Cadence's check and save.
		      ;; give them a 3 second buffer due to an old bug in the
		      ;; way that it crated SCHlastSchematicExtraction
		      ((and tmpVal1 tmpVal2
			    ;; give them a 2 second fudge factor
			    (greaterp (compareTime tmpVal2 tmpVal1) 3)
		       )
		       "Please use CY schxtr"
		      )
		      ;; otherwise, do nothing
		      (t "")
		  )
		 )
		 (3 (or ilInst~>cellView~>instancesLastChanged ""))
		 (4 (or ilInst~>schfullPathName ""))

		 ;; diode disable box
		 (5 (or ilInst~>diodeDisable ""))

		 ;; contBlock
		 (6 (or (substring cellName 1 1) ""))
		 (7 (or ilInst~>schblockName ""))
		 (8 (or ilInst~>figureNumber) "")
		 (9 (CDFgetRev))
		 (10 (or (and (floatp ilInst~>schiceCapScale)
			      (sprintf nil "%g" ilInst~>schiceCapScale))
			 ""))
		 (11 (or ilInst~>engineer ""))
		 (12
		  (setq tmpVal1 (or ilInst~>sheetNumber ""))
		  (when (integerp tmpVal1)
		      (setq tmpVal1 (sprintf nil "%d" tmpVal1))
		  )
		  (when (nequal "" tmpVal1)
		      (setq tmpVal2 (or ilInst~>maxSheets ""))
		      (when (integerp tmpVal2)
			  (setq tmpVal2 (sprintf nil "%d" tmpVal2))
		      )
		      (when (nequal "" tmpVal2)
			  (setq tmpVal1 (strcat tmpVal1 " OF " tmpVal2))
		      )
		  )
		  tmpVal1
		 )
		 ;; Antrim simulation back annotation for sheets, one
		 ;; in each corner
		 (20 (ANTgeneralDisplayInCorner "ul"))
		 (21 (ANTgeneralDisplayInCorner "ll"))
		 (22 (ANTgeneralDisplayInCorner "ur"))
		 (23 (ANTgeneralDisplayInCorner "lr"))
	     )
	    )
	    ;; end sheets

	    ;; begin sources
	    ;;
	    ((equal cellName "bcs")
	     (case num
		 (1 (CDFname))
		 (2 (strcat "I=" ilInst~>cur))
		 (3  (ANTdevOpba 'large))
		 (31 (ANTdevOpba 'medium))
		 (32 (ANTdevOpba 'small))
		 (4 (CDFterm "PLUS" ":i"))
		 (5 (CDFterm "MINUS"))
	     )
	    )
	    ((equal cellName "bvs")
	     (case num
		 (1 (CDFname))
		 (2 (strcat "V=" ilInst~>vol))
		 (3  (ANTdevOpba 'large))
		 (31 (ANTdevOpba 'medium))
		 (32 (ANTdevOpba 'small))
		 (4 (CDFterm "PLUS" ":i"))
		 (5 (CDFterm "MINUS"))
	     )
	    )
	    ((equal cellName "iac")
	     (case num
		 (1 (CDFname))
		 (2 (when ilInst~>acmE != "" 
			(strcat "acmag = " ilInst~>acmE))
		 )
		 (3 (when ilInst~>acp != "" 
			(strcat "acphase = " ilInst~>acp))
		 )
		 (4  (ANTdevOpba 'large))
		 (41 (ANTdevOpba 'medium))
		 (42 (ANTdevOpba 'small))
		 (5 (CDFterm "PLUS" ":i"))
		 (6 (CDFterm "MINUS"))
	     )
	    )
	    ((equal cellName "icis")
	     (case num
		 (1 (CDFname))
		 (2 (CDFicisValue))
		 (3 (CDFiter))
		 (4  (ANTdevOpba 'large))
		 (41 (ANTdevOpba 'medium))
		 (42 (ANTdevOpba 'small))
		 (9 (CDFterm "NM" ":i"))
		 (10 (CDFterm "NP"))
	     )
	    )
	    ((equal cellName "icvs")
	     (case num
		 (1 (CDFname))
		 (2 (CDFicvsValue))
		 (3 (CDFiter))
		 (4  (ANTdevOpba 'large))
		 (41 (ANTdevOpba 'medium))
		 (42 (ANTdevOpba 'small))
		 (9 (CDFterm "NP" ":i"))
		 (10 (CDFterm "NM"))
	     )
	    )
	    ((equal cellName "ipulse")
	     (case num
		 (1 (CDFname))
		 (2 (strcat "v1=" (AELgetStringProp ilInst 'v1)))
		 (3 (strcat "v2=" (AELgetStringProp ilInst 'v2)))
		 (4 (strcat "per=" (AELgetStringProp ilInst 'per)))
		 (5  (ANTdevOpba 'large))
		 (51 (ANTdevOpba 'medium))
		 (52 (ANTdevOpba 'small))
		 (7 (CDFterm "plus" ":i"))
		 (8 (CDFterm "minus"))
	     )
	    )
	    ((or (equal cellName "isrc") (equal cellName "inoise") (equal cellName "ipattern"))
	     (case num
		 (1 (CDFname))
		 (2 (when ilInst~>acmE != "" 
			(strcat "acmag = " ilInst~>acmE))
		 )
		 (3 (when ilInst~>acp != "" 
			(strcat "acphase = " ilInst~>acp))
		 )
		 (4 (when ilInst~>idc != "" 
			(strcat "dc = " ilInst~>idc))
		 )
		 (5  (ANTdevOpba 'large))
		 (51 (ANTdevOpba 'medium))
		 (52 (ANTdevOpba 'small))
		 (6 (CDFterm "PLUS" ":i"))
		 (7 (CDFterm "MINUS"))
	     )
	    )
	    ((equal cellName "soi")
	     (case num
		 (1 (CDFname))
		 (2 (CDFdcValue))
		 (3 (CDFacValuePhase))
		 (4 (CDFiter))
		 (5  (ANTdevOpba 'large))
		 (51 (ANTdevOpba 'medium))
		 (52 (ANTdevOpba 'small))
		 (9 (CDFterm "NP" ":i"))
		 (10 (CDFterm "NM"))
	     )
	    )
	    ((equal cellName "sov")
	     (case num
		 (1 (CDFname))
		 (2 (CDFdcValue))
		 (3 (CDFacValuePhase))
		 (4 (CDFiter))
		 (5  (ANTdevOpba 'large))
		 (51 (ANTdevOpba 'medium))
		 (52 (ANTdevOpba 'small))
		 (7 (CDFterm "NP" ":i"))
		 (8 (CDFterm "NM"))
	     )
	    )
	    ((equal cellName "vac")
	     (case num
		 (1 (CDFname))
		 (2 (when ilInst~>acmE != "" 
			(strcat "acmag = " ilInst~>acmE))
		 )
		 (3 (when ilInst~>acp != "" 
			(strcat "acphase = " ilInst~>acp))
		 )
		 (4  (ANTdevOpba 'large))
		 (41 (ANTdevOpba 'medium))
		 (42 (ANTdevOpba 'small))
		 (5 (CDFterm "PLUS" ":i"))
		 (6 (CDFterm "MINUS"))
	     )
	    )
	    ((equal cellName "vcis")
	     (case num
		 (1 (CDFname))
		 (2 (CDFourGain))
		 (3 (CDFiter))
		 (4  (ANTdevOpba 'large))
		 (41 (ANTdevOpba 'medium))
		 (42 (ANTdevOpba 'small))
		 (9 (CDFterm "NP" ":i"))
		 (10 (CDFterm "NM"))
		 (11 (CDFterm "NCP"))
		 (12 (CDFterm "NCM"))
	     )
	    )
	    ((equal cellName "vcvs")
	     (case num
		 (1 (CDFname))
		 (2 (CDFourGain))
		 (3 (CDFiter))
		 (4  (ANTdevOpba 'large))
		 (41 (ANTdevOpba 'medium))
		 (42 (ANTdevOpba 'small))
		 (9 (CDFterm "NP" ":i"))
		 (10 (CDFterm "NM"))
		 (11 (CDFterm "NCP"))
		 (12 (CDFterm "NCM"))
	     )
	    )
	    ((or (equal cellName "vsrc") (equal cellName "vnoise") (equal cellName "vpattern"))
	     (case num
		 (1 (CDFname))
		 (2 (when ilInst~>acmE != "" 
			(strcat "acmag = " ilInst~>acmE))
		 )
		 (3 (when ilInst~>acp != "" 
			(strcat "acphase = " ilInst~>acp))
		 )
		 (4 (when ilInst~>vdc != "" 
			(strcat "dc = " ilInst~>vdc))
		 )
		 (5  (ANTdevOpba 'large))
		 (51 (ANTdevOpba 'medium))
		 (52 (ANTdevOpba 'small))
		 (6 (CDFterm "PLUS" ":i"))
		 (7 (CDFterm "MINUS"))
	     )
	    )
	    ;; end vanilla sources

	    ;; begin analog elements
	    ;;
	    ((equal cellName "atod")
	     (case num
		 (1 (CDFname))
		 (2 (strcat "vl=" (or (AELgetStringProp ilInst 'vl) "")))
		 (3 (strcat "vh=" (or (AELgetStringProp ilInst 'vh) "")))
		 (4 (strcat "tx=" (or (AELgetStringProp ilInst 'tx) "")))
		 (5 (strcat "td=" (or (AELgetStringProp ilInst 'td) "")))
		 (6 (CDFterm "A"))
		 (7 (CDFterm "D"))
	     )
	    )
	    ((equal cellName "dtoa")
	     (case num
		 (1 (CDFname))
		 (2 (strcat "v0=" (or (AELgetStringProp ilInst 'v0) "")))
		 (3 (strcat "v1=" (or (AELgetStringProp ilInst 'v1) "")))
		 (4 (strcat "vx=" (or (AELgetStringProp ilInst 'vx) "")))
		 (5 (strcat "vz=" (or (AELgetStringProp ilInst 'vz) "")))
		 (6 (strcat "tr=" (or (AELgetStringProp ilInst 'tr) "")))
		 (7 (strcat "tf=" (or (AELgetStringProp ilInst 'tf) "")))
		 (8 (strcat "td=" (or (AELgetStringProp ilInst 'td) "")))
		 (9 (CDFterm "D"))
		 (10 (CDFterm "A"))
	     )
	    )
	    ((equal cellName "cccsF")
	     (case num
		 (1 (CDFname))
		 (2 (CDFvn1))
		 (3 (CDFgain))
		 (4 (CDFic))
		 (5  (ANTdevOpba 'large))
		 (51 (ANTdevOpba 'medium))
		 (52 (ANTdevOpba 'small))
		 (10 (CDFterm "plus" ":i"))
		 (11 (CDFterm "minus"))
	     )
	    )
	    ((equal cellName "ccvsH")
	     (case num
		 (1 (CDFname))
		 (2 (CDFvn1))
		 (3 (strcat "transres="
			    (AELgetStringProp ilInst 'transresistance))
		 )
		 (4 (CDFic))
		 (5  (ANTdevOpba 'large))
		 (51 (ANTdevOpba 'medium))
		 (52 (ANTdevOpba 'small))
		 (10 (CDFterm "plus" ":i"))
		 (11 (CDFterm "minus"))
	     )
	    )
	    ((equal cellName "incon")
	     (case num
		 (1 (strcat "ic=" (or (AELgetStringProp ilInst 'ic) "Undef")))
	     )
	    )
	    ((equal cellName "vam")
	     (case num
		 (1 (CDFname))
		 (2 (strcat "sa=" (AELgetStringProp ilInst 'sa)))
		 (3 (strcat "fc=" (AELgetStringProp ilInst 'fc)))
		 (4 (strcat "fm=" (AELgetStringProp ilInst 'fm)))
		 (5  (ANTdevOpba 'large))
		 (51 (ANTdevOpba 'medium))
		 (52 (ANTdevOpba 'small))
		 (7 (CDFterm "plus" ":i"))
		 (8 (CDFterm "minus"))
	     )
	    )
	    ((equal cellName "vccsG")
	     (case num
		 (1 (CDFname))
		 (2 (strcat "ggain=" (AELgetStringProp ilInst 'ggain)))
		 (3 (CDFic))
		 (4  (ANTdevOpba 'large))
		 (41 (ANTdevOpba 'medium))
		 (42 (ANTdevOpba 'small))
		 (9 (CDFterm "plus" ":i"))
		 (10 (CDFterm "minus"))
		 (11 (CDFterm "ncplus"))
		 (12 (CDFterm "ncminus"))
	     )
	    )
	    ((equal cellName "vcvsE")
	     (case num
		 (1 (CDFname))
		 (2 (CDFgain))
		 (3 (CDFic))
		 (4  (ANTdevOpba 'large))
		 (41 (ANTdevOpba 'medium))
		 (42 (ANTdevOpba 'small))
		 (9 (CDFterm "plus" ":i"))
		 (10 (CDFterm "minus"))
		 (11 (CDFterm "ncplus"))
		 (12 (CDFterm "ncminus"))
	     )
	    )
	    ((equal cellName "vexp")
	     (case num
		 (1 (CDFname))
		 (2 (strcat "v1=" (AELgetStringProp ilInst 'v1)))
		 (3 (strcat "v2=" (AELgetStringProp ilInst 'v2)))
		 (4 (strcat "td1=" (AELgetStringProp ilInst 'td1)))
		 (5  (ANTdevOpba 'large))
		 (51 (ANTdevOpba 'medium))
		 (52 (ANTdevOpba 'small))
		 (7 (CDFterm "plus" ":i"))
		 (8 (CDFterm "minus"))
	     )
	    )
	    ((equal cellName "vpulse")
	     (case num
		 (1 (CDFname))
		 (2 (strcat "v1=" (AELgetStringProp ilInst 'v1)))
		 (3 (strcat "v2=" (AELgetStringProp ilInst 'v2)))
		 (4 (strcat "per=" (AELgetStringProp ilInst 'per)))
		 (5  (ANTdevOpba 'large))
		 (51 (ANTdevOpba 'medium))
		 (52 (ANTdevOpba 'small))
		 (7 (CDFterm "plus" ":i"))
		 (8 (CDFterm "minus"))
	     )
	    )
	    ((equal cellName "vpwl")
	     (case num
		 (1 (CDFname))
		 (2 (strcat "t1=" (AELgetStringProp ilInst 't1)))
		 (3 (strcat "v1=" (AELgetStringProp ilInst 'v1)))
		 (4 (strcat "tvpairs=" (AELgetStringProp ilInst 'tvpairs)))
		 (5  (ANTdevOpba 'large))
		 (51 (ANTdevOpba 'medium))
		 (52 (ANTdevOpba 'small))
		 (7 (CDFterm "plus" ":i"))
		 (8 (CDFterm "minus"))
	     )
	    )
	    ((equal cellName "vpwlf")
	     (case num
		 (1 (CDFname))
		 (2 (strcat "file=" (AELgetStringProp ilInst 'file)))
		 (3 
		  (setq tmpVal1 (AELgetStringProp ilInst 'r))
		  (cond
		      ((and tmpVal1 (nequal tmpVal1 "0"))
		       (strcat "r=" tmpVal1)
		      )
		      (t "")
		  )
		 )
		 (4
		  (setq tmpVal1 (AELgetStringProp ilInst 'Td))
		  (cond
		      ((and tmpVal1 (nequal tmpVal1 "0"))
		       (strcat "Td=" tmpVal1)
		      )
		      (t "")
		  )
		 )
		 (5
		  (setq tmpVal1 (AELgetStringProp ilInst 'm))
		  (cond
		      ((and tmpVal1 (nequal tmpVal1 "1"))
		       (strcat "m=" tmpVal1)
		      )
		      (t "")
		  )
		 )
		 (6  (ANTdevOpba 'large))
		 (61 (ANTdevOpba 'medium))
		 (62 (ANTdevOpba 'small))
		 (8 (CDFterm "plus" ":i"))
		 (9 (CDFterm "minus"))
	     )
	    )
	    ((equal cellName "vsffm")
	     (case num
		 (1 (CDFname))
		 (2 (strcat "vo=" (AELgetStringProp ilInst 'vo)))
		 (3 (strcat "va=" (AELgetStringProp ilInst 'va)))
		 (4 (strcat "fc=" (AELgetStringProp ilInst 'fc)))
		 (5  (ANTdevOpba 'large))
		 (51 (ANTdevOpba 'medium))
		 (52 (ANTdevOpba 'small))
		 (7 (CDFterm "plus" ":i"))
		 (8 (CDFterm "minus"))
	     )
	    )
	    ((equal cellName "vsin")
	     (case num
		 (1 (CDFname))
		 (2 (strcat "vo=" (AELgetStringProp ilInst 'vo)))
		 (3 (strcat "va=" (AELgetStringProp ilInst 'va)))
		 (4 (strcat "freq=" (AELgetStringProp ilInst 'freq)))
		 (5  (ANTdevOpba 'large))
		 (51 (ANTdevOpba 'medium))
		 (52 (ANTdevOpba 'small))
		 (7 (CDFterm "plus" ":i"))
		 (8 (CDFterm "minus"))
	     )
	    )
	    ;; end of the analog sources

	    ;; begin EldoRF elements
	    ;;
	    ((equal cellName "jtran")
	     (case num
		 (1 (CDFname))
		 (2 (strcat "ratio = " ilInst~>aE))
		 (3 (CDFterm "n1"))
		 (4 (CDFterm "n2"))
		 (5 (CDFterm "n3"))
		 (6 (CDFterm "n4"))
	     )
	    )
	    ((member cellName '("lvtrans2" "lvtrans3" "lvtrans4"))
	     (CDFlvtransLabels cellName num)
	    )
	    ((equal cellName "mtee")
	     (case num
		 (1 (CDFname))
		 (2 (setq s "")
		  (when ilInst~>ms_w1 != "" 
		      (sprintf s "%sW1=%s " s ilInst~>ms_w1))
		  (when ilInst~>ms_w2 != "" 
		      (sprintf s "%sW2=%s " s ilInst~>ms_w2))
		  (when ilInst~>ms_w3 != "" 
		      (sprintf s "%sW3=%s " s ilInst~>ms_w3))
		  (sprintf nil "%s" s)
		 )
		 (3 (when ilInst~>ms_t != "" 
			(strcat "T = " ilInst~>ms_t))
		 )
		 (4 (when ilInst~>ms_h != "" 
			(strcat "H = " ilInst~>ms_h))
		 )
		 (5 (when ilInst~>ms_er != "" 
			(strcat "ER = " ilInst~>ms_er))
		 )
		 (6  (ANTdevOpba 'large))
		 (61 (ANTdevOpba 'medium))
		 (62 (ANTdevOpba 'small))
		 (7 (CDFterm "p1"))
		 (8 (CDFterm "p2"))
		 (9 (CDFterm "p3"))
		 (10 (CDFterm "p4"))
		 (11 (CDFterm "p5"))
		 (12 (CDFterm "p6"))
	     )
	    )
	    ((equal cellName "mstep")
	     (case num
		 (1 (CDFname))
		 (2 (setq s "")
		  (when ilInst~>ms_w1 != "" 
		      (sprintf s "%sW1=%s " s ilInst~>ms_w1))
		  (when ilInst~>ms_w2 != "" 
		      (sprintf s "%sW2=%s " s ilInst~>ms_w2))
		  (sprintf nil "%s" s)
		 )
		 (3 (when ilInst~>ms_t != "" 
			(strcat "T = " ilInst~>ms_t))
		 )
		 (4 (when ilInst~>ms_h != "" 
			(strcat "H = " ilInst~>ms_h))
		 )
		 (5 (sprintf nil "ASYMMETRICAL = %L" ilInst~>ms_asymmetrical)
		 )
		 (6  (ANTdevOpba 'large))
		 (61 (ANTdevOpba 'medium))
		 (62 (ANTdevOpba 'small))
		 (7 (CDFterm "p1"))
		 (8 (CDFterm "p2"))
		 (9 (CDFterm "p3"))
		 (10 (CDFterm "p4"))
	     )
	    )
	    ((or (equal cellName "mbend") (equal cellName "mbend2") (equal cellName "mbend3") (equal cellName "mcorn"))
	     (case num
		 (1 (CDFname))
		 (2 (when ilInst~>ms_w != "" 
		      (sprintf nil "W = %s " ilInst~>ms_w))
		 )
		 (3 (when ilInst~>ms_h != "" 
			(strcat "H = " ilInst~>ms_h))
		 )
		 (4 (when ilInst~>ms_er != "" 
			(strcat "ER = " ilInst~>ms_er))
		 )
		 (5 (when (and (ilInst~>ms_t != "") (not (null ilInst~>ms_t)))
			(strcat "T = " ilInst~>ms_t))
		 )
		 (6  (ANTdevOpba 'large))
		 (61 (ANTdevOpba 'medium))
		 (62 (ANTdevOpba 'small))
		 (7 (CDFterm "p1"))
		 (8 (CDFterm "p2"))
		 (9 (CDFterm "p3"))
		 (10 (CDFterm "p4"))
	     )
	    )
	    ((equal cellName "sbend") 
	     (case num
		 (1 (CDFname))
		 (2 (when ilInst~>ms_w != "" 
		      (sprintf nil "W = %s " ilInst~>ms_w))
		 )
		 (3 (when ilInst~>ms_b != "" 
			(strcat "B = " ilInst~>ms_b))
		 )
		 (4 (when ilInst~>ms_er != "" 
			(strcat "ER = " ilInst~>ms_er))
		 )
		 (5 (when (and (ilInst~>ms_t != "") (not (null ilInst~>ms_t)))
			(strcat "T = " ilInst~>ms_t))
		 )
		 (6  (ANTdevOpba 'large))
		 (61 (ANTdevOpba 'medium))
		 (62 (ANTdevOpba 'small))
		 (7 (CDFterm "p1"))
		 (8 (CDFterm "p2"))
		 (9 (CDFterm "p3"))
		 (10 (CDFterm "p4"))
	     )
	    )
	    ((equal cellName "rcwire") 
	     (case num
		 (1 (CDFname))
		 (2 (when ilInst~>model != "" 
		      (sprintf nil "model: %s " ilInst~>model))
		 )
		 (3 (when ilInst~>rE != "" 
			(strcat "R = " ilInst~>rE))
		 )
		 (4 (when ilInst~>cE != "" 
			(strcat "C = " ilInst~>cE))
		 )
		 (5 (setq s "")
		  (when ilInst~>lE != "" 
		      (sprintf s "%sL=%s " s ilInst~>lE))
		  (when ilInst~>wE != "" 
		      (sprintf s "%sW=%s " s ilInst~>wE))
		  (when ilInst~>mE != "" 
		      (sprintf s "%sM=%s " s ilInst~>mE))
		  (sprintf nil "%s" s)
		 )
		 (6  (ANTdevOpba 'large))
		 (61 (ANTdevOpba 'medium))
		 (62 (ANTdevOpba 'small))
		 (7 (CDFterm "n1"))
		 (8 (CDFterm "n2"))
	     )
	    )
	    ((equal cellName "sfilter")
	     (case num
		 (1 (CDFname))
		 (2 (when ilInst~>r1 != "" 
		      (sprintf nil "RIN = %s " ilInst~>r1))
		 )
		 (3 (when ilInst~>r2 != "" 
			(strcat "ROUT = " ilInst~>r2))
		 )
		 (4  (ANTdevOpba 'large))
		 (41 (ANTdevOpba 'medium))
		 (42 (ANTdevOpba 'small))
		 (5 (CDFterm "in"))
		 (6 (CDFterm "out"))
	     )
	    )
	    ((equal cellName "zfilter")
	     (case num
		 (1 (CDFname))
		 (2 (when ilInst~>samfreq != "" 
		      (sprintf nil "FREQ = %s " ilInst~>samfreq))
		 )
		 (3 (setq s "")
		  (when ilInst~>r1 != "" 
		      (sprintf s "%sRIN=%s " s ilInst~>r1))
		  (when ilInst~>r2 != "" 
		      (sprintf s "%sROUT=%s " s ilInst~>r2))
		  (sprintf nil "%s" s)
		 )
		 (4  (ANTdevOpba 'large))
		 (41 (ANTdevOpba 'medium))
		 (42 (ANTdevOpba 'small))
		 (5 (CDFterm "in"))
		 (6 (CDFterm "out"))
	     )
	    )
	    ((or (equal cellName "opamp0") (equal cellName "opamp1") (equal cellName "opamp2"))
	     (case num
		 (1 (CDFname))
		 (2 (when ilInst~>model != "" 
		      (sprintf nil "model: %s " ilInst~>model))
		 )
		 (3 (setq s "")
		  (when ilInst~>gainE != "" 
		      (sprintf s "%sGAIN=%s " s ilInst~>gainE))
		  (when ilInst~>rin != "" 
		      (sprintf s "%sRIN=%s " s ilInst~>rin))
		  (sprintf nil "%s" s)
		 )
		 (4  (ANTdevOpba 'large))
		 (41 (ANTdevOpba 'medium))
		 (42 (ANTdevOpba 'small))
		 (5 (CDFterm "inp"))
		 (6 (CDFterm "inn"))
		 (7 (CDFterm "out"))
		 (8 (CDFterm "agnd"))
	     )
	    )
	    ((or (equal cellName "opamp0d") (equal cellName "opamp1d") (equal cellName "opamp2d"))
	     (case num
		 (1 (CDFname))
		 (2 (when ilInst~>model != "" 
		      (sprintf nil "model: %s " ilInst~>model))
		 )
		 (3 (setq s "")
		  (when ilInst~>gainE != "" 
		      (sprintf s "%sGAIN=%s " s ilInst~>gainE))
		  (when ilInst~>rin != "" 
		      (sprintf s "%sRIN=%s " s ilInst~>rin))
		  (sprintf nil "%s" s)
		 )
		 (4  (ANTdevOpba 'large))
		 (41 (ANTdevOpba 'medium))
		 (42 (ANTdevOpba 'small))
		 (5 (CDFterm "inp"))
		 (6 (CDFterm "inn"))
		 (7 (CDFterm "outn"))
		 (8 (CDFterm "outp"))
		 (9 (CDFterm "agnd"))
	     )
	    )
	    ((equal cellName "comp")
	     (case num
		 (1 (CDFname))
		 (2 (when ilInst~>model != "" 
		      (sprintf nil "model: %s " ilInst~>model))
		 )
                 (3 (setq tmpVal1 "")
                    (foreach
                     sym '(vhi vlo voff vdef tcom tpd)
                     (when (nequal (get ilInst sym) "")
                       (sprintf tmpVal1 "%s%s=%s " tmpVal1 (upperCase sym) (get ilInst sym)))
                     )
                    (sprintf nil "%s" tmpVal1)
                    )
		 (4  (ANTdevOpba 'large))
		 (41 (ANTdevOpba 'medium))
		 (42 (ANTdevOpba 'small))
		 (5 (CDFterm "inp"))
		 (6 (CDFterm "inn"))
		 (7 (CDFterm "out"))
	     )
	    )
	    ((equal cellName "compd")
	     (case num
		 (1 (CDFname))
		 (2 (when ilInst~>model != "" 
		      (sprintf nil "model: %s " ilInst~>model))
		 )
		 (3 (setq tmpVal1 "")
                    (foreach
                     sym '(vhi vlo voff vdef tcom tpd)
                     (when (nequal (get ilInst sym) "")
                       (sprintf tmpVal1 "%s%s=%s " tmpVal1 (upperCase sym) (get ilInst sym)))
                     )
                    (sprintf nil "%s" tmpVal1)
                    )
		 (4  (ANTdevOpba 'large))
		 (41 (ANTdevOpba 'medium))
		 (42 (ANTdevOpba 'small))
		 (5 (CDFterm "inp"))
		 (6 (CDFterm "inn"))
		 (7 (CDFterm "outn"))
		 (8 (CDFterm "outp"))
	     )
	    )
	    ((equal cellName "integ")
	     (case num
		 (1 (CDFname))
		 (2 (when ilInst~>model != "" 
		      (sprintf nil "model: %s " ilInst~>model))
		 )
		 (3 (setq s "")
		  (when ilInst~>kE != "" 
		      (sprintf s "%sK=%s " s ilInst~>kE))
		  (when ilInst~>c0E != "" 
		      (sprintf s "%sC0=%s " s ilInst~>c0E))
		  (sprintf nil "%s" s)
		 )
		 (4  (ANTdevOpba 'large))
		 (41 (ANTdevOpba 'medium))
		 (42 (ANTdevOpba 'small))
		 (5 (CDFterm "in"))
		 (6 (CDFterm "out"))
	     )
	    )
	    ((equal cellName "mult2")
	     (case num
		 (1 (CDFname))
		 (2 (when ilInst~>model != "" 
		      (sprintf nil "model: %s " ilInst~>model))
		 )
		 (3 (setq s "")
		  (when ilInst~>vmax != "" 
		      (sprintf s "%sVMAX=%s " s ilInst~>vmax))
		  (when ilInst~>vmin != "" 
		      (sprintf s "%sVMIN=%s " s ilInst~>vmin))
		  (sprintf nil "%s" s)
		 )
		 (4  (ANTdevOpba 'large))
		 (41 (ANTdevOpba 'medium))
		 (42 (ANTdevOpba 'small))
		 (5 (CDFterm "in1"))
		 (6 (CDFterm "in2"))
		 (7 (CDFterm "out"))
	     )
	    )
	    ((equal cellName "logamp")
	     (case num
		 (1 (CDFname))
		 (2 (when ilInst~>model != "" 
		      (sprintf nil "model: %s " ilInst~>model))
		 )
		 (3 (setq s "")
		  (when ilInst~>kE != "" 
		      (sprintf s "%sK=%s " s ilInst~>kE))
		  (when ilInst~>base != "" 
		      (sprintf s "%sBASE=%s " s ilInst~>base))
		  (sprintf nil "%s" s)
		 )
		 (4  (ANTdevOpba 'large))
		 (41 (ANTdevOpba 'medium))
		 (42 (ANTdevOpba 'small))
		 (5 (CDFterm "in"))
		 (6 (CDFterm "out"))
	     )
	    )
	    ((equal cellName "peak_d")
	     (case num
		 (1 (CDFname))
		 (2 (when ilInst~>model != "" 
		      (sprintf nil "model: %s " ilInst~>model))
		 )
		 (3 (setq s "")
		  (when ilInst~>vth != "" 
		      (sprintf s "%sVTH=%s " s ilInst~>vth))
		  (when ilInst~>level != "" 
		      (sprintf s "%sLEVEL=%L " s ilInst~>level))
		  (sprintf nil "%s" s)
		 )
		 (4  (ANTdevOpba 'large))
		 (41 (ANTdevOpba 'medium))
		 (42 (ANTdevOpba 'small))
		 (5 (CDFterm "inp"))
		 (6 (CDFterm "inn"))
		 (7 (CDFterm "inp"))
		 (8 (CDFterm "inn"))
		 (9 (CDFterm "crt"))
	     )
	    )
	    ((or (equal cellName "sc_u") (equal cellName "sc_s1") (equal cellName "sc_s2") (equal cellName "sc_b"))
	     (case num
		 (1 (CDFname))
		 (2 (when ilInst~>model != "" 
		      (sprintf nil "model: %s " ilInst~>model))
		 )
		 (3 (setq s "")
		  (when ilInst~>cf != "" 
		      (sprintf s "%sC=%s " s ilInst~>cf))
		  (when ilInst~>tp != "" 
		      (sprintf s "%sTP=%s " s ilInst~>tp))
		  (sprintf nil "%s" s)
		 )
		 (4  (ANTdevOpba 'large))
		 (41 (ANTdevOpba 'medium))
		 (42 (ANTdevOpba 'small))
		 (5 (CDFterm "in"))
		 (6 (CDFterm "out"))
	     )
	    )
	    ((equal cellName "opa")
	     (case num
		 (1 (CDFname))
		 (2 (when ilInst~>model != "" 
		      (sprintf nil "model: %s " ilInst~>model))
		 )
		 (3 (setq s "")
		  (when ilInst~>cin != "" 
		      (sprintf s "%sCIN=%s " s ilInst~>cin))
		  (when ilInst~>gaindb != "" 
		      (sprintf s "%sGAIN=%s " s ilInst~>gaindb))
		  (when ilInst~>rsE != "" 
		      (sprintf s "%sRS=%s " s ilInst~>rsE))
		  (sprintf nil "%s" s)
		 )
		 (4  (ANTdevOpba 'large))
		 (41 (ANTdevOpba 'medium))
		 (42 (ANTdevOpba 'small))
		 (5 (CDFterm "inn"))
		 (6 (CDFterm "inp"))
		 (7 (CDFterm "outn"))
		 (8 (CDFterm "outp"))
	     )
	    )
	    ((or (equal cellName "sc_sp1") (equal cellName "sc_sp2"))
	     (case num
		 (1 (CDFname))
		 (2 (when ilInst~>model != "" 
		      (sprintf nil "model: %s " ilInst~>model))
		 )
		 (3 (setq s "")
		  (when ilInst~>cf1 != "" 
		      (sprintf s "%sC1=%s " s ilInst~>cf1))
		  (when ilInst~>cf2 != "" 
		      (sprintf s "%sC2=%s " s ilInst~>cf2))
		  (when ilInst~>tp != "" 
		      (sprintf s "%sTP=%s " s ilInst~>tp))
		  (sprintf nil "%s" s)
		 )
		 (4  (ANTdevOpba 'large))
		 (41 (ANTdevOpba 'medium))
		 (42 (ANTdevOpba 'small))
		 (5 (CDFterm "in"))
		 (6 (CDFterm "out"))
		 (7 (CDFterm "ref"))
	     )
	    )
	    ((or (equal cellName "sc_i") (equal cellName "sc_n"))
	     (case num
		 (1 (CDFname))
		 (2 (when ilInst~>model != "" 
		      (sprintf nil "model: %s " ilInst~>model))
		 )
		 (3 (setq s "")
		  (when ilInst~>cf != "" 
		      (sprintf s "%sC=%s " s ilInst~>cf))
		  (when ilInst~>tp != "" 
		      (sprintf s "%sTP=%s " s ilInst~>tp))
		  (sprintf nil "%s" s)
		 )
		 (4  (ANTdevOpba 'large))
		 (41 (ANTdevOpba 'medium))
		 (42 (ANTdevOpba 'small))
		 (5 (CDFterm "p1"))
		 (6 (CDFterm "p2"))
		 (7 (CDFterm "n1"))
		 (8 (CDFterm "n2"))
	     )
	    )
	    ((equal cellName "sc_p")
	     (case num
		 (1 (CDFname))
		 (2 (when ilInst~>model != "" 
		      (sprintf nil "model: %s " ilInst~>model))
		 )
		 (3 (setq s "")
		  (when ilInst~>cf != "" 
		      (sprintf s "%sC=%s " s ilInst~>cf))
		  (when ilInst~>tp != "" 
		      (sprintf s "%sTP=%s " s ilInst~>tp))
		  (sprintf nil "%s" s)
		 )
		 (4  (ANTdevOpba 'large))
		 (41 (ANTdevOpba 'medium))
		 (42 (ANTdevOpba 'small))
		 (5 (CDFterm "p1"))
		 (6 (CDFterm "p2"))
		 (7 (CDFterm "n"))
	     )
	    )
	    ((equal cellName "sc_ideal")
	     (case num
		 (1 (CDFname))
		 (2 (when ilInst~>m != "" 
		      (sprintf nil "M = %s " ilInst~>m))
		 )
		 (3 (sprintf nil ""))
		 (4  (ANTdevOpba 'large))
		 (41 (ANTdevOpba 'medium))
		 (42 (ANTdevOpba 'small))
		 (5 (CDFterm "inp"))
		 (6 (CDFterm "inn"))
		 (7 (CDFterm "out"))
	     )
	    )
	    ((equal cellName "switcheldo")
	     (case num
		 (1 (CDFname))
		 (2 (when ilInst~>model != "" 
		      (sprintf nil "model: %s " ilInst~>model))
		 )
		 (3 (setq s "")
		  (when ilInst~>ron != "" 
		      (sprintf s "%sRON=%s " s ilInst~>ron))
		  (when ilInst~>crec != "" 
		      (sprintf s "%sCREC=%s " s ilInst~>crec))
		  (sprintf nil "%s" s)
		 )
		 (4  (ANTdevOpba 'large))
		 (41 (ANTdevOpba 'medium))
		 (42 (ANTdevOpba 'small))
		 (5 (CDFterm "nc"))
		 (6 (CDFterm "n1"))
		 (7 (CDFterm "n2"))
	     )
	    )
	    ((equal cellName "scres")
	     (case num
		 (1 (CDFname))
		 (2 (when ilInst~>model != "" 
		      (sprintf nil "model: %s " ilInst~>model))
		 )
		 (3 (setq s "")
		  (when ilInst~>rE != "" 
		      (sprintf s "%sR=%s " s ilInst~>rE))
		  (when ilInst~>l != "" 
		      (sprintf s "%sL=%s " s ilInst~>l))
		  (when ilInst~>crec != "" 
		      (sprintf s "%sW=%s " s ilInst~>w))
		  (sprintf nil "%s" s)
		 )
		 (4  (ANTdevOpba 'large))
		 (41 (ANTdevOpba 'medium))
		 (42 (ANTdevOpba 'small))
		 (5 (CDFterm "n1"))
		 (6 (CDFterm "n2"))
		 (7 (CDFterm "ns"))
	     )
	    )
	    ((equal cellName "vswitch")
	     (case num
		 (1 (CDFname))
		 (2 (setq s "")
		  (when ilInst~>level != "" 
		      (sprintf s "%slevel=%s  " s ilInst~>level))
		  (when ilInst~>model != "" 
		      (sprintf s "%smodel: %s " s ilInst~>model))
		  (sprintf nil "%s" s)
		 )
		 (3 (setq s "")
		  (when ilInst~>von != "" 
		      (sprintf s "%sVON=%s " s ilInst~>von))
		  (when ilInst~>voff != "" 
		      (sprintf s "%sVOFF=%s " s ilInst~>voff))
		  (sprintf nil "%s" s)
		 )
		 (4 (setq s "")
		  (when ilInst~>ron != "" 
		      (sprintf s "%sRON=%s " s ilInst~>ron))
		  (when ilInst~>roff != "" 
		      (sprintf s "%sROFF=%s " s ilInst~>roff))
		  (sprintf nil "%s" s)
		 )
		 (5  (ANTdevOpba 'large))
		 (51 (ANTdevOpba 'medium))
		 (52 (ANTdevOpba 'small))
		 (6 (CDFterm "np"))
		 (7 (CDFterm "nn"))
		 (8 (CDFterm "cp"))
		 (9 (CDFterm "cn"))
	     )
	    )
	    ((equal cellName "vco")
	     (case num
		 (1 (CDFname))
		 (2 (setq s "")
		  (when ilInst~>level != "" 
		      (sprintf s "%slevel=%s  " s ilInst~>level))
		  (when ilInst~>model != "" 
		      (sprintf s "%smodel: %s " s ilInst~>model))
		  (sprintf nil "%s" s)
		 )
		 (3 (setq s "")
		  (when ilInst~>v1E != "" 
		      (sprintf s "%sV1=%s " s ilInst~>v1E))
		  (when ilInst~>voff != "" 
		      (sprintf s "%sVOFF=%s " s ilInst~>voff))
		  (sprintf nil "%s" s)
		 )
		 (4 (setq s "")
		  (when ilInst~>fmin != "" 
		      (sprintf s "%sFMIN=%s " s ilInst~>fmin))
		  (when ilInst~>fmaxE != "" 
		      (sprintf s "%sFMAX=%s " s ilInst~>fmaxE))
		  (sprintf nil "%s" s)
		 )
		 (5  (ANTdevOpba 'large))
		 (51 (ANTdevOpba 'medium))
		 (52 (ANTdevOpba 'small))
		 (6 (CDFterm "inp"))
		 (7 (CDFterm "inn"))
		 (8 (CDFterm "outp"))
		 (9 (CDFterm "outn"))
	     )
	    )
	    ((equal cellName "winding")
	     (case num
		 (1 (CDFname))
		 (2 (setq s "")
		  (when ilInst~>model != "" 
		      (sprintf s "%smodel: %s " s ilInst~>model))
		  (sprintf nil "%s" s)
		 )
		 (3 (setq s "")
		  (when ilInst~>nIdle != "" 
		      (sprintf s "%sN=%s " s ilInst~>nIdle))
		  (when ilInst~>resis != "" 
		      (sprintf s "%sR=%s " s ilInst~>resis))
		  (sprintf nil "%s" s)
		 )
		 (4 (sprintf nil ""))
		 (5  (ANTdevOpba 'large))
		 (51 (ANTdevOpba 'medium))
		 (52 (ANTdevOpba 'small))
		 (6 (CDFterm "e1"))
		 (7 (CDFterm "e2"))
		 (8 (CDFterm "m1"))
		 (9 (CDFterm "m2"))
	     )
	    )
	    ((equal cellName "pwm")
	     (case num
		 (1 (CDFname))
		 (2 (setq s "")
		  (when ilInst~>model != "" 
		      (sprintf s "%smodel: %s " s ilInst~>model))
		  (sprintf nil "%s" s)
		 )
		 (3 (setq s "")
		  (when ilInst~>dutymin != "" 
		      (sprintf s "%sDUTYMIN=%s " s ilInst~>dutymin))
		  (when ilInst~>dutymax != "" 
		      (sprintf s "%sDUTYMAX=%s " s ilInst~>dutymax))
		  (sprintf nil "%s" s)
		 )
		 (4 (setq s "")
		  (when ilInst~>ctrlmin != "" 
		      (sprintf s "%sCTRLMIN=%s " s ilInst~>ctrlmin))
		  (when ilInst~>ctrlmax != "" 
		      (sprintf s "%sCTRLMAX=%s " s ilInst~>ctrlmax))
		  (sprintf nil "%s" s)
		 )
		 (5  (ANTdevOpba 'large))
		 (51 (ANTdevOpba 'medium))
		 (52 (ANTdevOpba 'small))
		 (6 (CDFterm "ctrp"))
		 (7 (CDFterm "ctrn"))
		 (8 (CDFterm "outp"))
		 (9 (CDFterm "outn"))
	     )
	    )
	    ((equal cellName "stairgen")
	     (case num
		 (1 (CDFname))
		 (2 (when ilInst~>model != "" 
		      (sprintf nil "model: %s " ilInst~>model))
		 )
		 (3 (setq s "")
		  (when ilInst~>vstart != "" 
		      (sprintf s "%sVSTART=%s " s ilInst~>vstart))
		  (when ilInst~>vdelta != "" 
		      (sprintf s "%svdelta=%s " s ilInst~>vdelta))
		  (when ilInst~>nstep != "" 
		      (sprintf s "%sNSTEP=%s " s ilInst~>nstep))
		  (sprintf nil "%s" s)
		 )
		 (4  (ANTdevOpba 'large))
		 (41 (ANTdevOpba 'medium))
		 (42 (ANTdevOpba 'small))
		 (5 (CDFterm "np"))
		 (6 (CDFterm "nn"))
	     )
	    )
	    ((equal cellName "sawgen")
	     (case num
		 (1 (CDFname))
		 (2 (when ilInst~>model != "" 
		      (sprintf nil "model: %s " ilInst~>model))
		 )
		 (3 (setq s "")
		  (when ilInst~>v0 != "" 
		      (sprintf s "%sV0=%s " s ilInst~>v0))
		  (when ilInst~>v1E != "" 
		      (sprintf s "%sV1=%s " s ilInst~>v1E))
		  (sprintf nil "%s" s)
		 )
		 (4  (ANTdevOpba 'large))
		 (41 (ANTdevOpba 'medium))
		 (42 (ANTdevOpba 'small))
		 (5 (CDFterm "np"))
		 (6 (CDFterm "nn"))
	     )
	    )
	    ((or (equal cellName "vfour") (equal cellName "ifour"))
	     (case num
		 (1 (CDFname))
		 (2 (setq s 0)
		    (when (equal "TRUE" ilInst~>fund1_sst) s++)
		    (when (equal "TRUE" ilInst~>fund2_sst) s++)
		    (when (equal "TRUE" ilInst~>fund3_sst) s++)
		    (sprintf nil "fund=%d" s)
		 )
                 (3 (strcat "format=" ilInst~>format))
		 (4  (ANTdevOpba 'large))
		 (41 (ANTdevOpba 'medium))
		 (42 (ANTdevOpba 'small))
		 (5 (CDFterm "PLUS" ":i"))
		 (6 (CDFterm "MINUS"))
	     )
	    )
	    ((or (equal cellName "vfoursst") (equal cellName "ifoursst"))
	     (case num
		 (1 (CDFname))
		 (2 (setq s 0)
		    (when (equal "TRUE" ilInst~>fund1_sst) s++)
		    (when (equal "TRUE" ilInst~>fund2_sst) s++)
		    (when (equal "TRUE" ilInst~>fund3_sst) s++)
		    (sprintf nil "fund=%d" s)
		 )
                 (3 (strcat "format=" ilInst~>format))
		 (4 (when ilInst~>acmE != "" 
			(strcat "acmag = " ilInst~>acmE))
		 )
		 (5 (when ilInst~>acp != "" 
			(strcat "acphase = " ilInst~>acp))
		 )
		 (6 (when ilInst~>idc != "" 
			(strcat "dc = " ilInst~>idc))
		 )
		 (7  (ANTdevOpba 'large))
		 (71 (ANTdevOpba 'medium))
		 (72 (ANTdevOpba 'small))
		 (8 (CDFterm "PLUS" ":i"))
		 (9 (CDFterm "MINUS"))
	     )
	    )
	    ((equal cellName "sstprobe")
	     (case num
		 (1 (CDFname))
		 (2  (ANTdevOpba 'large))
		 (21 (ANTdevOpba 'medium))
		 (22 (ANTdevOpba 'small))
		 (3 (CDFterm "PLUS" ":i"))
		 (4 (CDFterm "MINUS"))
	     )
	    )
	    ((or (equal cellName "vmodsst") (equal cellName "imodsst"))
	     (case num
		 (1 (CDFname))
		 (2 (strcat "modulation=" ilInst~>source))
                 (3 (strcat "carrier=" ilInst~>carrier))
                 (4
                  (cond
                    ((equal "FOUR" ilInst~>carrier)
                     (setq s 0)
		     (when (equal "TRUE" ilInst~>fund1_sst) s++)
		     (when (equal "TRUE" ilInst~>fund2_sst) s++)
		     (when (equal "TRUE" ilInst~>fund3_sst) s++)
		     (sprintf nil "fund=%d" s)
                    )
                    ((equal "SIN" ilInst~>carrier)
                     (strcat "vo=" (AELgetStringProp ilInst 'vo))
                    )
                  )
                 )
                 (5
                  (cond
                    ((equal "FOUR" ilInst~>carrier)
                     (strcat "format=" (concat ilInst~>format))
                    )
                    ((equal "SIN" ilInst~>carrier)
                     (strcat "va=" (AELgetStringProp ilInst 'va))
                    )
                  )
                 )
                 (6
                  (cond
                    ((equal "FOUR" ilInst~>carrier)
                     ""
                    )
                    ((equal "SIN" ilInst~>carrier)
                     (strcat "freq=" (AELgetStringProp ilInst 'freq))
                    )
                  )
                 )
		 (7  (ANTdevOpba 'large))
		 (71 (ANTdevOpba 'medium))
		 (72 (ANTdevOpba 'small))
		 (8 (CDFterm "PLUS" ":i"))
		 (9 (CDFterm "MINUS"))
	     )
	    )
	    ((or (equal cellName "vphnoise") (equal cellName "iphnoise"))
	     (case num
		 (1 (CDFname))
                 (2 (strcat "desc=" ilInst~>phnoise))
                 (3 (strcat "sig=" ilInst~>psignal))
		 (4 
                  (cond
                    ((equal "FOUR" ilInst~>psignal)
                     (strcat "fi=" (concat ilInst~>fundi))
                    )
                    ((equal "SIN" ilInst~>psignal)
                     (strcat "vo=" (AELgetStringProp ilInst 'vo))
                    )
                    ((equal "PULSE" ilInst~>psignal)
                     (strcat "v1=" (AELgetStringProp ilInst 'v1))
                    )
                  )
                 )
                 (5 
                  (cond
                    ((equal "FOUR" ilInst~>psignal)
                     (strcat "format=" ilInst~>format)
                    )
                    ((equal "SIN" ilInst~>psignal)
                     (strcat "va=" (AELgetStringProp ilInst 'va))
                    )
                    ((equal "PULSE" ilInst~>psignal)
                     (strcat "v2=" (AELgetStringProp ilInst 'v2))
                    )
                  )
                 )
                 (6
                  (cond
                    ((equal "FOUR" ilInst~>psignal)
                     ""
                    )
                    ((equal "SIN" ilInst~>psignal)
                     (strcat "freq=" (AELgetStringProp ilInst 'freq))
                    )
                    ((equal "PULSE" ilInst~>psignal)
                     (strcat "per=" (AELgetStringProp ilInst 'per))
                    )
                  )
                 )
		 (7  (ANTdevOpba 'large))
		 (71 (ANTdevOpba 'medium))
		 (72 (ANTdevOpba 'small))
		 (8 (CDFterm "PLUS" ":i"))
		 (9 (CDFterm "MINUS"))
	     )
	    )
	    ;; end of the EldoRF sources

	    ;; passive
	    ((member cellName '("cap2" "cppc" "dtcap"))
	     (CDFcap2Labels num)
	    )
	    ((member cellName '("cap_int3"))
	     (CDFcap_int3Labels num)
	    )
	    ((member cellName '("vppcap"))
	     (CDFvppcapLabels num)
	    )
	    ;; the cmimc is similar to the capacitor part of the capbn_b
	    ((or (equal cellName "cmimc") (equal cellName "cmim3c") )
	     (case num
		 (1 (CDFname))
		 (2 (CDFiter))
		 (3 (or ilInst~>ctype "ERROR_no_model"))
		 (4
		  (setq tmpVal1 (AELgetStringProp ilInst 'cm))
		  (setq tmpVal2 (AELgetStringProp ilInst 'cw))
		  (setq tmpVal3 (AELgetStringProp ilInst 'cl))
		  (cond
		      ((or (null tmpVal1)
			   (equal "1" tmpVal1)
			   (equal "" tmpVal1)
		       )
		       (setq tmpVal1 "")
		      )
		      (t (setq tmpVal1 (strcat tmpVal1 "*")))
		  )
		  (when (or (null tmpVal2) (equal "" tmpVal2))
		      (setq tmpVal2 "ERROR_no_cw")
		  )
		  (when (or (null tmpVal3) (equal "" tmpVal3))
		      (setq tmpVal3 "ERROR_no_cl")
		  )
		  (strcat tmpVal1 tmpVal2 "*" tmpVal3)
		 )
		 (5
		  (setq tmpVal1 (AELgetStringProp ilInst 'actualC))
		  (when (equal "" tmpVal1)
		      (setq tmpVal1 (AELgetStringProp ilInst 'c))
		  )
		  tmpVal1
		 )
		 (6 (ANTdevOpba 'large "C"))
		 (61 (ANTdevOpba 'medium "C"))
		 (62 (ANTdevOpba 'small "C"))
		 (7 (CDFterm "c1"))
		 (8 (CDFterm "c0"))
		 
		 (9
		  (when (equal cellName "cmim3c")
		    (CDFterm "b")
		  )
		 )
	     )
	    )
	    ((or (equal cellName "capbn_b") (equal cellName "moscap"))
	     (case num
		 (1 (CDFname))
		 (2 (CDFiter))
		 (3 (or ilInst~>ctype "ERROR_no_model"))
		 (4
		  (setq tmpVal1 (AELgetStringProp ilInst 'cm))
		  (setq tmpVal2 (AELgetStringProp ilInst 'cw))
		  (setq tmpVal3 (AELgetStringProp ilInst 'cl))
		  (setq tmpVal4 (AELgetStringProp ilInst 'cg))
		  (cond
		      ((or (null tmpVal1)
			   (equal "1" tmpVal1)
			   (equal "" tmpVal1)
		       )
		       (setq tmpVal1 "")
		      )
		      (t (setq tmpVal1 (strcat tmpVal1 "*")))
		  )
		  (when (or (null tmpVal2) (equal "" tmpVal2))
		      (setq tmpVal2 "ERROR_no_cw")
		  )
		  (when (or (null tmpVal3) (equal "" tmpVal3))
		      (setq tmpVal3 "ERROR_no_cl")
		  )
		  (when (and tmpVal4 (nequal "" tmpVal4))
		      (setq tmpVal3 (strcat tmpVal3 " g=" tmpVal4))
		  )
		  (strcat tmpVal1 tmpVal2 "*" tmpVal3)
		 )
		 (5
		  ;; display the capacitance, if possible
		  (setq tmpVal1 (AELgetStringProp ilInst 'actualC))
		  (when (equal "" tmpVal1)
		      (setq tmpVal1 (AELgetStringProp ilInst 'c))
		  )
		  (setq tmpVal2 (AELgetStringProp ilInst 'cm))
		  (cond
		      ((and (stringp tmpVal1) (aelIsNumberP tmpVal1)
			    (stringp tmpVal2) (aelIsNumberP tmpVal2))
		       (setq tmpVal1 (aelNumber tmpVal1))
		       (setq tmpVal1 (quotient tmpVal1
					       (aelNumber tmpVal2)))
                       (setq tmpVal1 (aelNumber (sprintf nil "%.3g" tmpVal1)))
		       (cond
			   ((or (equal "1" tmpVal2) (equal "" tmpVal2))
			    (setq tmpVal2 "")
			   )
			   (t (setq tmpVal2 (strcat tmpVal2 "*")))
		       )
		       ;; if it is really huge, assume it is already in pF
		       (when (lessp tmpVal1 1e-3)
			   (setq tmpVal1 (times 1e12 tmpVal1))
		       )
		       (sprintf nil "%s%gpF" tmpVal2 tmpVal1)
		      )
		      (t "")
		  )
		 )
		 (6
		  (setq tmpVal1 ilInst~>manualDiode)
		  (cond
		      ((or (null tmpVal1) (equal "FALSE" tmpVal1))
		       ""
		      )
		      (t
		       (setq tmpVal1 (AELgetStringProp ilInst 'dm))
		       (cond
			   ((equal "Area & Perim" ilInst~>manDiodeMethod)
			    (setq tmpVal2 (AELgetStringProp ilInst 'area))
			    (setq tmpVal2 (strcat " a=" tmpVal2))
			    (setq tmpVal3 (AELgetStringProp ilInst 'perim))
			    (setq tmpVal3 (strcat ", p=" tmpVal3))
			   )
			   (t
			    (setq tmpVal2 (AELgetStringProp ilInst 'dw))
			    (setq tmpVal3 (AELgetStringProp ilInst 'dl))
			   )
		       )
		       (cond
			   ((or (null tmpVal1)
				(equal "1" tmpVal1)
				(equal "" tmpVal1)
			    )
			    (setq tmpVal1 "")
			   )
			   (t (setq tmpVal1 (strcat tmpVal1 "*")))
		       )
		       (when (or (null tmpVal2) (equal "" tmpVal2))
			   (setq tmpVal2 "ERROR_no_dw")
		       )
		       (when (or (null tmpVal3) (equal "" tmpVal3))
			   (setq tmpVal3 "ERROR_no_dl")
		       )
		       (cond
			   ((equal "Area & Perim" ilInst~>manDiodeMethod)
			    (strcat tmpVal1 tmpVal2 tmpVal3)
			   )
			   (t
			    (strcat tmpVal1 tmpVal2 "*" tmpVal3)
			   )
		       )
		      )
		  )
		 )
		 (7 (CDFterm "c0"))
		 (8 (CDFterm "c1"))
		 (9 (CDFterm "b"))
		 (10 (ANTdevOpba 'large "C"))
		 (101 (ANTdevOpba 'medium "C"))
		 (102 (ANTdevOpba 'small "C"))
		 (11 (ANTdevOpba 'large "D"))
		 (111 (ANTdevOpba 'medium "D"))
		 (112 (ANTdevOpba 'small "D"))
	     )
	    )
	    ((equal cellName "fuse")
	     (case num
		 (1 (CDFname))
		 (2 (CDFlogic))
		 (3 (CDFiter))
		 (4
		  (strcat (or (AELgetStringProp ilInst 'rw) "")
			  "/"
			  (or (AELgetStringProp ilInst 'rl) "")
		  )
		 )
		 (5 (CDFterm "f0"))
		 (6 (CDFterm "f1"))
		 (7 (ANTdevOpba 'large))
		 (71 (ANTdevOpba 'medium))
		 (72 (ANTdevOpba 'small))
	     )
	    )
	    ((equal cellName "icecap")
	     (case num
		 (1 (ICElabel ilInst~>cap))
		 (2 (if (and ilInst~>actualCap (nequal "" ilInst~>actualCap)) (strcat "LC:" (ICElabel ilInst~>actualCap)) ""))
	     )
	    )
	    ((equal cellName "inductor")
	     (case num
		 (1 (CDFname))
		 (2 (strcat "L=" (or (AELgetStringProp ilInst 'l) "ERROR")))
		 (3
		  (setq tmpVal1 (or (AELgetStringProp ilInst 'm) ""))
		  (cond
		      ((and (nequal "" tmpVal1) (nequal "1" tmpVal1))
		       (setq tmpVal1 (strcat "m=" tmpVal1))
		      )
		      (t (setq tmpVal1 ""))
		  )
		  (cond
		      ((equal "Mutual List" (AELgetStringProp ilInst 'indType))
		       (setq tmpVal2 (or (AELgetStringProp ilInst 'mutualList)
					 ""))
		       (when (nequal "" tmpVal2)
			   (setq tmpVal2 "coupled to multiple inductors")
		       )
		      )
		      (t
		       (setq tmpVal2 (or (AELgetStringProp ilInst 'l2name) ""))
		       (when (nequal "" tmpVal2)
			   (setq tmpVal2 (or (AELgetStringProp ilInst 'k) ""))
			   (when (nequal "" tmpVal2)
			       (setq tmpVal2 (strcat "k=" tmpVal2))
			   )
		       )
		      )
		  )
		  (cond
		      ((and tmpVal1 tmpVal2
			    (nequal "" tmpVal1) (nequal "" tmpVal2))
		       (strcat tmpVal1 ", " tmpVal2)
		      )
		      (t
		       (strcat tmpVal1 tmpVal2)
		      )
		  )
		 )
		 (4
		  (setq tmpVal1 ilInst~>indType)
		  (cond
		      ((or (null tmpVal1) (equal "Normal" tmpVal1))
		       (setq tmpVal1 (or (AELgetStringProp ilInst 'k) ""))
		       (when (nequal "" tmpVal1)
			   (setq tmpVal1 (or (AELgetStringProp ilInst 'l2name) ""))
			   (when (nequal "" tmpVal1)
			       (strcat "coupled to " tmpVal1)
			   )
		       )
		      )
		      (t "")
		  )
		 )
		 (5 (CDFiter))
		 (6  (ANTdevOpba 'large))
		 (61 (ANTdevOpba 'medium))
		 (62 (ANTdevOpba 'small))
		 (9 (CDFterm "PLUS" ":i"))
		 (10 (CDFterm "MINUS"))
	     )
	    )
	    ((equal cellName "metop")
	     (case num
		 (1
		  (setq tmpVal1 (or (AELgetStringProp ilInst 'metopNumber) ""))
		  (cond
		      ((equal "" tmpVal1) "ERROR")
		      (t tmpVal1)
		  )
		 )
		 (2 (CDFname))
		 (3 (CDFlogic))
		 (4 (CDFiter))
	     )
	    )
	    ((or (equal cellName "ncap2") (equal cellName "pcap2"))
	     (CDFthinoxCapLabels num)
	    )
	    ((equal cellName "short")
	     (case num
		 (1 (CDFname))
		 (2 (CDFiter))
		 (3 (CDFlogic))
	     )
	    )
	    ((equal cellName "transLine")
	     (case num
		 (1 (CDFname))
		 (2 (strcat "TD=" (or (AELgetStringProp ilInst 'TD) "")))
 		 (3 (strcat "L=" (or (AELgetStringProp ilInst 'L) "")))
  		 (4 (strcat "Z0=" (or (AELgetStringProp ilInst 'Z0) "")))
		 (7  (ANTdevOpba 'large))
		 (71 (ANTdevOpba 'medium))
		 (72 (ANTdevOpba 'small))
		 (8 (CDFterm "in" ":i1"))
		 (9 (CDFterm "refin"))
		 (10 (CDFterm "out" ":i2"))
		 (11 (CDFterm "refout"))
	     )
	    )
	    ((member cellName '("res" "res3" "rescap" "resn" "resnw" "resp" "respw" "rcon" "reslocsub"))
	     (CDFresLabels num)
	    )
            ((member cellName '("gres3"))
              (CDFgresLabels num)
            )
	    ((member cellName '("subres" "subresw"))
	     (case num
		 (1
		  (setq tmpVal1 (AELgetStringProp ilInst 'model))
		  (when (or (null tmpVal1) (equal "" tmpVal1))
		      (setq tmpVal1 "ERROR_no_model")
		  )
		  tmpVal1
		 )
		 (2 (strcat "w=" (AELgetStringProp ilInst 'w)))
		 (3 (strcat "l=" (AELgetStringProp ilInst 'l)))
	     )
	    )
	    ;; end of the passive

	    ;; logic gates
	    ((equal cellName "bkeep_p")
	     (case num
		 (1 (CDFname))
		 (3 (CDFwlm 'pwa 'pla 'pma))
		 (4 (CDFwlm 'nwa 'nla 'nma))
		 (7 (CDFwlm 'pwb 'plb 'pmb))
		 (8 (CDFwlm 'nwb 'nlb 'nmb))
		 (10 (CDFsubcktMult))
		 (11 (CDFiter))
		 (12 (CDFlogic))
		 (13 (CDFterm "out"))
		 (14 (CDFterm "vpwr"))
		 (15 (CDFterm "vgnd"))
	     )
	    )
	    ((equal cellName "csw_p")
	     (case num
		 (1 (CDFname))
		 (3 (CDFwlm 'pw 'pl 'pm))
		 (4 (CDFwlm 'nw 'nl 'nm))
		 (6 (CDFsubcktMult))
		 (7 (CDFiter))
		 (8 (CDFlogic))
		 (9 (CDFterm "d"))
		 (10 (CDFterm "s"))
		 (11 (CDFterm "gp"))
		 (12 (CDFterm "gn"))
	     )
	    )
	    ((equal cellName "einv_p")
	     (case num
		 (1 (CDFname))
		 (2 (CDFwlm 'pw0 'pl0 'pm0))
		 (3 (CDFwlm 'pw1 'pl1 'pm1))
		 (6 (CDFwlm 'nw0 'nl0 'nm0))
		 (7 (CDFwlm 'nw1 'nl1 'nm1))
		 (10 (CDFsubcktMult))
		 (11 (CDFiter))
		 (12 (CDFlogic))
		 (13 (CDFterm "p0"))
		 (14 (CDFterm "p1"))
		 (15 (CDFterm "n0"))
		 (16 (CDFterm "n1"))
		 (17 (CDFterm "out"))
		 (18 (CDFterm "vpwr"))
		 (19 (CDFterm "vgnd"))
	     )
	    )
	    ((equal cellName "inv_p")
	     (case num
		 (1 (CDFname))
		 (3 (CDFwlm 'pw 'pl 'pm))
		 (4 (CDFwlm 'nw 'nl 'nm))
		 (6 (CDFsubcktMult))
		 (7 (CDFiter))
		 (8 (CDFlogic))
		 (9 (CDFterm "in0"))
		 (10 (CDFterm "out"))
		 (11 (CDFterm "vpwr"))
		 (12 (CDFterm "vgnd"))
	     )
	    )
	    ((equal cellName "nand2_p")
	     (case num
		 (1 (CDFname))
		 (3 (CDFwlmChain 'p 0 1))
		 (4 (CDFwlm 'nw0 'nl0 'nm0))
		 (5 (CDFwlmIfDiff 'nw 'nl 'nm 1 1))
		 (8 (CDFsubcktMult))
		 (9 (CDFiter))
		 (10 (CDFlogic))
		 (11 (CDFterm "in0"))
		 (12 (CDFterm "in1"))
		 (13 (CDFterm "out"))
		 (14 (CDFterm "vpwr"))
		 (15 (CDFterm "vgnd"))
	     )
	    )
	    ((equal cellName "nand2s_p")
	     (case num
		 (1 (CDFname))
		 (3 (CDFwlm 'pw 'pl 'pm))
		 (4 (strcat "2* (" (CDFwlm 'nw 'nl 'nm) ")"))
		 (6 (CDFsubcktMult))
		 (7 (CDFiter))
		 (8 (CDFlogic))
		 (9 (CDFterm "in0"))
		 (10 (CDFterm "in1"))
		 (11 (CDFterm "out"))
		 (12 (CDFterm "vpwr"))
		 (13 (CDFterm "vgnd"))
	     )
	    )
	    ((equal cellName "nand3_p")
	     (case num
		 (1 (CDFname))
		 (3 (CDFwlmChain 'p 0 2))
		 (4 (CDFwlm 'nw0 'nl0 'nm0))
		 (5 (CDFwlmIfDiff 'nw 'nl 'nm 1 2))
		 (6 (CDFwlmIfDiff 'nw 'nl 'nm 2 2))
		 (10 (CDFsubcktMult))
		 (11 (CDFiter))
		 (12 (CDFlogic))
		 (13 (CDFterm "in0"))
		 (14 (CDFterm "in1"))
		 (15 (CDFterm "in2"))
		 (16 (CDFterm "out"))
		 (17 (CDFterm "vpwr"))
		 (18 (CDFterm "vgnd"))
	     )
	    )
	    ((equal cellName "nand4_p")
	     (case num
		 (1 (CDFname))
		 (3 (CDFwlmChain 'p 0 3))
		 (4 (CDFwlm 'nw0 'nl0 'nm0))
		 (5 (CDFwlmIfDiff 'nw 'nl 'nm 1 3))
		 (6 (CDFwlmIfDiff 'nw 'nl 'nm 2 3))
		 (7 (CDFwlmIfDiff 'nw 'nl 'nm 3 3))
		 (12 (CDFsubcktMult))
		 (13 (CDFiter))
		 (14 (CDFlogic))
		 (15 (CDFterm "in0"))
		 (16 (CDFterm "in1"))
		 (17 (CDFterm "in2"))
		 (18 (CDFterm "in3"))
		 (19 (CDFterm "out"))
		 (20 (CDFterm "vpwr"))
		 (21 (CDFterm "vgnd"))
	     )
	    )
	    ((equal cellName "nand5_p")
	     (case num
		 (1 (CDFname))
		 (3 (CDFwlmChain 'p 0 4))
		 (4 (CDFwlm 'nw0 'nl0 'nm0))
		 (5 (CDFwlmIfDiff 'nw 'nl 'nm 1 4))
		 (6 (CDFwlmIfDiff 'nw 'nl 'nm 2 4))
		 (7 (CDFwlmIfDiff 'nw 'nl 'nm 3 4))
		 (8 (CDFwlmIfDiff 'nw 'nl 'nm 4 4))
		 (14 (CDFsubcktMult))
		 (15 (CDFiter))
		 (16 (CDFlogic))
		 (17 (CDFterm "in0"))
		 (18 (CDFterm "in1"))
		 (19 (CDFterm "in2"))
		 (20 (CDFterm "in3"))
		 (21 (CDFterm "in4"))
		 (22 (CDFterm "out"))
		 (23 (CDFterm "vpwr"))
		 (24 (CDFterm "vgnd"))
	     )
	    )
	    ((equal cellName "nor2_p")
	     (case num
		 (1 (CDFname))
		 (2 (CDFwlm 'pw0 'pl0 'pm0))
		 (3 (CDFwlmIfDiff 'pw 'pl 'pm 1 1))
		 (6 (CDFwlmChain 'n 0 1))
		 (8 (CDFsubcktMult))
		 (9 (CDFiter))
		 (10 (CDFlogic))
		 (11 (CDFterm "in0"))
		 (12 (CDFterm "in1"))
		 (13 (CDFterm "out"))
		 (14 (CDFterm "vpwr"))
		 (15 (CDFterm "vgnd"))
	     )
	    )
	    ((equal cellName "nor2s_p")
	     (case num
		 (1 (CDFname))
		 (3 (strcat "2* (" (CDFwlm 'pw 'pl 'pm) ")"))
		 (4 (CDFwlm 'nw 'nl 'nm))
		 (6 (CDFsubcktMult))
		 (7 (CDFiter))
		 (8 (CDFlogic))
		 (9 (CDFterm "in0"))
		 (10 (CDFterm "in1"))
		 (11 (CDFterm "out"))
		 (12 (CDFterm "vpwr"))
		 (13 (CDFterm "vgnd"))
	     )
	    )
	    ((equal cellName "nor3_p")
	     (case num
		 (1 (CDFname))
		 (2 (CDFwlm 'pw0 'pl0 'pm0))
		 (3 (CDFwlmIfDiff 'pw 'pl 'pm 1 2))
		 (4 (CDFwlmIfDiff 'pw 'pl 'pm 2 2))
		 (8 (CDFwlmChain 'n 0 2))
		 (10 (CDFsubcktMult))
		 (11 (CDFiter))
		 (12 (CDFlogic))
		 (13 (CDFterm "in0"))
		 (14 (CDFterm "in1"))
		 (15 (CDFterm "in2"))
		 (16 (CDFterm "out"))
		 (17 (CDFterm "vpwr"))
		 (18 (CDFterm "vgnd"))
	     )
	    )
	    ((equal cellName "nor4_p")
	     (case num
		 (1 (CDFname))
		 (2 (CDFwlm 'pw0 'pl0 'pm0))
		 (3 (CDFwlmIfDiff 'pw 'pl 'pm 1 3))
		 (4 (CDFwlmIfDiff 'pw 'pl 'pm 2 3))
		 (5 (CDFwlmIfDiff 'pw 'pl 'pm 3 3))
		 (10 (CDFwlmChain 'n 0 3))
		 (12 (CDFsubcktMult))
		 (13 (CDFiter))
		 (14 (CDFlogic))
		 (15 (CDFterm "in0"))
		 (16 (CDFterm "in1"))
		 (17 (CDFterm "in2"))
		 (18 (CDFterm "in3"))
		 (19 (CDFterm "out"))
		 (20 (CDFterm "vpwr"))
		 (21 (CDFterm "vgnd"))
	     )
	    )
	    ((equal cellName "xnor2_p")
	     (case num
		 (1 (CDFname))
		 (2 (CDFwlm 'pw0 'pl0 'pm0))
		 (3 (CDFwlmIfDiff 'pw 'pl 'pm 1 1))
		 (6 (CDFwlmChain 'n 0 1))
		 (8 (CDFsubcktMult))
		 (9 (CDFiter))
		 (10 (CDFlogic))
		 (11 (CDFterm "in0"))
		 (12 (CDFterm "in1"))
		 (13 (CDFterm "out"))
		 (14 (CDFterm "vpwr"))
		 (15 (CDFterm "vgnd"))
	     )
	    )

	    ;; basic (?) fets, that have all kinds of crap around them
	    ((member cellName '("pfet" "pfetesd" "pfetextd" "pvhv"))
	     (CDFpfetLabels num cellName)
	    )
	    ((member cellName '("nfet" "fnfet" "hvacell" "hvscell" "nwcap" "nfetesd" "dfet" "nfetextd" "nfetextdiso" "nvhv"))
	     (CDFnfetLabels num cellName)
	    )
	    ((equal cellName "fafetr")
	     (cond
		 ((lessp num 40)
		  (CDFnfetLabels num cellName)
		 )
		 (t
		  (case num
		      (40
		       (setq tmpVal1 ilInst~>isErase)
		       (cond
			   ((and tmpVal1 (nequal "FALSE" tmpVal1))
			    "Erase"
			   )
			   (t "")
		       )
		      )
		  )
		 )
	     )
	    )
	    ((equal cellName "fafetw")
	     (cond
		 ((lessp num 40)
		  (CDFnfetLabels num cellName)
		 )
		 (t
		  (case num
		      (40
		       (setq tmpVal1 ilInst~>isReadable)
		       (cond
			   ((and tmpVal1 (nequal "FALSE" tmpVal1))
			    "Readable"
			   )
			   (t "")
		       )
		      )
		  )
		 )
	     )
	    )
	    ((equal cellName "fafetp")
	     (case num
		 (1 (CDFname))
		 (2 (CDFiter))
		 (3
		  (setq tmpVal1 (AELgetStringProp ilInst 'm))
		  (setq tmpVal2 (AELgetStringProp ilInst 'w))
		  (setq tmpVal3 (AELgetStringProp ilInst 'l))
		  (cond
		      ((or (null tmpVal1)
			   (equal "1" tmpVal1)
			   (equal "" tmpVal1)
		       )
		       (setq tmpVal1 "")
		      )
		      (t (setq tmpVal1 (strcat tmpVal1 "*")))
		  )
		  (cond
		      ((or (null tmpVal2) (equal "" tmpVal2))
		       (setq tmpVal2 "ERROR_no_cw")
		      )
		      (ilInst~>hide_w
		       (setq tmpVal2 "")
		      )
		  )
		  (cond
		      ((or (null tmpVal3) (equal "" tmpVal3))
		       (setq tmpVal3 "ERROR_no_cl")
		      )
		      (ilInst~>hide_l
		       (setq tmpVal3 "")
		      )
		      (t (setq tmpVal3 (strcat "/" tmpVal3)))
		  )
		  (strcat tmpVal1 tmpVal2 tmpVal3)
		 )
		 (4
		  (setq tmpVal1 ilInst~>isRing)
		  (cond
		      ((and tmpVal1 (nequal "FALSE" tmpVal1))
		       "RING"
		      )
		      (t "")
		  )
		 )
	     )
	    )
	    ;; magnetic tunnel junction
	    ((equal cellName "mtj")
	     (case num
	       (1 (CDFname))
	       (2 (CDFiter))
	       (3 (setq tmpVal1 (AELgetStringProp ilInst 'mm))
		  (cond
		   ((null tmpVal1) "")
		   ((or (equal "1" tmpVal1) (equal "" tmpVal1)) "")
		   (t (strcat "m=" tmpVal1))
		   )
		)
	       (4
		(setq tmpVal1 (AELgetStringProp ilInst 'model))
		(when (or (null tmpVal1) (equal "" tmpVal1))
		  (setq tmpVal1 "ERROR_no_model")
		  )
		tmpVal1
		)
	       (t "")
	     )
	    )
	    ;; magnetic tunnel junction 5 term device
	    ((equal cellName "mtj5")
	     (case num
	       (1 (CDFname))
	       (2 (CDFiter))
	       (3 (setq tmpVal1 (AELgetStringProp ilInst 'mm))
		  (cond
		   ((null tmpVal1) "")
		   ((or (equal "1" tmpVal1) (equal "" tmpVal1)) "")
		   (t (strcat "m=" tmpVal1))
		   )
		  )
	       (4
		(setq tmpVal1 (AELgetStringProp ilInst 'modelName))
		(when (or (null tmpVal1) (equal "" tmpVal1))
		  (setq tmpVal1 "ERROR_no_model")
		  )
		tmpVal1
						)
	       (t "")
	       )
	     )

	    ;; refCell 5 term device
	    ((equal cellName "refCell")
	     (case num
	       (1 (CDFname))
	       (2 (CDFiter))
	       (3 (setq tmpVal1 (AELgetStringProp ilInst 'm))
		  (cond
		   ((null tmpVal1) "")
		   ((or (equal "1" tmpVal1) (equal "" tmpVal1)) "")
		   (t (strcat "m=" tmpVal1))
		   )
		  )
	       (4
		(setq tmpVal1 ilInst~>modelName)
		(when (or (null tmpVal1) (equal "" tmpVal1))
		  (setq tmpVal1 "ERROR_no_model")
		  )
		tmpVal1
		)
	       )
         )
	     
	     ;; memCell 5 term device
	     ((equal cellName "memCell")
	      (case num
		(1 (CDFname))
		(2 (CDFiter))
		(3 (setq tmpVal1 (AELgetStringProp ilInst 'm))
		   (cond
		    ((null tmpVal1) "")
		    ((or (equal "1" tmpVal1) (equal "" tmpVal1)) "")
		    (t (strcat "m=" tmpVal1))
		    )
		   )
		(4
		 (setq tmpVal1 ilInst~>modelName)
		 (when (or (null tmpVal1) (equal "" tmpVal1))
		   (setq tmpVal1 "ERROR_no_model")
		   )
		 tmpVal1
		 )
		)
    )


;; condiode 2 term device
	     
	     ((or (member cellName '("condiode")) (member cellName '("condiode_grid")))
	      (setq condiodeSimulatable (cdfGetInstCDF ilInst)~>simulatable~>value)
	      (case num
		(1 (CDFname))
		(2 (cond
		    (condiodeSimulatable
		     (or ilInst~>simmodel ilInst~>hspiceModel "ERROR"))
		    (t
		     "condiode")
		    ))
		(3 (CDFiter))
		(4 (cond
		    (condiodeSimulatable
		     (setq tmpVal1 (AELgetStringProp ilInst 'area))
		     (setq tmpVal2 (AELgetStringProp ilInst 'perim))
		     (setq tmpVal1Num (aelNumber tmpVal1))
		     (setq tmpVal2Num (aelNumber tmpVal2))
		     (cond
		      ((or  (not tmpVal2Num ) (not tmpVal1Num )  (and tmpVal1Num (not (greaterp  tmpVal1Num 0))) (and tmpVal2Num (not (greaterp tmpVal2Num 0))))
		       (strcat "A=" tmpVal1 "p and P=" tmpVal2 "u"))
		      (t
		       (strcat "A=" tmpVal1 "p"))
		     ))
		    (t
		     "not simulatable")
		    ))
		(5 (cond
		    (condiodeSimulatable
		     (setq tmpVal1 (AELgetStringProp ilInst 'area))
		     (setq tmpVal2 (AELgetStringProp ilInst 'perim))
		     (setq tmpVal1Num (aelNumber tmpVal1))
		     (setq tmpVal2Num (aelNumber tmpVal2))
		     (cond
		      ((or  (not tmpVal2Num ) (not tmpVal1Num )  (and tmpVal1Num (not (greaterp  tmpVal1Num 0))) (and tmpVal2Num (not (greaterp tmpVal2Num 0))))
		       (strcat "WILL NOT EXTRACT"))
		      (t
		       (strcat "P=" tmpVal2 "u"))
		      ))
		    (t
		     "not simulatable")
		    ))
		(6 (cond
		    (condiodeSimulatable
		     (setq tmpVal1 (AELgetStringProp ilInst 'm))
		     (cond
		      ((or (equal "1" tmpVal1) (equal "" tmpVal1)) "")
		      (t (strcat "m=" tmpVal1))
		      ))
		    (t
		     "")
		    ))
		(7 (cond 
		    (condiodeSimulatable
		     (setq tmpVal1 ilInst~>isPtype)
		     (cond
		      ((and tmpVal1 (nequal "FALSE" tmpVal1)) "O")
		      (t "")
		      ))
		    (t
		     "")
		    ))
		(8 (CDFterm "d0" ":i"))
		(9 (CDFterm "d1"))
		)
	      )
	     

	      ;; 3 term LVS inductor
	    ((equal cellName "ind3")
	     (case num
	       (1 (CDFname))
	       (2 (CDFiter))
	       (3
		(setq tmpVal1 ilInst~>modelName)
		(when (or (null tmpVal1) (equal "" tmpVal1))
		  (setq tmpVal1 "ERROR_no_model")
		)
		tmpVal1
	       )
	       (4 (setq tmpVal1 "")
		(foreach ind (TECHgetInd3Devices "ind3")
		   (when (equal ilInst~>modelName (TECHgetDeviceParam ind 'hspiceModel))
		     (setq tmpVal1 (TECHgetDeviceParam ind 'lValue))
		     (setq tmpVal1 (strcat "L=" tmpVal1))
		    )
		 ) ;;end foreach
		tmpVal1
	       )
	       (5 (setq tmpVal1 "")
		(foreach ind (TECHgetInd3Devices "ind3")
		   (when (equal ilInst~>modelName (TECHgetDeviceParam ind 'hspiceModel))
		     (setq tmpVal1 (TECHgetDeviceParam ind 'qMaxValue))
		     (setq tmpVal1 (strcat "Qmax=" tmpVal1))
		    )
		 ) ;;end foreach
		tmpVal1
	       )
	       (9 (CDFterm "t1" ":i"))
	       (10 (CDFterm "t2"))
	       (11 (CDFterm "body"))
	       (t "")
	     )
	    )
	    ;; 4 term LVS inductor
	    ((equal cellName "ind4")
	     (case num
	       (1 (CDFname))
	       (2 (CDFiter))
	       (3
		(setq tmpVal1 ilInst~>modelName)
		(when (or (null tmpVal1) (equal "" tmpVal1))
		  (setq tmpVal1 "ERROR_no_model")
		)
		tmpVal1
	       )
	       (4 (setq tmpVal1 "")
		(foreach ind (TECHgetInd3Devices "ind4")
		   (when (equal ilInst~>modelName (TECHgetDeviceParam ind 'hspiceModel))
		     (setq tmpVal1 (TECHgetDeviceParam ind 'lValue))
		     (setq tmpVal1 (strcat "L=" tmpVal1))
		    )
		 ) ;;end foreach
		tmpVal1
	       )
	       (5 (setq tmpVal1 "")
		(foreach ind (TECHgetInd3Devices "ind4")
		   (when (equal ilInst~>modelName (TECHgetDeviceParam ind 'hspiceModel))
		     (setq tmpVal1 (TECHgetDeviceParam ind 'qMaxValue))
		     (setq tmpVal1 (strcat "Qmax=" tmpVal1))
		    )
		 ) ;;end foreach
		tmpVal1
	       )
	       (9 (CDFterm "t1" ":i"))
	       (10 (CDFterm "t2"))
	       (11 (CDFterm "t3"))
	       (12 (CDFterm "body"))
	       (t "")
	     )
	    )
	    ((equal cellName "npn4")
	     (setq isSubckt ilInst~>isSubckt)
	     (when (equal "FALSE" ilInst~>isSubckt)
		 (setq isSubckt nil)
	     )
	     (case num
		 (1 (CDFname))
		 (2 (CDFiter))
		 (3
		  (setq tmpVal1 ilInst~>modelName)
		  (when (or (null tmpVal1) (equal "" tmpVal1))
		      (setq tmpVal1 "ERROR_no_model")
		  )
		  tmpVal1
		 )
		 (4
		  (setq tmpVal1 (AELgetStringProp ilInst 'm))
		  (cond
		      ((null tmpVal1) "")
		      ((or (equal "1" tmpVal1) (equal "" tmpVal1)) "")
		      (t (strcat "m=" tmpVal1))
		  )
		 )

		 ;; the 5* family is the emitter node voltage
		 (50 (CDFterm "e" (and (null isSubckt) ":e")))
		 ;; (51 (CY_OPCvoltage "e"))
		 ;; (52 (CY_OPDvoltage "e"))

		 ;; the 6* family is the base node voltage
		 (60 (CDFterm "b" (and (null isSubckt) ":b")))
		 ;; (61 (CY_OPCvoltage "b"))
		 ;; (62 (CY_OPDvoltage "b"))

		 ;; the 7* family is the collector node voltage
		 (70 (CDFterm "c" (and (null isSubckt) ":c")))
		 ;; (71 (CY_OPCvoltage "c"))
		 ;; (72 (CY_OPDvoltage "c"))

		 ;; the 8* family is the body node voltage
		 (80 (CDFterm "body" (and (null isSubckt) ":s")))
		 ;; (81 (CY_OPCvoltage "body"))
		 ;; (82 (CY_OPDvoltage "body"))

		 ;; the 9* family is the model back annotation
		 (90 (or (ANTdevOpba 'large "Q" )
			 (CDFwmOpBa CY_OP_FontSizeStr 0)))
		 (91 (or (ANTdevOpba 'medium "Q" )
			 (CDFwmOpBa CY_OP_FontSizeStr 1)))
		 (92 (or (ANTdevOpba 'small "Q" )
			 (CDFwmOpBa CY_OP_FontSizeStr 2)))

	     )
	    )
	    ((equal cellName "pnp4")
	     (case num
		 (1 (CDFname))
		 (2 (CDFiter))
		 (3
		  (setq tmpVal1 ilInst~>modelName)
		  (when (or (null tmpVal1) (equal "" tmpVal1))
		      (setq tmpVal1 "ERROR_no_model")
		  )
		  tmpVal1
		 )
		 (4
		  (setq tmpVal1 (AELgetStringProp ilInst 'm))
		  (cond
		      ((null tmpVal1) "")
		      ((or (equal "1" tmpVal1) (equal "" tmpVal1)) "")
		      (t (strcat "m=" tmpVal1))
		  )
		 )
		 (5
		  (setq tmpVal1 ilInst~>hide_evs)
		  (setq tmpVal2 ilInst~>evs)
		  (cond
		      ((and tmpVal1 tmpVal2
			    (nequal "FALSE" tmpVal1) (nequal "FALSE" tmpVal2))
		       "<--"
		      )
		      (t "")
		  )
		 )
		 (6
		  (setq tmpVal1 ilInst~>hide_bvs)
		  (setq tmpVal2 ilInst~>bvs)
		  (cond
		      ((and tmpVal1 tmpVal2
			    (nequal "FALSE" tmpVal1) (nequal "FALSE" tmpVal2))
		       "-->"
		      )
		      (t "")
		  )
		 )
		 (7
		  (setq tmpVal1 ilInst~>hide_cvs)
		  (setq tmpVal2 ilInst~>cvs)
		  (cond
		      ((and tmpVal1 tmpVal2
			    (nequal "FALSE" tmpVal1) (nequal "FALSE" tmpVal2))
		       "<--"
		      )
		      (t "")
		  )
		 )
		 (8 (CDFterm "e" ":e"))
		 (9 (CDFterm "b" ":b"))
		 (10 (CDFterm "c" ":c"))
		 (11 (CDFterm "body" ":s"))
		 (12  (ANTdevOpba 'large))
		 (121 (ANTdevOpba 'medium))
		 (122 (ANTdevOpba 'small))
	     )
	    )

	    ;; miscl items
	    ((equal cellName "cds_thru")
	     (case num
		 (1 (CDFname))
	     )
	    )
	    ((equal cellName "term")
	     (case num
		 (1 (CDFname))
	     )
	    )
	    ((equal cellName "hvforce")
	     (case num
		 (1 (or ilInst~>vtype "No voltage"))
	     )
	    )
	    ((equal cellName "patch")
	     (case num
		 (1 (CDFname))
		 (2 ilInst~>schPatchExpr)
	     )
	    )
	    ((member cellName '("opin" "ipin" "iopin" "sympin"))
	     (case num
		 (1
		  (cond
		      ;; The Antrim net property for specifying a discipline
		      ;; is just "discipline".  The Cadence AMS net property
		      ;; for specifying a discipline is "netDiscipline".
		      ;; For now, only support the Antrim method.
		      ;;
		      ((and (setq tmpVal1 ilInst~>pin~>term~>net~>discipline)
			    (stringp tmpVal1)
			    (null (ENVgetVal "schematic" "hideNetDisciplines"))
		       )
		       (strcat ilInst~>pin~>term~>name " (" tmpVal1 ")")
		      )
		      (t
		       ilInst~>pin~>term~>name
		      )
		  )
		 )
	     )
	    )
	    ((member cellName '("title10" "title15" "title20"))
	     (case num
		 (1 (or ilInst~>engineer ""))
		 (2 (or ilInst~>partName ""))
		 (3 (or ilInst~>dieSize ""))
		 (4 (or ilInst~>packageType ""))
		 (5 (or ilInst~>cavitySize ""))
		 (6 (or ilInst~>date ""))
	     )
	    )

	    ((member cellName '("diode" "lvsdiode" "tdiode"))
	     (case num
		 (1 (CDFname))
		 (2 (or ilInst~>model ilInst~>hspiceModel "ERROR"))
		 (3 (CDFiter))
		 (4 (strcat "A=" (AELgetStringProp ilInst 'area) "p"))
		 (5 (strcat "P=" (AELgetStringProp ilInst 'perim) "u"))
		 (6
		  (setq tmpVal1 (AELgetStringProp ilInst 'm))
		  (cond
		      ((or (equal "1" tmpVal1) (equal "" tmpVal1)) "")
		      (t (strcat "m=" tmpVal1))
		  )
		 )
		 (7 (CDFlogic))
		 (8
		  (setq tmpVal1 ilInst~>isPtype)
		  (cond
		      ((and tmpVal1 (nequal "FALSE" tmpVal1)) "O")
		      (t "")
		  )
		 )
		 (9 (CDFterm "d0" ":i"))
		 (10 (CDFterm "d1"))
		 (11  (ANTdevOpba 'large))
		 (111 (ANTdevOpba 'medium))
		 (112 (ANTdevOpba 'small))
	     )
	    )
            ;; wavemaster probe symbols

	    ((equal cellName "wmip")
	     (case num
		 (1 (CDFname))
		 (2 (or (ANTdevOpba 'large)
			(CDFwmOpBa CY_OPPV_FontSizeStr 0)))
		 (21 (or (ANTdevOpba 'medium)
			 (CDFwmOpBa CY_OPPV_FontSizeStr 1)))
		 (22 (or (ANTdevOpba 'small)
			 (CDFwmOpBa CY_OPPV_FontSizeStr 2)))
	     )
	    )
	    ((equal cellName "wmvp")
	     (case num
		 (1 (CDFterm "p" nil t))
	     )
	    )

	    ((equal cellName "bagp")

	     ;; first of all, get the general display parameters
	     (when (and ilInst~>showGenParams
			(nequal "FALSE" ilInst~>showGenParams))
		 (setq tmpVal1 (ANTgeneralDisplay))
	     )
	     (setq tmpVal2 (setof x (list ilInst~>param0 ilInst~>param1
					  ilInst~>param2 ilInst~>param3)
				  (and x (nequal "" x))))
	     (when tmpVal2
		 (setq tmpVal2 (ANTgeneralDisplay tmpVal2))
	     )
	     (setq tmpVal1 (strcat (or tmpVal1 "") (or tmpVal2 "")))

	     (case num
		 ;; font size control
		 (2  (ANTdisplayIfFontMatches 'large tmpVal1))
		 (21 (ANTdisplayIfFontMatches 'medium tmpVal1))
		 (22 (ANTdisplayIfFontMatches 'small tmpVal1))
	     )
	    )
	    ((equal cellName "batm")
	     (setq tmpVal1 (or (ANTtermMath ilInst)
			       (SPCtermMath ilInst)))

	     (case num
		 ;; font size control
		 (2  (ANTdisplayIfFontMatches 'large tmpVal1))
		 (21 (ANTdisplayIfFontMatches 'medium tmpVal1))
		 (22 (ANTdisplayIfFontMatches 'small tmpVal1))

		 ;; terminal voltages for t0 and t1
		 (3 (CDFterm "t0"))
		 (4 (CDFterm "t1"))
	     )
	    )

	    ;; for something else, it is unknown
	    (t "UNKNOWN")
	)
    )
)

(defun CDFpfetLabels (num cellName "xtg")
    (let (retVal tmpVal1 tmpVal2 diodeSize LODSize)

      ;;(setq LODSize (ENVgetVal "schematic" "LODFontSize"))
      ;;(setq diodeSize (ENVgetVal "schematic" "diodeFontSize"))
  ;;    (setq displayLOD (ENVgetVal "schematic" "displayLOD"))

	(case num

	    ;; 1 through 6 and 15-16 are on the LHS, 7 through 14 are on the RHS

	    (1
	     (setq tmpVal1 (CDFdelvto))
	     (setq tmpVal2 (CDFspiceModel cellName))
	     (cond
		 ((and (nequal "" tmpVal1) (nequal "" tmpVal2))
		  (setq retVal (strcat tmpVal1 ", " tmpVal2))
		 )
		 (t (setq retVal (strcat tmpVal1 tmpVal2)))
	     )
	    )

	    (2 (setq retVal (CDFterm "s" ":s")))
	    (3 (setq retVal (CDFterm "g" ":g")))
	    (4 (setq retVal (CDFname)))

	    (5
	     ;; we are trying to merge a bunch of crap into one display.
	     ;; max of "iter, ttype, ltype, topography, maxv"
	     (setq tmpVal1 (CDFiter))
	     (setq tmpVal2 (CDFtopography))
	     (cond
		 ((and (nequal "" tmpVal1) (nequal "" tmpVal2))
		  (setq tmpVal1 (strcat tmpVal1 ", " tmpVal2))
		 )
		 (t (setq tmpVal1 (strcat tmpVal1 tmpVal2)))
		 )
	     (setq tmpVal2 (CDFdeepNwell))
	     (cond
	      ((and (nequal "" tmpVal1) (nequal "" tmpVal2))
	       (setq retVal (strcat tmpVal1 ", " tmpVal2))
	       )
	      (t (setq retVal (strcat tmpVal1 tmpVal2)))
	      )
	     )
	    
	    (6 (setq retVal (CDFterm "d" ":d")))

	    ;; end of LHS, beginning of RHS

	    (7  (when (equal diodeSize "large")  (setq retVal (CDFmanualDiode 'as))))
	    (71 (when (equal diodeSize "medium") (setq retVal (CDFmanualDiode 'as))))
	    (72 (when (equal diodeSize "small")  (setq retVal (CDFmanualDiode 'as))))

	    (8 (when (equal diodeSize "large")
	     (cond
		 ((and (setq tmpVal1 (dbGet ilInst 'manualDiodes))
		       (nequal "FALSE" tmpVal1))
		  (setq tmpVal1 (CDFmanualDiode 'ps))
		  (setq tmpVal2 (AELgetStringProp ilInst 'nrs))
		  (setq retVal tmpVal1)
		  (when (nequal "0" tmpVal2)
		      (setq retVal (strcat tmpVal1 ", nrs=" tmpVal2))
		  )
		  retVal
		 )
		 (t
		  (setq tmpVal1 (CDFmanualDiodeMethod 's))
		  (when (equal "" tmpVal1) (setq tmpVal1 nil))
		  (setq tmpVal2 (AELgetStringProp ilInst 'srcOffset))
		  (when (or (equal "0.0" tmpVal2) (equal "0" tmpVal2))
		      (setq tmpVal2 nil)
		  )
		  (cond
		      ((and tmpVal1 tmpVal2)
		       (setq retVal (strcat tmpVal1 ", srcOffset=" tmpVal2))
		      )
		      (tmpVal2
		       (setq retVal (strcat "srcOffset=" tmpVal2))
		      )
		      (t (setq retVal tmpVal1))
		  )
		  retVal
		 )
	     )
	    ))
	    (81 (when (equal diodeSize "medium")
	     (cond
		 ((and (setq tmpVal1 (dbGet ilInst 'manualDiodes))
		       (nequal "FALSE" tmpVal1))
		  (setq tmpVal1 (CDFmanualDiode 'ps))
		  (setq tmpVal2 (AELgetStringProp ilInst 'nrs))
		  (setq retVal tmpVal1)
		  (when (nequal "0" tmpVal2)
		      (setq retVal (strcat tmpVal1 ", nrs=" tmpVal2))
		  )
		  retVal
		 )
		 (t
		  (setq tmpVal1 (CDFmanualDiodeMethod 's))
		  (when (equal "" tmpVal1) (setq tmpVal1 nil))
		  (setq tmpVal2 (AELgetStringProp ilInst 'srcOffset))
		  (when (or (equal "0.0" tmpVal2) (equal "0" tmpVal2))
		      (setq tmpVal2 nil)
		  )
		  (cond
		      ((and tmpVal1 tmpVal2)
		       (setq retVal (strcat tmpVal1 ", srcOffset=" tmpVal2))
		      )
		      (tmpVal2
		       (setq retVal (strcat "srcOffset=" tmpVal2))
		      )
		      (t (setq retVal tmpVal1))
		  )
		  retVal
		 )
	     )
	    ))
	    (82 (when (equal diodeSize "small")
	     (cond
		 ((and (setq tmpVal1 (dbGet ilInst 'manualDiodes))
		       (nequal "FALSE" tmpVal1))
		  (setq tmpVal1 (CDFmanualDiode 'ps))
		  (setq tmpVal2 (AELgetStringProp ilInst 'nrs))
		  (setq retVal tmpVal1)
		  (when (nequal "0" tmpVal2)
		      (setq retVal (strcat tmpVal1 ", nrs=" tmpVal2))
		  )
		  retVal
		 )
		 (t
		  (setq tmpVal1 (CDFmanualDiodeMethod 's))
		  (when (equal "" tmpVal1) (setq tmpVal1 nil))
		  (setq tmpVal2 (AELgetStringProp ilInst 'srcOffset))
		  (when (or (equal "0.0" tmpVal2) (equal "0" tmpVal2))
		      (setq tmpVal2 nil)
		  )
		  (cond
		      ((and tmpVal1 tmpVal2)
		       (setq retVal (strcat tmpVal1 ", srcOffset=" tmpVal2))
		      )
		      (tmpVal2
		       (setq retVal (strcat "srcOffset=" tmpVal2))
		      )
		      (t (setq retVal tmpVal1))
		  )
		  retVal
		 )
	     )
	    ))


	    (9
	     (setq tmpVal1 (CDFwlm 'w 'l 'm))
	     (setq tmpVal2 (CDFlogic))
	     (cond
		 ((and (nequal "" tmpVal1) (nequal "" tmpVal2))
		  (setq retVal (strcat tmpVal1 ", " tmpVal2))
		 )
		 (t (setq retVal (strcat tmpVal1 tmpVal2)))
	     )
	    )

	    ;; 11 111 112 are device operating point back annotation locations
	    (11 (setq retVal (or (ANTdevOpba 'large "M")
				 (CDFwmOpBa CY_OP_FontSizeStr 0))))
	    (111 (setq retVal (or (ANTdevOpba 'medium "M")
				  (CDFwmOpBa CY_OP_FontSizeStr 1))))
	    (112 (setq retVal (or (ANTdevOpba 'small "M")
				  (CDFwmOpBa CY_OP_FontSizeStr 2))))

	    (13 (when (equal diodeSize "large")
	     (cond
		 ((and (setq tmpVal1 (dbGet ilInst 'manualDiodes))
		       (nequal "FALSE" tmpVal1))
		  (setq tmpVal1 (CDFmanualDiode 'pd))
		  (setq tmpVal2 (AELgetStringProp ilInst 'nrd))
		  (setq retVal tmpVal1)
		  (when (nequal "0" tmpVal2)
		      (setq retVal (strcat tmpVal1 ", nrd=" tmpVal2))
		  )
		  retVal
		 )
		 (t
		  (setq tmpVal1 (CDFmanualDiodeMethod 'd))
		  (when (equal "" tmpVal1) (setq tmpVal1 nil))
		  (setq tmpVal2 (AELgetStringProp ilInst 'drnOffset))
		  (when (or (equal "0.0" tmpVal2) (equal "0" tmpVal2))
		      (setq tmpVal2 nil)
		  )
		  (cond
		      ((and tmpVal1 tmpVal2)
		       (setq retVal (strcat tmpVal1 ", drnOffset=" tmpVal2))
		      )
		      (tmpVal2
		       (setq retVal (strcat "drnOffset=" tmpVal2))
		      )
		      (t (setq retVal tmpVal1))
		  )
		  retVal
		 )
	     )
	    ))
	    (131 (when (equal diodeSize "medium")
	     (cond
		 ((and (setq tmpVal1 (dbGet ilInst 'manualDiodes))
		       (nequal "FALSE" tmpVal1))
		  (setq tmpVal1 (CDFmanualDiode 'pd))
		  (setq tmpVal2 (AELgetStringProp ilInst 'nrd))
		  (setq retVal tmpVal1)
		  (when (nequal "0" tmpVal2)
		      (setq retVal (strcat tmpVal1 ", nrd=" tmpVal2))
		  )
		  retVal
		 )
		 (t
		  (setq tmpVal1 (CDFmanualDiodeMethod 'd))
		  (when (equal "" tmpVal1) (setq tmpVal1 nil))
		  (setq tmpVal2 (AELgetStringProp ilInst 'drnOffset))
		  (when (or (equal "0.0" tmpVal2) (equal "0" tmpVal2))
		      (setq tmpVal2 nil)
		  )
		  (cond
		      ((and tmpVal1 tmpVal2)
		       (setq retVal (strcat tmpVal1 ", drnOffset=" tmpVal2))
		      )
		      (tmpVal2
		       (setq retVal (strcat "drnOffset=" tmpVal2))
		      )
		      (t (setq retVal tmpVal1))
		  )
		  retVal
		 )
	     )
	    ))
	    (132 (when (equal diodeSize "small")
	     (cond
		 ((and (setq tmpVal1 (dbGet ilInst 'manualDiodes))
		       (nequal "FALSE" tmpVal1))
		  (setq tmpVal1 (CDFmanualDiode 'pd))
		  (setq tmpVal2 (AELgetStringProp ilInst 'nrd))
		  (setq retVal tmpVal1)
		  (when (nequal "0" tmpVal2)
		      (setq retVal (strcat tmpVal1 ", nrd=" tmpVal2))
		  )
		  retVal
		 )
		 (t
		  (setq tmpVal1 (CDFmanualDiodeMethod 'd))
		  (when (equal "" tmpVal1) (setq tmpVal1 nil))
		  (setq tmpVal2 (AELgetStringProp ilInst 'drnOffset))
		  (when (or (equal "0.0" tmpVal2) (equal "0" tmpVal2))
		      (setq tmpVal2 nil)
		  )
		  (cond
		      ((and tmpVal1 tmpVal2)
		       (setq retVal (strcat tmpVal1 ", drnOffset=" tmpVal2))
		      )
		      (tmpVal2
		       (setq retVal (strcat "drnOffset=" tmpVal2))
		      )
		      (t (setq retVal tmpVal1))
		  )
		  retVal
		 )
	     )
	    ))
	    (133  (setq tmpVal1 (dbGet ilInst 'addNoNoise))
	      (cond
	       ((and tmpVal1 (nequal "FALSE" tmpVal1))
	        (setq retVal "no noise")
	        retVal
	        )
	       (t 
	        (setq retVal "")
	        retVal
	        )
	       ))
	    (14  (when (equal diodeSize "large")  (setq retVal (CDFmanualDiode 'ad))))
	    (141 (when (equal diodeSize "medium") (setq retVal (CDFmanualDiode 'ad))))
	    (142 (when (equal diodeSize "small")  (setq retVal (CDFmanualDiode 'ad))))
            (15  (when (equal LODSize "large")    (setq retVal (CDFmanualLOD cellName))))
            (151 (when (equal LODSize "medium")   (setq retVal (CDFmanualLOD cellName))))
            (152 (when (equal LODSize "small")    (setq retVal (CDFmanualLOD cellName))))
            (16 (setq retVal (CDFmanualWPE cellName)))
	    (17 (when (TECHgetDeviceParam (CDFfetDeviceFromDbid ilInst cellName) 'useMultNF)
		  (setq retVal (strcat "m=" (AELgetStringProp ilInst 'mult)))))
	)

	retVal
    )
)

(defun CDFnfetLabels (num cellName "xtg")
    (let (retVal tmpVal1 tmpVal2 LODSize diodeSize)

     ;;(setq LODSize (ENVgetVal "schematic" "LODFontSize"))
     ;;(setq diodeSize (ENVgetVal "schematic" "diodeFontSize"))
;;     (setq displayLOD (ENVgetVal "schematic" "displayLOD"))

	(case num

	    ;; 1 through 6 and 15-16 are on the LHS, 7 through 14 are on the RHS

	    (1
	     (setq tmpVal1 (CDFdelvto))
	     (setq tmpVal2 (CDFspiceModel cellName))
	     (cond
		 ((and (nequal "" tmpVal1) (nequal "" tmpVal2))
		  (setq retVal (strcat tmpVal1 ", " tmpVal2))
		 )
		 (t (setq retVal (strcat tmpVal1 tmpVal2)))
	     )
	    )

	    (2 (setq retVal (CDFterm "d" ":d")))

	    (3
	     ;; we are trying to merge a bunch of crap into one display.
	     ;; theoretically, the maximum stuff displayed here may be
	     ;; *iter, nlowVt, esd, native, topography, maxv
	     ;;
	     (setq tmpVal1 (CDFiter))
	     (setq tmpVal2 (CDFtopography))
	     (cond
		 ((and (nequal "" tmpVal1) (nequal "" tmpVal2))
		  (setq tmpVal1 (strcat tmpVal1 ", " tmpVal2))
		 )
		 (t (setq tmpVal1 (strcat tmpVal1 tmpVal2)))
	     )
	    )

	    (4 (setq retVal (CDFterm "g" ":g")))
	    (5 (setq tmpVal1 (CDFname))
	       (setq tmpVal2 (CDFdeepNwell))
	       (cond
		   ((and (nequal "" tmpVal1) (nequal "" tmpVal2))
		    (setq retVal (strcat tmpVal1 ", " tmpVal2))
		   )
		   (t (setq retVal (strcat tmpVal1 tmpVal2)))
	       )
	    )
	    (6 (setq retVal (CDFterm "s" ":s")))

	    ;; end of LHS, beginning of RHS

	    (7  (when (equal diodeSize "large")  (setq retVal (CDFmanualDiode 'ad))))
	    (71 (when (equal diodeSize "medium") (setq retVal (CDFmanualDiode 'ad))))
	    (72 (when (equal diodeSize "small")  (setq retVal (CDFmanualDiode 'ad))))

	    (8 (when (equal diodeSize "large")
	     (cond
		 ((and (setq tmpVal1 (dbGet ilInst 'manualDiodes))
		       (nequal "FALSE" tmpVal1))
		  (setq tmpVal1 (CDFmanualDiode 'pd))
		  (setq tmpVal2 (AELgetStringProp ilInst 'nrd))
		  (setq retVal tmpVal1)
		  (when (nequal "0" tmpVal2)
		      (setq retVal (strcat tmpVal1 ", nrd=" tmpVal2))
		  )
		  retVal
		 )
		 (t
		  (setq tmpVal1 (CDFmanualDiodeMethod 'd))
		  (when (equal "" tmpVal1) (setq tmpVal1 nil))
		  (setq tmpVal2 (AELgetStringProp ilInst 'drnOffset))
		  (when (or (equal "0.0" tmpVal2) (equal "0" tmpVal2))
		      (setq tmpVal2 nil)
		  )
		  (cond
		      ((and tmpVal1 tmpVal2)
		       (setq retVal (strcat tmpVal1 ", drnOffset=" tmpVal2))
		      )
		      (tmpVal2
		       (setq retVal (strcat "drnOffset=" tmpVal2))
		      )
		      (t (setq retVal tmpVal1))
		  )
		  retVal
		 )
	     )
	    ))
	    (81 (when (equal diodeSize "medium")
	     (cond
		 ((and (setq tmpVal1 (dbGet ilInst 'manualDiodes))
		       (nequal "FALSE" tmpVal1))
		  (setq tmpVal1 (CDFmanualDiode 'pd))
		  (setq tmpVal2 (AELgetStringProp ilInst 'nrd))
		  (setq retVal tmpVal1)
		  (when (nequal "0" tmpVal2)
		      (setq retVal (strcat tmpVal1 ", nrd=" tmpVal2))
		  )
		  retVal
		 )
		 (t
		  (setq tmpVal1 (CDFmanualDiodeMethod 'd))
		  (when (equal "" tmpVal1) (setq tmpVal1 nil))
		  (setq tmpVal2 (AELgetStringProp ilInst 'drnOffset))
		  (when (or (equal "0.0" tmpVal2) (equal "0" tmpVal2))
		      (setq tmpVal2 nil)
		  )
		  (cond
		      ((and tmpVal1 tmpVal2)
		       (setq retVal (strcat tmpVal1 ", drnOffset=" tmpVal2))
		      )
		      (tmpVal2
		       (setq retVal (strcat "drnOffset=" tmpVal2))
		      )
		      (t (setq retVal tmpVal1))
		  )
		  retVal
		 )
	     )
	    ))
	    (82 (when (equal diodeSize "small")
	     (cond
		 ((and (setq tmpVal1 (dbGet ilInst 'manualDiodes))
		       (nequal "FALSE" tmpVal1))
		  (setq tmpVal1 (CDFmanualDiode 'pd))
		  (setq tmpVal2 (AELgetStringProp ilInst 'nrd))
		  (setq retVal tmpVal1)
		  (when (nequal "0" tmpVal2)
		      (setq retVal (strcat tmpVal1 ", nrd=" tmpVal2))
		  )
		  retVal
		 )
		 (t
		  (setq tmpVal1 (CDFmanualDiodeMethod 'd))
		  (when (equal "" tmpVal1) (setq tmpVal1 nil))
		  (setq tmpVal2 (AELgetStringProp ilInst 'drnOffset))
		  (when (or (equal "0.0" tmpVal2) (equal "0" tmpVal2))
		      (setq tmpVal2 nil)
		  )
		  (cond
		      ((and tmpVal1 tmpVal2)
		       (setq retVal (strcat tmpVal1 ", drnOffset=" tmpVal2))
		      )
		      (tmpVal2
		       (setq retVal (strcat "drnOffset=" tmpVal2))
		      )
		      (t (setq retVal tmpVal1))
		  )
		  retVal
		 )
	     )
	    ))	   
	    
	    ;; 9, 91, 92 are device operating point back annotation locations
	    (9 (setq retVal (or (ANTdevOpba 'large "M")
				(CDFwmOpBa CY_OP_FontSizeStr 0))))
	    (91 (setq retVal (or (ANTdevOpba 'medium "M")
				 (CDFwmOpBa CY_OP_FontSizeStr 1))))
	    (92 (setq retVal (or (ANTdevOpba 'small "M")
				 (CDFwmOpBa CY_OP_FontSizeStr 2))))

	    (11 (CDFterm "b" ":b"))

	    ;; 12 is the basic w, l, m.  It also contains the verilog model
	    ;; if it is not default.
	    (12
	     (setq tmpVal1 (CDFwlm 'w 'l 'm))
	     (setq tmpVal2 (CDFlogic))
	     (cond
		 ((and (nequal "" tmpVal1) (nequal "" tmpVal2))
		  (setq retVal (strcat tmpVal1 ", " tmpVal2))
		 )
		 (t (setq retVal (strcat tmpVal1 tmpVal2)))
	     )
	    )

	    (13 (when (equal diodeSize "large")
	     (cond
		 ((and (setq tmpVal1 (dbGet ilInst 'manualDiodes))
		       (nequal "FALSE" tmpVal1))
		  (setq tmpVal1 (CDFmanualDiode 'ps))
		  (setq tmpVal2 (AELgetStringProp ilInst 'nrs))
		  (setq retVal tmpVal1)
		  (when (nequal "0" tmpVal2)
		      (setq retVal (strcat tmpVal1 ", nrs=" tmpVal2))
		  )
		  retVal
		 )
		 (t
		  (setq tmpVal1 (CDFmanualDiodeMethod 's))
		  (when (equal "" tmpVal1) (setq tmpVal1 nil))
		  (setq tmpVal2 (AELgetStringProp ilInst 'srcOffset))
		  (when (or (equal "0.0" tmpVal2) (equal "0" tmpVal2))
		      (setq tmpVal2 nil)
		  )
		  (cond
		      ((and tmpVal1 tmpVal2)
		       (setq retVal (strcat tmpVal1 ", srcOffset=" tmpVal2))
		      )
		      (tmpVal2
		       (setq retVal (strcat "srcOffset=" tmpVal2))
		      )
		      (t (setq retVal tmpVal1))
		  )
		  retVal
		 )
	     )
	    ))
	    (131 (when (equal diodeSize "medium")
	     (cond
		 ((and (setq tmpVal1 (dbGet ilInst 'manualDiodes))
		       (nequal "FALSE" tmpVal1))
		  (setq tmpVal1 (CDFmanualDiode 'ps))
		  (setq tmpVal2 (AELgetStringProp ilInst 'nrs))
		  (setq retVal tmpVal1)
		  (when (nequal "0" tmpVal2)
		      (setq retVal (strcat tmpVal1 ", nrs=" tmpVal2))
		  )
		  retVal
		 )
		 (t
		  (setq tmpVal1 (CDFmanualDiodeMethod 's))
		  (when (equal "" tmpVal1) (setq tmpVal1 nil))
		  (setq tmpVal2 (AELgetStringProp ilInst 'srcOffset))
		  (when (or (equal "0.0" tmpVal2) (equal "0" tmpVal2))
		      (setq tmpVal2 nil)
		  )
		  (cond
		      ((and tmpVal1 tmpVal2)
		       (setq retVal (strcat tmpVal1 ", srcOffset=" tmpVal2))
		      )
		      (tmpVal2
		       (setq retVal (strcat "srcOffset=" tmpVal2))
		      )
		      (t (setq retVal tmpVal1))
		  )
		  retVal
		 )
	     )
	    ))
	    (132 (when (equal diodeSize "small")
	     (cond
		 ((and (setq tmpVal1 (dbGet ilInst 'manualDiodes))
		       (nequal "FALSE" tmpVal1))
		  (setq tmpVal1 (CDFmanualDiode 'ps))
		  (setq tmpVal2 (AELgetStringProp ilInst 'nrs))
		  (setq retVal tmpVal1)
		  (when (nequal "0" tmpVal2)
		      (setq retVal (strcat tmpVal1 ", nrs=" tmpVal2))
		  )
		  retVal
		 )
		 (t
		  (setq tmpVal1 (CDFmanualDiodeMethod 's))
		  (when (equal "" tmpVal1) (setq tmpVal1 nil))
		  (setq tmpVal2 (AELgetStringProp ilInst 'srcOffset))
		  (when (or (equal "0.0" tmpVal2) (equal "0" tmpVal2))
		      (setq tmpVal2 nil)
		  )
		  (cond
		      ((and tmpVal1 tmpVal2)
		       (setq retVal (strcat tmpVal1 ", srcOffset=" tmpVal2))
		      )
		      (tmpVal2
		       (setq retVal (strcat "srcOffset=" tmpVal2))
		      )
		      (t (setq retVal tmpVal1))
		  )
		  retVal
		 )
	     )
	     ))
	 (133  (setq tmpVal1 (dbGet ilInst 'addNoNoise))
	      (cond
	       ((and tmpVal1 (nequal "FALSE" tmpVal1))
	        (setq retVal "no noise")
	        retVal
	        )
	       (t 
	        (setq retVal "")
	        retVal
	        )
	       ))

	    (14  (when (equal diodeSize "large")  (setq retVal (CDFmanualDiode 'as))))
	    (141 (when (equal diodeSize "medium") (setq retVal (CDFmanualDiode 'as))))
	    (142 (when (equal diodeSize "small")  (setq retVal (CDFmanualDiode 'as))))
            (15  (when (equal LODSize "large")    (setq retVal (CDFmanualLOD cellName))))
            (151 (when (equal LODSize "medium")   (setq retVal (CDFmanualLOD cellName))))
            (152 (when (equal LODSize "small")    (setq retVal (CDFmanualLOD cellName))))
            (16 (setq retVal (CDFmanualWPE cellName)))
	    (17 (when (TECHgetDeviceParam (CDFfetDeviceFromDbid ilInst cellName) 'useMultNF)
		  (setq retVal (strcat "m=" (AELgetStringProp ilInst 'mult)))))
	)

	retVal
    )
)

(defun CDFcap2Labels (num)
    (let (tmpVal1 tmpVal2 tmpVal3)
	(case num
	    (1 (CDFname))
	    (2 (CDFiter))
	    (3
	     (cond
		 ((and (setq tmpVal1 ilInst~>isAbsoluteCap)
		       (nequal "FALSE" tmpVal1))
		  "abs"
		 )
		 (t (or ilInst~>ctype ""))
	     )
	    )
	    ;; regular cap value, m*C or m*w*l
	    (4
	     (setq tmpVal1 (or (AELgetStringProp ilInst 'cm) ""))
	     (cond
		 ((and (nequal "" tmpVal1) (nequal "1" tmpVal1))
		  (setq tmpVal1 (strcat tmpVal1 "*"))
		 )
		 (t (setq tmpVal1 ""))
	     )
	     (cond
		 ;; if it is an absolute cap, do C=m*val or C=val
		 ((and (setq tmpVal2 ilInst~>isAbsoluteCap)
		       (nequal "FALSE" tmpVal2)
		  )
		  (setq tmpVal2 (or (AELgetStringProp ilInst 'c)
				    "UNDEF_C"))
		  (strcat "C=" tmpVal1 tmpVal2)
		 )
		 ;; if it is a width and length cap, do m*w*l, or w*l
		 (t
		  (setq tmpVal2 (or (AELgetStringProp ilInst 'cw)
				    "UNDEF_W"))
		  (setq tmpVal3 (or (AELgetStringProp ilInst 'cl)
				    "UNDEF_L"))
		  (strcat tmpVal1 tmpVal2 "*" tmpVal3)
		 )
	     )
	    )
	    (6
	     (cond
		 ((and (setq tmpVal1 ilInst~>isAbsoluteCap)
		       (nequal "FALSE" tmpVal1))
		  ""
		 )
		 (t
		  (when (and (setq tmpVal1 (AELgetStringProp ilInst 'space))
			     (nequal "" tmpVal1)
			     ilInst~>capSpace1
			)
		      (strcat "space=" tmpVal1)
		  )
		 )
		 (t "")
	     )
	    )
	    (7
	     (cond
		 ((and (setq tmpVal1 ilInst~>isAbsoluteCap)
		       (nequal "FALSE" tmpVal1))
		  ""
		 )
		 (t
		  (when (and (setq tmpVal1 (AELgetStringProp ilInst 'coupling))
			     (nequal "" tmpVal1)
			     ilInst~>capSpace1
			)
		      (strcat "coupling=" tmpVal1)
		  )
		 )
		 (t "")
	     )
	    )
	    (8 (ANTdevOpba 'large))
	    (81 (ANTdevOpba 'medium))
	    (82 (ANTdevOpba 'small))
	    (11 (CDFterm "c0" ":i"))
	    (12 (CDFterm "c1"))
	)
    )
)

(defun CDFvppcapLabels (num)
  (let (tmpVal1 tmpVal2)
    (case num
      (1 (CDFterm "c0" ":i"))
      (2 (CDFterm "c1"))
      (3 (CDFterm "term4"))
      (4 (CDFterm "b"))
      (5 "")
      (6 (CDFname))
      (7 (CDFmult))
      
      )
    )
  )

(defun CDFcap_int3Labels (num)
	(let (tmpVal1 tmpVal2)
		(case num
			(1 (CDFname))
			(2 (CDFiter))
			(3
				(cond
					((and (setq tmpVal1 ilInst~>isAbsoluteCap)
						(nequal "FALSE" tmpVal1))	"abs"
					)
					(t (or ilInst~>ctype ""))
				)
	    )

			;; regular cap value, m*C 
			(4
				(setq tmpVal1 (or (AELgetStringProp ilInst 'cm) ""))
				(cond
					((and (nequal "" tmpVal1) (nequal "1" tmpVal1))
						(setq tmpVal1 (strcat tmpVal1 "*"))
					)
					(t (setq tmpVal1 ""))
				)
				;; do C=m*val or C=val
				(setq tmpVal2 (or (AELgetStringProp ilInst 'c) "UNDEF_C"))
;  below is used to change the scale
;				(printf "%L\n" tmpVal2)
;				(cond
;					((nequal "UNDEF_C" tmpVal2)
;						(setq tmpVal2 ((aelNumber tmpVal2) * 1e15))
;						(setq tmpVal2 (sprintf nil "%L" tmpVal2))
;					)
;					(t (setq tmpVal2 "UNDEF_C"))
;				)
				(strcat "C=" tmpVal1 tmpVal2)
					
			)
			(6 "" )

	    (7 (CDFterm "b"))
			(8 (ANTdevOpba 'large))
			(81 (ANTdevOpba 'medium))
			(82 (ANTdevOpba 'small))
			(11 (CDFterm "c0" ":i"))
			(12 (CDFterm "c1"))
		)
	)
)


(defun CDFthinoxCapLabels (num)
    (let (tmpVal1 tmpVal2)

	(case num
	    (1 (CDFname))
	    (2
	     (setq tmpVal1 ilInst~>ctype)
	     (when (or (null tmpVal1) (equal "" tmpVal1))
		 (setq tmpVal1 "ERROR")
	     )
	     (setq tmpVal2 (CDFiter))
	     (when (nequal "" tmpVal2)
		 (setq tmpVal1 (strcat tmpVal2 ", " tmpVal1))
	     )
	     tmpVal1
	    )
	    (3
	     (setq tmpVal1 (AELgetStringProp ilInst 'cm))
	     (cond
		 ((and (nequal "" tmpVal1) (nequal "1" tmpVal1))
		  (strcat "m=" tmpVal1)
		 )
		 (t "")
	     )
	    )
	    ;; width or perimeter
	    (4
	     (cond
		 ((equal "Width & Length" ilInst~>apMode)
		  (setq tmpVal1 (AELgetStringProp ilInst 'cw))
		  (cond
		      ((nequal "" tmpVal1)
		       (strcat "w=" tmpVal1)
		      )
		      (t "w=UNDEFINED")
		  )
		 )
		 (t ;; area and perimeter
		  (setq tmpVal1 (AELgetStringProp ilInst 'p))
		  (cond
		      ((nequal "" tmpVal1)
		       (strcat "P=" tmpVal1
			       (or (and (aelIsNumberP tmpVal1) "u") "")
		       )
		      )
		      (t "P=UNDEFINED")
		  )
		 )
	     )
	    )
	    ;; length or area display
	    (5
	     (cond
		 ((equal "Width & Length" ilInst~>apMode)
		  (setq tmpVal1 (AELgetStringProp ilInst 'cl))
		  (cond
		      ((nequal "" tmpVal1)
		       (strcat "l=" tmpVal1)
		      )
		      (t "l=UNDEFINED")
		  )
		 )
		 (t ;; area and perimeter based instance
		  (setq tmpVal1 (AELgetStringProp ilInst 'a))
		  (cond
		      ((nequal "" tmpVal1)
		       (strcat "A=" tmpVal1
			       (or (and (aelIsNumberP tmpVal1) "p") "")
		       )
		      )
		      (t "A=UNDEFINED")
		  )
		 )
	     )
	    )
	    (6
	     (setq tmpVal1 (CDFopba "c"))
	     (setq tmpVal2 (CDFopba "Ceff"))
	     (cond
		 ((and (nequal "" tmpVal1) (nequal "" tmpVal2))
		  (strcat tmpVal1 ", " tmpVal2)
		 )
		 (t (strcat tmpVal1 tmpVal2))
	     )
	    )
	    (7
	     (setq tmpVal1 (CDFopba "i"))
	     (setq tmpVal2 (CDFopba "p"))
	     (cond
		 ((and (nequal "" tmpVal1) (nequal "" tmpVal2))
		  (strcat tmpVal1 ", " tmpVal2)
		 )
		 (t (strcat tmpVal1 tmpVal2))
	     )
	    )
	    (8
	     (setq tmpVal1 (CDFopba "v"))
	     (setq tmpVal2 (CDFopba "m"))
	     (cond
		 ((and (nequal "" tmpVal1) (nequal "" tmpVal2))
		  (strcat tmpVal1 ", " tmpVal2)
		 )
		 (t (strcat tmpVal1 tmpVal2))
	     )
	    )
	    (9 (CDFterm "c0"))
	    (10 (CDFterm "c1"))
	)
    )
)

;;; 
;;; CDFgresLabels --
;;;   This will handle the display labels for gres3
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 

(defun CDFgresLabels (num)
  (let (tmpVal1 tmpVal2 tmpVal3 parType)
    (case num
	  (1 (CDFname))
	  
	  (2
	   (setq tmpVal1 ilInst~>isParasitic)
	   (cond
	    ((and tmpVal1 (nequal "FALSE" tmpVal1))
	     (setq tmpVal2 ilInst~>r)
	     (setq tmpVal3 (and tmpVal2 (aelIsNumberP tmpVal2)
				(aelNumber tmpVal2)))
	     (cond
	      ((null tmpVal3)
	       "NOT LVS'd"
	       )
	      ((equal "open" ilInst~>deriveAs)
	       (or (and (geqp tmpVal3 100e3) "NOT LVS'd open")
		   "NOT LVS'd open (too small?)")
	       )
	      (t
	       (or (and (geqp tmpVal3 100e3) "NOT LVS'd short (too large?)")
		   "NOT LVS'd")
	       )
	      )
	     )
	    (t "")
	    )
	   )
	  
	  (3
	   (setq tmpVal1 ilInst~>rpolymod)
	   (cond
	    ((and tmpVal1 (nequal "" tmpVal1))
	     tmpVal1
	     )
	    (t "ERROR_model")
	    )
	   )
	  
	  (4
	   (setq tmpVal1 (CDFdisplayResistance_gres ilInst))
	   (setq tmpVal2 ilInst~>isAbsoluteRes)
	   (setq tmpVal3 (AELgetStringProp ilInst 'rm))
	   (cond
	    ((and tmpVal1 (nequal "" tmpVal1))
		  (setq tmpVal1 (strcat "R=" tmpVal1))
		  (when (and tmpVal2 (nequal "FALSE" tmpVal2)
			     tmpVal3 (null (member tmpVal3 '("" "1"))))
		    (setq tmpVal1 (strcat tmpVal1 "/" tmpVal3))
		    )
		  tmpVal1
		  )
	    (t "")
	    )
	   )
	  (5
	   (setq tmpVal1 ilInst~>isAbsoluteRes)
	   (cond
	    ((and tmpVal1 (nequal "FALSE" tmpVal1))
	     ""
	     )
	    (t
	     (setq tmpVal1 (AELgetStringProp ilInst 'rw))
	     (when (or (null tmpVal1) (equal "" tmpVal1))
	       (setq tmpVal1 "UNDEF_rw")
	       )
	     (setq tmpVal2 (AELgetStringProp ilInst 'rl))
	     (when (or (null tmpVal2) (equal "" tmpVal2))
	       (setq tmpVal2 "UNDEF_rl")
	       )
	     (setq tmpVal3 (AELgetStringProp ilInst 'seriesSegment))
	     (when (or (null tmpVal3) (equal "" tmpVal3))
	       (setq tmpVal3 "1")
	       )
	     (setq tmpVal4 (AELgetStringProp ilInst 'parallelSegment))
	     (when (or (null tmpVal4) (equal "" tmpVal4))
	       (setq tmpVal4 "1")
	       )
	     (cond
	      ((nequal tmpVal3 "1") 
	       (setq tmpVal34 (strcat tmpVal3 "S-") )
	       )
	      ((nequal tmpVal4 "1") 
	       (setq tmpVal34 (strcat tmpVal4 "P-") )
	       )
	      (t (setq tmpVal34 ""))
	      )
	     (strcat tmpVal34 tmpVal1 "/" tmpVal2)
	     )
	    )
	   )
	  (7 ;; verilog props drive strength, vhigh, and vlow
	   (setq tmpVal1 ilInst~>hide_vDriveStrength)
	   (cond
	    ((and tmpVal1 (nequal "FALSE" tmpVal1))
	     (setq tmpVal1 ilInst~>vDriveStrength)
	     (cond
	      ((and tmpVal1 (nequal "" tmpVal1))
	       (setq tmpVal1 (strcat "str(" tmpVal1 ")"))
	       )
	      (t (setq tmpVal1 ""))
	      )
	     )
	    (t (setq tmpVal1 ""))
	    )
	   (setq tmpVal2 ilInst~>hide_vHigh_Strength)
	   (cond
	    ((and tmpVal2 (nequal "FALSE" tmpVal2))
	     (setq tmpVal2 ilInst~>vHigh_Strength)
	     (cond
	      ((and tmpVal2 (nequal "" tmpVal2))
	       (setq tmpVal2 (strcat "(" tmpVal2 ","))
	       )
	      (t (setq tmpVal2 ""))
	      )
	     )
	    (t (setq tmpVal2 ""))
	    )
	   (setq tmpVal3 ilInst~>hide_vLow_Strength)
	   (cond
	    ((and tmpVal3 (nequal "FALSE" tmpVal3))
	     (setq tmpVal3 ilInst~>vLow_Strength)
	     (cond
	      ((and tmpVal3 (nequal "" tmpVal3))
	       (setq tmpVal3 (strcat tmpVal3 ")"))
	       )
	      (t (setq tmpVal3 ""))
	      )
	     )
	    (t (setq tmpVal3 ""))
	    )
	   (strcat tmpVal1 tmpVal2 tmpVal3)
	   )
	  ;; rcons on r0 side
	  (8
	   (setq tmpVal1 (AELgetStringProp ilInst 'rcon0m))
	   (cond
	    ((and tmpVal1 (nequal "0" tmpVal1) (nequal "" tmpVal1))
	     (setq tmpVal1 (strcat "rcon0 N=" tmpVal1))
	     )
	    (t (setq tmpVal1 ""))
	    )
	   (cond
	    ((and (equal "rescap" ilInst~>cellName)
		  (ENVgetVal "schematic" "displayCapsOfRescaps"))
	     (setq tmpVal2
		   (CDFcapCalculate ilInst~>parasiteModel
				    ilInst~>cw
				    ilInst~>cw1
				    ilInst~>cw2
				    ilInst~>cl
				    ilInst~>rm
				    (dbFindProp ilInst "space")~>value
				    ilInst~>capSpace1
				    ilInst~>capSpace2
				    ilInst~>coupling
				    t
				    )
		   )
	     (unless tmpVal2 (setq tmpVal2 ""))
	     (cond
	      ((and (nequal "" tmpVal1) (nequal "" tmpVal2))
	       (strcat tmpVal1 ", " tmpVal2)
	       )
	      ((nequal "" tmpVal2)
	       tmpVal2
	       )
	      (t tmpVal1)
	      )
	     )
	    (t tmpVal1)
	    )
	   )
	  (9 (CDFiter))
	  (10 (CDFlogic))
	  ;; rcons on the r1 side
	  (11
	   (setq tmpVal1 (AELgetStringProp ilInst 'rcon1m))
	   (cond
	    ((and tmpVal1 (nequal "0" tmpVal1) (nequal "" tmpVal1))
	     (setq tmpVal1 (strcat "rcon1 N=" tmpVal1))
	     )
	    (t (setq tmpVal1 ""))
	    )
	   (cond
	    ((and (equal "rescap" ilInst~>cellName)
		  (ENVgetVal "schematic" "displayCapsOfRescaps"))
	     (setq tmpVal2
		   (CDFcapCalculate ilInst~>parasiteModel
				    ilInst~>cw
				    ilInst~>cw1
				    ilInst~>cw2
				    ilInst~>cl
				    ilInst~>rm
				    (dbFindProp ilInst "space")~>value
				    ilInst~>capSpace1
				    ilInst~>capSpace2
				    ilInst~>coupling
				    t
				    )
		   )
	     (unless tmpVal2 (setq tmpVal2 ""))
	     (cond
	      ((and (nequal "" tmpVal1) (nequal "" tmpVal2))
	       (strcat tmpVal1 ", " tmpVal2)
	       )
	      ((nequal "" tmpVal2)
	       tmpVal2
	       )
	      (t tmpVal1)
	      )
	     )
	    (t tmpVal1)
	    )
	   )
	  (15 (CDFterm "r0" ":i"))
	  (16 (CDFterm "r1"))
	  ;; the res is the only flavor that does not have a body terminal
	  (17 (when (nequal "res" ilInst~>master~>cellName) (CDFterm "b")))
	  
	  ;; back annotation parameters
	  (18  (ANTdevOpba 'large "R"))
	  (181 (ANTdevOpba 'medium "R"))
	  (182 (ANTdevOpba 'small "R"))
	  
	  (19  (and parType (ANTdevOpba 'large parType nil "_0")))
	  (191 (and parType (ANTdevOpba 'medium parType nil "_0")))
	  (192 (and parType (ANTdevOpba 'small parType nil "_0")))
	  
	  (20  (and parType (ANTdevOpba 'large parType nil "_1")))
	  (201 (and parType (ANTdevOpba 'medium parType nil "_1")))
	  (202 (and parType (ANTdevOpba 'small parType nil "_1")))
	  
	  ;; 21 is particular to the rcon only
	  (21
	   (setq tmpVal1 (AELgetStringProp ilInst 'rm))
	   (when (or (null tmpVal1) (equal "" tmpVal1))
	     (setq tmpVal1 "1")
	     )
	   (strcat "m=" tmpVal1)
	   )
	  )
    )
  )

(defun CDFdisplayResistance_gres (instDbid)
  (let (r rHasChanged)
    
    (cond
     ;; if it is an absolute resistor, no problem
     ((and instDbid~>isAbsoluteRes (nequal "FALSE" instDbid~>isAbsoluteRes))
      (setq r (AELgetStringProp instDbid 'res))
      )
     
     ;; else, let it lookup the device in the techrep, and
     ;; calculate based on width and length
     (t
      (setq r instDbid~>cres)
      )
     )
    (unless (stringp r)
      (setq r (sprintf nil "%.2f" r))
      )
    r
    )
  )

;;; 
;;; CDFresLabels --
;;;   This will handle the display labels for res, rescap, resn, resnw, resp, respw res3.
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFresLabels (num)
    (let (tmpVal1 tmpVal2 tmpVal3 parType)
	(cond
	    ((equal ilInst~>master~>cellName "rescap")
	     (setq parType "C")
	    )
	    ((member ilInst~>master~>cellName '("resn" "resp" "resnw"))
	     (setq parType "D")
	    )
	)
	(case num
	    (1 (CDFname))
	    (2
	     (setq tmpVal1 ilInst~>isParasitic)
	     (cond
		 ((and tmpVal1 (nequal "FALSE" tmpVal1))
		  (setq tmpVal2 ilInst~>r)
		  (setq tmpVal3 (and tmpVal2 (aelIsNumberP tmpVal2)
				     (aelNumber tmpVal2)))
		  (cond
		      ((null tmpVal3)
		       "NOT LVS'd"
		      )
		      ((equal "open" ilInst~>deriveAs)
		       (or (and (geqp tmpVal3 100e3) "NOT LVS'd open")
			   "NOT LVS'd open (too small?)")
		      )
		      (t
		       (or (and (geqp tmpVal3 100e3) "NOT LVS'd short (too large?)")
			   "NOT LVS'd")
		      )
		  )
		 )
		 (t "")
	     )
	    )
	    (3
	     (setq tmpVal1 ilInst~>model)
	     (cond
		 ((and tmpVal1 (nequal "" tmpVal1))
		  tmpVal1
		 )
		 (t "ERROR_model")
	     )
	    )
	    (4
;;;	     (setq tmpVal1 (AELgetStringProp ilInst 'r))
	     (setq tmpVal1 (CDFdisplayResistance ilInst))
	     (setq tmpVal2 ilInst~>isAbsoluteRes)
	     (setq tmpVal3 (AELgetStringProp ilInst 'rm))
	     (cond
		 ((and tmpVal1 (nequal "" tmpVal1))
		  (setq tmpVal1 (strcat "R=" tmpVal1))
		  (when (and tmpVal2 (nequal "FALSE" tmpVal2)
			     tmpVal3 (null (member tmpVal3 '("" "1"))))
		      (setq tmpVal1 (strcat tmpVal1 "/" tmpVal3))
		  )
		  tmpVal1
		 )
		 (t "")
	     )
	    )
	    (5
	     (setq tmpVal1 ilInst~>isAbsoluteRes)
	     (cond
		 ((and tmpVal1 (nequal "FALSE" tmpVal1))
		  ""
		 )
		 (t
		  (setq tmpVal1 (AELgetStringProp ilInst 'rw))
		  (when (or (null tmpVal1) (equal "" tmpVal1))
		      (setq tmpVal1 "UNDEF_rw")
		  )
		  (setq tmpVal2 (AELgetStringProp ilInst 'rl))
		  (when (or (null tmpVal2) (equal "" tmpVal2))
		      (setq tmpVal2 "UNDEF_rl")
		  )
		  (setq tmpVal3 (AELgetStringProp ilInst 'rm))
		  (when (or (null tmpVal3) (equal "" tmpVal3))
		      (setq tmpVal3 "1")
		  )
		  (cond
		      ((nequal tmpVal3 "1")
		       (setq tmpVal3 (strcat tmpVal3 "*"))
		      )
		      (t (setq tmpVal3 ""))
		  )
		  (strcat tmpVal3 tmpVal1 "/" tmpVal2)
		 )
	     )
	    )
	    (7 ;; verilog props drive strength, vhigh, and vlow
	     (setq tmpVal1 ilInst~>hide_vDriveStrength)
	     (cond
		 ((and tmpVal1 (nequal "FALSE" tmpVal1))
		  (setq tmpVal1 ilInst~>vDriveStrength)
		  (cond
		      ((and tmpVal1 (nequal "" tmpVal1))
		       (setq tmpVal1 (strcat "str(" tmpVal1 ")"))
		      )
		      (t (setq tmpVal1 ""))
		  )
		 )
		 (t (setq tmpVal1 ""))
	     )
	     (setq tmpVal2 ilInst~>hide_vHigh_Strength)
	     (cond
		 ((and tmpVal2 (nequal "FALSE" tmpVal2))
		  (setq tmpVal2 ilInst~>vHigh_Strength)
		  (cond
		      ((and tmpVal2 (nequal "" tmpVal2))
		       (setq tmpVal2 (strcat "(" tmpVal2 ","))
		      )
		      (t (setq tmpVal2 ""))
		  )
		 )
		 (t (setq tmpVal2 ""))
	     )
	     (setq tmpVal3 ilInst~>hide_vLow_Strength)
	     (cond
		 ((and tmpVal3 (nequal "FALSE" tmpVal3))
		  (setq tmpVal3 ilInst~>vLow_Strength)
		  (cond
		      ((and tmpVal3 (nequal "" tmpVal3))
		       (setq tmpVal3 (strcat tmpVal3 ")"))
		      )
		      (t (setq tmpVal3 ""))
		  )
		 )
		 (t (setq tmpVal3 ""))
	     )
	     (strcat tmpVal1 tmpVal2 tmpVal3)
	    )
	    ;; rcons on r0 side
	    (8
	     (setq tmpVal1 (AELgetStringProp ilInst 'rcon0m))
	     (cond
		 ((and tmpVal1 (nequal "0" tmpVal1) (nequal "" tmpVal1))
		  (setq tmpVal1 (strcat "rcon0 N=" tmpVal1))
		 )
		 (t (setq tmpVal1 ""))
	     )
	     (cond
		 ((and (equal "rescap" ilInst~>cellName)
		       (ENVgetVal "schematic" "displayCapsOfRescaps"))
		  (setq tmpVal2
			(CDFcapCalculate ilInst~>parasiteModel
					 ilInst~>cw
					 ilInst~>cw1
					 ilInst~>cw2
					 ilInst~>cl
					 ilInst~>rm
					 (dbFindProp ilInst "space")~>value
					 ilInst~>capSpace1
					 ilInst~>capSpace2
					 ilInst~>coupling
					 t
			)
		  )
		  (unless tmpVal2 (setq tmpVal2 ""))
		  (cond
		      ((and (nequal "" tmpVal1) (nequal "" tmpVal2))
		       (strcat tmpVal1 ", " tmpVal2)
		      )
		      ((nequal "" tmpVal2)
		       tmpVal2
		      )
		      (t tmpVal1)
		  )
		 )
		 (t tmpVal1)
	     )
	    )
	    (9 (CDFiter))
	    (10 (CDFlogic))
	    ;; rcons on the r1 side
	    (11
	     (setq tmpVal1 (AELgetStringProp ilInst 'rcon1m))
	     (cond
		 ((and tmpVal1 (nequal "0" tmpVal1) (nequal "" tmpVal1))
		  (setq tmpVal1 (strcat "rcon1 N=" tmpVal1))
		 )
		 (t (setq tmpVal1 ""))
	     )
	     (cond
		 ((and (equal "rescap" ilInst~>cellName)
		       (ENVgetVal "schematic" "displayCapsOfRescaps"))
		  (setq tmpVal2
			(CDFcapCalculate ilInst~>parasiteModel
					 ilInst~>cw
					 ilInst~>cw1
					 ilInst~>cw2
					 ilInst~>cl
					 ilInst~>rm
					 (dbFindProp ilInst "space")~>value
					 ilInst~>capSpace1
					 ilInst~>capSpace2
					 ilInst~>coupling
					 t
			)
		  )
		  (unless tmpVal2 (setq tmpVal2 ""))
		  (cond
		      ((and (nequal "" tmpVal1) (nequal "" tmpVal2))
		       (strcat tmpVal1 ", " tmpVal2)
		      )
		      ((nequal "" tmpVal2)
		       tmpVal2
		      )
		      (t tmpVal1)
		  )
		 )
		 (t tmpVal1)
	     )
	    )
	    ;; 12, 13, and 14 are particular to the rescap
	    (12
	     (when (equal "rescap" ilInst~>master~>cellName)
		 (when ilInst~>capSpace1
		     (when (and (setq tmpVal1 (AELgetStringProp ilInst 'space))
				(nequal "" tmpVal1))
			 (strcat "space=" tmpVal1)
		     )
		 )
	     )
	    )
	    (13
	     (when (equal "rescap" ilInst~>master~>cellName)
		 (when ilInst~>capSpace1
		     (when (and (setq tmpVal1
				      (AELgetStringProp ilInst 'coupling))
				(nequal "" tmpVal1))
			 (strcat "coupling=" tmpVal1)
		     )
		 )
	     )
	    )
	    (14
	     (when (equal "rescap" ilInst~>master~>cellName)
		 (when (and (setq tmpVal1 ilInst~>parasiteModel)
			    (nequal "" tmpVal1))
		     tmpVal1
		 )
	     )
	    )
	    (15 (CDFterm "r0" ":i"))
	    (16 (CDFterm "r1"))
	    ;; the res is the only flavor that does not have a body terminal
	    (17 (when (nequal "res" ilInst~>master~>cellName) (CDFterm "b")))

	    ;; back annotation parameters
	    (18  (ANTdevOpba 'large "R"))
	    (181 (ANTdevOpba 'medium "R"))
	    (182 (ANTdevOpba 'small "R"))

	    (19  (and parType (ANTdevOpba 'large parType nil "_0")))
	    (191 (and parType (ANTdevOpba 'medium parType nil "_0")))
	    (192 (and parType (ANTdevOpba 'small parType nil "_0")))

	    (20  (and parType (ANTdevOpba 'large parType nil "_1")))
	    (201 (and parType (ANTdevOpba 'medium parType nil "_1")))
	    (202 (and parType (ANTdevOpba 'small parType nil "_1")))

	    ;; 21 is particular to the rcon only
	    (21
	     (setq tmpVal1 (AELgetStringProp ilInst 'rm))
	     (when (or (null tmpVal1) (equal "" tmpVal1))
		 (setq tmpVal1 "1")
	     )
	     (strcat "m=" tmpVal1)
	    )
	    (22
             (setq tmpVal1 ilInst~>isHV)
	     (cond
	      ((and tmpVal1 (nequal "FALSE" tmpVal1))
	       "HV Res"
	       )
	      (t "")
	     )
	     )
	    )
	)
)


;;; 
;;; CDFlvtransLabels --
;;;   This will handle the display labels for the variable winding transformer eldo element
;;;
;;; Input: cellName and CDFloc number
;;; Output:
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFlvtransLabels (cellName num)
 (let (tmpVal1 tmpVal2 tmpVal3 retVal)
    ;;check the following for all the lvtrans cells
    (case num
      (1  (CDFname))
      (2  (ANTdevOpba 'large))
      (21 (ANTdevOpba 'medium))
      (22 (ANTdevOpba 'small))
      (3  (CDFterm "p1p"))
      (4  (CDFterm "p1n"))
      (5  (CDFterm "p2p"))
      (6  (CDFterm "p2n"))
      (7  (CDFterm "p3p"))
      (8  (CDFterm "p3n"))
      (9  (CDFterm "p4p"))
      (10 (CDFterm "p4n"))
      (11 (when ilInst~>model != "" 
	       (sprintf nil "model: %s " ilInst~>model))
	 )
      (12 
       (when ilInst~>l11 != ""
	  (case cellName 
	    ("lvtrans2" (sprintf nil " L11=%s L12=%s\n R1=%s" ilInst~>l11 ilInst~>l12 ilInst~>r1))
	    ("lvtrans3" (sprintf nil " L11=%s L12=%s\n L13=%s R1=%s" ilInst~>l11 ilInst~>l12 ilInst~>l13 ilInst~>r1))
	    ("lvtrans4" (sprintf nil " L11=%s L12=%s\n L13=%s L14=%s\n R1=%s" ilInst~>l11 ilInst~>l12 ilInst~>l13 ilInst~>l14 ilInst~>r1))
	    ))
       )
      (13 
       (when ilInst~>l21 != ""
	  (case cellName 
	    ("lvtrans2" (sprintf nil " L21=%s L22=%s\n R2=%s" ilInst~>l21 ilInst~>l22 ilInst~>r2))
	    ("lvtrans3" (sprintf nil " L21=%s L22=%s\n L23=%s R2=%s" ilInst~>l21 ilInst~>l22 ilInst~>l23 ilInst~>r2))
	    ("lvtrans4" (sprintf nil " L21=%s L22=%s\n L23=%s L24=%s\n R2=%s" ilInst~>l21 ilInst~>l22 ilInst~>l23 ilInst~>l24 ilInst~>r2))
	    ))
       )
      (14 
       (when ilInst~>l31 != ""
	  (case cellName 
	    ;;lvtrans2 does not have this pin
	    ("lvtrans3" (sprintf nil " L31=%s L32=%s\n L33=%s R3=%s" ilInst~>l31 ilInst~>l32 ilInst~>l33 ilInst~>r3))
	    ("lvtrans4" (sprintf nil " L31=%s L32=%s\n L33=%s L34=%s\n R3=%s" ilInst~>l31 ilInst~>l32 ilInst~>l33 ilInst~>l34 ilInst~>r3))
	    ))
       )
      (15
       ;;lvtrans2/3 does not have this pin
       (when ilInst~>l41 != ""
	  (sprintf nil " L41=%s L42=%s\n L43=%s L44=%s\n R4=%s" ilInst~>l41 ilInst~>l42 ilInst~>l43 ilInst~>l44 ilInst~>r4))
       )
      (t (setq retVal ""))
   ) ;;end case num
 )
)


;;; 
;;; CDFopba --
;;;   This will return the operating point back annotation values as strings
;;; for the parameters specified, once it is actually written.
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFopba (params)
    ""
)

;;; 
;;; CDFterm --
;;;   This function is used to back annotate the spice simulation
;;; results of node voltage or device terminal current to the schematic.
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFterm (termName @optional termCurrentName force "tg")
    (let (tmpVal tmpVal2)
	(cond
	    ;; this is the Wavemaster/hspice backannotation function
	    ((and (setq tmpVal (CY_OPvoltage termName force))
		  (nequal "" tmpVal))

	     (cond
		 ((floatp tmpVal)
		  (setq tmpVal (strcat (CDFbaFloatToString tmpVal) "v"))
		 )
		 ((stringp tmpVal)
		  (when (rindex tmpVal "v")
		      (setq tmpVal (car (parseString tmpVal "v")))
		      (setq tmpVal (strcat (CDFbaFloatToString (aelNumber tmpVal)) "v"))
		  )
		 )
	     )
	    )

	    ;; this is the custom Cypress Antrim back annotation function
	    ((boundp 'ANTbaLibName)
	     (setq tmpVal (ANTtermDisplay ilInst termName force))
	     (cond
		 ;; if they specified a primitive current OP param name
		 ((stringp termCurrentName)
		  (setq tmpVal2 (ANTdeviceCurrent ilInst termCurrentName))
		 )
		 ;; default to subckt currents using the terminal name
		 (t
		  (setq tmpVal2 (ANTdeviceCurrent ilInst termName))
		 )
	     )
	     (cond
		 ((and tmpVal tmpVal2)
		  (setq tmpVal (strcat tmpVal ", " tmpVal2))
		 )
		 (t
		  (setq tmpVal (or tmpVal tmpVal2))
		 )
	     )
	    )
	    ;; this is Cadence's default, which Antrim redefines with
	    ;; their own back annotation capability
	    ((isCallable 'cdsTerm)
	     (setq tmpVal (eval `(cdsTerm ,termName)))
	     (when (aelNumber tmpVal)
		 (setq tmpVal
		       (CDFbaFloatToString (aelNumber tmpVal)
					   ;; piggyback on Antrim OPBA number
					   ;; of significant digits, or default
					   ;; to 5
					   (or (and (boundp 'ANTshow)
						    (integerp ANTshow->signifDigits)
						    ANTshow->signifDigits)
					       5)
		       )
		 )
	     )
	    )
	)

	;; if they want to show net discipline information as well
	(when (and (null (ENVgetVal "schematic" "hideNetDisciplines"))
		   (setq tmpVal2
			 (car (setof x ilInst~>terminals
				     (equal termName x~>name)))~>net~>discipline
		   )
	      )
	    (setq tmpVal (strcat (or tmpVal "") "(" tmpVal2 ")"))
	)

	tmpVal
    )
)

;;; 
;;; CDFwmOpBa --
;;;   This function will show a subset of the Wavemaster operating point
;;; back annotation values.  Previously, it used one label that had multiple
;;; lines, one line per param.  Now, we are limiting one line of display
;;; per symbol label.  This function is used to concatenate something such
;;; as every 3rd back annotated parameter into a comma separated string.
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFwmOpBa (fontSizeStr fontLocation "tx")
    (let (showlist oplist paramlist showOpList pVal pName retVal
	 nthIter)
	(when (and (boundp 'CY_op_ba_showopparams)
		   CY_op_ba_showopparams
		   (boundp 'CY_op_ba_data)
		   (equal fontSizeStr
			  (nth fontLocation CY_OP_FontSizeLst))
	      )
	    (setq showlist (cadr (assoc ilInst~>master~>cellName
					CY_op_ba_showlist)))
	    (when showlist
		(unless (boundp 'CY_op_ba_time)
		    (setq CY_op_ba_time (caar CY_op_ba_data))
		)
		(setq oplist (cadr (assoc CY_op_ba_time CY_op_ba_data)))

		(when oplist
		    (setq paramlist (cadr (assoc (CY_op_external_inst_namepath)
						 oplist)))
		    (when paramlist
			(foreach param showlist
			    (setq pVal (cadr (assoc param paramlist)))
			    ;;
			    ;; quietly skip the display if the data is not found
			    ;;
			    (when pVal
				(when (aelIsNumberP pVal)
				    (setq pVal (CDFbaFloatToString (aelNumber pVal)))
				)
				(cond
				    ((equal param "current")
				     (setq pName "I")
				    )
				    (t (setq pName param))
				)
				(when retVal (setq retVal (strcat retVal "\n")))
				(setq retVal (strcat (or retVal "") pName
						 (cond
						     (pVal (strcat "=" pVal))
						     (t " not found")
						 )
					 )
				)
			    )
			)
		    )
		    (or retVal "")
		)
		(or retVal "")
	    )
	    (or retVal "")
	)
	(or retVal "")
    )
)

;;; 
;;; CDFbaFloatToString --
;;;   This will take a floating point number and return a string representation
;;; of it.  It will use engineering units suffix, and only round to 3
;;; significant digits.  If 0.0 < (abs float) < 1e-24, it is displayed as
;;; absolute 0.0
;;;
;;; Input: a floating point number
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: a string of the number with an engineering units suffix
;;; 
(defun CDFbaFloatToString (flt @optional numSignifDigits "fg")
    (let ((absFlt (abs flt))
          suffixPair
	  formatStr
         )
        (setq suffixPair
              (cond
		  ;; if it is this close to zero, it is zero.
		  ((lessp absFlt 1e-24) (setq flt 0.0) '("" 1))
		  ((and (lessp absFlt 1e-21) (geqp absFlt 1e-24)) '("y" 1e-24))
		  ((and (lessp absFlt 1e-18) (geqp absFlt 1e-21)) '("z" 1e-21))
		  ((and (lessp absFlt 1e-15) (geqp absFlt 1e-18)) '("a" 1e-18))
		  ((and (lessp absFlt 1e-12) (geqp absFlt 1e-15)) '("f" 1e-15))
		  ((and (lessp absFlt 1e-9) (geqp absFlt 1e-12)) '("p" 1e-12))
		  ((and (lessp absFlt 1e-6) (geqp absFlt 1e-9)) '("n" 1e-9))
		  ((and (lessp absFlt 1e-3) (geqp absFlt 1e-6)) '("u" 1e-6))
		  ((and (lessp absFlt 1) (geqp absFlt 1e-3)) '("m" 1e-3))
		  ((and (lessp absFlt 1e3) (geqp absFlt 1)) '("" 1))
		  ((and (lessp absFlt 1e6) (geqp absFlt 1e3)) '("K" 1e3))
		  ((and (lessp absFlt 1e9) (geqp absFlt 1e6)) '("M" 1e6))
		  ((and (lessp absFlt 1e12) (geqp absFlt 1e9)) '("G" 1e9))
		  ((and (lessp absFlt 1e15) (geqp absFlt 1e12)) '("T" 1e12))
		  ((and (lessp absFlt 1e18) (geqp absFlt 1e15)) '("P" 1e15))
		  ((and (lessp absFlt 1e21) (geqp absFlt 1e18)) '("E" 1e18))
		  ((and (lessp absFlt 1e24) (geqp absFlt 1e21)) '("Z" 1e21))
		  ((geqp absFlt 1e24) '("Y" 1e24))
              )
        )
	(setq formatStr (sprintf nil "%s%d%s"
				 "%." (or (and (integerp numSignifDigits) numSignifDigits) 3) "g%s"))
        (sprintf nil formatStr (quotient flt (cadr suffixPair)) (car suffixPair))
    )
)

;;; 
;;; AELgetStringProp --
;;;   This function will get the property value off an instance using AEL
;;; expressions evaluation if needed.  It will try to get its bearings from
;;; the current window or another window in which the instance
;;; exists.  Sample calling of this function is:
;;;
;;;   (AELgetStringProp (car (geGetSelSet)) 'w)
;;;
;;; Input: inst - dbid of the instance
;;;        propName - symbol of the property to retrieve, such as 'w
;;; Output: warning messages as appropriate
;;; Globals: AELnlMode (t if Analog netlisting mode)
;;; Side Effects: 
;;; Return: string if prop exists, nil if it does not exist
;;; 
(defun AELgetStringProp (inst propName "ds")
    (let (propVal newPropVal winId inhList theAelEnv undefGlobals compiledVal
		  tmpSimGlobals)

	(setq propVal (dbGet inst propName))

	(cond
	    ;; if it is an integer, return it
	    ((integerp propVal) (sprintf nil "%d" propVal))

	    ;; if it is a float, return it
	    ((floatp propVal) (sprintf nil "%g" propVal))

	    ;; if it is a string that represents a number, return the string
	    ((and (stringp propVal) (aelIsNumberP propVal))
	     propVal
	    )

	    ;; if it is a string, and they want to show literals, return it
	    ((and (stringp propVal) (ENVgetVal "schematic" "showLiteral"))
	     propVal
	    )

	    ;; if it is a string, but not directly a number, try to perform
	    ;; AEL evaluation on it
	    ((stringp propVal)

	     ;; try to find the window in which this instance exists.  First
	     ;; check the active window; second check if any window has it.
	     (cond
		 ((equal (hiGetCurrentWindow)~>cellView inst~>cellView)
		  (setq winId (hiGetCurrentWindow))
		 )
		 (t
		  (setq winId (geGetCellViewWindow inst~>cellView))
		 )
	     )

	     ;; build the inheritance list based on the window
	     (when winId
		 (setq inhList (geGetHierMemInst winId))
		 (setq inhList (reverse (foreach mapcar x inhList (car x))))

		 ;; prepend this instance to the beginning of the inhList
		 (setq inhList (cons inst inhList))

		 ;; AEL behaves mildly differently between Analog and Digital
		 ;; netlisting modes.  Analog mode likes to have the top
		 ;; cellview at the end of the inhList.  When in Digital
		 ;; mode, it cannot follow multiple pPar's up the hierarchy
		 ;;
		 (unless (boundp 'AELnlMode)
		     (setq AELnlMode 
			   (null (null (member (getShellEnvVar "CDS_Netlisting_Mode")
					       '("Analog" "Compatibility"))))
		     )
		 )
		 (when AELnlMode
		     (setq inhList (append inhList (last inhList)~>cellView))
		 )
	     )

	     ;; create a new AEL environment in "f" (full evaluation) mode
	     (setq theAelEnv (aelEnvCreate "f"))

	     ;; this sets the parent lineage to do pPar evaluation
	     (aelSetLineage theAelEnv inhList)

	     ;; plug in any parameters from the Antrim simulation
	     (when (boundp 'ANTsimParams)
		 ;; get past the leading nil of the disassociated prop list
		 (setq tmpSimGlobals (cdr ANTsimParams))
		 (while (car tmpSimGlobals)
		     (when (cadr tmpSimGlobals)
			 (aelEnvSetGlobals theAelEnv
					   (strcat (car tmpSimGlobals))
					   (cadr tmpSimGlobals))
		     )
		     (setq tmpSimGlobals (cdr (cdr tmpSimGlobals)))
		 )
	     )

	     ;; compile the expression
	     (setq compiledVal (aelEnvCompile theAelEnv propVal))

	     (setq undefGlobals (aelEnvListDeferredGlobals theAelEnv))
	     
	     ;; if it compiled OK and had no undefined globals
	     (when (and (null undefGlobals) compiledVal)
		 (setq newPropVal (aelEnvExecute compiledVal))

		 ;; do we ever want to show both the evaluated value and
		 ;; the literal value?  Probably not
		 (when newPropVal
		     (setq propVal newPropVal)
		 )
		 ;; (when (and newPropVal (nequal newPropVal propVal))
		 ;;  (setq propVal (strcat newPropVal " (from " propVal ")"))
		 ;; )
	     )

	     ;; clean up the memory associated with this AEL env
	     (setq theAelEnv nil)

	     ;; return the propVal
	     propVal

	    ) ;; end if it is a string that is not directly a number

	    ;; if it is something else, it isn't what it is supposed to be
	    (t nil)
	)
    )
)

;;; 
;;; CDFname --
;;;   Nearly every tech library element will have this.  We can either hide
;;; or show the current instance name by the CY property "showName".
;;;
;;; Input: 
;;; Output: 
;;; Globals: ilInst
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFname ()
    (cond
	((ENVgetVal "schematic" "hideInstNames")
	 ""
	)
	(t
	 (let (preShowProp)

	     (setq preShowProp ilInst~>preShowName)
	     (cond
		 ((equal "FALSE" preShowProp)
		  ""
		 )
		 (t ilInst~>name)
	     )
	 )
	)
    )
)

;;; 
;;; CDFiter --
;;;   Nearly every tech library element will have this.  If it is an
;;; iterated instance, it will show the number of iterations as an integer,
;;; such as "*4".
;;;
;;; Input: 
;;; Output: 
;;; Globals: ilInst
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFiter ()
    (let (iterProp)

	(setq iterProp (AELgetStringProp ilInst 'iterations))
	(cond
	    ((and iterProp (null (onep (aelNumber iterProp))))
	     (strcat "*" iterProp)
	    )
	    (t "")
	)
    )
)


(defun CDFicisValue ()
    (let (valueProp controlProp)

	(setq valueProp (AELgetStringProp ilInst 'value))
	(when (or (null valueProp) (equal "" valueProp))
	    (setq valueProp "ERROR")
	)
	(setq controlProp (AELgetStringProp ilInst 'controlName))
	(when (or (null controlProp) (equal "" controlProp))
	    (setq controlProp "ERROR")
	)

	(strcat valueProp "*I(i" controlProp ")")
    )
)

(defun CDFicvsValue ()
    (let (valueProp controlProp)

	(setq valueProp (AELgetStringProp ilInst 'value))
	(when (or (null valueProp) (equal "" valueProp))
	    (setq valueProp "ERROR")
	)
	(setq controlProp (AELgetStringProp ilInst 'controlName))
	(when (or (null controlProp) (equal "" controlProp))
	    (setq controlProp "ERROR")
	)

	(strcat valueProp "*I(v" controlProp ")")
    )
)

(defun CDFdcValue ()
    (let (valueProp)

	(setq valueProp (AELgetStringProp ilInst 'DCValue))
	(when (or (null valueProp) (equal "" valueProp))
	    (setq valueProp "ERROR")
	)

	(strcat "DC=" valueProp)
    )
)

(defun CDFacValuePhase ()
    (let (sourceTypeProp valueProp phaseProp)

	(setq sourceTypeProp ilInst~>sourceType)
	(cond
	    ;; straight DC sources do not have an AC part
	    ((or (null sourceTypeProp) (equal "None" sourceTypeProp))
	     ""
	    )
	    (t
	     (setq valueProp (or (AELgetStringProp ilInst 'ACMag) ""))
	     (when (equal "" valueProp)
		 (setq valueProp "ERROR")
	     )
	     (when (equal sourceTypeProp "ACMag & ACPhase")
		 (setq phaseProp (or (AELgetStringProp ilInst 'ACPhase) ""))
		 (when (equal "" phaseProp)
		     (setq phaseProp "ERROR")
		 )
		 (setq phaseProp (strcat "," phaseProp))
	     )
	     (strcat "AC=" valueProp (or phaseProp ""))
	    )
	)
    )
)

(defun CDFourGain ()
    (let (gainProp)
	(setq gainProp (AELgetStringProp ilInst 'value))
	(cond
	    ((and gainProp (nequal "" gainProp))
	     (strcat "gain=" gainProp)
	    )
	    (t "gain=ERROR")
	)
    )
)

(defun CDFgain ()
    (let (gainProp)
	(setq gainProp (AELgetStringProp ilInst 'gain))
	(cond
	    ((and gainProp (nequal "" gainProp))
	     (strcat "gain=" gainProp)
	    )
	    (t "gain=ERROR")
	)
    )
)

(defun CDFvn1 ()
    (let (vn1Prop)
	(setq vn1Prop (AELgetStringProp ilInst 'vn1))
	(cond
	    ((and vn1Prop (nequal "" vn1Prop))
	     (strcat "vn1=" vn1Prop)
	    )
	    (t "vn1=ERROR")
	)
    )
)

(defun CDFic ()
    (let (icProp)
	(setq icProp (AELgetStringProp ilInst 'ic))
	(cond
	    ((and icProp (nequal "" icProp))
	     (strcat "ic=" icProp)
	    )
	    (t "")
	)
    )
)

(defun CDFwlm (wProp lProp mProp "sss")
    (let (wVal lVal mVal hideL retVal techRepDev cdfId)
	(setq wVal (or (AELgetStringProp ilInst wProp) "ERROR"))
	(setq lVal (or (AELgetStringProp ilInst lProp) "ERROR"))
	(setq mVal (or (AELgetStringProp ilInst mProp) "1"))

;;	(cond
;;	    ((and (setq techRepDev (TECHgetDevice ?instance ilInst))
;;		  techRepDev->minGateLength)
;;	     (when (equal (aelNumber lVal) techRepDev->minGateLength)
;;		 (setq hideL t)
;;	     )
;;	    )
;;	    ((setq cdfId (cdfGetCellCDF (ddGetObj ilInst~>libName
;;						  ilInst~>cellName)))
;;	     (when (equal lVal (get cdfId lProp)->defValue)
;;		 (setq hideL t)
;;	     )
;;	    )
;;	)

;;	(cond
;;	    (hideL (setq retVal ""))
;;	    (t (setq retVal (strcat "/" lVal)))
;;	)

	(setq retVal (strcat "/" lVal))
	(setq retVal (strcat wVal retVal))
	(when (nequal "1" mVal)
	    (setq retVal (strcat mVal "*" retVal))
	)

	retVal
    )
)

(defun CDFwlmChain (fetType startNum stopNum "sxx")
    (let (fullRetVal retVal asym symRetVal)

	(for x startNum stopNum
	     (setq retVal (CDFwlm (concat fetType 'w x)
				  (concat fetType 'l x)
				  (concat fetType 'm x)
			  )
	     )
	     (cond
		 ((equal x startNum)
		  (setq fullRetVal retVal)
		  (setq symRetVal retVal)
		 )
		 (t
		  (unless (equal symRetVal retVal)
		      (setq asym t)
		  )
		  (setq fullRetVal (strcat fullRetVal ", " retVal))
		 )
	     )
	)

	(cond
	    (asym fullRetVal)
	    (t symRetVal)
	)
    )
)

;;; 
;;; CDFwlmIfDiff --
;;;   This function will show a w/l/m value unless the values for all
;;; items in the stack are identical.  For example of a nand3
;;;
;;;   w/l/m 0 should call (CDFwlm 'nw0 'nl0 'nm0)
;;;   w/l/m 1 should call (CDFwlmIfDiff 'nw 'nl 'nm 1 2)
;;;   w/l/m 2 should call (CDFwlmIfDiff 'nw 'nl 'nm 2 2)
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFwlmIfDiff (wProp lProp mProp thisIndex maxIndex "sssxx")
    (let (isDifferent loopIndex wlmVal newWlmVal)
	(setq isDifferent nil)
	(setq wlmVal (CDFwlm (concat wProp 0)
			     (concat lProp 0)
			     (concat mProp 0)))
	(setq loopIndex 1)
	(while (and (null isDifferent) (leqp loopIndex maxIndex))
	    (setq newWlmVal (CDFwlm (concat wProp loopIndex)
				    (concat lProp loopIndex)
				    (concat mProp loopIndex)))
	    (unless (equal newWlmVal wlmVal)
		(setq isDifferent t)
	    )
	    (setq loopIndex (plus loopIndex 1))
	)
	(cond
	    (isDifferent
	     (CDFwlm (concat wProp thisIndex)
		     (concat lProp thisIndex)
		     (concat mProp thisIndex))
	    )
	    (t "")
	)
    )
)

(defun CDFlogic ()
    (let (retVal prop)
	(unless (dbGet ilInst 'hide_verilogModelName)
	    (when (setq prop (dbFindProp ilInst "modelName"))
		(setq retVal prop->value)
	    )
	)
	(or retVal "")
    )
)

(defun CDFsubcktMult ()
    (let (retVal)
	;; new method is to use property "m"; old way is property subcktMult.
	;; We do not allow this to be parameterized, so just use simple get
	(setq retVal (or (dbGet ilInst 'm) (dbGet ilInst 'subcktMult)))
	(when (integerp retVal)
	    (setq retVal (sprintf nil "%d" retVal))
	)
	(cond
	    ((or (null retVal) (equal retVal "1"))
	     (setq retVal "")
	    )
	    (t (setq retVal (strcat "m=" retVal)))
	)

	retVal
    )
)

(alias CDFmult CDFsubcktMult)

(defun CDFcellName ()
    (or ilInst~>cellName "")
)

;;; 
;;; CDFdelvto --
;;;   delvto is an interesting parameter for the fets.  They always want to
;;; parameterize it, but have its default set to 0.  This is not going to
;;; mesh too well with the new way of pPar'ing these guys, as those who are
;;; not doing the delvto varying simulations are going to have to specifically
;;; set a global param for delvto to 0 in their setup.  Both Hspice and Antrim
;;; spice support the delvto parameter for fets.
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFdelvto ()
    (let (delvto)
	
	(setq delvto (AELgetStringProp ilInst 'delvto))

	;; return delvto=val or ""
	(cond
	    ((and delvto (null (zerop (aelNumber delvto))))
	     (strcat "delvto=" delvto)
	    )
	    (t "")
	)
    )
)

;;; 
;;; CDFspiceModel --
;;;   This will get the hspiceModel property of a transistor.  If manualDiodes
;;; are specified, it will display it.  Else, it will grab the CY techrep dev
;;; for the transistor and sanity check its recommended hspiceModel verses
;;; the instance's property.  If the two are different, it will show the
;;; instance's hspiceModel property followed by a "(?)" to indicate that it
;;; is different from what is recommended.  If it matches the recommended
;;; hspiceModel, nothing is displayed.
;;;
;;; Input: cellName, such as "nfet"
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFspiceModel (cellName "t")
    (let (manualSpiceModel spiceModel fetDevice)
	(setq manualSpiceModel (dbGet ilInst 'manualSpiceModel))
	(setq spiceModel (dbGet ilInst 'hspiceModel))
	(when (or (null spiceModel) (equal "" spiceModel))
	    (setq spiceModel "ERROR_UNDEFINED_MODEL")
	)
	(cond
	    ;; when manual spice model is specified, do not do anything
	    ((and manualSpiceModel (nequal "FALSE" manualSpiceModel))
	     t
	    )
	    ;; else, sanity check against techrep device
	    (t
	     (setq fetDevice (CDFfetDeviceFromDbid ilInst cellName))
	     (cond
		 ((equal spiceModel (TECHgetDeviceParam fetDevice 'hspiceModel))
		  ;;(setq spiceModel "")
		  ;;if device exists in techrep then do nothing
		  t
		 )
		 (t (setq spiceModel (strcat spiceModel "(?)")))
	     )
	     (cond
		 ((TECHgetDeviceParam fetDevice 'isSubckt)
		  (unless (and ilInst~>isSubckt (nequal "FALSE" ilInst~>isSubckt))
		      (setq spiceModel (strcat spiceModel " not subckt?"))
		  )
		 )
		 (t
		  (unless (or (null ilInst~>isSubckt) (equal "FALSE" ilInst~>isSubckt))
		      (setq spiceModel (strcat spiceModel " subckt?"))
		  )
		 )
	     )
	    )
	)

	spiceModel
    )
)

(defun CDFtopography ()
    (let (topo)

	(setq topo (dbGet ilInst 'topography))
	(when (or (null topo) (equal "normal" topo))
	    (setq topo "")
	)

	topo
    )
)

(defun CDFmanualDiode (propName)
  (let (manual propVal)
    (setq manual (dbGet ilInst 'manualDiodes))
    (when (and manual (nequal "FALSE" manual))
      (setq propVal (AELgetStringProp ilInst propName))
      (unless propVal (setq propVal "0"))
      ;; we assume the scale factor is going to be on the order
      ;; of 1e-6.  Therefore, we slap on a "u" units suffix for
      ;; the perimeters, and a "p" units suffix for the areas
      (cond
       ((member propName '(as ad))
        (setq propVal (strcat propName "=" propVal "p"))
        )
       ((member propName '(ps pd))
        (setq propVal (strcat propName "=" propVal "u"))
        )
       )
      )
    (or propVal "")
    )
  )

(defun CDFmanualDiodeMethod (sourceOrDrain)
    (or (CDFdiodeMethodMap (dbGet ilInst (concat 'userMethod sourceOrDrain)))
	"")
)

(defun CDFmanualLOD (cellName "tg")
  (let (cellName propNameList symLOD manual propVal instCdf (retVal "") (theDevice (CDFfetDeviceFromDbid ilInst cellName)))
    (setq cellName ilInst~>master~>cellName)
    (setq instCdf (cdfGetInstCDF ilInst))
    (setq manual (dbGet ilInst 'manualLOD))
    (setq symLOD (if (equal (ENVgetVal "schematic" "symbolicLOD") "symbolic") t nil))
    (when (and 
	   (or (null symLOD) (and manual (nequal "FALSE" manual)))
	       (TECHgetDeviceParam theDevice 'enableLOD))
      (cond
       ((or (equal cellName "nfetextd")(equal cellName "nfetextdiso")(equal cellName "pfetextd"))
	(setq propNameList '(sa sb))
	)
       (t
	(setq propNameList '(sa sb sd))
	)
       )
      (foreach propName propNameList
       (setq propVal (AELgetStringProp ilInst propName))
       (unless propVal (setq propVal "0"))
       ;; we assume the scale factor is going to be on the order
       ;; of 1e-6.  Therefore, we slap on a "u" units suffix.
       (cond
        ((equal "" retVal)
         (setq retVal (strcat propName ":" propVal "u"))
         )
        (t
         (setq retVal (strcat retVal "," propName ":" propVal "u"))
         )
        ) ;; cond
       ) ;; foreach
      ) ;; when
    (when (and symLOD (or (null manual) (equal "FALSE" manual)) (TECHgetDeviceParam theDevice 'enableLOD))
      (cond
       ((or (equal cellName "nfetextd")(equal cellName "nfetextdiso")(equal cellName "pfetextd"))
	(setq propNameList '(SA SB))
	)
       (t
	(setq propNameList '(SA SB SD))
	)
       )
      (foreach propName propNameList
	       ;; symbolic values, read the cdf properties
	       (setq method (get (get instCdf (concat 'userMethodLOD_ propName)) 'value))
	       (setq propVal method)
       (cond
	((equal method "Auto (a)")
	 (setq propVal "a")
	 )
	((equal method "Minimum (min)")
	 (setq propVal "min")
	 )
	((equal method "Abutting gates (g)")
	 (setq propVal "g")
	 )
	((equal method "Tap + abutting gates (gt)")
	 (setq propVal "gt")
	 )
	((equal method "Abutting tap (t)")
	 (setq propVal "t")
	 )
	((equal method "Maximum (max)")
	 (setq propVal "max")
	 )
	((equal method "Contacts (c)")
	 (setq propVal "c")
	 )
	((equal method "No contacts (nc)")
	 (setq propVal "nc")
	 )
	(t
	 (setq propVal "")
	 )
	)
       (when (and (nequal propName 'SD) (nequal method "Abutting tap (t)") (rexMatchp "butt" method))
	 (setq buttingGates (get (get instCdf (concat 'buttingGates propName)) 'value))
	 (setq propVal (strcat buttingGates propVal))
	 )
       (cond
	((equal retVal "")
	 (setq retVal (strcat (lowerCase propName) ":" propVal))
	 )
	(t
	 (setq retVal (strcat retVal "," (lowerCase propName) ":" propVal))
	 )
	) ;; cond
       ) ;; foreach
      ) ;; when
    retVal
    ) ;; let
  ) ;; defun

(defun CDFmanualWPE (cellName "t")
  (let (manual advanced propVal (retVal "") (theDevice (CDFfetDeviceFromDbid ilInst cellName)))
    (setq manual (dbGet ilInst 'manualDiodes))
    (when (and manual (nequal "FALSE" manual) (TECHgetDeviceParam theDevice 'enableWPE))
      (setq advanced (dbGet ilInst 'advancedWPE))
      (cond
       ((and advanced (nequal "FALSE" advanced))
        (foreach
         propName '(sca scb scc)
         (setq propVal (AELgetStringProp ilInst propName))
         (unless propVal (setq propVal "0"))
         (cond
          ((equal "" retVal)
           (setq retVal (strcat propName "=" propVal))
           )
          (t
           (setq retVal (strcat retVal "," propName "=" propVal))
           )
          ) ;; cond
         ) ;; foreach
        ) ;; advanced
       (t
        (setq propVal (AELgetStringProp ilInst 'sc))
        (unless propVal (setq propVal "0"))
        (setq retVal (strcat "sc" "=" propVal "u"))
        ) ;; t
       ) ;; cond
      ) ;; when
    retVal
    ) ;; let
  ) ;; defun

(defun CDFnative ()
	(let (propVal)
		(cond
			((and (setq propVal (dbGet ilInst 'native))
			      (nequal "FALSE" propVal))
				"nhvi"
	    )
			((and (setq propVal (dbGet ilInst 'lvNative))
			      (nequal "FALSE" propVal))
				"lvNative"
	    )
			((and (setq propVal (dbGet ilInst 'ntvNative))
			      (nequal "FALSE" propVal))
				"ntv"
	    )
			(t "")
		)
	)
)

(defun CDFesdFet ()
  (let (propVal isESD)
    (cond
     ((and (setq propVal (dbGet ilInst 'isESD))
	   (nequal "FALSE" propVal))
      (setq isESD "ESD")
      )
     (t (setq isESD ""))
     )
    )
)

;;; 
;;; CDFgetRev --
;;;   This function could get slow because it talks to Sync for this info.
;;; Therefore, only show this info if they have the global CDFshowRev set.
;;;
;;; Input: 
;;; Output: 
;;; Globals: CDFshowRev
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFgetRev ()
    (cond
	((and (boundp 'CDFshowRev)
	      CDFshowRev
	      (nequal "FALSE" CDFshowRev)
	      (isCallable 'dssGetVersionsByName))
	 (or (car (last (dssGetVersionsByName ilInst~>cellView~>libName
					      ilInst~>cellView~>cellName
					      ilInst~>cellView~>viewName))
	     )
	     "")
	)
	(t "")
    )
)

;;; 
;;; CDFdisplayResistance --
;;;   This function will display the resistance value of a resistor.
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFdisplayResistance (instDbid)
    (let (r rHasChanged)

	(cond
	    ;; if it is an absolute resistor, no problem
	    ((and instDbid~>isAbsoluteRes (nequal "FALSE" instDbid~>isAbsoluteRes))
	     (setq r (AELgetStringProp instDbid 'r))
	    )

	    ((null (ENVgetVal "schematic" "displayDynamicResistors"))
	     (setq r (AELgetStringProp instDbid 'r))
	     (setq rHasChanged
		   (CDFhasRchanged (equal "R Driven" instDbid~>lrDriven)
				   instDbid~>r
				   instDbid~>rw
				   instDbid~>rl
				   instDbid~>rm
				   instDbid~>model
				   instDbid~>rcon0m
				   instDbid~>rcon1m
		   )
	     )
	    )

	    ;; if it is a user defined resistor
	    ((equal "User" instDbid~>usermod)
	     (setq r
		   (CDFdisplayCalculateR instDbid~>rw
					 instDbid~>rl
					 instDbid~>rm
					 nil
					 instDbid~>rcon0m
					 instDbid~>rcon1m
					 instDbid~>userRconModel
					 instDbid~>useSheetRes
		   )
	     )
	    )

	    ;; else, let it lookup the device in the techrep, and
	    ;; calculate based on width and length
	    (t
	     (setq r
		   (CDFdisplayCalculateR instDbid~>rw
					 instDbid~>rl
					 instDbid~>rm
					 instDbid~>model
					 instDbid~>rcon0m
					 instDbid~>rcon1m
					 instDbid~>rconModel
					 nil
		   )
	     )
	     (setq rHasChanged
		   (CDFhasRchanged (equal "R Driven" instDbid~>lrDriven)
				   instDbid~>r
				   instDbid~>rw
				   instDbid~>rl
				   instDbid~>rm
				   instDbid~>model
				   instDbid~>rcon0m
				   instDbid~>rcon1m
		   )
	     )
	    )
	)
	(unless (stringp r)
	    (setq r (sprintf nil "%L" r))
	)
	(when rHasChanged
	    (setq r (strcat "changed " r))
	)

	r
    )
)

;;; 
;;; CDFdisplayCalculateR --
;;;   This function will calculate a resistor's R based on the current
;;; schematic display options of typical, high, or low resistances,
;;; with or without rcons.
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFdisplayCalculateR (w l m resModel rcon0m rcon1m rconModel userSheetRes)

    (let (r deltaW deltaL resDev rconDev rcon0Res rcon1Res sheetRes typHighLow
	    isSubckt adjustedForM changedText)

	(foreach x '(w l m)
	    (when (aelIsNumberP (eval x))
		(set x (aelNumber (eval x)))
	    )
	)

	(setq typHighLow (ENVgetVal "schematic" "resShowTypHighLow"))

	(cond
	    (resModel
	     (setq resDev (car (TECHgetResistorDevices nil resModel)))
	     (unless resDev
		 (setq resDev (car (TECHgetRes3Devices nil resModel)))
	     )
	     (setq deltaW (TECHgetDeviceParam resDev 'deltaW))
	     (unless deltaW (setq deltaW 0.0))
	     (setq deltaL (TECHgetDeviceParam resDev 'deltaL))
	     (unless deltaL (setq deltaL 0.0))
	     (setq isSubckt (TECHgetDeviceParam resDev 'isSubckt))

	     ;; sheet resistance is either "sheet", "sheetHigh", or "sheetLow"
	     ;; depending on what they want to see
	     (cond
		 ((equal "high" typHighLow)
		  (setq sheetRes (TECHgetDeviceParam resDev 'sheetHigh))
		  (unless sheetRes (setq sheetRes "unknownHighSheetres"))
		 )
		 ((equal "low" typHighLow)
		  (setq sheetRes (TECHgetDeviceParam resDev 'sheetLow))
		  (unless sheetRes (setq sheetRes "unknownLowSheetres"))
		 )
		 ((equal "typical" typHighLow)
		  (setq sheetRes (TECHgetDeviceParam resDev 'sheet))
		  (unless sheetRes (setq sheetRes "unknownTypSheetres"))
		 )
	     )
	    )
	    ;; if a resModel was not specified, it must be a user defined
	    ;; resistor model, with user defined sheet resistance
	    (t
	     (setq sheetRes userSheetRes)
	     (setq deltaW 0.0)
	     (setq deltaL 0.0)
	    )
	)

	(cond
	    ((and (numberp w) (numberp l) (numberp sheetRes) (numberp deltaW) (numberp deltaL))
	     (setq r (quotient (times (difference l deltaL) sheetRes) (difference w deltaW)))
	    )
	    (t
	     ;; get things as strings
	     (foreach x '(w l sheetRes deltaW deltaL)
		 (when (numberp (eval x))
		     (set x (sprintf nil "%L" (eval x)))
		 )
	     )
	     (setq r (sprintf nil "((%s-%s)*%s/(%s-%s))" l deltaL sheetRes w deltaW))
	    )
	)

	;; if they want to display the resistance with contacts
	(when (or (ENVgetVal "schematic" "resShowWithContacts")
		  (and isSubckt (TECHgetDeviceParam resDev 'headRes)))
	    (cond
		;; when it is a subckt based resistor, the contacts are in
		;; the "headRes" properties of the techrep resistor device.
		;; This behaves slightly differently with the m-factors than
		;; the non-headRes resistors
		((and isSubckt (TECHgetDeviceParam resDev 'headRes))

		 ;; get the head contact resistance for typ, high, or low
		 (cond
		     ((equal "typical" typHighLow)
		      (setq rconRes (TECHgetDeviceParam resDev 'headRes))
		      (unless rconRes (setq rconRes "unknownTypRconRes"))
		     )
		     ((equal "high" typHighLow)
		      (setq rconRes (TECHgetDeviceParam resDev 'headResHigh))
		      (unless rconRes (setq rconRes "unknownHighRconRes"))
		     )
		     ((equal "low" typHighLow)
		      (setq rconRes (TECHgetDeviceParam resDev 'headResLow))
		      (unless rconRes (setq rconRes "unknownLowRconRes"))
		     )
		 )

		 (cond
		     ((and (numberp rconRes) (numberp r) (numberp m))
		      (setq r (quotient (plus r rconRes) m))
		     )
		     (t
		      ;; get things as strings
		      (foreach x '(r rconRes m)
			  (when (numberp (eval x))
			      (set x (sprintf nil "%L" (eval x)))
			  )
		      )
		      (setq r (sprintf nil "(%s+%s)/%s" r rconRes m))
		     )
		 )
		 (setq adjustedForM t)

		) ;; end when it is a subckt based resistor with specific
		;; head resistance properties

		;; When the user can specify the number of contacts on each
		;; end of the resistor
		(t
		 (unless (and rcon0m (nequal "" rcon0m)
			      (null (zerop (aelNumber rcon0m))))
		     (setq rcon0m nil)
		 )
		 (unless (and rcon1m (nequal "" rcon1m)
			      (null (zerop (aelNumber rcon1m))))
		     (setq rcon1m nil)
		 )

		 ;; if they have any contact resistors
		 (when (or rcon0m rcon1m)
		     ;; first, get the contact resistor device
		     (setq rconDev (car (TECHgetRconDevices nil rconModel)))
		     (cond
			 ((null rconDev)
			  (setq rconRes nil)
			 )
			 ((equal "typical" typHighLow)
			  (setq rconRes
				(TECHgetDeviceParam rconDev 'contactRes))
			  (unless rconRes (setq rconRes "unknownTypRconRes"))
			 )
			 ((equal "high" typHighLow)
			  (setq rconRes
				(TECHgetDeviceParam rconDev 'contactResHigh))
			  (unless rconRes (setq rconRes "unknownHighRconRes"))
			 )
			 ((equal "low" typHighLow)
			  (setq rconRes
				(TECHgetDeviceParam rconDev 'contactResLow))
			  (unless rconRes (setq rconRes "unknownLowRconRes"))
			 )
		     )
		     (unless rconRes (setq rconRes "?"))

		     (foreach (rconXm rconXRes)
			 '(rcon0m rcon1m)
			 '(rcon0Res rcon1Res)

			 (cond
			     ((null (eval rconXm))
			      (set rconXRes 0.0)
			     )
			     ((and (aelIsNumberP rcon0m)
				   (aelIsNumberP rconRes))
			      (set rconXRes (times (aelNumber (eval rconXm))
						   (aelNumber rconRes)))
			     )
			     (t
			      (when (numberp (eval rconXm))
				  (set rconXm (sprintf nil "%L" (eval rconXm)))
			      )
			      (when (numberp rconRes)
				  (setq rconRes (sprintf nil "%L" rconRes))
			      )
			      (set rconXRes
				   (sprintf nil "(%s*%s)"
					    (eval rconXm) rconRes))
			     )
			 )
		     )

		     (cond
			 ((and (numberp r)
			       (numberp rcon0Res)
			       (numberp rcon1Res)
			       (numberp m))
			  (setq r (plus (quotient r m) rcon0Res rcon1Res))
			 )
			 (t
			  (foreach x '(r m rcon0Res rcon1Res)
			      (when (numberp (eval x))
				  (set x (sprintf nil "%L" (eval x)))
			      )
			  )
			  (setq r (sprintf nil "(%s/%s)+%s+%s" r m rcon0Res rcon1Res))
			 )
		     )
		     (setq adjustedForM t)
		 ) ;; end when there were contacts

		) ;; end when it is a non-subckt based resistor
	    )
	) ;; end when they are showing resistance with contacts

	;; if we have not adjusted for the m-factor yet
	(unless adjustedForM
	    (cond
		((and (numberp m) (numberp r))
		 (setq r (quotient r m))
		)
		(t
		 (foreach x '(r m)
		     (when (numberp (eval x))
			 (set x (sprintf nil "%L" (eval x)))
		     )
		 )
		 (setq r (sprintf nil "(%s/%s)" r m))
		)
	    )
	)

	r
    ) ;; end let
)

;;; 
;;; CDFhasRchanged --
;;;   if it is a resistance driven resistor, make sure that the
;;; resistance value is the same as it was originally created.
;;; This may be caused by an update to the sheet rho.
;;;
;;; Input: isRdriven - boolean of whether it is a resistance driven resistor
;;;        w, l, m - width, length, m-factor of resistor
;;;        rcon0m, rcon1m - contact resistor m-factors for r0 and r1 terms
;;;
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: t if the R has changed notably, nil otherwise
;;; 
(defun CDFhasRchanged (isRdriven instR w l m resModel rcon0m rcon1m)
    (let (tmpR retVal maxDiff sheetRes)
	(when isRdriven

	    (when resModel
		(setq resDev (car (TECHgetResistorDevices nil resModel)))
		(unless resDev
		    (setq resDev (car (TECHgetRes3Devices nil resModel)))
		)
	    )

	    ;; this will only calculate the typical resistance
	    ;; as it might be stored by the "r" instance property
	    (setq tmpR (CDFcalculateRes nil 0 m w l resDev nil
					rcon0m rcon1m))
	    (when (and tmpR (aelIsNumberP tmpR)
		       instR (aelIsNumberP instR))

		(when (stringp tmpR) (setq tmpR (aelNumber tmpR)))
		(when (stringp instR) (setq instR (aelNumber instR)))

		(when (stringp w) (setq w (aelNumber w)))
		(when (setq sheetRes (TECHgetDeviceParam resDev 'sheet))
		    ;; get the maximum difference for just over half a grid
		    (setq maxDiff
			  (quotient (times (TECHgetProp snapGrid) 0.51 sheetRes) w)
		    )
		)

		(cond
		    (maxDiff
		     (when (greaterp (abs (difference instR tmpR)) maxDiff)
			 (setq retVal t)
		     )
		    )
		    (t
		     ;; if the number calculated for the R is different
		     ;; by more than 0.5%, add "changed" to the label.
		     ;; This may be too coarse as it snaps to the nearest
		     ;; grid for the defined layer.
		     (unless (or (equal instR tmpR)
				 (lessp (abs (difference instR tmpR))
					(abs (times tmpR 0.005))))

			 (setq retVal t)
		     )
		    )
		)
	    )
	)

	retVal
    )
)

;;; 
;;; CDFcapCalculate --
;;;   This function is used to calculate and interpolate a capacitance
;;; value for the given width, width indices, length, space, and space
;;; indices.
;;;
;;; Input: 
;;; Output: 
;;; Globals: 
;;; Side Effects: 
;;; Return: 
;;; 
(defun CDFcapCalculate (capModel w width1 width2 l m space space1 space2
				 coupling adjustWidthByM)
    (let
	((scale (TECHgetProp scaleFactor))
	 lineBuffer
	 areaCapBuffer
	 perimBuffer
	 perimCapBuffer
	 neighborFringeBuffer
	 plateFringeBuffer
	 Ca
	 Cc1 Cc2 Cc3 Cc4
	 Cf1 Cf2 Cf3 Cf4
	 linearCc linearCf
	 tmpEntry
	)

	(when (numberp scale) (setq scale (times 1e-6 scale)))

	;; get the spaces and widths, etc, as numbers
	(foreach x '(space space1 space2 w width1 width2 l coupling m)
	    (when (and (eval x) (aelIsNumberP (eval x)))
		(set x (aelNumber (eval x)))
	    )
	)

	(when (and w (aelIsNumberP w)
		   l (aelIsNumberP l)
		   coupling (aelIsNumberP coupling))

	    ;; ugly, ugly kludge.  In ancient days, we used to effectively
	    ;; adjust the mfactor for caps in rescaps by multiplying the
	    ;; width by the mfactor to create the "cw" value.  However, this
	    ;; does not let the perimeter capacitance scale with the mfactor
	    ;; correctly now that we have gone to equation based caps.
	    (when adjustWidthByM
		(setq w (quotient w (or m 1.0)))
	    )

	    ;; there will always be at least one space datapoint
	    (cond
		(width1
		 (setq tmpEntry
		       (arrayref TECHcapParams (list capModel space1 width1)))
		 (setq Ca (nth 0 tmpEntry))
		 (setq Cc1 (nth 1 tmpEntry))
		 (setq Cf1 (nth 2 tmpEntry))
		 (when space2
		     (setq tmpEntry
			   (arrayref TECHcapParams (list capModel space2 width1)))
		     (setq Cc2 (nth 1 tmpEntry))
		     (setq Cf2 (nth 2 tmpEntry))
		 )
		 (when (and (null space2) width2)
		     (setq tmpEntry
			   (arrayref TECHcapParams (list capModel space1 width2)))
		     (setq Cc2 (nth 1 tmpEntry))
		     (setq Cf2 (nth 2 tmpEntry))
		 )
		 (when (and space2 width2)
		     (setq tmpEntry
			   (arrayref TECHcapParams (list capModel space1 width2)))
		     (setq Cc3 (nth 1 tmpEntry))
		     (setq Cf3 (nth 2 tmpEntry))
		     (setq tmpEntry
			   (arrayref TECHcapParams (list capModel space2 width2)))
		     (setq Cc4 (nth 1 tmpEntry))
		     (setq Cf4 (nth 2 tmpEntry))
		 )
		)
		;; if we do not use width as a table lookup (only space)
		(t
		 (setq tmpEntry
		       (arrayref TECHcapParams (list capModel space1)))
		 (setq Ca (nth 0 tmpEntry))
		 (setq Cc1 (nth 1 tmpEntry))
		 (setq Cf1 (nth 2 tmpEntry))
		 (when space2
		     (setq tmpEntry
			   (arrayref TECHcapParams (list capModel space2)))
		     (setq Cc2 (nth 1 tmpEntry))
		     (setq Cf2 (nth 2 tmpEntry))
		 )
		)
	    )

	    ;; we will print the mfactor as m*capValue, so get it as a string
	    (when (integerp m) (setq m (sprintf nil "%d" m)))
	    (when (floatp m) (setq m (sprintf nil "%g" m)))

	    ;; the area equation is going to be the same for all cases
	    (when (and (numberp w) (numberp l) (numberp scale) (numberp Ca))
		(setq areaCapBuffer (times l scale w scale Ca))
		;; the perimeter equation is going to be the same for all cases
		;; However, for rescaps, do not count the phantom line that
		;; splits it into two caps
		(cond
		    (adjustWidthByM
		     (setq perimBuffer (times scale (plus w l l)))
		    )
		    (t
		     (setq perimBuffer (times 2 scale (plus w l)))
		    )
		)
	    )
	    (cond
		;; if there are 4 data points to do a 2D interpolation between
		;; both width and space
		;;
		(Cc4
		 (setq linearCc
		       (CDFinterpolate w
				   width1
				   (CDFinterpolate space space1 Cc1 space2 Cc2)
				   width2
				   (CDFinterpolate space space1 Cc3 space2 Cc4)
		       )
		 )
		 (setq linearCf
		       (CDFinterpolate w
				   width1
				   (CDFinterpolate space space1 Cf1 space2 Cf2)
				   width2
				   (CDFinterpolate space space1 Cf3 space2 Cf4)
		       )
		 )
		)
		;; if there are 2 data points, and it is width based
		((and Cc2 width2)
		 (setq linearCc (CDFinterpolate w width1 Cc1 width2 Cc2))
		 (setq linearCf (CDFinterpolate w width1 Cf1 width2 Cf2))
		)
		;; if there are 2 data points, and it is space based
		((and Cc2 space2)
		 (setq linearCc (CDFinterpolate space space1 Cc1 space2 Cc2))
		 (setq linearCf (CDFinterpolate space space1 Cf1 space2 Cf2))
		)
		;; if it is an exact match on both width and space
		(t
		 (setq linearCc Cc1)
		 (setq linearCf Cf1)
		)
	    )

	    (when (and (numberp coupling)
		       (numberp linearCc)
		       (numberp linearCf))
		(setq neighborFringeBuffer (times coupling linearCc))
		(setq perimCapBuffer
		      (times perimBuffer (plus neighborFringeBuffer linearCf)))
	    )

	    ;; still needed, properly handle the significant digits
	    (when (and (numberp areaCapBuffer) (numberp perimCapBuffer))
		(cond
		    ((or (null m) (onep m))
		     (sprintf lineBuffer "C=%s"
			      (CDFbaFloatToString
			       (plus areaCapBuffer perimCapBuffer)))
		    )
		    (t
		     (sprintf lineBuffer "C=%s*%s"
			      m (CDFbaFloatToString
				 (plus areaCapBuffer perimCapBuffer)))
		    )
		)
	    )
	)
    )
)

;;; 
;;; CDFinterpolate --
;;;   This function will return a number from a linear interpolation.
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
(defun CDFinterpolate (xi x1 y1 x2 y2)

    ;; get everything as a number
    (foreach param '(xi x1 y1 x2 y2)
	(unless (numberp (eval param))
	    (when (and (stringp (eval param)) (aelIsNumberP (eval param)))
		(set param (aelNumber (eval param)))
	    )
	)
    )
    (cond
	;; if they are not all numbers
	((null (and (numberp xi) (numberp x1) (numberp y1) (numberp x2)
		    (numberp y2)))
	 nil
	)

	;; do not divide by 0
	((or (null x2) (equal x1 x2)) y1)

	(t
	 (plus y1 (quotient (times (difference xi x1) (difference y2 y1))
			    (difference x2 x1)))
	)
    )
)

;;; Deep nwell label
(defun CDFdeepNwell ()
    (let (deepNwell)

	(setq deepNwell (dbGet ilInst 'deepNwell))
	(when (or (null deepNwell) (equal "FALSE" deepNwell))
	    (setq deepNwell "")
	)
	(when (and deepNwell (equal "TRUE" deepNwell))
	    (setq deepNwell "dnw")
	)
	deepNwell
    )
)
