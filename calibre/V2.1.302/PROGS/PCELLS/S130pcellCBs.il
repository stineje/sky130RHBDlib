/*==============================================================================
  File:         S130pcellCBs.il
  Purpose:      Callback functions for Skywater S130 Pcells
                To be loaded by the tech lib libInit.il

  Created:      Mar 14, 2020  Madek Graham

  Functions defined:  S130fetCB
                      S130fet12vCB
                      S130fet20vCB
                      S130hrpolyCB
                      S130hrpolyResCalc
                      S130hrpolyRheadCalc
                      S130resCB
                      S130rmetCB
                      S130rpwellCB
                      S130bipolarCB
                      S130dioCB
                      S130welldioCB
                      S130mimcapCB
                      S130padCB
                      S130sealringCB
                      S130fuseCB
                      S130anchorCB
                      S130CheckRange
                      S130Round
                      S130TruncateZeros
                      S130stringTruncateZeros
                      S130CalcNetlistValues
                      S130hrpolyCdlNLProc
                      S130hrpolySpectreNLProc

------------------------------------------------------------
  Modifications:
  - Mar 17, 2020 MSG
    Added nf to cdl netlisting to spit out as segments
  - Apr 08, 2020 MSG
    Cleaned up some lint errors
    Added S130mimcapCB
  - Apr 19, 2020 MSG
    Modified the S130mimcapCB to accomodate singleTopPlate and CBs to trigger
      upon initial placement of devices
  - Nov 08, 2020 MSG
    Added S130fuseCB

  - 9/28/2021 - CBPL 
		updating SealRing pcell to add 2 parameters wOutside=w+6microns lOutside=l+6microns
		Changed display w -> w Inside  l -> l Inside 

==============================================================================*/

/*==============================================================================
  ***** FET CDF Callback Definitions *****
==============================================================================*/

;---------------------------------------
; Main callback for fets (non-DE)
;---------------------------------------
procedure( S130fetCB(@optional (param nil) )
  let( ( cv tfId grid fw l nf fingerSP m minW maxW minL maxL diffLext
        diffRext minFingerSP maxFingerSP rsh diffOLgate gateMidCntSP w
        totalW as ad ps pd nrs nrd asL asR asI adR adI psL psR psI pdR
        pdI nrsL nrsR nrsI nrdR nrdI gateCntExt minDiffOLgate
        model fixedWL fixedW fixedL fixedWch fixedLch )

    cv = cdfgData->id~>master || cdfgData->id
    tfId = techGetTechFile(cv)
    grid = techGetMfgGridResolution(tfId)

    ; in case a device type is changed, ensure these params are reset to default values
    cdfgData->model->value    = cdfgData->model->defValue
    cdfgData->lvsModel->value = cdfgData->lvsModel->defValue
    cdfgData->info->value     = cdfgData->info->defValue
    minW          = cdfgData->minW->value        = cdfgData->minW->defValue
    maxW          = cdfgData->maxW->value        = cdfgData->maxW->defValue
    minL          = cdfgData->minL->value        = cdfgData->minL->defValue
    maxL          = cdfgData->maxL->value        = cdfgData->maxL->defValue
    minFingerSP   = cdfgData->minFingerSP->value = cdfgData->minFingerSP->defValue
    maxFingerSP   = cdfgData->maxFingerSP->value = cdfgData->maxFingerSP->defValue
    rsh           = cdfgData->rsh->value         = cdfgData->rsh->defValue

    ; base params
    ;-----------------------------------------------------------
    when( cdfgData->fixedW                        ;; remove for continuous devices
      model         = cdfgData->model->value      ;; remove for continuous devices
      fixedWL       = evalstring(strcat(model "->fixedWL"))      ;; remove for continuous devices
      fixedW        = cdfgData->fixedW->value      ;; remove for continuous devices
      fixedL        = cdfgData->fixedL->value      ;; remove for continuous devices
      fixedWch      = cdfgData->fixedW->choices    ;; remove for continuous devices
      fixedLch      = cdfgData->fixedL->choices    ;; remove for continuous devices
    ); unless fixedW      ;; remove for continuous devices

    fw            = cdfgData->fw->value
    l             = cdfgData->l->value
    nf            = cdfgData->nf->value
    fingerSP      = cdfgData->fingerSP->value
    m             = cdfgData->m->value
    gateCntExt    = cdfgData->gateCntExt->value
    diffLext      = cdfgData->diffLext->value
    diffRext      = cdfgData->diffRext->value

    caseq( param

      ( fixedW                ;; remove for continuous devices
        when( cdfgData->useFixedWL->value      ;; remove for continuous devices
          cdfgData->fw->value = fw = evalstring(fixedW)
          cdfgData->fixedL->choices = mapcar( 'cadr setof( wl fixedWL evalstring(car(wl)) == fw) )
          fixedLch = mapcar( 'evalstring mapcar( 'cadr setof( wl fixedWL evalstring(car(wl)) == fw) ) )
          unless( member( l fixedLch )
            fixedL = cdfgData->fixedL->value = car(cdfgData->fixedL->choices)
            l = cdfgData->l->value = evalstring(fixedL)
          ); unless
        ); when useFixedWL
      )

      ( fixedL                ;; remove for continuous devices
        when( cdfgData->useFixedWL->value      ;; remove for continuous devices
          cdfgData->l->value = l = evalstring(fixedL)
          cdfgData->fixedW->choices = mapcar( 'car setof( wl fixedWL evalstring(cadr(wl)) == l) )
          fixedWch = mapcar( 'evalstring mapcar( 'car setof( wl fixedWL evalstring(cadr(wl)) == l) ) )
          ;unless( member( sprintf(nil "%g" fw) cdfgData->fixedW->choices )
          unless( member( fw fixedWch )
            fixedW = cdfgData->fixedW->value = car(cdfgData->fixedW->choices)
            fw = cdfgData->fw->value = evalstring(fixedW)
          ); unless
        ); when useFixedWL
      )

      ( fw
        unless( cdfgData->useFixedWL->value      ;; remove for continuous devices
          fw = S130Round(fw grid)
          fw = S130CheckRange(cdfgData->fw->prompt fw minW maxW)
          cdfgData->fw->value = cdfParseFloatString(S130TruncateZeros(fw))
        )                             ;; remove for continuous devices
      ); fw param

      ( l
        unless( cdfgData->useFixedWL->value      ;; remove for continuous devices
          l = S130Round(l grid)
          l = S130CheckRange(cdfgData->l->prompt l minL maxL)
          cdfgData->l->value = cdfParseFloatString(S130TruncateZeros(l))
        )                             ;; remove for continuous devices
      ); l param

      ( nf
        nf = fix(nf) 
        nf = S130CheckRange(cdfgData->nf->prompt nf 1 100)
        cdfgData->nf->value = nf
      )
      ( fingerSP 
        fingerSP = S130Round(fingerSP grid)
        fingerSP = S130CheckRange(cdfgData->fingerSP->prompt fingerSP minFingerSP maxFingerSP)
        cdfgData->fingerSP->value = cdfParseFloatString(S130TruncateZeros(fingerSP))
        cdfgData->sd->value = cdfParseFloatString(S130TruncateZeros(fingerSP))
      ); fingerSP param
      ( m
        m = fix(m) 
        m = S130CheckRange(cdfgData->m->prompt m 1 500)
        cdfgData->m->value = m
      )
      ( gateCntExt 
        gateCntExt = S130Round(gateCntExt grid)
        gateCntExt = S130CheckRange(cdfgData->gateCntExt->prompt gateCntExt 0.0 10.0)
        cdfgData->gateCntExt->value = cdfParseFloatString(S130TruncateZeros(gateCntExt))
      ); gateCntExt param
      ( diffLext 
        diffLext = S130Round(diffLext grid)
        diffLext = S130CheckRange(cdfgData->diffLext->prompt diffLext 0.0 5.0)
        cdfgData->diffLext->value = cdfParseFloatString(S130TruncateZeros(diffLext))
      ); diffLext param
      ( diffRext 
        diffRext = S130Round(diffRext grid)
        diffRext = S130CheckRange(cdfgData->diffRext->prompt diffRext 0.0 5.0)
        cdfgData->diffRext->value = cdfParseFloatString(S130TruncateZeros(diffRext))
      ); diffRext param

    ); caseq

    ; Grabbing params again in case they changed due to param callbacks above
    ;-----------------------------------------------------------
    fw            = cdfgData->fw->value
    l             = cdfgData->l->value
    nf            = cdfgData->nf->value
    fingerSP      = cdfgData->fingerSP->value
    m             = cdfgData->m->value
    gateCntExt    = cdfgData->gateCntExt->value
    diffLext      = cdfgData->diffLext->value
    diffRext      = cdfgData->diffRext->value

    ; calculate total width
    ;-----------------------------------------------------------
    w = S130Round(fw*nf grid)
    cdfgData->w->value = cdfParseFloatString(S130TruncateZeros(w))
    totalW = S130Round(fw*nf*m grid)
    cdfgData->totalW->value = cdfParseFloatString(S130TruncateZeros(totalW))

    ; calculate src/drn values as, ad, ps, pd, nrs, nrd
    ;-----------------------------------------------------------
    ; params needed for src/drn info
    minDiffOLgate = cdfgData->minDiffOLgate->value
    diffOLgate    = cdfgData->diffOLgate->value
    gateMidCntSP  = cdfgData->gateMidCntSP->value
    
    ; calculate the left and right end values
    if( cdfgData->leftSDCont->value then
      asL = (diffOLgate + diffLext) * fw
      psL = 2*(diffOLgate + diffLext) + fw
      nrsL = (gateMidCntSP + diffLext)/fw 
      cdfgData->sa->value = cdfParseFloatString(S130TruncateZeros(diffOLgate + diffLext))
    else
      asL = (minDiffOLgate + diffLext) * fw
      psL = 2*(minDiffOLgate + diffLext) + fw
      nrsL = (minDiffOLgate + diffLext)/fw 
      cdfgData->sa->value = cdfParseFloatString(S130TruncateZeros(minDiffOLgate + diffLext))
    ); if leftSDCont
    if( cdfgData->rightSDCont->value then
      cdfgData->sb->value = cdfParseFloatString(S130TruncateZeros(diffOLgate + diffRext))
    else
      cdfgData->sb->value = cdfParseFloatString(S130TruncateZeros(minDiffOLgate + diffRext))
    ); if rightSDCont
    if( evenp(nf) then
      adR = pdR = nrdR = 0
      if( cdfgData->rightSDCont->value then
        asR = (diffOLgate + diffRext) * fw
        psR = 2*(diffOLgate + diffRext) + fw
        nrsR = (gateMidCntSP + diffRext) / fw 
      else
        asR = (minDiffOLgate + diffRext) * fw
        psR = 2*(minDiffOLgate + diffRext) + fw
        nrsR = (minDiffOLgate + diffRext) / fw 
      ); if rightSDCont
    else
      asR = psR = nrsR = 0
      if( cdfgData->rightSDCont->value then
        adR = (diffOLgate + diffRext) * fw
        pdR = 2*(diffOLgate + diffRext) + fw
        nrdR = (gateMidCntSP + diffRext) / fw 
      else
        adR = (minDiffOLgate + diffRext) * fw
        pdR = 2*(minDiffOLgate + diffRext) + fw
        nrdR = (minDiffOLgate + diffRext) / fw 
      ); if rightSDCont
    ); if even nf

    ; calculate inner values when fingers > 1
    asI = adI = psI = pdI = nrsI = nrdI = 0
    cond(
      ( nf == 2
          adI  = fingerSP * fw
          pdI  = 2*fingerSP
          nrdI = 0.5*(0.5*fingerSP/fw)
      )
      ( nf > 2 && evenp(nf)
          asI  = round( (nf-2)*0.5 ) * fingerSP * fw
          psI  = round( (nf-2)*0.5 ) * 2*fingerSP
          nrsI = (0.5*(0.5*fingerSP/fw)) / round( (nf-2)*0.5 )
          adI  = round( nf*0.5 ) * fingerSP * fw
          pdI  = round( nf*0.5 ) * 2*fingerSP
          nrdI = (0.5*(0.5*fingerSP/fw)) / round( nf*0.5 )
      )
      ( nf > 2 && oddp(nf)
          asI  = adI  = round( (nf-1)*0.5 ) * fingerSP * fw
          psI  = pdI  = round( (nf-1)*0.5 ) * 2*fingerSP
          nrsI = nrdI = (0.5*(0.5*fingerSP/fw)) / round( (nf-1)*0.5 )
      )
    ); cond

    as = asL + asI + asR
    ad = adI + adR
    ps = psL + psI + psR
    pd = pdI + pdR
    if( nrsR == 0 then
      if( nrsI == 0 then
        nrs = nrsL
      else
        nrs = 1/(1/nrsL + 1/nrsI)
      ); if nrsI  = 0
    else
      if( nrsI == 0 then
        nrs = 1/(1/nrsR + 1/nrsL)
      else
        nrs = 1/(1/nrsR + 1/nrsL + 1/nrsI)
      ); if nrsI  = 0
    ); if nrsR = 0
    if( nrdR == 0 then
      nrd = nrdI
    else
      if( nrdI == 0 then
        nrd = nrdR
      else
        nrd = 1/(1/nrdR + 1/nrdI)
      ); if nrdI  = 0
    ); if nrdR = 0

    cdfgData->as->value = cdfParseFloatString(S130TruncateZeros(as))
    cdfgData->ad->value = cdfParseFloatString(S130TruncateZeros(ad))
    cdfgData->ps->value = cdfParseFloatString(S130TruncateZeros(ps))
    cdfgData->pd->value = cdfParseFloatString(S130TruncateZeros(pd))
    cdfgData->nrs->value = cdfParseFloatString(S130TruncateZeros(nrs))
    cdfgData->nrd->value = cdfParseFloatString(S130TruncateZeros(nrd))
    cdfgData->rs->value = cdfParseFloatString(S130TruncateZeros(rsh*nrs))
    cdfgData->rd->value = cdfParseFloatString(S130TruncateZeros(rsh*nrd))

    cdfgData->tm->value = int(nf*m)

  ); let
); procedure S130fetCB

;---------------------------------------
; Main callback for 12V fets (DE)
;---------------------------------------
procedure( S130fet12vCB(@optional (param nil) )
  let( ( cv tfId grid fw l nf m minW maxW minL maxL
        w totalW gateCntExt ps as nrs pd ad nrd
        model fixedWL fixedW fixedL fixedWch fixedLch )

    cv = cdfgData->id~>master || cdfgData->id
    tfId = techGetTechFile(cv)
    grid = techGetMfgGridResolution(tfId)

    ; base params
    ;-----------------------------------------------------------
    model         = cdfgData->model->value      ;; remove for continuous devices
    fixedWL       = evalstring(strcat(model "->fixedWL"))      ;; remove for continuous devices
    fixedW        = cdfgData->fixedW->value      ;; remove for continuous devices
    fixedL        = cdfgData->fixedL->value      ;; remove for continuous devices
    fixedWch      = cdfgData->fixedW->choices    ;; remove for continuous devices
    fixedLch      = cdfgData->fixedL->choices    ;; remove for continuous devices

    fw            = cdfgData->fw->value
    l             = cdfgData->l->value
    nf            = cdfgData->nf->value
    m             = cdfgData->m->value
    gateCntExt    = cdfgData->gateCntExt->value
    ; in case a device type is changed, ensure these params are reset to default values
    cdfgData->model->value    = cdfgData->model->defValue
    cdfgData->lvsModel->value = cdfgData->lvsModel->defValue
    cdfgData->info->value     = cdfgData->info->defValue
    minW          = cdfgData->minW->value        = cdfgData->minW->defValue
    maxW          = cdfgData->maxW->value        = cdfgData->maxW->defValue
    minL          = cdfgData->minL->value        = cdfgData->minL->defValue
    maxL          = cdfgData->maxL->value        = cdfgData->maxL->defValue

    caseq( param

      ( fixedW                ;; remove for continuous devices
        when( cdfgData->useFixedWL->value      ;; remove for continuous devices
          cdfgData->fw->value = fw = evalstring(fixedW)
          cdfgData->fixedL->choices = mapcar( 'cadr setof( wl fixedWL evalstring(car(wl)) == fw) )
          fixedLch = mapcar( 'evalstring mapcar( 'cadr setof( wl fixedWL evalstring(car(wl)) == fw) ) )
          unless( member( l fixedLch )
            fixedL = cdfgData->fixedL->value = car(cdfgData->fixedL->choices)
            l = cdfgData->l->value = evalstring(fixedL)
          ); unless
        ); when useFixedWL
      )

      ( fixedL                ;; remove for continuous devices
        when( cdfgData->useFixedWL->value      ;; remove for continuous devices
          cdfgData->l->value = l = evalstring(fixedL)
          cdfgData->fixedW->choices = mapcar( 'car setof( wl fixedWL evalstring(cadr(wl)) == l) )
          fixedWch = mapcar( 'evalstring mapcar( 'car setof( wl fixedWL evalstring(cadr(wl)) == l) ) )
          ;unless( member( sprintf(nil "%g" fw) cdfgData->fixedW->choices )
          unless( member( fw fixedWch )
            fixedW = cdfgData->fixedW->value = car(cdfgData->fixedW->choices)
            fw = cdfgData->fw->value = evalstring(fixedW)
          ); unless
        ); when useFixedWL
      )

      ( fw
        unless( cdfgData->useFixedWL->value      ;; remove for continuous devices
          fw = S130Round(fw grid)
          fw = S130CheckRange(cdfgData->fw->prompt fw minW maxW)
          cdfgData->fw->value = cdfParseFloatString(S130TruncateZeros(fw))
        )                             ;; remove for continuous devices
      ); fw param

      ( l
        unless( cdfgData->useFixedWL->value      ;; remove for continuous devices
          l = S130Round(l grid)
          l = S130CheckRange(cdfgData->l->prompt l minL maxL)
          cdfgData->l->value = cdfParseFloatString(S130TruncateZeros(l))
        )                             ;; remove for continuous devices
        ; needed for nwell spacing between fingers
        when( rexMatchp( "^nmos" model )
          when( l < 0.89
            warn(sprintf(nil "When %s is < 0.89, %s need to be set to minimum\nto accommodate drain nw to nw spacing"
              cdfgData->l->prompt cdfgData->nf->prompt ))
            cdfgData->nf->value = nf = 2
          ); when l < 0.89 (the value needed for l so the space between drain nw is 2.4+
        ); when nmos
      ); l param

      ( nf
        nf = fix(nf)
        when( oddp(nf)
          warn(sprintf(nil "%L has to be a factor of 2 (changing %d to %d)"
            cdfgData->nf->prompt nf nf+1))
          nf = nf + 1
        ); when odd
        nf = S130CheckRange(cdfgData->nf->prompt nf 2 20)
        cdfgData->nf->value = nf
      )
      ( m
        m = fix(m) 
        m = S130CheckRange(cdfgData->m->prompt m 1 500)
        cdfgData->m->value = m
      )
      ( gateCntExt 
        gateCntExt = S130Round(gateCntExt grid)
        gateCntExt = S130CheckRange(cdfgData->gateCntExt->prompt gateCntExt 0.0 10.0)
        cdfgData->gateCntExt->value = cdfParseFloatString(S130TruncateZeros(gateCntExt))
      ); gateCntExt param

    ); caseq

    ; Grabbing params again in case they changed due to param callbacks above
    ;-----------------------------------------------------------
    fw            = cdfgData->fw->value
    l             = cdfgData->l->value
    nf            = cdfgData->nf->value
    m             = cdfgData->m->value
    gateCntExt    = cdfgData->gateCntExt->value

    ; calculate total width
    ;-----------------------------------------------------------
    w = S130Round(fw*nf grid)
    cdfgData->w->value = cdfParseFloatString(S130TruncateZeros(w))
    totalW = S130Round(fw*nf*m grid)
    cdfgData->totalW->value = cdfParseFloatString(S130TruncateZeros(totalW))
    cdfgData->tm->value = int(nf*m)

    ; calculate s/d params
    ;-----------------------------------------------------------
    ps = 2*( 2*(designRules->licon1->minW + 2*designRules->licon1->minDcontSPpoly) + fw ) +
      ( fix(0.5*(nf-2)) * 2*(designRules->licon1->minW + 2*designRules->licon1->minDcontSPpoly) )
    pd = fix(0.5*nf) * 2*(2*(evalstring(model)->rules->srcOLnwell + evalstring(model)->rules->srcDrnSP) + 
      evalstring(model)->rules->minDrnW + 2*evalstring(model)->rules->drnBevW +
      (fw + 2*evalstring(model)->rules->wellOLdrn))
    as = 2*((designRules->licon1->minW + 2*designRules->licon1->minDcontSPpoly) * fw) +
      ( fix(0.5*(nf-2)) * 2*(designRules->licon1->minW + 2*designRules->licon1->minDcontSPpoly) * fw )
    ad = fix(0.5*nf) * (2*(evalstring(model)->rules->srcOLnwell + evalstring(model)->rules->srcDrnSP) + 
      evalstring(model)->rules->minDrnW + 2*evalstring(model)->rules->drnBevW) *
      (fw + 2*evalstring(model)->rules->wellOLdrn)
    nrs = ((0.5*designRules->licon1->minW + designRules->licon1->minDcontSPpoly) / fw) / (2 + fix(0.5*(nf-2)))
    nrd = (0.35 / (fw + 2*(evalstring(model)->rules->wellOLdrn))) / fix(0.5*nf)
    cdfgData->ps->value = cdfParseFloatString(S130TruncateZeros(ps))
    cdfgData->pd->value = cdfParseFloatString(S130TruncateZeros(pd))
    cdfgData->as->value = cdfParseFloatString(S130TruncateZeros(as))
    cdfgData->ad->value = cdfParseFloatString(S130TruncateZeros(ad))
    cdfgData->nrs->value = cdfParseFloatString(S130TruncateZeros(nrs))
    cdfgData->nrd->value = cdfParseFloatString(S130TruncateZeros(nrd))

  ); let
); procedure S130fet12vCB

;---------------------------------------
; Main callback for 20V fets (DE)
;---------------------------------------
procedure( S130fet20vCB(@optional (param nil) )
  let( ( cv tfId grid fw l nf m minW maxW minL maxL
        minNf maxNf minM maxM w totalW
        ps as nrs pd ad nrd pdnw adnw )

    cv = cdfgData->id~>master || cdfgData->id
    tfId = techGetTechFile(cv)
    grid = techGetMfgGridResolution(tfId)

    ; base params
    ;-----------------------------------------------------------
    fw            = cdfgData->fw->value
    l             = cdfgData->l->value
    nf            = cdfgData->nf->value
    m             = cdfgData->m->value
    ;gateCntExt    = cdfgData->gateCntExt->value

    ; in case a device type is changed, ensure these params are reset to default values
    cdfgData->model->value    = cdfgData->model->defValue
    cdfgData->lvsModel->value = cdfgData->lvsModel->defValue
    cdfgData->info->value     = cdfgData->info->defValue
    minW          = cdfgData->minfw->value
    maxW          = cdfgData->maxfw->value
    minL          = cdfgData->minl->value
    maxL          = cdfgData->maxl->value
    minNf         = cdfgData->minnf->value
    maxNf         = cdfgData->maxnf->value
    minM          = cdfgData->minm->value
    maxM          = cdfgData->maxm->value

    pdnw = 0.0
    adnw = 0.0

    caseq( param

      ( fw
        fw = S130Round(fw grid)
        fw = S130CheckRange(cdfgData->fw->prompt fw minW maxW)
        cdfgData->fw->value = cdfParseFloatString(S130TruncateZeros(fw))
      ); fw param

      ( l
        l = S130Round(l grid)
        l = S130CheckRange(cdfgData->l->prompt l minL maxL)
        cdfgData->l->value = cdfParseFloatString(S130TruncateZeros(l))
      ); l param

      ( nf
        nf = fix(nf)
        when( oddp(nf)
          warn(sprintf(nil "%L has to be a factor of 2 (changing %d to %d)"
            cdfgData->nf->prompt nf nf+1))
          nf = nf + 1
        ); when odd
        nf = S130CheckRange(cdfgData->nf->prompt nf minNf maxNf)
        cdfgData->nf->value = nf
      )
      ( m
        m = fix(m) 
        m = S130CheckRange(cdfgData->m->prompt m minM maxM)
        cdfgData->m->value = m
      )
      /*
      ( gateCntExt 
        gateCntExt = S130Round(gateCntExt grid)
        gateCntExt = S130CheckRange(cdfgData->gateCntExt->prompt gateCntExt 0.0 10.0)
        cdfgData->gateCntExt->value = cdfParseFloatString(S130TruncateZeros(gateCntExt))
      ); gateCntExt param
      */

    ); caseq

    ; Grabbing params again in case they changed due to param callbacks above
    ;-----------------------------------------------------------
    fw            = cdfgData->fw->value
    l             = cdfgData->l->value
    nf            = cdfgData->nf->value
    m             = cdfgData->m->value
    ;gateCntExt    = cdfgData->gateCntExt->value

    ; calculate total width
    ;-----------------------------------------------------------
    w = S130Round(fw*nf grid)
    cdfgData->w->value = cdfParseFloatString(S130TruncateZeros(w))
    totalW = S130Round(fw*nf*m grid)
    cdfgData->totalW->value = cdfParseFloatString(S130TruncateZeros(totalW))
    cdfgData->tm->value = int(nf*m)

    ; calculate s/d params
    ;-----------------------------------------------------------
    ; s/d params are hard values until these devices become continuous
    ; currently the layouts are fixed
    case( cdfgData->model->value
      ( "nmos_de_v20"
        ps = 2*(fw + 2*0.29)    ; nf * (fw + 2* src diff ext from gate)
        pd = 2*(38.0 + 7.75)    ; dnwell over drain perim
        as = 2*(fw * 0.29)      ; nf * (fw * src diff ext from gate)
        ad = 38.0 * 7.75        ; dnwell over drain area
        nrs = (0.145 / fw) / 2  ; (gate to mid src cont / fw) / nf
        nrd = 0.35 / fw         ; sti depth / fw
      )
      ( "nmos_de_nat_v20"
        ps = 2*(fw + 2*0.29)    ; nf * (fw + 2* src diff ext from gate)
        pd = 2*(38.0 + 7.75)    ; dnwell over drain perim
        as = 2*(fw * 0.29)      ; nf * (fw * src diff ext from gate)
        ad = 38.0 * 7.75        ; dnwell over drain area
        nrs = (0.145 / fw) / 2  ; (gate to mid src cont / fw) / nf
        nrd = 0.35 / fw         ; sti depth / fw
      )
      ( "nmos_de_zvt_v20"
        ps = 2*(fw + 2*0.29)    ; nf * (fw + 2* src diff ext from gate)
        pd = 2*(36.0 + 5.75)    ; dnwell over drain perim
        as = 2*(fw * 0.29)      ; nf * (fw * src diff ext from gate)
        ad = 36.0 * 5.75        ; dnwell over drain area
        nrs = (0.145 / fw) / 2  ; (gate to mid src cont / fw) / nf
        nrd = 0.35 / fw         ; sti depth / fw
      )
      ( "nmos_de_iso_v20"
        ps = 2*(fw + 2*0.63)    ; nf * (fw + 2* src diff ext from gate)
        pd = 2*2*(34.0 + 4.38)  ; pwbm hole perim
        as = 2*(fw * 0.63)      ; nf * (fw * src diff ext from gate)
        ad = 2*(34.0 * 4.38)    ; pwbm hole area
        nrs = (0.145 / fw) / 2  ; (gate to mid src cont / fw) / nf
        nrd = (0.35 / fw) / 2   ; sti depth / fw
        pdnw = 2*(fw + 1.6)     ; nwell over drain perim
        adnw = fw * 1.6         ; nwell over drain area
        cdfgData->pdnw->value = cdfParseFloatString(S130TruncateZeros(pdnw))
        cdfgData->adnw->value = cdfParseFloatString(S130TruncateZeros(adnw))
      )
      ( "pmos_de_v20"
        ps = 2*(fw + 2*0.29)    ; nf * (fw + 2* src diff ext from gate)
        pd = 2*(35.0 + 4.75)    ; pwde over drain perim
        as = 2*(fw * 0.29)      ; nf * (fw * src diff ext from gate)
        ad = 35.0 * 4.75        ; pwde over drain area
        nrs = (0.145 / fw) / 2  ; (gate to mid src cont / fw) / nf
        nrd = 0.35 / fw         ; sti depth / fw
      )
    )
    cdfgData->ps->value = cdfParseFloatString(S130TruncateZeros(ps))
    cdfgData->pd->value = cdfParseFloatString(S130TruncateZeros(pd))
    cdfgData->as->value = cdfParseFloatString(S130TruncateZeros(as))
    cdfgData->ad->value = cdfParseFloatString(S130TruncateZeros(ad))
    cdfgData->nrs->value = cdfParseFloatString(S130TruncateZeros(nrs))
    cdfgData->nrd->value = cdfParseFloatString(S130TruncateZeros(nrd))
  ); let
); procedure S130fet20vCB

/*==============================================================================
  ***** Resistor CDF Callback Definitions *****
==============================================================================*/

;---------------------------------------
; Main callback for rpoly_hp/rpoly_hp2K
;---------------------------------------
; Many values in this are hard coded, in the future this could use 
; variables loaded from the techData file

procedure( S130hrpolyCB(@optional param)
  let( (cv mfgGrid m
        res resMax resMin segL segLMax segLMin segW segWMax segWMin segments
        segmentsMax segmentsMin contRows contRowsMax contRowsMin rType rCalcMethod
        segmentSP segmentSPMax segmentSPMin rtn serpL segSP lHead )

    cv = cdfgData->id~>master || cdfgData->id
    mfgGrid = techGetMfgGridResolution(techGetTechFile(cv)) || 0.005

    ; base params
    m = cdfgData->m->value
    m = fix(m) 
    m = S130CheckRange(cdfgData->m->prompt m 1 500)
    cdfgData->m->value = m

    if( cdfgData->wellType->value == "Pwell" then
      cdfgData->lvsModel->value = strcat(cdfgData->model->value "_pw")
    else
      cdfgData->lvsModel->value = strcat(cdfgData->model->value "_nw")
    )

    rType = cdfgData->rType->value
    rCalcMethod = cdfgData->rCalcMethod->value 
    res = cdfParseFloatString(cdfgData->res->value)
    segL = cdfParseFloatString(cdfgData->segL->value)
    segW = cdfParseFloatString(cdfgData->segW->value)
    segments = cdfgData->segments->value
    contRows = cdfgData->contRows->value
    segmentSP = cdfParseFloatString(cdfgData->segmentSP->value)

    ; param min/max values
    resMax = 2.0e12
    resMin = 0.001 
    segLMax = 500.0
    contRowsMax = 5 

    ; needs to be revisited as the contRows can break the serp r
    ; just set some limits so it won't make a mess
    if( rType == "Serpentine" && segments > 1 then

      ; segL can't be <= lHead*2
      segLMin = designRules->pres->contL + designRules->pres->polyOLScont + mfgGrid

      lHead = designRules->pres->contL + designRules->pres->polyOLScont +
        (contRows - 1)*(designRules->pres->contL + designRules->pres->contSP)
      ; find the correct number of contRows
      while( lHead > 0.5*(segL-mfgGrid) || contRows < 1
        contRows = contRows - 1
        lHead = designRules->pres->contL + designRules->pres->polyOLScont +
          (contRows - 1)*(designRules->pres->contL + designRules->pres->contSP)
      ); while
      contRows = max(1 contRows)

      if( contRows < cdfgData->contRows->value then
        warn("Segment length must be > 2*segment Head, adjusting Contact Rows to %d" contRows)
        cdfgData->contRows->value = contRows
      )
      contRowsMax = min( contRowsMax max( 1 contRows
        ((segL + mfgGrid - designRules->pres->contL - designRules->pres->polyOLScont) /
        (designRules->pres->contL + designRules->pres->contSP)) + 1
        ))

      ; recheck segL vs lHead
      lHead = designRules->pres->contL + designRules->pres->polyOLScont +
        (contRows - 1)*(designRules->pres->contL + designRules->pres->contSP)
      if( contRows == 1 && lHead > 0.5*(segL-mfgGrid) then
        warn("Segment length must be > 2*segment Head, adjusting segment Length" )
        segL = 2*lHead + mfgGrid
      ); if

      ; due to construction, segL needs to be > 2*segW + poly spacing
      when( segL < 2*segW + designRules->poly->minSP
        segL = S130Round(2*segW + designRules->poly->minSP mfgGrid)
        warn("For Serpentines, the segment Length must be > 2* segment Width + poly spacing.")
      ); when
    else
      segLMin = 0.5 
    ); if Serpentine & m>1
    segWMax = 100.0 
    segWMin = 0.33 
    segmentsMax = 50 
    segmentsMin = 1 
    contRowsMin = 1
    segmentSPMax = 2.0 
    ; segmentSPMin depends on if the segW is less than presContW+2*max(polyOLpresContW li1OLLlicon1) &
    ; spacing of poly or li1 or slotted licon1
    ; preslicon1MinW = 0.19, polyOLpresContW = 0.05 li1OLLlicon1 = 0.08 polyMinSP = 0.21 li1MinSP = 0.14 licon1SP = 0.51
    ; only written out so later the numbers can be replaced with variables
    ; Also check in the segW check as the segW effects the segmentSPMin
    segmentSPMin = 
            if( (rType == "Serpentine" && segments != 2) || (segW + 0.21) > 0.19+0.51 then
              0.21
            else
              max( 2*0.08+0.19+0.14, 2*0.05+0.19+0.21, 0.19+0.51) - segW
            )
    when( rType == "Serpentine" 
      segmentSP = segmentSPMin
      cdfgData->segmentSP->value = sprintf( nil "%.3f" segmentSP )
    )

    caseq( param

      ( res
        if( numberp(res) then
          res = S130Round(res 0.001)
          res = S130CheckRange(cdfgData->res->prompt res resMin resMax)

          rtn = S130hrpolyResCalc(rCalcMethod res segL segW segments contRows rType mfgGrid)

          ;; check segL, res limits
          ;; check if segL will violate limits, recalc res
          if( atof(nth(1 rtn)) > segLMax then
            warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
              cdfgData->segL->prompt nth(1 rtn) segLMax cdfgData->res->prompt))
            rtn = S130hrpolyResCalc("Segment Length" res segLMax segW segments contRows rType mfgGrid)
          else
            if( atof(nth(1 rtn)) < segLMin then
              warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                cdfgData->segL->prompt nth(1 rtn) segLMin cdfgData->res->prompt))
              rtn = S130hrpolyResCalc("Segment Length" res segLMin segW segments contRows rType mfgGrid)
            ); if
          ); if

          cdfgData->res->value = nth(0 rtn) 
          cdfgData->segL->value = nth(1 rtn) 
        ); if 
      ); end res param

      ( segL 
        if( numberp(segL) then
          segL = S130Round(segL mfgGrid)
          segL = S130CheckRange(cdfgData->segL->prompt segL segLMin segLMax)

          rtn = S130hrpolyResCalc(rCalcMethod res segL segW segments contRows rType mfgGrid)

          ;; check segL, res limits
          ;; check if res will violate limits, recalc segL 
          if( atof(nth(0 rtn)) > resMax then
            warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
              cdfgData->res->prompt nth(0 rtn) resMax cdfgData->segL->prompt))
            rtn = S130hrpolyResCalc("Total Resistance" resMax segL segW segments contRows rType mfgGrid)
          else
            if( atof(nth(0 rtn)) < resMin then
              warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                cdfgData->res->prompt nth(0 rtn) resMin cdfgData->segL->prompt))
              rtn = S130hrpolyResCalc("Total Resistance" resMin segL segW segments contRows rType mfgGrid)
            ); if
          ); if

          cdfgData->res->value = nth(0 rtn) 
          cdfgData->segL->value = nth(1 rtn) 
        ); if
      ); end segL param

      ( segW
        if( numberp(segW) then
          segW = S130Round(segW 2*mfgGrid)
          segW = S130CheckRange(cdfgData->segW->prompt segW segWMin segWMax)

          ; the segW can effect the segmentSP if the segW creates a dogbone
          segmentSPMin = 
            if( rType == "Serpentine" || (segW + 0.21) > 0.19+0.51 then
              0.21
            else
              max( 2*0.08+0.19+0.14, 2*0.05+0.19+0.21, 0.19+0.51 ) - segW
            )
          segmentSP = S130CheckRange(cdfgData->segmentSP->prompt segmentSP segmentSPMin segmentSPMax)
          cdfgData->segmentSP->value = sprintf( nil "%.3f" segmentSP )

          rtn = S130hrpolyResCalc(rCalcMethod res segL segW segments contRows rType mfgGrid)

          cdfgData->segW->value = S130TruncateZeros(segW)
          
          ;; check segL, res limits
          case( rCalcMethod 
            ("Total Resistance"
              ;; check if segL will violate limits, recalc res
              if( atof(nth(1 rtn)) > segLMax then
                warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                  cdfgData->segL->prompt nth(1 rtn) segLMax cdfgData->res->prompt))
                rtn = S130hrpolyResCalc("Segment Length" res segLMax segW segments contRows rType mfgGrid)
              else
                if( atof(nth(1 rtn)) < segLMin then
                  warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                    cdfgData->segL->prompt nth(1 rtn) segLMin cdfgData->res->prompt))
                  rtn = S130hrpolyResCalc("Segment Length" res segLMin segW segments contRows rType mfgGrid)
                ); if
              ); if

              ;; check if res will violate limits, recalc segL 
              if( atof(nth(0 rtn)) > resMax then
                warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                  cdfgData->res->prompt nth(0 rtn) resMax cdfgData->segL->prompt))
                rtn = S130hrpolyResCalc("Total Resistance" resMax segL segW segments contRows rType mfgGrid)
              else
                if( atof(nth(0 rtn)) < resMin then
                  warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                    cdfgData->res->prompt nth(0 rtn) resMin cdfgData->segL->prompt))
                  rtn = S130hrpolyResCalc("Total Resistance" resMin segL segW segments contRows rType mfgGrid)
                ); if
              ); if
            )
            ("Segment Length"
              ;; check if res will violate limits, recalc segL 
              if( atof(nth(0 rtn)) > resMax then
                warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                  cdfgData->res->prompt nth(0 rtn) resMax cdfgData->segL->prompt))
                rtn = S130hrpolyResCalc("Total Resistance" resMax segL segW segments contRows rType mfgGrid)
              else
                if( atof(nth(0 rtn)) < resMin then
                  warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                    cdfgData->res->prompt nth(0 rtn) resMin cdfgData->segL->prompt))
                  rtn = S130hrpolyResCalc("Total Resistance" resMin segL segW segments contRows rType mfgGrid)
                ); if
              ); if

              ;; check if segL will violate limits, recalc res
              if( atof(nth(1 rtn)) > segLMax then
                warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                  cdfgData->segL->prompt nth(1 rtn) segLMax cdfgData->res->prompt))
                rtn = S130hrpolyResCalc("Segment Length" res segLMax segW segments contRows rType mfgGrid)
              else
                if( atof(nth(1 rtn)) < segLMin then
                  warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                    cdfgData->segL->prompt nth(1 rtn) segLMin cdfgData->res->prompt))
                  rtn = S130hrpolyResCalc("Segment Length" res segLMin segW segments contRows rType mfgGrid)
                ); if
              ); if
            )
          ); case 

          ;; reset segL, res values
          cdfgData->res->value = nth(0 rtn) 
          cdfgData->segL->value = nth(1 rtn) 
        ); if
      ); end segW param

      ( segmentSP 
        if( numberp(segmentSP) then
          segmentSP = S130Round(segmentSP mfgGrid)
          segmentSP = S130CheckRange(cdfgData->segmentSP->prompt segmentSP segmentSPMin segmentSPMax)
          cdfgData->segmentSP->value = sprintf( nil "%.3f" segmentSP )

          when( rType == "Serpentine" && segments > 1
            rtn = S130hrpolyResCalc(rCalcMethod res segL segW segments contRows rType mfgGrid)

            ;; check segL, res limits
            ;; check if res will violate limits, recalc segL 
            if( atof(nth(0 rtn)) > resMax then
              warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                cdfgData->res->prompt nth(0 rtn) resMax cdfgData->segL->prompt))
              rtn = S130hrpolyResCalc("Total Resistance" resMax segL segW segments contRows rType mfgGrid)
            else
              if( atof(nth(0 rtn)) < resMin then
                warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                  cdfgData->res->prompt nth(0 rtn) resMin cdfgData->segL->prompt))
                rtn = S130hrpolyResCalc("Total Resistance" resMin segL segW segments contRows rType mfgGrid)
              ); if
            ); if

            cdfgData->res->value = nth(0 rtn) 
            cdfgData->segL->value = nth(1 rtn) 
          ); when Serpentine
        ); if
      ); end segmentSP param

      ( rType 
        segmentSP = segmentSPMin
        cdfgData->segmentSP->value = sprintf( nil "%.3f" segmentSP )

        rtn = S130hrpolyResCalc(rCalcMethod res segL segW segments contRows rType mfgGrid)

        ;; check segL, res limits
        case( rCalcMethod 
          ("Total Resistance"
            ;; check if segL will violate limits, recalc res
            if( atof(nth(1 rtn)) > segLMax then
              warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                cdfgData->segL->prompt nth(1 rtn) segLMax cdfgData->res->prompt))
              rtn = S130hrpolyResCalc("Segment Length" res segLMax segW segments contRows rType mfgGrid)
            else
              if( atof(nth(1 rtn)) < segLMin then
                warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                  cdfgData->segL->prompt nth(1 rtn) segLMin cdfgData->res->prompt))
                rtn = S130hrpolyResCalc("Segment Length" res segLMin segW segments contRows rType mfgGrid)
              ); if
            ); if

            ;; check if res will violate limits, recalc segL 
            if( atof(nth(0 rtn)) > resMax then
              warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                cdfgData->res->prompt nth(0 rtn) resMax cdfgData->segL->prompt))
              rtn = S130hrpolyResCalc("Total Resistance" resMax segL segW segments contRows rType mfgGrid)
            else
              if( atof(nth(0 rtn)) < resMin then
                warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                  cdfgData->res->prompt nth(0 rtn) resMin cdfgData->segL->prompt))
                rtn = S130hrpolyResCalc("Total Resistance" resMin segL segW segments contRows rType mfgGrid)
              ); if
            ); if
          )
          ("Segment Length"
            ;; check if res will violate limits, recalc segL 
            if( atof(nth(0 rtn)) > resMax then
              warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                cdfgData->res->prompt nth(0 rtn) resMax cdfgData->segL->prompt))
              rtn = S130hrpolyResCalc("Total Resistance" resMax segL segW segments contRows rType mfgGrid)
            else
              if( atof(nth(0 rtn)) < resMin then
                warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                  cdfgData->res->prompt nth(0 rtn) resMin cdfgData->segL->prompt))
                rtn = S130hrpolyResCalc("Total Resistance" resMin segL segW segments contRows rType mfgGrid)
              ); if
            ); if

            ;; check if segL will violate limits, recalc res
            if( atof(nth(1 rtn)) > segLMax then
              warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                cdfgData->segL->prompt nth(1 rtn) segLMax cdfgData->res->prompt))
              rtn = S130hrpolyResCalc("Segment Length" res segLMax segW segments contRows rType mfgGrid)
            else
              if( atof(nth(1 rtn)) < segLMin then
                warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                  cdfgData->segL->prompt nth(1 rtn) segLMin cdfgData->res->prompt))
                rtn = S130hrpolyResCalc("Segment Length" res segLMin segW segments contRows rType mfgGrid)
              ); if
            ); if
          )
        ); case 

        ;; reset segL, res values
        cdfgData->res->value = nth(0 rtn) 
        cdfgData->segL->value = nth(1 rtn) 
      ); end rType param

      ( segments 
        if( numberp(segments) then
          segments = S130CheckRange(cdfgData->segments->prompt segments segmentsMin segmentsMax)

          rtn = S130hrpolyResCalc(rCalcMethod res segL segW segments contRows rType mfgGrid)

          cdfgData->segments->value = segments
  
          ;; check segL, res limits
          case( rCalcMethod 
            ("Total Resistance"
              ;; check if segL will violate limits, recalc res
              if( atof(nth(1 rtn)) > segLMax then
                warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                  cdfgData->segL->prompt nth(1 rtn) segLMax cdfgData->res->prompt))
                rtn = S130hrpolyResCalc("Segment Length" res segLMax segW segments contRows rType mfgGrid)
              else
                if( atof(nth(1 rtn)) < segLMin then
                  warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                    cdfgData->segL->prompt nth(1 rtn) segLMin cdfgData->res->prompt))
                  rtn = S130hrpolyResCalc("Segment Length" res segLMin segW segments contRows rType mfgGrid)
                ); if
              ); if

              ;; check if res will violate limits, recalc segL 
              if( atof(nth(0 rtn)) > resMax then
                warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                  cdfgData->res->prompt nth(0 rtn) resMax cdfgData->segL->prompt))
                rtn = S130hrpolyResCalc("Total Resistance" resMax segL segW segments contRows rType mfgGrid)
              else
                if( atof(nth(0 rtn)) < resMin then
                  warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                    cdfgData->res->prompt nth(0 rtn) resMin cdfgData->segL->prompt))
                  rtn = S130hrpolyResCalc("Total Resistance" resMin segL segW segments contRows rType mfgGrid)
                ); if
              ); if
            )
            ("Segment Length"
              ;; check if res will violate limits, recalc segL 
              if( atof(nth(0 rtn)) > resMax then
                warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                  cdfgData->res->prompt nth(0 rtn) resMax cdfgData->segL->prompt))
                rtn = S130hrpolyResCalc("Total Resistance" resMax segL segW segments contRows rType mfgGrid)
              else
                if( atof(nth(0 rtn)) < resMin then
                  warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                    cdfgData->res->prompt nth(0 rtn) resMin cdfgData->segL->prompt))
                  rtn = S130hrpolyResCalc("Total Resistance" resMin segL segW segments contRows rType mfgGrid)
                ); if
              ); if

              ;; check if segL will violate limits, recalc res
              if( atof(nth(1 rtn)) > segLMax then
                warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                  cdfgData->segL->prompt nth(1 rtn) segLMax cdfgData->res->prompt))
                rtn = S130hrpolyResCalc("Segment Length" res segLMax segW segments contRows rType mfgGrid)
              else
                if( atof(nth(1 rtn)) < segLMin then
                  warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                    cdfgData->segL->prompt nth(1 rtn) segLMin cdfgData->res->prompt))
                  rtn = S130hrpolyResCalc("Segment Length" res segLMin segW segments contRows rType mfgGrid)
                ); if
              ); if
            )
          ); case 

          ;; reset segL, res values
          cdfgData->res->value = nth(0 rtn) 
          cdfgData->segL->value = nth(1 rtn) 
        ); if 
      ); end segments param

      ( contRows 
        if( numberp(contRows) then
          contRows = S130CheckRange(cdfgData->contRows->prompt contRows contRowsMin contRowsMax)

          rtn = S130hrpolyResCalc(rCalcMethod res segL segW segments contRows rType mfgGrid)

          cdfgData->contRows->value = contRows
  
          /* this will only be needed if rHead changes but we are keeping it to only one contRow

          ;; check segL, res limits
          case( rCalcMethod 
            ("Total Resistance"
              ;; check if segL will violate limits, recalc res
              if( atof(nth(1 rtn)) > segLMax then
                warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                  cdfgData->segL->prompt nth(1 rtn) segLMax cdfgData->res->prompt))
                rtn = S130hrpolyResCalc("Segment Length" res segLMax segW segments contRows rType mfgGrid)
              else
                if( atof(nth(1 rtn)) < segLMin then
                  warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                    cdfgData->segL->prompt nth(1 rtn) segLMin cdfgData->res->prompt))
                  rtn = S130hrpolyResCalc("Segment Length" res segLMin segW segments contRows rType mfgGrid)
                ); if
              ); if

              ;; check if res will violate limits, recalc segL 
              if( atof(nth(0 rtn)) > resMax then
                warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                  cdfgData->res->prompt nth(0 rtn) resMax cdfgData->segL->prompt))
                rtn = S130hrpolyResCalc("Total Resistance" resMax segL segW segments contRows rType mfgGrid)
              else
                if( atof(nth(0 rtn)) < resMin then
                  warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                    cdfgData->res->prompt nth(0 rtn) resMin cdfgData->segL->prompt))
                  rtn = S130hrpolyResCalc("Total Resistance" resMin segL segW segments contRows rType mfgGrid)
                ); if
              ); if
            )
            ("Segment Length"
              ;; check if res will violate limits, recalc segL 
              if( atof(nth(0 rtn)) > resMax then
                warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                  cdfgData->res->prompt nth(0 rtn) resMax cdfgData->segL->prompt))
                rtn = S130hrpolyResCalc("Total Resistance" resMax segL segW segments contRows rType mfgGrid)
              else
                if( atof(nth(0 rtn)) < resMin then
                  warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                    cdfgData->res->prompt nth(0 rtn) resMin cdfgData->segL->prompt))
                  rtn = S130hrpolyResCalc("Total Resistance" resMin segL segW segments contRows rType mfgGrid)
                ); if
              ); if

              ;; check if segL will violate limits, recalc res
              if( atof(nth(1 rtn)) > segLMax then
                warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                  cdfgData->segL->prompt nth(1 rtn) segLMax cdfgData->res->prompt))
                rtn = S130hrpolyResCalc("Segment Length" res segLMax segW segments contRows rType mfgGrid)
              else
                if( atof(nth(1 rtn)) < segLMin then
                  warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                    cdfgData->segL->prompt nth(1 rtn) segLMin cdfgData->res->prompt))
                  rtn = S130hrpolyResCalc("Segment Length" res segLMin segW segments contRows rType mfgGrid)
                ); if
              ); if
            )
          ); case 

          ;; reset segL, res values
          cdfgData->res->value = nth(0 rtn) 
          cdfgData->segL->value = nth(1 rtn) 
          */
        ); if 
      ); end contRows param

    ); caseq
    
    ; grab all the values needed after they have been updated
    segL = cdfParseFloatString(cdfgData->segL->value)
    segW = cdfParseFloatString(cdfgData->segW->value)
    segments = cdfgData->segments->value
    contRows = cdfgData->contRows->value
    segSP = cdfParseFloatString(cdfgData->segmentSP->value)

    lHead = designRules->pres->contL + designRules->pres->polyOLScont +
          (contRows - 1)*(designRules->pres->contL + designRules->pres->contSP)

    if( rType == "Serpentine" then
      cond(
        ( segments == 1  serpL = segL )
        ( segments == 2  serpL = 2*(segL - lHead - segW) + segSP + sqrt(2*expt(segW 2)) )
        ( segments > 2   serpL = 2*(segL - lHead - segW) + (segments-1)*(segSP +
          sqrt(2*expt(segW 2))) + (segments-2)*(segL-2*segW) )
      ); cond
      cdfgData->serpL->value = sprintf( nil "%.3f" serpL )
    else
      cdfgData->serpL->value = "0.0"
    )

    S130CalcNetlistValues()

  ); let
); procedure S130hrpolyCB

;---------------------------------------
; Calculate Resistance - hrpoly
;---------------------------------------
procedure( S130hrpolyResCalc(rCalcMethod res segL segW segments contRows rType mfgGrid)
  let((rshPoly cornerFactor rHead tmpsegL segLStr tmpres resStr lHead polyConnL totalL)

    ;; Calculate segment length from resistance
    ;rshPoly = 319.8
    rshPoly = cdfParseFloatString(cdfgData->sheetRho->value)
    polyConnL = cdfParseFloatString(cdfgData->segmentSP->value)
    cornerFactor = 0.56
    rHead = S130hrpolyRheadCalc(segW)
    ; set headRes in cdf
    cdfgData->headRes->value = sprintf(nil "%f" rHead ) 
    ;lHead = 2.08 + 2.35*(contRows - 1)
    lHead = designRules->pres->contL + designRules->pres->polyOLScont +
          (contRows - 1)*(designRules->pres->contL + designRules->pres->contSP)

    case( rType
      ( "Series"
        case( rCalcMethod 
          ("Total Resistance"
            totalL = (res-2*rHead*segments)*segW/rshPoly
            tmpsegL = totalL/segments 
            tmpsegL = S130Round(tmpsegL mfgGrid)
  
            ;; Recalculate resistance after rounding segment L to grid
            tmpres = (rshPoly*(tmpsegL/segW) + 2*rHead)*segments
          )
          ("Segment Length"
            tmpres = (rshPoly*(segL/segW) + 2*rHead)*segments
  
            ;; pass segL back out unchanged 
            tmpsegL = segL 
          )
        ); case 
        cdfgData->segRes->value = sprintf(nil "%f" rshPoly*(tmpsegL/segW) )
      ); "Series"
      ( "Parallel"
        case( rCalcMethod 
          ("Total Resistance"
            totalL = (res-2*rHead/segments)*segW/rshPoly
            tmpsegL = totalL*segments 
            tmpsegL = S130Round(tmpsegL mfgGrid)
  
            ;; Recalculate resistance after rounding segment L to grid
            tmpres = (rshPoly*(tmpsegL/segW) + 2*rHead)/segments
          )
          ("Segment Length"
            tmpres = (rshPoly*(segL/segW) + 2*rHead)/segments
  
            ;; pass segL back out unchanged 
            tmpsegL = segL 
          )
        ); case 
        cdfgData->segRes->value = sprintf(nil "%f" rshPoly*(tmpsegL/segW) )
      ); "Parallel"
      ( "Serpentine"
        cond(
          (segments == 1
            case( rCalcMethod 
              ("Total Resistance"
                tmpsegL = (segW/rshPoly)*(res - 2*rHead) 
                tmpsegL = S130Round(tmpsegL mfgGrid)

                ;; Recalculate resistance after rounding segment L to grid
                tmpres = (rshPoly*tmpsegL)/segW + 2*rHead
              )
              ("Segment Length"
                tmpres = (rshPoly*segL)/segW + 2*rHead

                ;; pass segL back out unchanged 
                tmpsegL = segL 
              )
            ); case 
            cdfgData->segRes->value = sprintf(nil "%f" tmpres-2*rHead )
          )
          (segments == 2
            case( rCalcMethod 
              ("Total Resistance"
                totalL = (res-2*rHead-rshPoly*(2*cornerFactor + polyConnL/segW))*segW/rshPoly
                tmpsegL = 0.5*totalL+segW+lHead
                tmpsegL = S130Round(tmpsegL mfgGrid)

                ;; Recalculate resistance after rounding segment L to grid
                tmpres = rshPoly*(2*(tmpsegL-segW-lHead)+polyConnL+2*cornerFactor*segW)/segW + 2*rHead
              )
              ("Segment Length"
                tmpres = rshPoly*(2*(segL-segW-lHead)+polyConnL+2*cornerFactor*segW)/segW + 2*rHead

                ;; pass segL back out unchanged 
                tmpsegL = segL 
              )
            ); case 
            cdfgData->segRes->value = sprintf(nil "%f" rshPoly*(tmpsegL-segW-lHead)/segW )
          )
          (segments > 2
            case( rCalcMethod 
              ("Total Resistance"
                totalL = (res-2*rHead-(segments-1)*rshPoly*(2*cornerFactor + polyConnL/segW))*segW/rshPoly
                tmpsegL = (totalL+2*(lHead-segW))/segments+2*segW
                tmpsegL = S130Round(tmpsegL mfgGrid)

                ;; Recalculate resistance after rounding segment L to grid
                tmpres = rshPoly*(2*(tmpsegL-segW-lHead)+(segments-2)*(tmpsegL-2*segW)+
                  (segments-1)*(polyConnL+2*cornerFactor*segW))/segW + 2*rHead
              )
              ("Segment Length"
                tmpres = rshPoly*(2*(segL-segW-lHead)+(segments-2)*(segL-2*segW)+
                  (segments-1)*(polyConnL+2*cornerFactor*segW))/segW + 2*rHead

                ;; pass segL back out unchanged 
                tmpsegL = segL 
              )
            ); case 
            cdfgData->segRes->value = sprintf(nil "%f" rshPoly*(tmpsegL-2*segW)/segW )
          )
        ); cond
      ); "Serpentine"
    ); case

    ;; format outputs 
    if( (abs(tmpres - 1000.0) < 1e-6) || (tmpres > 1000.0) then
      resStr = cdfFormatFloatString(sprintf(nil "%.0f" tmpres) "auto")
    else
      resStr = cdfFormatFloatString(sprintf(nil "%.3f" tmpres) "auto")
    ); if
    segLStr = S130TruncateZeros(tmpsegL)

    list(resStr segLStr)

  ); let
); procedure S130hrpolyResCalc

;---------------------------------------
; Calculate hrpoly Head Resistance
;---------------------------------------
procedure( S130hrpolyRheadCalc(segW)
  let((rHead)
    ;; R head calculation
    ;;segW  Rhead
    ;;0.35  294.995
    ;;0.69  194.95
    ;;1.41  127.385
    ;;2.85  65.18
    ;;5.73  34.025
    ;;10    17.0125
    ;;20    8.50625
    ;;40    4.253125
    ;;80    2.1265625
    ;;160   1.06328125
    ;;320   0.531640625
    ;;640   0.2658203125
    ;;1280  0.13291015625

    cond(
      (segW <= 0.35                 rHead =  294.995 )
      (segW > 0.35 && segW <= 0.69  rHead = -294.25*segW     + 397.9825 )
      (segW > 0.69 && segW <= 1.41  rHead = -93.8402778*segW + 259.7 )
      (segW > 1.41 && segW <= 2.85  rHead = -43.1979167*segW + 188.294 )
      (segW > 2.85 && segW <= 5.73  rHead = -10.8177083*segW + 96.01 )
      (segW > 5.73 && segW <= 10    rHead = -3.98419204*segW + 56.854 )
      (segW > 10 && segW <= 20      rHead = -0.850625*segW   + 25.519 )
      (segW > 20 && segW <= 40      rHead = -0.21265625*segW + 12.759 )
      (segW > 40 && segW <= 80      rHead = -0.05316406*segW + 6.38 )
      (segW > 80 && segW <= 160     rHead = -0.01329102*segW + 3.19 )
      (segW > 160 && segW <= 320    rHead = -0.00332275*segW + 1.595 )
      (segW > 320 && segW <= 640    rHead = -0.00083069*segW + 0.797 )
      (segW > 640 && segW <= 1280   rHead = -0.00020767*segW + 0.399 )
      (segW rHead = 0.0 )
    ); end cond

    ; since the model files only account for 1 contRow, keeping the head res to match
    ;rHead/contRows
    rHead

  ); let
); procedure S130hrpolyRheadCalc

;---------------------------------------
; Main callback for diff and base poly Resistors
;---------------------------------------
procedure(S130resCB(@optional param)
  let( (cv tfId grid model rType res segRes w l m rsh minW maxW minL maxL
        minSegSP maxSegSP maxRes minRes contRows segments segmentSP ) 

    cv = cdfgData->id~>master || cdfgData->id
    tfId = techGetTechFile(cv)
    grid = techGetMfgGridResolution(tfId)

    ; base params
    model     = cdfgData->model->value
    rType     = cdfgData->rType->value
    res       = cdfParseFloatString(cdfgData->res->value)
    w         = cdfgData->segW->value
    l         = cdfgData->segL->value
    rsh       = cdfgData->sheetRho->value
    segments  = cdfgData->segments->value
    segmentSP = cdfgData->segmentSP->value
    contRows  = cdfgData->contRows->value
    m         = cdfgData->m->value

    ; these will change based on the device
    ; the model name is the same as the device name, which is the same
    ; as what is defined in the S130techData.il file
    ; fudge factor added due to cadence being weird and thinking x doesn't = x
    minW = evalstring(strcat(model "->minW")) - 1e-9
    maxW = evalstring(strcat(model "->maxW"))
    minL = evalstring(strcat(model "->minL")) - 1e-9
    maxL = evalstring(strcat(model "->maxL"))

    ; ensure they enter a positive value for m
    ;-----------------------------
    m = fix(m) 
    m = S130CheckRange(cdfgData->m->prompt m 1 500)
    cdfgData->m->value = m

    case( param
      ( segmentSP
        ; check segmentSP
        ;-----------------------------
        if( rType == "Parallel" then
          ; no worries of the metal connections being too close when in parallel
          minSegSP = evalstring(strcat(model "->minSegSP"))
        else
          ; the metal layers are drawn within the reslayer, but could abut edges, so
          ; minSegSP is the max value between min spacing of reslayer, li1, and met1 
          minSegSP = max( evalstring(strcat(model "->minSegSP"))
            designRules->li1->minSP 
            if( w < designRules->met1->minWide then designRules->met1->minSP
            else designRules->met1->minSPwide + 0.01 ) )
        ); if rType
        maxSegSP = evalstring(strcat(model "->maxSegSP"))
        segmentSP = S130Round(segmentSP grid)
        segmentSP = S130CheckRange( cdfgData->segmentSP->prompt segmentSP minSegSP maxSegSP )
        cdfgData->segmentSP->value = segmentSP
      ); segmentSP
      ( segW
        ; clean up w
        ;-----------------------------
        w = S130Round(w 2*grid)
        w = S130CheckRange( cdfgData->segW->prompt w minW maxW )
        cdfgData->segW->value = evalstring(S130TruncateZeros(w))
        cdfgData->w->value = S130TruncateZeros(w)
      ); segW
      ( segments
        segments = fix(segments) 
        segments = S130CheckRange(cdfgData->segments->prompt segments 1 50)
        cdfgData->segments->value = segments
      ); segments
      ( contRows
        contRows = fix(contRows) 
        contRows = S130CheckRange(cdfgData->contRows->prompt contRows 1 10)
        cdfgData->contRows->value = contRows
      ); contRows
    ); case param

    case( param (rType || res || segL || segW || segments
      ; check res and segL
      ;-----------------------------
      if( cdfgData->rCalcMethod->value == "Total Resistance" then
        case( rType
          ("Series"
            minRes = (rsh*minL/w)*segments
            maxRes = (rsh*maxL/w)*segments
            res = S130CheckRange( cdfgData->res->prompt res minRes maxRes )
            segRes = res/segments
            l = S130Round(segRes*w/rsh grid)
            l = S130CheckRange( cdfgData->segL->prompt l minL maxL )
            segRes = rsh*l/w
            res = segRes*segments
          )
          ("Parallel"
            minRes = (rsh*minL/w)/segments
            maxRes = (rsh*maxL/w)/segments
            segRes = res*segments
            l = S130Round(segRes*w/rsh grid)
            l = S130CheckRange( cdfgData->segL->prompt l minL maxL )
            segRes = rsh*l/w
            res = segRes/segments
          )
        ); case rType
      else
        l = S130Round(l grid)
        l = S130CheckRange( cdfgData->segL->prompt l minL maxL )
        segRes = rsh*l/w
        case( rType
          ("Series"
            res = segRes*segments
          )
          ("Parallel"
            res = segRes/segments
          )
        ); case rType
      ); if rCalcMethod

      cdfgData->segL->value = evalstring(S130TruncateZeros(l))
      cdfgData->l->value = S130TruncateZeros(l)

      ;; format outputs 
      if( (abs(segRes - 1000.0) < 1e-6) || (segRes > 1000.0) then
        segRes = cdfFormatFloatString(sprintf(nil "%.0f" segRes) "auto")
      else
        segRes = cdfFormatFloatString(sprintf(nil "%.4f" segRes) "auto")
      ); if
      cdfgData->segRes->value = S130stringTruncateZeros(segRes)

      ;; format outputs 
      if( (abs(res - 1000.0) < 1e-6) || (res > 1000.0) then
        res = cdfFormatFloatString(sprintf(nil "%.0f" res) "auto")
      else
        res = cdfFormatFloatString(sprintf(nil "%.4f" res) "auto")
      ); if
      cdfgData->res->value = S130stringTruncateZeros(res)
    )); param rType || res || segL || segW || segments

  ); let
); procedure S130resCB

;---------------------------------------
; Main callback for rpwell
;---------------------------------------
procedure(S130rpwellCB()
  let( (cv tfId grid w l m rsh minW maxW minL maxL res deltaL ) 

    cv = cdfgData->id~>master || cdfgData->id
    tfId = techGetTechFile(cv)
    grid = techGetMfgGridResolution(tfId)

    ; base params
    w     = cdfgData->w->value
    l     = cdfgData->l->value
    res   = cdfParseFloatString(cdfgData->res->value)
    rsh   = cdfgData->sheetRho->value

    ; these will change based on the rType
    minW = rpwell->rules->minW
    maxW = rpwell->rules->maxW
    minL = rpwell->rules->minL
    maxL = rpwell->rules->maxL
    deltaL = rpwell->deltaL

    ; ensure they enter a positive value for m
    m = cdfgData->m->value
    m = fix(m) 
    m = S130CheckRange(cdfgData->m->prompt m 1 500)
    cdfgData->m->value = m

    ; clean up w
    w = S130Round(w grid)
    w = S130CheckRange( cdfgData->w->prompt w minW maxW )
    cdfgData->w->value = w

    if( cdfgData->rCalcMethod->value == "Resistance" then
      res = S130CheckRange( cdfgData->res->prompt res round((rsh*minL/w)/0.0001)*0.0001 rsh*maxL/w )
      l = S130Round(res*w/rsh grid)-deltaL
      l = S130CheckRange( cdfgData->l->prompt l minL maxL )
    else
      l = S130Round(l grid)
      l = S130CheckRange( cdfgData->l->prompt l minL maxL )

      res = rsh * ((l+deltaL) / w)
    ); if rCalcMethod

    cdfgData->l->value = l

    ;; format outputs 
    if( (abs(res - 1000.0) < 1e-6) || (res > 1000.0) then
      res = cdfFormatFloatString(sprintf(nil "%.0f" res) "auto")
    else
      res = cdfFormatFloatString(sprintf(nil "%.4f" res) "auto")
    ); if
  
    cdfgData->res->value = S130stringTruncateZeros(res)

    case( cdfgData->nwTapCnt->value
      ("Both"
        cdfgData->nwTapLRCnt->value = t
        cdfgData->nwTapTBCnt->value = t
      )
      ("Sides"
        cdfgData->nwTapLRCnt->value = t
        cdfgData->nwTapTBCnt->value = nil
      )
      ("Ends"
        cdfgData->nwTapLRCnt->value = nil
        cdfgData->nwTapTBCnt->value = t
      )
    ); case nwTapCnt

  ); let
); procedure S130rpwellCB

;---------------------------------------
; Main callback for rmet
;---------------------------------------
procedure(S130rmetCB(@optional param)
  let( (cv tfId grid rType w l m rsh minW maxW minL maxL res ) 

    cv = cdfgData->id~>master || cdfgData->id
    tfId = techGetTechFile(cv)
    grid = techGetMfgGridResolution(tfId)

    ; base params
    rType = cdfgData->rType->value
    w     = cdfgData->w->value
    l     = cdfgData->l->value
    res   = cdfParseFloatString(cdfgData->r->value)

    ; these will change based on the rType
    cdfgData->model->value = nthelem( lindex( cdfgData->rType->choices rType ) rmet->modelNames )
    cdfgData->lvsModel->value = nthelem( lindex( cdfgData->rType->choices rType ) rmet->lvsModels )
    rsh = evalstring(strcat("designRules->" rType "->sheetRho"))
    cdfgData->rsh->value = rsh
    minW = evalstring(strcat("designRules->" rType "->minresW"))
    maxW = evalstring(strcat("designRules->" rType "->maxW"))||100
    minL = 2*grid
    maxL = evalstring(strcat("designRules->" rType "->maxW"))||1e6

    case( param
      ("rType"
        when( w < minW  w = minW )
        when( w > maxW  w = maxW )
      )
    ); case param

    ; ensure they enter a positive value for m
    m = cdfgData->m->value
    m = fix(m) 
    m = S130CheckRange(cdfgData->m->prompt m 1 500)
    cdfgData->m->value = m

    ; clean up w
    w = S130Round(w grid)
    w = S130CheckRange( cdfgData->w->prompt w minW maxW )
    cdfgData->w->value = w

    if( cdfgData->rCalcMethod->value == "R & W" then
      res = S130CheckRange( cdfgData->r->prompt res round((rsh*minL/w)/0.0001)*0.0001 rsh*maxL/w )
      l = S130Round(res*w/rsh grid)
      l = S130CheckRange( cdfgData->l->prompt l minL maxL )
    else
      l = S130Round(l grid)
      l = S130CheckRange( cdfgData->l->prompt l minL maxL )

      res = rsh * (l / w)
    ); if rCalcMethod

    cdfgData->l->value = l

    ;; format outputs 
    if( (abs(res - 1000.0) < 1e-6) || (res > 1000.0) then
      res = cdfFormatFloatString(sprintf(nil "%.0f" res) "auto")
    else
      res = cdfFormatFloatString(sprintf(nil "%.4f" res) "auto")
    ); if
  
    cdfgData->r->value = S130stringTruncateZeros(res)


  ); let
); procedure S130rmetCB

;---------------------------------------
; Main callback for bipolars
;---------------------------------------
procedure(S130bipolarCB()
  let( (m)

    ; ensure they enter a positive value for m
    m = cdfgData->m->value
    m = fix(m) 
    m = S130CheckRange(cdfgData->m->prompt m 1 500)
    cdfgData->m->value = m

  ); let
); procedure S130bipolarCB

;---------------------------------------
; Main callback for diodes
;---------------------------------------
procedure(S130dioCB()
  let( (cv tfId grid model w l m minW maxW minL maxL minA maxA area )

    cv = cdfgData->id~>master || cdfgData->id
    tfId = techGetTechFile(cv)
    grid = techGetMfgGridResolution(tfId)

    ; base params
    model = cdfgData->lvsModel->value
    w     = cdfgData->w->value
    l     = cdfgData->l->value
    area  = cdfParseFloatString(cdfgData->area->value)

    ; grab min/max values for range tests
    minW = evalstring(strcat(model "->minW"))||0.33
    minL = evalstring(strcat(model "->minL"))||0.33
    minA = minW * minL
    maxW = evalstring(strcat(model "->maxW"))||1e6
    maxL = evalstring(strcat(model "->maxL"))||1e6
    maxA = maxW * maxL

    ; ensure they enter a positive value for m
    m = cdfgData->m->value
    m = fix(m) 
    m = S130CheckRange(cdfgData->m->prompt m 1 500)
    cdfgData->m->value = m

    ; check params for offgrid or out of range
    w = S130Round(w grid)
    w = S130CheckRange( cdfgData->w->prompt w minW maxW )
    cdfgData->w->value = evalstring(S130TruncateZeros(w))

    l = S130Round(l grid)
    l = S130CheckRange( cdfgData->l->prompt l minL maxL )
    cdfgData->l->value = evalstring(S130TruncateZeros(l))

    area = S130CheckRange( cdfgData->area->prompt area minA-1e-6 maxA )
    cdfgData->area->value = S130TruncateZeros(area)

    if( cdfgData->calcMethod->value == "Area & Width" then
      l = S130Round(area/w grid)
      l = S130CheckRange( cdfgData->l->prompt l minL maxL )
      cdfgData->l->value = evalstring(S130TruncateZeros(l))
      when( area != w*l
        warn("Adjusted diode area based on length calculation (ongrid/min/max)")
        cdfgData->area->value = S130TruncateZeros(w*l)
      )
    else
      cdfgData->area->value = S130TruncateZeros(w*l)
    ); if calcMethod

    cdfgData->perim->value = S130TruncateZeros(S130Round(2*w+2*l grid))

  ); let
); procedure S130dioCB

procedure(S130welldioCB()
  let( (model minW maxW minL maxL minA maxA minP maxP
        m area perim )

    ; base params
    model = cdfgData->lvsModel->value
    area  = cdfParseFloatString(cdfgData->area->value)
    perim = cdfParseFloatString(cdfgData->perim->value)

    ; grab min/max values for range tests
    minW = evalstring(strcat(model "->minW"))||0.33
    minL = evalstring(strcat(model "->minL"))||0.33
    minA = minW * minL
    minP = 2*(minW + minL)
    maxW = evalstring(strcat(model "->maxW"))||1e6
    maxL = evalstring(strcat(model "->maxL"))||1e6
    maxA = maxW * maxL
    maxP = 2*(maxW + maxL)

    ; ensure they enter a positive value for m
    m = cdfgData->m->value
    m = fix(m) 
    m = S130CheckRange(cdfgData->m->prompt m 1 500)
    cdfgData->m->value = m

    ; check params for offgrid or out of range
    area = S130CheckRange( cdfgData->area->prompt area minA maxA )
    cdfgData->area->value = S130stringTruncateZeros(sprintf(nil "%.5f" area))
    perim = S130CheckRange( cdfgData->perim->prompt perim minP maxP )
    cdfgData->perim->value = S130stringTruncateZeros(sprintf(nil "%.3f" perim))

  ); let
); procedure S130welldioCB

;---------------------------------------
; Main callback for mimcaps
;---------------------------------------
procedure(S130mimcapCB()
  let( (cv tfId grid calcMethod model w l c actualC cS cF
        minW maxW minL maxL maxWLratio m )

    cv = cdfgData->id~>master || cdfgData->id
    tfId = techGetTechFile(cv)
    grid = techGetMfgGridResolution(tfId)

    ; all units are in um and fF

    ; base params
    calcMethod = cdfgData->calcMethod->value
    model = cdfgData->model->value
    w     = cdfgData->w->value
    l     = cdfgData->l->value
    c     = cdfgData->c->value

    ; grab min/max values for range tests
    minW  = evalstring(strcat(model "->minW"))
    minL  = evalstring(strcat(model "->minL"))
    maxW  = evalstring(strcat(model "->maxW"))
    maxL  = evalstring(strcat(model "->maxL"))
    cS    = evalstring(strcat(model "->sheetCap"))
    cF    = evalstring(strcat(model "->fringeCap"))
    maxWLratio = evalstring(strcat(model "->maxWLratio"))

    ; ensure they enter a positive value for m
    m = cdfgData->m->value
    m = fix(m) 
    m = S130CheckRange(cdfgData->m->prompt m 1 500)
    cdfgData->m->value = m

    ; check w for offgrid or out of range
    w = S130Round(w grid)
    w = S130CheckRange( cdfgData->w->prompt w minW maxW )

    case( calcMethod
      ( "Capacitance & Width"
        ; calc length based off c & w
        l = (c - 2*w*cF)/(w*cS + 2*cF)
      )
      ( "Capacitance"
        ; calc width & length based off c & w
        w = -((2*cF-sqrt(4*expt(cF 2)+cS*c))/cS)
        w = S130Round(w grid)
        w = S130CheckRange( cdfgData->w->prompt w minW maxW )
        l = (c - 2*w*cF)/(w*cS + 2*cF)
      )
    ); case calcMethod

    ; check l for offgrid or out of range
    l = S130Round(l grid)
    l = S130CheckRange( cdfgData->l->prompt l minL maxL )

    ; check ratio and adjust l & w as needed
    when( l/w > maxWLratio || w/l > maxWLratio
      if( l >= w then
        warn( "Max L/W ratio of %s exceeded; adjusting length\n" S130TruncateZeros(maxWLratio) )
        l = w * maxWLratio
        l = S130Round(l grid)
        l = S130CheckRange( cdfgData->l->prompt l minL maxL )
      else
        warn( "Max W/L ratio of %s exceeded; adjusting width\n" S130TruncateZeros(maxWLratio) )
        w = l * maxWLratio
        w = S130Round(w grid)
        w = S130CheckRange( cdfgData->w->prompt w minW maxW )
      ); if l >= w
    ); when over maxWLratio

    cdfgData->w->value = evalstring(S130stringTruncateZeros(sprintf(nil "%f" w)))
    cdfgData->l->value = evalstring(S130stringTruncateZeros(sprintf(nil "%f" l)))

    cdfgData->area->value = w*l
    cdfgData->perim->value = 2*w + 2*l

    actualC = cS*w*l + (2*cF*(w+l))
    cdfgData->actualC->value = evalstring(S130stringTruncateZeros(sprintf(nil "%f" actualC)))
    cdfgData->totalC->value  = evalstring(S130stringTruncateZeros(sprintf(nil "%f" actualC*cdfgData->m->value)))

    when( calcMethod == "Width & Length"
      cdfgData->c->value = cdfgData->actualC->value
    ); unless calcMethod

  ); let
); procedure S130mimcapCB

;---------------------------------------
; Main callback for pads
;---------------------------------------
procedure(S130padCB(param)
  let( (cv tfId grid padW padL minW maxW m metalOL minMetOL maxMetOL )

    cv = cdfgData->id~>master || cdfgData->id
    tfId = techGetTechFile(cv)
    grid = techGetMfgGridResolution(tfId)

    padW = cdfgData->w->value
    padL = cdfgData->l->value
    minW = cdfgData->minW->value
    maxW = cdfgData->maxW->value

    minMetOL = cdfgData->minTopMetOL->value
    maxMetOL = 5*cdfgData->minTopMetOL->value

    case( param
      ( w
        ; check w for offgrid or out of range
        padW = S130Round(padW grid)
        padW = S130CheckRange( cdfgData->w->prompt padW minW maxW )
      ); w
      ( l
        ; check l for offgrid or out of range
        padL = S130Round(padL grid)
        padL = S130CheckRange( cdfgData->l->prompt padL minW maxW )
      ); l
      ( m
        m = fix(cdfgData->m->value)
        m = S130CheckRange(cdfgData->m->prompt m 1 500)
        cdfgData->m->value = m
      ); m
      ( metalOL
        ; check metalOL for offgrid or out of range
        metalOL = S130Round(cdfgData->metalOL->value grid)
        metalOL = S130CheckRange(cdfgData->metalOL->prompt metalOL minMetOL maxMetOL)
        cdfgData->metalOL->value = metalOL
      ); metalOL
    ); case param

    cdfgData->w->value = padW
    cdfgData->l->value = padL

  ); let
); procedure S130padCB

;---------------------------------------
; Main callback for sealring
;---------------------------------------
procedure(S130sealringCB(param)
  let( (cv tfId grid w l minW maxW extraCut sealringW sealGrid )

    cv = cdfgData->id~>master || cdfgData->id
    tfId = techGetTechFile(cv)
    grid = techGetMfgGridResolution(tfId)

    w = cdfgData->w->value
    l = cdfgData->l->value
    dieW = cdfgData->dieW->value
    dieL = cdfgData->dieL->value
    minW = sealring->minW
    maxW = sealring->maxW
    minDieW = sealring->minDieW
    maxDieW = sealring->maxDieW
    extraCut = cdfgData->extraCut->value
	sealringW = sealring->minWseal
	sealGrid = grid * 200 ; only whole microns allowed

    case( param
      ( w
        ; check w for offgrid or out of range
        w = S130Round(w sealGrid)
        w = S130CheckRange( cdfgData->w->prompt w minW maxW )
		dieW = w + (2*sealringW)
      ); w
      ( l
        ; check l for offgrid or out of range
        l = S130Round(l sealGrid)
        l = S130CheckRange( cdfgData->l->prompt l minW maxW )
      ); l

      ( dieW
        ; check dieW for offgrid or out of range
        dieW = S130Round(dieW sealGrid)
        dieW = S130CheckRange( cdfgData->dieW->prompt dieW minDieW maxDieW )
		w= dieW - (2*sealringW)
      ); dieW
      ( dieL
        ; check dieL for offgrid or out of range
        dieL = S130Round(dieL sealGrid)
        dieL = S130CheckRange( cdfgData->dieL->prompt dieL minDieW maxDieW )
		l = dieL - (2*sealringW)
      ); dieL
      ( extraCut
        ; check l for offgrid or out of range
        extraCut = S130Round(extraCut grid)
        extraCut = S130CheckRange( cdfgData->extraCut->prompt extraCut 0.0 S130Round(min(w l)*0.25 grid) )
      ); l
    ); case param

    cdfgData->w->value = evalstring(S130TruncateZeros(w))
    cdfgData->l->value = evalstring(S130TruncateZeros(l))
    cdfgData->dieW->value = evalstring(S130TruncateZeros(dieW))
    cdfgData->dieL->value = evalstring(S130TruncateZeros(dieL))
    cdfgData->extraCut->value = evalstring(S130TruncateZeros(extraCut))

  ); let
); procedure S130sealringCB

;---------------------------------------
; Main callback for anchor
;---------------------------------------
procedure(S130anchorCB(param)
  let( (cv tfId grid x y z numAnchors )

    cv = cdfgData->id~>master || cdfgData->id
    tfId = techGetTechFile(cv)
    grid = techGetMfgGridResolution(tfId)

    x = cdfgData->x->value
    y = cdfgData->y->value
    z = cdfgData->z->value
    numAnchors = cdfgData->numAnchors->value

    case( param
      ( x
        ; check x for offgrid or out of range
        x = S130Round(x grid)
        x = S130CheckRange( cdfgData->x->prompt x anchor->defW 1e6 )
        cdfgData->x->value = evalstring(S130TruncateZeros(x))
      ); x
      ( y
        ; check y for offgrid or out of range
        y = S130Round(y grid)
        y = S130CheckRange( cdfgData->y->prompt y anchor->defW 1e6 )
        cdfgData->y->value = evalstring(S130TruncateZeros(y))
      ); y
      ( z
        ; check z for out of range
        z = S130CheckRange( cdfgData->z->prompt z anchor->defW sqrt(0.5*expt(min(x y) 2)) )
        cdfgData->z->value = evalstring(S130TruncateZeros(z))
      ); z
      ( numAnchors
        ; ensure they enter a positive value for numAnchors
        numAnchors = fix(numAnchors) 
        numAnchors = S130CheckRange(cdfgData->numAnchors->prompt numAnchors 1 100)
        cdfgData->numAnchors->value = numAnchors
      ); numAnchors
    ); case param

  ); let
); procedure S130anchorCB

;---------------------------------------
; Main callback for fuse
;---------------------------------------
procedure(S130fuseCB(@optional param)
  let( (cv tfId grid w l res shieldSP m rsh minW maxW minL maxL shieldMinSP shieldMaxSP) 

    cv = cdfgData->id~>master || cdfgData->id
    tfId = techGetTechFile(cv)
    grid = techGetMfgGridResolution(tfId)

    ; base params
    w     = cdfgData->w->value
    l     = cdfgData->l->value
    res   = cdfParseFloatString(cdfgData->r->value)
    shieldSP = cdfgData->shieldSP->value

    rsh = cdfgData->rsh->value
    minW = designRules->fuse->minW
    maxW = designRules->fuse->maxW
    minL = designRules->fuse->minL
    maxL = designRules->fuse->maxL
    shieldMinSP = designRules->fuse->shieldMinSP
    shieldMaxSP = designRules->fuse->shieldMaxSP

    ; ensure they enter a positive value for m
    m = cdfgData->m->value
    m = fix(m) 
    m = S130CheckRange(cdfgData->m->prompt m 1 500)
    cdfgData->m->value = m

    ; clean up w
    w = S130Round(w grid)
    w = S130CheckRange( cdfgData->w->prompt w minW maxW )
    cdfgData->w->value = w

    if( cdfgData->rCalcMethod->value == "R & W" then
      res = S130CheckRange( cdfgData->r->prompt res round((rsh*minL/w)/0.0001)*0.0001 rsh*maxL/w )
      l = S130Round(res*w/rsh grid)
      l = S130CheckRange( cdfgData->l->prompt l minL maxL )
    else
      l = S130Round(l grid)
      l = S130CheckRange( cdfgData->l->prompt l minL maxL )

      res = rsh * (l / w)
    ); if rCalcMethod

    cdfgData->l->value = l

    ;; format outputs 
    if( (abs(res - 1000.0) < 1e-6) || (res > 1000.0) then
      res = cdfFormatFloatString(sprintf(nil "%.0f" res) "auto")
    else
      res = cdfFormatFloatString(sprintf(nil "%.4f" res) "auto")
    ); if
  
    cdfgData->r->value = S130stringTruncateZeros(res)

    ; clean up shield spacing
    shieldSP = S130Round(shieldSP grid)
    shieldSP = S130CheckRange( cdfgData->shieldSP->prompt shieldSP shieldMinSP shieldMaxSP )
    cdfgData->shieldSP->value = shieldSP

  ); let
); procedure S130fuseCB


/*==============================================================================
  ***** Abutment Procedures *****
==============================================================================*/

;---------------------------------------
; MOS Abutment procedure
;---------------------------------------
; some env options needed to prevent odd warnings during gen+chaining
envSetVal("layoutXL" "lxFingeringNames" 'string "fingers nf")
envSetVal("layoutXL" "lxChainAlignNMOS" 'string "Top")
envSetVal("layoutXL" "lxChainAlignPMOS" 'string "Bottom")

procedure( S130mosAbutFunc(instA instB pinA pinB pinAside conn event @optional (group nil))
  prog(( result pinAcontP pinAstrP pinBcontP pinBstrP pinAmosW pinBmosW pinAcontV
         pinAstrV pinBcontV pinBstrV instName instArext instAlext instBrext instBlext
         instAttap instAbtap instBttap instBbtap
         propName propType propValue eqW )

    ;; Find the names of the parameters affecting each pin.
    ;; These are added to the pins after they are created in
    ;; the pcell procedure.
    when( pinA && pinB && group

      pinAcontP = pinA~>contactParam
      pinBcontP = pinB~>contactParam

      ;; Get the current parameter values to be restored
      ;; during an un-abutment event.
      pinAcontV = get(instA~>master~>superMaster~>parameters pinAcontP)
      pinAcontV = pinAcontV && pinAcontV != "FALSE"
      pinBcontV = get(instB~>master~>superMaster~>parameters pinBcontP)
      pinBcontV = pinBcontV && pinBcontV != "FALSE"
      instArext = get(instA~>master~>superMaster~>parameters "diffRext")
      instAlext = get(instA~>master~>superMaster~>parameters "diffLext")
      instBrext = get(instB~>master~>superMaster~>parameters "diffRext")
      instBlext = get(instB~>master~>superMaster~>parameters "diffLext")
      instAttap = get(instA~>master~>superMaster~>parameters "tapTop")
      instAbtap = get(instA~>master~>superMaster~>parameters "tapBottom")
      instBttap = get(instB~>master~>superMaster~>parameters "tapTop")
      instBbtap = get(instB~>master~>superMaster~>parameters "tapBottom")

      ;; Store the current values on the abutment group for
      ;; these instances. (The group is stored on the cellView).

      oldValues = list(
        list(instA~>name pinAcontP      "boolean"   pinAcontV)
        list(instB~>name pinBcontP      "boolean"   pinBcontV)
        list(instA~>name "diffRext"     "float"     instArext)
        list(instA~>name "diffLext"     "float"     instAlext)
        list(instB~>name "diffRext"     "float"     instBrext)
        list(instB~>name "diffLext"     "float"     instBlext)
        list(instA~>name "tapTopCnt"    "boolean"   t)
        list(instA~>name "tapBottomCnt" "boolean"   t)
        list(instB~>name "tapTopCnt"    "boolean"   t)
        list(instB~>name "tapBottomCnt" "boolean"   t)
        list(instA~>name "tapTop"       "boolean"   instAttap)
        list(instA~>name "tapBottom"    "boolean"   instAbtap)
        list(instB~>name "tapTop"       "boolean"   instBttap)
        list(instB~>name "tapBottom"    "boolean"   instBbtap)
      )
      dbReplaceProp(group "oldValues" "list" oldValues)
    ); when

    pinAmosW = pinA~>w
    pinBmosW = pinB~>w

    ; event
    ; 1 - offset pin edge to pin edge
    ; 2 - abutment, inst param adjustments
    ; 3 - unabutment, inst param restore

    ; conn
    ; 1 - no external connection, no contact needed
    ; 2 - external connections, contact needed

    case( event
      (1  ;; Offset. This gets run after abutment.
        case(conn
          (1 result = -pinA->pinW
            when( pinAmosW > pinBmosW
              result = -pinA->pinW - designRules->poly->minSPdiff
            )
          )
          (2 
            result = -pinA->pinW - (designRules->diff->minOLLlicon1 -
              designRules->licon1->minDcontSPpoly)
              when( pinAmosW > pinBmosW
                result = -pinA->pinW + (pinA->pinW - pinB->pinW)
              )
              when( pinAmosW < pinBmosW
                result = -pinB->pinW + (pinB->pinW - pinA->pinW)
              )
          )
          (t printf("        Unknown conn %L\n" conn) )
        ); case conn
        unless( pinAmosW == pinBmosW
          result = result + designRules->poly->minSPdiff
        ); unless equal widths
        result
      ); event 1
      (2  ;; Abutment
        ;; Get the current device sizes to calculate abutment.
        case(conn
          (1 ;; No contact needed.
            if( pinAmosW < pinBmosW then
              dbReplaceProp(instB pinBcontP "boolean" nil)
              dbReplaceProp(instA pinAcontP "boolean" nil)
              dbReplaceProp(instA "gateCnt" "string" "none" )
              dbReplaceProp(instA "tapTop"    "boolean" nil )
              dbReplaceProp(instA "tapBottom" "boolean" nil )
              if( pinA->pin->name == "left" then
                dbReplaceProp(instA "diffLext" "float" instA->diffLext + designRules->poly->minSPdiff )
              else
                dbReplaceProp(instA "diffRext" "float" instA->diffRext + designRules->poly->minSPdiff )
              ); if left pin
            else
              if(pinAmosW > pinBmosW then
                dbReplaceProp(instB pinBcontP "boolean" nil)
                dbReplaceProp(instA pinAcontP "boolean" nil)
                dbReplaceProp(instB "gateCnt" "string" "none" )
                dbReplaceProp(instB "tapTop"    "boolean" nil )
                dbReplaceProp(instB "tapBottom" "boolean" nil )
                if( pinB->pin->name == "left" then
                  dbReplaceProp(instB "diffLext" "float" instB->diffLext + designRules->poly->minSPdiff )
                else
                  dbReplaceProp(instB "diffRext" "float" instB->diffRext + designRules->poly->minSPdiff )
                ); if left pin
              else
                dbReplaceProp(instA pinAcontP "boolean" nil)
                dbReplaceProp(instB pinBcontP "boolean" nil)
              ); if A width > B width
            ); if A width < B width
          ); conn 1
          (2 ;; Contact needed.
            if( pinAmosW < pinBmosW then
              dbReplaceProp(instB pinBcontP "boolean" t)
              dbReplaceProp(instA pinAcontP "boolean" nil)
              dbReplaceProp(instA "gateCnt" "string" "none" )
              dbReplaceProp(instA "tapTop"    "boolean" nil )
              dbReplaceProp(instA "tapBottom" "boolean" nil )
              if( pinA->pin->name == "left" then
                dbReplaceProp(instA "diffLext" "float" instA->diffLext + designRules->poly->minSPdiff )
              else
                dbReplaceProp(instA "diffRext" "float" instA->diffRext + designRules->poly->minSPdiff )
              ); if left pin
            else
              if(pinAmosW > pinBmosW then
                dbReplaceProp(instB pinBcontP "boolean" nil)
                dbReplaceProp(instA pinAcontP "boolean" t)
                dbReplaceProp(instB "gateCnt" "string" "none" )
                dbReplaceProp(instB "tapTop"    "boolean" nil )
                dbReplaceProp(instB "tapBottom" "boolean" nil )
                if( pinB->pin->name == "left" then
                  dbReplaceProp(instB "diffLext" "float" instB->diffLext + designRules->poly->minSPdiff )
                else
                  dbReplaceProp(instB "diffRext" "float" instB->diffRext + designRules->poly->minSPdiff )
                ); if left pin
              else
                dbReplaceProp(instB pinBcontP "boolean" t)
                dbReplaceProp(instA pinAcontP "boolean" t)
              ); if A width > B width
            ); if A width < B width
          ); conn 2
          (t
            printf("        Unknown conn %L\n" conn)
          )
        ); case conn
        ; turn off the taps
        if( pinA->pin->name == "left" then
          dbReplaceProp(instA "tapLeft" "boolean" nil )
        else
          dbReplaceProp(instA "tapRight" "boolean" nil )
        )
        if( pinB->pin->name == "left" then
          dbReplaceProp(instB "tapLeft" "boolean" nil )
        else
          dbReplaceProp(instB "tapRight" "boolean" nil )
        )
        
        result = t
      ); event 2
      (3  ;; Un-abutment
        oldValues = dbSearchPropByName(group "oldValues")
        
        foreach(propList oldValues~>value
          instName  = car(propList)
          propName  = cadr(propList)
          propType  = caddr(propList)
          propValue = cadddr(propList)
          if( instName == instA~>name then
            dbReplaceProp(instA propName propType propValue)
          else
            dbReplaceProp(instB propName propType propValue)
          ); if
        ); foreach prop
        
        result = t
      ); event 3
      (t
        result = nil
      )
    ); case event
    return(result)
  ); prog
); procedure S130mosAbutFunc

/*==============================================================================
  ***** Support Functions *****
==============================================================================*/

;---------------------------------------
; Check min/max for param
;---------------------------------------
procedure( S130CheckRange(paramName val minVal maxVal)
  let(()
    if( val < minVal then
      warn(sprintf(nil "%L is out of range (%s < %L)" val paramName minVal))
      minVal
    else
      if( val > maxVal then
        warn(sprintf(nil "%L is out of range (%s > %L)" val paramName maxVal))
        maxVal
      else
        ;; param in range
        val
      ); if val > max
    ); if val < min
  ); let
); procedure S130CheckRange

;---------------------------------------
; Rounding to grid
;---------------------------------------
procedure( S130Round(value grid)
  let( (initVal decVal)
    initVal = floor(value)
    decVal = value - initVal
    initVal + round(decVal/grid)*grid
  ) ; end let
) ; end procedure

;---------------------------------------
; Truncates zeros
;---------------------------------------
procedure( S130TruncateZeros(val)
  let( ()
    ;; val = float
    ;; returns string with trailing zeros truncated down to 0.001
    ;; beyond 0.001, full precision returned

    ;; if an integer
    if( abs(val - S130Round(val 1)) < 1e-6 then
      sprintf(nil "%.0f" val)
    else
      if( abs(val - S130Round(val 0.1)) < 1e-6 then
        sprintf(nil "%.1f" val)
      else
        if( abs(val - S130Round(val 0.01)) < 1e-6 then
          sprintf(nil "%.2f" val)
        else
          if( abs(val - S130Round(val 0.001)) < 1e-6 then
            sprintf(nil "%.3f" val)
          else
            sprintf(nil "%f" val)
          ); if
        ); if
      ); if
    ); if
  ); let
); procedure S130TruncateZeros

procedure( S130stringTruncateZeros(val)
  prog( ()
    ;; val = string
    ;; returns string with trailing zeros behind the decimal
    ;; removed
    unless( stringp(val) return(val) )
    if( rexMatchp("[0-9]+\\.[0-9]*u$" val) then
      rexCompile("0+u")
      val = rexReplace(val "u" 1)
      rexCompile("\\.u$")
      val = rexReplace(val ".0u" 1)
    else
      if( rexMatchp("[0-9]+\\.[0-9]*m$" val) then
        rexCompile("0+m")
        val = rexReplace(val "m" 1)
        rexCompile("\\.m$")
        val = rexReplace(val ".0m" 1)
      else
        if( rexMatchp("[0-9]+\\.[0-9]*[kK]$" val) then
          rexCompile("0+[kK]")
          val = rexReplace(val "K" 1)
          rexCompile("\\.K$")
          val = rexReplace(val ".0K" 1)
        else
          if( rexMatchp("[0-9]+\\.[0-9]*M$" val) then
            rexCompile("0+M")
            val = rexReplace(val "M" 1)
            rexCompile("\\.M$")
            val = rexReplace(val ".0M" 1)
          else
            if( rexMatchp("[0-9]+\\.[0-9]*$" val) then
              rexCompile("0+$")
              val = rexReplace(val "0" 1)
            ); if
          ); if M
        ); if k
      ); if m
    ); if u
    return(val)
  ); prog
); procedure S130stringTruncateZeros


;---------------------------------------
; Calculate values for auLVS & auCdl netlists for resistors
;---------------------------------------
procedure( S130CalcNetlistValues()
  let( ( rType lHead segW segL segments segSP contRows )
    rType     = cdfgData->rType->value
    segL      = cdfParseFloatString(cdfgData->segL->value)
    segW      = cdfParseFloatString(cdfgData->segW->value)
    segments  = cdfgData->segments->value
    segSP     = cdfParseFloatString(cdfgData->segmentSP->value)
    contRows  = cdfgData->contRows->value

    cdfgData->w->value = sprintf( nil "%.3f" segW )

    lHead = designRules->pres->contL + designRules->pres->polyOLScont +
          (contRows - 1)*(designRules->pres->contL + designRules->pres->contSP)
    
    case( rType
      ( "Parallel"
        cdfgData->l->value = sprintf( nil "%.3f" segL )
      )
      ( "Series"
        cdfgData->l->value = sprintf( nil "%.3f" segL )
      )
      ( "Serpentine"
        cdfgData->l->value = sprintf( nil "%.3f" 
          cond( 
            ( segments == 1 segL )
            ( segments == 2 2*(segL - lHead - segW) + segSP + sqrt(2*expt(segW 2)) )
            ( segments >2   2*(segL - lHead - segW) + (segments-1)*(segSP +
              sqrt(2*expt(segW 2))) + (segments-2)*(segL-2*segW) )
          ); cond segments
        )
      )
    ); case rType
  ); let
); procedure S130CalcNetlistValues

/*==============================================================================
  Netlisting procedures for S130 devices
==============================================================================*/
; CDL netlisting
procedure( S130hrpolyCdlNLProc( instanceId )
  auCdlInstPrintOrder = list('instName 'connections  'instParams 'instProps)
  ansCdlHnlPrintInst(instanceId)
); procedure S130hrpolyCdlNLProc

procedure( S130rpwellCdlNLProc( instanceId )
  let( ( inst )

  inst = instanceId->inst
  
  auCdlInstPrintOrder = list('instName 'connections  'instParams 'instProps)
  ansCdlHnlPrintInst(instanceId)

  ); let
); procedure S130rpwellCdlNLProc

; Spectre & other sim netlising
;---------------------------------------
;; 3 term res
procedure( S130hrpolySpectreNLProc( instanceId )
  let( ( netlister toolName model segL segW segments segSP
       port1 port2 port3 newPort1 newPort2 serpL lHead )

    netlister = nlGetNetlister( nlGetFormatter(instanceId) )
    toolName = nlGetToolName( nlGetFormatter(instanceId) )

    model = nlGetParamStringValue( instanceId "model")
    segL = cdfParseFloatString( nlGetParamStringValue( instanceId "segL"))
    segW = cdfParseFloatString( nlGetParamStringValue( instanceId "segW"))
    segments = fix(evalstring(nlGetParamStringValue( instanceId "segments")))
    segSP = cdfParseFloatString( nlGetParamStringValue( instanceId "segmentSP"))

    port1 = nlGetTerminalSignalName( instanceId "PLUS")
    port2 = nlGetTerminalSignalName( instanceId "MINUS")
    port3 = nlGetTerminalSignalName( instanceId "B") || nil

    lHead = designRules->pres->contL + designRules->pres->polyOLScont

    case( nlGetParamStringValue( instanceId "rType")
      ("Parallel"
        case( toolName
          ("spectre"
            nlPrintInstName( nlGetFormatter(instanceId) instanceId )
            nlPrintString( netlister sprintf( nil " (%s %s %s) %s w=%g l=%g m=%d"
               port1 port2 port3 model segW segL segments ) )
          )
          (t
            nlPrintInstName( nlGetFormatter(instanceId) instanceId )
            nlPrintString( netlister sprintf( nil " (%s %s %s) %s w=%g l=%g m=%d"
               port1 port2 port3 model segW segL segments ) )
          )
        )
      )
      ("Series"
        if( segments == 1 then
          nlPrintInstName( nlGetFormatter(instanceId) instanceId )
          nlPrintString( netlister sprintf( nil " (%s %s %s) %s w=%g l=%g m=1"
            port1 port2 port3 model segW segL ) )
        else
          for( i 1 segments
            cond(
              ( i == 1
                newPort1 = port1
                newPort2 = sprintf( nil "%s_%s_%d_%d" instanceId->id->baseName port1 hnlCurrentIteration i )
              )
              ( i == segments
                newPort1 = sprintf( nil "%s_%s_%d_%d" instanceId->id->baseName port1 hnlCurrentIteration i-1 )
                newPort2 = port2
              )
              ( t
                newPort1 = sprintf( nil "%s_%s_%d_%d" instanceId->id->baseName port1 hnlCurrentIteration i-1 )
                newPort2 = sprintf( nil "%s_%s_%d_%d" instanceId->id->baseName port1 hnlCurrentIteration i )
              )
            ); end cond

            case( toolName
              ("spectre"
                nlPrintInstName( nlGetFormatter(instanceId) instanceId )
                nlPrintString( netlister sprintf( nil "_%d (%s %s %s) %s w=%g l=%g m=1"
                  i newPort1 newPort2 port3 model segW segL ) )
              )
              (t
                nlPrintInstName( nlGetFormatter(instanceId) instanceId )
                nlPrintString( netlister sprintf( nil "_%d (%s %s %s) %s w=%g l=%g m=1"
                  i newPort1 newPort2 port3 model segW segL ) )
              )
            )

            when( i < segments
              nlPrintString( netlister "\n")
            ); end when
            
          ); end for 1 to segments
        ); if segments = 1
      )
      ("Serpentine"
        cond(
          ( segments == 1  serpL = segL )
          ( segments == 2  serpL = 2*(segL - lHead - segW) + segSP + sqrt(2*expt(segW 2)) )
          ( segments > 2   serpL = 2*(segL - lHead - segW) + (segments-1)*(segSP +
            sqrt(2*expt(segW 2))) + (segments-2)*(segL-2*segW) )
        )
        case( toolName
          ("spectre"
            nlPrintInstName( nlGetFormatter(instanceId) instanceId )
            nlPrintString( netlister sprintf( nil " (%s %s %s) %s w=%g l=%g m=1"
              port1 port2 port3 model segW serpL ) )
          )
          (t
            nlPrintInstName( nlGetFormatter(instanceId) instanceId )
            nlPrintString( netlister sprintf( nil " (%s %s %s) %s w=%g l=%g m=1"
              port1 port2 port3 model segW serpL ) )
          )
        )
      )
    ); end case rType

  );let
); procedure S130hrpolySpectreNLProc

;; 2 term res
procedure( S130rpolySpectreNLProc( instanceId )
  let( ( netlister toolName model segL segW segments segSP
       port1 port2 newPort1 newPort2 serpL lHead )

    netlister = nlGetNetlister( nlGetFormatter(instanceId) )
    toolName = nlGetToolName( nlGetFormatter(instanceId) )

    model = nlGetParamStringValue( instanceId "model")
    segL = cdfParseFloatString( nlGetParamStringValue( instanceId "segL"))
    segW = cdfParseFloatString( nlGetParamStringValue( instanceId "segW"))
    segments = fix(evalstring(nlGetParamStringValue( instanceId "segments")))
    segSP = cdfParseFloatString( nlGetParamStringValue( instanceId "segmentSP"))

    port1 = nlGetTerminalSignalName( instanceId "PLUS")
    port2 = nlGetTerminalSignalName( instanceId "MINUS")

    lHead = designRules->pres->contL + designRules->pres->polyOLScont

    case( nlGetParamStringValue( instanceId "rType")
      ("Parallel"
        case( toolName
          ("spectre"
            nlPrintInstName( nlGetFormatter(instanceId) instanceId )
            nlPrintString( netlister sprintf( nil " (%s %s) %s w=%g l=%g m=%d"
              port1 port2 model segW segL segments ) )
          )
          (t
            nlPrintInstName( nlGetFormatter(instanceId) instanceId )
            nlPrintString( netlister sprintf( nil " (%s %s) %s w=%g l=%g m=%d"
              port1 port2 model segW segL segments ) )
          )
        )
      )
      ("Series"
        if( segments == 1 then
          nlPrintInstName( nlGetFormatter(instanceId) instanceId )
          nlPrintString( netlister sprintf( nil " (%s %s) %s w=%g l=%g m=1"
            port1 port2 model segW segL ) )
        else
          for( i 1 segments
            cond(
              ( i == 1
                newPort1 = port1
                newPort2 = sprintf( nil "%s_%s_%d_%d" instanceId->id->baseName port1 hnlCurrentIteration i )
              )
              ( i == segments
                newPort1 = sprintf( nil "%s_%s_%d_%d" instanceId->id->baseName port1 hnlCurrentIteration i-1 )
                newPort2 = port2
              )
              ( t
                newPort1 = sprintf( nil "%s_%s_%d_%d" instanceId->id->baseName port1 hnlCurrentIteration i-1 )
                newPort2 = sprintf( nil "%s_%s_%d_%d" instanceId->id->baseName port1 hnlCurrentIteration i )
              )
            ); end cond

            case( toolName
              ("spectre"
                nlPrintInstName( nlGetFormatter(instanceId) instanceId )
                nlPrintString( netlister sprintf( nil "_%d (%s %s) %s w=%g l=%g m=1"
                  i newPort1 newPort2 model segW segL ) )
              )
              (t
                nlPrintInstName( nlGetFormatter(instanceId) instanceId )
                nlPrintString( netlister sprintf( nil "_%d (%s %s) %s w=%g l=%g m=1"
                  i newPort1 newPort2 model segW segL ) )
              )
            )

            when( i < segments
              nlPrintString( netlister "\n")
            ); end when
            
          ); end for 1 to segments
        ); if segments = 1
      )
      ("Serpentine"
        cond(
          ( segments == 1  serpL = segL )
          ( segments == 2  serpL = 2*(segL - lHead - segW) + segSP + sqrt(2*expt(segW 2)) )
          ( segments > 2   serpL = 2*(segL - lHead - segW) + (segments-1)*(segSP +
            sqrt(2*expt(segW 2))) + (segments-2)*(segL-2*segW) )
        )
        case( toolName
          ("spectre"
            nlPrintInstName( nlGetFormatter(instanceId) instanceId )
            nlPrintString( netlister sprintf( nil " (%s %s) %s w=%g l=%g m=1"
              port1 port2 model segW serpL ) )
          )
          (t
            nlPrintInstName( nlGetFormatter(instanceId) instanceId )
            nlPrintString( netlister sprintf( nil " (%s %s) %s w=%g l=%g m=1"
              port1 port2 model segW serpL ) )
          )
        )
      )
    ); end case rType

  );let
); procedure S130rpolySpectreNLProc

; for icecap
procedure( S130icecapSpectreNLProc( instanceId )
  let( ( netlister port1 port2)

    netlister = nlGetNetlister( nlGetFormatter(instanceId) )
    port1 = nlGetTerminalSignalName( instanceId "c0")
    port2 = nlGetParamStringValue( instanceId "sub")

    nlPrintInstName( nlGetFormatter(instanceId) instanceId )
    nlPrintString( netlister sprintf( nil " (%s %s) capacitor c=%sf"
      port1 port2 nlGetParamStringValue( instanceId "cap")) )

  );let
); procedure S130icecapSpectreNLProc

/*==================================  EOF  ===================================*/
