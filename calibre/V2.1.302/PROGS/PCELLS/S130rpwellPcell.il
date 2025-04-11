/*==============================================================================
  File:         S130rpwellPcell.il
  Purpose:      Pcell code for layout and symbols, and cdf setup for the rpwell
                resistor for the Skywater S130 Pcell.

  Created:      May 02, 2020  Madek Graham
  Description:  Pcell code to create the pwell resistor
  
  Devices/views:  rpwell / layout symbol auCdl auLvs spectre

------------------------------------------------------------
  Modifications:

==============================================================================*/

/*==============================================================================

  This file only needs to be loaded once to create the pcells and cdf information
  for the resBaseDevices set within the S130techData.il file

==============================================================================*/

let( ( libName )

  libName = "S130"

  foreach( device rpwellDevices
    printf("Creating device %s in %s library\n" device->deviceName libName )

    ;===========================================================
    ;***** Define Layout Pcell *****
    ;===========================================================

    let( (cv lppShapes nwTapLROffsetPath nwTapLROffsetPath nwTapLRSubCnt nwTapLRSubCnt
          nwTapLRTBOffsetPath nwTapLRTBSubCnt nwTapLX nwTapLY nwTapOffsetPath nwTapSPpsdm
          nwTapSubCnt nwTapTBOffsetPath nwTapTBOffsetPath nwTapTBSubCnt nwTapTBSubCnt
          nwTapUX nwTapUY tapLi1OLlicon1 tapLi1OLmcon tapLi1W tapMet1OLmcon tapMet1W
          tapOLcont tapW termL termW bottomTapMet1 leftTapMet1 rightTapMet1 topTapMet1 )

      pcDefinePCell( list( ddGetObj(libName) device->deviceName "layout" )
        ; formal parameters name value pairs
        (
          ( devInfo       "ilList"  device )
          ( rules         "ilList"  designRules )
          ( grid          "float"   techGetMfgGridResolution(techGetTechFile(ddGetObj(libName))) )
          ( w             "float"   device->defW )
          ( l             "float"   device->defL )
          ( nwTapLRCnt    "boolean" t)
          ( nwTapTBCnt    "boolean" nil)
        )

        cv = pcCellView

        dbReplaceProp(cv "instNamePrefix" "string" "RPW")

        rodCreateRect(
          ?cvId   cv
          ?name   "res"
          ?layer  devInfo->mrkLay
          ?width  w
          ?length l
          ?origin 0:0
        )
        ; psdm (pwell hole)
        rodCreateRect(
          ?cvId   cv
          ?name   "resImp"
          ?layer  rules->psdm->layer
          ?width  rodGetObj("res" cv)->width
          ?length rodGetObj("res" cv)->length + 2*(rules->pwres->termW) + 2*(rules->pwres->termSPnwell)
        )
        rodAlign(
          ?alignObj     rodGetObj("resImp" cv)
          ?alignHandle  "centerCenter"
          ?refObj       rodGetObj("res" cv)
          ?refHandle    "centerCenter"
        )
        ; deep nwell
        rodCreateRect(
          ?cvId   cv
          ?name   "resDnw"
          ?layer  rules->dnwell->layer
          ?width  rodGetObj("resImp" cv)->width + 2*rules->dnwell->minOLipw
          ?length rodGetObj("resImp" cv)->length + 2*rules->dnwell->minOLipw
        )
        rodAlign(
          ?alignObj     rodGetObj("resDnw" cv)
          ?alignHandle  "centerCenter"
          ?refObj       rodGetObj("resImp" cv)
          ?refHandle    "centerCenter"
        )

        ; create terminals
        termL = devInfo->rules->termW
        termW = w - 2*devInfo->rules->termSPnwell

        ; diffusion
        rodCreateRect(
          ?cvId   cv
          ?name   "plusTerm"
          ?layer  rules->tap->layer
          ?width  termW
          ?length termL
        )
        rodAlign(
          ?alignObj     rodGetObj("plusTerm" cv)
          ?alignHandle  "upperCenter"
          ?refObj       rodGetObj("res" cv)
          ?refHandle    "lowerCenter"
        )
        rodCreateRect(
          ?cvId   cv
          ?name   "minusTerm"
          ?layer  rules->tap->layer
          ?width  termW
          ?length termL
        )
        rodAlign(
          ?alignObj     rodGetObj("minusTerm" cv)
          ?alignHandle  "lowerCenter"
          ?refObj       rodGetObj("res" cv)
          ?refHandle    "upperCenter"
        )
        ; licon1
        rodFillWithRects(
          ?shapeId          rodGetObj("plusTerm" cv)->dbId
          ?fillShapeLPP     list(rules->licon1->layer rules->licon1->purpose)
          ?fillShapeWidth   rules->licon1->minW
          ?fillShapeLength  rules->licon1->minW
          ?gap              "minium"
          ?justification    "centerCenter"
          ?spaceX           rules->licon1->minSP
          ?spaceY           rules->licon1->minSP
          ?enclosureX       rules->tap->minOLSisoTapLicon1
          ?enclosureY       rules->li1->minOLLlicon1
          ?grid             grid
        )
        rodFillWithRects(
          ?shapeId          rodGetObj("minusTerm" cv)->dbId
          ?fillShapeLPP     list(rules->licon1->layer rules->licon1->purpose)
          ?fillShapeWidth   rules->licon1->minW
          ?fillShapeLength  rules->licon1->minW
          ?gap              "minimum"
          ?justification    "centerCenter"
          ?spaceX           rules->licon1->minSP
          ?spaceY           rules->licon1->minSP
          ?enclosureX       rules->tap->minOLSisoTapLicon1
          ?enclosureY       rules->li1->minOLLlicon1
          ?grid             grid
        )
        ; li1
        rodCreateRect(
          ?cvId   cv
          ?name   "plusTermLi1"
          ?layer  rules->li1->layer
          ?width  termW
          ?length termL
        )
        rodAlign(
          ?alignObj     rodGetObj("plusTermLi1" cv)
          ?alignHandle  "centerCenter"
          ?refObj       rodGetObj("plusTerm" cv)
          ?refHandle    "centerCenter"
        )
        rodCreateRect(
          ?cvId   cv
          ?name   "minusTermLi1"
          ?layer  rules->li1->layer
          ?width  termW
          ?length termL
        )
        rodAlign(
          ?alignObj     rodGetObj("minusTermLi1" cv)
          ?alignHandle  "centerCenter"
          ?refObj       rodGetObj("minusTerm" cv)
          ?refHandle    "centerCenter"
        )
        rodFillWithRects(
          ?shapeId          rodGetObj("plusTermLi1" cv)->dbId
          ?fillShapeLPP     list(rules->mcon->layer rules->mcon->purpose)
          ?fillShapeWidth   rules->mcon->minW
          ?fillShapeLength  rules->mcon->minW
          ?gap              "minimum"
          ?justification    "centerCenter"
          ?spaceX           rules->mcon->minSP
          ?spaceY           rules->mcon->minSP
          ?enclosureX       rules->li1->minOLSmcon
          ?enclosureY       rules->li1->minOLLmcon
          ?grid             grid
        )
        rodFillWithRects(
          ?shapeId          rodGetObj("minusTermLi1" cv)->dbId
          ?fillShapeLPP     list(rules->mcon->layer rules->mcon->purpose)
          ?fillShapeWidth   rules->mcon->minW
          ?fillShapeLength  rules->mcon->minW
          ?gap              "minimum"
          ?justification    "centerCenter"
          ?spaceX           rules->mcon->minSP
          ?spaceY           rules->mcon->minSP
          ?enclosureX       rules->li1->minOLSmcon
          ?enclosureY       rules->li1->minOLLmcon
          ?grid             grid
        )
        ; metal1
        rodCreateRect(
          ?cvId   cv
          ?name   "plusTermMet1"
          ?layer  rules->met1->layer
          ?width  rodGetObj("plusTermLi1" cv)->width  + 2*(rules->met1->minOLSmcon - rules->li1->minOLSmcon)
          ?length rodGetObj("plusTermLi1" cv)->length + 2*(rules->met1->minOLLmcon - rules->li1->minOLLmcon)
        )
        rodAlign(
          ?alignObj     rodGetObj("plusTermMet1" cv)
          ?alignHandle  "centerCenter"
          ?refObj       rodGetObj("plusTermLi1" cv)
          ?refHandle    "centerCenter"
        )
        rodCreateRect(
          ?cvId   cv
          ?name   "minusTermMet1"
          ?layer  rules->met1->layer
          ?width  rodGetObj("minusTermLi1" cv)->width  + 2*(rules->met1->minOLSmcon - rules->li1->minOLSmcon)
          ?length rodGetObj("minusTermLi1" cv)->length + 2*(rules->met1->minOLLmcon - rules->li1->minOLLmcon)
        )
        rodAlign(
          ?alignObj     rodGetObj("minusTermMet1" cv)
          ?alignHandle  "centerCenter"
          ?refObj       rodGetObj("minusTermLi1" cv)
          ?refHandle    "centerCenter"
        )

        ; Make the terminal pins
        rodCreateRect(
          ?cvId   cv
          ?name   "plusPin"
          ?layer  list( rules->met1->pinlayer rules->met1->pinpurpose )
          ?bBox   list( rodGetObj("plusTermMet1" cv)->lowerLeft rodGetObj("plusTermMet1" cv)->upperRight )
          ?netName  "PLUS"
          ?termName "PLUS"
          ?termIOType "inputOutput"
          ?pin      t
          ?pinLabel t
          ?pinLabelHeight round( (rodGetObj("plusTermMet1" cv)->length/length("PLUS")) /grid)*grid
          ?pinLabelLayer  list( rules->met1->layer "label")
          ?pinLabelFont   "stick"
        )
        rodCreateRect(
          ?cvId   cv
          ?name   "minusPin"
          ?layer  list( rules->met1->pinlayer rules->met1->pinpurpose )
          ?bBox   list( rodGetObj("minusTermMet1" cv)->lowerLeft rodGetObj("minusTermMet1" cv)->upperRight )
          ?netName  "MINUS"
          ?termName "MINUS"
          ?termIOType "inputOutput"
          ?pin      t
          ?pinLabel t
          ?pinLabelHeight round( (rodGetObj("minusTermMet1" cv)->length/length("MINUS")) /grid)*grid
          ?pinLabelLayer  list( rules->met1->layer "label")
          ?pinLabelFont   "stick"
        )
      
        ; dnwell nwell ring & tap
        tapOLcont = max(rules->tap->minOLLisoTapLicon1 rules->tap->minOLSisoTapLicon1)
        tapW = max(rules->tap->minW  2*tapOLcont+rules->licon1->minW )
        tapLi1OLlicon1 = max( rules->li1->minOLLlicon1 rules->li1->minOLSlicon1 )
        tapLi1OLmcon = max( rules->li1->minOLLmcon rules->li1->minOLSmcon )
        tapLi1W = max(rules->li1->minW 2*tapLi1OLlicon1+rules->licon1->minW 2*tapLi1OLmcon+rules->mcon->minW )
        tapMet1OLmcon = max( rules->met1->minOLLmcon rules->met1->minOLSmcon )
        tapMet1W = max(rules->met1->minW 2*tapMet1OLmcon+rules->mcon->minW )

        nwTapSPpsdm = ceiling((0.5*(rules->dnwell->minOLipw + rules->nwell->minOLdnwell))/grid)*grid
        nwTapLX = -nwTapSPpsdm
        nwTapLY = yCoord(rodGetObj("resImp" cv)->lowerLeft)  - nwTapSPpsdm
        nwTapUX = xCoord(rodGetObj("resImp" cv)->upperRight) + nwTapSPpsdm
        nwTapUY = yCoord(rodGetObj("resImp" cv)->upperRight) + nwTapSPpsdm

        nwTapOffsetPath = list(
          list(
            ?layer        rules->nsdm->layer
            ?width        tapW+2*rules->nsdm->minOLtap
            ?beginOffset  rules->nsdm->minOLtap
            ?endOffset    rules->nsdm->minOLtap
          )
          list(
            ?layer        rules->nwell->layer
            ?width        2*nwTapSPpsdm
            ?beginOffset  nwTapSPpsdm - 0.5*tapW
            ?endOffset    nwTapSPpsdm - 0.5*tapW
          )
        )
        nwTapSubCnt = list()

        nwTapLRTBOffsetPath = list(
          list(
            ?layer        rules->li1->layer
            ?width        tapLi1W
            ?beginOffset  0.5*(tapLi1W - tapW)
            ?endOffset    0.5*(tapLi1W - tapW)
          )
          list(
            ?layer        rules->met1->layer
            ?width        tapMet1W
            ?beginOffset  0.5*(tapMet1W - tapW)
            ?endOffset    0.5*(tapMet1W - tapW)
          )
        )
        nwTapLRTBSubCnt = list(
          list(
            ?layer        rules->licon1->layer
            ?length       rules->licon1->minW
            ?width        rules->licon1->minW
            ?space        rules->licon1->minSP
            ?endOffset    -tapOLcont
            ?beginOffset  -tapOLcont
          )
          list(
            ?layer        rules->mcon->layer
            ?length       rules->mcon->minW
            ?width        rules->mcon->minW
            ?space        rules->mcon->minSP
            ?endOffset    -tapOLcont
            ?beginOffset  -tapOLcont
          )
        )

        if( nwTapLRCnt then
          nwTapLROffsetPath = append( nwTapOffsetPath nwTapLRTBOffsetPath )
          nwTapLRSubCnt = append( nwTapSubCnt nwTapLRTBSubCnt )
        else
          nwTapLROffsetPath = nwTapOffsetPath
          nwTapLRSubCnt = nwTapSubCnt
        ); if nwell tap left/right contacts
        if( nwTapTBCnt then
          nwTapTBOffsetPath = append( nwTapOffsetPath nwTapLRTBOffsetPath )
          nwTapTBSubCnt = append( nwTapSubCnt nwTapLRTBSubCnt )
        else
          nwTapTBOffsetPath = nwTapOffsetPath
          nwTapTBSubCnt = nwTapSubCnt
        ); if nwell tap top/bottom contacts

        rodCreatePath(
          ?cvId   cv
          ?name   "nwellLeftTap"
          ?layer  rules->tap->layer
          ?width  tapW
          ?pts    list( nwTapLX:nwTapLY nwTapLX:nwTapUY )
          ?endType "variable"
          ?beginExt 0.5*tapW
          ?endExt   0.5*tapW
          ?offsetSubPath nwTapLROffsetPath
          ?subRect nwTapLRSubCnt
          ?netName  "B"
          ?termName "B"
          ?termIOType "inputOutput"
          ?pin      t
        )
        when( leftTapMet1 = car(setof( shape rodGetObj("nwellLeftTap" cv)~>subShapes
          shape->layerName == "met1"))
          rodCreateRect(
            ?cvId   cv
            ?name   "leftTapMetPin"
            ?layer  list( rules->met1->pinlayer rules->met1->pinpurpose )
            ?bBox   leftTapMet1->bBox 
            ?netName  "B"
            ?termName "B"
            ?termIOType "inputOutput"
            ?pin      t
            ?pinLabel t
            ?pinLabelHeight 0.5*leftTapMet1->width
            ?pinLabelLayer  list( rules->met1->layer "label")
            ?pinLabelFont   "stick"
          )
        ); when tapMet1

        rodCreatePath(
          ?cvId   cv
          ?name   "nwellRightTap"
          ?layer  rules->tap->layer
          ?width  tapW
          ?pts    list( nwTapUX:nwTapLY nwTapUX:nwTapUY )
          ?endType "variable"
          ?beginExt 0.5*tapW
          ?endExt   0.5*tapW
          ?offsetSubPath nwTapLROffsetPath
          ?subRect nwTapLRSubCnt
          ?netName  "B"
          ?termName "B"
          ?termIOType "inputOutput"
          ?pin      t
        )
        when( rightTapMet1 = car(setof( shape rodGetObj("nwellRightTap" cv)~>subShapes
          shape->layerName == "met1"))
          rodCreateRect(
            ?cvId   cv
            ?name   "rightTapMetPin"
            ?layer  list( rules->met1->pinlayer rules->met1->pinpurpose )
            ?bBox   rightTapMet1->bBox 
            ?netName  "B"
            ?termName "B"
            ?termIOType "inputOutput"
            ?pin      t
            ?pinLabel t
            ?pinLabelHeight 0.5*rightTapMet1->width
            ?pinLabelLayer  list( rules->met1->layer "label")
            ?pinLabelFont   "stick"
          )
        ); when tapMet1

        rodCreatePath(
          ?cvId   cv
          ?name   "nwellTopTap"
          ?layer  rules->tap->layer
          ?width  tapW
          ?pts    list( nwTapLX:nwTapUY nwTapUX:nwTapUY )
          ?endType "variable"
          ?beginExt 0.5*tapW
          ?endExt   0.5*tapW
          ?offsetSubPath nwTapTBOffsetPath
          ?subRect nwTapTBSubCnt
          ?netName  "B"
          ?termName "B"
          ?termIOType "inputOutput"
          ?pin      t
        )
        when( topTapMet1 = car(setof( shape rodGetObj("nwellTopTap" cv)~>subShapes
          shape->layerName == "met1"))
          rodCreateRect(
            ?cvId   cv
            ?name   "topTapMetPin"
            ?layer  list( rules->met1->pinlayer rules->met1->pinpurpose )
            ?bBox   topTapMet1->bBox 
            ?netName  "B"
            ?termName "B"
            ?termIOType "inputOutput"
            ?pin      t
            ?pinLabel t
            ?pinLabelHeight 0.5*topTapMet1->width
            ?pinLabelLayer  list( rules->met1->layer "label")
            ?pinLabelFont   "stick"
          )
        ); when tapMet1

        rodCreatePath(
          ?cvId   cv
          ?name   "nwellBottomTap"
          ?layer  rules->tap->layer
          ?width  tapW
          ?pts    list( nwTapLX:nwTapLY nwTapUX:nwTapLY )
          ?endType "variable"
          ?beginExt 0.5*tapW
          ?endExt   0.5*tapW
          ?offsetSubPath nwTapTBOffsetPath
          ?subRect nwTapTBSubCnt
          ?netName  "B"
          ?termName "B"
          ?termIOType "inputOutput"
          ?pin      t
        )
        when( bottomTapMet1 = car(setof( shape rodGetObj("nwellBottomTap" cv)~>subShapes
          shape->layerName == "met1"))
          rodCreateRect(
            ?cvId   cv
            ?name   "bottomTapMetPin"
            ?layer  list( rules->met1->pinlayer rules->met1->pinpurpose )
            ?bBox   bottomTapMet1->bBox 
            ?netName  "B"
            ?termName "B"
            ?termIOType "inputOutput"
            ?pin      t
            ?pinLabel t
            ?pinLabelHeight 0.5*bottomTapMet1->width
            ?pinLabelLayer  list( rules->met1->layer "label")
            ?pinLabelFont   "stick"
          )
        ); when tapMet1

        ; flatten the nwell taps for merging
        dbConvertPathToPolygon(rodGetObj("nwellLeftTap" cv)->dbId)
        dbConvertPathToPolygon(rodGetObj("nwellRightTap" cv)->dbId)
        dbConvertPathToPolygon(rodGetObj("nwellTopTap" cv)->dbId)
        dbConvertPathToPolygon(rodGetObj("nwellBottomTap" cv)->dbId)

        ; Merge all the parts so it removes geometry lines
        foreach( lpp cv~>lpps
          lppShapes = lpp~>shapes
          when( lppShapes && (car(lppShapes)->purpose == "drawing" || car(lppShapes)->purpose == "res" ||
                car(lppShapes)->layerName == "areaid" )
            dbLayerOr( cv car(lppShapes)->lpp lppShapes )
            foreach(shape lppShapes dbDeleteObject(shape))
          ); end when lppShapes
        ); end foreach lpp

      ); end pcDefinePCell
    ); let

    ;===========================================================
    ;***** Define Symbol Pcell *****
    ;===========================================================

    foreach( view list("symbol" "auCdl" "auLvs" "spectre")
      let( (cv cellLabel instLabel labelR labelW labelL labelM labelB
            netm netp netb plus minus bias termP termM termB  paramLabel )

      when( cv = dbOpenCellViewByType( ddGetObj(libName) device->deviceName view "schematicSymbol" "w" ) 

        dbReplaceProp(cv "instNamePrefix" "string" "RPW")

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

        labelW = dbCreateLabel(cv list("annotate" "drawing") -0.0625:-0.234375
          "[@w:W=%]" "lowerRight" "R0" "stick" 0.03125)
        labelW->labelType = "NLPLabel"
        labelL = dbCreateLabel(cv list("annotate" "drawing") -0.0625:-0.296875
          "[@l:L=%]" "lowerRight" "R0" "stick" 0.03125)
        labelL->labelType = "NLPLabel"
        labelM = dbCreateLabel(cv list("annotate" "drawing") -0.0625:-0.359375
          "[@m:M=%]" "lowerRight" "R0" "stick" 0.03125)
        labelM->labelType = "NLPLabel"

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
        bias = dbCreatePolygon(cv list("pin" "drawing")
          list(-0.01875:-0.01875 0.01875:0.0 -0.01875:0.01875) )
        dbMoveShape(bias cv list(0.125:-0.1875 "R0"))
        dbCreatePin(netb bias)
        termB = dbCreateLabel( cv list("annotate" "drawing8") 0.125:-0.203125 "cdsTerm(\"B\")"
          "upperLeft" "R0" "stick" 0.01875 )
        termB~>labelType = "ILLabel"
        termB->parent = bias

        cv~>portOrder = list("PLUS" "MINUS" "B")

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
        ; bias label
        labelB = dbCreateLabel(cv list("annotate" "drawing8") 0.0953125:-0.1875
          "DNW" "lowerCenter" "R90" "stick" 0.01875)
        labelB->parent = bias

      dbSave(cv)
      dbClose(cv)
      ); when cv
      ); let
    ); foreach view

    ;===========================================================
    ;***** CDF definition *****
    ;===========================================================

    let( (cellname cellId cdf tfId defLvsModel )

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
        ?name           "rCalcMethod"
        ?prompt         "Calculate By"
        ?type           "cyclic"
        ?defValue       "Resistance"
        ?storeDefault   "yes"
        ?choices        list("Resistance" "Length")
      )
      cdfCreateParam( cdf
        ?name           "res"
        ?prompt         "Resistance"
        ?type           "string"
        ?defValue       sprintf( nil "%.3f" device->defRes ) 
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?parseAsNumber  "yes"
        ?units          "resistance"
        ?editable       "cdfgData->rCalcMethod->value == \"Resistance\""
        ?callback       sprintf( nil "%s()" device->paramCB )
      )
      cdfCreateParam( cdf
        ?name           "l"
        ?prompt         "Length"
        ?type           "float"
        ?defValue       device->defL 
        ?storeDefault   "yes"
        ?editable       "cdfgData->rCalcMethod->value == \"Length\""
        ?callback       sprintf( nil "%s()" device->paramCB )
      )
      cdfCreateParam( cdf
        ?name           "w"
        ?prompt         "Width"
        ?type           "float"
        ?defValue       device->defW 
        ?storeDefault   "yes"
        ?editable       "nil"
        ?callback       sprintf( nil "%s()" device->paramCB )
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
      cdfCreateParam( cdf
        ?name           "nwTapCnt"
        ?prompt         "Deep Nwell Metal Connection"
        ?type           "radio"
        ?defValue       "Sides"
        ?storeDefault   "yes"
        ?choices        list("Sides" "Ends" "Both")
        ?callback       strcat(device->paramCB "()")
        ?display        "hiGetCurrentWindow()~>cellView~>cellViewType == \"maskLayout\""
      )
      cdfCreateParam( cdf
        ?name           "nwTapLRCnt"
        ?prompt         "Deep Nwell Sides Metal Connection"
        ?type           "boolean"
        ?defValue       t
        ?storeDefault   "yes"
        ?display        "nil"
      )
      cdfCreateParam( cdf
        ?name           "nwTapTBCnt"
        ?prompt         "Deep Nwell Ends Metal Connection"
        ?type           "boolean"
        ?defValue       nil
        ?storeDefault   "yes"
        ?display        "nil"
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

      cdf->simInfo = list( nil)

      cdf->simInfo->auCdl = '( nil
        dollarEqualParams nil
        dollarParams      nil
        otherParameters   nil
        netlistProcedure  S130rpwellCdlNLProc
        instParameters    (model w l m)
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
        propMapping             nil
        netlistProcedure        ansSpectreDevPrim
        otherParameters         (model)
        instParameters          (m w l)
        termOrder               (PLUS MINUS B)
        namePrefix              "R"
        componentName           model
      )
      cdf->simInfo->spectreS = '( nil
        propMapping             nil
        netlistProcedure        ansSpectreSDevPrim
        otherParameters         (model)
        instParameters          (m w l)
        termOrder               (PLUS MINUS B)
        namePrefix              "R"
        componentName           model
      )

      cdf->formInitProc            = "S130disablePcellChange"
      cdf->paramLabelSet           = ""
      cdf->opPointLabelSet         = "v i pwr"
      cdf->paramEvaluate           = "t nil nil nil nil"
      cdf->paramDisplayMode        = "parameter"
      cdf->instDisplayMode         = "instName"
      cdf->instNameType            = "schematic"
      cdf->termDisplayMode         = "netName"
      cdf->netNameType             = "schematic"

      cdfSaveCDF( cdf)

    ); let
  ); foreach device

); let

/*==================================  EOF  ===================================*/
