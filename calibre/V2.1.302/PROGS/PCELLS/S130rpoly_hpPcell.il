/*==============================================================================
  File:         S130rpoly_hpPcell.il
  Purpose:      Pcell code for layout and symbols, and cdf setup for hrpoly &
                uhrpoly resistors for Skywater S130 Pcells

  Created:      Mar 12, 2020  Madek Graham
  Description:  Pcell code to create the high precision poly resistors
  
  Devices/views:  rpoly_hp   / layout symbol auCdl auLvs spectre
                  rpoly_hp2K / layout symbol auCdl auLvs spectre

------------------------------------------------------------
  Modifications:
  - Mar 12, 2020 MSG
    Added the wellType parameter to the auCdl siminfo so the model can change
    accordingly
  - Mar 17, 2020 MSG
    added nf to cdl netlisting to spit out as segments
  - Mar 23, 2020 MSG
    Fixed lvs model on placement
  - Mar 26, 2020 MSG
    Added option to turn on/off metal1 connections
  - Jun 27, 2020 MSG
    Changed hvi layer to thkox to accomodate change in PDK
  - Sep 06, 2020 MSG
    Moved let statements to inside pcell def
    Adjusted pin labels so they weren't huge and rotated them
    Fixed bug with one of the align commands

==============================================================================*/

/*==============================================================================

  This file only needs to be loaded once to create the pcells and cdf information
  for the hrResDevices set within the S130techData.il file

==============================================================================*/

let( ( libName )

  libName = "S130"

  foreach( device hrResDevices
    printf("Creating device %s in %s library\n" device->deviceName libName )

    ;===========================================================
    ;***** Define Layout Pcell *****
    ;===========================================================

      pcDefinePCell( list( ddGetObj(libName) device->deviceName "layout" )
        ; formal parameters name value pairs
        (
          ( devInfo       "ilList"  device )
          ( rules         "ilList"  designRules )
          ( grid          "float"   techGetMfgGridResolution(techGetTechFile(ddGetObj(libName))) )
          ( rCalcMethod   "string"  "Resistance" ) ;; values are "Resistance", "Length"
          ( rType         "string"  "Series" ) ;; values are "Series", "Parallel", "Serpentine"
          ( res           "string"  sprintf(nil "%.3f" device->defRes )) 
          ( segW          "string"  sprintf(nil "%.3f" device->defW ))
          ( segL          "string"  sprintf(nil "%.3f" device->defL ))
          ( segments      "int"     1 )
          ( segmentSP     "string"  sprintf( nil "%.3f" device->defSegSP ))
          ( wellType      "string"  "Pwell" ) ;; values are "Pwell" or "Nwell"
          ( vType         "string"  "1.8V") ;; values are "1.8V", "5V", "12V", "20V"
          ( contRows      "int"     1 )
          ( metCont       "boolean" t)
          ( tapTop        "boolean" nil)
          ( tapTopCnt     "boolean" t)
          ( tapBottom     "boolean" nil)
          ( tapBottomCnt  "boolean" t)
          ( tapRight      "boolean" nil)
          ( tapRightCnt   "boolean" t)
          ( tapLeft       "boolean" t)
          ( tapLeftCnt    "boolean" t)
          ; informational for user
          ( sheetRho      "string"  sprintf(nil "%.3f" device->sheetRho ))
          ( segRes        "string"  sprintf(nil "%.5f" device->defSegRes ))
          ( headRes       "string"  sprintf(nil "%.5f" device->defHeadRes ))
        )

        let(( allPresShapes botHead botHeadLi1 botHeadLicon1 botHeadMcon botHeadMet1 cv
          headL headLi1L headLi1W headLicon1Xadj headLicon1Yadj headLicon1sTotalL
          headLicon1sTotalW headMconXadj headMconYadj headMconsTotalL headMconsTotalW
          headMet1L headMet1W headW headXadj headYadj hvi hviBbox imp1L imp1OLresL
          imp1OLresW imp1W imp2L imp2OLresL imp2OLresW imp2W imp3L imp3OLresL imp3OLresW
          imp3W lppShapes minLi1L minLi1W minMet1L minMet1W numXHeadLicon1s numXHeadMcons
          numYHeadMcons nwell nwellBot nwellLft nwellRht nwellTop pinAdj presBotEdge presLftEdge
          presRhtEdge presTopEdge resBody resImp1 resImp1Adjtb resImp1Adjlr resImp1Shape resImp2
          resImp3 resMark resMinContW resTotalL resTotalW segmentL segmentW 
          tapBotAdjL tapBotAdjR tapBotEncPath tapBotL tapBotPath tapBotSubRect tapEncPath
          tapEncPathWithCnt tapImp tapImpOLtap tapLftAdjB tapLftAdjT tapLftEncPath tapLftL tapLftPath
          tapLftSubRect tapMetOLcont tapOLcont tapRhtAdjB tapRhtAdjT tapRhtEncPath tapRhtL tapRhtPath
          tapRhtSubRect taptbSPres taplrSPres tapSubRect tapSubRectWithCnt tapTopAdjL tapTopAdjR tapTopEncPath
          tapTopL tapTopPath tapTopSubRect tapW temp topHead topHeadLi1 topHeadLicon1 topHeadMcon
          topHeadMet1 uhvi uhviBbox vhvi vhviBbox )


        cv = pcCellView

        segmentW  = cdfParseFloatString(segW)
        segmentL  = cdfParseFloatString(segL)
        segmentSP = cdfParseFloatString(segmentSP)

        headL = rules->pres->contL + rules->pres->polyOLScont +
          (contRows - 1)*(rules->pres->contL + rules->pres->contSP)

        when( rType == "Serpentine" && segments > 1
          segmentL = segmentL-2*headL
        ); when Serpentine

        ; create the segments
        for( segment 1 segments 
          resBody = rodCreateRect(
            ?cvId cv
            ?name sprintf( nil "res%d" segment )
            ?layer devInfo->resLay
            ?width segmentW
            ?length segmentL
            ?origin (segment-1)*(segmentW + segmentSP) : 0
          )
          resMark = rodCreateRect(
            ?cvId cv
            ?layer devInfo->mrk1Lay
            ?bBox  list( resBody->lowerLeft resBody->upperRight )
            ?origin (segment-1)*(segmentW + segmentSP) : 0
          )
        ); end for 1 to segments

        ; create Headers
        resMinContW = rules->pres->contW + 2*rules->pres->polyOLLcont

        ; figure out how many and how wide/long all the licon1s will be for fillRect later
        headXadj = 0.0
        headYadj = 0.0
        ; dogbone check and adjustments, & get headLicon numbers needed
        if( segmentW < resMinContW then
          headW = resMinContW
          ; needed to move the serpentine heads over
          ; parallel and series the segment spacing will be adjusted in the cdf
          when( rType == "Serpentine" && segments > 1
            headXadj = resMinContW - segmentW
          ); end when serpentine
          headYadj = rules->pres->polyOLScont
          headL = headL + headYadj
          numXHeadLicon1s = 1
          headLicon1sTotalW = rules->pres->contW
          headLicon1sTotalL = rules->pres->contL + (contRows - 1)*(rules->pres->contL +
            rules->pres->contSP)
        else
          headW = segmentW
          numXHeadLicon1s = 1 + floor( (segmentW - 2*rules->pres->polyOLLcont - 
            rules->pres->contW)/(rules->pres->contW + rules->pres->contSP))
          headLicon1sTotalW = rules->pres->contW + (numXHeadLicon1s-1)*(rules->pres->contW +
            rules->pres->contSP)
          ; ensure the licon1 to licon1 on different segments don't cause a violation, if so, reduce the number of
          ; licon1s by 1
          when( segments > 1 &&
                segmentSP+(segmentW-headLicon1sTotalW) < rules->licon1->minSPslot &&
                numXHeadLicon1s > 1
            numXHeadLicon1s = numXHeadLicon1s - 1
            headLicon1sTotalW = rules->pres->contW + (numXHeadLicon1s-1)*(rules->pres->contW +
              rules->pres->contSP)
          ); end when
          headLicon1sTotalL = rules->pres->contL + (contRows-1)*(rules->pres->contL +
            rules->pres->contSP)
        ); end if segmentW < room for one contact

        ; need to make sure we have some minimums to check against
        minLi1W = 2*max(rules->li1->minOLLlicon1 rules->li1->minOLLmcon) + rules->pres->contW
        minLi1L = 2*max(rules->li1->minOLSlicon1 rules->li1->minOLSmcon) + rules->pres->contL
        minMet1W = 2*rules->met1->minOLLmcon + rules->pres->contW
        minMet1L = 2*rules->met1->minOLSmcon + rules->pres->contL

        ; li1 width and length
        headLi1W = max(minLi1W,2*max(rules->li1->minOLLlicon1,rules->li1->minOLLmcon) +
          headLicon1sTotalW)
        headLi1L = max(minLi1L,2*max(rules->li1->minOLSlicon1,rules->li1->minOLSmcon) +
          headLicon1sTotalL)
        headLicon1Xadj = 0.5*(headLi1W - headLicon1sTotalW)
        headLicon1Yadj = 0.5*(headLi1L - headLicon1sTotalL)

        ; figure out how many and how wide/long all the mcons will be for fillRect later
        if( numXHeadLicon1s == 1 then
          numXHeadMcons = 1
        else
          numXHeadMcons = 1 + floor( (headLi1W - 2*rules->li1->minOLLmcon - rules->mcon->minW)/
            (rules->mcon->minW + rules->mcon->minSP) )
        ); end if numXHeadLicon1s
        numYHeadMcons = 1 + floor( (headLi1L - 2*rules->li1->minOLSmcon - rules->mcon->minW)/
          (rules->mcon->minW + rules->mcon->minSP) )
        headMconsTotalW = rules->mcon->minW + (numXHeadMcons-1)*(rules->mcon->minW +
          rules->mcon->minSP)
        headMconsTotalL = rules->mcon->minW + (numYHeadMcons-1)*(rules->mcon->minW +
          rules->mcon->minSP)

        ; met1 width and length
        headMet1W = headMconsTotalW + 2*rules->met1->minOLLmcon
        headMet1L = headMconsTotalL + 2*rules->met1->minOLSmcon
        headMconXadj = 0.5*(headMet1W - headMconsTotalW)
        headMconYadj = 0.5*(headMet1L - headMconsTotalL)

        for( segment 1 segments

          ; bottom headers
          botHead = rodCreateRect(
            ?cvId cv
            ?name sprintf( nil "botHead%d" segment )
            ?layer devInfo->resLay
            ?width  if( rType != "Serpentine" then
                      headW
                    else
                      if( segment == 1 || (evenp(segments) && segment == segments) then
                        headW
                      else
                        segmentW
                      )
                    )
            ?length headL
          )
          rodAlign(
            ?alignObj     rodGetObj( sprintf( nil "botHead%d" segment ) cv )
            ?alignHandle  if( (segment == 1 || segment == segments) && rType == "Serpentine" && segments > 1 then 
                            if( segment == 1 then "upperRight" else "upperLeft" )
                          else "upperCenter" )
            ?refObj       rodGetObj( sprintf( nil "res%d" segment ) cv )
            ?refHandle    if( (segment == 1 || segment == segments) && rType == "Serpentine" && segments > 1 then 
                            if( segment == 1 then "lowerRight" else "lowerLeft" )
                          else "lowerCenter" )
            ?ySep         headYadj
          )
          ; top headers
          topHead = rodCreateRect(
            ?cvId cv
            ?name sprintf( nil "topHead%d" segment )
            ?layer devInfo->resLay
            ?width  if( rType != "Serpentine" then
                      headW
                    else
                      if( oddp(segments) && segment == segments then headW else segmentW )
                    )
            ?length headL
          )
          rodAlign(
            ?alignObj     rodGetObj( sprintf( nil "topHead%d" segment ) cv )
            ?alignHandle  if( oddp(segments) && segment == segments && rType == "Serpentine" && segments > 1 then
                            "lowerLeft"
                          else
                            "lowerCenter"
                          )
            ?refObj       rodGetObj( sprintf( nil "res%d" segment ) cv )
            ?refHandle    if( oddp(segments) && segment == segments && rType == "Serpentine" && segments > 1 then
                            "upperLeft"
                          else
                            "upperCenter"
                          )
            ?ySep         -headYadj
          )

          ; for types other than Serpentine, we'll need contacts and metal on all headers
          if( rType != "Serpentine" then
            ; bottom headers metal and contacts
            ; could add a contact on/off option here
            botHeadLi1 = rodCreateRect(
              ?cvId     cv
              ?name     sprintf( nil "botHeadLi1%d" segment )
              ?layer    rules->li1->layer
              ?width    headLi1W
              ?length   headLi1L
            )
            rodAlign(
              ?alignObj     rodGetObj( sprintf( nil "botHeadLi1%d" segment ) cv )
              ?alignHandle  "upperCenter"
              ?refObj       rodGetObj( sprintf( nil "botHead%d" segment ) cv )
              ?refHandle    "upperCenter"
              ?ySep         max(rules->li1->minOLSlicon1,rules->li1->minOLSmcon)-headYadj
            )
            botHeadLicon1 = rodFillBBoxWithRects(
              ?cvId         cv
              ?layer        rules->licon1->layer
              ?fillBBox     list(
                              rodAddToY(rodAddToX(botHeadLi1->lowerLeft headLicon1Xadj) headLicon1Yadj)
                              rodAddToY(rodAddToX(botHeadLi1->upperRight -headLicon1Xadj) -headLicon1Yadj)
                            )
              ?width        rules->pres->contW
              ?length       rules->pres->contL
              ?gap          "minimum"
              ?spaceX       rules->pres->contSP
              ?spaceY       rules->pres->contSP
            )
            when( metCont
              botHeadMet1 = rodCreateRect(
                ?cvId     cv
                ?name     sprintf( nil "botHeadMet1%d" segment )
                ?layer    rules->met1->layer
                ?width    headMet1W
                ?length   headMet1L
              )
              rodAlign(
                ?alignObj     rodGetObj( sprintf( nil "botHeadMet1%d" segment ) cv )
                ?alignHandle  "centerCenter"
                ?refObj       rodGetObj( sprintf( nil "botHeadLi1%d" segment ) cv )
                ?refHandle    "centerCenter"
              )
              botHeadMcon = rodFillBBoxWithRects(
                ?cvId         cv
                ?layer        rules->mcon->layer
                ?fillBBox     list(
                                rodAddToY(rodAddToX(botHeadMet1->lowerLeft headMconXadj) headMconYadj)
                                rodAddToY(rodAddToX(botHeadMet1->upperRight -headMconXadj) -headMconYadj)
                              )
                ?width        rules->mcon->minW
                ?length       rules->mcon->minW
                ?gap          "minimum"
                ?spaceX       rules->mcon->minSP
                ?spaceY       rules->mcon->minSP
              )
            ); when metCont

            ; top headers metal and contacts
            topHeadLi1 = rodCreateRect(
              ?cvId     cv
              ?name     sprintf( nil "topHeadLi1%d" segment )
              ?layer    rules->li1->layer
              ?width    headLi1W
              ?length   headLi1L
            )
            rodAlign(
              ?alignObj     rodGetObj( sprintf( nil "topHeadLi1%d" segment ) cv )
              ?alignHandle  "lowerCenter"
              ?refObj       rodGetObj( sprintf( nil "topHead%d" segment ) cv )
              ?refHandle    "lowerCenter"
              ?ySep         -max(rules->li1->minOLSlicon1,rules->li1->minOLSmcon)+headYadj
            )
            topHeadLicon1 = rodFillBBoxWithRects(
              ?cvId         cv
              ?layer        rules->licon1->layer
              ?fillBBox     list(
                              rodAddToY(rodAddToX(topHeadLi1->lowerLeft headLicon1Xadj) headLicon1Yadj)
                              rodAddToY(rodAddToX(topHeadLi1->upperRight -headLicon1Xadj) -headLicon1Yadj)
                            )
              ?width        rules->pres->contW
              ?length       rules->pres->contL
              ?gap          "minimum"
              ?spaceX       rules->pres->contSP
              ?spaceY       rules->pres->contSP
            )
            when( metCont
              topHeadMet1 = rodCreateRect(
                ?cvId     cv
                ?name     sprintf( nil "topHeadMet1%d" segment )
                ?layer    rules->met1->layer
                ?width    headMet1W
                ?length   headMet1L
              )
              rodAlign(
                ?alignObj     rodGetObj( sprintf( nil "topHeadMet1%d" segment ) cv )
                ?alignHandle  "centerCenter"
                ?refObj       rodGetObj( sprintf( nil "topHeadLi1%d" segment ) cv )
                ?refHandle    "centerCenter"
              )
              topHeadMcon = rodFillBBoxWithRects(
                ?cvId         cv
                ?layer        rules->mcon->layer
                ?fillBBox     list(
                                rodAddToY(rodAddToX(topHeadMet1->lowerLeft headMconXadj) headMconYadj)
                                rodAddToY(rodAddToX(topHeadMet1->upperRight -headMconXadj) -headMconYadj)
                              )
                ?width        rules->mcon->minW
                ?length       rules->mcon->minW
                ?gap          "minimum"
                ?spaceX       rules->mcon->minSP
                ?spaceY       rules->mcon->minSP
              )
            ); when metCont
          else
            when( segment == 1
              botHeadLi1 = rodCreateRect(
                ?cvId     cv
                ?name     sprintf( nil "botHeadLi1%d" segment )
                ?layer    rules->li1->layer
                ?width    headLi1W
                ?length   headLi1L
              )
              rodAlign(
                ?alignObj     rodGetObj( sprintf( nil "botHeadLi1%d" segment ) cv )
                ?alignHandle  "upperCenter"
                ?refObj       rodGetObj( sprintf( nil "botHead%d" segment ) cv )
                ?refHandle    "upperCenter"
                ?ySep         max(rules->li1->minOLSlicon1,rules->li1->minOLSmcon)-headYadj
              )
              botHeadLicon1 = rodFillBBoxWithRects(
                ?cvId         cv
                ?layer        rules->licon1->layer
                ?fillBBox     list(
                                rodAddToY(rodAddToX(botHeadLi1->lowerLeft headLicon1Xadj) headLicon1Yadj)
                                rodAddToY(rodAddToX(botHeadLi1->upperRight -headLicon1Xadj) -headLicon1Yadj)
                              )
                ?width        rules->pres->contW
                ?length       rules->pres->contL
                ?gap          "minimum"
                ?spaceX       rules->pres->contSP
                ?spaceY       rules->pres->contSP
              )
              when( metCont
                botHeadMet1 = rodCreateRect(
                  ?cvId     cv
                  ?name     sprintf( nil "botHeadMet1%d" segment )
                  ?layer    rules->met1->layer
                  ?width    headMet1W
                  ?length   headMet1L
                )
                rodAlign(
                  ?alignObj     rodGetObj( sprintf( nil "botHeadMet1%d" segment ) cv )
                  ?alignHandle  "centerCenter"
                  ?refObj       rodGetObj( sprintf( nil "botHeadLi1%d" segment ) cv )
                  ?refHandle    "centerCenter"
                )
                botHeadMcon = rodFillBBoxWithRects(
                  ?cvId         cv
                  ?layer        rules->mcon->layer
                  ?fillBBox     list(
                                  rodAddToY(rodAddToX(botHeadMet1->lowerLeft headMconXadj) headMconYadj)
                                  rodAddToY(rodAddToX(botHeadMet1->upperRight -headMconXadj) -headMconYadj)
                                )
                  ?width        rules->mcon->minW
                  ?length       rules->mcon->minW
                  ?gap          "minimum"
                  ?spaceX       rules->mcon->minSP
                  ?spaceY       rules->mcon->minSP
                )
              ); when metCont
            ); end when
            when( segment == segments
              if( oddp(segments) then
                topHeadLi1 = rodCreateRect(
                  ?cvId     cv
                  ?name     sprintf( nil "topHeadLi1%d" segment )
                  ?layer    rules->li1->layer
                  ?width    headLi1W
                  ?length   headLi1L
                )
                rodAlign(
                  ?alignObj     rodGetObj( sprintf( nil "topHeadLi1%d" segment ) cv )
                  ?alignHandle  "lowerCenter"
                  ?refObj       rodGetObj( sprintf( nil "topHead%d" segment ) cv )
                  ?refHandle    "lowerCenter"
                  ?ySep         -max(rules->li1->minOLSlicon1,rules->li1->minOLSmcon)+headYadj
                )
                topHeadLicon1 = rodFillBBoxWithRects(
                  ?cvId         cv
                  ?layer        rules->licon1->layer
                  ?fillBBox     list(
                                  rodAddToY(rodAddToX(topHeadLi1->lowerLeft headLicon1Xadj) headLicon1Yadj)
                                  rodAddToY(rodAddToX(topHeadLi1->upperRight -headLicon1Xadj) -headLicon1Yadj)
                                )
                  ?width        rules->pres->contW
                  ?length       rules->pres->contL
                  ?gap          "minimum"
                  ?spaceX       rules->pres->contSP
                  ?spaceY       rules->pres->contSP
                )
                when( metCont
                  topHeadMet1 = rodCreateRect(
                    ?cvId     cv
                    ?name     sprintf( nil "topHeadMet1%d" segment )
                    ?layer    rules->met1->layer
                    ?width    headMet1W
                    ?length   headMet1L
                  )
                  rodAlign(
                    ?alignObj     rodGetObj( sprintf( nil "topHeadMet1%d" segment ) cv )
                    ?alignHandle  "centerCenter"
                    ?refObj       rodGetObj( sprintf( nil "topHeadLi1%d" segment ) cv )
                    ?refHandle    "centerCenter"
                  )
                  topHeadMcon = rodFillBBoxWithRects(
                    ?cvId         cv
                    ?layer        rules->mcon->layer
                    ?fillBBox     list(
                                    rodAddToY(rodAddToX(topHeadMet1->lowerLeft headMconXadj) headMconYadj)
                                    rodAddToY(rodAddToX(topHeadMet1->upperRight -headMconXadj) -headMconYadj)
                                  )
                    ?width        rules->mcon->minW
                    ?length       rules->mcon->minW
                    ?gap          "minimum"
                    ?spaceX       rules->mcon->minSP
                    ?spaceY       rules->mcon->minSP
                  )
                ); when metCont
              else
                botHeadLi1 = rodCreateRect(
                  ?cvId     cv
                  ?name     sprintf( nil "botHeadLi1%d" segment )
                  ?layer    rules->li1->layer
                  ?width    headLi1W
                  ?length   headLi1L
                )
                rodAlign(
                  ?alignObj     rodGetObj( sprintf( nil "botHeadLi1%d" segment ) cv )
                  ?alignHandle  "upperCenter"
                  ?refObj       rodGetObj( sprintf( nil "botHead%d" segment ) cv )
                  ?refHandle    "upperCenter"
                  ?ySep         max(rules->li1->minOLSlicon1,rules->li1->minOLSmcon)-headYadj
                )
                botHeadLicon1 = rodFillBBoxWithRects(
                  ?cvId         cv
                  ?layer        rules->licon1->layer
                  ?fillBBox     list(
                                  rodAddToY(rodAddToX(botHeadLi1->lowerLeft headLicon1Xadj) headLicon1Yadj)
                                  rodAddToY(rodAddToX(botHeadLi1->upperRight -headLicon1Xadj) -headLicon1Yadj)
                                )
                  ?width        rules->pres->contW
                  ?length       rules->pres->contL
                  ?gap          "minimum"
                  ?spaceX       rules->pres->contSP
                  ?spaceY       rules->pres->contSP
                )
                when( metCont
                  botHeadMet1 = rodCreateRect(
                    ?cvId     cv
                    ?name     sprintf( nil "botHeadMet1%d" segment )
                    ?layer    rules->met1->layer
                    ?width    headMet1W
                    ?length   headMet1L
                  )
                  rodAlign(
                    ?alignObj     rodGetObj( sprintf( nil "botHeadMet1%d" segment ) cv )
                    ?alignHandle  "centerCenter"
                    ?refObj       rodGetObj( sprintf( nil "botHeadLi1%d" segment ) cv )
                    ?refHandle    "centerCenter"
                  )
                  botHeadMcon = rodFillBBoxWithRects(
                    ?cvId         cv
                    ?layer        rules->mcon->layer
                    ?fillBBox     list(
                                    rodAddToY(rodAddToX(botHeadMet1->lowerLeft headMconXadj) headMconYadj)
                                    rodAddToY(rodAddToX(botHeadMet1->upperRight -headMconXadj) -headMconYadj)
                                  )
                    ?width        rules->mcon->minW
                    ?length       rules->mcon->minW
                    ?gap          "minimum"
                    ?spaceX       rules->mcon->minSP
                    ?spaceY       rules->mcon->minSP
                  )
                ); when metCont
              ); end if semgments are odd
            ); end when last segment
            
          ); end if rType == "Serpentine"

        ); end for 1 to segments
        
        ; Time to connect the segments based on the rType
        ; no connections needed if there is only one segment
        when( segments > 1
          case( rType
            ("Series"
              for( segment 1 segments-1
                if( oddp(segment) then
                  rodCreateRect(
                    ?cvId   cv
                    ?name   sprintf( nil "connectLi1Top%d" segment )
                    ?layer  rules->li1->layer
                    ?bBox   list(
                              rodGetObj(sprintf(nil "topHeadLi1%d" segment)  cv)->lowerLeft
                              rodGetObj( sprintf(nil "topHeadLi1%d" segment+1) cv)->upperRight
                            )
                  )
                  when( metCont
                    rodCreateRect(
                      ?cvId   cv
                      ?name   sprintf( nil "connectMet1Top%d" segment )
                      ?layer  rules->met1->layer
                      ?bBox   list(
                                rodGetObj(sprintf(nil "topHeadMet1%d" segment)  cv)->lowerLeft
                                rodGetObj( sprintf(nil "topHeadMet1%d" segment+1) cv)->upperRight
                              )
                    )
                  ); when metCont
                else ; even segment
                  rodCreateRect(
                    ?cvId   cv
                    ?name   sprintf( nil "connectLi1Bot%d" segment )
                    ?layer  rules->li1->layer
                    ?bBox   list(
                              rodGetObj(sprintf(nil "botHeadLi1%d" segment)  cv)->lowerLeft
                              rodGetObj( sprintf(nil "botHeadLi1%d" segment+1) cv)->upperRight
                            )
                  )
                  when( metCont
                    rodCreateRect(
                      ?cvId   cv
                      ?name   sprintf( nil "connectMet1Bot%d" segment )
                      ?layer  rules->met1->layer
                      ?bBox   list(
                                rodGetObj(sprintf(nil "botHeadMet1%d" segment)  cv)->lowerLeft
                                rodGetObj( sprintf(nil "botHeadMet1%d" segment+1) cv)->upperRight
                              )
                    )
                  ); when metCont
                ); end if segment is odd
              ); end for 1 to segments-1
            ); end case "Series"
            ("Parallel"
              rodCreateRect(
                ?cvId   cv
                ?name   "connectLi1Bot1"
                ?layer  rules->li1->layer
                ?bBox   list(
                          rodGetObj("botHeadLi11" cv)->lowerLeft
                          rodGetObj( sprintf(nil "botHeadLi1%d" segments) cv)->upperRight
                        )
              )
              when( metCont
                rodCreateRect(
                  ?cvId   cv
                  ?name   "connectMet1Bot1"
                  ?layer  rules->met1->layer
                  ?bBox   list(
                            rodGetObj("botHeadMet11" cv)->lowerLeft
                            rodGetObj( sprintf(nil "botHeadMet1%d" segments) cv)->upperRight
                          )
                )
              ); when metCont
              rodCreateRect(
                ?cvId   cv
                ?name   "connectLi1Top1"
                ?layer  rules->li1->layer
                ?bBox   list(
                          rodGetObj("topHeadLi11" cv)->lowerLeft
                          rodGetObj( sprintf(nil "topHeadLi1%d" segments) cv)->upperRight
                        )
              )
              when( metCont
                rodCreateRect(
                  ?cvId   cv
                  ?name   "connectMet1Top1"
                  ?layer  rules->met1->layer
                  ?bBox   list(
                            rodGetObj("topHeadMet11" cv)->lowerLeft
                            rodGetObj( sprintf(nil "topHeadMet1%d" segments) cv)->upperRight
                          )
                )
              ); when metCont
            ); end case "Parallel"
            ("Serpentine"
              for( segment 1 segments-1
                if( oddp(segment) then
                  rodCreateRect(
                    ?cvId   cv
                    ?name   sprintf( nil "connectPolyTop%d" segment )
                    ?layer  devInfo->resLay
                    ?width  2*segmentW + segmentSP
                    ?length segmentW
                  )
                  rodAlign(
                    ?alignObj     rodGetObj( sprintf( nil "connectPolyTop%d" segment ) cv )
                    ?alignHandle  "upperRight"
                    ?refObj       rodGetObj( sprintf( nil "topHead%d" segment+1 ) cv )
                    ?refHandle    "upperRight"
                  )
                  rodCreateRect(
                    ?cvId   cv
                    ?name   sprintf( nil "connectResIdTop%d" segment )
                    ?layer  devInfo->mrk1Lay
                    ?width  2*devInfo->mrk1OLres + rodGetObj( sprintf( nil "connectPolyTop%d" segment ) cv )->width
                    ?length 2*devInfo->mrk1OLres + rodGetObj( sprintf( nil "connectPolyTop%d" segment ) cv )->length
                  )
                  rodAlign(
                    ?alignObj     rodGetObj( sprintf( nil "connectResIdTop%d" segment ) cv )
                    ?alignHandle  "lowerLeft"
                    ?refObj       rodGetObj( sprintf( nil "connectPolyTop%d" segment ) cv )
                    ?refHandle    "lowerLeft"
                    ?xSep         -devInfo->mrk1OLres
                    ?ySep         -devInfo->mrk1OLres
                  )
                  rodCreateRect(
                    ?cvId   cv
                    ?name   sprintf( nil "connectResIdTopHead%d" segment )
                    ?layer  devInfo->mrk1Lay
                    ?width  2*devInfo->mrk1OLres + rodGetObj( sprintf( nil "topHead%d" segment ) cv )->width
                    ?length 2*devInfo->mrk1OLres + rodGetObj( sprintf( nil "topHead%d" segment ) cv )->length
                  )
                  rodAlign(
                    ?alignObj     rodGetObj( sprintf( nil "connectResIdTopHead%d" segment ) cv )
                    ?alignHandle  "lowerLeft"
                    ?refObj       rodGetObj( sprintf( nil "topHead%d" segment ) cv )
                    ?refHandle    "lowerLeft"
                    ?xSep         -devInfo->mrk1OLres
                    ?ySep         -devInfo->mrk1OLres
                  )
                  rodCreateRect(
                    ?cvId   cv
                    ?name   sprintf( nil "connectResIdTopHead%d" segment+1 )
                    ?layer  devInfo->mrk1Lay
                    ?width  2*devInfo->mrk1OLres + rodGetObj( sprintf( nil "topHead%d" segment+1 ) cv )->width
                    ?length 2*devInfo->mrk1OLres + rodGetObj( sprintf( nil "topHead%d" segment+1 ) cv )->length
                  )
                  rodAlign(
                    ?alignObj     rodGetObj( sprintf( nil "connectResIdTopHead%d" segment+1 ) cv )
                    ?alignHandle  "lowerLeft"
                    ?refObj       rodGetObj( sprintf( nil "topHead%d" segment+1 ) cv )
                    ?refHandle    "lowerLeft"
                    ?xSep         -devInfo->mrk1OLres
                    ?ySep         -devInfo->mrk1OLres
                  )
                else ; even segment
                  rodCreateRect(
                    ?cvId   cv
                    ?name   sprintf( nil "connectPolyBot%d" segment )
                    ?layer  devInfo->resLay
                    ?width  2*segmentW + segmentSP
                    ?length segmentW
                  )
                  rodAlign(
                    ?alignObj     rodGetObj( sprintf( nil "connectPolyBot%d" segment ) cv )
                    ?alignHandle  "lowerLeft"
                    ?refObj       rodGetObj( sprintf( nil "botHead%d" segment ) cv )
                    ?refHandle    "lowerLeft"
                  )
                  rodCreateRect(
                    ?cvId   cv
                    ?name   sprintf( nil "connectResIdBot%d" segment )
                    ?layer  devInfo->mrk1Lay
                    ?width  2*devInfo->mrk1OLres + rodGetObj( sprintf( nil "connectPolyBot%d" segment ) cv )->width
                    ?length 2*devInfo->mrk1OLres + rodGetObj( sprintf( nil "connectPolyBot%d" segment ) cv )->length
                  )
                  rodAlign(
                    ?alignObj     rodGetObj( sprintf( nil "connectResIdBot%d" segment ) cv )
                    ?alignHandle  "lowerLeft"
                    ?refObj       rodGetObj( sprintf( nil "connectPolyBot%d" segment ) cv )
                    ?refHandle    "lowerLeft"
                    ?xSep         -devInfo->mrk1OLres
                    ?ySep         -devInfo->mrk1OLres
                  )
                  rodCreateRect(
                    ?cvId   cv
                    ?name   sprintf( nil "connectResIdBotHead%d" segment )
                    ?layer  devInfo->mrk1Lay
                    ?width  2*devInfo->mrk1OLres + rodGetObj( sprintf( nil "botHead%d" segment ) cv )->width
                    ?length 2*devInfo->mrk1OLres + rodGetObj( sprintf( nil "botHead%d" segment ) cv )->length
                  )
                  rodAlign(
                    ?alignObj     rodGetObj( sprintf( nil "connectResIdBotHead%d" segment ) cv )
                    ?alignHandle  "lowerLeft"
                    ?refObj       rodGetObj( sprintf( nil "botHead%d" segment ) cv )
                    ?refHandle    "lowerLeft"
                    ?xSep         -devInfo->mrk1OLres
                    ?ySep         -devInfo->mrk1OLres
                  )
                  rodCreateRect(
                    ?cvId   cv
                    ?name   sprintf( nil "connectResIdBotHead%d" segment+1 )
                    ?layer  devInfo->mrk1Lay
                    ?width  2*devInfo->mrk1OLres + rodGetObj( sprintf( nil "botHead%d" segment+1 ) cv )->width
                    ?length 2*devInfo->mrk1OLres + rodGetObj( sprintf( nil "botHead%d" segment+1 ) cv )->length
                  )
                  rodAlign(
                    ?alignObj     rodGetObj( sprintf( nil "connectResIdBotHead%d" segment+1 ) cv )
                    ?alignHandle  "lowerLeft"
                    ?refObj       rodGetObj( sprintf( nil "botHead%d" segment+1 ) cv )
                    ?refHandle    "lowerLeft"
                    ?xSep         -devInfo->mrk1OLres
                    ?ySep         -devInfo->mrk1OLres
                  )
                ); end if segment is odd
              ); end for 1 to segments-1
            ); end case "Serpentine"
          ); end case
        ); end when segments > 1

        ; Make the pins
        if( rType == "Parallel" && segments > 1 then
          if( metCont then
            rodCreateRect(
              ?cvId   cv
              ?name   "plusPin"
              ?layer  list( rules->met1->pinlayer rules->met1->pinpurpose )
              ?bBox   list( rodGetObj( "connectMet1Bot1" cv )->lowerLeft rodGetObj( "connectMet1Bot1" cv )->upperRight )
              ?netName  "PLUS"
              ?termName "PLUS"
              ?termIOType "inputOutput"
              ?pin      t
              ?pinLabel t
              ?pinLabelHeight 0.3 
              ?pinLabelOrient "R90" 
              ?pinLabelLayer  list( rules->met1->layer "label")
              ?pinLabelFont   "stick"
            )
            rodCreateRect(
              ?cvId   cv
              ?name   "minusPin"
              ?layer  list( rules->met1->pinlayer rules->met1->pinpurpose )
              ?bBox   list( rodGetObj( "connectMet1Top1" cv )->lowerLeft rodGetObj( "connectMet1Top1" cv )->upperRight )
              ?netName  "MINUS"
              ?termName "MINUS"
              ?termIOType "inputOutput"
              ?pin      t
              ?pinLabel t
              ?pinLabelHeight 0.3 
              ?pinLabelOrient "R90" 
              ?pinLabelLayer  list( rules->met1->layer "label")
              ?pinLabelFont   "stick"
            )
          else
            rodCreateRect(
              ?cvId   cv
              ?name   "plusPin"
              ?layer  list( rules->li1->pinlayer rules->li1->pinpurpose )
              ?bBox   list( rodGetObj( "connectLi1Bot1" cv )->lowerLeft rodGetObj( "connectLi1Bot1" cv )->upperRight )
              ?netName  "PLUS"
              ?termName "PLUS"
              ?termIOType "inputOutput"
              ?pin      t
              ?pinLabel t
              ?pinLabelHeight 0.3 
              ?pinLabelOrient "R90" 
              ?pinLabelLayer  list( rules->li1->layer "label")
              ?pinLabelFont   "stick"
            )
            rodCreateRect(
              ?cvId   cv
              ?name   "minusPin"
              ?layer  list( rules->li1->pinlayer rules->li1->pinpurpose )
              ?bBox   list( rodGetObj( "connectLi1Top1" cv )->lowerLeft rodGetObj( "connectLi1Top1" cv )->upperRight )
              ?netName  "MINUS"
              ?termName "MINUS"
              ?termIOType "inputOutput"
              ?pin      t
              ?pinLabel t
              ?pinLabelHeight 0.3 
              ?pinLabelOrient "R90" 
              ?pinLabelLayer  list( rules->li1->layer "label")
              ?pinLabelFont   "stick"
            )
          ); if metCont
        else
          if( metCont then
            rodCreateRect(
              ?cvId   cv
              ?name   "plusPin"
              ?layer  list( rules->met1->pinlayer rules->met1->pinpurpose )
              ?bBox   list( rodGetObj( "botHeadMet11" cv )->lowerLeft rodGetObj( "botHeadMet11" cv )->upperRight )
              ?netName  "PLUS"
              ?termName "PLUS"
              ?termIOType "inputOutput"
              ?pin      t
              ?pinLabel t
              ?pinLabelHeight 0.3 
              ?pinLabelOrient "R90" 
              ?pinLabelLayer  list( rules->met1->layer "label")
              ?pinLabelFont   "stick"
            )
            rodCreateRect(
              ?cvId   cv
              ?name   "minusPin"
              ?layer  list( rules->met1->pinlayer rules->met1->pinpurpose )
              ?bBox   if( oddp(segments) then
                        list( rodGetObj( sprintf( nil "topHeadMet1%d" segments) cv )->lowerLeft
                          rodGetObj( sprintf( nil "topHeadMet1%d" segments) cv )->upperRight )
                      else
                        list( rodGetObj( sprintf( nil "botHeadMet1%d" segments) cv )->lowerLeft
                          rodGetObj( sprintf( nil "botHeadMet1%d" segments) cv )->upperRight )
                      )
              ?netName  "MINUS"
              ?termName "MINUS"
              ?termIOType "inputOutput"
              ?pin      t
              ?pinLabel t
              ?pinLabelHeight 0.3 
              ?pinLabelOrient "R90" 
              ?pinLabelLayer  list( rules->met1->layer "label")
              ?pinLabelFont   "stick"
            )
          else
            rodCreateRect(
              ?cvId   cv
              ?name   "plusPin"
              ?layer  list( rules->li1->pinlayer rules->li1->pinpurpose )
              ?bBox   list( rodGetObj( "botHeadLi11" cv )->lowerLeft rodGetObj( "botHeadLi11" cv )->upperRight )
              ?netName  "PLUS"
              ?termName "PLUS"
              ?termIOType "inputOutput"
              ?pin      t
              ?pinLabel t
              ?pinLabelHeight 0.3 
              ?pinLabelOrient "R90" 
              ?pinLabelLayer  list( rules->li1->layer "label")
              ?pinLabelFont   "stick"
            )
            rodCreateRect(
              ?cvId   cv
              ?name   "minusPin"
              ?layer  list( rules->li1->pinlayer rules->li1->pinpurpose )
              ?bBox   if( oddp(segments) then
                        list( rodGetObj( sprintf( nil "topHeadLi1%d" segments) cv )->lowerLeft
                          rodGetObj( sprintf( nil "topHeadLi1%d" segments) cv )->upperRight )
                      else
                        list( rodGetObj( sprintf( nil "botHeadLi1%d" segments) cv )->lowerLeft
                          rodGetObj( sprintf( nil "botHeadLi1%d" segments) cv )->upperRight )
                      )
              ?netName  "MINUS"
              ?termName "MINUS"
              ?termIOType "inputOutput"
              ?pin      t
              ?pinLabel t
              ?pinLabelHeight 0.3 
              ?pinLabelOrient "R90" 
              ?pinLabelLayer  list( rules->li1->layer "label")
              ?pinLabelFont   "stick"
            )
          ); if metCont
        ); end if rType = "Parallel"
      
        ; get the edges of the pres
        allPresShapes = setof( shape cv->shapes shape->lpp == devInfo->resLay )
        presTopEdge = topEdge( car(allPresShapes)->bBox )
        presLftEdge = leftEdge( car(allPresShapes)->bBox )
        presBotEdge = bottomEdge( car(allPresShapes)->bBox )
        presRhtEdge = rightEdge( car(allPresShapes)->bBox )
        foreach( presShape allPresShapes
          presTopEdge = max(presTopEdge topEdge( presShape->bBox ))
          presLftEdge = min(presLftEdge leftEdge( presShape->bBox ))
          presBotEdge = min(presBotEdge bottomEdge( presShape->bBox ))
          presRhtEdge = max(presRhtEdge rightEdge( presShape->bBox ))
        ); foreach presShape

        resTotalW = presRhtEdge - presLftEdge
        resTotalL = presTopEdge - presBotEdge

        when( devInfo->imp1Lay
          ; need to insure the implant is > min width of implant
          if( devInfo->imp1MinW > 2*devInfo->imp1OLres + resTotalW then
            imp1W = devInfo->imp1MinW
            imp1OLresW = 0.5*(devInfo->imp1MinW - resTotalW)
          else
            imp1W = 2*devInfo->imp1OLres + resTotalW
            imp1OLresW = devInfo->imp1OLres
          ); end if imp1MinW > resTotalW + 2* imp1OLres
          if( devInfo->imp1MinW > 2*devInfo->imp1OLres + resTotalL then
            imp1L = devInfo->imp1MinW
            imp1OLresL = 0.5*(devInfo->imp1MinW - resTotalL)
          else
            imp1L = 2*devInfo->imp1OLres + resTotalL
            imp1OLresL = devInfo->imp1OLres
          ); end if imp1MinW > resTotalW + 2* imp1OLres

          resImp1 = rodCreateRect(
            ?cvId     cv
            ?name     "resImp1"
            ?layer    devInfo->imp1Lay
            ?width    imp1W
            ?length   imp1L
          )
          rodAlign(
            ?alignObj     rodGetObj( "resImp1" cv )
            ?alignHandle  "lowerLeft"
            ?refObj       rodGetObj( "botHead1" cv )
            ?refHandle    "lowerLeft"
            ?xSep         -imp1OLresW
            ?ySep         -imp1OLresL
          )

          ; create body pin if no taps exist
          unless( tapTop || tapLeft || tapBottom || tapRight
            if( wellType == "Nwell" then
              rodCreateRect(
                ?cvId   cv
                ?name   "wellPin"
                ?layer  list( "nwell" "pin" )
                ?fromObj rodGetObj( "resImp1" cv )
                ?netName  "B"
                ?termName "B"
                ?termIOType "inputOutput"
                ?pin      t
                ?pinLabel t
                ?pinLabelHeight 0.3
                ?pinLabelLayer  list( "nwell" "label")
                ?pinLabelFont   "stick"
              )
            else
              rodCreateRect(
                ?cvId   cv
                ?name   "wellPin"
                ?layer  list( "pwell" "pin" )
                ?fromObj rodGetObj( "resImp1" cv )
                ?netName  "B"
                ?termName "B"
                ?termIOType "inputOutput"
                ?pin      t
                ?pinLabel t
                ?pinLabelHeight 0.3
                ?pinLabelLayer  list( "pwell" "label")
                ?pinLabelFont   "stick"
              )
            ); if nwell
          ); unless any taps

        ); end when defInfo->imp1Lay

        when( devInfo->imp2Lay
          ; need to insure the implant is > min width of implant
          if( devInfo->imp2MinW > 2*devInfo->imp2OLres + resTotalW then
            imp2W = devInfo->imp2MinW
            imp2OLresW = 0.5*(devInfo->imp2MinW - resTotalW)
          else
            imp2W = 2*devInfo->imp2OLres + resTotalW
            imp2OLresW = devInfo->imp2OLres
          ); end if imp2MinW > resTotalW + 2* imp2OLres
          if( devInfo->imp2MinW > 2*devInfo->imp2OLres + resTotalL then
            imp2L = devInfo->imp2MinW
            imp2OLresL = 0.5*(devInfo->imp2MinW - resTotalL)
          else
            imp2L = 2*devInfo->imp2OLres + resTotalL
            imp2OLresL = devInfo->imp2OLres
          ); end if imp2MinW > resTotalW + 2* imp2OLres

          resImp2 = rodCreateRect(
            ?cvId     cv
            ?name     "resImp2"
            ?layer    devInfo->imp2Lay
            ?width    imp2W
            ?length   imp2L
          )
          rodAlign(
            ?alignObj     rodGetObj( "resImp2" cv )
            ?alignHandle  "lowerLeft"
            ?refObj       rodGetObj( "botHead1" cv )
            ?refHandle    "lowerLeft"
            ?xSep         -imp2OLresW
            ?ySep         -imp2OLresL
          )
        ); end when defInfo->imp2Lay

        when( devInfo->imp3Lay
          ; need to insure the implant is > min width of implant
          if( devInfo->imp3MinW > 2*devInfo->imp3OLres + resTotalW then
            imp3W = devInfo->imp3MinW
            imp3OLresW = 0.5*(imp3W - resTotalW)
          else
            imp3W = 2*devInfo->imp3OLres + resTotalW
            imp3OLresW = devInfo->imp3OLres
          ); end if imp3MinW > resTotalW + 2* imp3OLres
          if( devInfo->imp3MinW > 2*devInfo->imp3OLres + resTotalL then
            imp3L = devInfo->imp3MinW
            imp3OLresL = 0.5*(imp3L - resTotalL)
          else
            imp3L = 2*devInfo->imp3OLres + resTotalL
            imp3OLresL = devInfo->imp3OLres
          ); end if imp3MinW > resTotalW + 2* imp3OLres

          resImp3 = rodCreateRect(
            ?cvId     cv
            ?name     "resImp3"
            ?layer    devInfo->imp3Lay
            ?width    imp3W
            ?length   imp3L
          )
          rodAlign(
            ?alignObj     rodGetObj( "resImp3" cv )
            ?alignHandle  "lowerLeft"
            ?refObj       rodGetObj( "botHead1" cv )
            ?refHandle    "lowerLeft"
            ?xSep         -imp3OLresW
            ?ySep         -imp3OLresL
          )
        ); end when defInfo->imp3Lay

        ; Merge all the parts so it removes geometry lines
        ;leMergeShapes( cv~>shapes ) ; can't use this in pcells - breaks steaming
        foreach( lpp cv~>lpps
          lppShapes = lpp~>shapes
          when( lppShapes && (car(lppShapes)->purpose == "drawing" || car(lppShapes)->purpose == "res" ||
                car(lppShapes)->layerName == "areaid" )
            dbLayerOr( cv car(lppShapes)->lpp lppShapes )
            foreach(shape lppShapes dbDeleteObject(shape))
          ); end when lppShapes
        ); end foreach lpp

        ; create the taps
        if( wellType == "Nwell" then
          tapImp = rules->nsdm->layer
          tapImpOLtap = rules->nsdm->minOLtap
          taptbSPres = max( rules->poly->rpolyMinSPtap
                          devInfo->imp1OLres + rules->nsdm->minSPdiff
                          devInfo->imp2OLres + rules->licon1->taplicon1SPnpc - rules->tap->minOLSisoTapLicon1
                          imp3OLresL + devInfo->tapImpSPImp3 + rules->nsdm->minOLtap
                        )
          taplrSPres = max( rules->poly->rpolyMinSPtap
                          devInfo->imp1OLres + rules->nsdm->minSPdiff
                          devInfo->imp2OLres + rules->licon1->taplicon1SPnpc - rules->tap->minOLSisoTapLicon1
                          imp3OLresW + devInfo->tapImpSPImp3 + rules->nsdm->minOLtap
                        )
        else
          tapImp = rules->psdm->layer
          tapImpOLtap = rules->psdm->minOLtap
          taptbSPres = max( rules->poly->rpolyMinSPtap
                          devInfo->imp2OLres + rules->licon1->taplicon1SPnpc - rules->tap->minOLSisoTapLicon1
                        )
          taplrSPres = taptbSPres
        ); end if Nwell

        ; figure out the gap between psdm/nsdm to later adjust the res imp psdm to butt them
        if( taptbSPres > devInfo->imp1OLres + tapImpOLtap then
          resImp1Adjtb = taptbSPres - (devInfo->imp1OLres + tapImpOLtap)
        else
          resImp1Adjtb = 0.0
        )
        if( taplrSPres > devInfo->imp1OLres + tapImpOLtap then
          resImp1Adjlr = taplrSPres - (devInfo->imp1OLres + tapImpOLtap)
        else
          resImp1Adjlr = 0.0
        )
        resImp1Shape = car( setof( shape cv~>shapes shape~>lpp == devInfo->imp1Lay ))
        when( tapTop
          resImp1Shape->bBox = list(
            leftEdge(resImp1Shape):bottomEdge(resImp1Shape) 
            rightEdge(resImp1Shape):topEdge(resImp1Shape)+resImp1Adjtb
          )
        ); end when tapTop
        when( tapRight
          resImp1Shape->bBox = list(
            leftEdge(resImp1Shape):bottomEdge(resImp1Shape) 
            rightEdge(resImp1Shape)+resImp1Adjlr:topEdge(resImp1Shape)
          )
        ); end when tapRight
        when( tapBottom
          resImp1Shape->bBox = list(
            leftEdge(resImp1Shape):bottomEdge(resImp1Shape)-resImp1Adjtb
            rightEdge(resImp1Shape):topEdge(resImp1Shape)
          )
        ); end when tapBottom
        when( tapLeft
          resImp1Shape->bBox = list(
            leftEdge(resImp1Shape)-resImp1Adjlr:bottomEdge(resImp1Shape)
            rightEdge(resImp1Shape):topEdge(resImp1Shape)
          )
        ); end when tapLeft

        ; best to go with max overlap contact so the corners will line up
        tapOLcont = max(rules->tap->minOLLisoTapLicon1 rules->tap->minOLSisoTapLicon1)
        tapMetOLcont = max(rules->li1->minOLLlicon1 rules->li1->minOLSlicon1)
        tapW = max(rules->tap->minW  2*tapOLcont+rules->licon1->minW )
        if( tapTop    then tapRhtAdjT = tapLftAdjT = taptbSPres + tapW else tapRhtAdjT = tapLftAdjT = 0.0 )
        if( tapLeft   then tapTopAdjL = tapBotAdjL = taplrSPres + tapW else tapTopAdjL = tapBotAdjL = 0.0 )
        if( tapBottom then tapRhtAdjB = tapLftAdjB = taptbSPres + tapW else tapRhtAdjB = tapLftAdjB = 0.0 )
        if( tapRight  then tapTopAdjR = tapBotAdjR = taplrSPres + tapW else tapTopAdjR = tapBotAdjR = 0.0 )

        ; make adjustments to top and bottom taps if their lengths are < tapW
        when( tapW > presRhtEdge - presLftEdge
          unless( tapLeft || tapRight
            tapTopAdjL = tapBotAdjL = tapTopAdjR = tapBotAdjR = 0.5*(tapW-(presRhtEdge - presLftEdge))
          )
        ); when

        tapTopL = (presRhtEdge - presLftEdge) + tapTopAdjL + tapTopAdjR
        tapLftL = (presTopEdge - presBotEdge) + tapLftAdjT + tapLftAdjB
        tapBotL = (presRhtEdge - presLftEdge) + tapBotAdjL + tapBotAdjR
        tapRhtL = (presTopEdge - presBotEdge) + tapRhtAdjT + tapRhtAdjB

        tapEncPath = list( list( ?layer tapImp ?enclosure -tapImpOLtap ) )
        tapSubRect = list( )
        tapEncPathWithCnt = list(
                              ?layer rules->li1->layer
                              ?enclosure -(tapMetOLcont - tapOLcont)
                            )
        tapSubRectWithCnt = list(
                              ?layer rules->licon1->layer
                              ?length rules->licon1->minW
                              ?width rules->licon1->minW
                              ?space rules->licon1->minSP
                              ?endOffset -tapOLcont
                              ?beginOffset -tapOLcont
                            )

        ; set well edges for later
        ; using tap OL for res OL since there is no rule and will work with taps added
        nwellTop = presTopEdge + rules->nwell->minOLtap
        nwellRht = presRhtEdge + rules->nwell->minOLtap
        nwellBot = presBotEdge - rules->nwell->minOLtap
        nwellLft = presLftEdge - rules->nwell->minOLtap
        when( tapW > presRhtEdge - presLftEdge
          unless( tapLeft || tapRight
            nwellRht = nwellRht + 0.5*(tapW-(presRhtEdge - presLftEdge))
            nwellLft = nwellLft - 0.5*(tapW-(presRhtEdge - presLftEdge))
          )
        ); when

        ; create top tap
        if( tapTop then
          if( tapTopCnt then
            tapTopEncPath = append1( tapEncPath tapEncPathWithCnt )
            tapTopSubRect = append1( tapSubRect tapSubRectWithCnt )
          else
            tapTopEncPath = tapEncPath
            tapTopSubRect = tapSubRect
          ); end when tapTopCnt
          tapTopPath = rodCreatePath(
            ?cvId cv
            ?name "tapTopPath"
            ?layer rules->tap->layer
            ?width tapW
            ?pts list(
              presLftEdge-tapTopAdjL : presTopEdge+taptbSPres+0.5*tapW
              presRhtEdge+tapTopAdjR : presTopEdge+taptbSPres+0.5*tapW
            )
            ?netName  "B"
            ?termName "B"
            ?termIOType "inputOutput"
            ?pin      t
            ?encSubPath tapTopEncPath
            ?subRect tapTopSubRect
          ); end rodCreatePath tapTopPath
          ; create pin
          when( tapTopCnt
            pinAdj = tapMetOLcont - tapOLcont
            rodCreateRect(
              ?cvId   cv
              ?name   "tapTopPin"
              ?layer  list( rules->li1->pinlayer rules->li1->pinpurpose )
              ?bBox   list( 
                        rodAddToY(rodAddToX(tapTopPath->lowerLeft -pinAdj) -pinAdj)
                        rodAddToY(rodAddToX(tapTopPath->upperRight pinAdj)  pinAdj)
                      )
              ?netName  "B"
              ?termName "B"
              ?termIOType "inputOutput"
              ?pin      t
              ?pinLabel t
              ?pinLabelHeight tapTopPath->length
              ?pinLabelLayer  list( rules->li1->layer "label")
              ?pinLabelFont   "stick"
            )
          )
          nwellTop = nwellTop + taptbSPres + tapW 
        ); end if tapTop

        ; create right tap
        if( tapRight then
          if( tapRightCnt then
            tapRhtEncPath = append1( tapEncPath tapEncPathWithCnt )
            tapRhtSubRect = append1( tapSubRect tapSubRectWithCnt )
          else
            tapRhtEncPath = tapEncPath
            tapRhtSubRect = tapSubRect
          ); end when tapRightCnt
          tapRhtPath = rodCreatePath(
            ?cvId cv
            ?name "tapRhtPath"
            ?layer rules->tap->layer
            ?width tapW
            ?pts list(
              presRhtEdge+taplrSPres+0.5*tapW : presBotEdge-tapRhtAdjB
              presRhtEdge+taplrSPres+0.5*tapW : presTopEdge+tapRhtAdjT
            )
            ?netName  "B"
            ?termName "B"
            ?termIOType "inputOutput"
            ?pin      t
            ?encSubPath tapRhtEncPath
            ?subRect tapRhtSubRect
          ); end rodCreatePath tapRhtPath
          when( tapRightCnt
            pinAdj = tapMetOLcont - tapOLcont
            rodCreateRect(
              ?cvId   cv
              ?name   "tapRhtPin"
              ?layer  list( rules->li1->pinlayer rules->li1->pinpurpose )
              ?bBox   list( 
                        rodAddToY(rodAddToX(tapRhtPath->lowerLeft -pinAdj) -pinAdj)
                        rodAddToY(rodAddToX(tapRhtPath->upperRight pinAdj)  pinAdj)
                      )
              ?netName  "B"
              ?termName "B"
              ?termIOType "inputOutput"
              ?pin      t
              ?pinLabel t
              ?pinLabelHeight tapRhtPath->width
              ?pinLabelLayer  list( rules->li1->layer "label")
              ?pinLabelFont   "stick"
            )
          )
          nwellRht = nwellRht + taplrSPres + tapW 
        ); end if tapRight

        ; create bottom tap
        if( tapBottom then
          if( tapBottomCnt then
            tapBotEncPath = append1( tapEncPath tapEncPathWithCnt )
            tapBotSubRect = append1( tapSubRect tapSubRectWithCnt )
          else
            tapBotEncPath = tapEncPath
            tapBotSubRect = tapSubRect
          ); end when tapBottomCnt
          tapBotPath = rodCreatePath(
            ?cvId cv
            ?name "tapBotPath"
            ?layer rules->tap->layer
            ?width tapW
            ?pts list(
              presLftEdge-tapBotAdjL : presBotEdge-taptbSPres-0.5*tapW
              presRhtEdge+tapBotAdjR : presBotEdge-taptbSPres-0.5*tapW
            )
            ?netName  "B"
            ?termName "B"
            ?termIOType "inputOutput"
            ?pin      t
            ?encSubPath tapBotEncPath
            ?subRect tapBotSubRect
          ); end rodCreatePath tapBotPath
          when( tapBottomCnt
            pinAdj = tapMetOLcont - tapOLcont
            rodCreateRect(
              ?cvId   cv
              ?name   "tapBotPin"
              ?layer  list( rules->li1->pinlayer rules->li1->pinpurpose )
              ?bBox   list( 
                        rodAddToY(rodAddToX(tapBotPath->lowerLeft -pinAdj) -pinAdj)
                        rodAddToY(rodAddToX(tapBotPath->upperRight pinAdj)  pinAdj)
                      )
              ?netName  "B"
              ?termName "B"
              ?termIOType "inputOutput"
              ?pin      t
              ?pinLabel t
              ?pinLabelHeight tapBotPath->length
              ?pinLabelLayer  list( rules->li1->layer "label")
              ?pinLabelFont   "stick"
            )
          )
          nwellBot = nwellBot - taptbSPres - tapW 
        ); end if tapBottom

        ; create left tap
        if( tapLeft then
          if( tapLeftCnt then
            tapLftEncPath = append1( tapEncPath tapEncPathWithCnt )
            tapLftSubRect = append1( tapSubRect tapSubRectWithCnt )
          else
            tapLftEncPath = tapEncPath
            tapLftSubRect = tapSubRect
          ); end when tapLeftCnt
          tapLftPath = rodCreatePath(
            ?cvId cv
            ?name "tapLftPath"
            ?layer rules->tap->layer
            ?width tapW
            ?pts list(
              presLftEdge-taplrSPres-0.5*tapW : presBotEdge-tapLftAdjB
              presLftEdge-taplrSPres-0.5*tapW : presTopEdge+tapLftAdjT
            )
            ?netName  "B"
            ?termName "B"
            ?termIOType "inputOutput"
            ?pin      t
            ?encSubPath tapLftEncPath
            ?subRect tapLftSubRect
          ); end rodCreatePath tapLftPath
          when( tapLeftCnt
            pinAdj = tapMetOLcont - tapOLcont
            rodCreateRect(
              ?cvId   cv
              ?name   "tapLftPin"
              ?layer  list( rules->li1->pinlayer rules->li1->pinpurpose )
              ?bBox   list( 
                        rodAddToY(rodAddToX(tapLftPath->lowerLeft -pinAdj) -pinAdj)
                        rodAddToY(rodAddToX(tapLftPath->upperRight pinAdj)  pinAdj)
                      )
              ?netName  "B"
              ?termName "B"
              ?termIOType "inputOutput"
              ?pin      t
              ?pinLabel t
              ?pinLabelHeight tapLftPath->width
              ?pinLabelLayer  list( rules->li1->layer "label")
              ?pinLabelFont   "stick"
            )
          )
          nwellLft = nwellLft - taplrSPres - tapW 
        ); end if tapLeft

        ; create the nwell and hv imp if needed
        when( wellType == "Nwell"

          case( vType
            ( "1.8V"
              nwell = rodCreateRect(
                ?cvId     cv
                ?name     "nwell"
                ?layer    rules->nwell->layer
                ?bBox     list( nwellLft:nwellBot nwellRht:nwellTop )
              )
            )
            ( "5V"
              nwellTop = nwellTop - rules->nwell->minOLtap + rules->nwell->minOLhvtap
              nwellRht = nwellRht - rules->nwell->minOLtap + rules->nwell->minOLhvtap
              nwellBot = nwellBot + rules->nwell->minOLtap - rules->nwell->minOLhvtap
              nwellLft = nwellLft + rules->nwell->minOLtap - rules->nwell->minOLhvtap

              nwell = rodCreateRect(
                ?cvId     cv
                ?name     "nwell"
                ?layer    rules->nwell->layer
                ?bBox     list( nwellLft:nwellBot nwellRht:nwellTop )
              )

              temp = rules->hvi->minOLtap - rules->nwell->minOLhvtap
              if( plusp(temp) then
                hviBbox = list( nwellLft-temp:nwellBot-temp nwellRht+temp:nwellTop+temp ) 
              else
                hviBbox = list( nwellLft:nwellBot nwellRht:nwellTop )
              )
              rodCreateRect(
                ?cvId     cv
                ?name     "thkox"
                ?layer    rules->thkox->layer
                ?bBox     hviBbox
              )
              hvi = rodCreateRect(
                ?cvId     cv
                ?name     "hvi"
                ?layer    rules->hvi->layer
                ?bBox     hviBbox
              )
            )
            ( "12V"
              nwellTop = nwellTop - rules->nwell->minOLtap + rules->nwell->minOLhvtap
              nwellRht = nwellRht - rules->nwell->minOLtap + rules->nwell->minOLhvtap
              nwellBot = nwellBot + rules->nwell->minOLtap - rules->nwell->minOLhvtap
              nwellLft = nwellLft + rules->nwell->minOLtap - rules->nwell->minOLhvtap

              nwell = rodCreateRect(
                ?cvId     cv
                ?name     "nwell"
                ?layer    rules->nwell->layer
                ?bBox     list( nwellLft:nwellBot nwellRht:nwellTop )
              )

              temp = rules->vhvi->minOLtap - rules->nwell->minOLhvtap
              if( plusp(temp) then
                vhviBbox = list( nwellLft-temp:nwellBot-temp nwellRht+temp:nwellTop+temp ) 
              else
                vhviBbox = list( nwellLft:nwellBot nwellRht:nwellTop )
              )
              rodCreateRect(
                ?cvId     cv
                ?name     "thkox"
                ?layer    rules->thkox->layer
                ?bBox     vhviBbox
              )
              vhvi = rodCreateRect(
                ?cvId     cv
                ?name     "vhvi"
                ?layer    rules->vhvi->layer
                ?bBox     vhviBbox
              )
            )
            ( "20V"
              nwellTop = nwellTop - rules->nwell->minOLtap + rules->nwell->minOLhvtap
              nwellRht = nwellRht - rules->nwell->minOLtap + rules->nwell->minOLhvtap
              nwellBot = nwellBot + rules->nwell->minOLtap - rules->nwell->minOLhvtap
              nwellLft = nwellLft + rules->nwell->minOLtap - rules->nwell->minOLhvtap

              nwell = rodCreateRect(
                ?cvId     cv
                ?name     "nwell"
                ?layer    rules->nwell->layer
                ?bBox     list( nwellLft:nwellBot nwellRht:nwellTop )
              )

              temp = rules->uhvi->minOLtap - rules->nwell->minOLhvtap
              if( plusp(temp) then
                uhviBbox = list( nwellLft-temp:nwellBot-temp nwellRht+temp:nwellTop+temp ) 
              else
                uhviBbox = list( nwellLft:nwellBot nwellRht:nwellTop )
              )
              rodCreateRect(
                ?cvId     cv
                ?name     "thkox"
                ?layer    rules->thkox->layer
                ?bBox     uhviBbox
              )
              uhvi = rodCreateRect(
                ?cvId     cv
                ?name     "uhvi"
                ?layer    rules->uhvi->layer
                ?bBox     uhviBbox
              )
            )
          ); end case vType
        ); end when nwell

        ); let
      ); end pcDefinePCell

    ;===========================================================
    ;***** Define Symbol Pcell *****
    ;===========================================================

    foreach( view list("symbol" "auCdl" "auLvs" "spectre")
      pcDefinePCell( list( ddGetObj(libName) device->deviceName view "schematicSymbol" "w")
        ; formal parameters name value pairs
        (
          ( rType         "string"  "Series" )
          ( res           "string"  sprintf(nil "%.3f" device->defRes )) 
          ( segW          "string"  sprintf(nil "%.3f" device->defW ))
          ( segL          "string"  sprintf(nil "%.3f" device->defL ))
          ( segments      "int"     1 )
          ( wellType      "string"  "Pwell" ) ;; values are "Pwell" or "Nwell"
          ( vType         "string"  "1.8V") ;; values are "1.8V", "5V", "12V", "20V"
        )
        let( (cv cellLabel instLabel labelR labelW labelL labelT labelB
            netm netp netb plus minus bias termP termM termB  paramLabel )

        cv = pcCellView

        dbReplaceProp(cv "instNamePrefix" "string" "RP")

        ; bounding box and main labels
        ;-----------------------------
        dbCreateRect(cv list("instance" "drawing") list(-0.0625:-0.375 0.125:0.0))

        cellLabel = dbCreateLabel( cv list("text" "drawing") -0.0625:0.015625 "[@cellName]"
          "centerRight" "R0" "stick" 0.03125 )
        cellLabel~>labelType = "NLPLabel"

        instLabel = dbCreateLabel( cv list("annotate" "drawing7") -0.0625:-0.046875 "[@instanceName]"
          "centerRight" "R0" "stick" 0.0625 )
        instLabel~>labelType = "NLPLabel"

        labelR = dbCreateLabel( cv list("annotate" "drawing") -0.0625:-0.140625 "[@res]"
          "centerRight" "R0" "stick" 0.0625 )
        labelR~>labelType = "NLPLabel"

        if( rType == "Parallel" then
          labelW = dbCreateLabel(cv list("annotate" "drawing") -0.0625:-0.234375
            if( segments > 1 then "[@segments:W=%*][@segW:%]" else "[@segW:W=%]")
            "lowerRight" "R0" "stick" 0.03125)
          labelL = dbCreateLabel(cv list("annotate" "drawing") -0.0625:-0.296875
            "[@segL:L=%]" "lowerRight" "R0" "stick" 0.03125)
        else
          labelW = dbCreateLabel(cv list("annotate" "drawing") -0.0625:-0.234375
            "[@segW:W=%]" "lowerRight" "R0" "stick" 0.03125)
          labelL = dbCreateLabel(cv list("annotate" "drawing") -0.0625:-0.296875
            if( segments > 1 then "[@segments:L=%*][@segL:%]" else "[@segL:L=%]")
            "lowerRight" "R0" "stick" 0.03125)
        ); if rType Parallel
        labelW->labelType = "NLPLabel"
        labelL->labelType = "NLPLabel"
        labelT = dbCreateLabel(cv list("annotate" "drawing") -0.0625:-0.359375
          "[@rType:%]" "lowerRight" "R0" "stick" 0.03125)
        labelT->labelType = "NLPLabel"

        ; create nets and pins
        ;-----------------------------
        netp = dbMakeNet(cv "PLUS")
        dbCreateTerm(netp "PLUS"  "inputOutput")
        plus = dbCreateRect(cv list("pin" "drawing")
          list(-0.01875:-0.01875 0.01875:0.01875) )
        dbCreatePin(netp plus)
        termP = dbCreateLabel( cv list("annotate" "drawing8") 0.0125:0 "cdsTerm(\"PLUS\")"
          "upperLeft" "R90" "stick" 0.01875 )
        termP~>labelType = "ILLabel"
        termP->parent = plus

        netm = dbMakeNet(cv "MINUS")
        dbCreateTerm(netm "MINUS" "inputOutput")
        minus = dbCreateRect(cv list("pin" "drawing")
          list(-0.01875:-0.01875 0.01875:0.01875) )
        dbMoveShape(minus cv list(0:-0.375 "R0"))
        dbCreatePin(netm minus)
        termM = dbCreateLabel( cv list("annotate" "drawing8") 0.0125:-0.375 "cdsTerm(\"MINUS\")"
          "upperRight" "R90" "stick" 0.01875 )
        termM~>labelType = "ILLabel"
        termM->parent = minus

        netb = dbMakeNet(cv "B")
        dbCreateTerm(netb "B" "inputOutput")
        ;bias = dbCreateRect(cv list("pin" "drawing")
        ;  list(-0.01875:-0.01875 0.01875:0.01875) )
        if( wellType == "Pwell" then
          bias = dbCreatePolygon(cv list("pin" "drawing")
            list(0.01875:0.01875 -0.01875:0.0 0.01875:-0.01875) )
        else
          bias = dbCreatePolygon(cv list("pin" "drawing")
            list(-0.01875:-0.01875 0.01875:0.0 -0.01875:0.01875) )
        )
        dbMoveShape(bias cv list(0.125:-0.1875 "R0"))
        dbCreatePin(netb bias)
        termB = dbCreateLabel( cv list("annotate" "drawing8") 0.125:-0.203125 "cdsTerm(\"B\")"
          "upperLeft" "R0" "stick" 0.01875 )
        termB~>labelType = "ILLabel"
        termB->parent = bias

        paramLabel = dbCreateLabel( cv list("annotate" "drawing") 0.140625:-0.250 "cdsParam(1)"
          "upperRight" "R90" "stick" 0.03125 )
        paramLabel~>labelType = "ILLabel"
        paramLabel = dbCreateLabel( cv list("annotate" "drawing") 0.140625:-0.125 "cdsParam(2)"
          "upperLeft" "R90" "stick" 0.03125 )
        paramLabel~>labelType = "ILLabel"
        paramLabel = dbCreateLabel( cv list("annotate" "drawing") 0.203125:-0.250 "cdsParam(3)"
          "upperRight" "R90" "stick" 0.03125 )
        paramLabel~>labelType = "ILLabel"
        paramLabel = dbCreateLabel( cv list("annotate" "drawing") 0.203125:-0.125 "cdsParam(4)"
          "upperLeft" "R90" "stick" 0.03125 )
        paramLabel~>labelType = "ILLabel"

        ; main resistor drawing
        ;-----------------------------
        dbCreateLine(cv list("device" "drawing") list(0.0:-0.375 0.0:-0.3 -0.0625:-0.28125 
          0.0625:-0.24375 -0.0625:-0.20625 0.0625:-0.16875 -0.0625:-0.13125 0.0625:-0.09375 
          0.0:-0.075 0.0:0.0 ) )
        dbCreateLabel( cv list("device" "drawing") 0.06875:-0.06875
          case( cv->cellName ("rpoly_hp" "H" ) ("rpoly_hp2K" "VH" ))
          "lowerCenter" "R0" "stick" 0.03125 )
        ; bias label
        if( wellType == "Pwell" then
          labelB = dbCreateLabel(cv list("annotate" "drawing8") 0.0953125:-0.1875
            "PW" "lowerCenter" "R90" "stick" 0.01875)
        else
          labelB = dbCreateLabel(cv list("annotate" "drawing8") 0.0953125:-0.1875
            "[@vType:NW %]" "lowerCenter" "R90" "stick" 0.01875)
          labelB->labelType = "NLPLabel"
        ); if wellType

        ); let
      ); pcDefinePCell symbols
    ); foreach view

    ;===========================================================
    ;***** CDF definition *****
    ;===========================================================

    let( (cellName cellId cdf tfId)

      cellName = device->deviceName

      unless( cellId = ddGetObj( libName cellName )
        error( "Could not get cell object Lib: %s, Cell:%s" libName cellName )
      ); unless

      when( cdf = cdfGetBaseCellCDF( cellId )
        cdfDeleteCDF( cdf )
      ); when
      cdf = cdfCreateBaseCellCDF( cellId )

      tfId = techGetTechFile(cellId)

      cdfCreateParam( cdf
        ?name           "model"
        ?prompt         "Model Name"
        ?type           "string"
        ?defValue       sprintf( nil "%s" device->modelName ) 
        ?storeDefault   "yes"
        ?parseAsCEL     "yes"
        ?editable       "nil"
        ?display        "hiGetCurrentWindow()~>cellView~>cellViewType != \"maskLayout\""
      )
      cdfCreateParam( cdf
        ?name           "lvsModel"
        ?prompt         "LVS Model Name"
        ?type           "string"
        ?defValue       sprintf( nil "%s_pw" device->modelName ) 
        ?storeDefault   "yes"
        ?parseAsCEL     "yes"
        ?editable       "nil"
        ?display        "hiGetCurrentWindow()~>cellView~>cellViewType == \"maskLayout\""
      )
      cdfCreateParam( cdf
        ?name           "rType"
        ?prompt         "Type"
        ?type           "cyclic"
        ?defValue       "Series"
        ?storeDefault   "yes"
        ?choices        list("Series" "Parallel" "Serpentine")
        ?callback       sprintf( nil "%s('rType)" device->paramCB )
      )
      cdfCreateParam( cdf
        ?name           "rCalcMethod"
        ?prompt         "Calculate By"
        ?type           "cyclic"
        ?defValue       "Total Resistance"
        ?storeDefault   "yes"
        ?choices        list("Total Resistance" "Segment Length")
      )
      cdfCreateParam( cdf
        ?name           "res"
        ?prompt         "Total Resistance"
        ?type           "string"
        ?defValue       sprintf( nil "%.3f" device->defRes ) 
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?parseAsNumber  "yes"
        ?units          "resistance"
        ?editable       "cdfgData->rCalcMethod->value == \"Total Resistance\""
        ?callback       sprintf( nil "%s('res)" device->paramCB )
      )
      cdfCreateParam( cdf
        ?name           "segL"
        ?prompt         "Segment Length"
        ?type           "string"
        ?defValue       sprintf( nil "%.3f" device->defL ) 
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?parseAsNumber  "yes"
        ?editable       "cdfgData->rCalcMethod->value == \"Segment Length\""
        ?callback       sprintf( nil "%s('segL)" device->paramCB )
      )
      cdfCreateParam( cdf
        ?name           "segW"
        ?prompt         "Width"
        ?type           "string"
        ?defValue       sprintf( nil "%.3f" device->defW ) 
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?parseAsNumber  "yes"
        ?callback       sprintf( nil "%s('segW)" device->paramCB )
      )
      cdfCreateParam( cdf
        ?name           "segments"
        ?prompt         "Segments"
        ?type           "int"
        ?defValue       1
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?callback       sprintf( nil "%s('segments)" device->paramCB )
      )
      cdfCreateParam( cdf
        ?name           "segmentSP"
        ?prompt         "Segment Spacing"
        ?type           "string"
        ?defValue       sprintf( nil "%.3f" device->defSegSP ) 
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?parseAsNumber  "yes"
        ?callback       sprintf( nil "%s('segmentSP)" device->paramCB )
        ?editable       "cdfgData->rType->value != \"Serpentine\"" 
        ?display        "cdfgData->segments->value > 1"
      )
      cdfCreateParam( cdf
        ?name           "contRows"
        ?prompt         "Contact Rows"
        ?type           "int"
        ?defValue       1
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?callback       sprintf( nil "%s('contRows)" device->paramCB )
      )
      cdfCreateParam( cdf
        ?name           "metCont"
        ?prompt         "Metal1 Connections"
        ?defValue       t 
        ?storeDefault   "yes"
        ?type           "boolean"
        ?display        "hiGetCurrentWindow()~>cellView~>cellViewType == \"maskLayout\""
      )
      cdfCreateParam( cdf
        ?name           "wellType"
        ?prompt         "Well Type"
        ?type           "cyclic"
        ?defValue       "Pwell"
        ?storeDefault   "yes"
        ?choices        list("Pwell" "Nwell")
        ?callback       "{if( cdfgData->wellType->value == \"Pwell\" then
                          cdfgData->lvsModel->value = strcat(cdfgData->model->value \"_pw\")
                        else
                          cdfgData->lvsModel->value = strcat(cdfgData->model->value \"_nw\")
                        )}"
      )
      cdfCreateParam( cdf
        ?name           "vType"
        ?prompt         "Well Voltage Rating"
        ?type           "cyclic"
        ?defValue       "1.8V"
        ?storeDefault   "yes"
        ?choices        list("1.8V" "5V" "12V" "20V")
        ?display        "cdfgData->wellType->value == \"Nwell\""
      )
      cdfCreateParam( cdf
        ?name           "tapLeft"
        ?prompt         "Left Tap"
        ?defValue       t 
        ?storeDefault   "yes"
        ?type           "boolean"
        ?display        "hiGetCurrentWindow()~>cellView~>cellViewType == \"maskLayout\""
      )
      cdfCreateParam( cdf
        ?name           "tapLeftCnt"
        ?prompt         "   Left Tap Contacts"
        ?defValue       t 
        ?storeDefault   "yes"
        ?type           "boolean"
        ?display        "cdfgData->tapLeft->value && hiGetCurrentWindow()~>cellView~>cellViewType == \"maskLayout\""
      )
      cdfCreateParam( cdf
        ?name           "tapRight"
        ?prompt         "Right Tap"
        ?defValue       nil 
        ?storeDefault   "yes"
        ?type           "boolean"
        ?display        "hiGetCurrentWindow()~>cellView~>cellViewType == \"maskLayout\""
      )
      cdfCreateParam( cdf
        ?name           "tapRightCnt"
        ?prompt         "   Right Tap Contacts"
        ?defValue       t 
        ?storeDefault   "yes"
        ?type           "boolean"
        ?display        "cdfgData->tapRight->value && hiGetCurrentWindow()~>cellView~>cellViewType == \"maskLayout\""
      )
      cdfCreateParam( cdf
        ?name           "tapTop"
        ?prompt         "Top Tap"
        ?defValue       nil 
        ?storeDefault   "yes"
        ?type           "boolean"
        ?display        "hiGetCurrentWindow()~>cellView~>cellViewType == \"maskLayout\""
      )
      cdfCreateParam( cdf
        ?name           "tapTopCnt"
        ?prompt         "   Top Tap Contacts"
        ?defValue       t 
        ?storeDefault   "yes"
        ?type           "boolean"
        ?display        "cdfgData->tapTop->value && hiGetCurrentWindow()~>cellView~>cellViewType == \"maskLayout\""
      )
      cdfCreateParam( cdf
        ?name           "tapBottom"
        ?prompt         "Bottom Tap"
        ?defValue       nil 
        ?storeDefault   "yes"
        ?type           "boolean"
        ?display        "hiGetCurrentWindow()~>cellView~>cellViewType == \"maskLayout\""
      )
      cdfCreateParam( cdf
        ?name           "tapBottomCnt"
        ?prompt         "   Bottom Tap Contacts"
        ?defValue       t 
        ?storeDefault   "yes"
        ?type           "boolean"
        ?display        "cdfgData->tapBottom->value && hiGetCurrentWindow()~>cellView~>cellViewType == \"maskLayout\""
      )
      cdfCreateParam( cdf
        ?name           "segRes"
        ?prompt         "Segment Resistance"
        ?type           "string"
        ?defValue       sprintf( nil "%.5f" device->defSegRes ) 
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?parseAsNumber  "yes"
        ?editable       "nil"
        ?display        "cdfgData->rType->value != \"Serpentine\" && hiGetCurrentWindow()~>cellView~>cellViewType != \"maskLayout\"" 
      )
      cdfCreateParam( cdf
        ?name           "serpL"
        ?prompt         "Serpentine Length"
        ?type           "string"
        ?defValue       sprintf( nil "%.3f" device->defL ) 
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?parseAsNumber  "yes"
        ?editable       "nil"
        ?callback       sprintf( nil "%s()" device->paramCB )
        ?display        "cdfgData->rType->value == \"Serpentine\" && hiGetCurrentWindow()~>cellView~>cellViewType != \"maskLayout\"" 
      )
      cdfCreateParam( cdf
        ?name           "headRes"
        ?prompt         "Head Resistance"
        ?type           "string"
        ?defValue       sprintf( nil "%.5f" device->defHeadRes ) 
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?parseAsNumber  "yes"
        ?editable       "nil"
        ?display        "hiGetCurrentWindow()~>cellView~>cellViewType != \"maskLayout\""
      )
      cdfCreateParam( cdf
        ?name           "sheetRho"
        ?prompt         "Sheet Rho"
        ?type           "string"
        ?defValue       sprintf( nil "%.3f" device->sheetRho ) 
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?parseAsNumber  "yes"
        ?editable       "nil"
        ?display        "hiGetCurrentWindow()~>cellView~>cellViewType != \"maskLayout\""
      )
      ; params for auCdl & auLvs netlisting
      cdfCreateParam( cdf
        ?name           "l"
        ?prompt         "netlist length"
        ?type           "string"
        ?defValue       sprintf( nil "%.3f" device->defL ) 
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?parseAsNumber  "yes"
        ?display        "nil"
      )
      cdfCreateParam( cdf
        ?name           "w"
        ?prompt         "netlist width"
        ?type           "string"
        ?defValue       sprintf( nil "%.3f" device->defW ) 
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?parseAsNumber  "yes"
        ?display        "nil"
      )
      cdfCreateParam( cdf
        ?name           "m"
        ?prompt         "netlist m"
        ?type           "int"
        ?defValue       1
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?display        "nil"
      )
      cdfCreateParam( cdf
        ?name           "r"
        ?prompt         "netlist r"
        ?type           "string"
        ?defValue       sprintf( nil "%.3f" device->defRes ) 
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?parseAsNumber  "yes"
        ?units          "resistance"
        ?display        "nil"
      )

      cdf->simInfo = list( nil)

      cdf->simInfo->auCdl = '( nil
        dollarEqualParams nil
        dollarParams      nil
        otherParameters   nil
        netlistProcedure  S130hrpolyCdlNLProc
        instParameters    (model w l m segments rType nf )
        propMapping       (nil model lvsModel )
        componentName     sprintf( nil "%s" device->deviceName )
        termOrder         (PLUS MINUS B)
        namePrefix        "R"
        modelName         lvsModel
      )
      cdf->simInfo->auLvs = '( nil
        permuteRule       "(p PLUS MINUS)"
      )
      cdf->simInfo->spectre = '( nil
        netlistProcedure    S130hrpolySpectreNLProc
        namePrefix          "R"
        modelParamExprList  nil
        optParamExprList    nil
        opParamExprList     nil
        stringParameters    nil
        propMapping         nil
        componentName       nil
        instParameters      nil
        otherParameters     nil
        termOrder           nil
        termMapping         nil
      )
      cdf->simInfo->spectreS = '( nil
        netlistProcedure    S130hrpolySpectreNLProc
        namePrefix          "R"
        modelParamExprList  nil
        optParamExprList    nil
        opParamExprList     nil
        stringParameters    nil
        propMapping         nil
        componentName       nil
        instParameters      nil
        otherParameters     nil
        termOrder           nil
        termMapping         nil
      )

      cdf->formInitProc            = "S130disablePcellChange"
      cdf->paramLabelSet           = ""
      cdf->opPointLabelSet         = "v i pwr"
      cdf->paramEvaluate           = "t nil nil nil nil"
      cdf->paramDisplayMode        = "parameter"
      cdf->instDisplayMode         = "instName"
      cdf->instNameType            = "schematic"

      cdfSaveCDF( cdf)

    ); let
  ); foreach device

); let

/*==================================  EOF  ===================================*/
