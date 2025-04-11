/*==============================================================================
  File:         S130fetPcell.il
  Purpose:      Pcell code for layout setup for mosfet (non-DE)
                devices for Skywater S130 Pcells

  Created:      Mar 25, 2020  Madek Graham
  Description:  Pcell code to create the mosfet (non-DE) devices
  
  Devices/views:  nmos            / layout
                  nmos_esd_nat_v5 / layout
                  nmos_esd_v5     / layout
                  nmos_lvt        / layout
                  nmos_nat_v3     / layout
                  nmos_nat_v5     / layout
                  nmos_v5         / layout
                  pmos            / layout
                  pmos_esd_v5     / layout
                  pmos_hvt        / layout
                  pmos_lvt        / layout
                  pmos_v5         / layout

------------------------------------------------------------
  Modifications:
  - Jun 27, 2020 MSG
    Changed hvi layer to thkox to accomodate change in PDK
  - Sep 05, 2020 MSG
    Changed tap to default to bot, added fixed cdf params for w & l for discrete
    device sizes
  - Jan 12, 2021 MSG
    Added abutment rules
    Changed cdsTerms on symbols so they are a bit off the pin
  - Feb 13, 2021 MSG
    Split file into 3 parts (cdf, sym, lay)

==============================================================================*/

let( ( libName )

  libName = "S130"

  foreach( device fetDevices

    printf("Creating device %s layout in %s library\n" device->deviceName libName )

    ;===========================================================
    ;***** Define Layout Pcell *****
    ;===========================================================

    pcDefinePCell( list( ddGetObj(libName) device->deviceName "layout" )
      ; formal parameters name value pairs
      (
        ( devInfo       "ilList"  device )
        ( rules         "ilList"  designRules )
        ( grid          "float"   techGetMfgGridResolution(techGetTechFile(ddGetObj(libName))) )
        ( fw            "float"   device->defW ) ; finger width
        ( l             "float"   device->defL )
        ( nf            "int"     1 )
        ( fingerSP      "float"   device->defFingerSP )
        ( gateCnt       "string"  "none")   ; choices: none, Top, Bottom, Both
        ( gateCntExt    "float"   0.0)
        ( leftSDCont    "boolean" t )
        ( rightSDCont   "boolean" t )
        ( diffLext      "float"   0.0 )
        ( diffRext      "float"   0.0 )
        ( tapTop        "boolean" if( rexMatchp("^p" device->deviceName) then t else nil ) )
        ( tapTopCnt     "boolean" t)
        ( tapBottom     "boolean" if( rexMatchp("^n" device->deviceName) then t else nil ) )
        ( tapBottomCnt  "boolean" t)
        ( tapRight      "boolean" nil)
        ( tapRightCnt   "boolean" t)
        ( tapLeft       "boolean" nil)
        ( tapLeftCnt    "boolean" t)
        ( shortTerms    "string"  "none") ; short terminals choices none, SGD, SG, DG
      )

      let(( actBotEdge actLftEdge actRhtEdge actTopEdge active allDiffShapes
          cv diffBotEdge diffLftEdge diffRhtEdge diffTopEdge endCapExt
          gate gateBotCntImp gateBotCntPoly gateBotMetCnt gateCntL gateCntMetL
          gateCntMetW gateCntW gateExt gateNumCnts gatePin gateSPgateCnt
          gateTopCntImp gateTopCntPoly gateTopMetCnt gates hvBot
          hvLft hvOLbot hvOLlft hvOLrht hvOLtop hvRht
          hvTop implant leftSD mrk1 nwellBot nwellLayer
          nwellLft nwellOLbot nwellOLlft nwellOLrht nwellOLtop nwellRht
          nwellTop pinAdj rightSD shortAlgHandle shortRefHandle srcDrnCont
          srcDrnLength srcDrnNumConts srcDrnPin srcDrnShort srcDrnShortL tapBotAdjL
          tapBotAdjR tapBotEncPath tapBotL tapBotPath tapBotSubRect tapEncPath
          tapEncPathWithCnt tapImp tapImpOLtap tapLftAdjB tapLftAdjT tapLftEncPath
          tapLftL tapLftPath tapLftSubRect tapMetOLcont tapOLcont tapRhtAdjB
          tapRhtAdjT tapRhtEncPath tapRhtL tapRhtPath tapRhtSubRect tapSubRect
          tapSubRectWithCnt tapTBOffsetContR tapTBOffsetContL tapTBSubRectWithCnt
          tapTopAdjL tapTopAdjR tapTopEncPath tapTopL tapTopPath tapTopSubRect
          tapW tapbSP taplSP taprSP taptSP vtLayer leftPin rightPin abutRuleList )

        cv = pcCellView
        if( devInfo->nwellLay then
          dbReplaceProp(cv "instNamePrefix" "string" "MP")
        else
          dbReplaceProp(cv "instNamePrefix" "string" "MN")
        )

        ; create the gates
        ;-----------------------------
        gates = list()
        for( finger 1 nf
          gate = rodCreateRect(
            ?cvId     cv
            ?name     sprintf( nil "gate%d" finger )
            ?layer    devInfo->gateLay->layer
            ?width    l
            ?netName  "g"
            ?termName "g"
            ?termIOType "input"
            ?length   fw + 2*devInfo->gateLay->minOLdiff
            ?origin   (finger-1)*(l + fingerSP) : -devInfo->gateLay->minOLdiff
          )
          dbReplaceProp(gate~>dbId "lxBlockOverlapCheck" "boolean" t)
          gates = append1( gates gate )
        ); end for 1 to nf

        if( leftSDCont then
          leftSD = rules->diff->minOLLlicon1 + rules->licon1->minW + rules->licon1->minDcontSPpoly
        else
          leftSD = rules->diff->minOLgate
        )
        if( rightSDCont then
          rightSD = rules->diff->minOLLlicon1 + rules->licon1->minW + rules->licon1->minDcontSPpoly
        else
          rightSD = rules->diff->minOLgate
        )
        leftSD  = leftSD  + diffLext
        rightSD = rightSD + diffRext

        ; create the diff
        ;-----------------------------
        active = rodCreateRect(
          ?cvId   cv
          ?name   "active"
          ?layer  devInfo->diffLay->layer
          ?width  l + (nf-1)*(l + fingerSP) + leftSD + rightSD
          ?length fw
          ?origin 0.0 - leftSD : 0.00
        )
        allDiffShapes = list( active )

        ; create implant
        ;-----------------------------
        when( devInfo->impLay
          implant = rodCreateRect(
            ?cvId   cv
            ?name   "implant"
            ?layer  devInfo->impLay->layer
            ?width  2*devInfo->impLay->minOLdiff + active~>width
            ?length 2*devInfo->impLay->minOLdiff + active~>length
          )
          rodAlign(
            ?alignObj     implant
            ?alignHandle  "centerCenter"
            ?refObj       active
            ?refHandle    "centerCenter"
          )
        ); end when devInfo->impLay is defined

        ; create vt marking layer
        ;-----------------------------
        when( devInfo->vtLay
          vtLayer = rodCreateRect(
            ?cvId   cv
            ?name   "vtLayer"
            ?layer  devInfo->vtLay->layer
            ?width  2*devInfo->vtLay->minOLgate + nf*l + (nf-1)*fingerSP
            ?length 2*devInfo->vtLay->minOLgate + fw
          )
          rodAlign(
            ?alignObj     vtLayer
            ?alignHandle  "lowerLeft"
            ?refObj       rodGetObj( "gate1" cv )
            ?refHandle    "lowerLeft"
            ?xSep         -devInfo->vtLay->minOLgate
            ?ySep         -devInfo->vtLay->minOLgate + devInfo->gateLay->minOLdiff ; need to offset it by the gate endcap
          )
        ); end when devInfo->vtLay is defined

        ; create marking layer 1
        ;-----------------------------
        when( devInfo->mrk1Lay
          mrk1 = rodCreateRect(
            ?cvId   cv
            ?name   "mrk1"
            ?layer  devInfo->mrk1Lay
            ?width  2*devInfo->mrk1OLdiff + active~>width
            ?length 2*devInfo->mrk1OLdiff + active~>length
          )
          rodAlign(
            ?alignObj     mrk1
            ?alignHandle  "centerCenter"
            ?refObj       active
            ?refHandle    "centerCenter"
          )
        ); end when mrk1 is defined

        ; create the source & drain contacts
        ;-----------------------------

        ; calculate fetContLength (metal for src/drn contacts)
        srcDrnNumConts = 1 + fix( (fw - rules->licon1->minW -
          2*max(rules->diff->minOLSlicon1,rules->li1->minOLSlicon1))/
          (rules->licon1->minW + rules->licon1->minSP) )
        srcDrnLength = rules->licon1->minW + 2*rules->li1->minOLSlicon1 +
          (srcDrnNumConts - 1)*(rules->licon1->minW + rules->licon1->minSP)

        ; create the first srcDrnContact
        leftPin = rodCreateRect(
          ?cvId     cv
          ;?name     if( leftSDCont then "leftPin" else "srcDrnPin1" )
          ?name     "leftPin"
          ?layer    list( devInfo->diffLay->pinlayer devInfo->diffLay->pinpurpose )
          ?width    leftSD
          ?length   fw
          ?netName  "s"
          ?termName "s"
          ?termIOType "inputOutput"
          ?pin      t
          ?pinLabel t
          ?pinAccessDir list("top" "bottom" "left")
          ?pinLabelHeight round(0.25*leftSD/grid)*grid
          ?pinLabelLayer  list( devInfo->diffLay->layer "label")
          ?pinLabelFont   "stick"
        )
        rodAlign(
          ?alignObj     leftPin
          ?alignHandle  "lowerLeft"
          ?refObj       active
          ?refHandle    "lowerLeft"
        )
        if( leftSDCont then
          srcDrnCont = rodCreatePath(
            ?cvId     cv
            ?name     "srcDrnCont1"
            ?layer    rules->li1->layer
            ?termName "s"
            ?termIOType "inputOutput"
            ?width    rules->licon1->minW + 2*rules->li1->minOLLlicon1
            ?pts      list(0:0 0:srcDrnLength)
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
            ?alignObj     srcDrnCont
            ?alignHandle  "lowerLeft"
            ?refObj       active
            ?refHandle    "lowerLeft"
            ?xSep         rules->diff->minOLLlicon1-rules->li1->minOLLlicon1
            ?ySep         round((0.5*(fw-srcDrnLength))/grid)*grid
          )
        ); if leftSDCont

        ; create the internal contacts
        for( finger 2 nf
          srcDrnCont = rodCreatePath(
            ?cvId     cv
            ?name     sprintf(nil "srcDrnCont%d" finger)
            ?layer    rules->li1->layer
            ?termName if( oddp(finger) then "s" else "d" )
            ?termIOType "inputOutput"
            ?width    rules->licon1->minW + 2*rules->li1->minOLLlicon1
            ?pts      list(0:0 0:srcDrnLength)
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
            ?alignObj     srcDrnCont
            ?alignHandle  "lowerRight"
            ?refObj       rodGetObj(sprintf(nil "gate%d" finger) cv)
            ?refHandle    "lowerLeft"
            ?xSep         round((-0.5*(fingerSP - rules->licon1->minW + 2*rules->li1->minOLLlicon1))/grid)*grid
            ?ySep         rules->poly->minOLdiff+round((0.5*(fw-srcDrnLength))/grid)*grid
          )
          /*
          srcDrnPin = rodCreateRect(
            ?cvId     cv
            ?name     sprintf(nil "srcDrnPin%d" finger)
            ?layer    list( rules->li1->pinlayer rules->li1->pinpurpose )
            ?width    srcDrnCont->width
            ?length   srcDrnCont->length
            ?netName  if( oddp(finger) then "s" else "d" )
            ?termName if( oddp(finger) then "s" else "d" )
            ?termIOType "inputOutput"
            ?pin      t
            ?pinLabel t
            ?pinAccessDir list("top" "bottom")
            ?pinLabelHeight round(0.25*srcDrnCont->width/grid)*grid
            ?pinLabelLayer  list( rules->li1->layer "label")
            ?pinLabelFont   "stick"
          )
          rodAlign(
            ?alignObj     srcDrnPin
            ?alignHandle  "lowerLeft"
            ?refObj       srcDrnCont
            ?refHandle    "lowerLeft"
          )
          */
          srcDrnPin = rodCreateRect(
            ?cvId     cv
            ?name     sprintf(nil "srcDrnPin%d" finger)
            ?layer    list( devInfo->diffLay->pinlayer devInfo->diffLay->pinpurpose )
            ?width    fingerSP
            ?length   fw
            ?netName  if( oddp(finger) then "s" else "d" )
            ?termName if( oddp(finger) then "s" else "d" )
            ?termIOType "inputOutput"
            ?pin      t
            ?pinLabel t
            ?pinAccessDir list("top" "bottom")
            ?pinLabelHeight round(0.25*srcDrnCont->width/grid)*grid
            ?pinLabelLayer  list( devInfo->diffLay->pinlayer "label")
            ?pinLabelFont   "stick"
          )
          rodAlign(
            ?alignObj     srcDrnPin
            ?alignHandle  "lowerRight"
            ?refObj       rodGetObj(sprintf( nil "gate%d" finger ) cv)
            ?refHandle    "lowerLeft"
            ?ySep         devInfo->gateLay->minOLdiff
          )
        ); end for 1 to nf

        ; create the last srcDrnContact
        rightPin = rodCreateRect(
          ?cvId     cv
          ;?name     if( rightSDCont then "rightPin" else sprintf(nil "srcDrnPin%d" nf+1) )
          ?name     "rightPin"
          ?layer    list( devInfo->diffLay->pinlayer devInfo->diffLay->pinpurpose )
          ?width    rightSD
          ?length   fw
          ?netName  if( oddp(nf+1) then "s" else "d" )
          ?termName if( oddp(nf+1) then "s" else "d" )
          ?termIOType "inputOutput"
          ?pin      t
          ?pinLabel t
          ?pinAccessDir list("top" "bottom" "right")
          ?pinLabelHeight round(0.25*rightSD/grid)*grid
          ?pinLabelLayer  list( devInfo->diffLay->layer "label")
          ?pinLabelFont   "stick"
        )
        rodAlign(
          ?alignObj     rightPin
          ?alignHandle  "lowerRight"
          ?refObj       active
          ?refHandle    "lowerRight"
        )
        if( rightSDCont then
          srcDrnCont = rodCreatePath(
            ?cvId     cv
            ?name     sprintf(nil "srcDrnCont%d" nf+1)
            ?layer    rules->li1->layer
            ?termName if( oddp(nf+1) then "s" else "d" )
            ?termIOType "inputOutput"
            ?width    rules->licon1->minW + 2*rules->li1->minOLLlicon1
            ?pts      list(0:0 0:srcDrnLength)
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
            ?alignObj     srcDrnCont
            ?alignHandle  "lowerRight"
            ?refObj       active
            ?refHandle    "lowerRight"
            ?xSep         -rules->diff->minOLLlicon1+rules->li1->minOLLlicon1
            ?ySep         round((0.5*(fw-srcDrnLength))/grid)*grid
          )
        ); if rightSDcont

        ; create gate contacts
        ;-----------------------------
        unless( gateCnt == "none"

          ; calculate poly (gateCnt) for gate contacts
          gateCntL = max( 2*rules->poly->minOLSlicon1 + rules->licon1->minW,
            l + (nf-1)*(l+fingerSP) )
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
            devInfo->impLay->minOLdiff + (rules->licon1->minPcontSPpsdm - rules->poly->minOLLlicon1) )

          ; extension of gate endcap (if needed)
          endCapExt = 0.0
          if( gateSPgateCnt > rules->poly->minOLdiff then
            endCapExt = gateSPgateCnt - rules->poly->minOLdiff
          ); if gateSPgateCnt > endcap

          when( gateCnt == "Top" || gateCnt == "Both"
            gateTopCntPoly = rodCreateRect(
              ?cvId   cv
              ?name   "gateTopCntPoly"
              ?layer  rules->poly->layer
              ?width  gateCntL
              ?length gateCntW
            )
            rodAlign(
              ?alignObj     gateTopCntPoly
              ?alignHandle  "lowerLeft"
              ?refObj       rodGetObj( "gate1" cv )
              ?refHandle    "upperLeft"
              ?ySep         -rules->poly->minOLdiff + gateSPgateCnt
            )
            gateTopCntImp = rodCreateRect(
              ?cvId   cv
              ?name   "gateTopCntImp"
              ?layer  rules->npc->layer
              ?width  2*(rules->npc->minOLpcont - rules->poly->minOLLlicon1) + gateCntL
              ?length 2*(rules->npc->minOLpcont - rules->poly->minOLLlicon1) + gateCntW
            )
            rodAlign(
              ?alignObj     gateTopCntImp
              ?alignHandle  "centerCenter"
              ?refObj       gateTopCntPoly
              ?refHandle    "centerCenter"
            )
            when( endCapExt > 0.0
              for( finger 1 nf
                gateExt = rodCreateRect(
                  ?cvId   cv
                  ?name   sprintf(nil "gateTopExt%d" finger)
                  ?layer  rules->poly->layer
                  ?width  l
                  ?length endCapExt
                )
                rodAlign(
                  ?alignObj     gateExt
                  ?alignHandle  "lowerLeft"
                  ?refObj       rodGetObj( sprintf(nil "gate%d" finger) cv )
                  ?refHandle    "upperLeft"
                )
              ); for each finger
            ); when endCapExt > 0

            gateTopMetCnt = rodCreatePath(
              ?cvId     cv
              ?name     "gateTopMetCnt"
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
              ?alignObj     gateTopMetCnt
              ?alignHandle  "centerLeft"
              ?refObj       gateTopCntPoly
              ?refHandle    "centerLeft"
              ?xSep         round((0.5*(gateCntL - gateCntMetL))/grid)*grid
            )
            gatePin = rodCreateRect(
              ?cvId     cv
              ?name     "gateTopPin"
              ?layer    list( rules->li1->pinlayer rules->li1->pinpurpose )
              ?width    gateTopMetCnt->width
              ?length   gateTopMetCnt->length
              ?netName  "g"
              ?termName "g"
              ?termIOType "input"
              ?pin      t
              ?pinLabel t
              ?pinAccessDir   list("top" "left" "right")
              ?pinLabelHeight round(0.25*gateCntMetW/grid)*grid
              ?pinLabelLayer  list( rules->li1->layer "label")
              ?pinLabelFont   "stick"
            )
            rodAlign(
              ?alignObj     gatePin
              ?alignHandle  "lowerLeft"
              ?refObj       gateTopMetCnt
              ?refHandle    "lowerLeft"
            )

          ); when gateCnt Top

          when( gateCnt == "Bottom" || gateCnt == "Both"
            gateBotCntPoly = rodCreateRect(
              ?cvId   cv
              ?name   "gateBotCntPoly"
              ?layer  rules->poly->layer
              ?width  gateCntL
              ?length gateCntW
            )
            rodAlign(
              ?alignObj     gateBotCntPoly
              ?alignHandle  "upperLeft"
              ?refObj       rodGetObj( "gate1" cv )
              ?refHandle    "lowerLeft"
              ?ySep         rules->poly->minOLdiff - gateSPgateCnt
            )
            gateBotCntImp = rodCreateRect(
              ?cvId   cv
              ?name   "gateBotCntImp"
              ?layer  rules->npc->layer
              ?width  2*(rules->npc->minOLpcont - rules->poly->minOLLlicon1) + gateCntL
              ?length 2*(rules->npc->minOLpcont - rules->poly->minOLLlicon1) + gateCntW
            )
            rodAlign(
              ?alignObj     gateBotCntImp
              ?alignHandle  "centerCenter"
              ?refObj       gateBotCntPoly
              ?refHandle    "centerCenter"
            )
            when( endCapExt > 0.0
              for( finger 1 nf
                gateExt = rodCreateRect(
                  ?cvId   cv
                  ?name   sprintf(nil "gateBotExt%d" finger)
                  ?layer  rules->poly->layer
                  ?width  l
                  ?length endCapExt
                )
                rodAlign(
                  ?alignObj     gateExt
                  ?alignHandle  "upperLeft"
                  ?refObj       rodGetObj( sprintf(nil "gate%d" finger) cv )
                  ?refHandle    "lowerLeft"
                )
              ); for each finger
            ); when endCapExt > 0

            gateBotMetCnt = rodCreatePath(
              ?cvId     cv
              ?name     "gateBotMetCnt"
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
              ?alignObj     gateBotMetCnt
              ?alignHandle  "centerLeft"
              ?refObj       gateBotCntPoly
              ?refHandle    "centerLeft"
              ?xSep         round((0.5*(gateCntL - gateCntMetL))/grid)*grid
            )
            gatePin = rodCreateRect(
              ?cvId     cv
              ?name     "gateBotPin"
              ?layer    list( rules->li1->pinlayer rules->li1->pinpurpose )
              ?width    gateBotMetCnt->width
              ?length   gateBotMetCnt->length
              ?netName  "g"
              ?termName "g"
              ?termIOType "input"
              ?pin      t
              ?pinLabel t
              ?pinAccessDir   list("bottom" "left" "right")
              ?pinLabelHeight round(0.25*gateCntMetW/grid)*grid
              ?pinLabelLayer  list( rules->li1->layer "label")
              ?pinLabelFont   "stick"
            )
            rodAlign(
              ?alignObj     gatePin
              ?alignHandle  "lowerLeft"
              ?refObj       gateBotMetCnt
              ?refHandle    "lowerLeft"
            )

          ); when gateCnt Bot

        ); unless gateCnt none

        ; create gate pins when no gate contact
        ;-----------------------------
        when( gateCnt == "none"
          for( finger 1 nf
            gatePin = rodCreateRect(
              ?cvId   cv
              ?name   sprintf(nil "gateTopPin%d" finger)
              ?layer  list( devInfo->gateLay->pinlayer devInfo->gateLay->pinpurpose )
              ?width  l
              ?length devInfo->gateLay->minOLdiff
              ?netName  "g"
              ?termName "g"
              ?termIOType "input"
              ?pin      t
              ?pinLabel t
              ?pinAccessDir   list("top" "left" "right")
              ?pinLabelHeight round(0.25*devInfo->gateLay->minOLdiff/grid)*grid
              ?pinLabelLayer  list( devInfo->gateLay->layer "label")
              ?pinLabelFont   "stick"
            )
            rodAlign(
              ?alignObj     gatePin
              ?alignHandle  "upperLeft"
              ?refObj       rodGetObj(sprintf(nil "gate%d" finger) cv)
              ?refHandle    "upperLeft"
            )
            gatePin = rodCreateRect(
              ?cvId   cv
              ?name   sprintf(nil "gateBotPin%d" finger)
              ?layer  list( devInfo->gateLay->pinlayer devInfo->gateLay->pinpurpose )
              ?width  l
              ?length devInfo->gateLay->minOLdiff
              ?netName  "g"
              ?termName "g"
              ?termIOType "input"
              ?pin      t
              ?pinLabel t
              ?pinAccessDir   list("bottom" "left" "right")
              ?pinLabelHeight round(0.25*devInfo->gateLay->minOLdiff/grid)*grid
              ?pinLabelLayer  list( devInfo->gateLay->layer "label")
              ?pinLabelFont   "stick"
            )
            rodAlign(
              ?alignObj     gatePin
              ?alignHandle  "lowerLeft"
              ?refObj       rodGetObj(sprintf(nil "gate%d" finger) cv)
              ?refHandle    "lowerLeft"
            )
          ); for nf
        ); when no gateCnt

        ; short the terms
        ;-----------------------------
        if( shortTerms != "none" && gateCnt != "none" then
          case( gateCnt
            ("Both"
              srcDrnShortL = yCoord(rodGetObj("gateTopPin" cv)->upperRight) - yCoord(rodGetObj("gateBotPin" cv)->lowerLeft)
              shortAlgHandle = "centerCenter"
              shortRefHandle = "centerCenter"
            )
            ("Top"
              srcDrnShortL = yCoord(rodGetObj("gateTopPin" cv)->upperRight) - yCoord(rodGetObj("srcDrnPin2" cv)->lowerLeft)
              shortAlgHandle = "lowerLeft"
              shortRefHandle = "lowerLeft"
            )
            ("Bottom"
              srcDrnShortL = yCoord(rodGetObj("srcDrnPin2" cv)->upperRight) - yCoord(rodGetObj("gateBotPin" cv)->lowerLeft)
              shortAlgHandle = "upperRight"
              shortRefHandle = "upperRight"
            )
          ); case gateCnt
          when( leftSDCont && shortTerms != "DG"
            srcDrnShort = rodCreateRect(
              ?cvId     cv
              ?name     "srcDrnShort1"
              ?layer    rules->li1->layer
              ?width    rules->licon1->minW + 2*rules->li1->minOLLlicon1
              ?length   srcDrnShortL
            )
            rodAlign(
              ?alignObj     srcDrnShort
              ?alignHandle  shortAlgHandle
              ?refObj       rodGetObj("leftPin" cv)
              ?refHandle    shortRefHandle
            )
            when( gateCnt != "Bottom"
              rodCreateRect(
                ?cvId     cv
                ?name     "gateShortLT"
                ?layer    rules->li1->layer
                ?bBox     list( srcDrnShort->upperLeft rodGetObj("gateTopPin" cv)->lowerRight )
              )
            ); when gateCnt != Bottom
            when( gateCnt != "Top"
              rodCreateRect(
                ?cvId     cv
                ?name     "gateShortLB"
                ?layer    rules->li1->layer
                ?bBox     list( srcDrnShort->lowerLeft rodGetObj("gateBotPin" cv)->upperRight )
              )
            ); when gateCnt != Top
          ); when leftSDCont
          for( finger 2 nf
            when( evenp(finger) && shortTerms != "SG"
              srcDrnShort = rodCreateRect(
                ?cvId     cv
                ?name     sprintf(nil "srcDrnShort%d" finger)
                ?layer    rules->li1->layer
                ?width    rules->licon1->minW + 2*rules->li1->minOLLlicon1
                ?length   srcDrnShortL
              )
              rodAlign(
                ?alignObj     srcDrnShort
                ?alignHandle  shortAlgHandle
                ?refObj       rodGetObj(sprintf(nil "srcDrnPin%d" finger) cv)
                ?refHandle    shortRefHandle
              )
            ); when even finger and shortTerms != "SG"
            when( oddp(finger) && shortTerms != "DG"
              srcDrnShort = rodCreateRect(
                ?cvId     cv
                ?name     sprintf(nil "srcDrnShort%d" finger)
                ?layer    rules->li1->layer
                ?width    rules->licon1->minW + 2*rules->li1->minOLLlicon1
                ?length   srcDrnShortL
              )
              rodAlign(
                ?alignObj     srcDrnShort
                ?alignHandle  shortAlgHandle
                ?refObj       rodGetObj(sprintf(nil "srcDrnPin%d" finger) cv)
                ?refHandle    shortRefHandle
              )
            ); when odd finger and shortTerms != "DG"
          ); for nf
          when( rightSDCont &&
                ((oddp(nf) && shortTerms != "SG") || (evenp(nf) && shortTerms != "DG"))
            srcDrnShort = rodCreateRect(
              ?cvId     cv
              ?name     sprintf(nil "srcDrnShort%d" nf+1)
              ?layer    rules->li1->layer
              ?width    rules->licon1->minW + 2*rules->li1->minOLLlicon1
              ?length   srcDrnShortL
            )
            rodAlign(
              ?alignObj     srcDrnShort
              ?alignHandle  shortAlgHandle
              ?refObj       rodGetObj(sprintf(nil "srcDrnPin%d" nf+1) cv)
              ?refHandle    shortRefHandle
            )
            when( gateCnt != "Bottom"
              rodCreateRect(
                ?cvId     cv
                ?name     "gateShortRT"
                ?layer    rules->li1->layer
                ?bBox     list( srcDrnShort->upperRight rodGetObj("gateTopPin" cv)->lowerLeft )
              )
            ); when gateCnt != Bottom
            when( gateCnt != "Top"
              rodCreateRect(
                ?cvId     cv
                ?name     "gateShortRB"
                ?layer    rules->li1->layer
                ?bBox     list( srcDrnShort->lowerRight rodGetObj("gateBotPin" cv)->upperLeft )
              )
            ); when gateCnt != Top
          ); when rightSDCont

        ); if shortTerms

        ; create the taps
        ;-----------------------------
        tapImp = devInfo->tapImpLay->layer
        tapImpOLtap = devInfo->tapImpLay->minOLtap

        ; best to go with max overlap contact so the corners will line up
        tapOLcont = max(rules->tap->minOLLisoTapLicon1 rules->tap->minOLSisoTapLicon1)
        tapMetOLcont = max(rules->li1->minOLLlicon1 rules->li1->minOLSlicon1)
        tapW = max(rules->tap->minW  2*tapOLcont + rules->licon1->minW )

        ; do some basic calculations for the tap

        ; for left & right taps, the spacing will be from the mos diff
        taplSP = taprSP = max( if( devInfo->hvLay then devInfo->diffLay->minSPhvtap else devInfo->diffLay->minSP )
          devInfo->impLay->minOLdiff + devInfo->impLay->minSPdiff
          devInfo->tapImpLay->minOLtap + devInfo->impLay->minSPdiff )

        ; for top & bottom taps, the spacing could be from the mos diff, gates, or poly cont
        ; in the end, the spacing will be from mos diff to tap edge
        taptSP = tapbSP = max( if( devInfo->hvLay then devInfo->diffLay->minSPhvtap else devInfo->diffLay->minSP )
          devInfo->impLay->minOLdiff + devInfo->impLay->minSPdiff
          devInfo->tapImpLay->minOLtap + devInfo->impLay->minSPdiff
          rules->tap->minSPpoly + devInfo->gateLay->minOLdiff
          rules->licon1->minDcontSPpoly - rules->tap->minOLSisoTapLicon1 + devInfo->gateLay->minOLdiff )

        when( gateCnt == "Top" || gateCnt == "Both"
          taptSP = max( taptSP gateSPgateCnt + gateCntW + rules->tap->minSPpoly )
          when( tapTopCnt
            taptSP = max( taptSP
              gateSPgateCnt + gateCntW - 0.5*(gateCntW - gateCntMetW) + rules->li1->minSP + (tapMetOLcont - tapOLcont)
              gateSPgateCnt + gateCntW + (rules->npc->minOLpcont - rules->poly->minOLLlicon1) +
                rules->licon1->taplicon1SPnpc - rules->tap->minOLSisoTapLicon1
              gateSPgateCnt + gateCntW - 0.5*(gateCntW - gateCntMetW) + rules->licon1->minPcontSPdiff
              gateSPgateCnt + gateCntW - 0.5*(gateCntW - gateCntMetW) + rules->licon1->minPcontSPpsdm + devInfo->tapImpLay->minOLtap )
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
              gateSPgateCnt + gateCntW - 0.5*(gateCntW - gateCntMetW) + rules->licon1->minPcontSPpsdm + devInfo->tapImpLay->minOLtap )
          )
        ); when bottom gateCnt
        
        ; create body pin if no taps exist
        unless( tapTop || tapLeft || tapBottom || tapRight
          if( devInfo->nwellLay then
            rodCreateRect(
              ?cvId   cv
              ?name   "wellPin"
              ?layer  list( "nwell" "pin" )
              ?fromObj rodGetObj( "active" cv )
              ?netName  "b"
              ?termName "b"
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
              ?fromObj rodGetObj( "active" cv )
              ?netName  "b"
              ?termName "b"
              ?termIOType "inputOutput"
              ?pin      t
              ?pinLabel t
              ?pinLabelHeight 0.3
              ?pinLabelLayer  list( "pwell" "label")
              ?pinLabelFont   "stick"
            )
          ); if nwell
        ); unless any taps

        if( tapTop    then tapRhtAdjT = tapLftAdjT = tapW + taptSP else tapRhtAdjT = tapLftAdjT = 0.0 )
        if( tapBottom then tapRhtAdjB = tapLftAdjB = tapW + tapbSP else tapRhtAdjB = tapLftAdjB = 0.0 )
        if( tapLeft   then
          tapTopAdjL = tapBotAdjL = tapW + taplSP
        else
          tapTopAdjL = tapBotAdjL = tapOLcont - rules->diff->minOLLlicon1
        )
        if( tapRight   then
          tapTopAdjR = tapBotAdjR = tapW + taplSP
        else
          tapTopAdjR = tapBotAdjR = tapOLcont - rules->diff->minOLLlicon1
        )

        tapTopL = active->width  + tapTopAdjL + tapTopAdjR
        tapBotL = active->width  + tapBotAdjL + tapBotAdjR
        tapLftL = active->length + tapLftAdjT + tapLftAdjB
        tapRhtL = active->length + tapRhtAdjT + tapRhtAdjB

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
        cond(
          (tapRight && tapLeft
            tapTBOffsetContR = tapTopAdjR + rules->diff->minOLLlicon1
            tapTBOffsetContL = tapTopAdjL + rules->diff->minOLLlicon1
          )
          (tapRight && !tapLeft
            tapTBOffsetContR = tapTopAdjR + rules->diff->minOLLlicon1
            tapTBOffsetContL = tapOLcont
          )
          (!tapRight && tapLeft
            tapTBOffsetContR = tapOLcont
            tapTBOffsetContL = tapTopAdjL + rules->diff->minOLLlicon1
          )
          (t
            tapTBOffsetContR = tapOLcont
            tapTBOffsetContL = tapOLcont
          )
        )
        tapTBSubRectWithCnt = list(
                              ?layer rules->licon1->layer
                              ?length rules->licon1->minW
                              ?width rules->licon1->minW
                              ?space if( nf == 1 || fingerSP == devInfo->defFingerSP then
                                  max(rules->licon1->minSP 2*rules->licon1->minDcontSPpoly+l)
                                else
                                  max(rules->licon1->minSP
                                    rules->licon1->minDcontSPpoly + l + 0.5*(fingerSP - rules->licon1->minW)
                                  )
                                )
                              ?gap   if( rightSDCont && leftSDCont then "distribute" else "minimum" )
                              ?beginOffset if( leftSDCont then
                                  -tapTBOffsetContL
                                else
                                  -tapTBOffsetContR
                                )
                              ?endOffset   if( leftSDCont then
                                  -tapTBOffsetContR
                                else
                                  -tapTBOffsetContL
                                )
                            )

        ; grab coordinates from active rodShape
        actTopEdge = yCoord(active->upperRight)
        actRhtEdge = xCoord(active->upperRight)
        actBotEdge = yCoord(active->lowerLeft)
        actLftEdge = xCoord(active->lowerLeft)

        ; create top tap
        if( tapTop then
          if( tapTopCnt then
            tapTopEncPath = append1( tapEncPath tapEncPathWithCnt )
            tapTopSubRect = append1( tapSubRect tapTBSubRectWithCnt )
          else
            tapTopEncPath = tapEncPath
            tapTopSubRect = tapSubRect
          ); end when tapTopCnt
          tapTopPath = rodCreatePath(
            ?cvId cv
            ?name "tapTopPath"
            ?layer rules->tap->layer
            ?width tapW
            ?pts if( leftSDCont then
                list(
                  actLftEdge-tapTopAdjL : actTopEdge+taptSP+0.5*tapW
                  actRhtEdge+tapTopAdjR : actTopEdge+taptSP+0.5*tapW
                )
              else
                list(
                  actRhtEdge+tapTopAdjR : actTopEdge+taptSP+0.5*tapW
                  actLftEdge-tapTopAdjL : actTopEdge+taptSP+0.5*tapW
                )
              )
            ?netName  "b"
            ?termName "b"
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
          tapRhtPath = rodCreatePath(
            ?cvId cv
            ?name "tapRhtPath"
            ?layer rules->tap->layer
            ?width tapW
            ?pts list(
              actRhtEdge+taprSP+0.5*tapW : actBotEdge-tapRhtAdjB
              actRhtEdge+taprSP+0.5*tapW : actTopEdge+tapRhtAdjT
            )
            ?netName  "b"
            ?termName "b"
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
            tapBotSubRect = append1( tapSubRect tapTBSubRectWithCnt )
          else
            tapBotEncPath = tapEncPath
            tapBotSubRect = tapSubRect
          ); end when tapBottomCnt
          tapBotPath = rodCreatePath(
            ?cvId cv
            ?name "tapBotPath"
            ?layer rules->tap->layer
            ?width tapW
            ?pts if( leftSDCont then
                list(
                  actLftEdge-tapBotAdjL : actBotEdge-tapbSP-0.5*tapW
                  actRhtEdge+tapBotAdjR : actBotEdge-tapbSP-0.5*tapW
                )
              else
                list(
                  actRhtEdge+tapBotAdjR : actBotEdge-tapbSP-0.5*tapW
                  actLftEdge-tapBotAdjL : actBotEdge-tapbSP-0.5*tapW
                )
              )
            ?netName  "b"
            ?termName "b"
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
          tapLftPath = rodCreatePath(
            ?cvId cv
            ?name "tapLftPath"
            ?layer rules->tap->layer
            ?width tapW
            ?pts list(
              actLftEdge-taplSP-0.5*tapW : actBotEdge-tapLftAdjB
              actLftEdge-taplSP-0.5*tapW : actTopEdge+tapLftAdjT
            )
            ?netName  "b"
            ?termName "b"
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
                (devInfo->vtLay->minOLgate+devInfo->vtLay->minWellOL)||0 )
            else
              nwellOLtop = devInfo->nwellLay->minOLhvdiff||0
            )
          else
            hvOLtop = devInfo->hvLay->minOLdiff||0
            if( devInfo->vtLay then
              nwellOLtop = max(devInfo->nwellLay->minOLdiff||0
                (devInfo->vtLay->minOLgate+devInfo->vtLay->minWellOL)||0 )
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
                (devInfo->vtLay->minOLgate+devInfo->vtLay->minWellOL)||0 )
            else
              nwellOLbot = devInfo->nwellLay->minOLhvdiff||0
            )
          else
            hvOLbot = devInfo->hvLay->minOLdiff||0
            if( devInfo->vtLay then
              nwellOLbot = max(devInfo->nwellLay->minOLdiff||0
                (devInfo->vtLay->minOLgate+devInfo->vtLay->minWellOL)||0 )
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
                ((devInfo->vtLay->minOLgate-rightSD)+devInfo->vtLay->minWellOL)||0 )
            else
              nwellOLrht = devInfo->nwellLay->minOLhvdiff||0
            )
          else
            hvOLrht = devInfo->hvLay->minOLdiff||0
            if( devInfo->vtLay then
              nwellOLrht = max( devInfo->nwellLay->minOLdiff||0
                ((devInfo->vtLay->minOLgate-rightSD)+devInfo->vtLay->minWellOL)||0 )
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
                ((devInfo->vtLay->minOLgate-leftSD)+devInfo->vtLay->minWellOL)||0 )
            else
              nwellOLlft = devInfo->nwellLay->minOLhvdiff||0
            )
          else
            hvOLlft = devInfo->hvLay->minOLdiff||0
            if( devInfo->vtLay then
              nwellOLlft = max( devInfo->nwellLay->minOLdiff||0
                ((devInfo->vtLay->minOLgate-leftSD)+devInfo->vtLay->minWellOL)||0 )
            else
              nwellOLlft = devInfo->nwellLay->minOLdiff||0
            )
          ); if hvLay
        ); if tapLeft
        hvLft = diffLftEdge - hvOLlft
        nwellLft = diffLftEdge - nwellOLlft

        ; create hv marking layer
        ;-----------------------------
        when( devInfo->hvLay
          ; insure the hv meets min width for nfets
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

          nwellLayer = rodCreateRect(
            ?cvId     cv
            ?name     "nwellLayer"
            ?layer    devInfo->nwellLay->layer
            ?bBox     list( nwellLft:nwellBot nwellRht:nwellTop )
          )
        ); when devInfo->nwellLay defined

        ; abutment rules
        dbReplaceProp(cv "permuteRule" "string" "p(s d)")
        if( devInfo->nwellLay then
          dbReplaceProp(cv "lxComponentType" "string" "PMOS")
        else
          dbReplaceProp(cv "lxComponentType" "string" "NMOS")
        )

        ; left src/drn
        leftPin~>dbId->pin->name = "left"
        dbReplaceProp(leftPin~>dbId "abutGateNet" "string" "g")
        dbReplaceProp(leftPin~>dbId "abutClass" "string" cv->cellName )
        dbReplaceProp(leftPin->dbId "abutAccessDir" "list" list("left"))
        dbReplaceProp(leftPin->dbId "abutFunction" "string" "S130mosAbutFunc")
        dbReplaceProp(leftPin->dbId "contactParam" "string" "leftSDCont")
        dbReplaceProp(leftPin->dbId "vxlInstSpacingDir" "list" list("left"))
        dbReplaceProp(leftPin->dbId "vxlInstSpacingRule" "float"
          if( devInfo->hvLay then rules->diff->minSPhv else rules->diff->minSP )  )
        dbReplaceProp(leftPin~>dbId "abutCondInclusion" "string" "leftSDCont")
        dbReplaceProp(leftPin->dbId "w" "float" fw)
        dbReplaceProp(leftPin->dbId "pinW" "float" leftPin->width)

        ; right src/drn
        rightPin~>dbId->pin->name = "right"
        dbReplaceProp(rightPin~>dbId "abutGateNet" "string" "g")
        dbReplaceProp(rightPin~>dbId "abutClass" "string" cv->cellName )
        dbReplaceProp(rightPin->dbId "abutAccessDir" "list" list("right"))
        dbReplaceProp(rightPin->dbId "abutFunction" "string" "S130mosAbutFunc")
        dbReplaceProp(rightPin->dbId "contactParam" "string" "rightSDCont")
        dbReplaceProp(rightPin->dbId "vxlInstSpacingDir" "list" list("right"))
        dbReplaceProp(rightPin->dbId "vxlInstSpacingRule" "float"
          if( devInfo->hvLay then rules->diff->minSPhv else rules->diff->minSP )  )
        dbReplaceProp(rightPin~>dbId "abutCondInclusion" "string" "rightSDCont")
        dbReplaceProp(rightPin->dbId "w" "float" fw)
        dbReplaceProp(rightPin->dbId "pinW" "float" rightPin->width)

      ); let
    ); pcDefinePCell layout

  ); foreach device
);  let

/*==================================  EOF  ===================================*/
