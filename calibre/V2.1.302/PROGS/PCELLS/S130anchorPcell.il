/*==============================================================================
  File:         S130anchorPcell.il
  Purpose:      Pcell code for layout and cdf setup for the anchor Skywater
                S130 Pcell

  Created:      July 05, 2021  Madek Graham
  Description:  Pcell code to create anchor
  
  Devices/views:  anchor / layout

------------------------------------------------------------
  Modifications:

==============================================================================*/

let( ( libName )

  libName = "S130"

  printf("Creating %s in %s library\n" anchor->deviceName libName )

  ;===========================================================
  ;***** Define Layout Pcell *****
  ;===========================================================
  pcDefinePCell( list( ddGetObj(libName) anchor->deviceName "layout" )
    ; formal parameters name value pairs
    (
      ( devInfo       "ilList"  anchor )
      ( rules         "ilList"  designRules )
      ( grid          "float"   techGetMfgGridResolution(techGetTechFile(ddGetObj(libName))) )
      ( w             "float"   anchor->defW )
      ( sp            "float"   anchor->defSP )
      ( viaPitch      "float"   anchor->viaPitch )
      ( x             "float"   anchor->defX )
      ( y             "float"   anchor->defY )
      ( z             "float"   anchor->defZ )
      ( numAnchors    "int"     1 )
      ( endStyle      "string"  "aligned" )
      ( anchorType    "string"  "full" )
    )
      
    let( ( cv viaSP chamXY halfW viaOffset licon mcon via1 via2 via3 polyShapes )

      cv = pcCellView
      dbReplaceProp(cv "instNamePrefix" "string" "ANCHOR")

      ; base variables
      viaSP = viaPitch/5
      halfW = 0.5*w
      polyShapes = list()

      ; chamfer settings
      chamXY = sqrt(0.5*expt(z 2))
      chamXY = round2(chamXY/grid)*grid
      ; change cont/via offset if chamfer only
      if( anchorType != "full" then
        viaOffset = 1.0
      else
        viaOffset = viaPitch - rules->licon->minW
      )

      ; cont/via subRect definitions
      licon = list(
        ?layer  rules->licon->layer
        ?width  rules->licon->minW
        ?length rules->licon->minW
        ?gap    "minimum"
        ?beginOffset -viaOffset
        ?endOffset   -1.0
        ?space viaPitch - rules->licon->minW
        ?diagonal t
      )
      mcon = list(
        ?layer  rules->mcon->layer
        ?width  rules->mcon->minW
        ?length rules->mcon->minW
        ?gap    "minimum"
        ?beginOffset -viaOffset - 1*viaSP + 0.5*(rules->mcon->minW-rules->licon->minW)
        ?endOffset   -1.0
        ?space viaPitch - rules->mcon->minW
        ?diagonal t
      )
      via1 = list(
        ?layer  rules->via1->layer
        ?width  rules->via1->minW
        ?length rules->via1->minW
        ?gap    "minimum"
        ?beginOffset -viaOffset - 2*viaSP + 0.5*(rules->via1->minW-rules->mcon->minW)
        ?endOffset   -1.0
        ?space viaPitch - rules->via1->minW
        ?diagonal t
      )
      via2 = list(
        ?layer  rules->via2->layer
        ?width  rules->via2->minW
        ?length rules->via2->minW
        ?gap    "minimum"
        ?beginOffset -viaOffset - 3*viaSP + 0.5*(rules->via2->minW-rules->via1->minW)
        ?endOffset   -1.0
        ?space viaPitch - rules->via2->minW
        ?diagonal t
      )
      via3 = list(
        ?layer  rules->via3->layer
        ?width  rules->via3->minW
        ?length rules->via3->minW
        ?gap    "minimum"
        ?beginOffset -viaOffset - 4*viaSP + 0.5*(rules->via3->minW-rules->via2->minW)
        ?endOffset   -1.0
        ?space viaPitch - rules->via3->minW
        ?diagonal t
      )
      liconD = list(
        ?layer  rules->licon->layer
        ?width  rules->licon->minW
        ?length rules->licon->minW
        ?gap    "minimum"
        ?beginOffset 0.0
        ?endOffset   0.0
        ?space viaPitch - rules->licon->minW
        ?diagonal t
      )
      mconD = list(
        ?layer  rules->mcon->layer
        ?width  rules->mcon->minW
        ?length rules->mcon->minW
        ?gap    "minimum"
        ?beginOffset -viaSP + 0.5*(rules->mcon->minW-rules->licon->minW)
        ?endOffset   0.0
        ?space viaPitch - rules->mcon->minW
        ?diagonal t
      )
      via1D = list(
        ?layer  rules->via1->layer
        ?width  rules->via1->minW
        ?length rules->via1->minW
        ?gap    "minimum"
        ?beginOffset -2*viaSP + 0.5*(rules->via1->minW-rules->mcon->minW)
        ?endOffset   0.0
        ?space viaPitch - rules->via1->minW
        ?diagonal t
      )
      via2D = list(
        ?layer  rules->via2->layer
        ?width  rules->via2->minW
        ?length rules->via2->minW
        ?gap    "minimum"
        ?beginOffset -3*viaSP + 0.5*(rules->via2->minW-rules->via1->minW)
        ?endOffset   0.0
        ?space viaPitch - rules->via2->minW
        ?diagonal t
      )
      via3D = list(
        ?layer  rules->via3->layer
        ?width  rules->via3->minW
        ?length rules->via3->minW
        ?gap    "minimum"
        ?beginOffset -4*viaSP + 0.5*(rules->via3->minW-rules->via2->minW)
        ?endOffset   0.0
        ?space viaPitch - rules->via3->minW
        ?diagonal t
      )

      for( i 0 numAnchors-1
        let( ( xMin xMax yMin yMax pointsH1 pointsV1 pointsD1 ppointsD1 )

          if( endStyle == "extended" then
            xMin = yMin = 0.0 - i*(w+sp)
          else
            xMin = yMin = 0.0
          ); if extended

          xMax = x + i*(w+sp)
          yMax = y + i*(w+sp)
          pathX = xMax + halfW
          pathY = yMax + halfW
          badj = 0.5*halfW-chamXY+i*1.5*w

          pointsH1 = list( x+badj:pathY xMin:pathY )
          pointsV1 = list( pathX:y+badj pathX:yMin )
          pointsD1 = list( x+badj:pathY pathX:y+badj )
          ppointsD1 = list( x-chamXY+i*1.5*w:yMax x-chamXY+i*1.5*w:yMax+w
            x-chamXY+i*1.5*w+halfW:yMax+w xMax+w:y-chamXY+i*1.5*w+halfW
            xMax+w:y-chamXY+i*1.5*w xMax:y-chamXY+i*1.5*w
          )
          when( anchorType == "chamfer"
            ppointsD1 = list( x-chamXY+i*1.5*w:yMax x-chamXY-halfW+i*1.5*w:yMax
              x-chamXY-halfW+i*1.5*w:yMax+w x-chamXY+i*1.5*w:yMax+w
              x-chamXY+i*1.5*w+halfW:yMax+w xMax+w:y-chamXY+i*1.5*w+halfW
              xMax+w:y-chamXY+i*1.5*w xMax+w:y-chamXY-halfW+i*1.5*w
              xMax:y-chamXY-halfW+i*1.5*w xMax:y-chamXY+i*1.5*w
            )
          ); when chamfer

          when( anchorType == "full" || anchorType == "horizontal"
            rodCreatePath(
              ?cvId cv
              ?name sprintf(nil "anchH%d" i)
              ?layer rules->poly->layer
              ?width 3.0
              ?pts pointsH1
              ?subRect list( licon mcon via1 via2 via3 )
            )
            rodUnNameShape(rodGetObj(sprintf(nil "anchH%d" i) cv))
          ); when full/horz
          when( anchorType == "full" || anchorType == "vertical"
            rodCreatePath(
              ?cvId cv
              ?name sprintf(nil "anchV%d" i)
              ?layer rules->poly->layer
              ?width 3.0
              ?pts pointsV1
              ?subRect list( licon mcon via1 via2 via3 )
            )
            rodUnNameShape(rodGetObj(sprintf(nil "anchV%d" i) cv))
          ); when full/vert
          when( anchorType == "full" || anchorType == "chamfer"
            rodCreatePath(
              ?cvId cv
              ?name sprintf(nil "anchD%d" i)
              ?layer rules->poly->layer
              ?width 3.0
              ?pts pointsD1
              ?subRect list( liconD mconD via1D via2D via3D )
            )
            rodUnNameShape(rodGetObj(sprintf(nil "anchD%d" i) cv))
            rodCreatePolygon(
              ?cvId cv
              ?name sprintf(nil "anchpD%d" i)
              ?layer rules->poly->layer
              ?pts  ppointsD1
            )
          ); when full/vert

        ); let
      ); for numAnchors

      ; flatten everything
      foreach( lpp cv~>lpps
        lppShapes = lpp~>shapes
        when( lppShapes && car(lppShapes)->purpose == "drawing"
          dbLayerOr( cv car(lppShapes)->lpp lppShapes )
          foreach(shape lppShapes dbDeleteObject(shape))
        ); when lppShapes
      ); foreach lpp shape

      ; generate npc layers
      dbLayerSize( cv "npc"
         setof(shape cv->shapes shape->layerName == rules->licon->layer ) rules->npc->minOLpcont )
      ; generate other metal layers
      polyShapes = setof( shape cv->shapes shape->layerName == rules->poly->layer )
      dbLayerSize( cv rules->li->layer polyShapes 0.0 )
      dbLayerSize( cv rules->met1->layer polyShapes 0.0 )
      dbLayerSize( cv rules->met2->layer polyShapes 0.0 )
      dbLayerSize( cv rules->met3->layer polyShapes 0.0 )
      dbLayerSize( cv rules->met4->layer polyShapes 0.0 )

    ); let
  ); pcDefinePCell layout
  printf("  ...layout view created\n")

  ;===========================================================
  ;***** CDF definition *****
  ;===========================================================

  let( ( cellId cdf )

    unless( cellId = ddGetObj( libName anchor->deviceName )
      error( "Could not get cell object Lib: %s, Cell:%s" libName anchor->deviceName )
    ); unless

    when( cdf = cdfGetBaseCellCDF( cellId )
      cdfDeleteCDF( cdf )
    ); when
    cdf = cdfCreateBaseCellCDF( cellId )

    cdfCreateParam( cdf
      ?name           "x"
      ?prompt         "X length (internal)"
      ?type           "float"
      ?defValue       anchor->defX
      ?storeDefault   "yes"
      ?callback       sprintf( nil "%s('x)" anchor->paramCB )
    )
    cdfCreateParam( cdf
      ?name           "y"
      ?prompt         "Y length (internal)"
      ?type           "float"
      ?defValue       anchor->defY
      ?storeDefault   "yes"
      ?callback       sprintf( nil "%s('y)" anchor->paramCB )
    )
    cdfCreateParam( cdf
      ?name           "z"
      ?prompt         "Chamfer length (internal)"
      ?type           "float"
      ?defValue       anchor->defZ
      ?storeDefault   "yes"
      ?callback       sprintf( nil "%s('z)" anchor->paramCB )
    )
    cdfCreateParam( cdf
      ?name           "numAnchors"
      ?prompt         "# Anchors"
      ?defValue       1
      ?type           "int"
      ?storeDefault  "yes"
      ?callback       sprintf( nil "%s('numAnchors)" anchor->paramCB )
    )
    cdfCreateParam( cdf
      ?name           "endStyle"
      ?prompt         "End Style"
      ?defValue       "aligned"
      ?choices        '("aligned" "extended")
      ?type           "radio"
      ?storeDefault  "yes"
    )
    cdfCreateParam( cdf
      ?name           "anchorType"
      ?prompt         "Part(s)"
      ?defValue       "full"
      ?choices        '("full" "horizontal" "vertical" "chamfer")
      ?type           "radio"
      ?storeDefault  "yes"
    )


    ;;; Properties
    cdf->formInitProc              = "S130disablePcellChange"
    cdf->doneProc                  = ""
    cdf->buttonFieldWidth          = 250
    cdf->fieldHeight               = 35
    cdf->fieldWidth                = 250
    cdf->promptWidth               = 120
    cdf->modelLabelSet             = ""
    cdf->opPointLabelSet           = ""
    cdf->paramLabelSet             = ""
    cdf->instDisplayMode         = "instName"
    cdf->instNameType            = "schematic"
    cdf->termDisplayMode         = "netName"
    cdf->netNameType             = "schematic"

    cdfSaveCDF(cdf)

  ); let cdf

); let

/*==================================  EOF  ===================================*/

