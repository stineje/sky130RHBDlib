
;; ***** Resistor CDF Callback Definitions *****
;---------------------------------------
; Check CDF parameters
;---------------------------------------
; Many values in this are hard coded, in the future this could use 
; variables loaded from a file
procedure(S8hrpolyCB(param)
  let( (cv tfId mfgGrid 
        res resMax resMin segL segLMax segLMin segW segWMax segWMin segments
        segmentsMax segmentsMin contRows contRowsMax contRowsMin rType rCalcMethod
        segmentSP segmentSPMax segmentSPMin rtn )

    cv = cdfgData->id~>master || cdfgData->id
    tfId = techGetTechFile(cv)
    mfgGrid = techGetMfgGridResolution(tfId)

    ; base params
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
    segLMax = 30000.0
    ; needs to be revisited as the contRows can break the serp r
    ; just set some limits so it won't make a mess
    if( rType == "Serpentine" && segments > 1 then
      ; segL can't be <= lHead*2
      segLMin = 2*2.08 + mfgGrid
      contRowsMax = max(1,fix((segL-mfgGrid+0.46)/4.62)-1)
    else
      segLMin = 0.5 
      contRowsMax = 100 
    ); if Serpentine & m>1
    segWMax = 1000.0 
    segWMin = 0.33 
    segmentsMax = 30000 
    segmentsMin = 1 
    contRowsMin = 1
    segmentSPMax = 2.0 
    ; segmentSPMin depends on if the segW is less than presContW+2*max(polyOLpresContW li1OLLlicon1) &
    ; spacing of poly or li1 or slotted licon1
    ; preslicon1MinW = 0.19, polyOLpresContW = 0.05 li1OLLlicon1 = 0.08 polyMinSP = 0.21 li1MinSP = 0.14 licon1SP = 0.51
    ; only written out so later the numbers can be replaced with variables
    ; Also check in the segW check as the segW effects the segmentSPMin
    segmentSPMin = 
            if( rType == "Serpentine" || (segW + 0.21) > 0.19+0.51 then
              0.21
            else
              max( 2*0.08+0.19+0.14 2*0.05+0.19+0.21 0.19+0.51) - segW
            )

    caseq( param

      ( res
        if( numberp(res) then
          res = S8Round(res 0.001)
          res = S8CheckRange(cdfgData->res->prompt res resMin resMax)

          rtn = S8hrpolyResCalc(rCalcMethod res segL segW segments contRows rType mfgGrid)

          ;; check segL, res limits
          ;; check if segL will violate limits, recalc res
          if( atof(nth(1 rtn)) > segLMax then
            warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
              cdfgData->segL->prompt nth(1 rtn) segLMax cdfgData->res->prompt))
            rtn = S8hrpolyResCalc("Segment Length" res segLMax segW segments contRows rType mfgGrid)
          else
            if( atof(nth(1 rtn)) < segLMin then
              warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                cdfgData->segL->prompt nth(1 rtn) segLMin cdfgData->res->prompt))
              rtn = S8hrpolyResCalc("Segment Length" res segLMin segW segments contRows rType mfgGrid)
            ); if
          ); if

          cdfgData->res->value = nth(0 rtn) 
          cdfgData->segL->value = nth(1 rtn) 
        ); if 
      ); end res param

      ( segL 
        if( numberp(segL) then
          segL = S8Round(segL mfgGrid)
          segL = S8CheckRange(cdfgData->segL->prompt segL segLMin segLMax)

          rtn = S8hrpolyResCalc(rCalcMethod res segL segW segments contRows rType mfgGrid)

          ;; check segL, res limits
          ;; check if res will violate limits, recalc segL 
          if( atof(nth(0 rtn)) > resMax then
            warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
              cdfgData->res->prompt nth(0 rtn) resMax cdfgData->segL->prompt))
            rtn = S8hrpolyResCalc("Total Resistance" resMax segL segW segments contRows rType mfgGrid)
          else
            if( atof(nth(0 rtn)) < resMin then
              warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                cdfgData->res->prompt nth(0 rtn) resMin cdfgData->segL->prompt))
              rtn = S8hrpolyResCalc("Total Resistance" resMin segL segW segments contRows rType mfgGrid)
            ); if
          ); if

          cdfgData->res->value = nth(0 rtn) 
          cdfgData->segL->value = nth(1 rtn) 
        ); if
      ); end segL param

      ( segW
        if( numberp(segW) then
          segW = S8Round(segW mfgGrid)
          segW = S8CheckRange(cdfgData->segW->prompt segW segWMin segWMax)

          ; the segW can effect the segmentSP if the segW creates a dogbone
          segmentSPMin = 
            if( rType == "Serpentine" || (segW + 0.21) > 0.19+0.51 then
              0.21
            else
              max( 2*0.08+0.19+0.14, 2*0.05+0.19+0.21, 0.19+0.51 ) - segW
            )
          segmentSP = S8CheckRange(cdfgData->segmentSP->prompt segmentSP segmentSPMin segmentSPMax)
          cdfgData->segmentSP->value = sprintf( nil "%.3f" segmentSP )

          rtn = S8hrpolyResCalc(rCalcMethod res segL segW segments contRows rType mfgGrid)

          cdfgData->segW->value = S8TruncateZeros(segW)
          
          ;; check segL, res limits
          case( rCalcMethod 
            ("Total Resistance"
              ;; check if segL will violate limits, recalc res
              if( atof(nth(1 rtn)) > segLMax then
                warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                  cdfgData->segL->prompt nth(1 rtn) segLMax cdfgData->res->prompt))
                rtn = S8hrpolyResCalc("Segment Length" res segLMax segW segments contRows rType mfgGrid)
              else
                if( atof(nth(1 rtn)) < segLMin then
                  warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                    cdfgData->segL->prompt nth(1 rtn) segLMin cdfgData->res->prompt))
                  rtn = S8hrpolyResCalc("Segment Length" res segLMin segW segments contRows rType mfgGrid)
                ); if
              ); if

              ;; check if res will violate limits, recalc segL 
              if( atof(nth(0 rtn)) > resMax then
                warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                  cdfgData->res->prompt nth(0 rtn) resMax cdfgData->segL->prompt))
                rtn = S8hrpolyResCalc("Total Resistance" resMax segL segW segments contRows rType mfgGrid)
              else
                if( atof(nth(0 rtn)) < resMin then
                  warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                    cdfgData->res->prompt nth(0 rtn) resMin cdfgData->segL->prompt))
                  rtn = S8hrpolyResCalc("Total Resistance" resMin segL segW segments contRows rType mfgGrid)
                ); if
              ); if
            )
            ("Segment Length"
              ;; check if res will violate limits, recalc segL 
              if( atof(nth(0 rtn)) > resMax then
                warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                  cdfgData->res->prompt nth(0 rtn) resMax cdfgData->segL->prompt))
                rtn = S8hrpolyResCalc("Total Resistance" resMax segL segW segments contRows rType mfgGrid)
              else
                if( atof(nth(0 rtn)) < resMin then
                  warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                    cdfgData->res->prompt nth(0 rtn) resMin cdfgData->segL->prompt))
                  rtn = S8hrpolyResCalc("Total Resistance" resMin segL segW segments contRows rType mfgGrid)
                ); if
              ); if

              ;; check if segL will violate limits, recalc res
              if( atof(nth(1 rtn)) > segLMax then
                warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                  cdfgData->segL->prompt nth(1 rtn) segLMax cdfgData->res->prompt))
                rtn = S8hrpolyResCalc("Segment Length" res segLMax segW segments contRows rType mfgGrid)
              else
                if( atof(nth(1 rtn)) < segLMin then
                  warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                    cdfgData->segL->prompt nth(1 rtn) segLMin cdfgData->res->prompt))
                  rtn = S8hrpolyResCalc("Segment Length" res segLMin segW segments contRows rType mfgGrid)
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
          segmentSP = S8Round(segmentSP mfgGrid)
          segmentSP = S8CheckRange(cdfgData->segmentSP->prompt segmentSP segmentSPMin segmentSPMax)
          cdfgData->segmentSP->value = sprintf( nil "%.3f" segmentSP )

          when( rType == "Serpentine" && segments > 1
            rtn = S8hrpolyResCalc(rCalcMethod res segL segW segments contRows rType mfgGrid)

            ;; check segL, res limits
            ;; check if res will violate limits, recalc segL 
            if( atof(nth(0 rtn)) > resMax then
              warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                cdfgData->res->prompt nth(0 rtn) resMax cdfgData->segL->prompt))
              rtn = S8hrpolyResCalc("Total Resistance" resMax segL segW segments contRows rType mfgGrid)
            else
              if( atof(nth(0 rtn)) < resMin then
                warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                  cdfgData->res->prompt nth(0 rtn) resMin cdfgData->segL->prompt))
                rtn = S8hrpolyResCalc("Total Resistance" resMin segL segW segments contRows rType mfgGrid)
              ); if
            ); if

            cdfgData->res->value = nth(0 rtn) 
            cdfgData->segL->value = nth(1 rtn) 
          ); when Serpentine
        ); if
      ); end segmentSP param

      ( rType 
        rtn = S8hrpolyResCalc(rCalcMethod res segL segW segments contRows rType mfgGrid)

        ;; check segL, res limits
        case( rCalcMethod 
          ("Total Resistance"
            ;; check if segL will violate limits, recalc res
            if( atof(nth(1 rtn)) > segLMax then
              warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                cdfgData->segL->prompt nth(1 rtn) segLMax cdfgData->res->prompt))
              rtn = S8hrpolyResCalc("Segment Length" res segLMax segW segments contRows rType mfgGrid)
            else
              if( atof(nth(1 rtn)) < segLMin then
                warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                  cdfgData->segL->prompt nth(1 rtn) segLMin cdfgData->res->prompt))
                rtn = S8hrpolyResCalc("Segment Length" res segLMin segW segments contRows rType mfgGrid)
              ); if
            ); if

            ;; check if res will violate limits, recalc segL 
            if( atof(nth(0 rtn)) > resMax then
              warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                cdfgData->res->prompt nth(0 rtn) resMax cdfgData->segL->prompt))
              rtn = S8hrpolyResCalc("Total Resistance" resMax segL segW segments contRows rType mfgGrid)
            else
              if( atof(nth(0 rtn)) < resMin then
                warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                  cdfgData->res->prompt nth(0 rtn) resMin cdfgData->segL->prompt))
                rtn = S8hrpolyResCalc("Total Resistance" resMin segL segW segments contRows rType mfgGrid)
              ); if
            ); if
          )
          ("Segment Length"
            ;; check if res will violate limits, recalc segL 
            if( atof(nth(0 rtn)) > resMax then
              warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                cdfgData->res->prompt nth(0 rtn) resMax cdfgData->segL->prompt))
              rtn = S8hrpolyResCalc("Total Resistance" resMax segL segW segments contRows rType mfgGrid)
            else
              if( atof(nth(0 rtn)) < resMin then
                warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                  cdfgData->res->prompt nth(0 rtn) resMin cdfgData->segL->prompt))
                rtn = S8hrpolyResCalc("Total Resistance" resMin segL segW segments contRows rType mfgGrid)
              ); if
            ); if

            ;; check if segL will violate limits, recalc res
            if( atof(nth(1 rtn)) > segLMax then
              warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                cdfgData->segL->prompt nth(1 rtn) segLMax cdfgData->res->prompt))
              rtn = S8hrpolyResCalc("Segment Length" res segLMax segW segments contRows rType mfgGrid)
            else
              if( atof(nth(1 rtn)) < segLMin then
                warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                  cdfgData->segL->prompt nth(1 rtn) segLMin cdfgData->res->prompt))
                rtn = S8hrpolyResCalc("Segment Length" res segLMin segW segments contRows rType mfgGrid)
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
          segments = S8CheckRange(cdfgData->segments->prompt segments segmentsMin segmentsMax)

          rtn = S8hrpolyResCalc(rCalcMethod res segL segW segments contRows rType mfgGrid)

          cdfgData->segments->value = segments
  
          ;; check segL, res limits
          case( rCalcMethod 
            ("Total Resistance"
              ;; check if segL will violate limits, recalc res
              if( atof(nth(1 rtn)) > segLMax then
                warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                  cdfgData->segL->prompt nth(1 rtn) segLMax cdfgData->res->prompt))
                rtn = S8hrpolyResCalc("Segment Length" res segLMax segW segments contRows rType mfgGrid)
              else
                if( atof(nth(1 rtn)) < segLMin then
                  warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                    cdfgData->segL->prompt nth(1 rtn) segLMin cdfgData->res->prompt))
                  rtn = S8hrpolyResCalc("Segment Length" res segLMin segW segments contRows rType mfgGrid)
                ); if
              ); if

              ;; check if res will violate limits, recalc segL 
              if( atof(nth(0 rtn)) > resMax then
                warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                  cdfgData->res->prompt nth(0 rtn) resMax cdfgData->segL->prompt))
                rtn = S8hrpolyResCalc("Total Resistance" resMax segL segW segments contRows rType mfgGrid)
              else
                if( atof(nth(0 rtn)) < resMin then
                  warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                    cdfgData->res->prompt nth(0 rtn) resMin cdfgData->segL->prompt))
                  rtn = S8hrpolyResCalc("Total Resistance" resMin segL segW segments contRows rType mfgGrid)
                ); if
              ); if
            )
            ("Segment Length"
              ;; check if res will violate limits, recalc segL 
              if( atof(nth(0 rtn)) > resMax then
                warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                  cdfgData->res->prompt nth(0 rtn) resMax cdfgData->segL->prompt))
                rtn = S8hrpolyResCalc("Total Resistance" resMax segL segW segments contRows rType mfgGrid)
              else
                if( atof(nth(0 rtn)) < resMin then
                  warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                    cdfgData->res->prompt nth(0 rtn) resMin cdfgData->segL->prompt))
                  rtn = S8hrpolyResCalc("Total Resistance" resMin segL segW segments contRows rType mfgGrid)
                ); if
              ); if

              ;; check if segL will violate limits, recalc res
              if( atof(nth(1 rtn)) > segLMax then
                warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                  cdfgData->segL->prompt nth(1 rtn) segLMax cdfgData->res->prompt))
                rtn = S8hrpolyResCalc("Segment Length" res segLMax segW segments contRows rType mfgGrid)
              else
                if( atof(nth(1 rtn)) < segLMin then
                  warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                    cdfgData->segL->prompt nth(1 rtn) segLMin cdfgData->res->prompt))
                  rtn = S8hrpolyResCalc("Segment Length" res segLMin segW segments contRows rType mfgGrid)
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
          contRows = S8CheckRange(cdfgData->contRows->prompt contRows contRowsMin contRowsMax)

          rtn = S8hrpolyResCalc(rCalcMethod res segL segW segments contRows rType mfgGrid)

          cdfgData->contRows->value = contRows
  
          /* this will only be needed if rHead changes but we are keeping it to only use one contRow

          ;; check segL, res limits
          case( rCalcMethod 
            ("Total Resistance"
              ;; check if segL will violate limits, recalc res
              if( atof(nth(1 rtn)) > segLMax then
                warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                  cdfgData->segL->prompt nth(1 rtn) segLMax cdfgData->res->prompt))
                rtn = S8hrpolyResCalc("Segment Length" res segLMax segW segments contRows rType mfgGrid)
              else
                if( atof(nth(1 rtn)) < segLMin then
                  warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                    cdfgData->segL->prompt nth(1 rtn) segLMin cdfgData->res->prompt))
                  rtn = S8hrpolyResCalc("Segment Length" res segLMin segW segments contRows rType mfgGrid)
                ); if
              ); if

              ;; check if res will violate limits, recalc segL 
              if( atof(nth(0 rtn)) > resMax then
                warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                  cdfgData->res->prompt nth(0 rtn) resMax cdfgData->segL->prompt))
                rtn = S8hrpolyResCalc("Total Resistance" resMax segL segW segments contRows rType mfgGrid)
              else
                if( atof(nth(0 rtn)) < resMin then
                  warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                    cdfgData->res->prompt nth(0 rtn) resMin cdfgData->segL->prompt))
                  rtn = S8hrpolyResCalc("Total Resistance" resMin segL segW segments contRows rType mfgGrid)
                ); if
              ); if
            )
            ("Segment Length"
              ;; check if res will violate limits, recalc segL 
              if( atof(nth(0 rtn)) > resMax then
                warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                  cdfgData->res->prompt nth(0 rtn) resMax cdfgData->segL->prompt))
                rtn = S8hrpolyResCalc("Total Resistance" resMax segL segW segments contRows rType mfgGrid)
              else
                if( atof(nth(0 rtn)) < resMin then
                  warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                    cdfgData->res->prompt nth(0 rtn) resMin cdfgData->segL->prompt))
                  rtn = S8hrpolyResCalc("Total Resistance" resMin segL segW segments contRows rType mfgGrid)
                ); if
              ); if

              ;; check if segL will violate limits, recalc res
              if( atof(nth(1 rtn)) > segLMax then
                warn(sprintf(nil "%s out of range (%s > %.3f). Recalculating %s."
                  cdfgData->segL->prompt nth(1 rtn) segLMax cdfgData->res->prompt))
                rtn = S8hrpolyResCalc("Segment Length" res segLMax segW segments contRows rType mfgGrid)
              else
                if( atof(nth(1 rtn)) < segLMin then
                  warn(sprintf(nil "%s out of range (%s < %.3f). Recalculating %s."
                    cdfgData->segL->prompt nth(1 rtn) segLMin cdfgData->res->prompt))
                  rtn = S8hrpolyResCalc("Segment Length" res segLMin segW segments contRows rType mfgGrid)
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
    
    S8CalcNetlistValues( mfgGrid )

  ); let
); procedure S8hrpolyCB

;---------------------------------------
; Calculate Resistance - hrpoly
;---------------------------------------
procedure(S8hrpolyResCalc(rCalcMethod res segL segW segments contRows rType mfgGrid)
  let((rshPoly cornerFactor rHead tmpsegL segLStr tmpres resStr lHead polyConnL totalL)

    ;; Calculate segment length from resistance
    ;rshPoly = 319.8
    rshPoly = cdfParseFloatString(cdfgData->sheetRho->value)
    polyConnL = cdfParseFloatString(cdfgData->segmentSP->value)
    cornerFactor = 0.56
    rHead = S8hrpolyRheadCalc(segW contRows)
    ; set headRes in cdf
    cdfgData->headRes->value = sprintf(nil "%f" rHead ) 
    lHead = 2.08 + 2.35*(contRows - 1)

    case( rType
      ( "Series"
        case( rCalcMethod 
          ("Total Resistance"
            totalL = (res-2*rHead*segments)*segW/rshPoly
            tmpsegL = totalL/segments 
            tmpsegL = S8Round(tmpsegL mfgGrid)
  
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
            tmpsegL = S8Round(tmpsegL mfgGrid)
  
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
                tmpsegL = S8Round(tmpsegL mfgGrid)

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
                tmpsegL = S8Round(tmpsegL mfgGrid)

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
                tmpsegL = S8Round(tmpsegL mfgGrid)

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
    segLStr = S8TruncateZeros(tmpsegL)

    list(resStr segLStr)

  ); let
); procedure S8hrpolyResCalc

;---------------------------------------
; Calculate Head Resistance
;---------------------------------------
procedure(S8hrpolyRheadCalc(segW contRows)
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
); procedure S8hrpolyRheadCalc

;---------------------------------------
; Check min/max for param
;---------------------------------------
procedure(S8CheckRange(paramName val minVal maxVal)
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
); procedure S8CheckRange

;---------------------------------------
; Rounding to grid
;---------------------------------------
procedure(S8Round(value grid)
  let( (intVal decVal)
    ;;round(value/grid)*grid

    ;; Round only decimal portion of number, then add back to integer portion
    ;; Do this to prevent hitting max integer value in round() when val is a large number

    intVal = floor(value)
    decVal = value - intVal

    intVal + round(decVal/grid)*grid

  ) ; end let
) ; end procedure

;---------------------------------------
; Truncates zeros
;---------------------------------------
procedure( S8TruncateZeros(val)
  let( ()
    ;; val = float
    ;; returns string with trailing zeros truncated down to 0.001
    ;; beyond 0.001, full precision returned

    ;; if an integer
    if( abs(val - S8Round(val 1)) < 1e-6 then
      sprintf(nil "%.0f" val)
    else
      if( abs(val - S8Round(val 0.1)) < 1e-6 then
        sprintf(nil "%.1f" val)
      else
        if( abs(val - S8Round(val 0.01)) < 1e-6 then
          sprintf(nil "%.2f" val)
        else
          if( abs(val - S8Round(val 0.001)) < 1e-6 then
            sprintf(nil "%.3f" val)
          else
            sprintf(nil "%f" val)
          ); if
        ); if
      ); if
    ); if
  ); let
); procedure S8TruncateZeros

;---------------------------------------
; Calculate values for auLVS & auCdl netlists
;---------------------------------------
procedure( S8CalcNetlistValues( grid )
  let( ( rType res rHead sheetRho segRes segW segL segments )
    rType     = cdfgData->rType->value
    res       = cdfParseFloatString(cdfgData->res->value)
    rHead     = cdfParseFloatString(cdfgData->headRes->value)
    sheetRho  = cdfParseFloatString(cdfgData->sheetRho->value)
    segRes    = cdfParseFloatString(cdfgData->segRes->value)
    segL      = cdfParseFloatString(cdfgData->segL->value)
    segW      = cdfParseFloatString(cdfgData->segW->value)
    segments  = cdfgData->segments->value

    cdfgData->w->value = sprintf( nil "%.3f" segW )
    
    case( rType
      ( "Parallel"
        cdfgData->m->value = segments
        cdfgData->l->value = sprintf( nil "%.3f" segL )
        cdfgData->r->value = sprintf( nil "%.3f" segRes )
      )
      ( "Series"
        cdfgData->m->value = 1
        cdfgData->l->value = sprintf( nil "%.3f" round(segL*segments/grid)*grid )
        cdfgData->r->value = sprintf( nil "%.3f" segRes*segments )
      )
      ( "Serpentine"
        cdfgData->m->value = 1
        cdfgData->l->value = sprintf( nil "%.3f" (res-2*rHead)*segW/sheetRho )
        cdfgData->r->value = sprintf( nil "%.3f" res-2*rHead )
      )
    ); end if rType
  ); let
); procedure S8CalcNetlistValues


/*==============================================================================
  Netlisting procedures for S8 devices
==============================================================================*/

; Spectre & other sim netlising
;---------------------------------------
procedure( S8resNLProc( instanceId )
  let( ( netlister toolName instName model segL segW segments segSP instName
       port1 port2 port3 newPort1 newPort2 seriesL serpL instSuffix)

    netlister = nlGetNetlister( nlGetFormatter(instanceId) )
    toolName = nlGetToolName( nlGetFormatter(instanceId) )

    model = nlGetParamStringValue( instanceId "model")
    segL = cdfParseFloatString( nlGetParamStringValue( instanceId "segL"))
    segW = cdfParseFloatString( nlGetParamStringValue( instanceId "segW"))
    segments = evalstring(nlGetParamStringValue( instanceId "segments"))
    segSP = cdfParseFloatString( nlGetParamStringValue( instanceId "segmentSP"))

    instName = instanceId->id->name
    port1 = nlGetTerminalSignalName( instanceId "PLUS")
    port2 = nlGetTerminalSignalName( instanceId "MINUS")
    port3 = nlGetTerminalSignalName( instanceId "B") || nil
    instSuffix = ""
    
    case( nlGetParamStringValue( instanceId "rType")
      ("Parallel"
        case( toolName
          ("spectre"
            if( port3 then
              nlPrintInstName( nlGetFormatter(instanceId) instanceId )
              nlPrintString( netlister sprintf( nil " (%s %s %s) %s w=%g l=%g m=%d mult=1"
                 port1 port2 port3 model segW segL segments ) )
            else
              nlPrintInstName( nlGetFormatter(instanceId) instanceId )
              nlPrintString( netlister sprintf( nil " (%s %s) %s w=%g l=%g m=%d mult=1"
                port1 port2 model segW segL segments ) )
            ); end if port3
          )
          (t
            if( port3 then
              nlPrintInstName( nlGetFormatter(instanceId) instanceId )
              nlPrintString( netlister sprintf( nil " (%s %s %s) %s w=%g l=%g m=%d mult=1"
                 port1 port2 port3 model segW segL segments ) )
            else
              nlPrintInstName( nlGetFormatter(instanceId) instanceId )
              nlPrintString( netlister sprintf( nil " (%s %s) %s w=%g l=%g m=%d mult=1"
                port1 port2 model segW segL segments ) )
            ); end if port3
          )
        )
      )
      ("Series"
        for( i 1 segments
          cond(
            ( (i == 1 && i == segments)
              newPort1 = port1
              newPort2 = port2
              instSuffix = ""
            )
            ( i == 1
              newPort1 = port1
              newPort2 = sprintf( nil "%s_%s_%d" instanceId->id->baseName port1 i )
              instSuffix = sprintf(nil "_%d" i) 
            )
            ( i == segments
              newPort1 = sprintf( nil "%s_%s_%d" instanceId->id->baseName port1 i-1 )
              newPort2 = port2
              instSuffix = sprintf(nil "_%d" i) 
            )
            ( t
              newPort1 = sprintf( nil "%s_%s_%d" instanceId->id->baseName port1 i-1 )
              newPort2 = sprintf( nil "%s_%s_%d" instanceId->id->baseName port1 i )
              instSuffix = sprintf(nil "_%d" i) 
            )
          ); end cond

          case( toolName
            ("spectre"
              if( port3 then
                nlPrintInstName( nlGetFormatter(instanceId) instanceId )
                nlPrintString( netlister sprintf( nil "%s (%s %s %s) %s w=%g l=%g m=1 mult=1"
                  instSuffix newPort1 newPort2 port3 model segW segL ) )
              else
                nlPrintInstName( nlGetFormatter(instanceId) instanceId )
                nlPrintString( netlister sprintf( nil "%s (%s %s) %s w=%g l=%g m=1 mult=1"
                  instSuffix newPort1 newPort2 model segW segL ) )
              ); end if port3
            )
            (t
              if( port3 then
                nlPrintInstName( nlGetFormatter(instanceId) instanceId )
                nlPrintString( netlister sprintf( nil "%s (%s %s %s) %s w=%g l=%g m=1 mult=1"
                  instSuffix newPort1 newPort2 port3 model segW segL ) )
              else
                nlPrintInstName( nlGetFormatter(instanceId) instanceId )
                nlPrintString( netlister sprintf( nil "%s (%s %s) %s w=%g l=%g m=1 mult=1"
                  instSuffix newPort1 newPort2 model segW segL ) )
              ); end if port3
            )
          )

          when( i < segments
            nlPrintString( netlister "\n")
          ); end when

        ); end for 1 to segments
      )
      ("Serpentine"
        serpL = segL*segments + (segments - 1)*(segSP + segW) 
        case( toolName
          ("spectre"
            if( port3 then
              nlPrintInstName( nlGetFormatter(instanceId) instanceId )
              nlPrintString( netlister sprintf( nil " (%s %s %s) %s w=%g l=%g m=1 mult=1"
                port1 port2 port3 model segW serpL ) )
            else
              nlPrintInstName( nlGetFormatter(instanceId) instanceId )
              nlPrintString( netlister sprintf( nil " (%s %s) %s w=%g l=%g m=1 mult=1"
                port1 port2 model segW serpL ) )
            ); end if port3
          )
          (t
            if( port3 then
              nlPrintInstName( nlGetFormatter(instanceId) instanceId )
              nlPrintString( netlister sprintf( nil " (%s %s %s) %s w=%g l=%g m=1 mult=1"
                port1 port2 port3 model segW serpL ) )
            else
              nlPrintInstName( nlGetFormatter(instanceId) instanceId )
              nlPrintString( netlister sprintf( nil " (%s %s) %s w=%g l=%g m=1 mult=1"
                port1 port2 model segW serpL ) )
            ); end if port3
          )
        )
      )
    ); end case rType

  );let
); procedure S8resNLProc

