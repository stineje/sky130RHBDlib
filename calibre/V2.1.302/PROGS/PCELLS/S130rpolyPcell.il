/*==============================================================================
  File:         S130rpolyPcell.il
  Purpose:      Pcell code for layout and symbols, and cdf setup for the rpoly
                resistor for Skywater S130 Pcells

  Created:      Mar 25, 2020  Madek Graham
  Description:  Pcell code to create the basic layer resistors
  
  Devices/views:  rpoly      / layout symbol auCdl auLvs spectre

------------------------------------------------------------
  Modifications:

==============================================================================*/

/*==============================================================================

  This file only needs to be loaded once to create the pcells and cdf information
  for the resBaseDevices set within the S130techData.il file

==============================================================================*/

let( ( libName )

  libName = "S130"

  foreach( device rpolyDevices
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
        ( rType         "string"  "Series" ) ;; values are "Series", "Parallel"
        ( segW          "float"   device->defW )
        ( segL          "float"   device->defL )
        ( segments      "int"     1 )
        ( segmentSP     "float"   device->defSegSP )
        ( contRows      "int"     1 )
        ( metCont       "boolean" t)
      )

      let( (
        allPresShapes botHead botHeadLi1 botHeadLicon1 botHeadMcon botHeadMet1 cv
        headL headLi1L headLi1W headLicon1Xadj headLicon1Yadj headLicon1sTotalL
        headLicon1sTotalW headMconXadj headMconYadj headMconsTotalL headMconsTotalW
        headMet1L headMet1W headW headXadj headYadj
        imp1L imp1OLresL imp1OLresW imp1W lppShapes minLi1L minLi1W minMet1L minMet1W
        numXHeadLicon1s numXHeadMcons numYHeadMcons nwell nwellBot nwellLft nwellRht
        nwellTop pinAdj presBotEdge presLftEdge presRhtEdge presTopEdge res resImp1
        resImp1Adj resImp1Shape resMark resMinContW resTotalL resTotalW tapAdj
        tapBotAdjL tapBotAdjR tapBotEncPath tapBotL tapBotPath tapBotSubRect
        tapEncPath tapEncPathWithCnt tapImp tapImpOLtap tapLftAdjB tapLftAdjT
        tapLftEncPath tapLftL tapLftPath tapLftSubRect tapMetOLcont tapOLcont
        tapRhtAdjB tapRhtAdjT tapRhtEncPath tapRhtL tapRhtPath tapRhtSubRect
        tapSPres tapSubRect tapSubRectWithCnt tapTopAdjL tapTopAdjR tapTopEncPath
        tapTopL tapTopPath tapTopSubRect tapW temp topHead topHeadLi1 topHeadLicon1
        topHeadMcon topHeadMet1
      )

        cv = pcCellView

        dbReplaceProp(cv "instNamePrefix" "string" "RNP")

        headL = rules->licon1->minW + devInfo->resLay->minOLSlicon1 +
          (contRows - 1)*(rules->licon1->minW + rules->licon1->minSP)

        ; create the segments
        for( segment 1 segments 
          res = rodCreateRect(
            ?cvId cv
            ?name sprintf( nil "res%d" segment )
            ?layer devInfo->resLay->layer
            ?width segW
            ?length segL
            ?origin (segment-1)*(segW + segmentSP) : 0
          )
          resMark = rodCreateRect(
            ?cvId cv
            ?layer devInfo->mrk1Lay
            ?bBox  list( res->lowerLeft res->upperRight )
          )
        ); end for 1 to segments

        ; create Headers
        resMinContW = rules->licon1->minW + 2*devInfo->resLay->minOLSlicon1

        ; figure out how many and how wide/long all the licon1s will be for fillRect later
        headXadj = 0.0
        headYadj = 0.0
        ; dogbone check and adjustments, & get headLicon numbers needed
        if( segW < resMinContW then
          headW = resMinContW
          ; needed to move the serpentine heads over
          ; parallel and series the segment spacing will be adjusted in the cdf
          headYadj = devInfo->resLay->minOLLlicon1
          headL = headL + headYadj
          numXHeadLicon1s = 1
          headLicon1sTotalW = rules->licon1->minW
          headLicon1sTotalL = rules->licon1->minW + (contRows - 1)*(rules->licon1->minW +
            rules->licon1->minSP)
        else
          headW = segW
          numXHeadLicon1s = 1 + floor((segW - 2*max(devInfo->resLay->minOLSlicon1 rules->li1->minOLSlicon1) - 
            rules->licon1->minW)/(rules->licon1->minW + rules->licon1->minSP))
          headLicon1sTotalW = rules->licon1->minW + (numXHeadLicon1s-1)*(rules->licon1->minW +
            rules->licon1->minSP)
          ; ensure the licon1 to licon1 on different segments don't cause a violation, if so, reduce the number of
          ; licon1s by 1
          when( segments > 1 &&
                segmentSP+(segW-headLicon1sTotalW) < rules->licon1->minSP &&
                numXHeadLicon1s > 1
            numXHeadLicon1s = numXHeadLicon1s - 1
            headLicon1sTotalW = rules->licon1->minW + (numXHeadLicon1s-1)*(rules->licon1->minW +
              rules->licon1->minSP)
          ); end when
          headLicon1sTotalL = rules->licon1->minW + (contRows-1)*(rules->licon1->minW +
            rules->licon1->minSP)
        ); end if segW < room for one contact

        ; need to make sure we have some minimums to check against
        minLi1W = 2*max(rules->li1->minOLSlicon1 rules->li1->minOLSmcon) + rules->licon1->minW
        minLi1L = 2*max(rules->li1->minOLLlicon1 rules->li1->minOLLmcon) + rules->licon1->minW
        minMet1W = 2*rules->met1->minOLSmcon + rules->licon1->minW
        minMet1L = 2*rules->met1->minOLLmcon + rules->licon1->minW

        ; li1 width and length
        headLi1W = max(minLi1W,2*max(rules->li1->minOLSlicon1,rules->li1->minOLSmcon) +
          headLicon1sTotalW)
        headLi1L = max(minLi1L,2*max(rules->li1->minOLLlicon1,rules->li1->minOLLmcon) +
          headLicon1sTotalL)
        headLi1W = round(headLi1W/(grid*2))*(grid*2)
        headLi1L = round(headLi1L/(grid*2))*(grid*2)
        headLicon1Xadj = 0.5*(headLi1W - headLicon1sTotalW)
        headLicon1Yadj = 0.5*(headLi1L - headLicon1sTotalL)

        ; figure out how many and how wide/long all the mcons will be for fillRect later
        if( numXHeadLicon1s == 1 then
          numXHeadMcons = 1
        else
          numXHeadMcons = 1 + floor( (headLi1W - 2*rules->li1->minOLSmcon - rules->mcon->minW)/
            (rules->mcon->minW + rules->mcon->minSP) )
        ); end if numXHeadLicon1s
        numYHeadMcons = 1 + floor( (headLi1L - 2*rules->li1->minOLLmcon - rules->mcon->minW)/
          (rules->mcon->minW + rules->mcon->minSP) )
        headMconsTotalW = rules->mcon->minW + (numXHeadMcons-1)*(rules->mcon->minW +
          rules->mcon->minSP)
        headMconsTotalL = rules->mcon->minW + (numYHeadMcons-1)*(rules->mcon->minW +
          rules->mcon->minSP)

        ; met1 width and length
        headMet1W = headMconsTotalW + 2*rules->met1->minOLSmcon
        headMet1L = headMconsTotalL + 2*rules->met1->minOLLmcon
        when( rules->met1->minArea > headMet1W * headMet1L
          headMet1W = ceiling( (rules->met1->minArea/headMet1L)/grid)*grid
        ); when
        ; set the metals to be on 2*grid to fix offgrid issues
        headMet1W = round(headMet1W/(grid*2))*(grid*2)
        headMet1L = round(headMet1L/(grid*2))*(grid*2)
        headMconXadj = 0.5*(headMet1W - headMconsTotalW)
        headMconYadj = 0.5*(headMet1L - headMconsTotalL)

        for( segment 1 segments

          ; bottom headers
          botHead = rodCreateRect(
            ?cvId   cv
            ?name   sprintf( nil "botHead%d" segment )
            ?layer  devInfo->resLay->layer
            ?width  headW
            ?length headL
          )
          rodAlign(
            ?alignObj     rodGetObj( sprintf( nil "botHead%d" segment ) cv )
            ?alignHandle  "upperCenter"
            ?refObj       rodGetObj( sprintf( nil "res%d" segment ) cv )
            ?refHandle    "lowerCenter"
            ?ySep         headYadj
          )
          ; top headers
          topHead = rodCreateRect(
            ?cvId   cv
            ?name   sprintf( nil "topHead%d" segment )
            ?layer  devInfo->resLay->layer
            ?width  headW
            ?length headL
          )
          rodAlign(
            ?alignObj     rodGetObj( sprintf( nil "topHead%d" segment ) cv )
            ?alignHandle  "lowerCenter"
            ?refObj       rodGetObj( sprintf( nil "res%d" segment ) cv )
            ?refHandle    "upperCenter"
            ?ySep         -headYadj
          )

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
            ?ySep         max(rules->li1->minOLLlicon1,rules->li1->minOLLmcon)-headYadj
          )
          botHeadLicon1 = rodFillBBoxWithRects(
            ?cvId         cv
            ?layer        rules->licon1->layer
            ?fillBBox     list(
                            rodAddToY(rodAddToX(botHeadLi1->lowerLeft headLicon1Xadj) headLicon1Yadj)
                            rodAddToY(rodAddToX(botHeadLi1->upperRight -headLicon1Xadj) -headLicon1Yadj)
                          )
            ?width        rules->licon1->minW
            ?length       rules->licon1->minW
            ?gap          "minimum"
            ?spaceX       rules->licon1->minSP
            ?spaceY       rules->licon1->minSP
          )
          when( devInfo->npcLay
            rodCreateRect(
              ?cvId     cv
              ?name     sprintf( nil "botHeadNpc%d" segment )
              ?layer    devInfo->npcLay->layer
              ?bBox list( rodAddToY(rodAddToX(botHeadLi1->lowerLeft headLicon1Xadj-devInfo->npcLay->minOLpcont)
                          headLicon1Yadj-devInfo->npcLay->minOLpcont)
                          rodAddToY(rodAddToX(botHeadLi1->upperRight -headLicon1Xadj+devInfo->npcLay->minOLpcont)
                          -headLicon1Yadj+devInfo->npcLay->minOLpcont)
                        )
            )
          ); when npc
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
            ?ySep         -max(rules->li1->minOLLlicon1,rules->li1->minOLLmcon)+headYadj
          )
          topHeadLicon1 = rodFillBBoxWithRects(
            ?cvId         cv
            ?layer        rules->licon1->layer
            ?fillBBox     list(
                            rodAddToY(rodAddToX(topHeadLi1->lowerLeft headLicon1Xadj) headLicon1Yadj)
                            rodAddToY(rodAddToX(topHeadLi1->upperRight -headLicon1Xadj) -headLicon1Yadj)
                          )
            ?width        rules->licon1->minW
            ?length       rules->licon1->minW
            ?gap          "minimum"
            ?spaceX       rules->licon1->minSP
            ?spaceY       rules->licon1->minSP
          )
          when( devInfo->npcLay
            rodCreateRect(
              ?cvId     cv
              ?name     sprintf( nil "topHeadNpc%d" segment )
              ?layer    devInfo->npcLay->layer
              ?bBox list( rodAddToY(rodAddToX(topHeadLi1->lowerLeft headLicon1Xadj-devInfo->npcLay->minOLpcont)
                          headLicon1Yadj-devInfo->npcLay->minOLpcont)
                          rodAddToY(rodAddToX(topHeadLi1->upperRight -headLicon1Xadj+devInfo->npcLay->minOLpcont)
                          -headLicon1Yadj+devInfo->npcLay->minOLpcont)
                        )
            )
          ); when npc
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
            ); case "Parallel"
          ); case rtype
        ); when segments > 1

        ; fill npc gaps 
        when( devInfo->npcLay
          when( segments > 1 && 
            devInfo->npcLay->minSP > abs(xCoord(rodGetObj("botHeadNpc2" cv)->lowerLeft) -
              xCoord(rodGetObj("botHeadNpc1" cv)->upperRight))
            rodCreateRect(
              ?cvId     cv
              ?name     "botHeadNpcGapFill"
              ?layer    devInfo->npcLay->layer
              ?bBox     list( rodGetObj("botHeadNpc1" cv)->lowerLeft
                          rodGetObj(sprintf( nil "botHeadNpc%d" segments ) cv)->upperRight )
            )
            rodAlign(
              ?alignObj     rodGetObj( "botHeadNpcGapFill" cv )
              ?alignHandle  "lowerLeft"
              ?refObj       rodGetObj( "botHeadNpc1" cv )
              ?refHandle    "lowerLeft"
            )
            rodCreateRect(
              ?cvId     cv
              ?name     "topHeadNpcGapFill"
              ?layer    devInfo->npcLay->layer
              ?bBox     list( rodGetObj("topHeadNpc1" cv)->lowerLeft
                          rodGetObj(sprintf( nil "topHeadNpc%d" segments ) cv)->upperRight )
            )
            rodAlign(
              ?alignObj     rodGetObj( "topHeadNpcGapFill" cv )
              ?alignHandle  "lowerLeft"
              ?refObj       rodGetObj( "topHeadNpc1" cv )
              ?refHandle    "lowerLeft"
            )
          ); when npc gaps < npc spacing
        ); when npc

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
              ?pinLabelHeight round( (rodGetObj( "connectMet1Bot1" cv )->length/length("MINUS")) /grid)*grid
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
              ?pinLabelHeight round( (rodGetObj( "connectMet1Top1" cv )->length/length("MINUS")) /grid)*grid
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
              ?pinLabelHeight round( (rodGetObj( "connectLi1Bot1" cv )->length/length("MINUS")) /grid)*grid
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
              ?pinLabelHeight round( (rodGetObj( "connectLi1Top1" cv )->length/length("MINUS")) /grid)*grid
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
              ?pinLabelHeight round( (rodGetObj( "botHeadMet11" cv )->length/length("PLUS")) /grid)*grid
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
              ?pinLabelHeight round( (rodGetObj( "botHeadMet11" cv )->length/length("MINUS")) /grid)*grid
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
              ?pinLabelHeight round( (rodGetObj( "botHeadLi11" cv )->length/length("PLUS")) /grid)*grid
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
              ?pinLabelHeight round( (rodGetObj( "botHeadLi11" cv )->length/length("MINUS")) /grid)*grid
              ?pinLabelLayer  list( rules->li1->layer "label")
              ?pinLabelFont   "stick"
            )
          ); if metCont
        ); end if rType = "Parallel"
      
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

      ); let
    ); end pcDefinePCell

    ;===========================================================
    ;***** Define Symbol Pcell *****
    ;===========================================================

    foreach( view list("symbol" "auCdl" "auLvs" "spectre")
      pcDefinePCell( list( ddGetObj(libName) device->deviceName view "schematicSymbol" "w")
        ; formal parameters name value pairs
        (
          ( devInfo       "ilList"  device )
          ( model         "string"  device->modelName )
          ( rType         "string"  "Series" )
          ( res           "string"  sprintf(nil "%.3f" device->defRes )) 
          ( segW          "float"   device->defW )
          ( segL          "float"   device->defL )
          ( segments      "int"     1 )
        )

        let( (cv modelLabel instLabel labelR labelW labelL labelT
            netm netp plus minus termP termM paramLabel )

        cv = pcCellView

        dbReplaceProp(cv "instNamePrefix" "string" "RNP")

        ; bounding box and main labels
        ;-----------------------------
        dbCreateRect(cv list("instance" "drawing") list(-0.0625:-0.375 0.125:0.0))

        modelLabel = dbCreateLabel( cv list("text" "drawing") 0.0625:-0.1875 "[@model]"
          "upperCenter" "R90" "stick" 0.03125 )
        modelLabel~>labelType = "NLPLabel"

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

        cv~>portOrder = list("PLUS" "MINUS")

        paramLabel = dbCreateLabel( cv list("annotate" "drawing") 0.0625:-0.03125 "cdsParam(1)"
          "lowerLeft" "R0" "stick" 0.03125 )
        paramLabel~>labelType = "ILLabel"
        paramLabel = dbCreateLabel( cv list("annotate" "drawing") 0.0625:-0.09375 "cdsParam(2)"
          "lowerLeft" "R0" "stick" 0.03125 )
        paramLabel~>labelType = "ILLabel"
        paramLabel = dbCreateLabel( cv list("annotate" "drawing") 0.0625:-0.28125 "cdsParam(3)"
          "lowerLeft" "R0" "stick" 0.03125 )
        paramLabel~>labelType = "ILLabel"
        paramLabel = dbCreateLabel( cv list("annotate" "drawing") 0.0625:-0.34375 "cdsParam(4)"
          "lowerLeft" "R0" "stick" 0.03125 )
        paramLabel~>labelType = "ILLabel"

        ; main resistor drawing
        ;-----------------------------
        dbCreateLine(cv list("device" "drawing") list(0.0:-0.375 0.0:-0.3 -0.0625:-0.28125 
          0.0625:-0.24375 -0.0625:-0.20625 0.0625:-0.16875 -0.0625:-0.13125 0.0625:-0.09375 
          0.0:-0.075 0.0:0.0 ) )

        ); let
      ); pcDefinePCell symbols
    ); foreach view

    ;===========================================================
    ;***** CDF definition *****
    ;===========================================================

    let( (cellname cellId cdf tfId defLvsModel)

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
        ?defValue       sprintf( nil "%s" device->lvsModel ) 
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
        ?choices        list("Series" "Parallel")
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
        ?type           "float"
        ?defValue       device->defL 
        ?storeDefault   "yes"
        ?editable       "cdfgData->rCalcMethod->value == \"Segment Length\""
        ?callback       sprintf( nil "%s('segL)" device->paramCB )
      )
      cdfCreateParam( cdf
        ?name           "segW"
        ?prompt         "Width"
        ?type           "float"
        ?defValue       device->defW 
        ?storeDefault   "yes"
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
        ?type           "float"
        ?defValue       device->defSegSP
        ?storeDefault   "yes"
        ?callback       sprintf( nil "%s('segmentSP)" device->paramCB )
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
      /*
      cdfCreateParam( cdf
        ?name           "wellType"
        ?prompt         "Well Type"
        ?type           "cyclic"
        ?defValue       defWellType
        ?storeDefault   "yes"
        ?choices        chWellType
        ?display        disWellType
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
      */
      cdfCreateParam( cdf
        ?name           "segRes"
        ?prompt         "Segment Resistance"
        ?type           "string"
        ?defValue       sprintf( nil "%.5f" device->defSegRes ) 
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?parseAsNumber  "yes"
        ?editable       "nil"
        ?display        "hiGetCurrentWindow()~>cellView~>cellViewType != \"maskLayout\"" 
      )
      cdfCreateParam( cdf
        ?name           "sheetRho"
        ?prompt         "Sheet Rho"
        ?type           "float"
        ?defValue       device->sheetRho 
        ?storeDefault   "yes"
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

      cdf->simInfo = list( nil)

      cdf->simInfo->auCdl = '( nil
        dollarEqualParams nil
        dollarParams      nil
        otherParameters   nil
        netlistProcedure  S130hrpolyCdlNLProc
        instParameters    (model w l m segments rType nf )
        propMapping       (nil model lvsModel )
        componentName     sprintf( nil "%s" device->deviceName )
        termOrder         (PLUS MINUS)
        namePrefix        "R"
        modelName         lvsModel
      )
      cdf->simInfo->auLvs = '( nil
        permuteRule       "(p PLUS MINUS)"
      )
      cdf->simInfo->spectre = '( nil
        netlistProcedure    S130rpolySpectreNLProc
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
        netlistProcedure    S130rpolySpectreNLProc
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
