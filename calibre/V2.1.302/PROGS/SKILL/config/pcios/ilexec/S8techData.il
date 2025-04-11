;----------------------------------------------------------
; Design Rules for s8phirs_10r technology
;----------------------------------------------------------

designRules = ncons(nil)

;--- LAYER "nwell"
designRules->nwell = ncons(nil) ; initialize list for layer
designRules->nwell->type        = "n_well"
designRules->nwell->layer       = "nwell"
designRules->nwell->purpose     = "drawing"
designRules->nwell->minW        = 0.84
designRules->nwell->minSP       = 1.27
designRules->nwell->minOLdiff   = 0.18
designRules->nwell->minOLtap    = 0.18
designRules->nwell->minOLhvdiff = 0.33
designRules->nwell->minOLhvtap  = 0.33

;--- LAYER "diff"
designRules->diff = ncons(nil) ; initialize list for layer
designRules->diff->type         = "n_diffusion"
designRules->diff->layer        = "diff"
designRules->diff->purpose      = "drawing"
designRules->diff->minW         = 0.15
designRules->diff->minSP        = 0.27
designRules->diff->minOLSlicon1 = 0.06     ; diff overlap licon1 on short edge
designRules->diff->minOLLlicon1 = 0.04     ; diff overlap licon1 on long edge

;--- LAYER "tap"
designRules->tap = ncons(nil) ; initialize list for layer
designRules->tap->type         = "n_diffusion"
designRules->tap->layer        = "tap"
designRules->tap->purpose      = "drawing"
designRules->tap->minW         = 0.15
designRules->tap->minSP        = 0.27
designRules->tap->minOLSlicon1 = 0.06     ; tap overlap licon1 on short edge
designRules->tap->minOLLlicon1 = 0.04     ; tap overlap licon1 on long edge
designRules->tap->minOLSisoTapLicon1 = 0.12     ; isolated tap overlap licon1 on short edge
designRules->tap->minOLLisoTapLicon1 = 0.12     ; isolated tap overlap licon1 on long edge

;--- LAYER "poly"
designRules->poly = ncons(nil) ; initialize list for layer
designRules->poly->type           = "polysilicon"
designRules->poly->layer          = "poly"
designRules->poly->purpose        = "drawing"
designRules->poly->minW           = 0.15
designRules->poly->minPresW       = 0.33
designRules->poly->minSP          = 0.21
designRules->poly->rpolyMinSPdiff = 0.48
designRules->poly->rpolyMinSPtap  = 0.48
designRules->poly->rpolyMinSPpoly = 0.48
designRules->poly->minOLSlicon1   = 0.08     ; poly overlap licon1 on short edge
designRules->poly->minOLLlicon1   = 0.05     ; poly overlap licon1 on long edge

;--- Poly Resistor
designRules->pres = ncons(nil) ; initialize list
designRules->pres->rpmOLpoly = 0.20
designRules->pres->psdmOLpoly = 0.11
designRules->pres->npcOLpoly = 0.095
designRules->pres->contW = 0.19
designRules->pres->contL = 2.00
designRules->pres->contSP = 0.51
designRules->pres->polyOLScont = 0.08
designRules->pres->polyOLLcont = 0.05

;--- LAYER "licon1"
designRules->licon1 = ncons(nil) ; initialize list for layer
designRules->licon1->type      = "cut"
designRules->licon1->layer     = "licon1"
designRules->licon1->purpose   = "drawing"
designRules->licon1->minW      = 0.17
designRules->licon1->minSP     = 0.17
designRules->licon1->minWSlot  = 0.19
designRules->licon1->minLSlot  = 2.0
designRules->licon1->minSPslot = 0.51
designRules->licon1->taplicon1SPnpc = 0.09

;--- LAYER "li1"
designRules->li1 = ncons(nil) ; initialize list for layer
designRules->li1->type         = "metal"
designRules->li1->layer        = "li1"
designRules->li1->purpose      = "drawing"
designRules->li1->pinlayer     = "li1"
designRules->li1->pinpurpose   = "pin"
designRules->li1->minW         = 0.17
designRules->li1->minSP        = 0.17
designRules->li1->minOLSlicon1 = 0.08     ; li1 overlap licon1 on short edge
designRules->li1->minOLLlicon1 = 0.08     ; li1 overlap licon1 on long edge
designRules->li1->minOLSmcon   = 0.00     ; li1 overlap mcon on short edge
designRules->li1->minOLLmcon   = 0.00     ; li1 overlap mcon on long edge

;--- LAYER "mcon"
designRules->mcon = ncons(nil) ; initialize list for layer
designRules->mcon->type    = "cut"
designRules->mcon->layer   = "mcon"
designRules->mcon->purpose = "drawing"
designRules->mcon->minW    = 0.17
designRules->mcon->minSP   = 0.19

;--- LAYER "met1"
designRules->met1 = ncons(nil) ; initialize list for layer
designRules->met1->type       = "metal"
designRules->met1->layer      = "met1"
designRules->met1->purpose    = "drawing"
designRules->met1->pinlayer   = "met1"
designRules->met1->pinpurpose = "pin"
designRules->met1->minW       = 0.14
designRules->met1->minSP      = 0.14
designRules->met1->minOLSmcon = 0.06     ; met1 overlap mcon on short edge
designRules->met1->minOLLmcon = 0.03     ; met1 overlap mcon on long edge

;--- LAYER "rpm"
designRules->rpm = ncons(nil)
designRules->rpm->layer        = "rpm"
designRules->rpm->purpose      = "drawing"
designRules->rpm->type         = "protect_from_n+_poly_implant"
designRules->rpm->minW         = 1.27
designRules->rpm->minSP        = 0.84
designRules->rpm->minOLpoly    = 0.20
designRules->rpm->rpmMinSPpoly = 0.20
designRules->rpm->rpmMinSPnsdm = 0.20

;--- LAYER "urpm"
designRules->urpm = ncons(nil)
designRules->urpm->layer        = "urpm"
designRules->urpm->purpose      = "drawing"
designRules->urpm->type         = "protect_from_n+_poly_implant"
designRules->urpm->minW         = 1.27
designRules->urpm->minSP        = 0.84
designRules->urpm->minOLpoly    = 0.20
designRules->urpm->rpmMinSPpoly = 0.20
designRules->urpm->rpmMinSPnsdm = 0.20

;--- LAYER "psdm"
designRules->psdm = ncons(nil)
designRules->psdm->layer          = "psdm"
designRules->psdm->purpose        = "drawing"
designRules->psdm->type           = "p+_s_d_implant"
designRules->psdm->minW           = 0.38
designRules->psdm->minSP          = 0.38
designRules->psdm->psdmMinOLdiff  = 0.125
designRules->psdm->psdmMinOLtap   = 0.13
designRules->psdm->psdmMinOLrpoly = 0.11
designRules->psdm->psdmMinSPnsdm  = 0.13

;--- LAYER "nsdm"
designRules->nsdm = ncons(nil)
designRules->nsdm->layer         = "nsdm"
designRules->nsdm->purpose       = "drawing"
designRules->nsdm->type          = "n+_s_d_implant"
designRules->nsdm->minW          = 0.38
designRules->nsdm->minSP         = 0.38
designRules->nsdm->nsdmMinOLdiff = 0.125
designRules->nsdm->nsdmMinOLtap  = 0.13
designRules->nsdm->nsdmMinSPnsdm = 0.13
designRules->nsdm->nsdmMinSPpsdm = 0.13

;--- LAYER "npc"
designRules->npc = ncons(nil)
designRules->npc->layer     = "npc"
designRules->npc->purpose   = "drawing"
designRules->npc->type      = "nitride_poly_cut"
designRules->npc->minW      = 0.27
designRules->npc->minSP     = 0.27
designRules->npc->minOLpoly = 0.095

;--- LAYER "hvi"
designRules->hvi = ncons(nil)
designRules->hvi->layer        = "hvi"
designRules->hvi->purpose      = "drawing"
designRules->hvi->type         = "5V well coding"
designRules->hvi->minW         = 0.60
designRules->hvi->minSP        = 0.70
designRules->hvi->minOLdiff    = 0.18
designRules->hvi->minOLtap     = 0.18
designRules->hvi->hviMinSPdiff = 0.18
designRules->hvi->hviMinSPtap  = 0.18

;--- LAYER "vhvi"
designRules->vhvi = ncons(nil)
designRules->vhvi->layer         = "vhvi"
designRules->vhvi->purpose       = "drawing"
designRules->vhvi->type          = "12V well coding"
designRules->vhvi->minW          = 0.60
designRules->vhvi->minSP         = 0.70
designRules->vhvi->minOLdiff     = 0.18
designRules->vhvi->minOLtap      = 0.18
designRules->vhvi->vhviMinSPdiff = 0.18
designRules->vhvi->vhviMinSPtap  = 0.18

;--- LAYER "uhvi"
designRules->uhvi = ncons(nil)
designRules->uhvi->layer         = "uhvi"
designRules->uhvi->purpose       = "drawing"
designRules->uhvi->type          = "20V well coding"
designRules->uhvi->minW          = 0.0
designRules->uhvi->minSP         = 0.0
designRules->uhvi->minOLdiff     = 0.0
designRules->uhvi->minOLtap      = 0.0
designRules->uhvi->vhviMinSPdiff = 0.0
designRules->uhvi->vhviMinSPtap  = 0.0


/*==============================================================================
Device(s) Information
Info per device defined here, in another file, or taken from tech file (either
from rules or control section)

legend for variables
  W - width
  L - length
  SP - spacing
  OL - overlap (all directions)
  OLS - overlap (short edge)
  OLL - overlap (long edge)
  EX - extension (X or Y)

All floating values are in microns so they coincide with the layout grid.

Be sure that after you add the device with all parameters defined (ALL must be
defined) to add it to the deviceList at the bottom of the file.

==============================================================================*/
devices = list() 

/*===  POLY RESISTORS  ===*/

; hrpoly
;-----------------------------------------------------------
hrpoly = ncons(nil)
hrpoly->deviceName = "hrpoly"
hrpoly->modelName = "xhrpoly"
hrpoly->paramCB = "S8hrpolyCB"
; default/minimum/maximum width/lengths
hrpoly->sheetRho = 317.3885
hrpoly->defRes = 999.822
hrpoly->defSegRes = 668.102793
hrpoly->defHeadRes = 165.85972
hrpoly->defSegSP = 0.21
hrpoly->defW = 1.00
hrpoly->defL = 2.105
hrpoly->minL = 0.50
hrpoly->maxL = 30000.0
hrpoly->minW = 0.15
hrpoly->maxW = 1000.0
; layers needed
hrpoly->resLay      = list("poly"   "drawing")
hrpoly->imp1Lay     = list("psdm"   "drawing")
hrpoly->imp2Lay     = list("npc"    "drawing")
hrpoly->imp3Lay     = list("rpm"    "drawing")
hrpoly->mrk1Lay     = list("poly"   "res")
hrpoly->nwellLay    = list("nwell"  "drawing")
hrpoly->contLay     = list("licon1" "drawing")
hrpoly->metLay      = list("li1"    "drawing")
hrpoly->tapLay      = list("tap"    "drawing")
hrpoly->tapNImpLay  = list("nsdm"   "drawing")
hrpoly->tapPImpLay  = list("psdm"   "drawing")
hrpoly->volt1Lay    = list("poly"   "res")

; device specific rules since it matters on the implant/marking layers
; all implant/marking layers will be based on the overlap of the resistor
; so the values might need to be a calculation of other variables at times
; or take into account the tap layer
hrpoly->imp1OLres   = 0.11  ; implant1 overlap resistor
hrpoly->imp1MinW    = 0.38  ; implant1 min width
hrpoly->imp2OLres   = 0.095 ; implant2 overlap resistor
hrpoly->imp2MinW    = 0.27  ; implant2 min width
hrpoly->imp3OLres   = 0.20  ; implant3 overlap resistor
hrpoly->imp3MinW    = 1.27  ; implant3 min width
; for rpm the foundry said this doesn't really need to be 1.27 like
; docs say so setting it to min pres width + 2* rpm over pres
hrpoly->mrk1OLres   = 0.00  ; marking layer 1 overlap resistor
hrpoly->tapImpSPImp1 = 0.0  ; tap implant spacing to implant 1
hrpoly->tapImpSPImp2 = 0.0  ; tap implant spacing to implant 2
hrpoly->tapImpSPImp3 = designRules->rpm->rpmMinSPnsdm  ; tap implant spacing to implant 3

devices = append1( devices hrpoly )

; uhrpoly
;-----------------------------------------------------------
uhrpoly = ncons(nil)
uhrpoly->deviceName = "uhrpoly"
uhrpoly->modelName = "xuhrpoly_base"
uhrpoly->paramCB = "S8hrpolyCB"
; default/minimum/maximum width/lengths
uhrpoly->sheetRho = 2000.00
uhrpoly->defRes = 100019.00
uhrpoly->defSegRes = 99428.571429 
uhrpoly->defHeadRes = 294.995000 
uhrpoly->defSegSP = 0.21
uhrpoly->defW = 0.35 
uhrpoly->defL = 17.4
uhrpoly->minL = 0.50
uhrpoly->maxL = 30000.0
uhrpoly->minW = 0.15
uhrpoly->maxW = 1000.0
; layers needed
uhrpoly->resLay      = list("poly"   "drawing")
uhrpoly->imp1Lay     = list("psdm"   "drawing")
uhrpoly->imp2Lay     = list("npc"    "drawing")
uhrpoly->imp3Lay     = list("urpm"   "drawing")
uhrpoly->mrk1Lay     = list("poly"   "res")
uhrpoly->nwellLay    = list("nwell"  "drawing")
uhrpoly->contLay     = list("licon1" "drawing")
uhrpoly->metLay      = list("li1"    "drawing")
uhrpoly->tapLay      = list("tap"    "drawing")
uhrpoly->tapNImpLay  = list("nsdm"   "drawing")
uhrpoly->tapPImpLay  = list("psdm"   "drawing")
uhrpoly->volt1Lay    = list("poly"   "res")

; device specific rules since it matters on the implant/marking layers
; all implant/marking layers will be based on the overlap of the resistor
; so the values might need to be a calculation of other variables at times
; or take into account the tap layer
uhrpoly->imp1OLres   = 0.11  ; implant1 overlap resistor
uhrpoly->imp1MinW    = 0.38  ; implant1 min width
uhrpoly->imp2OLres   = 0.095 ; implant2 overlap resistor
uhrpoly->imp2MinW    = 0.27  ; implant2 min width
uhrpoly->imp3OLres   = 0.20  ; implant3 overlap resistor
uhrpoly->imp3MinW    = 1.27  ; implant3 min width
; for rpm the foundry said this doesn't really need to be 1.27 like
; docs say so setting it to min pres width + 2* rpm over pres
uhrpoly->mrk1OLres   = 0.00  ; marking layer 1 overlap resistor
uhrpoly->tapImpSPImp1 = 0.0  ; tap implant spacing to implant 1
uhrpoly->tapImpSPImp2 = 0.0  ; tap implant spacing to implant 2
uhrpoly->tapImpSPImp3 = designRules->urpm->rpmMinSPnsdm  ; tap implant spacing to implant 3

devices = append1( devices uhrpoly )
