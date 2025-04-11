;;; 
;;; $Id: tech.il 2 2018/02/20 18:48:50 GMT jszemiot Exp $
;;; 
;;; tech.il
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
;;;   osd 04/17/12  stress Rev AT updates
;;;   osd 04/26/12  antenna values
;;;   cva 06/07/12  TPA updates, reticle priority correction and M5 space/width
;;;   osd 06/29/12  spr 81542 updates
;;;   osd 10/30/12  TDR Rev AM
;;;   osd 12/12/12  updated ccu1m opuslayerno.
;;;  mmwn 02/03/13  adding rdlprobepad
;;;   cva 05/16/13  TDR rev CS, areaid.sigPad*
;;;  mmwn 05/29/13  TDR rev CS, s8phirs updates
;;;   cva 06/26/13  Adding scribe/field tone for cu1m and pmm2
;;;  mmwn 10/01/13  Adding rdlcon definition for AP
;;;  mmwn 10/15/13  res7 value bugfix for hrpoly (SPR 89801)
;;;  mmwn 10/25/13  adding hvtr/chvtrm and s8shrink rules (TDR CX)
;;;  mmwn 11/18/13  LPP updates for hvtrm
;;;   vse 12/10/13  added SERC tables
;;;  mmwn 02/06/14  Updates for rdl/pad(rdlcon) layer numbers for MW/AP/RH
;;;  mmwn 03/06/14  TDR DB - Adding PBO
;;;  mmwn 03/10/14  Adding cpmm.dg back for some pad generation in etest
;;;  mmwn 04/24/14  Adding WLCSP layers
;;;   cva 06/12/14  removing areaid.lvdnw (cannot find reason it exists)
;;;   cva 09/17/14  correcting tunm.3/4, TDR rev DF
;;;   cva 12/18/14  adding new pcell, TDR rev DL
;;;   cva 01/21/15  TDR rev DM, reverting to 13um CPBO
;;;   cva 2015-06-01  TDR rev DR, hvnvtm removal
;;;   cva 2015-08-20  TDR rev DV, mm5 waffleDrop
;;;


(TECHinit)
(TECHinclude (BOOTprependSrcPath "ilexec/generic.il"))
(TECHinclude (BOOTprependTechPath "../pcios/s8/s8x/info/s8-generic.il"))

(TECHdefProp  ?technology     "S130"
              ?snapGrid       0.005
              ?voltage        5.0
              ?scaleFactor    1.0
              ?metopLayer     "met3"
              ?distributedResCap t
              ?multipleSpacings t
              ?modelsACM      12 
              ?enableNrdNrs   t
              ?extWaffles     t
              ?pdDelta        t
              ?packageNoAddVia t
              ?twoLPP   (list '("FOM" "P1M") '("DNM" "HVNTM") '("LVTNM" "TUNM") '("HVTPM") '("HVTRM" "MM5")
                              '("NWM" "LVOM") '("ONOM" "PSDM") '("RPM" "NTM") '("LDNTM" "NPCM")
                              '("NSDM" "LI1M") '("LICM1" "CTM1") '("MM1" "MM2") '("VIM" "VIM2") 
                              '("MM3" "MM4") '("VIM3") '("VIM4" "NSM") '("PDM"))
              ?threeLPP (list '("FOM" "P1M" "LI1M") '("DNM" "HVNTM" "LDNTM") '("LVTNM" "TUNM" "NPCM")
                              '("HVTPM" "ONOM") '("HVTRM") '("NWM" "LVOM" "NTM")  '("RPM" "MM5")
                              '("PSDM" "NSDM" "MM4") '("LICM1" "CTM1" "VIM") '("MM1" "MM2" "MM3") '("VIM2" "VIM3")
                              '("VIM4" "NSM" "PDM") '("MM5"))
              ?fourLPP (list  '("FOM" "ONOM" "P1M" "LI1M") '("DNM" "LVTNM" "TUNM" "NPCM")
                              '("HVTPM" "PSDM" "NSDM") '("HVTRM" "MM5" "PDM") '("NWM" "LVOM" "NTM" "MM5") 
                              '("HVNTM" "LDNTM" "VIM4" "NSM") '("LICM1" "CTM1" "VIM" "VIM2")
                              '("MM1" "MM2" "MM3" "MM4") '("VIM3"))
)

;;; Load flow common rules
(TECHinclude (BOOTprependTechPath "../pcios/s8/s8x/info/tech.il"))

;;; Notes:
;;; 1. when fieldType is "clear", TPA is produced with Tone="digitized"
;;;    when it is "opaque", Tone="reverse". If other combinations are
;;;    needed, then ?nikonType must be used
;;; 2. if a layer is defined for the flow, but not used in TPA table
;;;    then ?tpaIgnore t
;;; 3. in the case that a layer has defined minSpace and minWidth rules, and
;;;    that values are the same for both TPA and DRC then
;;;    ?cdLayer "layer_name" can be used instead of ?drawnWidth and ?drawnSpace
;;; 4. if the mask has ?cdLayer property (i.e. entry in "layout data name" field of "mask layer info"
;;;    table, then its minSpace & minWidth properties will be derived from the corr. rule no. in tech.il
;;;    else the ?drawnWidth & ?drawnSpace params. will have to be defined.
;;; 5. 
;;;
(TECHdefLayer ?name "cncm"
              ?purposes '("drawing")
                  ?isVisible         t
                  ?isSelectable      nil
              )              
(TECHdefLayer ?name "cncm"
              ?reticleGrade "C4-365-BIM-LSR-WET"
              ?purposes '("mask")
                  ?isVisible         t
                  ?isSelectable      nil
              ?nikonType "DIGITIZED"
              ?fieldType "OPAQUE"
              ?scribeLane "OPAQUE"
              ?tpaIgnore t
              ?lbarDrawn    "ncm"
              )
(TECHdefLayer ?name "cviam2"
              ?purposes '("drawing")
              )
(TECHdefLayer ?name "cviam2"
              ?reticleGrade "F4-248-EAPSM-A43-APRX"
              ?spotSize 0.020
              ?reticlePriority 25
              ?cdLayer "via2"
              ?purposes '("mask")
              ?maskLayerNumber '( ("cypress" "560") ("gsmc" "802") )
              ?foundryLayerName "Via 2-Q/PLM"
              ?photoResistTone "POS"
              ?nikonType "DIGITIZED"
              ?fieldType "OPAQUE"
              ?scribeLane "OPAQUE"
              ?sizing 0.04
              ?opc "N/A"
              ?photoProcess "5500/700"
              ?lbarDrawn    "via2"
              )
(TECHdefLayer ?name "cmm3"
              ?purposes '("drawing")
              )
(TECHdefLayer ?name "cmm3"
              ?reticleGrade "E4-248-BIM-A37-DRY"
              ?spotSize 0.020
              ?reticlePriority 26
              ?cdLayer "met3"
              ?purposes '("mask")
              ?maskLayerNumber '( ("cypress" "570") ("gsmc" "703A") )
              ?foundryLayerName "Metal 3-Q/PLM"
              ?photoResistTone "POS"
              ?nikonType "DIGITIZED"
              ?fieldType "CLEAR"
              ?scribeLane "CLEAR"
              ?sizing 0.02
              ?opc "N/A"
              ?photoProcess "5500/700"
              ?lbarDrawn    "met3"
              )
(TECHdefLayer ?name "cviam3"
              ?purposes '("drawing")
              )
(TECHdefLayer ?name "cviam3"
              ?reticleGrade "F4-248-EAPSM-A43-APRX"
              ?spotSize 0.020
              ?reticlePriority 27
              ?drawnWidth 0.200
              ?drawnSpace 0.200
              ?purposes '("mask")
              ?maskLayerNumber '( ("cypress" "575") ("gsmc" "809") )
              ?foundryLayerName "Via3-QLM"
              ?photoResistTone "POS"
              ?nikonType "DIGITIZED"
              ?fieldType "OPAQUE"
              ?scribeLane "OPAQUE"
              ?sizing 0.04
              ?opc "N/A"
              ?photoProcess "5500/400"
              ?lbarDrawn    "via3"
              )
(TECHdefLayer ?name "cmm4"
              ?reticleGrade "E4-248-BIM-A37-DRY"
              ?spotSize 0.020
              ?reticlePriority 28
              ?drawnWidth 0.300 
              ?drawnSpace 0.300  
              ?purposes '("mask")
              ?maskLayerNumber '( ("cypress" "580") ("gsmc" "798") )
              ?foundryLayerName "Metal 4-QLM"
              ?photoResistTone "POS"
              ?nikonType  "DIGITIZED"
              ?fieldType  "CLEAR"
              ?scribeLane "CLEAR"
              ?sizing 0.02
              ?opc "N/A"
              ?photoProcess "5500/400"
              ?lbarDrawn    "met4"
              ?mwtfLayer   "met4"
              ?mwtfNumber  '(71 0)
              )
(TECHdefLayer ?name "cviam4"
              ?purposes '("drawing")
              )
(TECHdefLayer ?name "cviam4"
              ?reticleGrade "B4-248-BIM-LSR-WET"
              ?spotSize 0.020
              ?reticlePriority 29
              ?drawnWidth 0.800
              ?drawnSpace 0.800
              ?purposes '("mask")
              ?maskLayerNumber '( ("cypress" "585") ("gsmc" "809") )
              ?photoResistTone "POS"
              ?nikonType "DIGITIZED"
              ?fieldType "OPAQUE"
              ?scribeLane "OPAQUE"
              ?sizing 0.00
              ?opc "N/A"
              ?photoProcess "5500/400"
              ?lbarDrawn    "via4"
              ?mwtfLayer   "via4"
              ?mwtfNumber  '(58 0)
              )
(TECHdefLayer ?name "cmm5"
              ?reticleGrade "B4-248-BIM-LSR-WET"
              ?spotSize 0.020
              ?reticlePriority 30
              ?drawnWidth 1.600 
              ?drawnSpace 1.600  
              ?purposes '("mask")
              ?maskLayerNumber '( ("cypress" "590") ("gsmc" "798") )
              ?photoResistTone "POS"
              ?nikonType  "DIGITIZED"
              ?fieldType  "CLEAR"
              ?scribeLane "CLEAR"
              ?sizing 0.03
              ?opc "N/A"
              ?photoProcess "5500/400"
              ?lbarDrawn    "met5"
              ?mwtfLayer   "met5"
              ?mwtfNumber  '(72 0)
              )
(TECHdefLayer ?name "ctunm"
              ?purposes '("mask")
              ?reticlePriority 8
)
(TECHdefLayer ?name "conom"
              ?purposes '("mask")
              ?reticlePriority 9
)
(TECHdefLayer ?name "clvom"
              ?purposes '("mask")
              ?reticlePriority 10
)
(TECHdefLayer ?name "cp1m"
              ?purposes '("mask")
              ?reticlePriority 12
)
(TECHdefLayer ?name "cntm"
              ?purposes '("mask")
              ?reticlePriority 13
)
(TECHdefLayer ?name "chvntm"
              ?purposes '("mask")
              ?reticlePriority 14
)
(TECHdefLayer ?name "cldntm"
              ?purposes '("mask")
              ?reticlePriority 15
)
(TECHdefLayer ?name "cnpc"
              ?purposes '("mask")
              ?reticlePriority 16
)
(TECHdefLayer ?name "cpsdm"
              ?purposes '("mask")
              ?reticlePriority 17
)
(TECHdefLayer ?name "cnsdm"
              ?purposes '("mask")
              ?reticlePriority 18
)
(TECHdefLayer ?name "clicm1"
              ?purposes '("mask")
              ?reticlePriority 19
)
(TECHdefLayer ?name "cli1m"
              ?purposes '("mask")
              ?reticlePriority 20
)
(TECHdefLayer ?name "cctm1"
              ?purposes '("mask")
              ?reticlePriority 21
)
(TECHdefLayer ?name "cmm1"
              ?purposes '("mask")
              ?reticlePriority 22
)
(TECHdefLayer ?name "cviam"
              ?purposes '("mask")
              ?reticlePriority 23
)
(TECHdefLayer ?name "cmm2"
              ?purposes '("mask")
              ?reticlePriority 24
)
(TECHdefLayer ?name "cnsm"
              ?purposes '("mask")
              ?reticlePriority 31
)
(TECHdefLayer ?name "cpdm"
              ?purposes '("mask")
              ?reticlePriority 32
)
(TECHdefLayer ?name "cpbo"
              ?purposes '("mask")
              ?tpaIgnore t
)

(TECHdefLayer ?name "pmm"
              ?purposes '("drawing")
              ?gdsIInumber '(85 44) 
              ?opusLayerNumber 76
              ?packet "post2"
              ?isVisible         t
              ?isSelectable      t
              ?contributesChange t
              ?isDragable        t
              ?isLswValid        t
              ?hyperplot         '(700 -1 4 -1 1 4)
)

(TECHdefLayer ?name              "pi1"
              ?purposes          '("drawing")
              ?gdsIInumber       '(127 20)
              ?opusLayerNumber   139
              ?packet            "nnm"
              ?isVisible         t
              ?isSelectable      t
              ?contributesChange t
              ?isDragable        t
              ?isLswValid        t
              ?hyperplot         '(1 -2 7 -1 6 7)
)
(TECHdefLayer ?name "rdl"
              ?purposes '("psa1")
              ?gdsIInumber '(74 88)
              ?opusLayerNumber 136
              ?packet "met7Psa1"
              ?isVisible         t
              ?isSelectable      t
              ?contributesChange t
              ?isDragable        t
              ?isLswValid        t
              ?hyperplot         '(247 -1 247 -1 1 247)
)
(TECHdefLayer ?name "rdl"
              ?purposes '("psa2")
              ?gdsIInumber '(74 89)
              ?opusLayerNumber 136
              ?packet "met7Psa2"
              ?isVisible         t
              ?isSelectable      t
              ?contributesChange t
              ?isDragable        t
              ?isLswValid        t
              ?hyperplot         '(247 -1 247 -1 1 247)
)
(TECHdefLayer ?name "rdl"
              ?purposes '("psa3")
              ?gdsIInumber '(74 90)
              ?opusLayerNumber 136
              ?packet "met7Psa3"
              ?isVisible         t
              ?isSelectable      t
              ?contributesChange t
              ?isDragable        t
              ?isLswValid        t
              ?hyperplot         '(247 -1 247 -1 1 247)
)
(TECHdefLayer ?name "rdl"
              ?purposes '("psa4")
              ?gdsIInumber '(74 91)
              ?opusLayerNumber 136
              ?packet "met7Psa4"
              ?isVisible         t
              ?isSelectable      t
              ?contributesChange t
              ?isDragable        t
              ?isLswValid        t
              ?hyperplot         '(247 -1 247 -1 1 247)
)
(TECHdefLayer ?name "rdl"
              ?purposes '("psa5")
              ?gdsIInumber '(74 92)
              ?opusLayerNumber 136
              ?packet "met7Psa5"
              ?isVisible         t
              ?isSelectable      t
              ?contributesChange t
              ?isDragable        t
              ?isLswValid        t
              ?hyperplot         '(247 -1 247 -1 1 247)
)
(TECHdefLayer ?name "rdl"
              ?purposes '("psa6")
              ?gdsIInumber '(74 93)
              ?opusLayerNumber 136
              ?packet "met7Psa6"
              ?isVisible         t
              ?isSelectable      t
              ?contributesChange t
              ?isDragable        t
              ?isLswValid        t
              ?hyperplot         '(247 -1 247 -1 1 247)
)
(TECHdefLayer ?name              "rdl"
              ?purposes          '("drawing")
              ?gdsIInumber       '(74 20)
              ?opusLayerNumber   136
              ?packet            "met7"
              ?isVisible         t
              ?isSelectable      t
              ?contributesChange t
              ?isDragable        t
              ?isLswValid        t
              ?hyperplot         '(247 -1 247 -1 1 247)
)
(TECHdefLayer ?name              "rdl"
              ?purposes          '("pin")
              ?gdsIInumber       '(74 16)
              ?opusLayerNumber   136
              ?packet            "met7Pin"
              ?isVisible         t
              ?isSelectable      t
              ?contributesChange t
              ?isDragable        t
              ?isLswValid        t
              ?hyperplot         '(247 -1 247 -1 1 1)
)
(TECHdefLayer ?name "rdl"
            ?purposes '("res")
            ?gdsIInumber '(74 13)
            ?opusLayerNumber 136
            ?packet "rpolyRes"
            ?isVisible         t
            ?isSelectable      t
            ?contributesChange t
            ?isDragable        t
            ?isLswValid        t
            ?hyperplot         '(4 -2 4 -1 6 4)
)
(TECHdefLayer ?name "rdl"
            ?purposes '("cut")
            ?gdsIInumber '(74 14)
            ?opusLayerNumber 136
            ?packet "rpolyCut"
            ?isVisible         t
            ?isSelectable      t
            ?contributesChange t
            ?isDragable        t
            ?isLswValid        t
            ?hyperplot         '(4 -2 4 -1 6 4)
)
(TECHdefLayer ?name              "rdl"
              ?purposes          '("label")
              ?gdsIInumber       '(74 5)
              ?opusLayerNumber   136
              ?packet            "met7Label"
              ?isVisible         t
              ?isSelectable      t
              ?contributesChange t
              ?isDragable        t
              ?isLswValid        t
              ?hyperplot         '(1 -2 1 -1 1 1)
)
(TECHdefLayer ?name "rdl"
              ?purposes '("short")
              ?gdsIInumber '(74 15)
              ?opusLayerNumber 136
              ?packet "met7Short"
              ?isVisible         t
              ?isSelectable      t
              ?contributesChange t
              ?isDragable        t
              ?isLswValid        t
              ?hyperplot         '(1 -2 1 -1 1 1)
)

(TECHdefLayer ?name              "ubm"
        ?purposes          '("drawing")
        ?gdsIInumber       '(127 21)
        ?opusLayerNumber   140
        ?packet            "bpm"
        ?isVisible         t
        ?isSelectable      t
        ?contributesChange t
        ?isDragable        t
        ?isLswValid        t
        ?hyperplot         '(1 -2 7 -1 6 7)
)
(TECHdefLayer ?name              "bump"
        ?purposes          '("drawing")
        ?gdsIInumber       '(127 22)
        ?opusLayerNumber   141
        ?packet            "npm"
        ?isVisible         t
        ?isSelectable      t
        ?contributesChange t
        ?isDragable        t
        ?isLswValid        t
        ?hyperplot         '(1 -2 7 -1 6 7)
)
(TECHdefLayer ?name "cubm"
              ?gdsIInumber '(100 0)
              ?purposes '("mask")
              ?isVisible         t
              ?isSelectable      t
              ?fieldType  "OPAQUE"
              ?scribeLane "OPAQUE"
              ?tpaIgnore t
              ?packet "bpm"
              ?opusLayerNumber 143
              ?hyperplot         '(1 -2 1 0 1 1)
              ?fabAcronym "CUBM"
              )
(TECHdefLayer ?name "cbump"
              ?gdsIInumber '(101 0)
              ?purposes '("mask")
              ?isVisible         t   
              ?isSelectable      t   
              ?fieldType  "OPAQUE"
              ?scribeLane "OPAQUE"
              ?tpaIgnore t
              ?packet "npm"    
              ?opusLayerNumber 144
              ?hyperplot         '(1 -2 1 0 1 1)
              ?fabAcronym "CBUMP"
              )

(TECHdefLayer ?name "rpm"
             ?purposes '("drawing")
             ?gdsIInumber '(86 20)
             ?opusLayerNumber 106
             ?packet "elm"
             ?isVisible         t
             ?isSelectable      t
             ?contributesChange t
             ?isDragable        t
             ?isLswValid        t
             ?hyperplot         '(1 -2 1 0 1 1)
             )
(TECHdefLayer ?name "crpm"
              ?purposes '("drawing")
              )
(TECHdefLayer ?name "crpm"
              ?reticleGrade "C4-248-BIM-LSR-WET"
              ?spotSize 0.020
              ?reticlePriority 11
              ?drawnWidth 1.270 
              ?drawnSpace 0.840  
              ?purposes '("mask")
              ?maskLayerNumber '( ("cypress" "175") ("gsmc" "532") )
              ?foundryLayerName "Resistor Protect"
              ?photoResistTone "POS"
              ?nikonType "DIGITIZED"
              ?fieldType "CLEAR"
              ?scribeLane "CLEAR"
              ?sizing 0.00
              ?opc "N/A"
              ?photoProcess "5500/400"
              ?lbarDrawn    "rpm"
              )
(TECHdefLayer ?name "pmm2"
             ?purposes '("drawing")
             ?gdsIInumber '(77 20)
             ?opusLayerNumber 117
             ?packet "cesdmask"
             ?isVisible         t
             ?isSelectable      t
             ?contributesChange t
             ?isDragable        t
             ?isLswValid        t
             ?hyperplot         '(1 -2 1 0 1 1)
             )
(TECHdefLayer ?name "crpm"
              ?purposes '("drawing")
              )
(TECHdefLayer ?name "ccu1m"
              ?gdsIInumber '(93 0)
              ?purposes '("mask")
                  ?isVisible         t
                  ?isSelectable      t
              ?fieldType "OPAQUE"
              ?scribeLane "OPAQUE"
              ?tpaIgnore t
              ?packet "met7"
              ?opusLayerNumber 142
              ?hyperplot         '(1 -2 1 0 1 1)
              ?fabAcronym "CU1M"
              )
(TECHdefLayer ?name "cpmm2"  
              ?gdsIInumber '(94 0)
              ?purposes '("mask")
              ?isVisible         t
                  ?isSelectable      t
              ?fieldType "OPAQUE"
              ?scribeLane "CLEAR"
              ?tpaIgnore t
              ?packet "cesdmask"
              ?opusLayerNumber 114
              ?hyperplot         '(1 -2 1 0 1 1)
              ?fabAcronym "PMM2"
              )

(TECHdefLayer ?name "hvtr"
        ?purposes '("drawing")
        ?gdsIInumber '(18 20)
        ?opusLayerNumber 113 
        ?packet "hvtr"
        ?isVisible         t
        ?isSelectable      t
        ?contributesChange t
        ?isDragable        t
        ?isLswValid        nil
        ?hyperplot         '(128 -1 2 -1 1 2)
)
(TECHdefLayer ?name "chvtrm"
        ?purposes '("mask")
        ?reticlePriority   7 
        ?fieldType "CLEAR"
        ?scribeLane "CLEAR"
        ?photoResistTone "NEG"
        ?reticleGrade "E4-248-BIM-A37-DRY"
        ?spotSize 0.020
        ?sizing 0.00
        ?drawnWidth        0.38
        ?drawnSpace        0.38
        ?photoProcess "5500/700"
        ?opc "N/A"
)


;;; Additional layer definitions
;;; several fields on this cannot be defined in generic.il
;;; because not all flows use licon/li.
;;; connectsUpTo/connectsDownTo fields are used by placeBus

(TECHdefLayer ?name "nwell"
              ?purposes '("drawing")
              ?connectsUpTo '("tap")
)
(TECHdefLayer ?name "licon1"
              ?purposes '("drawing")
              ?connectsDownTo '("poly" "diff" "tap")
              ?connectsUpTo '("li1")
              ?aliases '("cl1") ;;; connecting layer1
)
(TECHdefLayer ?name "li1"
              ?purposes '("drawing")
              ?aliases '("rl1") ;;; routing layer 1
)
(TECHdefLayer ?name "mcon"
              ?purposes '("drawing")
              ?connectsDownTo '("li1")
              ?connectsUpTo '("met1")
              ?aliases '("cl2") ;;; connecting layer2
)
(TECHdefLayer ?name "met1"
              ?purposes '("drawing")
              ?aliases '("rl2") ;;; routing layer 2
)
(TECHdefLayer ?name "via"
              ?purposes '("drawing")
              ?connectsDownTo '("met1")
              ?connectsUpTo '("met2")
              ?aliases '("cl3") ;;; connecting layer 3
)
(TECHdefLayer ?name "met2"
              ?purposes '("drawing")
              ?aliases '("rl3") ;;; routing layer 3
)
(TECHdefLayer ?name "via2"
              ?purposes '("drawing")
              ?connectsDownTo '("met2")
              ?connectsUpTo '("met3")
              ?aliases '("cl4") ;;; connecting layer 4
)
(TECHdefLayer ?name "met3"
              ?purposes '("drawing")
              ?aliases '("rl4") ;;; routing layer 4
)
(TECHdefLayer ?name "via3"
              ?purposes '("drawing")
              ?connectsDownTo '("met3")
              ?connectsUpTo '("met4")
              ?aliases '("cl5") ;;; connecting layer 4
)
(TECHdefLayer ?name "met4"
              ?purposes '("drawing")
              ?aliases '("rl5") ;;; routing layer 4
)
(TECHdefLayer ?name "via4"
              ?purposes '("drawing")
              ?connectsDownTo '("met4")
              ?connectsUpTo '("met5")
              ?aliases '("cl6") ;;; connecting layer 5
)
(TECHdefLayer ?name "met5"
              ?purposes '("drawing")
              ?aliases '("rl6") ;;; routing layer 5
)
(TECHdefLayer ?name "pad"
        ?purposes '("drawing")
        ?connectsDownTo '("met5")
        ?connectsUpTo '("rdl")
        ?mwtfLayer  "pad"
        ?mwtfNumber '(37 0)
        ?aliases '("cl7") ;;; connecting layer 6
)
(TECHdefLayer ?name "rdl"
              ?purposes '("drawing")
              ?aliases '("rl7")
)

(TECHdefLayer ?name "rdl"
              ?purposes '("option1" "option2" "option3" "option4" 
                          "option5" "option6" "option7" "option8" "short")
              ?isLswValid        nil
              )

;; -Manual override for vhvi MW layer
(TECHdefLayer ?name "vhvi"
              ?purposes '("drawing")
              ?mwtfLayer "vhvi"
              ?mwtfNumber '(75 44)
)

;; keep unused or not allowed purposes from appearing in lsw by default.
;; (still visible, and can be turned on manually)
;; this includes the c* drawing purpose for non-cl compatible layers,
;; metops on non-top layers, add/drop purposes for non-add/drop layers

(TECHdefLayer ?name "diff"
              ?purposes '("pin" "label" "net" "boundary")
              ?isLswValid        nil
              )
(TECHdefLayer ?name "tap"
              ?purposes '("pin" "label" "net" "boundary")
              ?isLswValid        nil
              )
(TECHdefLayer ?name "li1"
              ?purposes '("res" "cut")
              ?isLswValid        nil
              )
(TECHdefLayer ?name "met1"
              ?purposes '("option1" "option2" "option3" "option4"
                          "option5" "option6" "option7" "option8"
                          "fuse" "res" "cut")
              ?isLswValid        nil
              )
(TECHdefLayer ?name "met2"
              ?purposes '("option1" "option2" "option3" "option4"
                          "option5" "option6" "option7" "option8"
                          "fuse" "res" "cut")
              ?isLswValid        nil
              )
(TECHdefLayer ?name "met3"
              ?purposes '("option1" "option2" "option3" "option4"
                          "option5" "option6" "option7" "option8"
                          "fuse" "res" "cut")
              ?isLswValid        nil
              )
(TECHdefLayer ?name "met4"
              ?purposes '("option1" "option2" "option3" "option4"
                          "option5" "option6" "option7" "option8"
                          "fuse" "res" "cut")
              ?isLswValid        nil
              )
(TECHdefLayer ?name "met5"
              ?purposes '("option1" "option2" "option3" "option4"
                          "option5" "option6" "option7" "option8"
                          "fuse" "res" "cut")
              ?isLswValid        nil
              )

(TECHdefLayer ?name "cnwm"
              ?purposes '("drawing" "maskAdd" "maskDrop")
              ?isLswValid        nil
              )
(TECHdefLayer ?name "cntm"
              ?purposes '("maskAdd" "maskDrop")
              ?isLswValid        nil
)
(TECHdefLayer ?name "cnpc"
              ?purposes '("maskAdd" "maskDrop")
              ?isLswValid        nil
)
(TECHdefLayer ?name "clvtnm"
              ?purposes '("drawing" "maskAdd" "maskDrop")
              ?isLswValid        nil
)
(TECHdefLayer ?name "chvtpm"
              ?purposes '("drawing" "maskAdd" "maskDrop")
              ?isLswValid        nil
)
(TECHdefLayer ?name "chvtrm"
              ?purposes '("drawing" "mask" "maskAdd" "maskDrop")
              ?isLswValid        nil
)
(TECHdefLayer ?name "cldntm"
              ?purposes '("drawing")
              ?isLswValid        nil
              )
(TECHdefLayer ?name "cnpc"
              ?purposes '("maskAdd" "maskDrop")
              ?isLswValid        nil
              )
(TECHdefLayer ?name "clvom"
              ?purposes '("maskAdd" "maskDrop")
              ?isLswValid        nil
              )
(TECHdefLayer ?name "chvntm"
              ?purposes '("maskAdd" "maskDrop")
              ?isLswValid        nil
              )
(TECHdefLayer ?name "cp1m"
              ?purposes '("drawing")
              ?isLswValid        nil
              )
(TECHdefLayer ?name "clicm1"
              ?purposes '("drawing")
              ?isLswValid        nil
              )
(TECHdefLayer ?name "cli1m"
              ?purposes '("drawing")
              ?isLswValid        nil
              )
(TECHdefLayer ?name "cctm1"
              ?purposes '("drawing" "maskAdd" "maskDrop")
              ?isLswValid        nil
              )
(TECHdefLayer ?name "cmm1"
              ?purposes '("drawing" "maskAdd" "maskDrop")
              ?isLswValid        nil
              )
(TECHdefLayer ?name "cviam"
              ?purposes '("drawing" "maskAdd" "maskDrop")
              ?isLswValid        nil
              )
(TECHdefLayer ?name "cmm2"
              ?purposes '("drawing" "maskAdd" "maskDrop")
              ?isLswValid        nil
              )
(TECHdefLayer ?name "cviam2"
              ?purposes '("drawing" "maskAdd" "maskDrop")
              ?isLswValid        nil
              )
(TECHdefLayer ?name "cmm3"
              ?purposes '("drawing" "maskAdd" "maskDrop")
              ?isLswValid        nil
              )
(TECHdefLayer ?name "cviam3"
              ?purposes '("drawing" "maskAdd" "maskDrop")
              ?isLswValid        nil
              )
(TECHdefLayer ?name "cviam4"
              ?purposes '("drawing" "maskAdd" "maskDrop")
              ?isLswValid        nil
              )

(TECHdefLayer ?name "cpdm"
              ?purposes '("drawing" "maskAdd" "maskDrop")
              ?isLswValid        nil
              )

;;  Define prune layer for LVS filtering flow
(TECHdefLayer ?name              "prune"
              ?purposes          '("drawing")
              ?gdsIInumber       '(84 44)
              ?opusLayerNumber   21
              ?packet            "prunedg"
              ?isVisible         t
              ?isSelectable      t
              ?contributesChange t
              ?isDragable        t
              ?isLswValid        t
              ?hyperplot         '(1 -2 7 -1 6 7)
)

(TECHdefLayer ?name              "nwell"
              ?purposes          '("net")
              ?gdsIInumber       '(84 23)
              ?opusLayerNumber   0
              ?packet            "hilite1"
              ?isVisible         t
              ?isSelectable      t
              ?contributesChange t
              ?isDragable        t
              ?isLswValid        t
              ?hyperplot         '(1 -2 7 -1 6 7)
)

(TECHdefLayer ?name "npn"
              ?purposes '("drawing")
              ?gdsIInumber '(82 20)
              ?opusLayerNumber 111
              ?packet "npn"
              ?isVisible         t
              ?isSelectable      t
              ?contributesChange t
              ?isDragable        t
              ?isLswValid        t
              ?hyperplot         '(1 -2 1 0 1 1)
)
(TECHdefLayer ?name "npn"
              ?purposes '("label")
              ?gdsIInumber '(82 5)
              ?opusLayerNumber 111
              ?packet "npnlabel"
              ?isVisible         t
              ?isSelectable      t
              ?contributesChange t
              ?isDragable        t
              ?isLswValid        t
              ?hyperplot         '(1 -1 1 -1 1 1)
)
(TECHdefLayer ?name "prBoundary"
            ?purposes '("boundary")
            ?gdsIInumber '(235 4)
            ?opusLayerNumber 235
            ?packet "prbdg"
            ?isVisible         t
            ?isSelectable      t
            ?contributesChange t
            ?isDragable        t
            ?isLswValid        t
            ?hyperplot         '(4 -2 4 -1 6 4)
)
(TECHdefLayer ?name "areaid"
              ?purposes '("rdlprobepad")
              ?gdsIInumber '(81 27)
              ?opusLayerNumber 110
              ?packet "areaidprobe"
              ?isVisible         t
              ?isSelectable      t
              ?contributesChange t
              ?isDragable        t
              ?isLswValid        t
              ?hyperplot         '(6 -2 6 -1 6 5)
)

(TECHvalidateLayers '("prBoundary" "boundary")
                    '("pwell"  "drawing")
                    '("pwell"  "pin")
                    '("pwell"  "label")
                    '("pwell"  "res")
                    '("pwell"  "cut")
                    '("pwelliso"  "pin")
                    '("pwelliso"  "label")
                    '("nwell"  "drawing")
                    '("nwell"  "net")
                    '("nwell"  "pin")
                    '("nwell"  "label")
                    '("dnwell" "drawing")
                    '("vhvi"   "drawing")
                    '("diff"   "drawing")
                    '("diff"   "res")
                    '("diff"   "cut")
                    '("diff"   "pin")
                    '("diff"   "label")
                    '("diff"   "net")
                    '("diff"   "boundary")
                    '("diff"   "hv")
                    '("tap"    "drawing")
                    '("tap"    "pin")
                    '("tap"    "net")
                    '("tap"    "boundary")
                    '("tap"    "label")
                    '("psdm"   "drawing")
                    '("nsdm"   "drawing")
                    '("poly"   "drawing")
                    '("poly"   "pin")
                    '("poly"   "res")
                    '("poly"   "cut")
                    '("poly"   "gate")
                    '("poly"   "label")
                    '("poly"   "boundary")
                    '("poly"   "probe")
                    '("poly"   "short") 
                    '("poly"   "net")   
                    '("poly"   "model")          
                    '("ldntm"  "drawing")
                    '("lvtn"   "drawing")
                    '("hvtp"   "drawing")
                    '("hvtr"   "drawing")
                    '("tunm"   "drawing")
                    '("licon1" "drawing")
                    '("licon1" "boundary")
                    '("licon1" "pin")
                    '("licon1" "net")
                    '("npc"    "drawing")
                    '("li1"    "drawing")
                    '("li1"    "pin")
                    '("li1"    "res")
                    '("li1"    "cut")
                    '("li1"    "label")
                    '("li1"    "net")
                    '("li1"    "boundary")
                    '("li1"    "blockage")
                    '("li1"    "short")
                    '("li1"    "probe")
                    '("mcon"   "drawing")
                    '("mcon"   "boundary")
                    '("mcon"   "pin")
                    '("mcon"   "net")
                    '("met1"   "drawing")
                    '("met1"   "res")
                    '("met1"   "cut")
                    '("met1"   "pin")
                    '("met1"   "label")
                    '("met1"   "net")
                    '("met1"   "boundary")
                    '("met1"   "blockage")
                    '("met1"   "short")
                    '("met1"   "probe")
                    '("met1"   "option1")
                    '("met1"   "option2")
                    '("met1"   "option3")
                    '("met1"   "option4")
                    '("met1"   "option5")
                    '("met1"   "option6")
                    '("met1"   "option7")
                    '("met1"   "option8")
                    '("via"    "drawing")
                    '("via"    "boundary")
                    '("via"    "net")
                    '("via"    "pin")
                    '("met2"   "drawing")
                    '("met2"   "res")
                    '("met2"   "cut")
                    '("met2"   "pin")
                    '("met2"   "label")
                    '("met2"   "net")
                    '("met2"   "boundary")
                    '("met2"   "blockage")
                    '("met2"   "short")
                    '("met2"   "probe")
                    '("met2"   "option1")
                    '("met2"   "option2")
                    '("met2"   "option3")
                    '("met2"   "option4")
                    '("met2"   "option5")
                    '("met2"   "option6")
                    '("met2"   "option7")
                    '("met2"   "option8")
                    '("via2"   "drawing")
                    '("via2"   "boundary")
                    '("via2"   "pin")
                    '("via2"   "net")
                    '("met3"   "drawing")
                    '("met3"   "res")
                    '("met3"   "cut")
                    '("met3"   "pin")
                    '("met3"   "label")
                    '("met3"   "net")
                    '("met3"   "boundary")
                    '("met3"   "blockage")
                    '("met3"   "short")
                    '("met3"   "fuse")
                    '("met3"   "probe")
                    '("met3"   "option1")
                    '("met3"   "option2")
                    '("met3"   "option3")
                    '("met3"   "option4")
                    '("met3"   "option5")
                    '("met3"   "option6")
                    '("met3"   "option7")
                    '("met3"   "option8")
                    '("via3"   "drawing")
                    '("via3"   "boundary")
                    '("via3"   "pin")
                    '("via3"   "net")
                    '("met4"   "drawing")
                    '("met4"   "res")
                    '("met4"   "cut")
                    '("met4"   "pin")
                    '("met4"   "label")
                    '("met4"   "net")
                    '("met4"   "boundary")
                    '("met4"   "blockage")
                    '("met4"   "short")
                    '("met4"   "fuse")
                    '("met4"   "probe")
                    '("met4"   "option1")
                    '("met4"   "option2")
                    '("met4"   "option3")
                    '("met4"   "option4")
                    '("met4"   "option5")
                    '("met4"   "option6")
                    '("met4"   "option7")
                    '("met4"   "option8")
                    '("via4"   "drawing")
                    '("via4"   "boundary")
                    '("via4"   "pin")
                    '("via4"   "net")
                    '("met5"   "drawing")
                    '("met5"   "res")
                    '("met5"   "cut")
                    '("met5"   "pin")
                    '("met5"   "label")
                    '("met5"   "net")
                    '("met5"   "boundary")
                    '("met5"   "blockage")
                    '("met5"   "short")
                    '("met5"   "fuse")
                    '("met5"   "probe")
                    '("met5"   "option1")
                    '("met5"   "option2")
                    '("met5"   "option3")
                    '("met5"   "option4")
                    '("met5"   "option5")
                    '("met5"   "option6")
                    '("met5"   "option7")
                    '("met5"   "option8")
                    '("nsm"    "drawing") 
                    '("pad"    "drawing") 
                    '("pad"    "label")
                    '("pad"    "pin")
                    '("pnp"    "drawing")
                    '("pnp"    "label")
                    '("npn"    "drawing")
                    '("npn"    "label")
                    '("rpm"    "drawing")
                    '("hvi"    "drawing")
                    '("capacitor"    "drawing")
                    '("ncm"    "drawing")
                    '("cncm"   "drawing")
                    '("cncm"   "mask")
                    '("pmm"    "drawing")
                    '("pmm2"   "drawing")
                    '("rdl"    "drawing")
                    '("rdl"    "pin")
                    '("rdl"    "label")
                    '("rdl"    "res")
                    '("rdl"    "cut")
                    '("rdl"    "short")
                    '("rdl"    "option1")
                    '("rdl"    "option2")
                    '("rdl"    "option3")
                    '("rdl"    "option4")
                    '("rdl"    "option5")
                    '("rdl"    "option6")
                    '("rdl"    "option7")
                    '("rdl"    "option8")
                    '("ubm"    "drawing")
                    '("bump"   "drawing")
                    '("inductor"   "drawing")
                    '("inductor"   "label")
                    '("inductor"   "term1")
                    '("inductor"   "term2")
                    '("inductor"   "term3")
                    '("cfom"   "drawing")
                    '("cfom"   "mask")
                    '("cfom"   "maskAdd")
                    '("cfom"   "maskDrop")  
                    '("cfom"   "waffleDrop")
                    '("fom"    "dummy")
                    '("cnwm"   "drawing")
                    '("cnwm"   "mask")
                    '("cnwm"   "maskAdd")
                    '("cnwm"   "maskDrop")
                    '("cdnm"  "drawing")
                    '("cdnm"  "mask")
                    '("cdnm"  "maskAdd")
                    '("cdnm"  "maskDrop")
                    '("clvtnm" "drawing")
                    '("clvtnm" "mask")
                    '("clvtnm" "maskAdd")
                    '("clvtnm" "maskDrop")
                    '("chvtpm" "drawing")
                    '("chvtpm" "mask")
                    '("chvtpm" "maskAdd")
                    '("chvtpm" "maskDrop")
                    '("chvtrm" "drawing")
                    '("chvtrm" "mask")
                    '("chvtrm" "maskAdd")
                    '("chvtrm" "maskDrop")
                    '("ctunm"  "drawing")
                    '("ctunm"  "mask")
                    '("ctunm"  "maskAdd")
                    '("ctunm"  "maskDrop")
                    '("conom"  "drawing")
                    '("conom"  "mask")
                    '("conom"  "maskAdd")
                    '("conom"  "maskDrop")
                    '("cnsdm"  "drawing")
                    '("cnsdm"  "mask")
                    '("cnsdm"  "maskAdd")
                    '("cnsdm"  "maskDrop")
                    '("cpsdm"  "drawing")
                    '("cpsdm"  "mask")
                    '("cpsdm"  "maskAdd")
                    '("cpsdm"  "maskDrop")
                    '("cntm"   "drawing")
                    '("cntm"   "mask")
                    '("cntm"   "maskAdd")
                    '("cntm"   "maskDrop")
                    '("hvntm"  "drawing")
                    '("chvntm" "drawing")
                    '("chvntm" "mask")
                    '("chvntm" "maskAdd")
                    '("chvntm" "maskDrop")
                    '("cldntm" "drawing")
                    '("cldntm" "mask")
                    '("clvom"  "drawing")
                    '("clvom"  "mask")
                    '("clvom"  "maskAdd")
                    '("clvom"  "maskDrop")
                    '("cp1m"   "drawing")
                    '("cp1m"   "mask")
                    '("cp1m"   "maskAdd")
                    '("cp1m"   "waffleDrop")
                    '("cp1m"   "maskDrop")  
                    '("cli1m"  "drawing")
                    '("cli1m"  "mask")
                    '("cli1m"  "maskAdd")
                    '("cli1m"  "maskDrop")
                    '("clicm1" "drawing")
                    '("clicm1" "mask")
                    '("clicm1" "maskAdd")
                    '("clicm1" "maskDrop")
                    '("cmm1"   "drawing")
                    '("cmm1"   "mask")
                    '("cmm1"   "maskAdd")
                    '("cmm1"   "maskDrop")
                    '("cmm1"   "waffleDrop")
                    '("cviam"  "drawing")
                    '("cviam"  "mask")
                    '("cviam"  "maskAdd")
                    '("cviam"  "maskDrop")
                    '("cmm2"   "drawing")
                    '("cmm2"   "mask")
                    '("cmm2"   "maskAdd")
                    '("cmm2"   "maskDrop")
                    '("cmm2"   "waffleDrop")
                    '("cviam2" "drawing")
                    '("cviam2" "mask")
                    '("cviam2" "maskAdd")
                    '("cviam2" "maskDrop")
                    '("cmm3"   "drawing")
                    '("cmm3"   "mask")
                    '("cmm3"   "maskAdd")
                    '("cmm3"   "maskDrop")
                    '("cmm3"   "waffleDrop")
                    '("cnpc"   "drawing")
                    '("cnpc"   "mask")
                    '("cnpc"   "maskAdd")
                    '("cnpc"   "maskDrop")
                    '("cviam3" "drawing")
                    '("cviam3" "mask")
                    '("cviam3" "maskAdd")
                    '("cviam3" "maskDrop")
                    '("cnsm"   "mask")
                    '("cpdm"   "drawing")
                    '("cpdm"   "mask")
                    '("cpdm"   "maskAdd")
                    '("cpdm"   "maskDrop")
                    '("cpmm"   "drawing")
                    '("cpbo"   "mask")
                    '("cmm4"  "mask")
                    '("cmm4"   "maskAdd")
                    '("cmm4"   "maskDrop")
                    '("cmm4"   "waffleDrop")
                    '("cviam4" "drawing")
                    '("cviam4" "mask")
                    '("cviam4" "maskAdd")
                    '("cviam4" "maskDrop")
                    '("cmm5"  "mask")
                    '("cmm5"   "waffleDrop")
                    '("target" "drawing")
                    '("cctm1"  "drawing")
                    '("cctm1"  "mask")
                    '("cctm1"  "maskAdd")
                    '("cctm1"  "maskDrop")
                    '("crpm"       "drawing")
                    '("crpm"       "mask")
                    '("crpm"       "maskAdd")
                    '("crpm"       "maskDrop")
                    '("ccu1m"   "mask")
                    '("cpmm2"  "mask")
                    '("cubm"   "mask")
                    '("cbump"  "mask")
                    '("overlap" "drawing")
                    '("overlap" "boundary")
                    '("areaid" "lowTapDensity")
                    '("areaid" "notCritSide")
                    '("areaid" "injection")
                    '("areaid" "rfdiode")
                    '("areaid" "seal")
                    '("areaid" "core")
                    '("areaid" "frame")
                    '("areaid" "esd")
                    '("areaid" "dieCut")
                    '("areaid" "moduleCut")
                    '("areaid" "frameRect")
                    '("areaid" "substrateCut")
                    '("areaid" "diode")
                    '("areaid" "standardc")
                    '("areaid" "deadZon")
                    '("areaid" "critCorner")
                    '("areaid" "critSid")
                    '("areaid" "opcDrop")
                    '("areaid" "waffleWindow")
                    '("areaid" "extendedDrain")
                    '("areaid" "lvNative")
                    '("areaid" "photo")
                    '("areaid" "etest")
                    '("areaid" "hvnwell")
                    '("areaid" "rdlprobepad")
		    '("areaid" "sigPadDiff")
		    '("areaid" "sigPadWell")
		    '("areaid" "sigPadMetNtr")
                    '("areaid" "analog")
                    '("text"   "drawing")
                    '("marker" "error")
                    '("marker" "warning")
                    '("prune"   "drawing")
                    '("padCenter" "drawing")
                    '("met1"   "psa1")
                    '("met2"   "psa1")
                    '("met3"   "psa1")
                    '("met4"   "psa1")
                    '("met5"   "psa1")
                    '("met1"   "psa2")
                    '("met2"   "psa2")
                    '("met3"   "psa2")
                    '("met4"   "psa2")
                    '("met5"   "psa2")
                    '("met1"   "psa3")
                    '("met2"   "psa3")
                    '("met3"   "psa3")
                    '("met4"   "psa3")
                    '("met5"   "psa3")
                    '("met1"   "psa4")
                    '("met2"   "psa4")
                    '("met3"   "psa4")
                    '("met4"   "psa4")
                    '("met5"   "psa4")
                    '("met1"   "psa5")
                    '("met2"   "psa5")
                    '("met3"   "psa5")
                    '("met4"   "psa5")
                    '("met5"   "psa5")
                    '("met1"   "psa6")
                    '("met2"   "psa6")
                    '("met3"   "psa6")
                    '("met4"   "psa6")
                    '("met5"   "psa6")
                    '("rdl"   "psa1")
                    '("rdl"   "psa2")
                    '("rdl"   "psa3")
                    '("rdl"   "psa4")
                    '("rdl"   "psa5")
                    '("rdl"   "psa6")
                    '("blanking"   "drawing")
)

;;; Flow dependent DRC rules
(TECHsetRules
 '(
   ;;met2 rules
   ("m2_6"                0.0676 "minArea"       "met2"   )
   )
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; s8shrink rules 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(TECHsetRules
 '(
   ("licon_8"             0.050)
   ("licon_8a"            0.080 "minEnclosure" "poly" "licon1") ;;pcell fix
   ("difftap_2b"          0.360)
   ("nsd_5a"              0.125)
   ("nsd_5b"              0.125)
   ("psd_5a"              0.125)
   ("psd_5b"              0.125)
   ("licon_11b"           0.050)
   ("tunm_3"              0.095)
   ("tunm_4"              0.095)
   ("m1_4a"               0.005)
   ("licon_11c"           0.040)
   ("licon_11d"           0.045)
   ("licon_11c_x"         0.500)
   ("licon_11d_x"         0.150)
   )
 )

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; hvtr rules hvtr.-
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (TECHsetRules
   '(
      ("hvtr_1"            0.380 "minWidth"     "hvtr")
      ("hvtr_2"            0.380 "minSpacing"   "hvtr")
      ("hvtr_3"            0.180) 
    )
  )

  (TECHsetRules
   '(
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;; via2 rules via2.-
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

     ("via2_1a"              0.200   "minWidth"     "via2")
     ("via2_2"               0.200   "minSpacing"   "via2")
     ("via2_3"               0.200)
     ("via2_4"               0.040   "minEnclosure" "met2"   "via2")
     ("via2_4a"              0.140)
     ("via2_5"               0.085   "minEnclosureAdj" "met2" "via2")
     ("via2_1b_vsmall"       0.200);technically via2_1d
     ("via2_1b_small"        0.280)
     ("via2_1b_med"          1.2)
     ("via2_1b_big"          1.5)
     ("via2_1c_med"          1.2)
     ("via2_1c_big"          1.5)
     )
   )

  (TECHsetRules
   '(
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;; met3 rules m3.-
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

     ("m3_1"                0.300  "minWidth"     "met3")
     ("m3_2"                0.300  "minSpacing"   "met3")
     ("m3_3a"               0.400)
     ("m3_3b"               0.400)
     ("m3_3c"               0.400)
     ("m3_3d"               0.400  "hugeSpacing"  "met3")
     ("m3_3_x"              3.000  "hugeWidth"    "met3") ;;; huge metal def
     ("m3_4"                0.065  "minEnclosure" "met3"  "via2")  ;; peri
     ("m3_6"                0.240  "minArea"      "met3") 
     )
   )
  (TECHsetRules
   '(
       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;; via3 rules via3.-
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

     ("via3_1"               0.200   "minWidth"     "via3")
     ("via3_1a"              0.800)
     ("via3_2"               0.200   "minSpacing"   "via3")
     ("via3_3"               0.200)
     ("via3_4"               0.060   "minEnclosure" "met3"   "via3")
     ("via3_5"               0.090   "minEnclosureAdj" "met3" "via3")
     )
   )

  (TECHsetRules
   '(
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;; met4 rules m4.-
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

     ("m4_1"                0.300  "minWidth"     "met4")
     ("m4_2"                0.300  "minSpacing"   "met4")
     ("m4_3"                0.065  "minEnclosure" "met4"  "via3")  ;; peri
     ("m4_4a"               0.240  "minArea"      "met4")
     ("m4_5a"               0.400)
     ("m4_5b"               0.400  "hugeSpacing"  "met4")
     ("m4_5_x"              3.000  "hugeWidth"    "met4") ;;; huge metal def
     )
   )

  (TECHsetRules
   '(
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;; via4 rules via4.-
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ("via4_1"               0.800   "minWidth"     "via4")
     ("via4_2"               0.800   "minSpacing"   "via4")
     ("via4_3"               0.800)
     ("via4_4"               0.190   "minEnclosure" "met4"   "via4")
     )
   )

  (TECHsetRules
   '(
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;; met5 rules indm.- (met5)
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

     ("m5_1"                1.600   "minWidth"     "met5")
     ("m5_2"                1.600   "minSpacing"   "met5")
     ("m5_3"                0.310   "minEnclosure" "met5"  "via4")
     ("m5_4"                4.000)
     
   )
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; FUSE rules mf.-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (TECHsetRules
   '(
     ("mf_1"                0.800  "minWidth"     ("met4"  "fuse"))
     ("mf_2"                7.200  "minLength"    ("met4"  "fuse"))
     ("mf_3"                2.760)
     ("mf_4"                3.300)
     ("mf_5"                0.830)
     ("mf_6"                3.300)
     ("mf_7"                3.300)
     ("mf_8"                2.660)
     ("mf_9"                2.640)
     ("mf_10"               3.250)
     ("mf_11"               3.320)
     ("mf_12_w"             0.5   "shieldWidth"   ("met4" "fuse"))
     ("mf_12_l"             2.4   "shieldLength"  ("met4" "fuse"))
     ("mf_13"               2.2)
     ("mf_14"               3.3)
     ; mf_15 no value
     ("mf_16"               4.0)
     ; mf_17 NC
     ("mf_18"               0.600)
     ("mf_19"               3.300)
;     ("mf_20"               3.300)
     ("mf_22"               1.960)
     ("mf_24"               3.3)
     ;("mf_21" no value
     ("centerwidth"         0.010)
  ))


(TECHsetRules
   '(
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;; Cpdm rules cpdm.-
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ("cpdm_4"                 0.000)
    )
)

(TECHsetRules
   '(
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; CVIM2 rules cvim.-
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ("cvim2_size_c"             -0.05)
     ("cvim2_size_d"             -0.10)
     ("cvim2_3e_x"                0.28)
     ("cvim2_3e"                 -0.04)
     ("cvim2_3f_x"                0.20)
     ("cvim2_3f"                  0.02)

   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; CVIM3 rules cvim.-
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ("cvim3_3"                   0.020)
     ("cvim3_3a_sz"               0.100)
  )
)

(TECHsetRules
 '(
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; CMM3 rules cmm3.-
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   ("cmm3_x_3"               1.150)
   ("cmm3_3"                 0.010)
   ("cmm3_pd_1"              0.300 "mm3_window_700_step_70")
   ("cmm3_pd_1b"             0.80) 
   ("cmm3_pd_1c"             0.70) 
   ("cmm3_pd_2a"           700.00)
   ("cmm3_pd_2b"            70.00)
   ("cmm3_waffle_size_1"     2.00)
   ("cmm3_waffle_space_1"    0.30)
   ("cmm3_waffle_effort_1"   1.00)
   ("cmm3_waffle_spaceKO_1"  3.00)
   ("cmm3_waffle_spaceSH_1"  0.30)
   ("cmm3_waffle_size_2"     1.00)
   ("cmm3_waffle_space_2"    0.30)
   ("cmm3_waffle_effort_2"   1.00)
   ("cmm3_waffle_spaceKO_2"  3.00)
   ("cmm3_waffle_spaceSH_2"  0.30)
   ("cmm3_waffle_size_3"     0.58)
   ("cmm3_waffle_space_3"    0.30)
   ("cmm3_waffle_effort_3"   1.00)
   ("cmm3_waffle_spaceKO_3"  0.50)
   ("cmm3_waffle_spaceSH_3"  0.30)
   ("cmm3_waffle_size_4"     0.40)
   ("cmm3_waffle_space_4"    0.30)
   ("cmm3_waffle_effort_4"   1.00)
   ("cmm3_waffle_spaceKO_4"  0.30)
   ("cmm3_frame_1"           0.550)
   ("cmm3_frame_2a"        100.000)
   ("cmm3_frame_2b"         10.000)
   )
 )
(TECHsetRules
 '(
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; CMM4 rules cmm4.-
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   ("cmm4_x_3"               1.150)
   ("cmm4_3"                 0.010)
   ("cmm4_pd_1"              0.300 "mm4_window_700_step_70")
   ("cmm4_pd_1b"             0.80) 
   ("cmm4_pd_1c"             0.70) 
   ("cmm4_pd_2a"           700.00)
   ("cmm4_pd_2b"            70.00)
   ("cmm4_waffle_size_1"     2.00)
   ("cmm4_waffle_space_1"    0.30)
   ("cmm4_waffle_effort_1"   1.00)
   ("cmm4_waffle_spaceKO_1"  3.00)
   ("cmm4_waffle_spaceSH_1"  0.30)
   ("cmm4_waffle_size_2"     1.00)
   ("cmm4_waffle_space_2"    0.30)
   ("cmm4_waffle_effort_2"   1.00)
   ("cmm4_waffle_spaceKO_2"  3.00)
   ("cmm4_waffle_spaceSH_2"  0.30)
   ("cmm4_waffle_size_3"     0.58)
   ("cmm4_waffle_space_3"    0.30)
   ("cmm4_waffle_effort_3"   1.00)
   ("cmm4_waffle_spaceKO_3"  0.50)
   ("cmm4_waffle_spaceSH_3"  0.30)
   ("cmm4_waffle_size_4"     0.40)
   ("cmm4_waffle_space_4"    0.30)
   ("cmm4_waffle_effort_4"   1.00)
   ("cmm4_waffle_spaceKO_4"  0.30)
   ("cmm4_frame_1"           0.550)
   ("cmm4_frame_2a"        100.000)
   ("cmm4_frame_2b"         10.000)
   )
 )

(TECHsetRules
 '(
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; CMM5 rules cmm5.-
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ("cmm5_3"               0.015)
   )
 )
(TECHsetRules
 '(
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; SEALID rule for s8phirs (Rule X.28)
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ("X_28"               6.00)
   )
 ) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Nikon rules
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; derivation/use of nikon values - see below seal ring table
;; featureSize        - source : given in tdr as arm width.
;;                    - use    : nikon pcell.  width of one of the cross arms (legWidth)
;; reverseFeatureSize - source : calc from tdr
;;                                   ( total width - cross width) / 2
;;                    - use    : nikon pcell, distance from end of cross arm 
;;                               to outer edge of reverse feature (width)
;; totalWidth         - source : given in tdr as total width
;;                    - use    : for calculating legLength for nikon pcell
;;                               totalWidth is the total width from outer edges of 
;;                               reverse layers of nikon pcell
;; cutOffset          - source : calc from TDR
;;                                   totalWidth * ( 1 - 0.5 sqr (2) )
;;                    - use    : determine the size of a diagonal corner triangle cut off used to 
;;                               make the eight sided poligon shape of reversed masks
;; offsetRsa          - source : calc from tdr
;;                                   center offset - (total width / 2)
;;                    - use    : determines enclosure of reversed layers by SEALID/pad mask 
;;                               at outside of die seal ring pcell
;; offsetLayers       - source : given in TDR as cross width of special layers
;;                                   '((("layer1") crossWidth1)
;;                                     (("layer2") crossWidth2)
;;                                    )
;;                    - use    : sets the width of a feature for a given layer
;;                               (featureSize parameter is ignored)
;;
;; nikon rules are also used to exclude the nikon cross from mask drc checks (at cad option)

(TECHdefNikonRules    ?featureSize         0.5
                      ?reverseFeatureSize  0.8
                      ?totalWidth          4.0
                      ?cutOffset           1.17
                      ?offsetRsa           1.0          
                      ?digitized           t          
                      ?reversed            nil
;                      ?offsetLayers        '((("cpmm") 2.200))
)


(TECHsetRules
 '(
   ("cviam2_nikon_1"  digitized)
   ("cmm3_nikon_1"    digitized)
   ("cviam3_nikon_1"  digitized)
   ("cmm4_nikon_1"    digitized)
   ("cviam4_nikon_1"  digitized)
   ("cmm5_nikon_1"    digitized)
   ("crpm_nikon_1"    digitized)
   ("chvtrm_nikon_1"  digitized)
   ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Define variables for Stress rules
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(TECHsetRules
 '(("num_met"       5)
   ("num_via"       4)
))
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ESD and LU rules from mtdr auto updates
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(TECHsetRules
 '(
   ("lu4_8_via3_space"             2.00)
   ("lu4_8_via4_space"             2.00)
   ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Updates
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(TECHsetRules
 '(
   
   ("rdl_1"             10.00   "minWidth"   "rdl") 
   ("rdl_2"             10.00   "minSpacing" "rdl") 
   ("rdl_3"             10.75   "minEnclosure" "rdl"   "pad")  
   ("rdl_4"             15.00   )
   ("rdl_6"             19.66   )
   ("cupad_1"             5.00 "minWidth"   "pad")
   ("cupad_2"             0.00)
   ("cupad_3"             2.70)
   ("cupad_4"             10.75)

   ("ccu1m_3"             0.35)
   ("ccu1m_4"             0.45)
   ("ccu1m_5"             6.75)

   ("cpmm2_1"             20.00)
   ("cpmm2_2"             20.00)
   ("cpmm2_3"             12.50)
   ("cpmm2_4"              6.16)
   ("cpmm2_5"             12.50)
   ("cpmm2_6"              6.16)
   ("cpmm2_7"              0.00)
   ("cpmm2_8"              0.00)

   ("res7"        0.50)
   ("res8"        1.18)
   ))
(TECHsetRules
   '(
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; RPM rules
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ("rpm_1a"                 1.270)
   ("rpm_1b"                 0.350)
   ("rpm_1c"                 0.690)
   ("rpm_1d"                 1.410)
   ("rpm_1e"                 2.850)
   ("rpm_1f"                 5.730)
   ("rpm_1g"                 1)
   ("rpm_1h"                 1)
   ("rpm_1i"                 2)
   ("rpm_1j"                 4)
   ("rpm_1k"                 8)
   ("rpm_2"                  0.840) 
   ("rpm_3"                  0.200)
   ("rpm_4"                  0.110)
   ("rpm_5"                  0.095)
   ("rpm_6"                  0.200)
   ("rpm_7"                  0.200)
   ;("rpm_8"             no number)
   ("rpm_9"                  0.185)
  )
)

(TECHsetRules
   '(
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; diff size rules these values are calculated using tab H5 of the TDR
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ("diff_0_42"          0.42)
  ("diff_0_84"          0.84)
  ("diff_1_11"          1.11)
  ("diff_1_14"          1.14)
  ("diff_1_68"          1.68)
  ("diff_1_97"          1.97)
  ("diff_2_00"          2.00)
  ("diff_3_00"          3.00)
  ("diff_3_72"          3.72)
  ("diff_5_00"          5.00)
  )
)
(TECHinclude (BOOTprependTechPath "../pcios/s8/s8phirs-10r/info/edr.il"))
(TECHinclude (BOOTprependTechPath "..pcios/s8/s8phirs-10r/info/devices.il"))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;ANTENNA RULES
;;;;;;;;;;;;;;;;;;;;;;;;;;
(TECHsetRules
   '(
     ("poly_flt"                0.180    "thickness" "poly")
     ("li1_flt"                 0.100    "thickness" "li1")
     ("met1_flt"                0.350    "thickness" "met1")
     ("met2_flt"                0.350    "thickness" "met2")
     ("met3_flt"                0.800    "thickness" "met3")
     ("met4_flt"                0.800    "thickness" "met4")
     ("met5_flt"                1.200    "thickness" "met5")
     ("rdl_flt"                 2.000    "thickness" "rdl")

     ("poly_a_max"             50)
     ("licon_a_max"             3)
     ("li1_a_max"              75        "antennaRatioMax" "li1" )
     ("mcon_a_max"              3        "antennaRatioMax" "mcon")
     ("met1_a_max"            400        "antennaRatioMax" "met1")
     ("via_a_max"               6        "antennaRatioMax" "via" )
     ("met2_a_max"            400        "antennaRatioMax" "met2")
     ("via2_a_max"              6        "antennaRatioMax" "via2")
     ("met3_a_max"            400        "antennaRatioMax" "met3")
     ("via3_a_max"              6        "antennaRatioMax" "via3")
     ("met4_a_max"            400        "antennaRatioMax" "met4")
     ("via4_a_max"              6        "antennaRatioMax" "via4")
     ("met5_a_max"            400        "antennaRatioMax" "met5")
 

     ;("poly_K"               n/a)
     ;("licon_K"              n/a)
     ("li1_K"                 450        "antennaK"        "li1" )
     ("mcon_K"                 18        "antennaK"        "mcon")
     ("met1_K"                400        "antennaK"        "met1")
     ("via_K"                  36        "antennaK"        "via" )
     ("met2_K"                400        "antennaK"        "met2")
     ("via2_K"                 36        "antennaK"        "via2")
     ("met3_K"                400        "antennaK"        "met3")
     ("via3_K"                 36        "antennaK"        "via3")
     ("met4_K"                400        "antennaK"        "met4")
     ("via4_K"                 36        "antennaK"        "via4")
     ("met5_K"                400        "antennaK"        "met5")


     ("met1_diodeBonus"      2200        "antennaDiodeBonus" "met1")
     ("met2_diodeBonus"      2200        "antennaDiodeBonus" "met2")
     ("met3_diodeBonus"      2200        "antennaDiodeBonus" "met3")
     ("met4_diodeBonus"      2200        "antennaDiodeBonus" "met4")
     ("met5_diodeBonus"      2200        "antennaDiodeBonus" "met5")

    )
  )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; s8p-10r LEF file specific rules
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; must be put here, after the tech.il load
(eval
 `(TECHsetRules
  '(("same_mcon_mcon" ,(TECHgetRuleWith "minSpacing" "mcon") "sameNet" "mcon" "mcon")
    ("same_met1_met1" ,(TECHgetRuleWith "minSpacing" "met1") "sameNet" "met1" "met1")
    ("same_via_via"   ,(TECHgetRuleWith "minSpacing" "via" ) "sameNet" "via"  "via" )
    ("same_met2_met2" ,(TECHgetRuleWith "minSpacing" "met2") "sameNet" "met2" "met2")
    ("same_via2_via2" ,(TECHgetRuleWith "minSpacing" "via2") "sameNet" "via2" "via2")
    ("same_met3_met3" ,(TECHgetRuleWith "minSpacing" "met3") "sameNet" "met3" "met3")
    ("same_via3_via3" ,(TECHgetRuleWith "minSpacing" "via3") "sameNet" "via3" "via3")
    ("same_met4_met4" ,(TECHgetRuleWith "minSpacing" "met4") "sameNet" "met4" "met4")
    ("same_met5_met5" ,(TECHgetRuleWith "minSpacing" "met5") "sameNet" "met5" "met5")
 
    ("same_mcon_via"   0.0 "sameNet"  "mcon" "via"  )
    ("same_mcon_via2"  0.0 "sameNet"  "mcon" "via2" )
    ("same_mcon_via3"  0.0 "sameNet"  "mcon" "via3" )
    ("same_via_via2"   0.0 "sameNet"  "via"  "via2" )
    ("same_via_via3"   0.0 "sameNet"  "via"  "via3" )
    ("same_via2_via3"  0.0 "sameNet"  "via2" "via3" )
    ("same_via3_via4"  0.0 "sameNet"  "via3" "via4" )

     )
   ) ; TECHsetRules
) ; eval


(eval
 `(TECHsetRules
    '(("offset_met1" ,(TECHgetRoutingOffsetL2V "met1" "mcon" "via")
                     "offset" "met1")
      ("offset_met2" ,(TECHgetRoutingOffsetL2V "met2" "via" "via2")
                     "offset" "met2")
      ("offset_met3" ,(TECHgetRoutingOffsetL2V "met3" "via2" "via3") 
                     "offset" "met3")
      ("offset_met4" ,(TECHgetRoutingOffsetL2V "met4" "via3"      )
                     "offset" "met4")
      ("offset_met5" ,(TECHgetRoutingOffsetL2V "met5" "via4"      )
                     "offset" "met5")
     )
  ) ; closes TECHsetrules
)

(TECHgetLEFAntennaRule "li1"
                       (TECHgetRuleWith "antennaRatioMax" "li1")
                       (TECHgetRuleWith "antennaK" "li1")
                       ?cum nil 
                       ?peri t
                       ?diodeArea (times (TECHgetRuleWith "minWidth" "diff") (TECHgetRuleWith "minWidth" "diff"))
                       )
(setq metallist '("met1" "met2" "met3" "met4" "met5"))
(for layer_met 0 (plus length(metallist) -1) 
         (TECHgetLEFAntennaRule ,(nth layer_met metallist)
                       (TECHgetRuleWith "antennaRatioMax" ,(nth layer_met metallist))
                       (TECHgetRuleWith "antennaK" ,(nth layer_met metallist))
                       ?cum nil 
                       ?peri t
                       ?diodeArea (times (TECHgetRuleWith "minWidth" "diff") (TECHgetRuleWith "minWidth" "diff"))
                       ?diodeBonus (TECHgetRuleWith "antennaDiodeBonus" ,(nth layer_met metallist))
                       )
)
(setq vialist '("mcon" "via" "via2" "via3" "via4"))
(for layer_via 0 (plus length(vialist) -1) 
         (TECHgetLEFAntennaRule ,(nth layer_via vialist)
                       (TECHgetRuleWith "antennaRatioMax" ,(nth layer_via vialist))
                       (TECHgetRuleWith "antennaK" ,(nth layer_via vialist))
                       ?cum nil 
                       ?peri nil
                       ?diodeArea (times (TECHgetRuleWith "minWidth" "diff") (TECHgetRuleWith "minWidth" "diff"))
                       )
)

;; SERC Tables

;; contains SERC rule specific tech info
;;NOTE: While entering clamp pins, the order is important.
;;      First one should be the pin, through which the signal net is connected.
;;      Second one should be the pin, through which the clamp supply is connected.
;;      The rest comes any other pins.
;;IMPORTANT: If the order is not kept, PERC (SERC) job may crash. 
(TECHcreateTable
 ?tableName   "SERC Tech Info"
 ?description "Technology Information for SERC Rules"
 ?header (list "SERC Rule Key" "Name" "Value")
 ?data   (list
	  `("fbdpg"           "fbdpg_exempt_cells"                           ""                                         )
	  `("hvdrvlvgate"     "hvdrvlvgate_exempt_cells"                     ""                                         )
	  `("lvDevWithHVsup"  "lvDevWithHVsup_exempt_cells"                  ""                                         )
	  `("ipspc"           "ipspc_esd_hv_r_cell_names"                    "{s8_esd_res75only pad rout} {s8_esd_res75only_small pad rout} {s8_esd_res75only_noshorts pad rout} {s8_esd_res75only_noshorts_nometal pad rout}" )
	  `("ipspc"           "ipspc_esd_lv_r_cell_names"                    "{s8_esd_res250 pad rout} {s8_esd_res250only pad rout} {s8_esd_res250only_small pad rout} " )
	  `("ipspc"           "ipspc_esd_hv_pwr_nmos_local_clamp_cell_names" "{s8_esd_localdiode_hv p vgnd} {s8_esd_signal_5_sym_hv_local_5term in vgnd} ")
	  `("ipspc"           "ipspc_esd_hv_gnd_nmos_local_clamp_cell_names" "{s8_esd_signal_5_sym_hv_local in vgnd} {s8_esd_signal_5_sym_hv_local_5term in vgnd} {s8_esd_signal_5_sym_hv_local_5term_dnwl in vgnd} ")
	  `("ipspc"           "ipspc_esd_lv_pwr_nmos_local_clamp_cell_names" "{s8_esd_localdiode_lv p vgnd} ")
	  `("ipspc"           "ipspc_esd_lv_gnd_nmos_local_clamp_cell_names" "{s8_esd_signal_5_sym_lv_local in vgnd} ")
	  `("b2bMainGnd"      "b2bMainGnd_esd_b2b_diode_cell_names"          "{s8_esd_gnd2gnd_120x2_lv_isosub vssn vssi vsub}"  )
	  )
 )


;; defines each SERC rule category as being mandatory or recommended in IP and full chip runs
(TECHcreateTable
 ?tableName "SERC Rule Matrix"
 ?description "Defines recommended/mandatory status for SERC rule categories"
 ?header (list "SERC Rule Key" "Mandatory Rules IP" "Mandatory Rules Full Chip" "Recommended Rules IP" "Recommended Rules Full Chip")
 ?data   (list
	  `(   "setup"                    t                       t                           nil                    nil)
	  `(   "dgts"                     nil                     nil                         t                      t  )
	  `(   "fbdpg"                    t                       t                           nil                    nil)
	  `(   "missBulk"                 t                       t                           nil                    nil)
	  `(   "floGate"                  t                       t                           nil                    nil)
	  `(   "ifb"                      t                       t                           nil                    nil)
	  `(   "hvdrvlvgate"              t                       t                           nil                    nil)
	  `(   "lvDevWithHVsup"           t                       t                           nil                    nil)
	  `(   "hvlvcrossing"             nil                     nil                         t                      t  )
	  `(   "b2bMainGnd"               nil                     t                           nil                    nil)
	  `(   "ipspc"                    nil                     nil                         t                      t  )
	  `(   "relpg"                    t                       t                           nil                    nil)
	  `(   "printSum"                 t                       t                           nil                    nil)
	  )
 
 )
