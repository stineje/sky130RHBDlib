/*==============================================================================
  File:         S130mimcapPcell.il
  Purpose:      Pcell code for layout and symbols, and cdf setup for mim caps
                for Skywater S130 Pcells

  Created:      Apr 19, 2020  Madek Graham
  Description:  Pcell code to create mim cap devices
  
  Devices/views:  cm3m4 / symbol auCdl auLvs spectre layout
                  cm4m5 / symbol auCdl auLvs spectre layout

------------------------------------------------------------
  Modifications:
  - Apr 25, 2020 Madek Graham
    Removed singlePlate and rows/cols, and made m editable

==============================================================================*/

/*==============================================================================

  This file only needs to be loaded once to create the pcells and cdf information
  for the capDevices set within the S130techData.il file

==============================================================================*/

let( ( libName )

  libName = "S130"

  foreach( device capDevices

    printf("Creating device %s in %s library\n" device->deviceName libName )

    ;===========================================================
    ;***** Define Layout Pcell *****
    ;===========================================================

    pcDefinePCell( list( ddGetObj(libName) device->deviceName "layout" )
      ; formal parameters name value pairs
      (
        ( devInfo         "ilList"  device )
        ( grid            "float"   techGetMfgGridResolution(techGetTechFile(ddGetObj(libName))) )
        ( w               "float"   device->defW )
        ( l               "float"   device->defL )
      )

      let(( cv cap botMet topMet )
        cv = pcCellView
        dbReplaceProp(cv "instNamePrefix" "string" "C")

        ; create the layers and vias
        ;-----------------------------
        cap = rodCreateRect(
          ?cvId     cv
          ?name     "cap"
          ?layer    devInfo->capLay->layer
          ?width    w
          ?length   l
          ?origin   list(0.0 0.0)
        )
        botMet = rodCreateRect(
          ?cvId     cv
          ?name     "botMet"
          ?layer    devInfo->botLay->layer
          ?width    w + 2*devInfo->capLay->minBotPlateOL
          ?length   l + 2*devInfo->capLay->minBotPlateOL
          ?netName  "MINUS"
          ?termName "MINUS"
          ?termIOType "inputOutput"
          ?origin   list(0.0 - devInfo->capLay->minBotPlateOL
                      0.0 - devInfo->capLay->minBotPlateOL)
        )
        rodCreateRect(
          ?cvId     cv
          ?name     "botMetPin"
          ?layer    list( devInfo->botLay->pinlayer devInfo->botLay->pinpurpose )
          ?width    botMet->width
          ?length   botMet->length
          ?netName  "MINUS"
          ?termName "MINUS"
          ?termIOType "inputOutput"
          ?pin      t
          ?pinLabel t
          ?pinLabelHeight 0.25*devInfo->capLay->minViaW
          ?pinLabelLayer  list( devInfo->botLay->layer "label")
          ?pinLabelFont   "stick"
          ?pinLabelRefHandle "lowerCenter"
          ?pinLabelJust "lowerCenter"
          ?pinLabelOffsetPoint 0:10*grid
          ?origin   botMet->lowerLeft
        )
        rodFillWithRects(
          ?shapeId          cap->dbId
          ?fillShapeLPP     list(devInfo->viaLay->layer devInfo->viaLay->purpose)
          ?fillShapeWidth   devInfo->capLay->minViaW
          ?fillShapeLength  devInfo->capLay->minViaW
          ?gap              "minimum"
          ?justification    "centerCenter"
          ?spaceX           devInfo->capLay->minViaSP
          ?spaceY           devInfo->capLay->minViaSP
          ?enclosureX       max( devInfo->capLay->minOLvia
                              devInfo->botLay->minOLSviaU - devInfo->capLay->minBotPlateOL
                              devInfo->topLay->minOLSviaL - devInfo->capLay->minTopPlateOL
                            )
          ?enclosureY       max( devInfo->capLay->minOLvia
                              devInfo->botLay->minOLSviaU - devInfo->capLay->minBotPlateOL
                              devInfo->topLay->minOLSviaL - devInfo->capLay->minTopPlateOL
                            )
          ?grid             grid
        )
        topMet = rodCreateRect(
          ?cvId     cv
          ?name     "topMet"
          ?layer    devInfo->topLay->layer
          ?width    w + 2*devInfo->capLay->minTopPlateOL
          ?length   l + 2*devInfo->capLay->minTopPlateOL
          ?netName  "PLUS"
          ?termName "PLUS"
          ?termIOType "inputOutput"
          ?origin   list(0.0 - devInfo->capLay->minTopPlateOL
                      0.0 - devInfo->capLay->minTopPlateOL)
        )
        rodCreateRect(
          ?cvId     cv
          ?name     "topMetPin"
          ?layer    list( devInfo->topLay->pinlayer devInfo->topLay->pinpurpose )
          ?width    topMet->width
          ?length   topMet->length
          ?netName  "PLUS"
          ?termName "PLUS"
          ?termIOType "inputOutput"
          ?pin      t
          ?pinLabel t
          ?pinLabelHeight 0.25*devInfo->capLay->minViaW
          ?pinLabelLayer  list( devInfo->topLay->layer "label")
          ?pinLabelFont   "stick"
          ?pinLabelRefHandle "upperCenter"
          ?pinLabelJust "upperCenter"
          ?pinLabelOffsetPoint 0:-10*grid
          ?origin   topMet->lowerLeft
        )

      ); let
    ); pcDefinePCell layout

    ;===========================================================
    ;***** Define Symbol Pcell *****
    ;===========================================================

    foreach( view list("symbol" "auCdl" "auLvs" "spectre")
      pcDefinePCell( list( ddGetObj(libName) device->deviceName view "schematicSymbol" "w")
        ; formal parameters name value pairs
        (
          ( m   "int"   1 )
        )
        let( (cv modelLabel instLabel labelC labelWL labelM
            netm netp plus minus termP termM paramLabel)

        cv = pcCellView

        dbReplaceProp(cv "instNamePrefix" "string" "C")

        ; bounding box and main labels
        ;-----------------------------
        dbCreateRect(cv list("instance" "drawing") list(-0.0625:-0.375 0.0625:0.0))
        modelLabel = dbCreateLabel( cv list("text" "drawing") -0.0625:0.015625 "[@model]"
          "centerRight" "R0" "stick" 0.03125 )
        modelLabel~>labelType = "NLPLabel"
        instLabel = dbCreateLabel( cv list("annotate" "drawing7") -0.0625:-0.046875 "[@instanceName]"
          "centerRight" "R0" "stick" 0.0625 )
        instLabel~>labelType = "NLPLabel"

        labelC = dbCreateLabel( cv list("annotate" "drawing") -0.0625:-0.140625 "[@actualC:%fF]"
          "centerRight" "R0" "stick" 0.0625 )
        labelC~>labelType = "NLPLabel"
        labelWL = dbCreateLabel(cv list("annotate" "drawing") -0.0625:-0.234375
          "[@w:%] x [@l:%]" "centerRight" "R0" "stick" 0.03125)
        labelWL->labelType = "NLPLabel"
        labelM = dbCreateLabel(cv list("annotate" "drawing") -0.0625:-0.296875
        "[@m:M=%]" "centerRight" "R0" "stick" 0.03125)
        labelM->labelType = "NLPLabel"

        ; create nets and pins
        ;-----------------------------
        netp = dbMakeNet(cv "PLUS")
        dbCreateTerm(netp "PLUS" "inputOutput")
        plus = dbCreateRect(cv list("pin" "drawing")
          list(-0.01875:-0.01875 0.01875:0.01875) )
        dbCreatePin(netp plus)
        termP = dbCreateLabel( cv list("annotate" "drawing8") 0.0125:0.0 "cdsTerm(\"PLUS\")"
          "upperLeft" "R90" "stick" 0.01875 )
        termP~>labelType = "ILLabel"
        termP->parent = plus

        netm = dbMakeNet(cv "MINUS")
        dbCreateTerm(netm "MINUS"  "inputOutput")
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
        paramLabel = dbCreateLabel( cv list("annotate" "drawing") 0.0625:-0.15625 "cdsParam(3)"
          "lowerLeft" "R0" "stick" 0.03125 )
        paramLabel~>labelType = "ILLabel"
        paramLabel = dbCreateLabel( cv list("annotate" "drawing") 0.0625:-0.21875 "cdsParam(4)"
          "lowerLeft" "R0" "stick" 0.03125 )
        paramLabel~>labelType = "ILLabel"

        ; main cap drawing
        ;-----------------------------
        dbCreateLine(cv list("device" "drawing") list(0.0:0.0 0.0:-0.1375) )
        dbCreateLine(cv list("device" "drawing") list(0.0:-0.175 0.0:-0.375) )
        dbCreateLine(cv list("device" "drawing") list(-0.0625:-0.1375 0.0625:-0.1375) )
        dbCreateArc(cv list("device" "drawing") list(-0.0875:-0.35 0.0875:-0.175)
          list(-0.0625:-0.2 0.0625:-0.175) )

        ); let
      ); pcDefinePCell
    ); foreach view

    ;===========================================================
    ;***** CDF definition *****
    ;===========================================================

    let( ( cellName cellId cdf defC )

      cellName = device->deviceName

      unless( cellId = ddGetObj( libName cellName )
        error( "Could not get cell object Lib: %s, Cell:%s" libName cellName )
      ); unless

      when( cdf = cdfGetBaseCellCDF( cellId )
        cdfDeleteCDF( cdf )
      ); when
      cdf = cdfCreateBaseCellCDF( cellId )

      defC = sprintf(nil "%.2f" device->defC )

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
        ?defValue       "Capacitance"
        ?storeDefault   "yes"
        ?choices        list("Capacitance" "Capacitance & Width" "Width & Length")
      )
      cdfCreateParam( cdf
        ?name           "c"
        ?prompt         "Unit Capacitance (fF)"
        ?type           "float"
        ?defValue       device->defC
        ?editable       "cdfgData->calcMethod->value != \"Width & Length\""
        ?storeDefault   "yes"
        ?callback       strcat(device->paramCB "()")
      )
      cdfCreateParam( cdf
        ?name           "actualC"
        ?prompt         "Drawn Unit Capacitance (fF)"
        ?type           "float"
        ?defValue       device->defC
        ?editable       "nil"
        ?storeDefault   "yes"
      )
      cdfCreateParam( cdf
        ?name           "totalC"
        ?prompt         "Total Drawn Capacitance (fF)"
        ?type           "float"
        ?defValue       device->defC
        ?editable       "nil"
        ?storeDefault   "yes"
        ?display        "cdfgData->m->value > 1"
      )
      cdfCreateParam( cdf
        ?name           "w"
        ?prompt         "Width (um)"
        ?type           "float"
        ?defValue       device->defW
        ?storeDefault   "yes"
        ?callback       strcat(device->paramCB "()")
        ?editable       "cdfgData->calcMethod->value != \"Capacitance\""
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
        ?editable       "t"
        ?callback       strcat(device->paramCB "()")
        ?display        "hiGetCurrentWindow()~>cellView~>cellViewType != \"maskLayout\""
      )
      ; for cdl netlisting - hidden params
      cdfCreateParam( cdf
        ?name           "area"
        ?prompt         "unit area"
        ?type           "float"
        ?defValue       device->defW * device->defL
        ?storeDefault   "yes"
        ?display        "nil"
      )
      cdfCreateParam( cdf
        ?name           "perim"
        ?prompt         "unit perimeter"
        ?type           "float"
        ?defValue       2*device->defW + 2*device->defL
        ?storeDefault   "yes"
        ?display        "nil"
      )

      cdf->simInfo = list( nil)
      cdf->simInfo->auCdl = '( nil
        dollarEqualParams nil
        dollarParams      nil
        otherParameters   nil
        netlistProcedure  ansCdlSubcktCallExtended
        instParameters    (model A P m)
        propMapping       (nil model lvsModel A area P perim )
        componentName     nil
        termOrder         (PLUS MINUS)
        namePrefix        "C"
      )
      cdf->simInfo->auLvs = '( nil
        dollarEqualParams nil
        dollarParams      nil
        otherParameters   nil
        netlistProcedure  ansLvsCompParamPrim
        instParameters    (model A P m)
        propMapping       (nil model lvsModel A area P perim )
        termOrder         (PLUS MINUS)
        namePrefix        "C"
      )
      cdf->simInfo->spectre = '( nil
        propMapping             nil
        otherParameters         (model)
        instParameters          (w l m)
        termOrder               (PLUS MINUS)
        namePrefix              "C"
        componentName           model
      )
      cdf->simInfo->spectreS = '( nil
        propMapping             nil
        netlistProcedure        ansSpectreSDevPrim
        otherParameters         (model)
        instParameters          (w l m)
        termOrder               (PLUS MINUS)
        namePrefix              "C"
        componentName           model
      )

      ;;; Properties
      cdf->formInitProc              = "S130disablePcellChange"
      cdf->doneProc                  = ""
      cdf->buttonFieldWidth          = 340
      cdf->fieldHeight               = 35
      cdf->fieldWidth                = 370
      cdf->promptWidth               = 200
      cdf->modelLabelSet             = ""
      cdf->opPointLabelSet           = "cap"
      cdf->paramLabelSet             = ""

      cdfSaveCDF(cdf)

    );  let
  ); foreach device

);  let

/*==================================  EOF  ===================================*/
