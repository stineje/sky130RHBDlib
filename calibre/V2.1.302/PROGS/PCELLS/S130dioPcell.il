/*==============================================================================
  File:         S130dioPcell.il
  Purpose:      Pcell code for layout and/or symbols, and cdf setup for diodes
                for Skywater S130 Pcells

  Created:      Mar 14, 2020  Madek Graham
  Description:  Pcell code to create diode devices
  
  Devices/views:  ddnw_sub / symbol auCdl auLvs spectre
                  ddnw_sub_v5 / symbol auCdl auLvs spectre
                  ddnw_sub_v12 / symbol auCdl auLvs spectre
                  ddnw_sub_v20 / symbol auCdl auLvs spectre
                  dpw_dnw / symbol auCdl auLvs spectre
                  dpw_dnw_v5 / symbol auCdl auLvs spectre
                  dpw_dnw_v12 / symbol auCdl auLvs spectre
                  dpw_dnw_v20 / symbol auCdl auLvs spectre
                  dnsd_pw / symbol auCdl auLvs spectre layout
                  dnsd_pw_esd / symbol auCdl auLvs spectre layout
                  dnsd_pw_esd_v5 / symbol auCdl auLvs spectre layout
                  dnsd_pw_lvt / symbol auCdl auLvs spectre layout
                  dnsd_pw_nat / symbol auCdl auLvs spectre layout
                  dnsd_pw_v5 / symbol auCdl auLvs spectre layout
                  dpsd_nw / symbol auCdl auLvs spectre layout
                  dpsd_nw_esd / symbol auCdl auLvs spectre layout
                  dpsd_nw_esd_v5 / symbol auCdl auLvs spectre layout
                  dpsd_nw_hvt / symbol auCdl auLvs spectre layout
                  dpsd_nw_lvt / symbol auCdl auLvs spectre layout
                  dpsd_nw_v5 / symbol auCdl auLvs spectre layout


------------------------------------------------------------
  Modifications:
  - Jun 27, 2020 MSG
    Changed hvi layer to thkox to accomodate change in PDK
  - Sep 06, 2020 MSG
    Changed pin label heights so not HUGE
  - March 16, 2022 CBPL
	Changed pin label heights from 0.3 to 0.15 so they fit inside the cell boundary


==============================================================================*/

/*==============================================================================

  This file only needs to be loaded once to create the pcells and cdf information
  for the dioDevices set within the S130techData.il file

==============================================================================*/

let( ( libName )

  libName = "S130"

  foreach( device dioDevices

    printf("Creating device %s in %s library\n" device->deviceName libName )

    ;===========================================================
    ;***** Define Layout Pcell *****
    ;===========================================================
    when( device->layout

      pcDefinePCell( list( ddGetObj(libName) device->deviceName "layout" )
        ; formal parameters name value pairs
        (
          ( devInfo       "ilList"  device )
          ( rules         "ilList"  designRules )
          ( grid          "float"   techGetMfgGridResolution(techGetTechFile(ddGetObj(libName))) )
          ( w             "float"   device->defW )
          ( l             "float"   device->defL )
          ( dioCont       "boolean" t )
          ( tapTop        "boolean" nil)
          ( tapTopCnt     "boolean" t)
          ( tapBottom     "boolean" nil)
          ( tapBottomCnt  "boolean" t)
          ( tapRight      "boolean" nil)
          ( tapRightCnt   "boolean" t)
          ( tapLeft       "boolean" t)
          ( tapLeftCnt    "boolean" t)
        )

      let((
        allDiffShapes dioDiff dioDiffBotEdge dioDiffLftEdge dioDiffMet dioDiffNet dioDiffPin
        dioDiffRhtEdge dioDiffTopEdge dioWellNet cv diffBotEdge diffLftEdge diffRhtEdge
        diffTopEdge esdLayer hvBot hvLft hvOLbot hvOLlft hvOLrht hvOLtop
        hvRht hvTop implant maxNumXConts maxNumYConts metEncX metEncY metMaxL
        metMaxW mrk1 mrk2 nwellBot nwellLft nwellOLbot nwellOLlft
        nwellOLrht nwellOLtop nwellRht nwellTop pinAdj tapBotAdjL tapBotAdjR
        tapBotEncPath tapBotPath tapBotSubRect tapEncPath tapEncPathWithCnt
        tapImp tapImpOLtap tapLftAdjB tapLftAdjT tapLftEncPath tapLftPath
        tapLftSubRect tapMetOLcont tapOLcont tapRhtAdjB tapRhtAdjT tapRhtEncPath
        tapRhtPath tapRhtSubRect tapSubRect tapSubRectWithCnt tapTopAdjL
        tapTopAdjR tapTopEncPath tapTopPath tapTopSubRect tapW
        tapbSP taplSP taprSP taptSP vtLayer tapTopL tapLftL tapBotL tapRhtL )

        cv = pcCellView
        dbReplaceProp(cv "instNamePrefix" "string" "D")

        ; Figure out the a/c nets
        ;-----------------------------
        if( rexMatchp("^dpsd" devInfo->deviceName) then
          dioDiffNet   = "PLUS"
          dioWellNet = "MINUS"
        else
          dioDiffNet   = "MINUS"
          dioWellNet = "PLUS"
        ); if device ^dp

        ; create the main diode
        ;-----------------------------
        dioDiff = rodCreateRect(
          ?cvId     cv
          ?name     "dioDiff"
          ?layer    devInfo->diffLay->layer
          ?width    w
          ?length   l
          ?netName  dioDiffNet
          ?termName dioDiffNet
          ?termIOType "inputOutput"
        )
        allDiffShapes = list( dioDiff )

        implant = rodCreateRect(
          ?cvId     cv
          ?name     "implant"
          ?layer    devInfo->impLay->layer
          ?width    2*devInfo->impLay->minOLdiff + w
          ?length   2*devInfo->impLay->minOLdiff + l
        )
        rodAlign(
          ?alignObj     implant
          ?alignHandle  "centerCenter"
          ?refObj       dioDiff
          ?refHandle    "centerCenter"
        )

        ; create vt marking layer
        ;-----------------------------
        when( devInfo->vtLay
          vtLayer = rodCreateRect(
            ?cvId   cv
            ?name   "vtLayer"
            ?layer  devInfo->vtLay->layer
            ?width  max(w devInfo->vtLay->minW round((devInfo->vtLay->minA/l)/grid)*grid
              round((devInfo->vtLay->minA/devInfo->vtLay->minW)/grid)*grid)
            ?length max(l devInfo->vtLay->minW round((devInfo->vtLay->minA/w)/grid)*grid
              round((devInfo->vtLay->minA/devInfo->vtLay->minW)/grid)*grid)
          )
          rodAlign(
            ?alignObj     vtLayer
            ?alignHandle  "lowerLeft"
            ?refObj       dioDiff
            ?refHandle    "lowerLeft"
            ?xSep         -round(0.5*(vtLayer->width-dioDiff->width)/grid)*grid
            ?ySep         -round(0.5*(vtLayer->length-dioDiff->length)/grid)*grid
          )
        ); end when devInfo->vtLay is defined

        ; create esd marking layer
        ;-----------------------------
        when( devInfo->esdLay
          esdLayer = rodCreateRect(
            ?cvId   cv
            ?name   "esdLayer"
            ?layer  devInfo->esdLay
            ?width  w
            ?length l
          )
          rodAlign(
            ?alignObj     esdLayer
            ?alignHandle  "centerCenter"
            ?refObj       dioDiff
            ?refHandle    "centerCenter"
          )
        ); end when devInfo->esdLay is defined

        ; create marking layer 1
        ;-----------------------------
        when( devInfo->mrk1Lay
          mrk1 = rodCreateRect(
            ?cvId   cv
            ?name   "mrk1"
            ?layer  devInfo->mrk1Lay
            ?width  2*devInfo->mrk1OLdiff + w
            ?length 2*devInfo->mrk1OLdiff + l
          )
          rodAlign(
            ?alignObj     mrk1
            ?alignHandle  "centerCenter"
            ?refObj       dioDiff
            ?refHandle    "centerCenter"
          )
        ); end when mrk1 is defined
        
        ; create marking layer 2
        ;-----------------------------
        when( devInfo->mrk2Lay
          mrk2 = rodCreateRect(
            ?cvId   cv
            ?name   "mrk2"
            ?layer  devInfo->mrk2Lay
            ?width  2*devInfo->mrk2OLdiff + w
            ?length 2*devInfo->mrk2OLdiff + l
          )
          rodAlign(
            ?alignObj     mrk2
            ?alignHandle  "centerCenter"
            ?refObj       dioDiff
            ?refHandle    "centerCenter"
          )
        ); end when mrk2 is defined

        ; create the dioDiff contacts
        ;-----------------------------

        if( dioCont then

          ; calculate metal & contacts for dioDiff
          metEncX = rules->li1->minOLSlicon1
          metEncY = rules->li1->minOLSlicon1
          when( l > w metEncX = rules->li1->minOLLlicon1 )
          when( w > l metEncY = rules->li1->minOLLlicon1 )
          maxNumXConts = 1 + fix( (w - rules->licon1->minW -
            2*max(devInfo->diffLay->minOLSlicon1,metEncX))/
            (rules->licon1->minW + rules->licon1->minSP) )
          maxNumYConts = 1 + fix( (l - rules->licon1->minW -
            2*max(devInfo->diffLay->minOLSlicon1,metEncY))/
            (rules->licon1->minW + rules->licon1->minSP) )
          metMaxW = rules->licon1->minW + 2*metEncX +
            (maxNumXConts - 1)*(rules->licon1->minW + rules->licon1->minSP)
          metMaxL = rules->licon1->minW + 2*metEncY +
            (maxNumYConts - 1)*(rules->licon1->minW + rules->licon1->minSP)

          dioDiffMet = rodCreateRect(
            ?cvId     cv
            ?name     "dioDiffMet"
            ?layer    rules->li1->layer
            ?termName  dioDiffNet
            ?termIOType "inputOutput"
            ?width    metMaxW 
            ?length   metMaxL
          )
          rodAlign(
            ?alignObj     dioDiffMet
            ?alignHandle  "lowerLeft"
            ?refObj       dioDiff
            ?refHandle    "lowerLeft"
            ?xSep         round((0.5*(w-metMaxW))/grid)*grid
            ?ySep         round((0.5*(l-metMaxL))/grid)*grid
          )
          rodCreateRect(
            ?cvId     cv
            ?name     "dioDiffConts"
            ?layer    rules->licon1->layer
            ?width    rules->licon1->minW
            ?length   rules->licon1->minW
            ?fillBBox list(
              xCoord(dioDiffMet->lowerLeft)+metEncX:yCoord(dioDiffMet->lowerLeft)+metEncY
              xCoord(dioDiffMet->upperRight)-metEncX:yCoord(dioDiffMet->upperRight)-metEncY )
            ?spaceX   rules->licon1->minSP
            ?spaceY   rules->licon1->minSP
          )
          dioDiffPin = rodCreateRect(
            ?cvId     cv
            ?name     "dioDiffPin"
            ?layer    list( rules->li1->pinlayer rules->li1->pinpurpose )
            ?width    dioDiffMet->width
            ?length   dioDiffMet->length
            ?netName  dioDiffNet
            ?termName dioDiffNet
            ?termIOType "inputOutput"
            ?pin      t
            ?pinLabel t
            ;?pinLabelHeight min( 0.3 round( (dioDiff->width/length(dioDiffNet)) /grid)*grid) ; CBPL changed text height
            ?pinLabelHeight min( 0.15 round( (dioDiff->width/length(dioDiffNet)) /grid)*grid)
            ?pinLabelLayer  list( rules->li1->layer "label")
            ?pinLabelFont   "stick"
          )
          rodAlign(
            ?alignObj     dioDiffPin
            ?alignHandle  "lowerLeft"
            ?refObj       dioDiffMet
            ?refHandle    "lowerLeft"
          )
        else
          dioDiffPin = rodCreateRect(
            ?cvId     cv
            ?name     "dioDiffPin"
            ?layer    list( devInfo->diffLay->pinlayer devInfo->diffLay->pinpurpose )
            ?width    w
            ?length   l
            ?netName  dioDiffNet
            ?termName dioDiffNet
            ?termIOType "inputOutput"
            ?pin      t
            ?pinLabel t
            ;?pinLabelHeight min( 0.3 round( (dioDiff->width/length(dioDiffNet)) /grid)*grid); CBPL changed text height
            ?pinLabelHeight min( 0.15 round( (dioDiff->width/length(dioDiffNet)) /grid)*grid)
            ?pinLabelLayer  list( devInfo->diffLay->layer "label")
            ?pinLabelFont   "stick"
          )
          rodAlign(
            ?alignObj     dioDiffPin
            ?alignHandle  "lowerLeft"
            ?refObj       dioDiff
            ?refHandle    "lowerLeft"
          )
        ); if dioCont

        ; create the taps
        ;-----------------------------
        tapImp = devInfo->tapImpLay->layer
        tapImpOLtap = devInfo->tapImpLay->minOLtap

        ; best to go with max overlap contact so the corners will line up
        tapOLcont = max(rules->tap->minOLLisoTapLicon1 rules->tap->minOLSisoTapLicon1)
        tapMetOLcont = max(rules->li1->minOLLlicon1 rules->li1->minOLSlicon1)
        tapW = max(rules->tap->minW  2*tapOLcont + rules->licon1->minW )

        ; do some basic calculations for the tap

        ; spacing to dioDiff
        taplSP = taprSP = taptSP = tapbSP = 
          max( if( devInfo->hvLay then devInfo->diffLay->minSPhvtap else devInfo->diffLay->minSP )
            devInfo->impLay->minOLdiff + devInfo->impLay->minSPdiff
            devInfo->tapImpLay->minOLtap + devInfo->impLay->minSPdiff )

        if( tapTop    then tapRhtAdjT = tapLftAdjT = tapW + taptSP else tapRhtAdjT = tapLftAdjT = 0.0 )
        if( tapLeft   then tapTopAdjL = tapBotAdjL = tapW + taplSP else tapTopAdjL = tapBotAdjL = 0.0 )
        if( tapBottom then tapRhtAdjB = tapLftAdjB = tapW + tapbSP else tapRhtAdjB = tapLftAdjB = 0.0 )
        if( tapRight  then tapTopAdjR = tapBotAdjR = tapW + taprSP else tapTopAdjR = tapBotAdjR = 0.0 )

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

        ; grab coordinates from dioDiff rodShape
        dioDiffTopEdge = yCoord(dioDiff->upperRight)
        dioDiffRhtEdge = xCoord(dioDiff->upperRight)
        dioDiffBotEdge = yCoord(dioDiff->lowerLeft)
        dioDiffLftEdge = xCoord(dioDiff->lowerLeft)

        tapTopL = dioDiff->width  + tapTopAdjL + tapTopAdjR
        tapLftL = dioDiff->length + tapLftAdjT + tapLftAdjB
        tapBotL = dioDiff->width  + tapBotAdjL + tapBotAdjR
        tapRhtL = dioDiff->length + tapRhtAdjT + tapRhtAdjB

        ; adjust the tap in case it is too small for metal
        ; since the min would only happen when the adjacent taps are off,
        ; no need to adjust things twice, just once for top/bot and once
        ; for left/right
        when( tapTopL < tapW
          dioDiffRhtEdge = dioDiffRhtEdge + round((0.5*(tapW-tapTopL))/grid)*grid
          dioDiffLftEdge = dioDiffLftEdge - round((0.5*(tapW-tapTopL))/grid)*grid
        ); when
        when( tapRhtL < tapW
          dioDiffTopEdge = dioDiffTopEdge + round((0.5*(tapW-tapRhtL))/grid)*grid
          dioDiffBotEdge = dioDiffBotEdge - round((0.5*(tapW-tapRhtL))/grid)*grid
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
              dioDiffLftEdge-tapTopAdjL : dioDiffTopEdge+taptSP+0.5*tapW
              dioDiffRhtEdge+tapTopAdjR : dioDiffTopEdge+taptSP+0.5*tapW
            )
            ?netName  dioWellNet
            ?termName dioWellNet
            ?termIOType "inputOutput"
            ?pin      t
            ?encSubPath tapTopEncPath
            ?subRect tapTopSubRect
          ); end rodCreatePath tapTopPath
          allDiffShapes = cons( tapTopPath allDiffShapes )
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
              ?netName  dioWellNet
              ?termName dioWellNet
              ?termIOType "inputOutput"
              ?pin      t
              ?pinLabel t
              ?pinLabelHeight round( (tapW/length(dioWellNet)) /grid)*grid
              ?pinLabelLayer  list( rules->li1->layer "label")
              ?pinLabelFont   "stick"
            )
          )
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
              dioDiffRhtEdge+taprSP+0.5*tapW : dioDiffBotEdge-tapRhtAdjB
              dioDiffRhtEdge+taprSP+0.5*tapW : dioDiffTopEdge+tapRhtAdjT
            )
            ?netName  dioWellNet
            ?termName dioWellNet
            ?termIOType "inputOutput"
            ?pin      t
            ?encSubPath tapRhtEncPath
            ?subRect tapRhtSubRect
          ); end rodCreatePath tapRhtPath
          allDiffShapes = cons( tapRhtPath allDiffShapes )
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
              ?netName  dioWellNet
              ?termName dioWellNet
              ?termIOType "inputOutput"
              ?pin      t
              ?pinLabel t
              ?pinLabelHeight round( (tapW/length(dioWellNet)) /grid)*grid
              ?pinLabelLayer  list( rules->li1->layer "label")
              ?pinLabelFont   "stick"
              ?pinLabelOrient "R90"
            )
          )
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
              dioDiffLftEdge-tapBotAdjL : dioDiffBotEdge-tapbSP-0.5*tapW
              dioDiffRhtEdge+tapBotAdjR : dioDiffBotEdge-tapbSP-0.5*tapW
            )
            ?netName  dioWellNet
            ?termName dioWellNet
            ?termIOType "inputOutput"
            ?pin      t
            ?encSubPath tapBotEncPath
            ?subRect tapBotSubRect
          ); end rodCreatePath tapBotPath
          allDiffShapes = cons( tapBotPath allDiffShapes )
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
              ?netName  dioWellNet
              ?termName dioWellNet
              ?termIOType "inputOutput"
              ?pin      t
              ?pinLabel t
              ?pinLabelHeight round( (tapW/length(dioWellNet)) /grid)*grid
              ?pinLabelLayer  list( rules->li1->layer "label")
              ?pinLabelFont   "stick"
            )
          )
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
              dioDiffLftEdge-taplSP-0.5*tapW : dioDiffBotEdge-tapLftAdjB
              dioDiffLftEdge-taplSP-0.5*tapW : dioDiffTopEdge+tapLftAdjT
            )
            ?netName  dioWellNet
            ?termName dioWellNet
            ?termIOType "inputOutput"
            ?pin      t
            ?encSubPath tapLftEncPath
            ?subRect tapLftSubRect
          ); end rodCreatePath tapLftPath
          allDiffShapes = cons( tapLftPath allDiffShapes )
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
              ?netName  dioWellNet
              ?termName dioWellNet
              ?termIOType "inputOutput"
              ?pin      t
              ?pinLabel t
              ?pinLabelHeight round( (tapW/length(dioWellNet)) /grid)*grid
              ?pinLabelLayer  list( rules->li1->layer "label")
              ?pinLabelFont   "stick"
              ?pinLabelOrient "R90"
            )
          )
        ); end if tapLeft

        ; create body pin if no taps exist
        unless( tapTop || tapLeft || tapBottom || tapRight
          if( devInfo->nwellLay then
            rodCreateRect(
              ?cvId   cv
              ?name   "wellPin"
              ?layer  list( "nwell" "pin" )
              ?fromObj rodGetObj( "dioDiff" cv )
              ?netName  dioWellNet
              ?termName dioWellNet
              ?termIOType "inputOutput"
              ?pin      t
              ?pinLabel t
              ;?pinLabelHeight 0.3; CBPL changed text height
              ?pinLabelHeight 0.15
              ?pinLabelLayer  list( "nwell" "label")
              ?pinLabelFont   "stick"
            )
          else
            rodCreateRect(
              ?cvId   cv
              ?name   "wellPin"
              ?layer  list( "pwell" "pin" )
              ?fromObj rodGetObj( "dioDiff" cv )
              ?netName  dioWellNet
              ?termName dioWellNet
              ?termIOType "inputOutput"
              ?pin      t
              ?pinLabel t
              ;?pinLabelHeight 0.3 ; CBPL changed text height
              ?pinLabelHeight 0.15
              ?pinLabelLayer  list( "pwell" "label")
              ?pinLabelFont   "stick"
            )
          ); if nwell
        ); unless any taps

        ; calculations for hvLay and nwellLayer
        ;-----------------------------
        diffTopEdge = yCoord( car(allDiffShapes)->upperRight )
        diffLftEdge = xCoord( car(allDiffShapes)->lowerLeft )
        diffBotEdge = yCoord( car(allDiffShapes)->lowerLeft )
        diffRhtEdge = xCoord( car(allDiffShapes)->upperRight )
        foreach( diffShape allDiffShapes
          diffTopEdge = max(diffTopEdge yCoord( diffShape->upperRight ))
          diffLftEdge = min(diffLftEdge xCoord( diffShape->lowerLeft ))
          diffBotEdge = min(diffBotEdge yCoord( diffShape->lowerLeft ))
          diffRhtEdge = max(diffRhtEdge xCoord( diffShape->upperRight ))
        ); foreach diffShape

        if( tapTop then
          if( devInfo->hvLay then
            if( devInfo->nwellLay then
              hvOLtop = max(devInfo->hvLay->minOLtap devInfo->nwellLay->minOLhvtap)
            else
              hvOLtop = devInfo->hvLay->minOLtap
            )
            nwellOLtop = devInfo->nwellLay->minOLhvtap||0.0
          else
            hvOLtop = 0.0
            nwellOLtop = devInfo->nwellLay->minOLtap||0.0
          ); if hvLay
        else
          if( devInfo->hvLay then
            if( devInfo->nwellLay then
              hvOLtop = max(devInfo->hvLay->minOLdiff devInfo->nwellLay->minOLhvdiff)
            else
              hvOLtop = devInfo->hvLay->minOLdiff
            )
            if( devInfo->vtLay then
              nwellOLtop = max(devInfo->nwellLay->minOLhvdiff||0
                devInfo->vtLay->minWellOL||0 )
            else
              nwellOLtop = devInfo->nwellLay->minOLhvdiff||0
            )
          else
            hvOLtop = devInfo->hvLay->minOLdiff||0
            if( devInfo->vtLay then
              nwellOLtop = max(devInfo->nwellLay->minOLdiff||0
                devInfo->vtLay->minWellOL+round((0.5*(vtLayer->length-l))/grid)*grid||0 )
            else
              nwellOLtop = devInfo->nwellLay->minOLdiff||0
            )
          ); if hvLay
        ); if tapTop
        hvTop = diffTopEdge + hvOLtop
        nwellTop = diffTopEdge + nwellOLtop

        if( tapBottom then
          if( devInfo->hvLay then
            if( devInfo->nwellLay then
              hvOLbot = max(devInfo->hvLay->minOLtap devInfo->nwellLay->minOLhvtap)
            else
              hvOLbot = devInfo->hvLay->minOLtap
            )
            nwellOLbot = devInfo->nwellLay->minOLhvtap||0
          else
            hvOLbot = 0.0
            nwellOLbot = devInfo->nwellLay->minOLtap||0
          ); if hvLay
        else
          if( devInfo->hvLay then
            if( devInfo->nwellLay then
              hvOLbot = max(devInfo->hvLay->minOLdiff devInfo->nwellLay->minOLhvdiff)
            else
              hvOLbot = devInfo->hvLay->minOLdiff
            )
            if( devInfo->vtLay then
              nwellOLbot = max(devInfo->nwellLay->minOLhvdiff||0
                devInfo->vtLay->minWellOL||0 )
            else
              nwellOLbot = devInfo->nwellLay->minOLhvdiff||0
            )
          else
            hvOLbot = devInfo->hvLay->minOLdiff||0
            if( devInfo->vtLay then
              nwellOLbot = max(devInfo->nwellLay->minOLdiff||0
                devInfo->vtLay->minWellOL+round((0.5*(vtLayer->length-l))/grid)*grid||0 )
            else
              nwellOLbot = devInfo->nwellLay->minOLdiff||0
            )
          ); if hvLay
        ); if tapBottom
        hvBot = diffBotEdge - hvOLbot
        nwellBot = diffBotEdge - nwellOLbot

        if( tapRight then
          if( devInfo->hvLay then
            if( devInfo->nwellLay then
              hvOLrht = max(devInfo->hvLay->minOLtap devInfo->nwellLay->minOLhvtap)
            else
              hvOLrht = devInfo->hvLay->minOLtap
            )
            nwellOLrht = devInfo->nwellLay->minOLhvtap||0.0
          else
            hvOLrht = 0.0
            nwellOLrht = devInfo->nwellLay->minOLtap||0.0
          ); if hvLay
        else
          if( devInfo->hvLay then
            if( devInfo->nwellLay then
              hvOLrht = max(devInfo->hvLay->minOLdiff devInfo->nwellLay->minOLhvdiff)
            else
              hvOLrht = devInfo->hvLay->minOLdiff
            )
            if( devInfo->vtLay then
              nwellOLrht = max( devInfo->nwellLay->minOLhvdiff||0
                devInfo->vtLay->minWellOL||0 )
            else
              nwellOLrht = devInfo->nwellLay->minOLhvdiff||0
            )
          else
            hvOLrht = devInfo->hvLay->minOLdiff||0
            if( devInfo->vtLay then
              nwellOLrht = max( devInfo->nwellLay->minOLdiff||0
                devInfo->vtLay->minWellOL+round((0.5*(vtLayer->width-w))/grid)*grid||0 )
            else
              nwellOLrht = devInfo->nwellLay->minOLdiff||0
            )
          ); if hvLay
        ); if tapRight
        hvRht = diffRhtEdge + hvOLrht
        nwellRht = diffRhtEdge + nwellOLrht

        if( tapLeft then
          if( devInfo->hvLay then
            if( devInfo->nwellLay then
              hvOLlft = max(devInfo->hvLay->minOLtap devInfo->nwellLay->minOLhvtap)
            else
              hvOLlft = devInfo->hvLay->minOLtap
            )
            nwellOLlft = devInfo->nwellLay->minOLhvtap||0
          else
            hvOLlft = 0.0
            nwellOLlft = devInfo->nwellLay->minOLtap||0
          ); if hvLay
        else
          if( devInfo->hvLay then
            if( devInfo->nwellLay then
              hvOLlft = max(devInfo->hvLay->minOLdiff devInfo->nwellLay->minOLhvdiff)
            else
              hvOLlft = devInfo->hvLay->minOLdiff
            )
            nwellOLlft = devInfo->nwellLay->minOLhvdiff||0
            if( devInfo->vtLay then
              nwellOLlft = max( devInfo->nwellLay->minOLhvdiff||0
                devInfo->vtLay->minWellOL||0 )
            else
              nwellOLlft = devInfo->nwellLay->minOLhvdiff||0
            )
          else
            hvOLlft = devInfo->hvLay->minOLdiff||0
            if( devInfo->vtLay then
              nwellOLlft = max( devInfo->nwellLay->minOLdiff||0
                devInfo->vtLay->minWellOL+round((0.5*(vtLayer->width-w))/grid)*grid||0 )
            else
              nwellOLlft = devInfo->nwellLay->minOLdiff||0
            )
          ); if hvLay
        ); if tapLeft
        hvLft = diffLftEdge - hvOLlft
        nwellLft = diffLftEdge - nwellOLlft

        ; create thkox & hv marking layer
        ;-----------------------------
        when( devInfo->hvLay
          ; insure the hv meets min width for ndiodes
          unless( devInfo->nwellLay
            when( devInfo->hvLay->minW > (hvRht-hvLft)
              hvRht = hvRht + (round((0.5*(devInfo->hvLay->minW-(hvRht-hvLft)))/grid)*grid)
              hvLft = hvRht - devInfo->hvLay->minW
            ); when
            when( devInfo->hvLay->minW > (hvTop-hvBot)
              hvTop = hvTop + (round((0.5*(devInfo->hvLay->minW-(hvTop-hvBot)))/grid)*grid)
              hvBot = hvTop - devInfo->hvLay->minW
            ); when
          ); unless

          rodCreateRect(
            ?cvId   cv
            ?name   "thkox"
            ?layer  devInfo->hvLay->layer
            ?bBox   list( hvLft:hvBot hvRht:hvTop )
          )
          rodCreateRect(
            ?cvId   cv
            ?name   "hvLayer"
            ?layer  rules->hvi->layer
            ?bBox   list( hvLft:hvBot hvRht:hvTop )
          )
        ); end when devInfo->hvLay is defined

        ; create nwell layer
        ;-----------------------------
        when( devInfo->nwellLay
          ; insure the nwell meets min width
          when( devInfo->nwellLay->minW > (nwellRht-nwellLft)
            nwellRht = nwellRht + (round((0.5*(devInfo->nwellLay->minW-(nwellRht-nwellLft)))/grid)*grid)
            nwellLft = nwellRht - devInfo->nwellLay->minW
          ); when
          when( devInfo->nwellLay->minW > (nwellTop-nwellBot)
            nwellTop = nwellTop + (round((0.5*(devInfo->nwellLay->minW-(nwellTop-nwellBot)))/grid)*grid)
            nwellBot = nwellTop - devInfo->nwellLay->minW
          ); when

          rodCreateRect(
            ?cvId     cv
            ?name     "nwellLayer"
            ?layer    devInfo->nwellLay->layer
            ?bBox     list( nwellLft:nwellBot nwellRht:nwellTop )
          )
        ); when devInfo->nwellLay defined

        ); let
      ); pcDefinePCell layout
    ); when device->layout

    ;===========================================================
    ;***** Define Symbol Pcell *****
    ;===========================================================

    when( device->symbols
    foreach( view list("symbol" "auCdl" "auLvs" "spectre")
      let( (cv modelLabel instLabel labelA labelM labelW labelL
            netm netp plus minus termP termM paramLabel)
      when( cv = dbOpenCellViewByType( ddGetObj(libName) device->deviceName view "schematicSymbol" "w" ) 

        ; device->native ; boolean: nil, t
        ; device->esd    ; boolean: nil, t
        ; device->hv     ; int:  nil, 3, 5, 12, 20
        ; device->vt     ; string:  nil, "low", "med", "high"

        dbReplaceProp(cv "instNamePrefix" "string" "D")

        ; bounding box and main labels
        ;-----------------------------
        dbCreateRect(cv list("instance" "drawing") list(-0.0625:-0.375 0.065:0.0))

        instLabel = dbCreateLabel( cv list("annotate" "drawing7") -0.0625:-0.046875 "[@instanceName]"
          "centerRight" "R0" "stick" 0.0625 )
        instLabel~>labelType = "NLPLabel"
        modelLabel = dbCreateLabel( cv list("text" "drawing") 0.078125:-0.1875 "[@model]"
          "upperCenter" "R90" "stick" 0.03125 )
        modelLabel~>labelType = "NLPLabel"

        labelA = dbCreateLabel( cv list("annotate" "drawing") -0.0625:-0.140625 "[@area:A=%]"
          "centerRight" "R0" "stick" 0.03125 )
        labelA~>labelType = "NLPLabel"
        labelW = dbCreateLabel(cv list("annotate" "drawing") -0.0625:-0.203125
          "[@w:W=%]" "centerRight" "R0" "stick" 0.03125)
        labelW->labelType = "NLPLabel"
        labelL = dbCreateLabel(cv list("annotate" "drawing") -0.0625:-0.265625
          "[@l:L=%]" "centerRight" "R0" "stick" 0.03125)
        labelL->labelType = "NLPLabel"
        labelM = dbCreateLabel(cv list("annotate" "drawing") -0.0625:-0.328125
          "[@m:M=%]" "centerRight" "R0" "stick" 0.03125)
        labelM->labelType = "NLPLabel"

        ; create nets and pins
        ;-----------------------------
        netp = dbMakeNet(cv "PLUS")
        dbCreateTerm(netp "PLUS" "inputOutput")
        if( rexMatchp("sub" device->deviceName) then 
          plus = dbCreatePolygon(cv list("pin" "drawing")
            list(-0.01875:0.01875 0:-0.01875 0.01875:0.01875) )
        else
          plus = dbCreateRect(cv list("pin" "drawing")
            list(-0.01875:-0.01875 0.01875:0.01875) )
        ); if device is sub
        dbMoveShape(plus cv list(0:-0.375 "R0"))
        dbCreatePin(netp plus)
        termP = dbCreateLabel( cv list("annotate" "drawing8") 0.0125:-0.375 "cdsTerm(\"PLUS\")"
          "upperRight" "R90" "stick" 0.01875 )
        termP~>labelType = "ILLabel"
        termP->parent = plus

        netm = dbMakeNet(cv "MINUS")
        dbCreateTerm(netm "MINUS"  "inputOutput")
        minus = dbCreateRect(cv list("pin" "drawing")
          list(-0.01875:-0.01875 0.01875:0.01875) )
        dbCreatePin(netm minus)
        termM = dbCreateLabel( cv list("annotate" "drawing8") 0.0125:0 "cdsTerm(\"MINUS\")"
          "upperLeft" "R90" "stick" 0.01875 )
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

        ; main diode drawing
        ;-----------------------------
        dbCreateLine(cv list("device" "drawing") list(0.0:0.0 0.0:-0.15625) )
        dbCreateLine(cv list("device" "drawing") list(0.0:-0.25 0.0:-0.375) )
        if( device->native then
          dbCreateLine(cv list("device" "drawing2") list(-0.0625:-0.15625 0.0625:-0.15625) )
        else
          if( device->hv then
            dbCreateLine(cv list("y9" "drawing") list(-0.0625:-0.15625 0.0625:-0.15625) )
          else
            dbCreateLine(cv list("device" "drawing") list(-0.0625:-0.15625 0.0625:-0.15625) )
          ); if hv
        ); if native
        if( device->hv then
          dbCreateLine(cv list("y9" "drawing")
            list(-0.0625:-0.25 0.0625:-0.25 0.0:-0.15625 -0.0625:-0.25) )
        else
          dbCreateLine(cv list("device" "drawing")
            list(-0.0625:-0.25 0.0625:-0.25 0.0:-0.15625 -0.0625:-0.25) )
        ); if hv

    ;    dbCreateLine(cv
    ;      if( device->native then list("device" "drawing2") else list("device" "drawing") )
    ;      list(-0.0625:-0.15625 0.0625:-0.15625) )
    ;    dbCreateLine(cv list("device" "drawing")
    ;      list(-0.0625:-0.25 0.0625:-0.25 0.0:-0.15625 -0.0625:-0.25) )

        ; HV label for high voltage devices
        ;-----------------------------
        when( device->hv
          dbCreateLabel( cv list("device" "drawing") 0.0:-0.21875
            sprintf(nil "%dV" device->hv) "centerCenter" "R0" "stick" 0.01875 )
        )
        ; RF label for rf devices
        ;-----------------------------
        if( rexMatchp("_rf" device->deviceName) then 
          dbCreateLabel( cv list("device" "drawing") 0.0:-0.140625
            "RF" "lowerRight" "R0" "stick" 0.01875 )
        )
        ; label for hvt/lvt devices
        ;-----------------------------
        if( rexMatchp("_lvt" device->deviceName) then 
          dbCreateLabel( cv list("device" "drawing") 0.0:-0.140625
            "LVT" "lowerRight" "R0" "stick" 0.01875 )
        )
        if( rexMatchp("_hvt" device->deviceName) then 
          dbCreateLabel( cv list("device" "drawing") 0.0:-0.140625
            "HVT" "lowerRight" "R0" "stick" 0.01875 )
        )
        ; lightning bolt (ESD devices)
        ;-----------------------------
        when( device->esd
          dbCreatePolygon(cv list("device" "drawing1")
            list(0.0375:-0.05625 0.0625:-0.05625 0.04375:-0.08125 
              0.0625:-0.08125 0.01875:-0.1375 0.03125:-0.09375 0.0125:-0.09375))
        ); when esd

      ; if the device doesn't have a layout, add the xlRemoveDevice prop
      if( device->layout then
        dbReplaceProp(cv "ignore" "boolean" nil)
      else
        dbReplaceProp(cv "ignore" "boolean" t)
      ); if device->layout

      dbSave(cv)
      dbClose(cv)
      ); when cv
      ); let
    ); foreach view
    ); when device->symbols

    ;===========================================================
    ;***** CDF definition *****
    ;===========================================================

    let( ( cellName cellId cdf tfId )

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
        ?defValue       device->modelName
        ?storeDefault   "yes"
        ?parseAsCEL     "yes"
        ?editable       "nil"
        ?display        "hiGetCurrentWindow()~>cellView~>cellViewType != \"maskLayout\""
      )
      cdfCreateParam( cdf
        ?name           "lvsModel"
        ?prompt         "LVS Model Name"
        ?type           "string"
        ?defValue       device->lvsModel
        ?storeDefault   "yes"
        ?parseAsCEL     "yes"
        ?editable       "nil"
        ?display        "hiGetCurrentWindow()~>cellView~>cellViewType == \"maskLayout\""
      )
      cdfCreateParam( cdf
        ?name           "info"
        ?prompt         "Device Info"
        ?type           "string"
        ?defValue       device->devInfo
        ?storeDefault   "yes"
        ?parseAsCEL     "yes"
        ?editable       "nil"
        ?display        "hiGetCurrentWindow()~>cellView~>cellViewType != \"maskLayout\""
      )
      cdfCreateParam( cdf
        ?name           "calcMethod"
        ?prompt         "Calculate By"
        ?type           "cyclic"
        ?defValue       "Width & Length"
        ?storeDefault   "yes"
        ?choices        list("Area & Width" "Width & Length")
      )
      cdfCreateParam( cdf
        ?name           "area"
        ?prompt         "Area (um^2)"
        ?type           "string"
        ?defValue       S130stringTruncateZeros(sprintf(nil "%f" (device->defW * device->defL) ))
        ?editable       "cdfgData->calcMethod->value == \"Area & Width\""
        ?storeDefault   "yes"
        ?parseAsCEL     "yes"
        ?parseAsNumber  "yes"
        ?callback       strcat(device->paramCB "()")
      )
      cdfCreateParam( cdf
        ?name           "perim"
        ?prompt         "Perimeter (um)"
        ?type           "string"
        ?defValue       S130stringTruncateZeros(sprintf(nil "%.3f" (2*device->defW + 2*device->defL) ))
        ?editable       "nil"
        ?storeDefault   "yes"
        ?parseAsCEL     "yes"
        ?parseAsNumber  "yes"
      )
      cdfCreateParam( cdf
        ?name           "w"
        ?prompt         "Width (um)"
        ?type           "float"
        ?defValue       device->defW
        ?storeDefault   "yes"
        ?callback       strcat(device->paramCB "()")
      )
      cdfCreateParam( cdf
        ?name           "l"
        ?prompt         "Length (um)"
        ?type           "float"
        ?defValue       device->defL
        ?storeDefault   "yes"
        ?callback       strcat(device->paramCB "()")
        ?editable       "cdfgData->calcMethod->value == \"Width & Length\""
      )
      cdfCreateParam( cdf
        ?name           "m"
        ?prompt         "Multiples"
        ?type           "int"
        ?defValue       1
        ?storeDefault   "yes"
        ?callback       strcat(device->paramCB "()")
        ?display        "hiGetCurrentWindow()~>cellView~>cellViewType != \"maskLayout\""
      )
      when( device->layout
        cdfCreateParam( cdf
          ?name           "dioCont"
          ?prompt         "Contacts on diode"
          ?type           "boolean"
          ?defValue       t
          ?storeDefault   "yes"
          ?display        "hiGetCurrentWindow()~>cellView~>cellViewType == \"maskLayout\""
        )
        cdfCreateParam( cdf
          ?name           "tapLeft"
          ?prompt         "Left Tap"
          ?type           "boolean"
          ?defValue       t
          ?storeDefault   "yes"
          ?display        "hiGetCurrentWindow()~>cellView~>cellViewType == \"maskLayout\""
        )
        cdfCreateParam( cdf
          ?name           "tapLeftCnt"
          ?prompt         "   Left Tap Contacts"
          ?type           "boolean"
          ?defValue       t
          ?storeDefault   "yes"
          ?display        "cdfgData->tapLeft->value && hiGetCurrentWindow()~>cellView~>cellViewType == \"maskLayout\""
        )
        cdfCreateParam( cdf
          ?name           "tapRight"
          ?prompt         "Right Tap"
          ?type           "boolean"
          ?defValue       nil
          ?storeDefault   "yes"
          ?display        "hiGetCurrentWindow()~>cellView~>cellViewType == \"maskLayout\""
        )
        cdfCreateParam( cdf
          ?name           "tapRightCnt"
          ?prompt         "   Right Tap Contacts"
          ?type           "boolean"
          ?defValue       t
          ?storeDefault   "yes"
          ?display        "cdfgData->tapRight->value && hiGetCurrentWindow()~>cellView~>cellViewType == \"maskLayout\""
        )
        cdfCreateParam( cdf
          ?name           "tapTop"
          ?prompt         "Top Tap"
          ?type           "boolean"
          ?defValue       nil
          ?storeDefault   "yes"
          ?display        "hiGetCurrentWindow()~>cellView~>cellViewType == \"maskLayout\""
        )
        cdfCreateParam( cdf
          ?name           "tapTopCnt"
          ?prompt         "   Top Tap Contacts"
          ?type           "boolean"
          ?defValue       t
          ?storeDefault   "yes"
          ?display        "cdfgData->tapTop->value && hiGetCurrentWindow()~>cellView~>cellViewType == \"maskLayout\""
        )
        cdfCreateParam( cdf
          ?name           "tapBottom"
          ?prompt         "Bottom Tap"
          ?type           "boolean"
          ?defValue       nil
          ?storeDefault   "yes"
          ?display        "hiGetCurrentWindow()~>cellView~>cellViewType == \"maskLayout\""
        )
        cdfCreateParam( cdf
          ?name           "tapBottomCnt"
          ?prompt         "   Bottom Tap Contacts"
          ?type           "boolean"
          ?defValue       t
          ?storeDefault   "yes"
          ?display        "cdfgData->tapBottom->value && hiGetCurrentWindow()~>cellView~>cellViewType == \"maskLayout\""
        )
      ); when device->layout

      cdf->simInfo = list( nil)
      cdf->simInfo->auCdl = '( nil
        dollarEqualParams nil
        dollarParams      nil
        otherParameters   nil
        netlistProcedure  ansCdlSubcktCallExtended
        instParameters    (model m area pj)
        propMapping       (nil model lvsModel pj perim)
        componentName     nil
        termOrder         (PLUS MINUS)
        namePrefix        "D"
      )
      cdf->simInfo->auLvs = '( nil
        dollarEqualParams nil
        dollarParams      nil
        otherParameters   nil
        netlistProcedure  ansLvsCompParamPrim
        instParameters    (model m area pj )
        propMapping       (nil model lvsModel pj perim)
        termOrder         (PLUS MINUS)
        namePrefix        "D"
      )
      cdf->simInfo->spectre = '( nil
        propMapping             nil
        otherParameters         (model)
        instParameters          (m area perim)
        termOrder               (PLUS MINUS)
        namePrefix              "D"
        componentName           model
      )

      cdf->simInfo->spectreS = '( nil
        propMapping             nil
        netlistProcedure        ansSpectreSDevPrim
        otherParameters         (model)
        instParameters          (m area perim)
        termOrder               (PLUS MINUS)
        namePrefix              "D"
        componentName           model
      )

      ;;; Properties
      cdf->formInitProc              = "S130disablePcellChange"
      cdf->doneProc                  = ""
      cdf->buttonFieldWidth          = 340
      cdf->fieldHeight               = 35
      cdf->fieldWidth                = 350
      cdf->promptWidth               = 175
      cdf->modelLabelSet             = "is rs n"
      cdf->opPointLabelSet           = "id vd reg"
      cdf->paramLabelSet             = ""
      cdf->instDisplayMode           = "instName"
      cdf->instNameType              = "schematic"


      cdfSaveCDF(cdf)

    );  let
  ); foreach device

);  let

/*==================================  EOF  ===================================*/
