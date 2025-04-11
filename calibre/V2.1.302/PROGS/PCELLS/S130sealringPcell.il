/*==============================================================================
  File:         S130sealringPcell.il
  Purpose:      Pcell code for layout and cdf setup for the sealring
                for Skywater S130 Pcell

  Created:      July 02, 2020  Madek Graham
  Description:  Pcell code to create sealring
  
  Devices/views:  sealring / layout

------------------------------------------------------------
  Modifications:

9/28/2021 - CBPL updating SealRing pcell to add 2 parameters dieW=w+6microns dieL=l+6microns
					Changed display w/l to nil

==============================================================================*/

let( ( libName )

  libName = "S130"

  printf("Creating %s in %s library\n" sealring->deviceName libName )

  ;===========================================================
  ;***** Define Layout Pcell *****
  ;===========================================================
  pcDefinePCell( list( ddGetObj(libName) sealring->deviceName "layout" )
    ; formal parameters name value pairs
    (
      ( devInfo       "ilList"  sealring )
      ( grid          "float"   techGetMfgGridResolution(techGetTechFile(ddGetObj(libName))) )
      ( w             "float"   sealring->defW )
      ( l             "float"   sealring->defL )
      ( dieW        "float"   sealring->defDieW )
      ( dieL        "float"   sealring->defDieL )
      ( extraCut      "float"   sealring->defExtraCut )
    )
      
    let( ( cv cfomMdW crossX crossY crosses cutout
        diff1InnerBev diff1InnerEdge diff1InnerPoints diff1OuterBev diff1OuterEdge diff1OuterPoints
        diff2InnerBev diff2InnerEdge diff2InnerPoints diff2OuterBev diff2OuterEdge diff2OuterPoints
        diff3InnerBev diff3InnerEdge diff3InnerPoints diff3OuterBev diff3OuterEdge diff3OuterPoints
        diff4InnerBev diff4InnerEdge diff4InnerPoints diff4OuterBev diff4OuterEdge diff4OuterPoints
        diffSP diffW nikonOctBevL nikonOctPoints nikonOctW nikonOffset nsmInnerBev nsmInnerPoints
        nsmOLdiff nsmOuterBev nsmOuterPoints nsmW seal sealBevW sealInnerPoints sealOuterPoints
        sealW temp totalL totalW slotW slotEdgeSP slotSP slotPitch num13VertStrips num24VertStrips
        num13HorzStrips num24HorzStrips vert13StripsL vert24StripsL horz13StripsL horz24StripsL
        strips13 strips24 stepX stepY )

      cv = pcCellView
      dbReplaceProp(cv "instNamePrefix" "string" "SEALRING")

      sealW = devInfo->minWseal
      totalW = w + 2*sealW
      totalL = l + 2*sealW
      nsmW = devInfo->minWnsm
      diffW = devInfo->minDiffW
      diffSP = devInfo->mindiffSP
      nsmOLdiff = devInfo->minNsmOLdiff
      nikonOctW = devInfo->octW
      nikonOctBevL = devInfo->octLbevel
      nikonOffset = devInfo->nikonOffset

      ; get some dimension values for later use for the bevels (additional values taken from s8 sealring)
      sealBevW = devInfo->minLcut + extraCut
      nsmInnerBev   = sealW + sealBevW - 0.415
      nsmOuterBev   = sealW + sealBevW - 2.490
      ; diff1 is the inner most diff ring, diff4 is the outer most
      diff1InnerBev = sealW + sealBevW - 1.015
      diff1OuterBev = sealW + sealBevW - 1.140
      diff2InnerBev = sealW + sealBevW - 1.265
      diff2OuterBev = sealW + sealBevW - 1.390
      diff3InnerBev = sealW + sealBevW - 1.515
      diff3OuterBev = sealW + sealBevW - 1.640
      diff4InnerBev = sealW + sealBevW - 1.765
      diff4OuterBev = sealW + sealBevW - 1.890
      diff1InnerEdge = nsmOLdiff + 3*(diffW + diffSP) + diffW
      diff1OuterEdge = nsmOLdiff + 3*(diffW + diffSP)
      diff2InnerEdge = nsmOLdiff + 2*(diffW + diffSP) + diffW
      diff2OuterEdge = nsmOLdiff + 2*(diffW + diffSP)
      diff3InnerEdge = nsmOLdiff + 1*(diffW + diffSP) + diffW
      diff3OuterEdge = nsmOLdiff + 1*(diffW + diffSP)
      diff4InnerEdge = nsmOLdiff + diffW
      diff4OuterEdge = nsmOLdiff

      sealOuterPoints = list( 0:0 totalW:totalL )
      sealInnerPoints = list( sealW:sealBevW+sealW
        sealW:totalL-sealW-sealBevW sealW+sealBevW:totalL-sealW
        totalW-sealW-sealBevW:totalL-sealW totalW-sealW:totalL-sealW-sealBevW
        totalW-sealW:sealW+sealBevW totalW-sealW-sealBevW:sealW
        sealW+sealBevW:sealW
      )
      nsmOuterPoints = list( 0:nsmOuterBev
        0:totalL-nsmOuterBev nsmOuterBev:totalL
        totalW-nsmOuterBev:totalL totalW:totalL-nsmOuterBev
        totalW:nsmOuterBev totalW-nsmOuterBev:0
        nsmOuterBev:0
      )
      nsmInnerPoints = list( nsmW:nsmInnerBev
        nsmW:totalL-nsmInnerBev nsmInnerBev:totalL-nsmW
        totalW-nsmInnerBev:totalL-nsmW totalW-nsmW:totalL-nsmInnerBev
        totalW-nsmW:nsmInnerBev totalW-nsmInnerBev:nsmW
        nsmInnerBev:nsmW
      )
      diff1OuterPoints = list( diff1OuterEdge:diff1OuterBev
        diff1OuterEdge:totalL-diff1OuterBev diff1OuterBev:totalL-diff1OuterEdge
        totalW-diff1OuterBev:totalL-diff1OuterEdge totalW-diff1OuterEdge:totalL-diff1OuterBev
        totalW-diff1OuterEdge:diff1OuterBev totalW-diff1OuterBev:diff1OuterEdge
        diff1OuterBev:diff1OuterEdge
      )
      diff1InnerPoints = list( diff1InnerEdge:diff1InnerBev
        diff1InnerEdge:totalL-diff1InnerBev diff1InnerBev:totalL-diff1InnerEdge
        totalW-diff1InnerBev:totalL-diff1InnerEdge totalW-diff1InnerEdge:totalL-diff1InnerBev
        totalW-diff1InnerEdge:diff1InnerBev totalW-diff1InnerBev:diff1InnerEdge
        diff1InnerBev:diff1InnerEdge
      )
      diff2OuterPoints = list( diff2OuterEdge:diff2OuterBev
        diff2OuterEdge:totalL-diff2OuterBev diff2OuterBev:totalL-diff2OuterEdge
        totalW-diff2OuterBev:totalL-diff2OuterEdge totalW-diff2OuterEdge:totalL-diff2OuterBev
        totalW-diff2OuterEdge:diff2OuterBev totalW-diff2OuterBev:diff2OuterEdge
        diff2OuterBev:diff2OuterEdge
      )
      diff2InnerPoints = list( diff2InnerEdge:diff2InnerBev
        diff2InnerEdge:totalL-diff2InnerBev diff2InnerBev:totalL-diff2InnerEdge
        totalW-diff2InnerBev:totalL-diff2InnerEdge totalW-diff2InnerEdge:totalL-diff2InnerBev
        totalW-diff2InnerEdge:diff2InnerBev totalW-diff2InnerBev:diff2InnerEdge
        diff2InnerBev:diff2InnerEdge
      )
      diff3OuterPoints = list( diff3OuterEdge:diff3OuterBev
        diff3OuterEdge:totalL-diff3OuterBev diff3OuterBev:totalL-diff3OuterEdge
        totalW-diff3OuterBev:totalL-diff3OuterEdge totalW-diff3OuterEdge:totalL-diff3OuterBev
        totalW-diff3OuterEdge:diff3OuterBev totalW-diff3OuterBev:diff3OuterEdge
        diff3OuterBev:diff3OuterEdge
      )
      diff3InnerPoints = list( diff3InnerEdge:diff3InnerBev
        diff3InnerEdge:totalL-diff3InnerBev diff3InnerBev:totalL-diff3InnerEdge
        totalW-diff3InnerBev:totalL-diff3InnerEdge totalW-diff3InnerEdge:totalL-diff3InnerBev
        totalW-diff3InnerEdge:diff3InnerBev totalW-diff3InnerBev:diff3InnerEdge
        diff3InnerBev:diff3InnerEdge
      )
      diff4OuterPoints = list( diff4OuterEdge:diff4OuterBev
        diff4OuterEdge:totalL-diff4OuterBev diff4OuterBev:totalL-diff4OuterEdge
        totalW-diff4OuterBev:totalL-diff4OuterEdge totalW-diff4OuterEdge:totalL-diff4OuterBev
        totalW-diff4OuterEdge:diff4OuterBev totalW-diff4OuterBev:diff4OuterEdge
        diff4OuterBev:diff4OuterEdge
      )
      diff4InnerPoints = list( diff4InnerEdge:diff4InnerBev
        diff4InnerEdge:totalL-diff4InnerBev diff4InnerBev:totalL-diff4InnerEdge
        totalW-diff4InnerBev:totalL-diff4InnerEdge totalW-diff4InnerEdge:totalL-diff4InnerBev
        totalW-diff4InnerEdge:diff4InnerBev totalW-diff4InnerBev:diff4InnerEdge
        diff4InnerBev:diff4InnerEdge
      )
      nikonOctPoints = list( -0.5*nikonOctW:-0.5*nikonOctW+nikonOctBevL
        -0.5*nikonOctW:0.5*nikonOctW-nikonOctBevL
        -0.5*nikonOctW+nikonOctBevL:0.5*nikonOctW
        0.5*nikonOctW-nikonOctBevL:0.5*nikonOctW
        0.5*nikonOctW:0.5*nikonOctW-nikonOctBevL
        0.5*nikonOctW:-0.5*nikonOctW+nikonOctBevL
        0.5*nikonOctW-nikonOctBevL:-0.5*nikonOctW
        -0.5*nikonOctW+nikonOctBevL:-0.5*nikonOctW
      )

      ; create the crit markers
      dbCreateRect( cv devInfo->critSidLay list(0:0 totalW:devInfo->critSidW) )
      dbCreateRect( cv devInfo->critSidLay list(0:totalL - devInfo->critSidW totalW:totalL) )
      dbCreateRect( cv devInfo->critSidLay list(0:0 devInfo->critSidW:totalL) )
      dbCreateRect( cv devInfo->critSidLay list(totalW - devInfo->critSidW:0 totalW:totalL) )
      dbCreateEllipse( cv devInfo->critCornerLay
        list( -devInfo->critCornerR:-devInfo->critCornerR devInfo->critCornerR:devInfo->critCornerR ) )
      temp = dbCreateEllipse( cv devInfo->critCornerLay
        list( -devInfo->critCornerR:-devInfo->critCornerR devInfo->critCornerR:devInfo->critCornerR ) )
      dbMoveShape(temp cv list(0:totalL "R0"))
      temp = dbCreateEllipse( cv devInfo->critCornerLay
        list( -devInfo->critCornerR:-devInfo->critCornerR devInfo->critCornerR:devInfo->critCornerR ) )
      dbMoveShape(temp cv list(totalW:totalL "R0"))
      temp = dbCreateEllipse( cv devInfo->critCornerLay
        list( -devInfo->critCornerR:-devInfo->critCornerR devInfo->critCornerR:devInfo->critCornerR ) )
      dbMoveShape(temp cv list(totalW:0 "R0"))

      ; create nikon crosses
      crosses = list()
      foreach( layer devInfo->nikonCrossLays
        foreach( corner list( list(nikonOffset:nikonOffset "R0") list(nikonOffset:totalL-nikonOffset "R0")
          list(totalW-nikonOffset:totalL-nikonOffset "R0") list(totalW-nikonOffset:nikonOffset "R0") )
          crossX = dbCreatePath(cv layer list(-0.5*devInfo->crossL:0 0.5*devInfo->crossL:0) devInfo->crossW)
          crossY = dbCreatePath(cv layer list(0:-0.5*devInfo->crossL 0:0.5*devInfo->crossL) devInfo->crossW)
          dbMoveShape( crossX cv corner ) dbMoveShape( crossY cv corner )
          crosses = append( crosses dbLayerOr(cv layer list(crossX crossY)))
          dbDeleteObject(crossX) dbDeleteObject(crossY)
        ); foreach corner
      ); foreach nikonCrossLays

      ; create nikon cross octogons
      foreach( layer devInfo->nikonOctLays
        foreach( corner list( list(nikonOffset:nikonOffset "R0") list(nikonOffset:totalL-nikonOffset "R0")
          list(totalW-nikonOffset:totalL-nikonOffset "R0") list(totalW-nikonOffset:nikonOffset "R0") )
          temp = dbCreatePolygon(cv layer nikonOctPoints)
          dbMoveShape( temp cv corner )
          dbLayerAndNot( cv layer list( temp ) crosses )
          dbDeleteObject(temp)
        ); foreach corner
      ); foreach nikonOctLays

      ; time to get crazy... some temp layers will be created to be used later to cut out the center
      ; areas to thus create octogon donut shapes
      ; create seal marker
      temp   = dbCreateRect( cv devInfo->sealLay sealOuterPoints )
      cutout = dbCreatePolygon( cv devInfo->sealLay sealInnerPoints )
      seal = dbLayerAndNot( cv devInfo->sealLay list( temp ) list( cutout ) )
      dbDeleteObject(temp) dbDeleteObject(cutout)

      ; create nsm layer & corner triangles
      temp   = dbCreatePolygon( cv devInfo->nsmLay nsmOuterPoints )
      cutout = dbCreatePolygon( cv devInfo->nsmLay nsmInnerPoints )
      dbLayerAndNot( cv devInfo->nsmLay list( temp ) list( cutout ) )
      dbLayerAndNot( cv devInfo->cornerLay seal append1(crosses temp) )
      dbDeleteObject(temp) dbDeleteObject(cutout)

      ; create strips to cut diff
      slotW = devInfo->minWdiffSlot
      slotSP = sealring->minSlotSP
      slotPitch = slotW + slotSP
      slotEdgeSP = sealring->minSlotSPedge
      num13VertStrips = 1 + floor((totalW - 2*slotEdgeSP - slotW)/slotPitch)
      num24VertStrips = 1 + floor((totalW - 2*slotEdgeSP - slotW - 0.5*slotPitch)/slotPitch)
      vert13StripsL = slotW + (num13VertStrips - 1)*slotPitch
      vert24StripsL = slotW + (num24VertStrips - 1)*slotPitch
      when( num13VertStrips == num24VertStrips &&
            totalW < vert24StripsL + 2*slotEdgeSP + slotPitch
        num24VertStrips = num24VertStrips - 1
        vert24StripsL = slotW + (num24VertStrips - 1)*slotPitch
      ); when
      num13HorzStrips = 1 + floor((totalL - 2*slotEdgeSP - slotW)/slotPitch)
      num24HorzStrips = 1 + floor((totalL - 2*slotEdgeSP - slotW - 0.5*slotPitch)/slotPitch)
      horz13StripsL = slotW + (num13HorzStrips - 1)*slotPitch
      horz24StripsL = slotW + (num24HorzStrips - 1)*slotPitch
      when( num13HorzStrips == num24HorzStrips &&
            totalL < horz24StripsL + 2*slotEdgeSP + slotPitch
        num24HorzStrips = num24HorzStrips - 1
        horz24StripsL = slotW + (num24HorzStrips - 1)*slotPitch
      ); when

      strips13 = list()
      strips24 = list()
      stepX = round(0.5*(totalW - vert13StripsL)/grid)*grid
      for( i 1 num13VertStrips
        temp = dbCreateRect( cv devInfo->diffLay list( stepX:0 stepX+slotW:totalL ) )
        strips13 = append1( strips13 temp )
        stepX = stepX + slotPitch
      ); for num13VertStrips
      stepY = round(0.5*(totalL - horz13StripsL)/grid)*grid
      for( i 1 num13HorzStrips
        temp = dbCreateRect( cv devInfo->diffLay list( 0:stepY totalW:stepY+slotW ) )
        strips24 = append1( strips24 temp )
        stepY = stepY + slotPitch
      ); for num13HorzStrips

      stepX = 0.5*slotPitch + round(0.5*(totalW - vert13StripsL)/grid)*grid
      for( i 1 num24VertStrips
        temp = dbCreateRect( cv devInfo->diffLay list( stepX:0 stepX+slotW:totalL ) )
        strips24 = append1( strips24 temp )
        stepX = stepX + slotPitch
      ); for num24VertStrips
      stepY = 0.5*slotPitch + round(0.5*(totalL - horz13StripsL)/grid)*grid
      for( i 1 num24HorzStrips
        temp = dbCreateRect( cv devInfo->diffLay list( 0:stepY totalW:stepY+slotW ) )
        strips13 = append1( strips13 temp )
        stepY = stepY + slotPitch
      ); for num24HorzStrips

      ; create diff layers
      ; inner diff ring
      temp   = dbCreatePolygon( cv devInfo->diffLay diff1OuterPoints )
      cutout = dbCreatePolygon( cv devInfo->diffLay diff1InnerPoints )
      ; use this if cuts in diff are desired over using cfom:maskDrop
      ;dbLayerAndNot( cv devInfo->diffLay list( temp ) append1( strips13 cutout ) )
      ;dbDeleteObject(temp) dbDeleteObject(cutout)
      diff1 = dbLayerAndNot( cv devInfo->diffLay list( temp ) list( cutout ) )
      diff1 = dbLayerSize( cv devInfo->diffLay diff1 0.025 )
      dbLayerAnd( cv devInfo->maskDropLay diff1 strips13 )
      dbDeleteObject(temp) dbDeleteObject(cutout)

      ; next inner diff ring
      temp   = dbCreatePolygon( cv devInfo->diffLay diff2OuterPoints )
      cutout = dbCreatePolygon( cv devInfo->diffLay diff2InnerPoints )
      ; use this if cuts in diff are desired over using cfom:maskDrop
      ;dbLayerAndNot( cv devInfo->diffLay list( temp ) append1( strips24 cutout ) )
      ;dbDeleteObject(temp) dbDeleteObject(cutout)
      diff2 = dbLayerAndNot( cv devInfo->diffLay list( temp ) list( cutout ) )
      diff2 = dbLayerSize( cv devInfo->diffLay diff2 0.025 )
      dbLayerAnd( cv devInfo->maskDropLay diff2 strips24 )
      dbDeleteObject(temp) dbDeleteObject(cutout)

      ; next inner diff ring
      temp   = dbCreatePolygon( cv devInfo->diffLay diff3OuterPoints )
      cutout = dbCreatePolygon( cv devInfo->diffLay diff3InnerPoints )
      ; use this if cuts in diff are desired over using cfom:maskDrop
      ;dbLayerAndNot( cv devInfo->diffLay list( temp ) append1( strips13 cutout ) )
      diff3 = dbLayerAndNot( cv devInfo->diffLay list( temp ) list( cutout ) )
      diff3 = dbLayerSize( cv devInfo->diffLay diff3 0.025 )
      dbLayerAnd( cv devInfo->maskDropLay diff3 strips13 )
      dbDeleteObject(temp) dbDeleteObject(cutout)

      ; outer most diff ring
      temp   = dbCreatePolygon( cv devInfo->diffLay diff4OuterPoints )
      cutout = dbCreatePolygon( cv devInfo->diffLay diff4InnerPoints )
      ; use this if cuts in diff are desired over using cfom:maskDrop
      ;dbLayerAndNot( cv devInfo->diffLay list( temp ) append1( strips24 cutout ) )
      diff4 = dbLayerAndNot( cv devInfo->diffLay list( temp ) list( cutout ) )
      diff4 = dbLayerSize( cv devInfo->diffLay diff4 0.025 )
      dbLayerAnd( cv devInfo->maskDropLay diff4 strips24 )
      dbDeleteObject(temp) dbDeleteObject(cutout)

      ; remove temp layers used for diff cuts/cfom:maskDrop
      foreach( strip strips13 dbDeleteObject(strip) )
      foreach( strip strips24 dbDeleteObject(strip) )
      ; if maskdrop is used
      foreach( diff append( diff1 append( diff2 append( diff3 diff4 ))) dbDeleteObject(diff) )

    ); let
  ); pcDefinePCell layout
  printf("  ...layout view created\n")

  ;===========================================================
  ;***** CDF definition *****
  ;===========================================================

  let( ( cellId cdf tfId )

    unless( cellId = ddGetObj( libName sealring->deviceName )
      error( "Could not get cell object Lib: %s, Cell:%s" libName sealring->deviceName )
    ); unless

    when( cdf = cdfGetBaseCellCDF( cellId )
      cdfDeleteCDF( cdf )
    ); when
    cdf = cdfCreateBaseCellCDF( cellId )

    tfId = techGetTechFile(cellId)

    cdfCreateParam( cdf
      ?name           "w"
      ?prompt         "Width Inner"
      ?type           "float"
      ?defValue       sealring->defW
      ?storeDefault   "yes"
      ?callback       sprintf( nil "%s('w)" sealring->paramCB )
     ; ?editable       "t"
		?editable		"nil"
    )
    cdfCreateParam( cdf
      ?name           "l"
      ?prompt         "Length Inner"
      ?type           "float"
      ?defValue       sealring->defL
      ?storeDefault   "yes"
      ?callback       sprintf( nil "%s('l)" sealring->paramCB )
     ; ?editable       "t"
		?editable		"nil"
    )

    cdfCreateParam( cdf
      ?name           "dieW"
      ?prompt         "Die X"
      ?type           "float"
      ?defValue       sealring->defDieW
      ?storeDefault   "yes"
      ?callback       sprintf( nil "%s('dieW)" sealring->paramCB )
      ?editable       "t"
    )
    cdfCreateParam( cdf
      ?name           "dieL"
      ?prompt         "Die Y"
      ?type           "float"
      ?defValue       sealring->defDieW
      ?storeDefault   "yes"
      ?callback       sprintf( nil "%s('dieL)" sealring->paramCB )
      ?editable       "t"
    )
    cdfCreateParam( cdf
      ?name           "extraCut"
      ?prompt         "Extra Corner Cut"
      ?type           "float"
      ?defValue       sealring->defExtraCut
      ?storeDefault   "yes"
      ?callback       sprintf( nil "%s('extraCut)" sealring->paramCB )
      ?editable       "t"
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

