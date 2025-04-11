/*==============================================================================
  File:         S130fet20vPcell.il
  Purpose:      Pcell code for layout setup for 20v mosfet (DE)
                devices for Skywater S130 Pcells

  Created:      Aug 15, 2020  Madek Graham
  Description:  Pcell code to create the 20V mosfet (DE) devices
  
  Devices/views:  nmos_de_v20         / layout
                  nmos_de_nat_v20     / layout
                  nmos_de_zvt_v20     / layout
                  nmos_de_iso_v20     / layout
                  pmos_de_v20         / layout

------------------------------------------------------------
  Modifications:

==============================================================================*/

let( ( libName )

  libName = "S130"

  ;; techData will be loaded in by the tech library's libInit.il

  foreach( device fet20vDevices

    printf("Creating device %s in %s library\n" device->deviceName libName )

/* For now, layout is set size until we have construction rules to build them
    ;===========================================================
    ;***** Define Layout Pcell *****
    ;===========================================================

    ; THERE ARE NO CONSTRUCTION RULES FOR THIS CURRENTLY, SO MOST OF THE SHAPES
    ; ARE HARD CODED IN SIZE, OVERLAPS, SPACING, ETC.  THE ONLY VARIABLES THAT
    ; ARE ADJUSTABLE ARE FW AND NF.

    pcDefinePCell( list( ddGetObj(libName) device->deviceName "layout" )
      ; formal parameters name value pairs
      (
        ( devInfo       "ilList"  device )
        ( rules         "ilList"  designRules )
        ( grid          "float"   techGetMfgGridResolution(techGetTechFile(ddGetObj(libName))) )
        ( fw            "float"   device->defW ) ; finger width
        ( l             "float"   device->defL )
        ( nf            "int"     2 )
        ( gateCnt       "string"  "none")   ; choices: none, Top, Bottom, Both
        ( tapTop        "boolean" nil)
        ( tapTopCnt     "boolean" t)
        ( tapBottom     "boolean" nil)
        ( tapBottomCnt  "boolean" t)
        ( tapRight      "boolean" nil)
        ( tapRightCnt   "boolean" t)
        ( tapLeft       "boolean" t)
        ( tapLeftCnt    "boolean" t)
      )

      let(( actImp activeBotEdge activeLftEdge activeRhtEdge activeTopEdge
          activeTotalL activeTotalW allActiveShapes allDiffShapes cv
          diffBotEdge diffLftEdge diffRhtEdge diffTopEdge drainImpPoints
          drainPoints drnBevW endCapExt fdrnSP fsrcSP
          gateCntL gateCntMetL gateCntMetW gateCntW gateNumCnts
          gateSPgateCnt gateX hvBot hvLft hvOLbot
          hvOLlft hvOLrht hvOLtop hvRht hvTop
          impOLsrc minDrnW nwellBevW nwellBot nwellEndPoints
          nwellL nwellLayer nwellLft nwellOLbot nwellOLlft
          nwellOLrht nwellOLtop nwellPoints nwellRht nwellShapes
          nwellTop nwellW nwellWend pinAdj polyWidth
          srcDrnLength srcDrnNumConts tapBotAdjL tapBotAdjR tapBotEncPath
          tapBotL tapBotSubRect tapEncPath tapEncPathWithCnt tapImp
          tapImpOLtap tapLftAdjB tapLftAdjT tapLftEncPath tapLftL
          tapLftSubRect tapMetOLcont tapOLcont tapRhtAdjB tapRhtAdjT
          tapRhtEncPath tapRhtL tapRhtSubRect tapSubRect tapSubRectWithCnt
          tapTopAdjL tapTopAdjR tapTopEncPath tapTopL tapTopSubRect
          tapW tapbSP taplSP taprSP taptSP )

        cv = pcCellView
        dbReplaceProp(cv "instNamePrefix" "string" "MN")
        actImp = rules->nsdm
        tapImp = rules->psdm

        ; gate width (gate l + overlaps)
        polyWidth = l + devInfo->gateOLwell
        ; figure out the finger spacing
        fsrcSP = 2*(rules->licon1->minW + rules->diff->minOLSlicon1) + rules->licon1->minSP
        fdrnSP = devInfo->drnW + 2*devInfo->gateSPdrn
        ; calculate li1 Length
        srcNumConts = 1 + fix( (fw - rules->licon1->minW -
          2*rules->li1->minOLSlicon1)/
          (rules->licon1->minW + rules->licon1->minSP) )
        srcLength = rules->licon1->minW + 2*rules->li1->minOLSlicon1 +
          (srcNumConts - 1)*(rules->licon1->minW + rules->licon1->minSP)

        ; create the gates
        ;-----------------------------
        gateX = 0.0

        for( finger 1 nf
          rodCreateRect(
            ?cvId     cv
            ?name     sprintf( nil "gate%d" finger )
            ?layer    rules->poly->layer
            ?width    polyWidth
            ?length   fw + 2*(polyWidth + devInfo->gateSPdrn + 0.5)
            ?origin   gateX : -(polyWidth + devInfo->gateSPdrn + 0.5)
          )
          if( oddp(finger) then
            ; create the double finger gate connections
            rodCreateRect(
              ?cvId     cv
              ?name     sprintf( nil "gateTop%d" finger )
              ?layer    rules->poly->layer
              ?width    2*polyWidth + fdrnSP
              ?length   polyWidth
            )
            rodAlign(
              ?alignObj     rodGetObj(sprintf(nil "gateTop%d" finger) cv)
              ?alignHandle  "upperLeft"
              ?refObj       rodGetObj(sprintf( nil "gate%d" finger ) cv)
              ?refHandle    "upperLeft"
            )
            rodCreateRect(
              ?cvId     cv
              ?name     sprintf( nil "gateBot%d" finger )
              ?layer    rules->poly->layer
              ?width    2*polyWidth + fdrnSP
              ?length   polyWidth
            )
            rodAlign(
              ?alignObj     rodGetObj(sprintf(nil "gateBot%d" finger) cv)
              ?alignHandle  "lowerLeft"
              ?refObj       rodGetObj(sprintf( nil "gate%d" finger ) cv)
              ?refHandle    "lowerLeft"
            )
            gateX = gateX + polyWidth + fdrnSP
          else
            gateX = gateX + polyWidth + fsrcSP
          ); if odd finger
        ); for 1 to nf

        ; create sources
        ;-----------------------------
        rodCreateRect(
          ?cvId   cv
          ?name   "active1"
          ?layer  rules->diff->layer
          ?termName "s"
          ?termIOType "inputOutput"
          ?width  2*rules->diff->minOLSlicon1 + rules->licon1->minW + devInfo->srcOLgate
          ?length fw
          ?origin 0.0 - (rules->licon1->minW + 2*rules->licon1->minOLSlicon1) : 0.00
        )
        ; create the srcContact
        rodCreatePath(
          ?cvId     cv
          ?name     "srcCont1"
          ?layer    rules->li1->layer
          ?termName "s"
          ?termIOType "inputOutput"
          ?width    rules->licon1->minW + 2*rules->li1->minOLSlicon1
          ?pts      list(0:0 0:srcLength)
          ?subRect list(
              list(
                ?layer        rules->licon1->layer
                ?length       rules->licon1->minW
                ?width        rules->licon1->minW
                ?space        rules->licon1->minSP
                ?gap          "minimum"
                ?endOffset    -rules->li1->minOLSlicon1
                ?beginOffset  -rules->li1->minOLSlicon1
              ))
        )
        rodAlign(
          ?alignObj     rodGetObj("srcCont1" cv)
          ?alignHandle  "lowerLeft"
          ?refObj       rodGetObj("active1" cv)
          ?refHandle    "lowerLeft"
          ?xSep         rules->diff->minOLSlicon1 - rules->li1->minOLLlicon1
          ?ySep         round((0.5*(fw-srcLength))/grid)*grid
        )
        rodCreateRect(
          ?cvId     cv
          ?name     "srcPin1"
          ?layer    list( rules->li1->pinlayer rules->li1->pinpurpose )
          ?width    rodGetObj("srcCont1" cv)->width
          ?length   rodGetObj("srcCont1" cv)->length
          ?netName  "s"
          ?termName "s"
          ?termIOType "inputOutput"
          ?pin      t
          ?pinLabel t
          ?pinLabelHeight round(0.25*rodGetObj("srcCont1" cv)->width/grid)*grid
          ?pinLabelLayer  list( rules->li1->layer "label")
          ?pinLabelFont   "stick"
        )
        rodAlign(
          ?alignObj     rodGetObj("srcPin1" cv)
          ?alignHandle  "lowerLeft"
          ?refObj       rodGetObj("srcCont1" cv)
          ?refHandle    "lowerLeft"
        )

        when( nf > 2
          for( finger 2 nf-1
            when( evenp(finger)
              rodCreateRect(
                ?cvId   cv
                ?name   sprintf( nil "active%d" finger )
                ?layer  rules->diff->layer
                ?termName "s"
                ?termIOType "inputOutput"
                ?width  2*(rules->diff->minOLSlicon1 + rules->licon1->minW + devInfo->srcOLgate) +
                            rules->licon1->minSP
                ?length fw
              )
              rodAlign(
                ?alignObj     rodGetObj(sprintf( nil "active%d" finger ) cv)
                ?alignHandle  "lowerLeft"
                ?refObj       rodGetObj(sprintf( nil "gate%d" finger ) cv)
                ?refHandle    "lowerLeft"
                ?xSep         polyWidth - devInfo->srcOLgate
                ?ySep         polyWidth + devInfo->gateSPdrn + 0.5
              )
              ; create the srcContact
              rodCreatePath(
                ?cvId     cv
                ?name     sprintf( nil "srcCont%d" finger )
                ?layer    rules->li1->layer
                ?termName "s"
                ?termIOType "inputOutput"
                ?width    2*(rules->licon1->minW + rules->li1->minOLSlicon1) + rules->licon1->minSP
                ?pts      list(0:0 0:srcLength)
                ?subRect list(
                    list(
                      ?layer        rules->licon1->layer
                      ?length       rules->licon1->minW
                      ?width        rules->licon1->minW
                      ?space        rules->licon1->minSP
                      ?gap          "minimum"
                      ?endOffset    -rules->li1->minOLSlicon1
                      ?beginOffset  -rules->li1->minOLSlicon1
                      ?sep          -0.5*(rules->licon1->minW + rules->licon1->minSP)
                    )
                    list(
                      ?layer        rules->licon1->layer
                      ?length       rules->licon1->minW
                      ?width        rules->licon1->minW
                      ?space        rules->licon1->minSP
                      ?gap          "minimum"
                      ?endOffset    -rules->li1->minOLSlicon1
                      ?beginOffset  -rules->li1->minOLSlicon1
                      ?sep          0.5*(rules->licon1->minW + rules->licon1->minSP)
                    )
                  )
              )
              rodAlign(
                ?alignObj     rodGetObj(sprintf(nil "srcCont%d" finger) cv)
                ?alignHandle  "lowerLeft"
                ?refObj       rodGetObj(sprintf(nil "active%d" finger) cv)
                ?refHandle    "lowerLeft"
                ?xSep         rules->diff->minOLSlicon1 + devInfo->srcOLgate - rules->li1->minOLLlicon1
                ?ySep         round((0.5*(fw-srcLength))/grid)*grid
              )
              rodCreateRect(
                ?cvId     cv
                ?name     sprintf( nil "srcPin%d" finger )
                ?layer    list( rules->li1->pinlayer rules->li1->pinpurpose )
                ?width    rodGetObj(sprintf(nil "srcCont%d" finger) cv)->width
                ?length   rodGetObj(sprintf(nil "srcCont%d" finger) cv)->length
                ?netName  "s"
                ?termName "s"
                ?termIOType "inputOutput"
                ?pin      t
                ?pinLabel t
                ?pinLabelHeight round(0.25*rodGetObj(sprintf(nil "srcCont%d" finger) cv)->width/grid)*grid
                ?pinLabelLayer  list( rules->li1->layer "label")
                ?pinLabelFont   "stick"
              )
              rodAlign(
                ?alignObj     rodGetObj(sprintf( nil "srcPin%d" finger ) cv)
                ?alignHandle  "lowerLeft"
                ?refObj       rodGetObj(sprintf(nil "srcCont%d" finger) cv)
                ?refHandle    "lowerLeft"
              )
            ); when even finger
          ); for finger 2 to nf-1
        ); when nf > 2
        when( evenp(nf)
          rodCreateRect(
            ?cvId   cv
            ?name   sprintf( nil "active%d" nf )
            ?layer  rules->diff->layer
            ?width  2*rules->diff->minOLSlicon1 + rules->licon1->minW + devInfo->srcOLgate
            ?length fw
          )
          rodAlign(
            ?alignObj     rodGetObj(sprintf( nil "active%d" nf ) cv)
            ?alignHandle  "lowerRight"
            ?refObj       rodGetObj(sprintf( nil "gate%d" nf ) cv)
            ?refHandle    "lowerRight"
            ?xSep         2*rules->diff->minOLSlicon1 + rules->licon1->minW
            ?ySep         polyWidth + devInfo->gateSPdrn + 0.5
          )
          ; create the srcContact
          rodCreatePath(
            ?cvId     cv
            ?name     sprintf( nil "srcCont%d" nf )
            ?layer    rules->li1->layer
            ?termName "s"
            ?termIOType "inputOutput"
            ?width    rules->licon1->minW + 2*rules->li1->minOLSlicon1
            ?pts      list(0:0 0:srcLength)
            ?subRect list(
                list(
                  ?layer        rules->licon1->layer
                  ?length       rules->licon1->minW
                  ?width        rules->licon1->minW
                  ?space        rules->licon1->minSP
                  ?gap          "minimum"
                  ?endOffset    -rules->li1->minOLSlicon1
                  ?beginOffset  -rules->li1->minOLSlicon1
                ))
          )
          rodAlign(
            ?alignObj     rodGetObj(sprintf( nil "srcCont%d" nf ) cv)
            ?alignHandle  "lowerRight"
            ?refObj       rodGetObj(sprintf( nil "active%d" nf ) cv)
            ?refHandle    "lowerRight"
            ?xSep         -rules->diff->minOLSlicon1 + rules->li1->minOLLlicon1
            ?ySep         round((0.5*(fw-srcLength))/grid)*grid
          )
          rodCreateRect(
            ?cvId     cv
            ?name     sprintf( nil "srcPin%d" nf )
            ?layer    list( rules->li1->pinlayer rules->li1->pinpurpose )
            ?width    rodGetObj(sprintf( nil "srcCont%d" nf ) cv)->width
            ?length   rodGetObj(sprintf( nil "srcCont%d" nf ) cv)->length
            ?netName  "s"
            ?termName "s"
            ?termIOType "inputOutput"
            ?pin      t
            ?pinLabel t
            ?pinLabelHeight round(0.25*rodGetObj(sprintf( nil "srcCont%d" nf ) cv)->width/grid)*grid
            ?pinLabelLayer  list( rules->li1->layer "label")
            ?pinLabelFont   "stick"
          )
          rodAlign(
            ?alignObj     rodGetObj(sprintf( nil "srcPin%d" nf ) cv)
            ?alignHandle  "lowerLeft"
            ?refObj       rodGetObj(sprintf( nil "srcCont%d" nf ) cv)
            ?refHandle    "lowerLeft"
          )
        ); when even nf

        ; create drains, implants, & nwells
        ;-----------------------------
        ; drain points based at lowerCenter
        minDrnW = devInfo->drnW
        drnBevW = devInfo->drnBevW
        drainPoints = list(0:0
          0.5*minDrnW:0
          0.5*minDrnW + drnBevW:drnBevW
          0.5*minDrnW + drnBevW:fw - drnBevW
          0.5*minDrnW:fw
          -0.5*minDrnW:fw
          -0.5*minDrnW - drnBevW:fw - drnBevW
          -0.5*minDrnW - drnBevW:drnBevW
          -0.5*minDrnW:0
        )
        dnwXOLdrn = devInfo->dnwellXOLdrn
        dnwYOLdrn = devInfo->dnwellYOLdrn
        dnwBevW = devInfo->dnwellBevW
        dnwellPoints = list(0:0
          0.5*minDrnW + dnwXOLdrn:0
          0.5*minDrnW + dnwXOLdrn + dnwellBevW:dnwellBevW
          0.5*minDrnW + dnwXOLdrn + dnwellBevW:fw + 2*dnwYOLdrn - dnwellBevW
          0.5*minDrnW + dnwXOLdrn:fw + 2*dnwYOLdrn
          -0.5*minDrnW - dnwXOLdrn:fw + 2*dnwYOLdrn
          -0.5*minDrnW - dnwXOLdrn - dnwellBevW:fw + 2*dnwYOLdrn - dnwellBevW
          -0.5*minDrnW - dnwXOLdrn - dnwellBevW:dnwellBevW
          -0.5*minDrnW - dnwXOLdrn:0
        )
        ; calculate li1 Length
        drnNumConts = 1 + fix( (fw - 2*devInfo->drnBevW - rules->licon1->minW -
          2*rules->tap->minOLLisoTapLicon1)/
          (rules->licon1->minW + rules->licon1->minSP) )
        drnLength = rules->licon1->minW + 2*rules->li1->minOLSlicon1 +
          (drnNumConts - 1)*(rules->licon1->minW + rules->licon1->minSP)
        for( finger 1 nf
          when( oddp(finger)
            rodCreatePolygon(
              ?cvId   cv
              ?name   sprintf(nil "drain%d" finger)
              ?layer  rules->diff->layer
              ?pts    drainPoints
            )
            rodAlign(
              ?alignObj     rodGetObj(sprintf(nil "drain%d" finger) cv)
              ?alignHandle  "lowerLeft"
              ?refObj       rodGetObj(sprintf( nil "active%d" finger) cv)||rodGetObj(sprintf( nil "active%d" finger-1) cv)
              ?refHandle    "lowerRight"
              ?xSep         devInfo->gateSPdrn
              ?ySep         polyWidth + devInfo->gateSPdrn + 0.5
            )
            ; drain dnwell
            rodCreatePolygon(
              ?cvId   cv
              ?name   sprintf( nil "dnwell%d" finger )
              ?layer  rules->dnwell->layer
              ?pts    dnwellPoints
            )
            rodAlign(
              ?alignObj     rodGetObj(sprintf(nil "dnwell%d" finger) cv)
              ?alignHandle  "centerCenter"
              ?refObj       rodGetObj(sprintf(nil "drain%d" finger) cv)
              ?refHandle    "centerCenter"
            )
            ; drain nwell
            rodCreateRect(
              ?cvId   cv
              ?name   sprintf( nil "drainNwell%d" finger )
              ?layer  rules->nwell->layer
              ?width  rodGetObj(sprintf(nil "drain%d" finger) cv)->width + 2*devInfo->nwellXOLdrn
              ?length rodGetObj(sprintf(nil "drain%d" finger) cv)->length + 2*devInfo->nwellYOLdrn
            )
            rodAlign(
              ?alignObj     rodGetObj(sprintf(nil "drainNwell%d" finger) cv)
              ?alignHandle  "centerCenter"
              ?refObj       rodGetObj(sprintf(nil "drain%d" finger) cv)
              ?refHandle    "centerCenter"
            )
            ; lvtn
            rodCreateRect(
              ?cvId   cv
              ?name   sprintf( nil "lvtn%d" finger )
              ?layer  rules->lvtn->layer
              ?width  rodGetObj(sprintf(nil "drain%d" finger) cv)->width + 2*devInfo->lvtnXOLdrn
              ?length rodGetObj(sprintf(nil "drain%d" finger) cv)->length + 2*devInfo->lvtnYOLdrn
            )
            rodAlign(
              ?alignObj     rodGetObj(sprintf(nil "lvtn%d" finger) cv)
              ?alignHandle  "centerCenter"
              ?refObj       rodGetObj(sprintf(nil "drain%d" finger) cv)
              ?refHandle    "centerCenter"
            )
            ; pwbm
            rodCreateRect(
              ?cvId   cv
              ?name   sprintf( nil "pwbm%d" finger )
              ?layer  "pwbm"
              ?width  rodGetObj(sprintf(nil "dnwell%d" finger) cv)->width + 2*devInfo->pwbmXOLdnw
              ?length rodGetObj(sprintf(nil "dnwell%d" finger) cv)->length + 2*devInfo->pwbmYOLdnw
            )
            rodAlign(
              ?alignObj     rodGetObj(sprintf(nil "pwbm%d" finger) cv)
              ?alignHandle  "centerCenter"
              ?refObj       rodGetObj(sprintf(nil "dnwell%d" finger) cv)
              ?refHandle    "centerCenter"
            )
            ; create the drnContact
            rodCreatePath(
              ?cvId     cv
              ?name     sprintf( nil "drnCont%d" finger )
              ?layer    rules->li1->layer
              ?termName "d"
              ?termIOType "inputOutput"
              ?width    2*(rules->licon1->minW + devInfo->drnOLlicon1) + rules->licon1->minSP
              ?pts      list(0:0 0:drnLength)
              ?subRect list( list(
                ?layer        rules->licon1->layer
                ?length       rules->licon1->minW
                ?width        rules->licon1->minW
                ?space        rules->licon1->minSP
                ?gap          "minimum"
                ?endOffset    -devInfo->drnOLlicon1
                ?beginOffset  -devInfo->drnOLlicon1
              ))
            )
            rodAlign(
              ?alignObj     rodGetObj(sprintf( nil "drnCont%d" finger ) cv)
              ?alignHandle  "lowerCenter"
              ?refObj       rodGetObj(sprintf( nil "drain%d" finger ) cv)
              ?refHandle    "lowerCenter"
              ?ySep         round((0.5*(fw-drnLength))/grid)*grid
            )
            rodCreateRect(
              ?cvId     cv
              ?name     sprintf( nil "drnPin%d" finger )
              ?layer    list( rules->li1->pinlayer rules->li1->pinpurpose )
              ?width    rodGetObj(sprintf( nil "drnCont%d" finger ) cv)->width
              ?length   rodGetObj(sprintf( nil "drnCont%d" finger ) cv)->length
              ?netName  "d"
              ?termName "d"
              ?termIOType "inputOutput"
              ?pin      t
              ?pinLabel t
              ?pinLabelHeight round(0.25*rodGetObj(sprintf( nil "drnCont%d" finger ) cv)->width/grid)*grid
              ?pinLabelLayer  list( rules->li1->layer "label")
              ?pinLabelFont   "stick"
            )
            rodAlign(
              ?alignObj     rodGetObj(sprintf( nil "drnPin%d" finger ) cv)
              ?alignHandle  "lowerLeft"
              ?refObj       rodGetObj(sprintf( nil "drnCont%d" finger ) cv)
              ?refHandle    "lowerLeft"
            )

          ); when odd finger
        ); for fingers

        ; create actImp & marking layer (ext drain)
        ;-----------------------------
        ; get the edges of the active diff
        allActiveShapes = setof( shape cv->shapes shape->layerName == rules->diff->layer )
        activeTopEdge = topEdge( car(allActiveShapes)->bBox )
        activeLftEdge = leftEdge( car(allActiveShapes)->bBox )
        activeBotEdge = bottomEdge( car(allActiveShapes)->bBox )
        activeRhtEdge = rightEdge( car(allActiveShapes)->bBox )
        foreach( activeShape allActiveShapes
          activeTopEdge = max(activeTopEdge topEdge( activeShape->bBox ))
          activeLftEdge = min(activeLftEdge leftEdge( activeShape->bBox ))
          activeBotEdge = min(activeBotEdge bottomEdge( activeShape->bBox ))
          activeRhtEdge = max(activeRhtEdge rightEdge( activeShape->bBox ))
        ); foreach activeShape
        activeTotalW = activeRhtEdge - activeLftEdge
        activeTotalL = activeTopEdge - activeBotEdge
        ; get the edges of the poly
        allPolyShapes = setof( shape cv->shapes shape->layerName == rules->poly->layer )
        polyTopEdge = topEdge( car(allPolyShapes)->bBox )
        polyLftEdge = leftEdge( car(allPolyShapes)->bBox )
        polyBotEdge = bottomEdge( car(allPolyShapes)->bBox )
        polyRhtEdge = rightEdge( car(allPolyShapes)->bBox )
        foreach( polyShape allPolyShapes
          polyTopEdge = max(polyTopEdge topEdge( polyShape->bBox ))
          polyLftEdge = min(polyLftEdge leftEdge( polyShape->bBox ))
          polyBotEdge = min(polyBotEdge bottomEdge( polyShape->bBox ))
          polyRhtEdge = max(polyRhtEdge rightEdge( polyShape->bBox ))
        ); foreach polyShape
        polyTotalW = polyRhtEdge - polyLftEdge
        polyTotalL = polyTopEdge - polyBotEdge

        rodCreateRect(
          ?cvId   cv
          ?name   "extDrain"
          ?layer  devInfo->mrkLay
          ?width  activeTotalW
          ?length activeTotalL
        )
        rodAlign(
          ?alignObj     rodGetObj("extDrain" cv)
          ?alignHandle  "lowerLeft"
          ?refObj       rodGetObj("active1" cv)
          ?refHandle    "lowerLeft"
        )
        rodCreateRect(
          ?cvId   cv
          ?name   "actImplant"
          ?layer  actImp->layer
          ?width  activeTotalW + 2*actImp->minOLtap
          ?length polyTotalL
        )
        rodAlign(
          ?alignObj     rodGetObj("actImplant" cv)
          ?alignHandle  "lowerLeft"
          ?refObj       rodGetObj("active1" cv)
          ?refHandle    "lowerLeft"
          ?xSep         -actImp->minOLtap
          ?ySep         -(polyWidth + devInfo->gateSPdrn + 0.5)
        )

        ; create 20V marking layer (only over active as the body might want to be a diff potential)
        ;-----------------------------
        rodCreateRect(
          ?cvId   cv
          ?name   "hvMarker"
          ?layer  rules->uhvi->layer
          ?width  activeTotalW
          ?length activeTotalL
        )
        rodAlign(
          ?alignObj     rodGetObj("hvMarker" cv)
          ?alignHandle  "lowerLeft"
          ?refObj       rodGetObj("active1" cv)
          ?refHandle    "lowerLeft"
        )

        ; create gate contacts
        ;-----------------------------
        unless( gateCnt == "none"

          ; calculate poly (gateCnt) for gate contacts
          gateCntL = max( 2*rules->poly->minOLSlicon1 + rules->licon1->minW,
            polyWidth )
          gateCntW = 2*rules->poly->minOLLlicon1 + rules->licon1->minW
          ; calculate number of gate contacts and metal length
          ; want to keep li1 within the gate cont poly
          gateNumCnts = 1 + fix( (gateCntL - 2*max(rules->poly->minOLSlicon1,rules->li1->minOLSlicon1) -
            rules->licon1->minW) / (rules->licon1->minW + rules->licon1->minSP))
          gateCntMetL = 2*rules->li1->minOLSlicon1 + rules->licon1->minW +
            (gateNumCnts-1)*(rules->licon1->minW + rules->licon1->minSP)
          gateCntMetW = 2*rules->li1->minOLLlicon1 + rules->licon1->minW
          gateSPgateCnt = gateCntExt + max( rules->poly->minSPdiff,
            rules->npc->minSPgate + (rules->npc->minOLpcont - rules->poly->minOLLlicon1)
            rules->licon1->minPcontSPdiff - rules->poly->minOLLlicon1 
            max(actImp->minOLdiff devInfo->rules->impOLsrc) + (rules->licon1->minPcontSPpsdm - rules->poly->minOLLlicon1) )

          ; extension of gate endcap (if needed)
          endCapExt = 0.0
          if( gateSPgateCnt > rules->poly->minOLdiff then
            endCapExt = gateSPgateCnt - rules->poly->minOLdiff
          ); if gateSPgateCnt > endcap

          when( gateCnt == "Top" || gateCnt == "Both"
            for( finger 1 nf
              rodCreateRect(
                ?cvId   cv
                ?name   sprintf(nil "gateTopCntPoly%d" finger)
                ?layer  rules->poly->layer
                ?width  gateCntL
                ?length gateCntW
              )
              rodAlign(
                ?alignObj     rodGetObj(sprintf(nil "gateTopCntPoly%d" finger) cv)
                ?alignHandle  "lowerLeft"
                ?refObj       rodGetObj(sprintf(nil "gate%d" finger) cv )
                ?refHandle    "upperLeft"
                ?ySep         -rules->poly->minOLdiff + gateSPgateCnt
              )
              rodCreateRect(
                ?cvId   cv
                ?name   sprintf(nil "gateTopCntImp%d" finger)
                ?layer  rules->npc->layer
                ?width  2*(rules->npc->minOLpcont - rules->poly->minOLLlicon1) + gateCntL
                ?length 2*(rules->npc->minOLpcont - rules->poly->minOLLlicon1) + gateCntW
              )
              rodAlign(
                ?alignObj     rodGetObj(sprintf( nil "gateTopCntImp%d" finger) cv)
                ?alignHandle  "centerCenter"
                ?refObj       rodGetObj(sprintf( nil "gateTopCntPoly%d" finger) cv)
                ?refHandle    "centerCenter"
              )
              when( endCapExt > 0.0
                rodCreateRect(
                  ?cvId   cv
                  ?name   sprintf(nil "gateTopExt%d" finger)
                  ?layer  rules->poly->layer
                  ?width  polyWidth
                  ?length endCapExt
                )
                rodAlign(
                  ?alignObj     rodGetObj( sprintf(nil "gateTopExt%d" finger) cv )
                  ?alignHandle  "lowerLeft"
                  ?refObj       rodGetObj( sprintf(nil "gate%d" finger) cv )
                  ?refHandle    "upperLeft"
                )
              ); when endCapExt > 0

              rodCreatePath(
                ?cvId     cv
                ?name     sprintf(nil "gateTopMetCnt%d" finger)
                ?layer    rules->li1->layer
                ?width    gateCntMetW
                ?pts      list(0:0 gateCntMetL:0)
                ?subRect list( list(
                  ?layer        rules->licon1->layer
                  ?length       rules->licon1->minW
                  ?width        rules->licon1->minW
                  ?space        rules->licon1->minSP
                  ?gap          "minimum"
                  ?endOffset    -rules->li1->minOLSlicon1
                  ?beginOffset  -rules->li1->minOLSlicon1
                ))
              )
              rodAlign(
                ?alignObj     rodGetObj( sprintf(nil "gateTopMetCnt%d" finger) cv )
                ?alignHandle  "centerLeft"
                ?refObj       rodGetObj(sprintf( nil "gateTopCntPoly%d" finger) cv)
                ?refHandle    "centerLeft"
                ?xSep         round((0.5*(gateCntL - gateCntMetL))/grid)*grid
              )
              rodCreateRect(
                ?cvId     cv
                ?name     sprintf(nil "gateTopPin%d" finger)
                ?layer    list( rules->li1->pinlayer rules->li1->pinpurpose )
                ?width    rodGetObj(sprintf( nil "gateTopMetCnt%d" finger) cv)->width
                ?length   rodGetObj(sprintf( nil "gateTopMetCnt%d" finger) cv)->length
                ?netName  "g"
                ?termName "g"
                ?termIOType "input"
                ?pin      t
                ?pinLabel t
                ?pinLabelHeight round(0.25*gateCntMetW/grid)*grid
                ?pinLabelLayer  list( rules->li1->layer "label")
                ?pinLabelFont   "stick"
              )
              rodAlign(
                ?alignObj     rodGetObj( sprintf(nil "gateTopPin%d" finger) cv )
                ?alignHandle  "lowerLeft"
                ?refObj       rodGetObj( sprintf(nil "gateTopMetCnt%d" finger) cv )
                ?refHandle    "lowerLeft"
              )

            ); for each finger
          ); when gateCnt Top

          when( gateCnt == "Bottom" || gateCnt == "Both"
            for( finger 1 nf
              rodCreateRect(
                ?cvId   cv
                ?name   sprintf(nil "gateBotCntPoly%d" finger)
                ?layer  rules->poly->layer
                ?width  gateCntL
                ?length gateCntW
              )
              rodAlign(
                ?alignObj     rodGetObj(sprintf(nil "gateBotCntPoly%d" finger) cv)
                ?alignHandle  "upperLeft"
                ?refObj       rodGetObj(sprintf(nil "gate%d" finger) cv )
                ?refHandle    "lowerLeft"
                ?ySep         rules->poly->minOLdiff - gateSPgateCnt
              )
              rodCreateRect(
                ?cvId   cv
                ?name   sprintf(nil "gateBotCntImp%d" finger)
                ?layer  rules->npc->layer
                ?width  2*(rules->npc->minOLpcont - rules->poly->minOLLlicon1) + gateCntL
                ?length 2*(rules->npc->minOLpcont - rules->poly->minOLLlicon1) + gateCntW
              )
              rodAlign(
                ?alignObj     rodGetObj(sprintf( nil "gateBotCntImp%d" finger) cv)
                ?alignHandle  "centerCenter"
                ?refObj       rodGetObj(sprintf( nil "gateBotCntPoly%d" finger) cv)
                ?refHandle    "centerCenter"
              )
              when( endCapExt > 0.0
                rodCreateRect(
                  ?cvId   cv
                  ?name   sprintf(nil "gateBotExt%d" finger)
                  ?layer  rules->poly->layer
                  ?width  polyWidth
                  ?length endCapExt
                )
                rodAlign(
                  ?alignObj     rodGetObj( sprintf(nil "gateBotExt%d" finger) cv )
                  ?alignHandle  "upperLeft"
                  ?refObj       rodGetObj( sprintf(nil "gate%d" finger) cv )
                  ?refHandle    "lowerLeft"
                )
              ); when endCapExt > 0

              rodCreatePath(
                ?cvId     cv
                ?name     sprintf(nil "gateBotMetCnt%d" finger)
                ?layer    rules->li1->layer
                ?width    gateCntMetW
                ?pts      list(0:0 gateCntMetL:0)
                ?subRect list( list(
                  ?layer        rules->licon1->layer
                  ?length       rules->licon1->minW
                  ?width        rules->licon1->minW
                  ?space        rules->licon1->minSP
                  ?gap          "minimum"
                  ?endOffset    -rules->li1->minOLSlicon1
                  ?beginOffset  -rules->li1->minOLSlicon1
                ))
              )
              rodAlign(
                ?alignObj     rodGetObj( sprintf(nil "gateBotMetCnt%d" finger) cv )
                ?alignHandle  "centerLeft"
                ?refObj       rodGetObj(sprintf( nil "gateBotCntPoly%d" finger) cv)
                ?refHandle    "centerLeft"
                ?xSep         round((0.5*(gateCntL - gateCntMetL))/grid)*grid
              )
              rodCreateRect(
                ?cvId     cv
                ?name     sprintf(nil "gateBotPin%d" finger)
                ?layer    list( rules->li1->pinlayer rules->li1->pinpurpose )
                ?width    rodGetObj(sprintf( nil "gateBotMetCnt%d" finger) cv)->width
                ?length   rodGetObj(sprintf( nil "gateBotMetCnt%d" finger) cv)->length
                ?netName  "g"
                ?termName "g"
                ?termIOType "input"
                ?pin      t
                ?pinLabel t
                ?pinLabelHeight round(0.25*gateCntMetW/grid)*grid
                ?pinLabelLayer  list( rules->li1->layer "label")
                ?pinLabelFont   "stick"
              )
              rodAlign(
                ?alignObj     rodGetObj( sprintf(nil "gateBotPin%d" finger) cv )
                ?alignHandle  "lowerLeft"
                ?refObj       rodGetObj( sprintf(nil "gateBotMetCnt%d" finger) cv )
                ?refHandle    "lowerLeft"
              )

            ); for each finger
          ); when gateCnt Bot

        ); unless gateCnt none

        ; create gate pins when no gate contact
        ;-----------------------------
        when( gateCnt == "none"
          for( finger 1 nf
            rodCreateRect(
              ?cvId   cv
              ?name   sprintf(nil "gateTopPin%d" finger)
              ?layer  list( rules->poly->pinlayer rules->poly->pinpurpose )
              ?width  polyWidth
              ?length rules->poly->minOLdiff
              ?netName  "g"
              ?termName "g"
              ?termIOType "input"
              ?pin      t
              ?pinLabel t
              ?pinLabelHeight round(0.25*rules->poly->minOLdiff/grid)*grid
              ?pinLabelLayer  list( rules->poly->layer "label")
              ?pinLabelFont   "stick"
            )
            rodAlign(
              ?alignObj     rodGetObj( sprintf(nil "gateTopPin%d" finger) cv )
              ?alignHandle  "upperLeft"
              ?refObj       rodGetObj( sprintf(nil "gate%d" finger) cv)
              ?refHandle    "upperLeft"
            )
            rodCreateRect(
              ?cvId   cv
              ?name   sprintf(nil "gateBotPin%d" finger)
              ?layer  list( rules->poly->pinlayer rules->poly->pinpurpose )
              ?width  polyWidth
              ?length rules->poly->minOLdiff
              ?netName  "g"
              ?termName "g"
              ?termIOType "input"
              ?pin      t
              ?pinLabel t
              ?pinLabelHeight round(0.25*rules->poly->minOLdiff/grid)*grid
              ?pinLabelLayer  list( rules->poly->layer "label")
              ?pinLabelFont   "stick"
            )
            rodAlign(
              ?alignObj     rodGetObj( sprintf(nil "gateBotPin%d" finger) cv )
              ?alignHandle  "lowerLeft"
              ?refObj       rodGetObj( sprintf(nil "gate%d" finger) cv)
              ?refHandle    "lowerLeft"
            )
          ); for nf
        ); when no gateCnt

        ; create the taps
        ;-----------------------------
        tapImpOLtap = tapImp->minOLtap

        ; best to go with max overlap contact so the corners will line up
        tapOLcont = max(rules->tap->minOLLisoTapLicon1 rules->tap->minOLSisoTapLicon1)
        tapMetOLcont = max(rules->li1->minOLLlicon1 rules->li1->minOLSlicon1)
        tapW = max(rules->tap->minW  2*tapOLcont + rules->licon1->minW )

        ; do some basic calculations for the tap

        ; for left & right taps, the spacing will be from the mos diff or nwell
        taplSP  = max( rules->diff->minSPhvtap
          actImp->minOLdiff + actImp->minSPdiff
          tapImp->minOLtap + actImp->minSPdiff )
        if( evenp(nf) then
          taprSP  = max( rules->diff->minSPhvtap
            actImp->minOLdiff + actImp->minSPdiff
            tapImp->minOLtap + actImp->minSPdiff )
        else
          if( rexMatchp("^pmos" devInfo->deviceName) then
            taprSP  = max( rules->nwell->minOLhvtap + devInfo->rules->wellOLdrn
              devInfo->rules->wellSPtap + devInfo->rules->wellOLdrn
              actImp->minOLdiff + actImp->minSPdiff
              tapImp->minOLtap + actImp->minSPdiff )
          else
            taprSP  = max( rules->tap->minSPnwell + devInfo->rules->wellOLdrn
              actImp->minOLdiff + actImp->minSPdiff
              tapImp->minOLtap + actImp->minSPdiff )
          ); if pmos
        ); if even nf

        ; for top & bottom taps, the spacing could be from the mos diff, gates, or poly cont
        ; in the end, the spacing will be from mos diff to tap edge
        taptSP = tapbSP = max( rules->diff->minSPhvtap
          if( rexMatchp("^pmos" devInfo->deviceName) then
            max( rules->nwell->minOLhvtap + devInfo->rules->wellOLdrn
              devInfo->rules->wellSPtap + devInfo->rules->wellOLdrn )
          else
            rules->tap->minSPnwell + devInfo->rules->wellOLdrn
            devInfo->rules->wellSPtap + devInfo->rules->wellOLdrn
          )
          actImp->minOLdiff + actImp->minSPdiff
          tapImp->minOLtap + actImp->minSPdiff
          rules->tap->minSPpoly + rules->poly->minOLdiff
          rules->licon1->minDcontSPpoly - rules->tap->minOLSisoTapLicon1 + rules->poly->minOLdiff )

        when( gateCnt == "Top" || gateCnt == "Both"
          taptSP = max( taptSP gateSPgateCnt + gateCntW + rules->tap->minSPpoly )
          when( tapTopCnt
            taptSP = max( taptSP
              gateSPgateCnt + gateCntW - 0.5*(gateCntW - gateCntMetW) + rules->li1->minSP + (tapMetOLcont - tapOLcont)
              gateSPgateCnt + gateCntW + (rules->npc->minOLpcont - rules->poly->minOLLlicon1) +
                rules->licon1->taplicon1SPnpc - rules->tap->minOLSisoTapLicon1
              gateSPgateCnt + gateCntW - 0.5*(gateCntW - gateCntMetW) + rules->licon1->minPcontSPdiff
              gateSPgateCnt + gateCntW - 0.5*(gateCntW - gateCntMetW) + rules->licon1->minPcontSPpsdm + tapImp->minOLtap )
          )
        ); when top gateCnt
        when( gateCnt == "Bottom" || gateCnt == "Both"
          tapbSP = max( tapbSP gateSPgateCnt + gateCntW + rules->tap->minSPpoly )
          when( tapBottomCnt
            tapbSP = max( tapbSP
              gateSPgateCnt + gateCntW - 0.5*(gateCntW - gateCntMetW) + rules->li1->minSP + (tapMetOLcont - tapOLcont)
              gateSPgateCnt + gateCntW + (rules->npc->minOLpcont - rules->poly->minOLLlicon1) +
                rules->licon1->taplicon1SPnpc - rules->tap->minOLSisoTapLicon1
              gateSPgateCnt + gateCntW - 0.5*(gateCntW - gateCntMetW) + rules->licon1->minPcontSPdiff
              gateSPgateCnt + gateCntW - 0.5*(gateCntW - gateCntMetW) + rules->licon1->minPcontSPpsdm + tapImp->minOLtap )
          )
        ); when bottom gateCnt

        if( tapTop    then tapRhtAdjT = tapLftAdjT = tapW + taptSP else tapRhtAdjT = tapLftAdjT = 0.0 )
        if( tapLeft   then tapTopAdjL = tapBotAdjL = tapW + taplSP else tapTopAdjL = tapBotAdjL = 0.0 )
        if( tapBottom then tapRhtAdjB = tapLftAdjB = tapW + tapbSP else tapRhtAdjB = tapLftAdjB = 0.0 )
        if( tapRight  then tapTopAdjR = tapBotAdjR = tapW + taprSP else tapTopAdjR = tapBotAdjR = 0.0 )

        tapTopL = activeTotalW + tapTopAdjL + tapTopAdjR
        tapLftL = activeTotalL + tapLftAdjT + tapLftAdjB
        tapBotL = activeTotalW + tapBotAdjL + tapBotAdjR
        tapRhtL = activeTotalL + tapRhtAdjT + tapRhtAdjB

        tapEncPath = list( list( ?layer tapImp->layer ?enclosure -tapImpOLtap ) )
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

        ; create top tap
        if( tapTop then
          if( tapTopCnt then
            tapTopEncPath = append1( tapEncPath tapEncPathWithCnt )
            tapTopSubRect = append1( tapSubRect tapSubRectWithCnt )
          else
            tapTopEncPath = tapEncPath
            tapTopSubRect = tapSubRect
          ); end when tapTopCnt
          rodCreatePath(
            ?cvId cv
            ?name "tapTopPath"
            ?layer rules->tap->layer
            ?width tapW
            ?pts list(
              activeLftEdge-tapTopAdjL : activeTopEdge+taptSP+0.5*tapW
              activeRhtEdge+tapTopAdjR : activeTopEdge+taptSP+0.5*tapW
            )
            ?netName  "b"
            ?termName "b"
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
                        rodAddToY(rodAddToX(rodGetObj("tapTopPath" cv)->lowerLeft -pinAdj) -pinAdj)
                        rodAddToY(rodAddToX(rodGetObj("tapTopPath" cv)->upperRight pinAdj)  pinAdj)
                      )
              ?netName  "b"
              ?termName "b"
              ?termIOType "inputOutput"
              ?pin      t
              ?pinLabel t
              ?pinLabelHeight 0.5*tapW
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
          rodCreatePath(
            ?cvId cv
            ?name "tapRhtPath"
            ?layer rules->tap->layer
            ?width tapW
            ?pts list(
              activeRhtEdge+taprSP+0.5*tapW : activeBotEdge-tapRhtAdjB
              activeRhtEdge+taprSP+0.5*tapW : activeTopEdge+tapRhtAdjT
            )
            ?netName  "b"
            ?termName "b"
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
                        rodAddToY(rodAddToX(rodGetObj("tapRhtPath" cv)->lowerLeft -pinAdj) -pinAdj)
                        rodAddToY(rodAddToX(rodGetObj("tapRhtPath" cv)->upperRight pinAdj)  pinAdj)
                      )
              ?netName  "b"
              ?termName "b"
              ?termIOType "inputOutput"
              ?pin      t
              ?pinLabel t
              ?pinLabelHeight 0.5*tapW
              ?pinLabelLayer  list( rules->li1->layer "label")
              ?pinLabelFont   "stick"
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
          rodCreatePath(
            ?cvId cv
            ?name "tapBotPath"
            ?layer rules->tap->layer
            ?width tapW
            ?pts list(
              activeLftEdge-tapBotAdjL : activeBotEdge-tapbSP-0.5*tapW
              activeRhtEdge+tapBotAdjR : activeBotEdge-tapbSP-0.5*tapW
            )
            ?netName  "b"
            ?termName "b"
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
                        rodAddToY(rodAddToX(rodGetObj("tapBotPath" cv)->lowerLeft -pinAdj) -pinAdj)
                        rodAddToY(rodAddToX(rodGetObj("tapBotPath" cv)->upperRight pinAdj)  pinAdj)
                      )
              ?netName  "b"
              ?termName "b"
              ?termIOType "inputOutput"
              ?pin      t
              ?pinLabel t
              ?pinLabelHeight 0.5*tapW
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
          rodCreatePath(
            ?cvId cv
            ?name "tapLftPath"
            ?layer rules->tap->layer
            ?width tapW
            ?pts list(
              activeLftEdge-taplSP-0.5*tapW : activeBotEdge-tapLftAdjB
              activeLftEdge-taplSP-0.5*tapW : activeTopEdge+tapLftAdjT
            )
            ?netName  "b"
            ?termName "b"
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
                        rodAddToY(rodAddToX(rodGetObj("tapLftPath" cv)->lowerLeft -pinAdj) -pinAdj)
                        rodAddToY(rodAddToX(rodGetObj("tapLftPath" cv)->upperRight pinAdj)  pinAdj)
                      )
              ?netName  "b"
              ?termName "b"
              ?termIOType "inputOutput"
              ?pin      t
              ?pinLabel t
              ?pinLabelHeight 0.5*tapW
              ?pinLabelLayer  list( rules->li1->layer "label")
              ?pinLabelFont   "stick"
            )
          )
        ); end if tapLeft

        ; calculations for thick ox (tkkox/v5), nwell, and dnwell layers
        ;-----------------------------
        allDiffShapes = setof( shape cv->shapes (shape->objType != "label" && shape->lpp == list("diff" "drawing")))
        diffTopEdge = topEdge(    car(allDiffShapes)->bBox )
        diffLftEdge = leftEdge(   car(allDiffShapes)->bBox )
        diffBotEdge = bottomEdge( car(allDiffShapes)->bBox )
        diffRhtEdge = rightEdge(  car(allDiffShapes)->bBox )
        foreach( diffShape allDiffShapes
          diffTopEdge = max(diffTopEdge topEdge( diffShape->bBox ))
          diffLftEdge = min(diffLftEdge leftEdge( diffShape->bBox ))
          diffBotEdge = min(diffBotEdge bottomEdge( diffShape->bBox ))
          diffRhtEdge = max(diffRhtEdge rightEdge( diffShape->bBox ))
        ); foreach diffShape

        if( tapTop then
          if( rexMatchp("^pmos" devInfo->deviceName) then
            hvOLtop = nwellOLtop = max( rules->nwell->minOLhvtap rules->nwell->minOLdnwell
              rules->nwell->minOLdnwell + rules->dnwell->minOLipw - (rules->nwell->minOLhvtap + tapW) )
          else
            hvOLtop = rules->thkox->minOLtap
            nwellOLtop = rules->nwell->minOLhvtap
          )
        else
          if( rexMatchp("^pmos" devInfo->deviceName) then
            hvOLtop = nwellOLtop = max( rules->nwell->minOLhvdiff rules->nwell->minOLdnwell
              devInfo->rules->wellOLdrn + rules->dnwell->minOLipw + rules->nwell->minOLdnwell
              devInfo->rules->wellOLdrn + rules->nwell->minW )
          else
            hvOLtop = max( rules->thkox->minOLdiff rules->nwell->minOLhvdiff devInfo->rules->wellOLdrn )
            nwellOLtop = rules->nwell->minOLhvdiff
          )
        ); if tapTop
        hvTop = diffTopEdge + hvOLtop
        nwellTop = diffTopEdge + nwellOLtop

        if( tapBottom then
          if( rexMatchp("^pmos" devInfo->deviceName) then
            hvOLbot = nwellOLbot = max( rules->nwell->minOLhvtap rules->nwell->minOLdnwell
              rules->nwell->minOLdnwell + rules->dnwell->minOLipw - (rules->nwell->minOLhvtap + tapW) )
          else
            hvOLbot = rules->thkox->minOLtap
            nwellOLbot = max( rules->nwell->minOLhvtap rules->nwell->minOLdnwell )
          )
        else
          if( rexMatchp("^pmos" devInfo->deviceName) then
            hvOLbot = nwellOLbot = max( rules->nwell->minOLhvdiff rules->nwell->minOLdnwell
              devInfo->rules->wellOLdrn + rules->dnwell->minOLipw + rules->nwell->minOLdnwell
              devInfo->rules->wellOLdrn + rules->nwell->minW )
          else
            hvOLbot = max( rules->thkox->minOLdiff rules->nwell->minOLhvdiff devInfo->rules->wellOLdrn )
            nwellOLbot = rules->nwell->minOLhvdiff
          )
        ); if tapBottom
        hvBot = diffBotEdge - hvOLbot
        nwellBot = diffBotEdge - nwellOLbot

        if( tapRight then
          if( rexMatchp("^pmos" devInfo->deviceName) then
            hvOLrht = nwellOLrht = max( rules->nwell->minOLhvtap rules->nwell->minOLdnwell )
              ;rules->nwell->minOLdnwell + rules->dnwell->minOLipw - (rules->nwell->minOLhvtap + tapW) )
          else
            hvOLrht = rules->thkox->minOLtap
            nwellOLrht = 0.0
          )
        else
          if( evenp(nf) then
            if( rexMatchp("^pmos" devInfo->deviceName) then
              hvOLrht = nwellOLrht = max( rules->nwell->minOLhvdiff rules->nwell->minOLdnwell 
                rules->nwell->minOLdnwell + rules->dnwell->minOLipw -
                (rodGetObj("active1" cv)->width - devInfo->rules->srcOLnwell))
            else
              hvOLrht = rules->thkox->minOLdiff
              nwellOLrht = 0.0
            )
          else
            if( rexMatchp("^pmos" devInfo->deviceName) then
              hvOLrht = nwellOLrht = max( rules->nwell->minOLhvdiff rules->nwell->minOLdnwell
                devInfo->rules->wellOLdrn + rules->dnwell->minOLipw + rules->nwell->minOLdnwell
                devInfo->rules->wellOLdrn + rules->nwell->minW )
            else
              hvOLrht = max( rules->thkox->minOLdiff rules->nwell->minOLhvdiff devInfo->rules->wellOLdrn )
              nwellOLrht = 0.0
            )
          ); if even nf
        ); if tapRight
        hvRht = diffRhtEdge + hvOLrht
        nwellRht = diffRhtEdge + nwellOLrht

        if( tapLeft then
          if( rexMatchp("^pmos" devInfo->deviceName) then
            hvOLlft = nwellOLlft = max( rules->nwell->minOLhvtap rules->nwell->minOLdnwell )
          else
            hvOLlft = rules->thkox->minOLtap
            nwellOLlft = 0.0
          )
        else
          if( rexMatchp("^pmos" devInfo->deviceName) then
            hvOLlft = nwellOLlft = max( rules->nwell->minOLhvdiff rules->nwell->minOLdnwell )
            hvOLlft = nwellOLlft = max( rules->nwell->minOLhvdiff rules->nwell->minOLdnwell 
              rules->nwell->minOLdnwell + rules->dnwell->minOLipw -
              (rodGetObj("active1" cv)->width - devInfo->rules->srcOLnwell))
          else
            hvOLlft = rules->thkox->minOLdiff
            nwellOLlft = 0.0
          )
        ); if tapLeft
        hvLft = diffLftEdge - hvOLlft
        nwellLft = diffLftEdge - nwellOLlft

        ; create thkox layer
        ;-----------------------------
        rodCreateRect(
          ?cvId   cv
          ?name   "thickOxLayer"
          ?layer  rules->thkox->layer
          ?bBox   list( hvLft:hvBot hvRht:hvTop )
        )

        ; create nwell and dnwell layers
        ;-----------------------------
        when( rexMatchp("^pmos" devInfo->deviceName)
          nwellShapes = setof( shape cv->shapes shape->layerName == rules->nwell->layer )
          rodCreateRect(
            ?cvId     cv
            ?name     "nwellLayer"
            ?layer    rules->nwell->layer
            ?bBox     list( nwellLft:nwellBot nwellRht:nwellTop )
          )
          rodCreateRect(
            ?cvId     cv
            ?name     "dnwellLayer"
            ?layer    rules->dnwell->layer
            ?fromObj  rodGetObj( "nwellLayer" cv)
            ?size     -rules->nwell->minOLdnwell
          )
          ; need to remove the nwells that are place holders for the iso pwells
          nwellLayer = dbLayerAndNot( cv rules->nwell->layer list( rodGetObj("nwellLayer" cv)->dbId ) nwellShapes )
          foreach( nw nwellShapes dbDeleteObject(nw))
          dbDeleteObject(rodGetObj("nwellLayer" cv)->dbId)
        ); when pmos

      ); let
    ); pcDefinePCell layout
*/
  ); foreach device

);  let

/*==================================  EOF  ===================================*/
