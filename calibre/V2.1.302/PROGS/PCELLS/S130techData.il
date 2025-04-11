/*==============================================================================
  File:         S130techData.il
  Purpose:      Design rules and device info for Skywater S130 Pcells

  Created:      Mar 25, 2020  Madek Graham
  Description:  Provides the needed variables used by the pcell code and
                callbacks.  DRC variables and device layers.
  
  Devices defined:  cm3m4, cm4m5
                    ddnw_sub, ddnw_sub_v5, ddnw_sub_v12, ddnw_sub_v20
                    dpw_dnw, dpw_dnw_v5, dpw_dnw_v12, dpw_dnw_v20
                    dnsd_pw, dnsd_pw_esd, dnsd_pw_esd_v5, dnsd_pw_lvt
                    dnsd_pw_nat, dnsd_pw_v5
                    dpsd_nw, dpsd_nw_esd, dpsd_nw_esd_v5
                    dpsd_nw_hvt, dpsd_nw_lvt, dpsd_nw_v5
					diode_antenna
                    nmos, nmos_esd, nmos_esd_nat_v5, nmos_esd_v5, nmos_lvt
                    nmos_nat_v3, nmos_nat_v5, nmos_v5
                    npn_1x1, npn_1x1_v5, npn_1x2
                    pad_bond, pad_microprobe, pad_probe
                    pmos, pmos_esd_v5, pmos_hvt, pmos_lvt, pmos_v5
                    pnp, pnp_5x
                    rmet (rli1-rmet5)
                    rndiff, rndiff_v5
                    rpdiff, rpdiff_v5
                    rpoly, rpoly_hp, rpoly_hp2K
                    rpwell
                    nmos_de_v20, nmos_de_iso_v20, nmos_de_nat_v20, nmos_de_zvt_v20
                    pmos_de_v20
                    fuse_m4
9/28/2021 - CBPL updating SealRing pcell to add 2 parameters wOutside=w+6microns lOutside=l+6microns
					Changed display w -> w Inside  l -> l Inside 
11/04/2021 - CBPL updating the SealRing maxDieW number from 10000 to 32,000 per pnm
11/22/2021 - CBPL updating the SealRing maxDieW number from 10k to 100k per nosl
03/15/2022 - CBPL adding an antenna diode diode_antenna

==============================================================================*/

/* Some premilinary setups for the library */
; Setting to ensure symbol values are in metrics
gLabelsNumNotation = 'suffix
; Set VXL mfactor
envSetVal("layoutXL" "mfactorNames" 'string "m mult")
; procedure to disable cell changes on placed devices (used in cdf initproc)
procedure( S130disablePcellChange(cdfDataId)
  if( cdfgForm~>_formName == "Edit Object Properties" then
    cdfgForm->cellName->editable = nil
  )
)


;----------------------------------------------------------
; Design Rules for S130 technology
;----------------------------------------------------------

designRules = ncons(nil)

;--- LAYER "dnwell"
designRules->dnwell = ncons(nil) ; initialize list for layer
designRules->dnwell->type        = "deep_nwell"
designRules->dnwell->layer       = "dnwell"
designRules->dnwell->purpose     = "drawing"
designRules->dnwell->minW        = 3.0    ; TDR dnwell.2
designRules->dnwell->minOLipw    = 1.03   ; TDR nwell.6

;--- LAYER "nwell"
designRules->nwell = ncons(nil) ; initialize list for layer
designRules->nwell->type        = "n_well"
designRules->nwell->layer       = "nwell"
designRules->nwell->purpose     = "drawing"
designRules->nwell->minW        = 0.84    ; TDR nwell.1
designRules->nwell->minSP       = 1.27    ; TDR nwell.2a
designRules->nwell->minOLdiff   = 0.18    ; TDR difftap.8
designRules->nwell->minOLtap    = 0.18    ; TDR difftap.10
designRules->nwell->minOLhvdiff = 0.33
designRules->nwell->minOLhvtap  = 0.33
designRules->nwell->minOLdnwell = 0.40    ; TDR nwell.5

;--- LAYER "lvtn"
designRules->lvtn = ncons(nil)
designRules->lvtn->type         = "define low Vt LV mosfets"
designRules->lvtn->layer        = "lvtn"
designRules->lvtn->purpose      = "drawing"
designRules->lvtn->minW         = 0.38    ; TDR lvtn.1a
designRules->lvtn->minSP        = 0.38    ; TDR lvtn.2
designRules->lvtn->minOLgate    = 0.18    ; TDR lvtn.4b
designRules->lvtn->minWellOL    = 0.38    ; TDR lvtn.10
designRules->lvtn->minA         = 0.265   ; TDR hvtp.13

;--- LAYER "hvtp"
designRules->hvtp = ncons(nil)
designRules->hvtp->type         = "define high Vt LV mosfets"
designRules->hvtp->layer        = "hvtp"
designRules->hvtp->purpose      = "drawing"
designRules->hvtp->minW         = 0.38    ; TDR hvtp.1
designRules->hvtp->minSP        = 0.38    ; TDR hvtp.2
designRules->hvtp->minOLgate    = 0.18    ; TDR hvtp.3
designRules->hvtp->minWellOL    = 0.0     ; TDR no rule for this
designRules->hvtp->minA         = 0.265   ; TDR hvtp.5

;--- LAYER "diff"
designRules->diff = ncons(nil) ; initialize list for layer
designRules->diff->type         = "diffusion"
designRules->diff->layer        = "diff"
designRules->diff->purpose      = "drawing"
designRules->diff->pinlayer     = "diff"
designRules->diff->pinpurpose   = "pin"
designRules->diff->minW         = 0.15
designRules->diff->minSP        = 0.27
designRules->diff->minOLSlicon1 = 0.06    ; diff overlap licon1 on short edge
designRules->diff->minOLLlicon1 = 0.04    ; diff overlap licon1 on long edge
designRules->diff->minOLgate    = 0.25    ; diff extend over poly (S/D min width)
designRules->diff->minSPnwell   = 0.34    ; TDR difftap.9
designRules->diff->minWhv       = 0.29    ; TDR difftap.14
designRules->diff->minSPhv      = 0.30    ; TDR difftap.15a
designRules->diff->minSPhvtap   = 0.37    ; TDR difftap.15b

;--- LAYER "tap"
designRules->tap = ncons(nil) ; initialize list for layer
designRules->tap->type         = "diffusion"
designRules->tap->layer        = "diff"
designRules->tap->purpose      = "drawing"
designRules->tap->minW         = 0.15           ; TDR difftap.1
designRules->tap->minSP        = 0.27           ; TDR difftap.3
designRules->tap->minSPpoly    = 0.055          ; TDR poly.5
designRules->tap->minOLSlicon1 = 0.06           ; tap overlap licon1 on short edge
designRules->tap->minOLLlicon1 = 0.04           ; tap overlap licon1 on long edge
designRules->tap->minOLSisoTapLicon1 = 0.12     ; isolated tap overlap licon1 on short edge
designRules->tap->minOLLisoTapLicon1 = 0.12     ; isolated tap overlap licon1 on long edge
designRules->tap->minSPnwell   = 0.13           ; TDR difftap.11

;--- LAYER "psdm"
designRules->psdm = ncons(nil)
designRules->psdm->type       = "p+_s_d_implant"
designRules->psdm->layer      = "psdm"
designRules->psdm->purpose    = "drawing"
designRules->psdm->minW       = 0.38    ; TDR psd.1
designRules->psdm->minSP      = 0.38    ; TDR psd.2
designRules->psdm->minOLdiff  = 0.125   ; TDR psd.5a
designRules->psdm->minOLtap   = 0.13    ; TDR psd.5b
designRules->psdm->minSPdiff  = 0.13    ; TDR psd.7
designRules->psdm->minOLrpoly = 0.11    ; TDR rpm.4

;--- LAYER "nsdm"
designRules->nsdm = ncons(nil)
designRules->nsdm->type       = "n+_s_d_implant"
designRules->nsdm->layer      = "nsdm"
designRules->nsdm->purpose    = "drawing"
designRules->nsdm->minW       = 0.38    ; TDR nsd.1
designRules->nsdm->minSP      = 0.38    ; TDR nsd.2
designRules->nsdm->minOLdiff  = 0.125   ; TDR nsd.5a
designRules->nsdm->minOLtap   = 0.13    ; TDR nsd.5b
designRules->nsdm->minSPdiff  = 0.13    ; TDR nsd.7

;--- LAYER "poly"
designRules->poly = ncons(nil) ; initialize list for layer
designRules->poly->type           = "polysilicon"
designRules->poly->layer          = "poly"
designRules->poly->purpose        = "drawing"
designRules->poly->pinlayer       = "poly"
designRules->poly->pinpurpose     = "pin"
designRules->poly->minW           = 0.15    ; TDR poly.1a
designRules->poly->minSP          = 0.21    ; TDR poly.2
designRules->poly->minPresW       = 0.33    ; TDR poly.3
designRules->poly->minSPdiff      = 0.075   ; TDR poly.4
designRules->poly->minSPtap       = 0.055   ; TDR poly.5
designRules->poly->minOLdiff      = 0.13    ; TDR poly.8
designRules->poly->rpolyMinSPdiff = 0.48    ; TDR poly.9
designRules->poly->rpolyMinSPtap  = 0.48    ; TDR poly.9
designRules->poly->rpolyMinSPpoly = 0.48    ; TDR poly.9
designRules->poly->minOLLlicon1   = 0.05    ; TDR licon1.8
designRules->poly->minOLSlicon1   = 0.08    ; TDR licon1.8a

;--- Poly Resistor
designRules->pres = ncons(nil) ; initialize list
designRules->pres->rpmOLpoly   = 0.20
designRules->pres->psdmOLpoly  = 0.11
designRules->pres->npcOLpoly   = 0.095
designRules->pres->contW       = 0.19
designRules->pres->contL       = 2.00
designRules->pres->contSP      = 0.51
designRules->pres->polyOLScont = 0.08
designRules->pres->polyOLLcont = 0.05

;--- LAYER "licon1"
designRules->licon1 = ncons(nil) ; initialize list for layer
designRules->licon1->type           = "cut"
designRules->licon1->layer          = "licon"
designRules->licon1->purpose        = "drawing"
designRules->licon1->minW           = 0.17    ; TDR licon.1
designRules->licon1->minSP          = 0.17    ; TDR licon.2
designRules->licon1->minPcontSPpsdm = 0.11    ; TDR licon.9
designRules->licon1->minDcontSPpoly = 0.055   ; TDR licon.11
designRules->licon1->minPcontSPdiff = 0.19    ; TDR licon.14
designRules->licon1->minWSlot       = 0.19    ; TDR licon.1b
designRules->licon1->minLSlot       = 2.0     ; TDR licon.1c
designRules->licon1->minSPslot      = 0.51    ; TDR licon.2c
designRules->licon1->taplicon1SPnpc = 0.09    ; TDR licon.13
; fix due to rename of layer
designRules->licon = designRules->licon1

;--- LAYER "li1"
designRules->li1 = ncons(nil) ; initialize list for layer
designRules->li1->type         = "metal"
designRules->li1->layer        = "li"
designRules->li1->purpose      = "drawing"
designRules->li1->pinlayer     = "li"
designRules->li1->pinpurpose   = "pin"
designRules->li1->minW         = 0.17     ; TDR li1.1
designRules->li1->minSP        = 0.17     ; TDR li1.3
designRules->li1->minOLSlicon1 = 0.08     ; TDR li1.5 li1 overlap licon1 on short edge
designRules->li1->minOLLlicon1 = 0.00     ; li1 overlap licon1 on long edge
designRules->li1->minOLSmcon   = 0.00     ; TDR ct.4  li1 overlap mcon on short edge
designRules->li1->minOLLmcon   = 0.00     ; TDR ct.4  li1 overlap mcon on long edge
designRules->li1->minresW      = 0.29     ; TDR li1.7
designRules->li1->sheetRho     = 12.8
; fix due to rename of layer
designRules->li = designRules->li1

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
designRules->met1->minW       = 0.14    ; TDR m1.1
designRules->met1->minSP      = 0.14    ; TDR m1.2
designRules->met1->minSPwide  = 0.28    ; TDR m1.2b
designRules->met1->minWide    = 3.0
designRules->met1->minOLLmcon = 0.03    ; TDR m1.4
designRules->met1->minOLSmcon = 0.06    ; TDR m1.5
designRules->met1->minArea    = 0.083   ; TDR m1.6
designRules->met1->minOLLviaL = 0.055   ; TDR via.4a
designRules->met1->minOLSviaL = 0.085   ; TDR via.5a
designRules->met1->minresW    = 0.14    ; TDR m1.1
designRules->met1->sheetRho   = 0.125

;--- LAYER "via1"
designRules->via1 = ncons(nil) ; initialize list for layer
designRules->via1->type    = "cut"
designRules->via1->layer   = "via1"
designRules->via1->purpose = "drawing"
designRules->via1->minW    = 0.15
designRules->via1->minSP   = 0.17

;--- LAYER "met2"
designRules->met2 = ncons(nil)
designRules->met2->type       = "metal"
designRules->met2->layer      = "met2"
designRules->met2->purpose    = "drawing"
designRules->met2->pinlayer   = "met2"
designRules->met2->pinpurpose = "pin"
designRules->met2->minW       = 0.14    ; TDR m2.1
designRules->met2->minSP      = 0.14    ; TDR m2.2
designRules->met2->minOLLviaL = 0.03    ; TDR m2.4
designRules->met2->minOLSviaL = 0.06    ; TDR m2.5
designRules->met2->minOLLviaU = 0.055   ; TDR via2.4
designRules->met2->minOLSviaU = 0.085   ; TDR via2.5
designRules->met2->minresW    = 0.14    ; TDR m2.1
designRules->met2->sheetRho   = 0.125

;--- LAYER "via2"
designRules->via2 = ncons(nil) ; initialize list for layer
designRules->via2->type    = "cut"
designRules->via2->layer   = "via2"
designRules->via2->purpose = "drawing"
designRules->via2->minW    = 0.2
designRules->via2->minSP   = 0.2

;--- LAYER "met3"
designRules->met3 = ncons(nil)
designRules->met3->type       = "metal"
designRules->met3->layer      = "met3"
designRules->met3->purpose    = "drawing"
designRules->met3->pinlayer   = "met3"
designRules->met3->pinpurpose = "pin"
designRules->met3->minW       = 0.3     ; TDR m3.1
designRules->met3->minSP      = 0.3     ; TDR m3.2
designRules->met3->minOLLviaL = 0.065   ; TDR m3.4
designRules->met3->minOLSviaL = 0.065   ; TDR m3.4
designRules->met3->minOLLviaU = 0.06    ; TDR via3.4
designRules->met3->minOLSviaU = 0.09    ; TDR via3.5
designRules->met3->minresW    = 0.3     ; TDR m3.1
designRules->met3->sheetRho   = 0.047

;--- LAYER "via3"
designRules->via3 = ncons(nil) ; initialize list for layer
designRules->via3->type    = "cut"
designRules->via3->layer   = "via3"
designRules->via3->purpose = "drawing"
designRules->via3->minW    = 0.2
designRules->via3->minSP   = 0.2

;--- LAYER "met4"
designRules->met4 = ncons(nil)
designRules->met4->type       = "metal"
designRules->met4->layer      = "met4"
designRules->met4->purpose    = "drawing"
designRules->met4->pinlayer   = "met4"
designRules->met4->pinpurpose = "pin"
designRules->met4->minW       = 0.3     ; TDR m4.1
designRules->met4->minSP      = 0.3     ; TDR m4.2
designRules->met4->minOLLviaL = 0.065   ; TDR m4.3
designRules->met4->minOLSviaL = 0.065   ; TDR m4.3
designRules->met4->minOLLviaU = 0.19    ; TDR via4.4
designRules->met4->minOLSviaU = 0.19    ; TDR via4.4
designRules->met4->minresW    = 0.3     ; TDR m4.1
designRules->met4->sheetRho   = 0.047

;--- LAYER "via4"
designRules->via4 = ncons(nil) ; initialize list for layer
designRules->via4->type    = "cut"
designRules->via4->layer   = "via4"
designRules->via4->purpose = "drawing"
designRules->via4->minW    = 0.8
designRules->via4->minSP   = 0.8

;--- LAYER "met5"
designRules->met5 = ncons(nil)
designRules->met5->type       = "metal"
designRules->met5->layer      = "met5"
designRules->met5->purpose    = "drawing"
designRules->met5->pinlayer   = "met5"
designRules->met5->pinpurpose = "pin"
designRules->met5->minW       = 1.6     ; TDR m5.1
designRules->met5->minSP      = 1.6     ; TDR m5.2
designRules->met5->minOLLviaL = 0.31    ; TDR m5.3
designRules->met5->minOLSviaL = 0.31    ; TDR m5.3
designRules->met5->minresW    = 1.6     ; TDR m5.1
designRules->met5->sheetRho   = 0.0285

;--- LAYER "capm"
designRules->capm = ncons(nil)
designRules->capm->type           = "define m3m4 mim cap"
designRules->capm->layer          = "capm"
designRules->capm->purpose        = "drawing"
designRules->capm->minW           = 2.0   ; TDR capm.1
designRules->capm->minSP          = 0.84  ; TDR capm.2a
designRules->capm->minBotPlateOL  = 0.14  ; TDR capm.3
designRules->capm->minBotPlateSP  = 1.20  ; TDR capm.2b
designRules->capm->minTopPlateOL  = 0.0
designRules->capm->minTopPlateSP  = 0.3   ; TDR m4.2
designRules->capm->minViaW        = 0.20  ; TDR via3.1 - added as param in case this changes
designRules->capm->minViaSP       = 0.20  ; TDR via3.2 - added as param in case this changes
designRules->capm->minOLvia       = 0.14  ; TDR capm.4
designRules->capm->maxWLratio     = 20.0  ; TDR capm.6

;--- LAYER "cap2m"
designRules->cap2m = ncons(nil)
designRules->cap2m->type           = "define m4m5 mim cap"
designRules->cap2m->layer          = "cap2m"
designRules->cap2m->purpose        = "drawing"
designRules->cap2m->minW           = 2.0   ; TDR capm.1
designRules->cap2m->minSP          = 0.84  ; TDR capm.2a
designRules->cap2m->minBotPlateOL  = 0.14  ; TDR capm.3
designRules->cap2m->minBotPlateSP  = 1.20  ; TDR capm.2b
designRules->cap2m->minTopPlateOL  = 0.0
designRules->cap2m->minTopPlateSP  = 1.6   ; TDR m5.2
designRules->cap2m->minViaW        = 0.80  ; TDR via4.1 - added as param in case this changes
designRules->cap2m->minViaSP       = 0.80  ; TDR via4.2 - added as param in case this changes
designRules->cap2m->minOLvia       = 0.14  ; TDR capm.4
designRules->cap2m->maxWLratio     = 20.0  ; TDR capm.6

;--- LAYER "rpm"
designRules->rpm = ncons(nil)
designRules->rpm->type         = "protect_from_n+_poly_implant"
designRules->rpm->layer        = "rpm"
designRules->rpm->purpose      = "drawing"
designRules->rpm->minW         = 1.27
designRules->rpm->minSP        = 0.84
designRules->rpm->minOLpoly    = 0.20
designRules->rpm->rpmMinSPpoly = 0.20
designRules->rpm->rpmMinSPnsdm = 0.20

;--- LAYER "urpm"
designRules->urpm = ncons(nil)
designRules->urpm->type         = "protect_from_n+_poly_implant"
designRules->urpm->layer        = "urpm"
designRules->urpm->purpose      = "drawing"
designRules->urpm->minW         = 1.27
designRules->urpm->minSP        = 0.84
designRules->urpm->minOLpoly    = 0.20
designRules->urpm->rpmMinSPpoly = 0.20
designRules->urpm->rpmMinSPnsdm = 0.20

;--- LAYER "npc"
designRules->npc = ncons(nil)
designRules->npc->type        = "nitride_poly_cut"
designRules->npc->layer       = "npc"
designRules->npc->purpose     = "drawing"
designRules->npc->minW        = 0.27    ; TDR npc.1
designRules->npc->minSP       = 0.27    ; TDR npc.2
designRules->npc->minSPgate   = 0.09    ; TDR npc.4
designRules->npc->minOLpoly   = 0.095   ; TDR npc.5 - for poly over slotted licon1
designRules->npc->minOLpcont  = 0.10    ; TDR licon.15

;--- LAYER "thkox"
designRules->thkox = ncons(nil)
designRules->thkox->type      = "thick oxide"
designRules->thkox->layer     = "thkox"
designRules->thkox->purpose   = "drawing"
designRules->thkox->minW      = 0.84    ; TDR cntm.1 - need to use this due to boolean goo
designRules->thkox->minSP     = 0.70    ; TDR hvi.2a
designRules->thkox->minOLdiff = 0.18    ; TDR difftap.22
designRules->thkox->minOLtap  = 0.18    ; TDR difftap.22
designRules->thkox->minSPdiff = 0.18    ; TDR difftap.23
designRules->thkox->minSPtap  = 0.18    ; TDR difftap.23

;--- LAYER "hvi" or "5V"
designRules->hvi = ncons(nil)
designRules->hvi->type      = "5V well coding"
designRules->hvi->layer     = "v5"
designRules->hvi->purpose   = "drawing"
;designRules->hvi->minW      = 0.60   ; TDR hvi.1
designRules->hvi->minW      = 0.84    ; TDR cntm.1 - need to use this due to boolean goo
designRules->hvi->minSP     = 0.70    ; TDR hvi.2a
designRules->hvi->minOLdiff = 0.18    ; TDR difftap.22
designRules->hvi->minOLtap  = 0.18    ; TDR difftap.22
designRules->hvi->minSPdiff = 0.18    ; TDR difftap.23
designRules->hvi->minSPtap  = 0.18    ; TDR difftap.23

;--- LAYER "vhvi" or "12V"
designRules->vhvi = ncons(nil)
designRules->vhvi->type       = "12V well coding"
designRules->vhvi->layer      = "v12"
designRules->vhvi->purpose    = "drawing"
;designRules->vhvi->minW       = 0.60    ; TDR vhi.1
designRules->vhvi->minW       = 0.84    ; TDR cntm.1
designRules->vhvi->minSP      = 0.70    ; TDR hvi.2a
designRules->vhvi->minOLdiff  = 0.18    ; TDR difftap.22
designRules->vhvi->minOLtap   = 0.18    ; TDR difftap.22
designRules->vhvi->minSPdiff  = 0.18    ; TDR difftap.23
designRules->vhvi->minSPtap   = 0.18    ; TDR difftap.23

;--- LAYER "uhvi" or "20V"
; NO RULES PROVIDED IN TDR!!
designRules->uhvi = ncons(nil)
designRules->uhvi->type       = "20V well coding"
designRules->uhvi->layer      = "v20"
designRules->uhvi->purpose    = "drawing"
designRules->uhvi->minW       = 0.0
designRules->uhvi->minSP      = 0.0
designRules->uhvi->minOLdiff  = 0.5
designRules->uhvi->minOLtap   = 0.5
designRules->uhvi->minSPdiff  = 0.0
designRules->uhvi->minSPtap   = 0.0

;--- denmos
designRules->denmos = ncons(nil) ; initialize list
designRules->denmos->type           = "Drain Extended Nmos rules"
designRules->denmos->minGateL       = 1.055   ; TDR denmos.1
designRules->denmos->minSrcWnoPoly  = 0.28    ; TDR denmos.2
designRules->denmos->minSrcWpoly    = 0.925   ; TDR denmos.3
designRules->denmos->minDrnW        = 0.17    ; TDR denmos.4
designRules->denmos->srcOLnwell     = 0.225   ; TDR denmos.5
designRules->denmos->srcDrnSP       = 1.585   ; TDR denmos.6
designRules->denmos->minChnW        = 5.0     ; TDR denmos.7
designRules->denmos->nwellBevW      = 0.43    ; TDR denmos.9a
designRules->denmos->drnBevW        = 0.05    ; TDR denmos.9b
designRules->denmos->wellOLdrn      = 0.66    ; TDR denmos.10
designRules->denmos->wellSPtap      = 0.86    ; TDR denmos.11
designRules->denmos->drnNwellSP     = 2.40    ; TDR denmos.12
designRules->denmos->impOLsrc       = 0.13    ; TDR denmos.13

;--- depmos
designRules->depmos = ncons(nil) ; initialize list
designRules->depmos->type           = "Drain Extended Pmos rules"
designRules->depmos->minGateL       = 1.050   ; TDR depmos.1
designRules->depmos->minSrcWnoPoly  = 0.28    ; TDR depmos.2
designRules->depmos->minSrcWpoly    = 0.920   ; TDR depmos.3
designRules->depmos->minDrnW        = 0.17    ; TDR depmos.4
designRules->depmos->srcOLnwell     = 0.260   ; TDR depmos.5
designRules->depmos->srcDrnSP       = 1.19    ; TDR depmos.6
designRules->depmos->minChnW        = 5.0     ; TDR depmos.7
designRules->depmos->nwellBevW      = 0.43    ; TDR depmos.9a
designRules->depmos->drnBevW        = 0.05    ; TDR depmos.9b
designRules->depmos->wellOLdrn      = 0.86    ; TDR depmos.10
designRules->depmos->wellSPtap      = 0.66    ; TDR depmos.11
designRules->depmos->impOLsrc       = 0.13    ; TDR depmos.12

;--- pwres
designRules->pwres = ncons(nil) ; initialize list
designRules->pwres->type        = "Pwell resistor rules"
designRules->pwres->minW        = 2.65    ; TDR pwres.2
designRules->pwres->maxW        = 2.65    ; TDR pwres.2
designRules->pwres->minL        = 26.5    ; TDR pwres.3
designRules->pwres->maxL        = 265.0   ; TDR pwres.4
designRules->pwres->termSPnwell = 0.22    ; TDR pwres.5
designRules->pwres->termW       = 0.53    ; TDR pwres.6

;--- pad
designRules->pad = ncons(nil) ; initialize list
designRules->pad->type        = "Pad rules"
designRules->pad->layer       = "pad"
designRules->pad->purpose     = "drawing"
designRules->pad->pinlayer    = "pad"
designRules->pad->pinpurpose  = "pin"
designRules->pad->minBotMetOL = 0.85    ; TDR m4.16
designRules->pad->minTopMetOL = 2.7     ; TDR pad.4
designRules->pad->minLbevel   = 7.0     ; TDR pad.12
designRules->pad->maxLbevel   = 8.8     ; TDR pad.13
designRules->pad->minModcutOL = 7.5     ; TDR scribe.12

;--- fuse
designRules->fuse = ncons(nil) ; initialize list
designRules->fuse->type        = "Fuse rules"
designRules->fuse->minW        = 0.80    ; TDR mf.1
designRules->fuse->maxW        = 0.80    ; TDR mf.1
designRules->fuse->minL        = 7.20    ; TDR mf.2
designRules->fuse->maxL        = 7.20    ; TDR mf.2
designRules->fuse->termW       = 0.83    ; TDR mf.5
designRules->fuse->shieldMinW  = 0.50    ; TDR mf.12
designRules->fuse->shieldMaxW  = 0.50    ; TDR mf.12
designRules->fuse->shieldMinL  = 2.40    ; TDR mf.12
designRules->fuse->shieldMaxL  = 2.40    ; TDR mf.12
designRules->fuse->shieldMinSP = 1.80    ; TDR mf.13 - 1/2 fuse w
designRules->fuse->shieldMaxSP = 2.90    ; TDR mf.14 - 1/2 fuse w

;--- pwbm
designRules->pwbm = ncons(nil) ; initialize list
designRules->pwbm->type        = "Pwbm rules"
designRules->pwbm->layer       = "pwbm"
designRules->pwbm->purpose     = "drawing"
designRules->pwbm->minW        = 0.84    ; Nothing in TDR, s8 DRC deck pwbm.1
designRules->pwbm->minSP       = 1.27    ; Nothing in TDR, s8 DRC deck pwbm.2
designRules->pwbm->minOLdnwell = 0.50    ; Nothing in TDR, taken from layouts in s8

;--- pwde
designRules->pwde = ncons(nil) ; initialize list
designRules->pwde->type        = "Pwde rules"
designRules->pwde->layer       = "pwde"
designRules->pwde->purpose     = "drawing"
designRules->pwde->minW        = 0.84    ; Nothing in TDR, s8 DRC deck pwde.1
designRules->pwde->minSP       = 1.27    ; Nothing in TDR, s8 DRC deck pwde.2
designRules->pwde->dnwellOL    = 1.00    ; Nothing in TDR, s8 DRC deck pwde.6

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

;-----------------------------------------------------------
/*===  MOSFETS  ===*/
;-----------------------------------------------------------
;; nmos, nmos_esd, nmos_esd_nat_v5, nmos_esd_v5, nmos_lvt, nmos_nat_v3,
;; nmos_nat_v5, nmos_v5, pmos, pmos_esd_v5, pmos_hvt, pmos_lvt, pmos_v5

fetDevices = list() 

;-----------------------------------------------------------
/*===  PFETS  ===*/
;-----------------------------------------------------------

; pmos
;-----------------------------------------------------------
pmos = ncons(nil)
pmos->deviceName = "pmos"
pmos->modelName  = "pmos"
pmos->lvsModel   = "pmos"
pmos->paramCB    = "S130fetCB"
pmos->devInfo    = "Vt=-790mV  Vcc=1.8V"
pmos->native     = nil   ; nil, t
pmos->hv         = nil   ; nil, 3, 5, 12, 20
pmos->vt         = nil   ; nil, "low", "high"
pmos->esd        = nil   ; nil, t
; default/minimum/maximum width/lengths
pmos->fixedWL = list( '("0.42" "0.15") '("0.42" "0.18") '("0.42" "0.5") '("0.42" "1.0") '("0.42" "2.0") '("0.42" "4.0") '("0.42" "8.0") '("0.42" "20.0") '("0.55" "0.5") '("0.55" "1.0") '("0.55" "2.0") '("0.55" "4.0") '("0.55" "8.0") '("0.64" "0.15") '("0.84" "0.15") '("1.0" "0.15") '("1.0" "0.18") '("1.0" "0.25") '("1.0" "0.5") '("1.0" "1.0") '("1.0" "2.0") '("1.0" "4.0") '("1.0" "8.0") '("1.26" "0.15") '("1.68" "0.15") '("3.0" "0.15") '("3.0" "0.18") '("3.0" "0.25") '("3.0" "0.5") '("3.0" "1.0") '("3.0" "2.0") '("3.0" "4.0") '("3.0" "8.0") '("5.0" "0.15") '("5.0" "0.18") '("5.0" "0.25") '("5.0" "0.5") '("5.0" "1.0") '("5.0" "2.0") '("5.0" "4.0") '("5.0" "8.0") '("7.0" "0.15") '("7.0" "0.18") '("7.0" "0.25") '("7.0" "0.5") '("7.0" "1.0") '("7.0" "2.0") '("7.0" "4.0") '("7.0" "8.0"))
pmos->defW = 0.42
pmos->minW = 0.42
pmos->maxW = 7.0
pmos->defL = 0.15
pmos->minL = 0.15
pmos->maxL = 8.0
pmos->defFingerSP = designRules->licon1->minW + 2*designRules->licon1->minDcontSPpoly
pmos->minFingerSP = designRules->licon1->minW + 2*designRules->licon1->minDcontSPpoly
pmos->maxFingerSP = 3.0  ; random number but need a max
; layers needed
pmos->gateLay     = designRules->poly
pmos->diffLay     = designRules->diff
pmos->impLay      = designRules->psdm
pmos->hvLay       = nil
pmos->vtLay       = nil
pmos->mrk1Lay     = nil
pmos->mrk1OLdiff  = 0.0
pmos->nwellLay    = designRules->nwell
pmos->tapImpLay   = designRules->nsdm
pmos->diffRho     = 197.0

fetDevices = append1( fetDevices pmos )

; pmos_v5
;-----------------------------------------------------------
pmos_v5 = ncons(nil)
pmos_v5->deviceName = "pmos_v5"
pmos_v5->modelName  = "pmos_v5"
pmos_v5->lvsModel   = "pmos_v5"
pmos_v5->paramCB    = "S130fetCB"
pmos_v5->devInfo    = "Vt=-961mV  Vcc=5.0V"
pmos_v5->native     = nil     ; nil, t
pmos_v5->hv         = 5     ; nil, 3, 5, 12, 20
pmos_v5->vt         = nil   ; nil, "low", "high"
pmos_v5->esd        = nil   ; nil, t
; default/minimum/maximum width/lengths
pmos_v5->fixedWL = list( '("0.42" "0.5") '("0.42" "0.6") '("0.42" "0.8") '("0.42" "1.0") '("0.42" "2.0") '("0.42" "4.0") '("0.42" "8.0") '("0.42" "20.0") '("0.7" "0.6") '("0.75" "0.5") '("0.75" "0.8") '("0.75" "1.0") '("0.75" "2.0") '("0.75" "4.0") '("1.0" "0.5") '("1.0" "0.6") '("1.0" "0.8") '("1.0" "1.0") '("1.0" "2.0") '("1.0" "4.0") '("1.0" "8.0") '("1.5" "0.5") '("1.5" "1.0") '("1.5" "2.0") '("1.5" "4.0") '("10.0" "0.5") '("15.0" "0.5") '("15.0" "1.0") '("20.0" "0.5") '("20.0" "1.0") '("3.0" "0.5") '("3.0" "0.6") '("3.0" "1.0") '("3.0" "2.0") '("3.0" "4.0") '("3.0" "8.0") '("5.0" "0.5") '("5.0" "0.6") '("5.0" "0.8") '("5.0" "1.0") '("5.0" "2.0") '("5.0" "4.0") '("5.0" "8.0") '("7.0" "0.5") '("7.0" "0.8") '("7.0" "1.0") '("7.0" "2.0") '("7.0" "4.0") '("7.0" "8.0"))
pmos_v5->defW = 0.42
pmos_v5->minW = 0.42
pmos_v5->maxW = 20.0
pmos_v5->defL = 0.50
pmos_v5->minL = 0.50
pmos_v5->maxL = 20.0
pmos_v5->defFingerSP = designRules->licon1->minW + 2*designRules->licon1->minDcontSPpoly
pmos_v5->minFingerSP = designRules->licon1->minW + 2*designRules->licon1->minDcontSPpoly
pmos_v5->maxFingerSP = 3.0  ; random number but need a max
; layers needed
pmos_v5->gateLay     = designRules->poly
pmos_v5->diffLay     = designRules->diff
pmos_v5->impLay      = designRules->psdm
pmos_v5->hvLay       = designRules->thkox
pmos_v5->vtLay       = nil
pmos_v5->mrk1Lay     = nil
pmos_v5->mrk1OLdiff  = 0.0
pmos_v5->nwellLay    = designRules->nwell
pmos_v5->tapImpLay   = designRules->nsdm
pmos_v5->diffRho     = 191.0

fetDevices = append1( fetDevices pmos_v5 )

; pmos_esd_v5
;-----------------------------------------------------------
pmos_esd_v5 = ncons(nil)
pmos_esd_v5->deviceName = "pmos_esd_v5"
pmos_esd_v5->modelName  = "pmos_esd_v5"
pmos_esd_v5->lvsModel   = "pmos_esd_v5"
pmos_esd_v5->paramCB    = "S130fetCB"
pmos_esd_v5->devInfo    = "Vt=-961mV  Vcc=5.0V"
pmos_esd_v5->native     = nil    ; nil, t
pmos_esd_v5->hv         = 5      ; nil, 3, 5, 12, 20
pmos_esd_v5->vt         = nil    ; nil, "low", "high"
pmos_esd_v5->esd        = t      ; nil, t
; default/minimum/maximum width/lengths
pmos_esd_v5->defW = 14.5
pmos_esd_v5->minW = 5.0
pmos_esd_v5->maxW = 26.5
pmos_esd_v5->defL = 0.55
pmos_esd_v5->minL = 0.55
pmos_esd_v5->maxL = 1.0
pmos_esd_v5->defFingerSP = designRules->licon1->minW + 2*designRules->licon1->minDcontSPpoly
pmos_esd_v5->minFingerSP = designRules->licon1->minW + 2*designRules->licon1->minDcontSPpoly
pmos_esd_v5->maxFingerSP = 3.0  ; random number but need a max
; layers needed
pmos_esd_v5->gateLay     = designRules->poly
pmos_esd_v5->diffLay     = designRules->diff
pmos_esd_v5->impLay      = designRules->psdm
pmos_esd_v5->hvLay       = designRules->thkox
pmos_esd_v5->vtLay       = nil
pmos_esd_v5->mrk1Lay     = list("areaid" "esd")
pmos_esd_v5->mrk1OLdiff  = 0.0
pmos_esd_v5->nwellLay    = designRules->nwell
pmos_esd_v5->tapImpLay   = designRules->nsdm
pmos_esd_v5->diffRho     = 191.0

fetDevices = append1( fetDevices pmos_esd_v5 )

; pmos_lvt
;-----------------------------------------------------------
pmos_lvt = ncons(nil)
pmos_lvt->deviceName = "pmos_lvt"
pmos_lvt->modelName  = "pmos_lvt"
pmos_lvt->lvsModel   = "pmos_lvt"
pmos_lvt->paramCB    = "S130fetCB"
pmos_lvt->devInfo    = "Vt=-602mV  Vcc=1.8V"
pmos_lvt->native     = nil   ; nil, t
pmos_lvt->hv         = nil   ; nil, 3, 5, 12, 20
pmos_lvt->vt         = "low" ; nil, "low", "high"
pmos_lvt->esd        = nil   ; nil, t
; default/minimum/maximum width/lengths
pmos_lvt->fixedWL = list( '("0.42" "0.35") '("0.42" "0.5") '("0.42" "1.0") '("0.42" "2.0") '("0.42" "4.0") '("0.42" "8.0") '("0.42" "20.0") '("0.55" "0.35") '("0.55" "0.5") '("0.55" "1.0") '("0.55" "2.0") '("0.55" "4.0") '("0.55" "8.0") '("1.0" "0.35") '("1.0" "0.5") '("1.0" "1.0") '("1.0" "2.0") '("1.0" "4.0") '("1.0" "8.0") '("3.0" "0.35") '("3.0" "0.5") '("3.0" "1.0") '("3.0" "1.5") '("3.0" "2.0") '("3.0" "4.0") '("3.0" "8.0") '("5.0" "0.35") '("5.0" "0.5") '("5.0" "1.0") '("5.0" "1.5") '("5.0" "2.0") '("5.0" "4.0") '("5.0" "8.0") '("7.0" "0.35") '("7.0" "0.5") '("7.0" "1.0") '("7.0" "1.5") '("7.0" "2.0") '("7.0" "4.0") '("7.0" "8.0"))
pmos_lvt->defW = 0.42
pmos_lvt->minW = 0.42
pmos_lvt->maxW = 7.0
pmos_lvt->defL = 0.35
pmos_lvt->minL = 0.35
pmos_lvt->maxL = 8.0
pmos_lvt->defFingerSP = designRules->licon1->minW + 2*designRules->licon1->minDcontSPpoly
pmos_lvt->minFingerSP = designRules->licon1->minW + 2*designRules->licon1->minDcontSPpoly
pmos_lvt->maxFingerSP = 3.0  ; random number but need a max
; layers needed
pmos_lvt->gateLay     = designRules->poly
pmos_lvt->diffLay     = designRules->diff
pmos_lvt->impLay      = designRules->psdm
pmos_lvt->hvLay       = nil
pmos_lvt->vtLay       = designRules->lvtn
pmos_lvt->mrk1Lay     = nil
pmos_lvt->mrk1OLdiff  = 0.0
pmos_lvt->nwellLay    = designRules->nwell
pmos_lvt->tapImpLay   = designRules->nsdm
pmos_lvt->diffRho     = 197.0

fetDevices = append1( fetDevices pmos_lvt )

; pmos_hvt
;-----------------------------------------------------------
pmos_hvt = ncons(nil)
pmos_hvt->deviceName = "pmos_hvt"
pmos_hvt->modelName  = "pmos_hvt"
pmos_hvt->lvsModel   = "pmos_hvt"
pmos_hvt->paramCB    = "S130fetCB"
pmos_hvt->devInfo    = "Vt=-942mV  Vcc=1.8V"
pmos_hvt->native     = nil     ; nil, t
pmos_hvt->hv         = nil     ; nil, 3, 5, 12, 20
pmos_hvt->vt         = "high"  ; nil, "low", "high"
pmos_hvt->esd        = nil     ; nil, t
; default/minimum/maximum width/lengths
pmos_hvt->fixedWL = list( '("0.42" "0.15") '("0.42" "0.18") '("0.42" "0.5") '("0.42" "1.0") '("0.42" "2.0") '("0.42" "4.0") '("0.42" "8.0") '("0.42" "20.0") '("0.55" "0.15") '("0.55" "0.5") '("0.55" "1.0") '("0.55" "2.0") '("0.55" "4.0") '("0.55" "8.0") '("0.64" "0.15") '("0.84" "0.15") '("1.0" "0.15") '("1.0" "0.18") '("1.0" "0.25") '("1.0" "0.5") '("1.0" "1.0") '("1.0" "2.0") '("1.0" "4.0") '("1.0" "8.0") '("1.26" "0.15") '("1.68" "0.15") '("3.0" "0.15") '("3.0" "0.18") '("3.0" "0.25") '("3.0" "0.5") '("3.0" "1.0") '("3.0" "2.0") '("3.0" "4.0") '("3.0" "8.0") '("5.0" "0.15") '("5.0" "0.18") '("5.0" "0.25") '("5.0" "0.5") '("5.0" "1.0") '("5.0" "2.0") '("5.0" "4.0") '("5.0" "8.0") '("7.0" "0.15") '("7.0" "0.18") '("7.0" "0.25") '("7.0" "0.5") '("7.0" "1.0") '("7.0" "2.0") '("7.0" "4.0") '("7.0" "8.0"))
pmos_hvt->defW = 0.42
pmos_hvt->minW = 0.42
pmos_hvt->maxW = 7.0
pmos_hvt->defL = 0.15
pmos_hvt->minL = 0.15
pmos_hvt->maxL = 8.0
pmos_hvt->defFingerSP = designRules->licon1->minW + 2*designRules->licon1->minDcontSPpoly
pmos_hvt->minFingerSP = designRules->licon1->minW + 2*designRules->licon1->minDcontSPpoly
pmos_hvt->maxFingerSP = 3.0  ; random number but need a max
; layers needed
pmos_hvt->gateLay     = designRules->poly
pmos_hvt->diffLay     = designRules->diff
pmos_hvt->impLay      = designRules->psdm
pmos_hvt->hvLay       = nil
pmos_hvt->vtLay       = designRules->hvtp
pmos_hvt->mrk1Lay     = nil
pmos_hvt->mrk1OLdiff  = 0.0
pmos_hvt->nwellLay    = designRules->nwell
pmos_hvt->tapImpLay   = designRules->nsdm
pmos_hvt->diffRho     = 197.0

fetDevices = append1( fetDevices pmos_hvt )

;-----------------------------------------------------------
/*===  NFETS  ===*/
;-----------------------------------------------------------

; nmos
;-----------------------------------------------------------
nmos = ncons(nil)
nmos->deviceName = "nmos"
nmos->modelName  = "nmos"
nmos->lvsModel   = "nmos"
nmos->paramCB    = "S130fetCB"
nmos->devInfo    = "Vt=690mV  Vcc=1.8V"
nmos->native     = nil   ; nil, t
nmos->hv         = nil   ; nil, 3, 5, 12, 20
nmos->vt         = nil   ; nil, "low", "high"
nmos->esd        = nil   ; nil, t
; default/minimum/maximum width/lengths
nmos->fixedWL = list( '("0.42" "0.15") '("0.42" "0.18") '("0.42" "0.5") '("0.42" "1.0") '("0.42" "2.0") '("0.42" "4.0") '("0.42" "8.0") '("0.42" "20.0") '("0.55" "0.15") '("0.55" "0.5") '("0.55" "1.0") '("0.55" "2.0") '("0.55" "4.0") '("0.55" "8.0") '("0.84" "0.15") '("1.0" "0.15") '("1.0" "0.18") '("1.0" "0.25") '("1.0" "0.5") '("1.0" "1.0") '("1.0" "2.0") '("1.0" "4.0") '("1.0" "8.0") '("1.26" "0.15") '("1.68" "0.15") '("2.0" "0.15") '("3.0" "0.15") '("3.0" "0.18") '("3.0" "0.25") '("3.0" "0.5") '("3.0" "1.0") '("3.0" "2.0") '("3.0" "4.0") '("3.0" "8.0") '("5.0" "0.15") '("5.0" "0.18") '("5.0" "0.25") '("5.0" "0.5") '("5.0" "1.0") '("5.0" "2.0") '("5.0" "4.0") '("5.0" "8.0") '("7.0" "0.15") '("7.0" "0.18") '("7.0" "0.25") '("7.0" "0.5") '("7.0" "1.0") '("7.0" "2.0") '("7.0" "4.0") '("7.0" "8.0"))
nmos->defW = 0.42
nmos->minW = 0.42
nmos->maxW = 7.0
nmos->defL = 0.15
nmos->minL = 0.15
nmos->maxL = 8.0
nmos->defFingerSP = designRules->licon1->minW + 2*designRules->licon1->minDcontSPpoly
nmos->minFingerSP = designRules->licon1->minW + 2*designRules->licon1->minDcontSPpoly
nmos->maxFingerSP = 3.0  ; random number but need a max
; layers needed
nmos->gateLay     = designRules->poly
nmos->diffLay     = designRules->diff
nmos->impLay      = designRules->nsdm
nmos->hvLay       = nil
nmos->vtLay       = nil
nmos->mrk1Lay     = nil
nmos->mrk1OLdiff  = 0.0
nmos->nwellLay    = nil
nmos->tapImpLay   = designRules->psdm
nmos->diffRho     = 120.0

fetDevices = append1( fetDevices nmos )

; nmos_v5
;-----------------------------------------------------------
nmos_v5 = ncons(nil)
nmos_v5->deviceName = "nmos_v5"
nmos_v5->modelName  = "nmos_v5"
nmos_v5->lvsModel   = "nmos_v5"
nmos_v5->paramCB    = "S130fetCB"
nmos_v5->devInfo    = "Vt=760mV  Vcc=5.0V"
nmos_v5->native     = nil   ; nil, t
nmos_v5->hv         = 5     ; nil, 3, 5, 12, 20
nmos_v5->vt         = nil   ; nil, "low", "high"
nmos_v5->esd        = nil   ; nil, t
; default/minimum/maximum width/lengths
nmos_v5->fixedWL = list( '("0.42" "0.5") '("0.42" "0.6") '("0.42" "0.8") '("0.42" "1.0") '("0.42" "2.0") '("0.42" "4.0") '("0.42" "8.0") '("0.42" "20.0") '("0.7" "0.6") '("0.75" "0.5") '("0.75" "0.8") '("0.75" "1.0") '("0.75" "2.0") '("0.75" "4.0") '("1.0" "0.5") '("1.0" "0.6") '("1.0" "0.8") '("1.0" "1.0") '("1.0" "2.0") '("1.0" "4.0") '("1.0" "8.0") '("1.5" "0.5") '("1.5" "1.0") '("1.5" "2.0") '("1.5" "4.0") '("10.0" "0.5") '("15.0" "0.5") '("15.0" "1.0") '("20.0" "0.5") '("20.0" "1.0") '("3.0" "0.5") '("3.0" "0.6") '("3.0" "1.0") '("3.0" "2.0") '("3.0" "4.0") '("3.0" "8.0") '("5.0" "0.5") '("5.0" "0.6") '("5.0" "0.8") '("5.0" "1.0") '("5.0" "2.0") '("5.0" "4.0") '("5.0" "8.0") '("7.0" "0.5") '("7.0" "0.8") '("7.0" "1.0") '("7.0" "2.0") '("7.0" "4.0") '("7.0" "8.0"))
nmos_v5->defW = 0.42
nmos_v5->minW = 0.42
nmos_v5->maxW = 20.0
nmos_v5->defL = 0.5
nmos_v5->minL = 0.5
nmos_v5->maxL = 20.0
nmos_v5->defFingerSP = designRules->licon1->minW + 2*designRules->licon1->minDcontSPpoly
nmos_v5->minFingerSP = designRules->licon1->minW + 2*designRules->licon1->minDcontSPpoly
nmos_v5->maxFingerSP = 3.0  ; random number but need a max
; layers needed
nmos_v5->gateLay     = designRules->poly
nmos_v5->diffLay     = designRules->diff
nmos_v5->impLay      = designRules->nsdm
nmos_v5->hvLay       = designRules->thkox
nmos_v5->vtLay       = nil
nmos_v5->mrk1Lay     = nil
nmos_v5->mrk1OLdiff  = 0.0
nmos_v5->nwellLay    = nil
nmos_v5->tapImpLay   = designRules->psdm
nmos_v5->diffRho     = 114.0

fetDevices = append1( fetDevices nmos_v5 )

; nmos_esd
;-----------------------------------------------------------
nmos_esd = ncons(nil)
nmos_esd->deviceName = "nmos_esd"
nmos_esd->modelName  = "nmos_esd"
nmos_esd->lvsModel   = "nmos_esd"
nmos_esd->paramCB    = "S130fetCB"
nmos_esd->devInfo    = "Vt=690mV  Vcc=1.8V"
nmos_esd->native     = nil   ; nil, t
nmos_esd->hv         = nil   ; nil, 3, 5, 12, 20
nmos_esd->vt         = nil   ; nil, "low", "high"
nmos_esd->esd        = t     ; nil, t
; default/minimum/maximum width/lengths
nmos_esd->defW = 20.35
nmos_esd->minW = 20.0
nmos_esd->maxW = 45.0
nmos_esd->defL = 0.165
nmos_esd->minL = 0.15
nmos_esd->maxL = 8.0
nmos_esd->defFingerSP = designRules->licon1->minW + 2*designRules->licon1->minDcontSPpoly
nmos_esd->minFingerSP = designRules->licon1->minW + 2*designRules->licon1->minDcontSPpoly
nmos_esd->maxFingerSP = 3.0  ; random number but need a max
; layers needed
nmos_esd->gateLay     = designRules->poly
nmos_esd->diffLay     = designRules->diff
nmos_esd->impLay      = designRules->nsdm
nmos_esd->hvLay       = nil
nmos_esd->vtLay       = nil
nmos_esd->mrk1Lay     = list("areaid" "esd")
nmos_esd->mrk1OLdiff  = 0.0
nmos_esd->nwellLay    = nil
nmos_esd->tapImpLay   = designRules->psdm
nmos_esd->diffRho     = 120.0

fetDevices = append1( fetDevices nmos_esd )

; nmos_esd_v5
;-----------------------------------------------------------
nmos_esd_v5 = ncons(nil)
nmos_esd_v5->deviceName = "nmos_esd_v5"
nmos_esd_v5->modelName  = "nmos_esd_v5"
nmos_esd_v5->lvsModel   = "nmos_esd_v5"
nmos_esd_v5->paramCB    = "S130fetCB"
nmos_esd_v5->devInfo    = "Vt=760mV  Vcc=5.0V"
nmos_esd_v5->native     = nil   ; nil, t
nmos_esd_v5->hv         = 5     ; nil, 3, 5, 12, 20
nmos_esd_v5->vt         = nil   ; nil, "low", "high"
nmos_esd_v5->esd        = t     ; nil, t
; default/minimum/maximum width/lengths
nmos_esd_v5->defW = 17.5
nmos_esd_v5->minW = 5.4
nmos_esd_v5->maxW = 51.0
nmos_esd_v5->defL = 0.55
nmos_esd_v5->minL = 0.55
nmos_esd_v5->maxL = 1.0
nmos_esd_v5->defFingerSP = designRules->licon1->minW + 2*designRules->licon1->minDcontSPpoly
nmos_esd_v5->minFingerSP = designRules->licon1->minW + 2*designRules->licon1->minDcontSPpoly
nmos_esd_v5->maxFingerSP = 3.0  ; random number but need a max
; layers needed
nmos_esd_v5->gateLay     = designRules->poly
nmos_esd_v5->diffLay     = designRules->diff
nmos_esd_v5->impLay      = designRules->nsdm
nmos_esd_v5->hvLay       = designRules->thkox
nmos_esd_v5->vtLay       = nil
nmos_esd_v5->mrk1Lay     = list("areaid" "esd")
nmos_esd_v5->mrk1OLdiff  = 0.0
nmos_esd_v5->nwellLay    = nil
nmos_esd_v5->tapImpLay   = designRules->psdm
nmos_esd_v5->diffRho     = 114.0

fetDevices = append1( fetDevices nmos_esd_v5 )

; nmos_lvt
;-----------------------------------------------------------
nmos_lvt = ncons(nil)
nmos_lvt->deviceName = "nmos_lvt"
nmos_lvt->modelName  = "nmos_lvt"
nmos_lvt->lvsModel   = "nmos_lvt"
nmos_lvt->paramCB    = "S130fetCB"
nmos_lvt->devInfo    = "Vt=590mV  Vcc=1.8V"
nmos_lvt->native     = nil   ; nil, t
nmos_lvt->hv         = nil   ; nil, 3, 5, 12, 20
nmos_lvt->vt         = "low" ; nil, "low", "high"
nmos_lvt->esd        = nil   ; nil, t
; default/minimum/maximum width/lengths
nmos_lvt->fixedWL = list( '("0.42" "0.15") '("0.42" "0.18") '("0.42" "1.0") '("1.0" "0.15") '("1.0" "0.18") '("1.0" "0.25") '("1.0" "0.5") '("1.0" "1.0") '("1.0" "2.0") '("1.0" "4.0") '("3.0" "0.15") '("3.0" "0.18") '("3.0" "0.25") '("3.0" "0.5") '("3.0" "1.0") '("3.0" "2.0") '("3.0" "4.0") '("5.0" "0.15") '("5.0" "0.18") '("5.0" "0.25") '("5.0" "0.5") '("5.0" "1.0") '("5.0" "2.0") '("5.0" "4.0") '("7.0" "0.15") '("7.0" "0.18") '("7.0" "0.25") '("7.0" "0.5") '("7.0" "1.0") '("7.0" "2.0") '("7.0" "8.0"))
nmos_lvt->defW = 0.42
nmos_lvt->minW = 0.42
nmos_lvt->maxW = 7.0
nmos_lvt->defL = 0.15
nmos_lvt->minL = 0.15
nmos_lvt->maxL = 8.0
nmos_lvt->defFingerSP = designRules->licon1->minW + 2*designRules->licon1->minDcontSPpoly
nmos_lvt->minFingerSP = designRules->licon1->minW + 2*designRules->licon1->minDcontSPpoly
nmos_lvt->maxFingerSP = 3.0  ; random number but need a max
; layers needed
nmos_lvt->gateLay     = designRules->poly
nmos_lvt->diffLay     = designRules->diff
nmos_lvt->impLay      = designRules->nsdm
nmos_lvt->hvLay       = nil
nmos_lvt->vtLay       = designRules->lvtn
nmos_lvt->mrk1Lay     = nil
nmos_lvt->mrk1OLdiff  = 0.0
nmos_lvt->nwellLay    = nil
nmos_lvt->tapImpLay   = designRules->psdm
nmos_lvt->diffRho     = 120.0

fetDevices = append1( fetDevices nmos_lvt )

; nmos_nat_v5
;-----------------------------------------------------------
nmos_nat_v5 = ncons(nil)
nmos_nat_v5->deviceName = "nmos_nat_v5"
nmos_nat_v5->modelName  = "nmos_nat_v5"
nmos_nat_v5->lvsModel   = "nmos_nat_v5"
nmos_nat_v5->paramCB    = "S130fetCB"
nmos_nat_v5->devInfo    = "Vt=18mV  Vcc=5.0V"
nmos_nat_v5->native     = t     ; nil, t
nmos_nat_v5->hv         = 5     ; nil, 3, 5, 12, 20
nmos_nat_v5->vt         = nil   ; nil, "low", "high"
nmos_nat_v5->esd        = nil   ; nil, t
; default/minimum/maximum width/lengths
nmos_nat_v5->fixedWL = list( '("0.42" "0.9") '("0.42" "1.0") '("0.7" "0.9") '("1.0" "0.9") '("1.0" "1.0") '("1.0" "2.0") '("1.0" "4.0") '("1.0" "8.0") '("1.0" "25.0") '("10.0" "0.9") '("10.0" "2.0") '("10.0" "4.0"))
nmos_nat_v5->defW = 0.42
nmos_nat_v5->minW = 0.42
nmos_nat_v5->maxW = 10.0
nmos_nat_v5->defL = 0.90
nmos_nat_v5->minL = 0.90
nmos_nat_v5->maxL = 25.0
nmos_nat_v5->defFingerSP = designRules->licon1->minW + 2*designRules->licon1->minDcontSPpoly
nmos_nat_v5->minFingerSP = designRules->licon1->minW + 2*designRules->licon1->minDcontSPpoly
nmos_nat_v5->maxFingerSP = 3.0  ; random number but need a max
; layers needed
nmos_nat_v5->gateLay     = designRules->poly
nmos_nat_v5->diffLay     = designRules->diff
nmos_nat_v5->impLay      = designRules->nsdm
nmos_nat_v5->hvLay       = designRules->thkox
nmos_nat_v5->vtLay       = designRules->lvtn
nmos_nat_v5->mrk1Lay     = nil
nmos_nat_v5->mrk1OLdiff  = 0.0
nmos_nat_v5->nwellLay    = nil
nmos_nat_v5->tapImpLay   = designRules->psdm
nmos_nat_v5->diffRho     = 114.0

fetDevices = append1( fetDevices nmos_nat_v5 )

; nmos_esd_nat_v5
;-----------------------------------------------------------
nmos_esd_nat_v5 = ncons(nil)
nmos_esd_nat_v5->deviceName = "nmos_esd_nat_v5"
nmos_esd_nat_v5->modelName  = "nmos_esd_nat_v5"
nmos_esd_nat_v5->lvsModel   = "nmos_esd_nat_v5"
nmos_esd_nat_v5->paramCB    = "S130fetCB"
nmos_esd_nat_v5->devInfo    = "Vt=18mV  Vcc=5.0V"
nmos_esd_nat_v5->nativeesd  = t     ; nil, t
nmos_esd_nat_v5->hv         = 5     ; nil, 3, 5, 12, 20
nmos_esd_nat_v5->vt         = nil   ; nil, "low", "high"
nmos_esd_nat_v5->esd        = t     ; nil, t
; default/minimum/maximum width/lengths
nmos_esd_nat_v5->defW = 10.0
nmos_esd_nat_v5->minW = 10.0
nmos_esd_nat_v5->maxW = 10.0
nmos_esd_nat_v5->defL = 0.90
nmos_esd_nat_v5->minL = 0.90
nmos_esd_nat_v5->maxL = 4.0
nmos_esd_nat_v5->defFingerSP = designRules->licon1->minW + 2*designRules->licon1->minDcontSPpoly
nmos_esd_nat_v5->minFingerSP = designRules->licon1->minW + 2*designRules->licon1->minDcontSPpoly
nmos_esd_nat_v5->maxFingerSP = 3.0  ; random number but need a max
; layers needed
nmos_esd_nat_v5->gateLay     = designRules->poly
nmos_esd_nat_v5->diffLay     = designRules->diff
nmos_esd_nat_v5->impLay      = designRules->nsdm
nmos_esd_nat_v5->hvLay       = designRules->thkox
nmos_esd_nat_v5->vtLay       = designRules->lvtn
nmos_esd_nat_v5->mrk1Lay     = list("areaid" "esd")
nmos_esd_nat_v5->mrk1OLdiff  = 0.0
nmos_esd_nat_v5->nwellLay    = nil
nmos_esd_nat_v5->tapImpLay   = designRules->psdm
nmos_esd_nat_v5->diffRho     = 114.0

fetDevices = append1( fetDevices nmos_esd_nat_v5 )

; nmos_nat_v3
;-----------------------------------------------------------
nmos_nat_v3 = ncons(nil)
nmos_nat_v3->deviceName = "nmos_nat_v3"
nmos_nat_v3->modelName  = "nmos_nat_v3"
nmos_nat_v3->lvsModel   = "nmos_nat_v3"
nmos_nat_v3->paramCB    = "S130fetCB"
nmos_nat_v3->devInfo    = "Vt=-86mV  Vcc=3.0V"
nmos_nat_v3->native     = t     ; nil, t
nmos_nat_v3->hv         = 3     ; nil, 3, 5, 12, 20
nmos_nat_v3->vt         = nil   ; nil, "low", "high"
nmos_nat_v3->esd        = nil   ; nil, t
; default/minimum/maximum width/lengths
nmos_nat_v3->fixedWL = list( '("0.42" "0.5") '("0.42" "0.6") '("0.42" "0.8") '("0.7" "0.5") '("0.7" "0.6") '("1.0" "0.5") '("1.0" "0.6") '("4.0" "0.5") '("10.0" "0.5"))
nmos_nat_v3->defW = 0.42
nmos_nat_v3->minW = 0.42
nmos_nat_v3->maxW = 10.0
nmos_nat_v3->defL = 0.50
nmos_nat_v3->minL = 0.50
nmos_nat_v3->maxL = 0.80
nmos_nat_v3->defFingerSP = designRules->licon1->minW + 2*designRules->licon1->minDcontSPpoly
nmos_nat_v3->minFingerSP = designRules->licon1->minW + 2*designRules->licon1->minDcontSPpoly
nmos_nat_v3->maxFingerSP = 3.0  ; random number but need a max
; layers needed
nmos_nat_v3->gateLay     = designRules->poly
nmos_nat_v3->diffLay     = designRules->diff
nmos_nat_v3->impLay      = designRules->nsdm
nmos_nat_v3->hvLay       = designRules->thkox
nmos_nat_v3->vtLay       = designRules->lvtn
nmos_nat_v3->mrk1Lay     = list("areaid" "lvNative")
nmos_nat_v3->mrk1OLdiff  = 0.0
nmos_nat_v3->nwellLay    = nil
nmos_nat_v3->tapImpLay   = designRules->psdm
nmos_nat_v3->diffRho     = 114.0

fetDevices = append1( fetDevices nmos_nat_v3 )


;-----------------------------------------------------------
/*===  DE FETS  ===*/
;-----------------------------------------------------------

;-----------------------------------------------------------
/*===  12V DE FETS  ===*/
;-----------------------------------------------------------
fet12vDevices = list() 

; pmos_de_v12
;-----------------------------------------------------------
pmos_de_v12 = ncons(nil)
pmos_de_v12->deviceName = "pmos_de_v12"
pmos_de_v12->modelName  = "pmos_de_v12"
pmos_de_v12->lvsModel   = "pmos_de_v12"
pmos_de_v12->paramCB    = "S130fet12vCB"
pmos_de_v12->devInfo    = "Vg=5V  Vd=12/16V"
pmos_de_v12->hv         = 12
; default/minimum/maximum width/lengths
pmos_de_v12->fixedWL = list( '("50.0" "0.66") '("50.0" "2.16"))
pmos_de_v12->defW = 50.0
pmos_de_v12->minW = 50.0
pmos_de_v12->maxW = 50.0
pmos_de_v12->defL = 0.66
pmos_de_v12->minL = 0.66
pmos_de_v12->maxL = 2.16
; layers needed
pmos_de_v12->rules       = designRules->depmos
pmos_de_v12->mrkLay      = list("areaid" "extendedDrain")

fet12vDevices = append1( fet12vDevices pmos_de_v12 )

; nmos_de_v12
;-----------------------------------------------------------
nmos_de_v12 = ncons(nil)
nmos_de_v12->deviceName = "nmos_de_v12"
nmos_de_v12->modelName  = "nmos_de_v12"
nmos_de_v12->lvsModel   = "nmos_de_v12"
nmos_de_v12->paramCB    = "S130fet12vCB"
nmos_de_v12->devInfo    = "Vg=5V  Vd=12/16V"
nmos_de_v12->hv         = 12
; default/minimum/maximum width/lengths
nmos_de_v12->fixedWL = list( '("5.0" "0.7") '("5.0" "2.2") '("20.0" "0.7") '("20.0" "2.2") '("50.0" "0.7") '("60.0" "0.7"))
nmos_de_v12->defW = 5.0
nmos_de_v12->minW = 5.0
nmos_de_v12->maxW = 50.0
nmos_de_v12->defL = 0.7
nmos_de_v12->minL = 0.7
nmos_de_v12->maxL = 2.2
; layers needed
nmos_de_v12->rules       = designRules->denmos
nmos_de_v12->mrkLay      = list("areaid" "extendedDrain")

fet12vDevices = append1( fet12vDevices nmos_de_v12 )

;-----------------------------------------------------------
/*===  20V DE FETS  ===*/
;-----------------------------------------------------------
; nmos_de_v20, nmos_de_iso_v20, nmos_de_nat_v20, nmos_de_zvt_v20,
; pmos_de_v20
; THERE ARE NO RULES TO GO BY, ONLY S8 LAYOUTS!
fet20vDevices = list() 

; nmos_de_v20
;-----------------------------------------------------------
nmos_de_v20 = ncons(nil)
nmos_de_v20->deviceName = "nmos_de_v20"
nmos_de_v20->modelName  = "nmos_de_v20"
nmos_de_v20->lvsModel   = "nmos_de_v20"
nmos_de_v20->paramCB    = "S130fet20vCB"
nmos_de_v20->devInfo    = "Vg=5V  Vd=20V"
nmos_de_v20->hv         = 20
nmos_de_v20->mrkLay     = list("areaid" "extendedDrain")
; default/minimum/maximum width/lengths
nmos_de_v20->deffw = 30.0
nmos_de_v20->minfw = 10.0
nmos_de_v20->maxfw = 250.0
nmos_de_v20->defl  = 0.5
nmos_de_v20->minl  = 0.5
nmos_de_v20->maxl  = 0.5
nmos_de_v20->defnf = 2
nmos_de_v20->minnf = 2
nmos_de_v20->maxnf = 20
nmos_de_v20->defm  = 1
nmos_de_v20->minm  = 1
nmos_de_v20->maxm  = 500
nmos_de_v20->gateOLwell = 2.5
nmos_de_v20->gateSPdrn  = 1.5
nmos_de_v20->drnW       = 0.75
nmos_de_v20->drnBevW    = 0.15
nmos_de_v20->drnOLlicon1  = 0.12
nmos_de_v20->srcOLgate    = 1.5
nmos_de_v20->nwellXOLdrn  = 0.05
nmos_de_v20->nwellYOLdrn  = 0.0
nmos_de_v20->dnwellXOLdrn = 3.5
nmos_de_v20->dnwellYOLdrn = 4.0
nmos_de_v20->dnwellBevW   = 0.43
nmos_de_v20->pwbmXOLdnw   = 0.5
nmos_de_v20->pwbmYOLdnw   = 0.5
nmos_de_v20->lvtnXOLdrn   = 4.0
nmos_de_v20->lvtnYOLdrn   = 4.5

fet20vDevices = append1( fet20vDevices nmos_de_v20 )

; nmos_de_nat_v20
;-----------------------------------------------------------
nmos_de_nat_v20 = ncons(nil)
nmos_de_nat_v20->deviceName = "nmos_de_nat_v20"
nmos_de_nat_v20->modelName  = "nmos_de_nat_v20"
nmos_de_nat_v20->lvsModel   = "nmos_de_nat_v20"
nmos_de_nat_v20->paramCB    = "S130fet20vCB"
nmos_de_nat_v20->devInfo    = "Vg=5V  Vd=20V"
nmos_de_nat_v20->hv         = 20
nmos_de_nat_v20->mrkLay     = list("areaid" "extendedDrain")
; default/minimum/maximum width/lengths
nmos_de_nat_v20->deffw = 30.0
nmos_de_nat_v20->minfw = 10.0
nmos_de_nat_v20->maxfw = 250.0
nmos_de_nat_v20->defl  = 0.5
nmos_de_nat_v20->minl  = 0.5
nmos_de_nat_v20->maxl  = 0.5
nmos_de_nat_v20->defnf = 2
nmos_de_nat_v20->minnf = 2
nmos_de_nat_v20->maxnf = 20
nmos_de_nat_v20->defm  = 1
nmos_de_nat_v20->minm  = 1
nmos_de_nat_v20->maxm  = 500
nmos_de_nat_v20->gateOLwell = 2.5
nmos_de_nat_v20->gateSPdrn  = 1.5
nmos_de_nat_v20->drnW       = 0.75
nmos_de_nat_v20->drnBevW    = 0.15
nmos_de_nat_v20->drnOLlicon1  = 0.12
nmos_de_nat_v20->srcOLgate    = 1.5
nmos_de_nat_v20->nwellXOLdrn  = 0.05
nmos_de_nat_v20->nwellYOLdrn  = 0.0
nmos_de_nat_v20->dnwellXOLdrn = 3.5
nmos_de_nat_v20->dnwellYOLdrn = 4.0
nmos_de_nat_v20->dnwellBevW   = 0.43
nmos_de_nat_v20->pwbmXOLdnw   = 0.5
nmos_de_nat_v20->pwbmYOLdnw   = 0.5
nmos_de_nat_v20->lvtnXOLdrn   = 5.16
nmos_de_nat_v20->lvtnYOLdrn   = 5.37

fet20vDevices = append1( fet20vDevices nmos_de_nat_v20 )

; nmos_de_zvt_v20
;-----------------------------------------------------------
nmos_de_zvt_v20 = ncons(nil)
nmos_de_zvt_v20->deviceName = "nmos_de_zvt_v20"
nmos_de_zvt_v20->modelName  = "nmos_de_zvt_v20"
nmos_de_zvt_v20->lvsModel   = "nmos_de_zvt_v20"
nmos_de_zvt_v20->paramCB    = "S130fet20vCB"
nmos_de_zvt_v20->devInfo    = "Vg=5V  Vd=20V"
nmos_de_zvt_v20->hv         = 20
nmos_de_zvt_v20->mrkLay     = list("areaid" "extendedDrain")
; default/minimum/maximum width/lengths
nmos_de_zvt_v20->deffw = 30.0
nmos_de_zvt_v20->minfw = 10.0
nmos_de_zvt_v20->maxfw = 250.0
nmos_de_zvt_v20->defl  = 5.5
nmos_de_zvt_v20->minl  = 5.5
nmos_de_zvt_v20->maxl  = 5.5
nmos_de_zvt_v20->defnf = 2
nmos_de_zvt_v20->minnf = 2
nmos_de_zvt_v20->maxnf = 20
nmos_de_zvt_v20->defm  = 1
nmos_de_zvt_v20->minm  = 1
nmos_de_zvt_v20->maxm  = 500
nmos_de_zvt_v20->gateOLwell = 1.5
nmos_de_zvt_v20->gateSPdrn  = 1.0
nmos_de_zvt_v20->drnW       = 0.75
nmos_de_zvt_v20->drnBevW    = 0.15
nmos_de_zvt_v20->drnOLlicon1  = 0.12
nmos_de_zvt_v20->srcOLgate    = 6.0
nmos_de_zvt_v20->nwellXOLdrn  = 0.05
nmos_de_zvt_v20->nwellYOLdrn  = 0.0
nmos_de_zvt_v20->dnwellXOLdrn = 2.5
nmos_de_zvt_v20->dnwellYOLdrn = 3.0
nmos_de_zvt_v20->dnwellBevW   = 0.43
nmos_de_zvt_v20->pwbmXOLdnw   = 6.0
nmos_de_zvt_v20->pwbmYOLdnw   = 0.5
nmos_de_zvt_v20->lvtnXOLdrn   = 8.5
nmos_de_zvt_v20->lvtnYOLdrn   = 3.5

fet20vDevices = append1( fet20vDevices nmos_de_zvt_v20 )

; nmos_de_iso_v20
;-----------------------------------------------------------
nmos_de_iso_v20 = ncons(nil)
nmos_de_iso_v20->deviceName = "nmos_de_iso_v20"
nmos_de_iso_v20->modelName  = "nmos_de_iso_v20"
nmos_de_iso_v20->lvsModel   = "nmos_de_iso_v20"
nmos_de_iso_v20->paramCB    = "S130fet20vCB"
nmos_de_iso_v20->devInfo    = "Vg=5V  Vd=20V"
nmos_de_iso_v20->hv         = 20
nmos_de_iso_v20->mrkLay     = list("areaid" "extendedDrain")
; default/minimum/maximum width/lengths
nmos_de_iso_v20->deffw = 30.0
nmos_de_iso_v20->minfw = 10.0
nmos_de_iso_v20->maxfw = 250.0
nmos_de_iso_v20->defl  = 0.5
nmos_de_iso_v20->minl  = 0.5
nmos_de_iso_v20->maxl  = 0.5
nmos_de_iso_v20->defnf = 2
nmos_de_iso_v20->minnf = 2
nmos_de_iso_v20->maxnf = 20
nmos_de_iso_v20->defm  = 1
nmos_de_iso_v20->minm  = 1
nmos_de_iso_v20->maxm  = 500
nmos_de_iso_v20->gateOLwell = 2.0
nmos_de_iso_v20->gateSPdrn  = 1.0
nmos_de_iso_v20->drnW       = 1.5
nmos_de_iso_v20->drnBevW    = 0.15
nmos_de_iso_v20->srcOLgate  = 1.5

fet20vDevices = append1( fet20vDevices nmos_de_iso_v20 )

; pmos_de_v20
;-----------------------------------------------------------
pmos_de_v20 = ncons(nil)
pmos_de_v20->deviceName = "pmos_de_v20"
pmos_de_v20->modelName  = "pmos_de_v20"
pmos_de_v20->lvsModel   = "pmos_de_v20"
pmos_de_v20->paramCB    = "S130fet20vCB"
pmos_de_v20->devInfo    = "Vg=5V  Vd=20V"
pmos_de_v20->hv         = 20
pmos_de_v20->mrkLay     = list("areaid" "extendedDrain")
; default/minimum/maximum width/lengths
pmos_de_v20->deffw = 30.0
pmos_de_v20->minfw = 10.0
pmos_de_v20->maxfw = 250.0
pmos_de_v20->defl  = 0.5
pmos_de_v20->minl  = 0.5
pmos_de_v20->maxl  = 0.5
pmos_de_v20->defnf = 2
pmos_de_v20->minnf = 2
pmos_de_v20->maxnf = 20
pmos_de_v20->defm  = 1
pmos_de_v20->minm  = 1
pmos_de_v20->maxm  = 500
pmos_de_v20->gateOLwell = 1.5
pmos_de_v20->gateSPdrn  = 1.0
pmos_de_v20->drnW       = 0.75
pmos_de_v20->drnBevW    = 0.15
pmos_de_v20->srcOLgate  = 1.5

fet20vDevices = append1( fet20vDevices pmos_de_v20 )

;-----------------------------------------------------------
/*===  RESISTORS  ===*/
;-----------------------------------------------------------

;-----------------------------------------------------------
/*===  PWELL RESISTORS  ===*/
;-----------------------------------------------------------
; rpwell
rpwellDevices = list() 

; rpwell
;-----------------------------------------------------------
rpwell = ncons(nil)
rpwell->deviceName = "rpwell"
rpwell->modelName  = "rpwell"
rpwell->lvsModel   = "rpwell"
rpwell->paramCB    = "S130rpwellCB"
; default/minimum/maximum width/lengths
rpwell->defRes     = 33940.9  ; rsh*(l+deltaL)/w
rpwell->defW       = 2.65
rpwell->defL       = 26.5
rpwell->rules      = designRules->pwres
rpwell->mrkLay     = list( "pwell" "res")
rpwell->sheetRho   = 3330   ; not what is documented which is 3050
rpwell->deltaL     = 0.51   ; not documented but is needed to get exact res

rpwellDevices = append1( rpwellDevices rpwell )

;-----------------------------------------------------------
/*===  POLY RESISTORS  ===*/
;-----------------------------------------------------------
rpolyDevices = list() 

; rpoly
;-----------------------------------------------------------
rpoly = ncons(nil)
rpoly->deviceName = "rpoly"
rpoly->modelName  = "rpoly"
rpoly->lvsModel   = "rpoly"
rpoly->paramCB    = "S130resCB"
rpoly->hv         = nil   ; nil, 3, 5, 12, 20
; default/minimum/maximum width/lengths
rpoly->defRes     = 96.4
rpoly->defSegRes  = 96.4
rpoly->defSegSP   = designRules->poly->minSP
rpoly->defW       = 1.00
rpoly->defL       = 2.00
rpoly->minL       = 0.2
rpoly->maxL       = 500.0
rpoly->minW       = designRules->poly->minPresW
rpoly->maxW       = 100.0
rpoly->minSegSP   = designRules->poly->minSP
rpoly->maxSegSP   = 50.0
; layers needed
rpoly->resLay      = designRules->poly
rpoly->impLay      = nil
rpoly->hvLay       = nil
rpoly->npcLay      = designRules->npc
rpoly->mrk1Lay     = list( designRules->poly->layer "res")
rpoly->mrk1OLdiff  = 0.0
rpoly->nwellLay    = nil
rpoly->sheetRho    = 48.2

rpolyDevices = append1( rpolyDevices rpoly )

;-----------------------------------------------------------
/*===  HIGH SHEET RHO/PRECISION POLY RESISTORS  ===*/
;-----------------------------------------------------------
;; rpoly_hp, rpoly_hp2K

hrResDevices = list() 

; rpoly_hp
;-----------------------------------------------------------
rpoly_hp = ncons(nil)
rpoly_hp->deviceName = "rpoly_hp"
rpoly_hp->modelName  = "rpoly_hp"
rpoly_hp->lvsModel   = "rpoly_hp"
rpoly_hp->paramCB    = "S130hrpolyCB"
; default/minimum/maximum width/lengths
rpoly_hp->sheetRho   = 317.3885
rpoly_hp->defRes     = 999.822
rpoly_hp->defSegRes  = 668.102793
rpoly_hp->defHeadRes = 165.85972
rpoly_hp->defSegSP   = 0.21
rpoly_hp->defW       = 1.00
rpoly_hp->defL       = 2.105
rpoly_hp->minL       = 0.50
rpoly_hp->maxL       = 500.0
rpoly_hp->minW       = 0.15
rpoly_hp->maxW       = 100.0
; layers needed
rpoly_hp->resLay      = list("poly"   "drawing")
rpoly_hp->imp1Lay     = list("psdm"   "drawing")
rpoly_hp->imp2Lay     = list("npc"    "drawing")
rpoly_hp->imp3Lay     = list("rpm"    "drawing")
rpoly_hp->mrk1Lay     = list("poly"   "res")
rpoly_hp->nwellLay    = list("nwell"  "drawing")
rpoly_hp->contLay     = list("licon"  "drawing")
rpoly_hp->metLay      = list("li"     "drawing")
rpoly_hp->tapLay      = list("tap"    "drawing")
rpoly_hp->tapNImpLay  = list("nsdm"   "drawing")
rpoly_hp->tapPImpLay  = list("psdm"   "drawing")
rpoly_hp->volt1Lay    = list("poly"   "res")

; device specific rules since it matters on the implant/marking layers
; all implant/marking layers will be based on the overlap of the resistor
; so the values might need to be a calculation of other variables at times
; or take into account the tap layer
rpoly_hp->imp1OLres   = 0.11  ; implant1 overlap resistor
rpoly_hp->imp1MinW    = 0.38  ; implant1 min width
rpoly_hp->imp2OLres   = 0.095 ; implant2 overlap resistor
rpoly_hp->imp2MinW    = 0.27  ; implant2 min width
rpoly_hp->imp3OLres   = 0.20  ; implant3 overlap resistor
rpoly_hp->imp3MinW    = 1.27  ; implant3 min width
; for rpm the foundry said this doesn't really need to be 1.27 like
; docs say so setting it to min pres width + 2* rpm over pres
rpoly_hp->mrk1OLres    = 0.0  ; marking layer 1 overlap resistor
rpoly_hp->tapImpSPImp1 = 0.0  ; tap implant spacing to implant 1
rpoly_hp->tapImpSPImp2 = 0.0  ; tap implant spacing to implant 2
rpoly_hp->tapImpSPImp3 = designRules->rpm->rpmMinSPnsdm  ; tap implant spacing to implant 3

hrResDevices = append1( hrResDevices rpoly_hp )

; rpoly_hp2K
;-----------------------------------------------------------
rpoly_hp2K = ncons(nil)
rpoly_hp2K->deviceName = "rpoly_hp2K"
rpoly_hp2K->modelName  = "rpoly_hp2K"
rpoly_hp2K->lvsModel   = "rpoly_hp2K"
rpoly_hp2K->paramCB    = "S130hrpolyCB"
; default/minimum/maximum width/lengths
rpoly_hp2K->sheetRho   = 2000.00
rpoly_hp2K->defRes     = 4332.00
rpoly_hp2K->defSegRes  = 4000.0
rpoly_hp2K->defHeadRes = 165.85972
rpoly_hp2K->defSegSP   = 0.21
rpoly_hp2K->defW       = 1.00
rpoly_hp2K->defL       = 2.0
rpoly_hp2K->minL       = 0.50
rpoly_hp2K->maxL       = 500.0
rpoly_hp2K->minW       = 0.15
rpoly_hp2K->maxW       = 100.0
; layers needed
rpoly_hp2K->resLay      = list("poly"   "drawing")
rpoly_hp2K->imp1Lay     = list("psdm"   "drawing")
rpoly_hp2K->imp2Lay     = list("npc"    "drawing")
rpoly_hp2K->imp3Lay     = list("urpm"   "drawing")
rpoly_hp2K->mrk1Lay     = list("poly"   "res")
rpoly_hp2K->nwellLay    = list("nwell"  "drawing")
rpoly_hp2K->contLay     = list("licon"  "drawing")
rpoly_hp2K->metLay      = list("li"     "drawing")
rpoly_hp2K->tapLay      = list("tap"    "drawing")
rpoly_hp2K->tapNImpLay  = list("nsdm"   "drawing")
rpoly_hp2K->tapPImpLay  = list("psdm"   "drawing")
rpoly_hp2K->volt1Lay    = list("poly"   "res")

; device specific rules since it matters on the implant/marking layers
; all implant/marking layers will be based on the overlap of the resistor
; so the values might need to be a calculation of other variables at times
; or take into account the tap layer
rpoly_hp2K->imp1OLres   = 0.11  ; implant1 overlap resistor
rpoly_hp2K->imp1MinW    = 0.38  ; implant1 min width
rpoly_hp2K->imp2OLres   = 0.095 ; implant2 overlap resistor
rpoly_hp2K->imp2MinW    = 0.27  ; implant2 min width
rpoly_hp2K->imp3OLres   = 0.20  ; implant3 overlap resistor
rpoly_hp2K->imp3MinW    = 1.27  ; implant3 min width
; for rpm the foundry said this doesn't really need to be 1.27 like
; docs say so setting it to min pres width + 2* rpm over pres
rpoly_hp2K->mrk1OLres    = 0.0  ; marking layer 1 overlap resistor
rpoly_hp2K->tapImpSPImp1 = 0.0  ; tap implant spacing to implant 1
rpoly_hp2K->tapImpSPImp2 = 0.0  ; tap implant spacing to implant 2
rpoly_hp2K->tapImpSPImp3 = designRules->urpm->rpmMinSPnsdm  ; tap implant spacing to implant 3

hrResDevices = append1( hrResDevices rpoly_hp2K )

;-----------------------------------------------------------
/*===  METAL RESISTORS  ===*/
;-----------------------------------------------------------
mResDevices = list() 

; rmet
;-----------------------------------------------------------
rmet = ncons(nil)
rmet->deviceName = "rmet"
rmet->modelNames = list("rli" "rm1" "rm2" "rm3" "rm4" "rm5")
rmet->lvsModels  = list("rli" "rm1" "rm2" "rm3" "rm4" "rm5")
rmet->paramCB    = "S130rmetCB"
; layers needed (layers for this act as rType and must have same order as models)
rmet->layers     = list("li" "met1" "met2" "met3" "met4" "met5")
rmet->mrkPurpose = "res"

mResDevices = append1( mResDevices rmet )

;-----------------------------------------------------------
/*===  DIFF RESISTORS  ===*/
;-----------------------------------------------------------
;; rndiff, rpdiff rndiff_v5, rpdiff_v5
rdiffDevices = list() 

; rndiff
;-----------------------------------------------------------
rndiff = ncons(nil)
rndiff->deviceName = "rndiff"
rndiff->modelName  = "rndiff"
rndiff->lvsModel   = "rndiff"
rndiff->paramCB    = "S130resCB"
rndiff->hv         = nil   ; nil, 3, 5, 12, 20
; default/minimum/maximum width/lengths
rndiff->defRes     = 240.0
rndiff->defSegRes  = 240.0
rndiff->defSegSP   = designRules->diff->minSP
rndiff->defW       = 1.00
rndiff->defL       = 2.00
rndiff->minL       = 0.20
rndiff->maxL       = 500.0
rndiff->minW       = designRules->licon1->minW + 2*designRules->diff->minOLSlicon1
rndiff->maxW       = 100.0
rndiff->minSegSP   = designRules->diff->minSP
rndiff->maxSegSP   = 50.0
; layers needed
rndiff->resLay      = designRules->diff
rndiff->impLay      = designRules->nsdm
rndiff->hvLay       = nil
rndiff->npcLay      = nil
rndiff->mrk1Lay     = list( designRules->diff->layer "res")
rndiff->mrk1OLdiff  = 0.0
rndiff->nwellLay    = nil
rndiff->sheetRho    = 120.0

rdiffDevices = append1( rdiffDevices rndiff )

; rndiff_v5
;-----------------------------------------------------------
rndiff_v5 = ncons(nil)
rndiff_v5->deviceName = "rndiff_v5"
rndiff_v5->modelName  = "rndiff_v5"
rndiff_v5->lvsModel   = "rndiff_v5"
rndiff_v5->paramCB    = "S130resCB"
rndiff_v5->hv         = 5   ; nil, 3, 5, 12, 20
; default/minimum/maximum width/lengths
rndiff_v5->defRes     = 228.0
rndiff_v5->defSegRes  = 228.0
rndiff_v5->defSegSP   = designRules->diff->minSPhv
rndiff_v5->defW       = 1.00
rndiff_v5->defL       = 2.00
rndiff_v5->minL       = 0.20
rndiff_v5->maxL       = 500.0
rndiff_v5->minW       = designRules->licon1->minW + 2*designRules->diff->minOLSlicon1
rndiff_v5->maxW       = 100.0
rndiff_v5->minSegSP   = designRules->diff->minSPhv
rndiff_v5->maxSegSP   = 50.0
; layers needed
rndiff_v5->resLay      = designRules->diff
rndiff_v5->impLay      = designRules->nsdm
rndiff_v5->hvLay       = designRules->thkox
rndiff_v5->npcLay      = nil
rndiff_v5->mrk1Lay     = list( designRules->diff->layer "res")
rndiff_v5->mrk1OLdiff  = 0.0
rndiff_v5->nwellLay    = nil
rndiff_v5->sheetRho    = 114.0

rdiffDevices = append1( rdiffDevices rndiff_v5 )

; rpdiff
;-----------------------------------------------------------
rpdiff = ncons(nil)
rpdiff->deviceName = "rpdiff"
rpdiff->modelName  = "rpdiff"
rpdiff->lvsModel   = "rpdiff"
rpdiff->paramCB    = "S130resCB"
rpdiff->hv         = nil   ; nil, 3, 5, 12, 20
; default/minimum/maximum width/lengths
rpdiff->defRes     = 394.0
rpdiff->defSegRes  = 394.0
rpdiff->defSegSP   = designRules->diff->minSP
rpdiff->defW       = 1.00
rpdiff->defL       = 2.00
rpdiff->minL       = 0.20
rpdiff->maxL       = 500.0
rpdiff->minW       = designRules->licon1->minW + 2*designRules->diff->minOLSlicon1
rpdiff->maxW       = 100.0
rpdiff->minSegSP   = designRules->diff->minSP
rpdiff->maxSegSP   = 50.0
; layers needed
rpdiff->resLay      = designRules->diff
rpdiff->impLay      = designRules->psdm
rpdiff->hvLay       = nil
rpdiff->npcLay      = nil
rpdiff->mrk1Lay     = list( designRules->diff->layer "res")
rpdiff->mrk1OLdiff  = 0.0
rpdiff->nwellLay    = designRules->nwell
rpdiff->tapImpLay   = designRules->nsdm
rpdiff->sheetRho    = 197.0

rdiffDevices = append1( rdiffDevices rpdiff )

; rpdiff_v5
;-----------------------------------------------------------
rpdiff_v5 = ncons(nil)
rpdiff_v5->deviceName = "rpdiff_v5"
rpdiff_v5->modelName  = "rpdiff_v5"
rpdiff_v5->lvsModel   = "rpdiff_v5"
rpdiff_v5->paramCB    = "S130resCB"
rpdiff_v5->hv         = 5   ; nil, 3, 5, 12, 20
; default/minimum/maximum width/lengths
rpdiff_v5->defRes     = 382.0
rpdiff_v5->defSegRes  = 382.0
rpdiff_v5->defSegSP   = designRules->diff->minSPhv
rpdiff_v5->defW       = 1.00
rpdiff_v5->defL       = 2.00
rpdiff_v5->minL       = 0.20
rpdiff_v5->maxL       = 500.0
rpdiff_v5->minW       = designRules->licon1->minW + 2*designRules->diff->minOLSlicon1
rpdiff_v5->maxW       = 100.0
rpdiff_v5->minSegSP   = designRules->diff->minSPhv
rpdiff_v5->maxSegSP   = 50.0
; layers needed
rpdiff_v5->resLay      = designRules->diff
rpdiff_v5->impLay      = designRules->psdm
rpdiff_v5->hvLay       = designRules->thkox
rpdiff_v5->npcLay      = nil
rpdiff_v5->mrk1Lay     = list( designRules->diff->layer "res")
rpdiff_v5->mrk1OLdiff  = 0.0
rpdiff_v5->nwellLay    = designRules->nwell
rpdiff_v5->tapImpLay   = designRules->nsdm
rpdiff_v5->sheetRho    = 191.0

rdiffDevices = append1( rdiffDevices rpdiff_v5 )

;-----------------------------------------------------------
/*===  DIODES  ===*/
;-----------------------------------------------------------
;; ddnw_sub, ddnw_sub_v5, ddnw_sub_v12, ddnw_sub_v20,
;; dipw_dnw, dipw_dnw_v5, dipw_dnw_v12, dipw_dnw_v20,
;; dpsd_nw, dpsd_nw_esd, dpsd_nw_esd_v5, dpsd_nw_hvt, dpsd_nw_lvt, dpsd_nw_v5,
;; dnsd_pw, dnsd_pw_esd, dnsd_pw_esd_v5, dnsd_pw_lvt, dnsd_pw_nat, dnsd_pw_v5

;-----------------------------------------------------------
/*===  WELL DIODES  ===*/
;-----------------------------------------------------------
welldioDevices = list() 

; ddnw_sub
;-----------------------------------------------------------
ddnw_sub = ncons(nil)
ddnw_sub->deviceName  = "ddnw_sub"
ddnw_sub->modelName   = "ddnw_sub"
ddnw_sub->lvsModel    = "ddnw_sub"
ddnw_sub->paramCB     = "S130welldioCB"
ddnw_sub->symbols     = t           ; create symbol views
ddnw_sub->layout      = nil         ; create layout view
ddnw_sub->devInfo     = "Vcc=16.0V"
ddnw_sub->native      = nil         ; nil, t
ddnw_sub->hv          = nil         ; nil, 3, 5, 12, 20
ddnw_sub->vt          = nil         ; nil, "low", "high"
ddnw_sub->esd         = nil         ; nil, t
; default/minimum/maximum width/lengths
ddnw_sub->defW = designRules->dnwell->minW
ddnw_sub->minW = designRules->dnwell->minW
ddnw_sub->maxW = 1e5
ddnw_sub->defL = designRules->dnwell->minW
ddnw_sub->minL = designRules->dnwell->minW
ddnw_sub->maxL = 1e5

welldioDevices = append1( welldioDevices ddnw_sub )

; ddnw_sub_v5
;-----------------------------------------------------------
ddnw_sub_v5 = ncons(nil)
ddnw_sub_v5->deviceName  = "ddnw_sub_v5"
ddnw_sub_v5->modelName   = "ddnw_sub"
ddnw_sub_v5->lvsModel    = "ddnw_sub_v5"
ddnw_sub_v5->paramCB     = "S130welldioCB"
ddnw_sub_v5->symbols     = t           ; create symbol views
ddnw_sub_v5->layout      = nil         ; create layout view
ddnw_sub_v5->devInfo     = "Vcc=16.0V"
ddnw_sub_v5->native      = nil         ; nil, t
ddnw_sub_v5->hv          = 5           ; nil, 3, 5, 12, 20
ddnw_sub_v5->vt          = nil         ; nil, "low", "high"
ddnw_sub_v5->esd         = nil         ; nil, t
; default/minimum/maximum width/lengths
ddnw_sub_v5->defW = designRules->dnwell->minW
ddnw_sub_v5->minW = designRules->dnwell->minW
ddnw_sub_v5->maxW = 1e5
ddnw_sub_v5->defL = designRules->dnwell->minW
ddnw_sub_v5->minL = designRules->dnwell->minW
ddnw_sub_v5->maxL = 1e5

welldioDevices = append1( welldioDevices ddnw_sub_v5 )

; ddnw_sub_v12
;-----------------------------------------------------------
ddnw_sub_v12 = ncons(nil)
ddnw_sub_v12->deviceName  = "ddnw_sub_v12"
ddnw_sub_v12->modelName   = "ddnw_sub"
ddnw_sub_v12->lvsModel    = "ddnw_sub_v12"
ddnw_sub_v12->paramCB     = "S130welldioCB"
ddnw_sub_v12->symbols     = t           ; create symbol views
ddnw_sub_v12->layout      = nil         ; create layout view
ddnw_sub_v12->devInfo     = "Vcc=16.0V"
ddnw_sub_v12->native      = nil         ; nil, t
ddnw_sub_v12->hv          = 12          ; nil, 3, 5, 12, 20
ddnw_sub_v12->vt          = nil         ; nil, "low", "high"
ddnw_sub_v12->esd         = nil         ; nil, t
; default/minimum/maximum width/lengths
ddnw_sub_v12->defW = designRules->dnwell->minW
ddnw_sub_v12->minW = designRules->dnwell->minW
ddnw_sub_v12->maxW = 1e5
ddnw_sub_v12->defL = designRules->dnwell->minW
ddnw_sub_v12->minL = designRules->dnwell->minW
ddnw_sub_v12->maxL = 1e5

welldioDevices = append1( welldioDevices ddnw_sub_v12 )

; ddnw_sub_v20
;-----------------------------------------------------------
ddnw_sub_v20 = ncons(nil)
ddnw_sub_v20->deviceName  = "ddnw_sub_v20"
ddnw_sub_v20->modelName   = "ddnw_sub"
ddnw_sub_v20->lvsModel    = "ddnw_sub_v20"
ddnw_sub_v20->paramCB     = "S130welldioCB"
ddnw_sub_v20->symbols     = t           ; create symbol views
ddnw_sub_v20->layout      = nil         ; create layout view
ddnw_sub_v20->devInfo     = "Vcc=16.0V"
ddnw_sub_v20->native      = nil         ; nil, t
ddnw_sub_v20->hv          = 20          ; nil, 3, 5, 12, 20
ddnw_sub_v20->vt          = nil         ; nil, "low", "high"
ddnw_sub_v20->esd         = nil         ; nil, t
; default/minimum/maximum width/lengths
ddnw_sub_v20->defW = designRules->dnwell->minW
ddnw_sub_v20->minW = designRules->dnwell->minW
ddnw_sub_v20->maxW = 1e5
ddnw_sub_v20->defL = designRules->dnwell->minW
ddnw_sub_v20->minL = designRules->dnwell->minW
ddnw_sub_v20->maxL = 1e5

welldioDevices = append1( welldioDevices ddnw_sub_v20 )

; dipw_dnw
;-----------------------------------------------------------
dipw_dnw = ncons(nil)
dipw_dnw->deviceName  = "dipw_dnw"
dipw_dnw->modelName   = "dipw_dnw"
dipw_dnw->lvsModel    = "dipw_dnw"
dipw_dnw->paramCB     = "S130welldioCB"
dipw_dnw->symbols     = t           ; create symbol views
dipw_dnw->layout      = nil         ; create layout view
dipw_dnw->devInfo     = "Vcc=16.0V"
dipw_dnw->native      = nil         ; nil, t
dipw_dnw->hv          = nil         ; nil, 3, 5, 12, 20
dipw_dnw->vt          = nil         ; nil, "low", "high"
dipw_dnw->esd         = nil         ; nil, t
; default/minimum/maximum width/lengths
dipw_dnw->defW = designRules->nwell->minSP
dipw_dnw->minW = designRules->nwell->minSP
dipw_dnw->maxW = 1e5
dipw_dnw->defL = designRules->nwell->minSP
dipw_dnw->minL = designRules->nwell->minSP
dipw_dnw->maxL = 1e5

welldioDevices = append1( welldioDevices dipw_dnw )

; dipw_dnw_v5
;-----------------------------------------------------------
dipw_dnw_v5 = ncons(nil)
dipw_dnw_v5->deviceName  = "dipw_dnw_v5"
dipw_dnw_v5->modelName   = "dipw_dnw"
dipw_dnw_v5->lvsModel    = "dipw_dnw_v5"
dipw_dnw_v5->paramCB     = "S130welldioCB"
dipw_dnw_v5->symbols     = t           ; create symbol views
dipw_dnw_v5->layout      = nil         ; create layout view
dipw_dnw_v5->devInfo     = "Vcc=16.0V"
dipw_dnw_v5->native      = nil         ; nil, t
dipw_dnw_v5->hv          = 5           ; nil, 3, 5, 12, 20
dipw_dnw_v5->vt          = nil         ; nil, "low", "high"
dipw_dnw_v5->esd         = nil         ; nil, t
; default/minimum/maximum width/lengths
dipw_dnw_v5->defW = designRules->nwell->minSP
dipw_dnw_v5->minW = designRules->nwell->minSP
dipw_dnw_v5->maxW = 1e5
dipw_dnw_v5->defL = designRules->nwell->minSP
dipw_dnw_v5->minL = designRules->nwell->minSP
dipw_dnw_v5->maxL = 1e5

welldioDevices = append1( welldioDevices dipw_dnw_v5 )

; dipw_dnw_v12
;-----------------------------------------------------------
dipw_dnw_v12 = ncons(nil)
dipw_dnw_v12->deviceName  = "dipw_dnw_v12"
dipw_dnw_v12->modelName   = "dipw_dnw"
dipw_dnw_v12->lvsModel    = "dipw_dnw_v12"
dipw_dnw_v12->paramCB     = "S130welldioCB"
dipw_dnw_v12->symbols     = t           ; create symbol views
dipw_dnw_v12->layout      = nil         ; create layout view
dipw_dnw_v12->devInfo     = "Vcc=16.0V"
dipw_dnw_v12->native      = nil         ; nil, t
dipw_dnw_v12->hv          = 12          ; nil, 3, 5, 12, 20
dipw_dnw_v12->vt          = nil         ; nil, "low", "high"
dipw_dnw_v12->esd         = nil         ; nil, t
; default/minimum/maximum width/lengths
dipw_dnw_v12->defW = designRules->nwell->minSP
dipw_dnw_v12->minW = designRules->nwell->minSP
dipw_dnw_v12->maxW = 1e5
dipw_dnw_v12->defL = designRules->nwell->minSP
dipw_dnw_v12->minL = designRules->nwell->minSP
dipw_dnw_v12->maxL = 1e5

welldioDevices = append1( welldioDevices dipw_dnw_v12 )

; dipw_dnw_v20
;-----------------------------------------------------------
dipw_dnw_v20 = ncons(nil)
dipw_dnw_v20->deviceName  = "dipw_dnw_v20"
dipw_dnw_v20->modelName   = "dipw_dnw"
dipw_dnw_v20->lvsModel    = "dipw_dnw_v20"
dipw_dnw_v20->paramCB     = "S130welldioCB"
dipw_dnw_v20->symbols     = t           ; create symbol views
dipw_dnw_v20->layout      = nil         ; create layout view
dipw_dnw_v20->devInfo     = "Vcc=16.0V"
dipw_dnw_v20->native      = nil         ; nil, t
dipw_dnw_v20->hv          = 20          ; nil, 3, 5, 12, 20
dipw_dnw_v20->vt          = nil         ; nil, "low", "high"
dipw_dnw_v20->esd         = nil         ; nil, t
; default/minimum/maximum width/lengths
dipw_dnw_v20->defW = designRules->nwell->minSP
dipw_dnw_v20->minW = designRules->nwell->minSP
dipw_dnw_v20->maxW = 1e5
dipw_dnw_v20->defL = designRules->nwell->minSP
dipw_dnw_v20->minL = designRules->nwell->minSP
dipw_dnw_v20->maxL = 1e5

welldioDevices = append1( welldioDevices dipw_dnw_v20 )

;-----------------------------------------------------------
/*===  DIFFUSION DIODES  ===*/
;-----------------------------------------------------------
dioDevices = list() 

; dpsd_nw
;-----------------------------------------------------------
dpsd_nw = ncons(nil)
dpsd_nw->deviceName  = "dpsd_nw"
dpsd_nw->modelName   = "dpsd_nw"
dpsd_nw->lvsModel    = "dpsd_nw"
dpsd_nw->paramCB     = "S130dioCB"
dpsd_nw->symbols     = t           ; create symbol views
dpsd_nw->layout      = t           ; create layout view
dpsd_nw->devInfo     = "Vcc=5.5V"
dpsd_nw->native      = nil         ; nil, t
dpsd_nw->hv          = nil         ; nil, 3, 5, 12, 20
dpsd_nw->vt          = nil         ; nil, "low", "high"
dpsd_nw->esd         = nil         ; nil, t
; default/minimum/maximum width/lengths
dpsd_nw->defW = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dpsd_nw->minW = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dpsd_nw->maxW = 250.0
dpsd_nw->defL = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dpsd_nw->minL = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dpsd_nw->maxL = 250.0
; layers needed
dpsd_nw->diffLay     = designRules->diff
dpsd_nw->impLay      = designRules->psdm
dpsd_nw->hvLay       = nil
dpsd_nw->vtLay       = nil
dpsd_nw->esdLay      = nil
dpsd_nw->nwellLay    = designRules->nwell
dpsd_nw->tapImpLay   = designRules->nsdm
dpsd_nw->mrk1Lay     = list("areaid" "diode")
dpsd_nw->mrk2Lay     = nil
dpsd_nw->mrk1OLdiff  = 0.0
dpsd_nw->mrk2OLdiff  = 0.0

dioDevices = append1( dioDevices dpsd_nw )

; dpsd_nw_esd
;-----------------------------------------------------------
dpsd_nw_esd = ncons(nil)
dpsd_nw_esd->deviceName  = "dpsd_nw_esd"
dpsd_nw_esd->modelName   = "dpsd_nw_esd"
dpsd_nw_esd->lvsModel    = "dpsd_nw_esd"
dpsd_nw_esd->paramCB     = "S130dioCB"
dpsd_nw_esd->symbols     = t           ; create symbol views
dpsd_nw_esd->layout      = t           ; create layout view
dpsd_nw_esd->devInfo     = "Vcc=5.5V"
dpsd_nw_esd->native      = nil         ; nil, t
dpsd_nw_esd->hv          = nil         ; nil, 3, 5, 12, 20
dpsd_nw_esd->vt          = nil         ; nil, "low", "high"
dpsd_nw_esd->esd         = t           ; nil, t
; default/minimum/maximum width/lengths
dpsd_nw_esd->defW = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dpsd_nw_esd->minW = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dpsd_nw_esd->maxW = 250.0
dpsd_nw_esd->defL = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dpsd_nw_esd->minL = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dpsd_nw_esd->maxL = 250.0
; layers needed
dpsd_nw_esd->diffLay     = designRules->diff
dpsd_nw_esd->impLay      = designRules->psdm
dpsd_nw_esd->hvLay       = nil
dpsd_nw_esd->vtLay       = nil
dpsd_nw_esd->esdLay      = list("areaid" "esd")
dpsd_nw_esd->mrk1Lay     = list("areaid" "diode")
dpsd_nw_esd->mrk2Lay     = nil
dpsd_nw_esd->mrk1OLdiff  = 0.0
dpsd_nw_esd->mrk2OLdiff  = 0.0
dpsd_nw_esd->nwellLay    = designRules->nwell
dpsd_nw_esd->tapImpLay   = designRules->nsdm

dioDevices = append1( dioDevices dpsd_nw_esd )

; dpsd_nw_esd_v5
;-----------------------------------------------------------
dpsd_nw_esd_v5 = ncons(nil)
dpsd_nw_esd_v5->deviceName  = "dpsd_nw_esd_v5"
dpsd_nw_esd_v5->modelName   = "dpsd_nw_esd_v5"
dpsd_nw_esd_v5->lvsModel    = "dpsd_nw_esd_v5"
dpsd_nw_esd_v5->paramCB     = "S130dioCB"
dpsd_nw_esd_v5->symbols     = t           ; create symbol views
dpsd_nw_esd_v5->layout      = t           ; create layout view
dpsd_nw_esd_v5->devInfo     = "Vcc=11.0V"
dpsd_nw_esd_v5->native      = nil         ; nil, t
dpsd_nw_esd_v5->hv          = 5           ; nil, 3, 5, 12, 20
dpsd_nw_esd_v5->vt          = nil         ; nil, "low", "high"
dpsd_nw_esd_v5->esd         = t           ; nil, t
; default/minimum/maximum width/lengths
dpsd_nw_esd_v5->defW = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dpsd_nw_esd_v5->minW = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dpsd_nw_esd_v5->maxW = 250.0
dpsd_nw_esd_v5->defL = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dpsd_nw_esd_v5->minL = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dpsd_nw_esd_v5->maxL = 250.0
; layers needed
dpsd_nw_esd_v5->diffLay     = designRules->diff
dpsd_nw_esd_v5->impLay      = designRules->psdm
dpsd_nw_esd_v5->hvLay       = designRules->thkox
dpsd_nw_esd_v5->vtLay       = nil
dpsd_nw_esd_v5->esdLay      = list("areaid" "esd")
dpsd_nw_esd_v5->mrk1Lay     = list("areaid" "diode")
dpsd_nw_esd_v5->mrk2Lay     = nil
dpsd_nw_esd_v5->mrk1OLdiff  = 0.0
dpsd_nw_esd_v5->mrk2OLdiff  = 0.0
dpsd_nw_esd_v5->nwellLay    = designRules->nwell
dpsd_nw_esd_v5->tapImpLay   = designRules->nsdm

dioDevices = append1( dioDevices dpsd_nw_esd_v5 )

; dpsd_nw_hvt
;-----------------------------------------------------------
dpsd_nw_hvt = ncons(nil)
dpsd_nw_hvt->deviceName  = "dpsd_nw_hvt"
dpsd_nw_hvt->modelName   = "dpsd_nw_hvt"
dpsd_nw_hvt->lvsModel    = "dpsd_nw_hvt"
dpsd_nw_hvt->paramCB     = "S130dioCB"
dpsd_nw_hvt->symbols     = t           ; create symbol views
dpsd_nw_hvt->layout      = t           ; create layout view
dpsd_nw_hvt->devInfo     = "Vcc=5.5V"
dpsd_nw_hvt->native      = nil         ; nil, t
dpsd_nw_hvt->hv          = nil         ; nil, 3, 5, 12, 20
dpsd_nw_hvt->vt          = "high"      ; nil, "low", "high"
dpsd_nw_hvt->esd         = nil         ; nil, t
; default/minimum/maximum width/lengths
dpsd_nw_hvt->defW = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dpsd_nw_hvt->minW = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dpsd_nw_hvt->maxW = 250.0
dpsd_nw_hvt->defL = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dpsd_nw_hvt->minL = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dpsd_nw_hvt->maxL = 250.0
; layers needed
dpsd_nw_hvt->diffLay     = designRules->diff
dpsd_nw_hvt->impLay      = designRules->psdm
dpsd_nw_hvt->hvLay       = nil
dpsd_nw_hvt->vtLay       = designRules->hvtp
dpsd_nw_hvt->esdLay      = nil
dpsd_nw_hvt->mrk1Lay     = list("areaid" "diode")
dpsd_nw_hvt->mrk2Lay     = nil
dpsd_nw_hvt->mrk1OLdiff  = 0.0
dpsd_nw_hvt->mrk2OLdiff  = 0.0
dpsd_nw_hvt->nwellLay    = designRules->nwell
dpsd_nw_hvt->tapImpLay   = designRules->nsdm

dioDevices = append1( dioDevices dpsd_nw_hvt )

; dpsd_nw_lvt
;-----------------------------------------------------------
dpsd_nw_lvt = ncons(nil)
dpsd_nw_lvt->deviceName  = "dpsd_nw_lvt"
dpsd_nw_lvt->modelName   = "dpsd_nw_lvt"
dpsd_nw_lvt->lvsModel    = "dpsd_nw_lvt"
dpsd_nw_lvt->paramCB     = "S130dioCB"
dpsd_nw_lvt->symbols     = t           ; create symbol views
dpsd_nw_lvt->layout      = t           ; create layout view
dpsd_nw_lvt->devInfo     = "Vcc=5.5V"
dpsd_nw_lvt->native      = nil         ; nil, t
dpsd_nw_lvt->hv          = nil         ; nil, 3, 5, 12, 20
dpsd_nw_lvt->vt          = "low"       ; nil, "low", "high"
dpsd_nw_lvt->esd         = nil         ; nil, t
; default/minimum/maximum width/lengths
dpsd_nw_lvt->defW = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dpsd_nw_lvt->minW = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dpsd_nw_lvt->maxW = 250.0
dpsd_nw_lvt->defL = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dpsd_nw_lvt->minL = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dpsd_nw_lvt->maxL = 250.0
; layers needed
dpsd_nw_lvt->diffLay     = designRules->diff
dpsd_nw_lvt->impLay      = designRules->psdm
dpsd_nw_lvt->hvLay       = nil
dpsd_nw_lvt->vtLay       = designRules->lvtn
dpsd_nw_lvt->esdLay      = nil
dpsd_nw_lvt->mrk1Lay     = list("areaid" "diode")
dpsd_nw_lvt->mrk2Lay     = nil
dpsd_nw_lvt->mrk1OLdiff  = 0.0
dpsd_nw_lvt->mrk2OLdiff  = 0.0
dpsd_nw_lvt->nwellLay    = designRules->nwell
dpsd_nw_lvt->tapImpLay   = designRules->nsdm

dioDevices = append1( dioDevices dpsd_nw_lvt )

; dpsd_nw_v5
;-----------------------------------------------------------
dpsd_nw_v5 = ncons(nil)
dpsd_nw_v5->deviceName  = "dpsd_nw_v5"
dpsd_nw_v5->modelName   = "dpsd_nw_v5"
dpsd_nw_v5->lvsModel    = "dpsd_nw_v5"
dpsd_nw_v5->paramCB     = "S130dioCB"
dpsd_nw_v5->symbols     = t           ; create symbol views
dpsd_nw_v5->layout      = t           ; create layout view
dpsd_nw_v5->devInfo     = "Vcc=11.0V"
dpsd_nw_v5->native      = nil         ; nil, t
dpsd_nw_v5->hv          = 5           ; nil, 3, 5, 12, 20
dpsd_nw_v5->vt          = nil         ; nil, "low", "high"
dpsd_nw_v5->esd         = nil         ; nil, t
; default/minimum/maximum width/lengths
dpsd_nw_v5->defW = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dpsd_nw_v5->minW = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dpsd_nw_v5->maxW = 250.0
dpsd_nw_v5->defL = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dpsd_nw_v5->minL = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dpsd_nw_v5->maxL = 250.0
; layers needed
dpsd_nw_v5->diffLay     = designRules->diff
dpsd_nw_v5->impLay      = designRules->psdm
dpsd_nw_v5->hvLay       = designRules->thkox
dpsd_nw_v5->vtLay       = nil
dpsd_nw_v5->esdLay      = nil
dpsd_nw_v5->mrk1Lay     = list("areaid" "diode")
dpsd_nw_v5->mrk2Lay     = nil
dpsd_nw_v5->mrk1OLdiff  = 0.0
dpsd_nw_v5->mrk2OLdiff  = 0.0
dpsd_nw_v5->nwellLay    = designRules->nwell
dpsd_nw_v5->tapImpLay   = designRules->nsdm

dioDevices = append1( dioDevices dpsd_nw_v5 )




; dnsd_pw
;-----------------------------------------------------------
dnsd_pw = ncons(nil)
dnsd_pw->deviceName  = "dnsd_pw"
dnsd_pw->modelName   = "dnsd_pw"
dnsd_pw->lvsModel    = "dnsd_pw"
dnsd_pw->paramCB     = "S130dioCB"
dnsd_pw->symbols     = t           ; create symbol views
dnsd_pw->layout      = t           ; create layout view
dnsd_pw->devInfo     = "Vcc=5.5V"
dnsd_pw->native      = nil         ; nil, t
dnsd_pw->hv          = nil         ; nil, 3, 5, 12, 20
dnsd_pw->vt          = nil         ; nil, "low", "high"
dnsd_pw->esd         = nil         ; nil, t
; default/minimum/maximum width/lengths
dnsd_pw->defW = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dnsd_pw->minW = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dnsd_pw->maxW = 250.0
dnsd_pw->defL = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dnsd_pw->minL = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dnsd_pw->maxL = 250.0
; layers needed
dnsd_pw->diffLay     = designRules->diff
dnsd_pw->impLay      = designRules->nsdm
dnsd_pw->hvLay       = nil
dnsd_pw->vtLay       = nil
dnsd_pw->esdLay      = nil
dnsd_pw->mrk1Lay     = list("areaid" "diode")
dnsd_pw->mrk2Lay     = nil
dnsd_pw->mrk1OLdiff  = 0.0
dnsd_pw->mrk2OLdiff  = 0.0
dnsd_pw->nwellLay    = nil
dnsd_pw->dnwellLay   = nil
dnsd_pw->tapImpLay   = designRules->psdm

dioDevices = append1( dioDevices dnsd_pw )

; dnsd_pw_esd
;-----------------------------------------------------------
dnsd_pw_esd = ncons(nil)
dnsd_pw_esd->deviceName  = "dnsd_pw_esd"
dnsd_pw_esd->modelName   = "dnsd_pw_esd"
dnsd_pw_esd->lvsModel    = "dnsd_pw_esd"
dnsd_pw_esd->paramCB     = "S130dioCB"
dnsd_pw_esd->symbols     = t           ; create symbol views
dnsd_pw_esd->layout      = t           ; create layout view
dnsd_pw_esd->devInfo     = "Vcc=5.5V"
dnsd_pw_esd->native      = nil         ; nil, t
dnsd_pw_esd->hv          = nil         ; nil, 3, 5, 12, 20
dnsd_pw_esd->vt          = nil         ; nil, "low", "high"
dnsd_pw_esd->esd         = t           ; nil, t
; default/minimum/maximum width/lengths
dnsd_pw_esd->defW = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dnsd_pw_esd->minW = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dnsd_pw_esd->maxW = 250.0
dnsd_pw_esd->defL = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dnsd_pw_esd->minL = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dnsd_pw_esd->maxL = 250.0
; layers needed
dnsd_pw_esd->diffLay     = designRules->diff
dnsd_pw_esd->impLay      = designRules->nsdm
dnsd_pw_esd->hvLay       = nil
dnsd_pw_esd->vtLay       = nil
dnsd_pw_esd->esdLay      = list("areaid" "esd")
dnsd_pw_esd->mrk1Lay     = list("areaid" "diode")
dnsd_pw_esd->mrk2Lay     = nil
dnsd_pw_esd->mrk1OLdiff  = 0.0
dnsd_pw_esd->mrk2OLdiff  = 0.0
dnsd_pw_esd->nwellLay    = nil
dnsd_pw_esd->dnwellLay   = nil
dnsd_pw_esd->tapImpLay   = designRules->psdm

dioDevices = append1( dioDevices dnsd_pw_esd )

; dnsd_pw_esd_v5
;-----------------------------------------------------------
dnsd_pw_esd_v5 = ncons(nil)
dnsd_pw_esd_v5->deviceName  = "dnsd_pw_esd_v5"
dnsd_pw_esd_v5->modelName   = "dnsd_pw_esd_v5"
dnsd_pw_esd_v5->lvsModel    = "dnsd_pw_esd_v5"
dnsd_pw_esd_v5->paramCB     = "S130dioCB"
dnsd_pw_esd_v5->symbols     = t           ; create symbol views
dnsd_pw_esd_v5->layout      = t           ; create layout view
dnsd_pw_esd_v5->devInfo     = "Vcc=11.0V"
dnsd_pw_esd_v5->native      = nil         ; nil, t
dnsd_pw_esd_v5->hv          = 5           ; nil, 3, 5, 12, 20
dnsd_pw_esd_v5->vt          = nil         ; nil, "low", "high"
dnsd_pw_esd_v5->esd         = t           ; nil, t
; default/minimum/maximum width/lengths
dnsd_pw_esd_v5->defW = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dnsd_pw_esd_v5->minW = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dnsd_pw_esd_v5->maxW = 250.0
dnsd_pw_esd_v5->defL = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dnsd_pw_esd_v5->minL = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dnsd_pw_esd_v5->maxL = 250.0
; layers needed
dnsd_pw_esd_v5->diffLay     = designRules->diff
dnsd_pw_esd_v5->impLay      = designRules->nsdm
dnsd_pw_esd_v5->hvLay       = designRules->thkox
dnsd_pw_esd_v5->vtLay       = nil
dnsd_pw_esd_v5->esdLay      = list("areaid" "esd")
dnsd_pw_esd_v5->mrk1Lay     = list("areaid" "diode")
dnsd_pw_esd_v5->mrk2Lay     = nil
dnsd_pw_esd_v5->mrk1OLdiff  = 0.0
dnsd_pw_esd_v5->mrk2OLdiff  = 0.0
dnsd_pw_esd_v5->nwellLay    = nil
dnsd_pw_esd_v5->dnwellLay   = nil
dnsd_pw_esd_v5->tapImpLay   = designRules->psdm

dioDevices = append1( dioDevices dnsd_pw_esd_v5 )

; dnsd_pw_lvt
;-----------------------------------------------------------
dnsd_pw_lvt = ncons(nil)
dnsd_pw_lvt->deviceName  = "dnsd_pw_lvt"
dnsd_pw_lvt->modelName   = "dnsd_pw_lvt"
dnsd_pw_lvt->lvsModel    = "dnsd_pw_lvt"
dnsd_pw_lvt->paramCB     = "S130dioCB"
dnsd_pw_lvt->symbols     = t           ; create symbol views
dnsd_pw_lvt->layout      = t           ; create layout view
dnsd_pw_lvt->devInfo     = "Vcc=5.5V"
dnsd_pw_lvt->native      = nil         ; nil, t
dnsd_pw_lvt->hv          = nil         ; nil, 3, 5, 12, 20
dnsd_pw_lvt->vt          = "low"       ; nil, "low", "high"
dnsd_pw_lvt->esd         = nil         ; nil, t
; default/minimum/maximum width/lengths
dnsd_pw_lvt->defW = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dnsd_pw_lvt->minW = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dnsd_pw_lvt->maxW = 250.0
dnsd_pw_lvt->defL = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dnsd_pw_lvt->minL = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dnsd_pw_lvt->maxL = 250.0
; layers needed
dnsd_pw_lvt->diffLay     = designRules->diff
dnsd_pw_lvt->impLay      = designRules->nsdm
dnsd_pw_lvt->hvLay       = nil
dnsd_pw_lvt->vtLay       = designRules->lvtn
dnsd_pw_lvt->esdLay      = nil
dnsd_pw_lvt->mrk1Lay     = list("areaid" "diode")
dnsd_pw_lvt->mrk2Lay     = nil
dnsd_pw_lvt->mrk1OLdiff  = 0.0
dnsd_pw_lvt->mrk2OLdiff  = 0.0
dnsd_pw_lvt->nwellLay    = nil
dnsd_pw_lvt->dnwellLay   = nil
dnsd_pw_lvt->tapImpLay   = designRules->psdm

dioDevices = append1( dioDevices dnsd_pw_lvt )

; dnsd_pw_nat
;-----------------------------------------------------------
dnsd_pw_nat = ncons(nil)
dnsd_pw_nat->deviceName  = "dnsd_pw_nat"
dnsd_pw_nat->modelName   = "dnsd_pw_nat"
dnsd_pw_nat->lvsModel    = "dnsd_pw_nat"
dnsd_pw_nat->paramCB     = "S130dioCB"
dnsd_pw_nat->symbols     = t           ; create symbol views
dnsd_pw_nat->layout      = t           ; create layout view
dnsd_pw_nat->devInfo     = "Vcc=5.5V"
dnsd_pw_nat->native      = t           ; nil, t
dnsd_pw_nat->hv          = nil         ; nil, 3, 5, 12, 20
dnsd_pw_nat->vt          = nil         ; nil, "low", "high"
dnsd_pw_nat->esd         = nil         ; nil, t
; default/minimum/maximum width/lengths
dnsd_pw_nat->defW = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dnsd_pw_nat->minW = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dnsd_pw_nat->maxW = 250.0
dnsd_pw_nat->defL = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dnsd_pw_nat->minL = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dnsd_pw_nat->maxL = 250.0
; layers needed
dnsd_pw_nat->diffLay     = designRules->diff
dnsd_pw_nat->impLay      = designRules->nsdm
dnsd_pw_nat->hvLay       = nil
dnsd_pw_nat->vtLay       = designRules->lvtn
dnsd_pw_nat->esdLay      = nil
dnsd_pw_nat->mrk1Lay     = list("areaid" "diode")
dnsd_pw_nat->mrk2Lay     = list("areaid" "lvNative")
dnsd_pw_nat->mrk1OLdiff  = 0.0
dnsd_pw_nat->mrk2OLdiff  = 0.0
dnsd_pw_nat->nwellLay    = nil
dnsd_pw_nat->dnwellLay   = nil
dnsd_pw_nat->tapImpLay   = designRules->psdm

dioDevices = append1( dioDevices dnsd_pw_nat )

; dnsd_pw_v5
;-----------------------------------------------------------
dnsd_pw_v5 = ncons(nil)
dnsd_pw_v5->deviceName  = "dnsd_pw_v5"
dnsd_pw_v5->modelName   = "dnsd_pw_v5"
dnsd_pw_v5->lvsModel    = "dnsd_pw_v5"
dnsd_pw_v5->paramCB     = "S130dioCB"
dnsd_pw_v5->symbols     = t           ; create symbol views
dnsd_pw_v5->layout      = t           ; create layout view
dnsd_pw_v5->devInfo     = "Vcc=11.0V"
dnsd_pw_v5->native      = nil         ; nil, t
dnsd_pw_v5->hv          = 5           ; nil, 3, 5, 12, 20
dnsd_pw_v5->vt          = nil         ; nil, "low", "high"
dnsd_pw_v5->esd         = nil         ; nil, t
; default/minimum/maximum width/lengths
dnsd_pw_v5->defW = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dnsd_pw_v5->minW = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dnsd_pw_v5->maxW = 250.0
dnsd_pw_v5->defL = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dnsd_pw_v5->minL = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
dnsd_pw_v5->maxL = 250.0
; layers needed
dnsd_pw_v5->diffLay     = designRules->diff
dnsd_pw_v5->impLay      = designRules->nsdm
dnsd_pw_v5->hvLay       = designRules->thkox
dnsd_pw_v5->vtLay       = nil
dnsd_pw_v5->esdLay      = nil
dnsd_pw_v5->mrk1Lay     = list("areaid" "diode")
dnsd_pw_v5->mrk2Lay     = nil
dnsd_pw_v5->mrk1OLdiff  = 0.0
dnsd_pw_v5->mrk2OLdiff  = 0.0
dnsd_pw_v5->nwellLay    = nil
dnsd_pw_v5->dnwellLay   = nil
dnsd_pw_v5->tapImpLay   = designRules->psdm

dioDevices = append1( dioDevices dnsd_pw_v5 )



;-----------------------------------------------------------
/*====== Antenna Diode ======*/
;-----------------------------------------------------------
;; diode_antenna

dioAntennaDevices = list()

; diode_antenna
;-----------------------------------------------------------
diode_antenna = ncons(nil)
diode_antenna->deviceName  = "diode_antenna"
diode_antenna->modelName   = "diode_antenna"
diode_antenna->lvsModel    = "diode_antenna"
diode_antenna->paramCB     = "S130dioCB"
diode_antenna->symbols     = nil           ; create symbol views
diode_antenna->layout      = t           ; create layout view
diode_antenna->devInfo     = "Vcc=5.5V"
diode_antenna->native      = nil         ; nil, t
diode_antenna->hv          = nil         ; nil, 3, 5, 12, 20
diode_antenna->vt          = nil         ; nil, "low", "high"
diode_antenna->esd         = nil         ; nil, t
; default/minimum/maximum width/lengths
diode_antenna->defW = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
diode_antenna->minW = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
diode_antenna->maxW = 250.0
diode_antenna->defL = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
diode_antenna->minL = designRules->licon1->minW + 2*max(designRules->diff->minOLSlicon1 designRules->li1->minOLSlicon1)
diode_antenna->maxL = 250.0
; layers needed
diode_antenna->diffLay     = designRules->diff
diode_antenna->impLay      = designRules->nsdm
diode_antenna->hvLay       = nil
diode_antenna->vtLay       = nil
diode_antenna->esdLay      = nil
;diode_antenna->mrk1Lay     = list("areaid" "diode")
diode_antenna->mrk1Lay     = nil
diode_antenna->mrk2Lay     = nil
diode_antenna->mrk1OLdiff  = 0.0
diode_antenna->mrk2OLdiff  = 0.0
diode_antenna->nwellLay    = nil
diode_antenna->dnwellLay   = nil
diode_antenna->tapImpLay   = designRules->psdm

dioAntennaDevices = append1( dioAntennaDevices diode_antenna )

;-----------------------------------------------------------
/*===  MIM CAPACITORS  ===*/
;-----------------------------------------------------------
;; cm3m4, cm4m5

capDevices = list()

; cm3m4
;-----------------------------------------------------------
cm3m4 = ncons(nil)
cm3m4->deviceName   = "cm3m4"
cm3m4->modelName    = "cm3m4"
cm3m4->lvsModel     = "cm3m4"
cm3m4->paramCB      = "S130mimcapCB"
cm3m4->devInfo      = "2fF/um^2, Vop=0V-5V"
cm3m4->sheetCap     = 2.0   ; fF/um^2
cm3m4->fringeCap    = 0.19  ; fF/um
cm3m4->subTerm      = nil
; default/minimum/maximum width/lengths
cm3m4->defC = 9.52
cm3m4->defW = 2.0
cm3m4->minW = 1.0
cm3m4->maxW = 100.0
cm3m4->defL = 2.0
cm3m4->minL = 1.0
cm3m4->maxL = 100.0
cm3m4->maxWLratio = 20.0
; layers needed
cm3m4->botLay = designRules->met3
cm3m4->topLay = designRules->met4
cm3m4->viaLay = designRules->via3
cm3m4->capLay = designRules->capm

capDevices = append1( capDevices cm3m4 )

; cm4m5
;-----------------------------------------------------------
cm4m5 = ncons(nil)
cm4m5->deviceName   = "cm4m5"
cm4m5->modelName    = "cm4m5"
cm4m5->lvsModel     = "cm4m5"
cm4m5->paramCB      = "S130mimcapCB"
cm4m5->devInfo      = "2fF/um^2, Vop=0V-5V"
cm4m5->sheetCap     = 2.0   ; fF/um^2
cm4m5->fringeCap    = 0.19  ; fF/um
cm4m5->subTerm      = nil
; default/minimum/maximum width/lengths
cm4m5->defC = 9.52
cm4m5->defW = 2.0
cm4m5->minW = 1.0
cm4m5->maxW = 100.0
cm4m5->defL = 2.0
cm4m5->minL = 1.0
cm4m5->maxL = 100.0
cm4m5->maxWLratio = 20.0
; layers needed
cm4m5->botLay = designRules->met4
cm4m5->topLay = designRules->met5
cm4m5->viaLay = designRules->via4
cm4m5->capLay = designRules->cap2m

capDevices = append1( capDevices cm4m5 )

;-----------------------------------------------------------
/*===  BIPOLARS  ===*/
;-----------------------------------------------------------
;; npn_1x1, npn_1x1_v5, npn_1x2, pnp , pnp_5x

bipolarDevices = list() 

; npn_1x1
;-----------------------------------------------------------
npn_1x1 = ncons(nil)
npn_1x1->deviceName  = "npn_1x1"
npn_1x1->modelName   = "npn_1x1"
npn_1x1->lvsModel    = "npn_1x1"
npn_1x1->paramCB     = "S130bipolarCB"
npn_1x1->devInfo     = "Vcc=5.5V"
npn_1x1->hv          = nil         ; nil, 3, 5, 12, 20
; default/minimum/maximum width/lengths
npn_1x1->defW = 1.0
npn_1x1->minW = 1.0
npn_1x1->maxW = 1.0
npn_1x1->defL = 1.0
npn_1x1->minL = 1.0
npn_1x1->maxL = 1.0
; layers needed
npn_1x1->diffLay    = designRules->diff
npn_1x1->impLay     = designRules->nsdm
npn_1x1->hvLay      = nil
npn_1x1->nwellLay   = designRules->nwell
npn_1x1->tapImpLay  = designRules->psdm
npn_1x1->dnwellLay  = designRules->dnwell
npn_1x1->mrkLay     = list("npn" "drawing")
npn_1x1->mrkOLdiff  = 0.0

bipolarDevices = append1( bipolarDevices npn_1x1 )

; npn_1x1_v5
;-----------------------------------------------------------
npn_1x1_v5 = ncons(nil)
npn_1x1_v5->deviceName  = "npn_1x1_v5"
npn_1x1_v5->modelName   = "npn_1x1_v5"
npn_1x1_v5->lvsModel    = "npn_1x1_v5"
npn_1x1_v5->paramCB     = "S130bipolarCB"
npn_1x1_v5->devInfo     = "Vcc=11.0V"
npn_1x1_v5->hv          = 5         ; nil, 3, 5, 12, 20
; default/minimum/maximum width/lengths
npn_1x1_v5->defW = 1.5
npn_1x1_v5->minW = 1.5
npn_1x1_v5->maxW = 1.5
npn_1x1_v5->defL = 1.5
npn_1x1_v5->minL = 1.5
npn_1x1_v5->maxL = 1.5
; layers needed
npn_1x1_v5->diffLay    = designRules->diff
npn_1x1_v5->impLay     = designRules->nsdm
npn_1x1_v5->hvLay      = designRules->thkox
npn_1x1_v5->nwellLay   = designRules->nwell
npn_1x1_v5->tapImpLay  = designRules->psdm
npn_1x1_v5->dnwellLay  = designRules->dnwell
npn_1x1_v5->mrkLay     = list("npn" "drawing")
npn_1x1_v5->mrkOLdiff  = 0.0

bipolarDevices = append1( bipolarDevices npn_1x1_v5 )

; npn_1x2
;-----------------------------------------------------------
npn_1x2 = ncons(nil)
npn_1x2->deviceName  = "npn_1x2"
npn_1x2->modelName   = "npn_1x2"
npn_1x2->lvsModel    = "npn_1x2"
npn_1x2->paramCB     = "S130bipolarCB"
npn_1x2->devInfo     = "Vcc=5.5V"
npn_1x2->hv          = nil         ; nil, 3, 5, 12, 20
; default/minimum/maximum width/lengths
npn_1x2->defW = 1.0
npn_1x2->minW = 1.0
npn_1x2->maxW = 1.0
npn_1x2->defL = 2.0
npn_1x2->minL = 2.0
npn_1x2->maxL = 2.0
; layers needed
npn_1x2->diffLay    = designRules->diff
npn_1x2->impLay     = designRules->nsdm
npn_1x2->hvLay      = nil
npn_1x2->nwellLay   = designRules->nwell
npn_1x2->tapImpLay  = designRules->psdm
npn_1x2->dnwellLay  = designRules->dnwell
npn_1x2->mrkLay     = list("npn" "drawing")
npn_1x2->mrkOLdiff  = 0.0

bipolarDevices = append1( bipolarDevices npn_1x2 )

; pnp
;-----------------------------------------------------------
pnp = ncons(nil)
pnp->deviceName  = "pnp"
pnp->modelName   = "pnp"
pnp->lvsModel    = "pnp"
pnp->paramCB     = "S130bipolarCB"
pnp->devInfo     = "Vcc=5.5V"
pnp->hv          = nil         ; nil, 3, 5, 12, 20
; default/minimum/maximum width/lengths
pnp->defW = 0.68
pnp->minW = 0.68
pnp->maxW = 0.68
pnp->defL = 0.68
pnp->minL = 0.68
pnp->maxL = 0.68
; layers needed
pnp->diffLay    = designRules->diff
pnp->impLay     = designRules->psdm
pnp->hvLay      = nil
pnp->nwellLay   = designRules->nwell
pnp->tapImpLay  = designRules->nsdm
pnp->dnwellLay  = nil
pnp->mrkLay     = list("pnp" "drawing")
pnp->mrkOLdiff  = 0.0

bipolarDevices = append1( bipolarDevices pnp )

; pnp_5x
;-----------------------------------------------------------
pnp_5x = ncons(nil)
pnp_5x->deviceName  = "pnp_5x"
pnp_5x->modelName   = "pnp_5x"
pnp_5x->lvsModel    = "pnp_5x"
pnp_5x->paramCB     = "S130bipolarCB"
pnp_5x->devInfo     = "Vcc=5.5V"
pnp_5x->hv          = nil         ; nil, 3, 5, 12, 20
; default/minimum/maximum width/lengths
pnp_5x->defW = 3.4
pnp_5x->minW = 3.4
pnp_5x->maxW = 3.4
pnp_5x->defL = 3.4
pnp_5x->minL = 3.4
pnp_5x->maxL = 3.4
; layers needed
pnp_5x->diffLay    = designRules->diff
pnp_5x->impLay     = designRules->psdm
pnp_5x->hvLay      = nil
pnp_5x->nwellLay   = designRules->nwell
pnp_5x->tapImpLay  = designRules->nsdm
pnp_5x->dnwellLay  = nil
pnp_5x->mrkLay     = list("pnp_5x" "drawing")
pnp_5x->mrkOLdiff  = 0.0

bipolarDevices = append1( bipolarDevices pnp_5x )

;-----------------------------------------------------------
/*===  PADS  ===*/
;-----------------------------------------------------------
;; pad_bond, pad_probe, pad_microprobe

padDevices = list() 

; pad_bond
;-----------------------------------------------------------
pad_bond = ncons(nil)
pad_bond->deviceName  = "pad_bond"
pad_bond->modelName   = "pad_bond"
pad_bond->lvsModel    = "pad_bond"
pad_bond->paramCB     = "S130padCB"
pad_bond->defW        = 60.0
pad_bond->defL        = 60.0
pad_bond->padLay      = designRules->pad
pad_bond->botMetLay   = designRules->met4
pad_bond->viaLay      = designRules->via4
pad_bond->topMetLay   = designRules->met5
pad_bond->minTopMetOL = 2.7     ; TDR pad.4
pad_bond->minLbevel   = 7.0     ; TDR pad.12
pad_bond->maxLbevel   = 8.8     ; TDR pad.13
pad_bond->minW        = 40.0    ; TDR no rule, just making this up
pad_bond->maxW        = 150.0   ; TDR pad.9.1
pad_bond->label       = nil
pad_bond->mrkLay      = nil

padDevices = append1( padDevices pad_bond )

; pad_probe
;-----------------------------------------------------------
pad_probe = ncons(nil)
pad_probe->deviceName  = "pad_probe"
pad_probe->modelName   = "pad_probe"
pad_probe->lvsModel    = "pad_probe"
pad_probe->paramCB     = "S130padCB"
pad_probe->defW        = 35.0
pad_probe->defL        = 35.0
pad_probe->padLay      = designRules->pad
pad_probe->botMetLay   = designRules->met4
pad_probe->viaLay      = designRules->via4
pad_probe->topMetLay   = designRules->met5
pad_probe->minTopMetOL = 2.5     ; TDR scribe.13
pad_probe->minLbevel   = nil
pad_probe->maxLbevel   = nil
pad_probe->minW        = 35.0    ; TDR scribe.9
pad_probe->maxW        = 67.0    ; TDR scribe.9
pad_probe->label       = "e-test"
pad_probe->mrkLay      = list("areaid" "etest")

padDevices = append1( padDevices pad_probe )

; pad_microprobe
;-----------------------------------------------------------
pad_microprobe = ncons(nil)
pad_microprobe->deviceName  = "pad_microprobe"
pad_microprobe->modelName   = "pad_microprobe"
pad_microprobe->lvsModel    = "pad_microprobe"
pad_microprobe->paramCB     = "S130padCB"
pad_microprobe->defW        = 10.0
pad_microprobe->defL        = 10.0
pad_microprobe->padLay      = designRules->pad
pad_microprobe->botMetLay   = designRules->met4
pad_microprobe->viaLay      = designRules->via4
pad_microprobe->topMetLay   = designRules->met5
pad_microprobe->minTopMetOL = 2.5     ; TDR scribe.17
pad_microprobe->minLbevel   = nil
pad_microprobe->maxLbevel   = nil
pad_microprobe->minW        = 10.0    ; TDR scribe.14
pad_microprobe->maxW        = 35.0    ; TDR no rule, so going with min e-test size
pad_microprobe->label       = "u-test"
pad_microprobe->mrkLay      = list("areaid" "etest")

padDevices = append1( padDevices pad_microprobe )

;-----------------------------------------------------------
/*===  SEALRING  ===*/
;-----------------------------------------------------------
;; sealring

; sealring
;-----------------------------------------------------------
; no rules found so basing everything off of the advSeal_6um from
; the s8phirs_10r library
sealring = ncons(nil)
sealring->deviceName    = "sealring"
sealring->modelName     = nil
sealring->lvsModel      = nil
sealring->paramCB       = "S130sealringCB"
sealring->defW          = 188.000 ; was 1000 made 188 because defDieW-12=188
sealring->defL          = 188.000 ; was 1000 made 188 because it's defDieW-12=188
sealring->defDieW          = 200.000 ; changed default to min 1000 - 200
sealring->defDieL          = 200.000 ; changed default to min 1000 - 200
sealring->defExtraCut   = 0.250
sealring->minW          = 100.0       ; TDR no rule, just making this up was 200 made it 100 because it's not editable
sealring->maxW          = 100000.0     ; TDR no rule, just making this up was 10000 made it 100000 because it's not editable
sealring->minDieW          = 200.0       ; TDR no rule, just making this up 
sealring->maxDieW          = 100000.0     ; TDR no rule, just making this up -11/4/21 CBPL changed from 10K to 32K -11/22/21 CBPL changed from 10k to 100k
sealring->minWnsm       = 5.0
sealring->minWseal      = 6.0
sealring->minLcut       = 6.735
sealring->minDiffW      = 0.30
sealring->mindiffSP     = 0.30
sealring->minNsmOLdiff  = 1.45
sealring->minWdiffSlot  = 1.0
sealring->minSlotSPedge = 13.0
sealring->minSlotSP     = 25.0
sealring->crossW        = 0.5
sealring->crossL        = 2.4
sealring->octW          = 4.0
sealring->octLbevel     = 1.17
sealring->critCornerR   = 152.4
sealring->critSidW      = 101.6
sealring->nikonOffset   = 3.0
sealring->sealLay       = list("areaid" "seal")
sealring->diffLay       = list("diff" "drawing")
sealring->nsmLay        = list("nsm" "drawing")
sealring->cornerLay     = list("cpdm" "mask")
sealring->maskDropLay   = list("cfom" "maskDrop")
sealring->critCornerLay = list("areaid" "critCorner")
sealring->critSidLay    = list("areaid" "critSid")
sealring->nikonCrossLays = list(
  '("cfom" "mask") '("cnwm" "mask") 
  '("chvtpm" "mask") '("chvtrm" "mask") 
  '("conom" "mask") '("cnsdm" "mask") 
  '("cpsdm" "mask") '("cntm" "mask") 
  '("clvom" "mask") '("cp1m" "mask")
  '("cli1m" "mask") '("clicm1" "mask") 
  '("cmm1" "mask") '("cviam" "mask") 
  '("cmm2" "mask") '("cviam2" "mask") 
  '("cmm3" "mask") '("cviam3" "mask") 
  '("cnsm" "mask") '("cmm4" "mask")
  '("cviam4" "mask") '("cmm5" "mask") 
  '("cctm1" "mask") '("crpm" "mask")
)
sealring->nikonOctLays = list(
  '("cdnm" "mask") '("clvtnm" "mask") 
  '("ctunm" "mask") '("chvntm" "mask") 
  '("cldntm" "mask") '("cnpc" "mask")
)

;-----------------------------------------------------------
/*===  ANCHOR  ===*/
;-----------------------------------------------------------
anchor = ncons(nil)
anchor->deviceName  = "anchor"
anchor->modelName   = "anchor"
anchor->lvsModel    = "anchor"
anchor->paramCB     = "S130anchorCB"
anchor->defW        = 3.0 
anchor->defSP       = 5.0 
anchor->viaPitch    = 3.1
anchor->defX        = 20.0 
anchor->defY        = 20.0
anchor->defZ        = 3.0 ; chamfer length

;-----------------------------------------------------------
/*===  FUSES  ===*/
;-----------------------------------------------------------
;; fuse_m4

fuseDevices = list() 

; fuse_m4
;-----------------------------------------------------------
fuse_m4 = ncons(nil)
fuse_m4->deviceName  = "fuse_m4"
fuse_m4->modelName   = "rm4"
fuse_m4->lvsModel    = "fuse_m4"
fuse_m4->paramCB     = "S130fuseCB"
fuse_m4->defW        = designRules->fuse->minW
fuse_m4->defL        = designRules->fuse->minL
fuse_m4->fuseLay     = designRules->met4
fuse_m4->mrkLay      = list(designRules->met4->layer "fuse")
fuse_m4->targetLay   = list("target" "drawing")

fuseDevices = append1( fuseDevices fuse_m4 )

/*==================================  EOF  ===================================*/
