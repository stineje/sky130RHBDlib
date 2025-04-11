/*==============================================================================
  File:         S130rmetPcell.il
  Purpose:      Pcell code for layout and symbols, and cdf setup for metal resistors
                for Skywater S130 Pcells

  Created:      Mar 12, 2020  Madek Graham
  Description:  Pcell code to create the rmet device
  
  Devices/views:  rmet / layout symbol auCdl auLvs spectre

------------------------------------------------------------
  Modifications:

==============================================================================*/

/*==============================================================================

  This file only needs to be loaded once to create the pcells and cdf information
  for the mResDevices set within the S130techData.il file

==============================================================================*/

let( ( libName )

  libName = "S130"

  foreach( device mResDevices

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
        ( rType         "string"  car(device->layers) )
        ( l             "float"   2*techGetMfgGridResolution(techGetTechFile(ddGetObj(libName))) )
        ( w             "float"   evalstring(strcat("designRules->" car(device->layers) "->minresW")) )
      )

      let(( cv termW metal mark plusPin minusPin )

        cv = pcCellView

        termW = round( (0.5*evalstring(strcat("rules->" rType "->minW")))/grid )*grid

        ; create the metal
        ;-----------------------------
        metal = rodCreateRect(
          ?cvId     cv
          ?name     "metal"
          ?layer    rType
          ?width    w
          ?length   l + 2*termW
          ?origin   0:0
        )
        mark = rodCreateRect(
          ?cvId     cv
          ?name     "mark"
          ?layer    list( rType devInfo->mrkPurpose )
          ?width    w
          ?length   l
          ?origin   0:termW
        )

        ; create the pins
        ;-----------------------------
        plusPin = rodCreateRect(
          ?cvId     cv
          ?name     "plusPin"
          ?layer    list( evalstring(strcat("rules->" rType "->pinlayer" ))
            evalstring(strcat("rules->" rType "->pinpurpose" )) )
          ?width    w
          ?length   termW
          ?netName  "PLUS"
          ?termName "PLUS"
          ?termIOType "inputOutput"
          ?pin      t
          ?pinLabel t
          ?pinLabelHeight round( (0.5*termW/length("PLUS"))/grid)*grid
          ?pinLabelLayer  list( rType "label")
          ?pinLabelFont   "stick"
          ?pinLabelOrient "R90"
        )
        rodAlign(
          ?alignObj     plusPin
          ?alignHandle  "upperLeft"
          ?refObj       mark
          ?refHandle    "lowerLeft"
        )
        minusPin = rodCreateRect(
          ?cvId     cv
          ?name     "minusPin"
          ?layer    list( evalstring(strcat("rules->" rType "->pinlayer" ))
            evalstring(strcat("rules->" rType "->pinpurpose" )) )
          ?width    w
          ?length   termW
          ?netName  "MINUS"
          ?termName "MINUS"
          ?termIOType "inputOutput"
          ?pin      t
          ?pinLabel t
          ?pinLabelHeight round( (0.5*termW/length("MINUS"))/grid)*grid
          ?pinLabelLayer  list( rType "label")
          ?pinLabelFont   "stick"
          ?pinLabelOrient "R90"
        )
        rodAlign(
          ?alignObj     minusPin
          ?alignHandle  "lowerLeft"
          ?refObj       mark
          ?refHandle    "upperLeft"
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
          ( model         "string"  car(device->modelNames) )
          ( rType         "string"  car(device->layers) )
          ( l             "float"   2*techGetMfgGridResolution(techGetTechFile(ddGetObj(libName))) )
          ( w             "float"   evalstring(strcat("designRules->" car(device->layers) "->minresW")) )
          ( m             "int"     1 )
          ( r             "string"  sprintf( nil "%L" evalstring(strcat("designRules->" car(device->layers) "->sheetRho")) *
                                    2*techGetMfgGridResolution(techGetTechFile(ddGetObj(libName))) / 
                                    evalstring(strcat("designRules->" car(device->layers) "->minresW")) ))
        )

        let( (cv modelLabel instLabel labelR labelM labelW labelL
            netm netp plus minus termP termM paramLabel )

        cv = pcCellView

        dbReplaceProp(cv "instNamePrefix" "string" "RM")

        ; bounding box and main labels
        ;-----------------------------
        dbCreateRect(cv list("instance" "drawing") list(-0.0625:-0.375 0.065:0.0))

        modelLabel = dbCreateLabel( cv list("text" "drawing") 0.0625:-0.1875 "[@model]"
          "upperCenter" "R90" "stick" 0.03125 )
        modelLabel~>labelType = "NLPLabel"

        instLabel = dbCreateLabel( cv list("annotate" "drawing7") -0.0625:-0.046875 "[@instanceName]"
          "centerRight" "R0" "stick" 0.0625 )
        instLabel~>labelType = "NLPLabel"
        labelR = dbCreateLabel( cv list("annotate" "drawing") -0.0625:-0.140625 "[@r]"
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

        cv~>portOrder = list("PLUS" "MINUS")

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
        ?defValue       car(device->modelNames)
        ?storeDefault   "yes"
        ?parseAsCEL     "yes"
        ?editable       "nil"
        ?display        "hiGetCurrentWindow()~>cellView~>cellViewType != \"maskLayout\""
      )
      cdfCreateParam( cdf
        ?name           "lvsModel"
        ?prompt         "LVS Model Name"
        ?type           "string"
        ?defValue       car(device->lvsModels)
        ?storeDefault   "yes"
        ?parseAsCEL     "yes"
        ?editable       "nil"
        ?display        "hiGetCurrentWindow()~>cellView~>cellViewType == \"maskLayout\""
      )
      cdfCreateParam( cdf
        ?name           "rType"
        ?prompt         "Layer"
        ?type           "cyclic"
        ?defValue       car(device->layers)
        ?choices        device->layers
        ?storeDefault   "yes"
        ?callback       strcat(device->paramCB "(\"rType\")")
      )
      cdfCreateParam( cdf
        ?name           "rCalcMethod"
        ?prompt         "Calculate By"
        ?type           "cyclic"
        ?defValue       "W & L"
        ?storeDefault   "yes"
        ?choices        list("R & W" "W & L")
      )
      cdfCreateParam( cdf
        ?name           "r"
        ?prompt         "Resistance"
        ?type           "string"
        ;?units          "resistance"
        ?defValue       sprintf( nil "%.4f" evalstring(strcat("designRules->" car(device->layers) "->sheetRho")) *
          2*techGetMfgGridResolution(techGetTechFile(ddGetObj(libName))) / 
          evalstring(strcat("designRules->" car(device->layers) "->minresW")) )
        ?editable       "cdfgData->rCalcMethod->value == \"R & W\""
        ?storeDefault   "yes"
        ?parseAsCEL     "yes"
        ?parseAsNumber  "yes"
        ?callback       strcat(device->paramCB "()")
      )
      cdfCreateParam( cdf
        ?name           "w"
        ?prompt         "Width (um)"
        ?type           "float"
        ?defValue       evalstring(strcat("designRules->" car(device->layers) "->minresW"))
        ?storeDefault   "yes"
        ?callback       strcat(device->paramCB "()")
      )
      cdfCreateParam( cdf
        ?name           "l"
        ?prompt         "Length (um)"
        ?type           "float"
        ?defValue       2*techGetMfgGridResolution(techGetTechFile(ddGetObj(libName)))
        ?storeDefault   "yes"
        ?callback       strcat(device->paramCB "()")
        ?editable       "cdfgData->rCalcMethod->value == \"W & L\""
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
        ?name           "rsh"
        ?prompt         "Sheet Rho"
        ?type           "float"
        ?defValue       evalstring(strcat("designRules->" car(device->layers) "->sheetRho"))
        ?storeDefault   "yes"
        ?editable       "nil"
      )

      cdf->simInfo = list( nil)
      cdf->simInfo->auCdl = '( nil
        dollarEqualParams nil
        dollarParams      nil
        otherParameters   nil
        netlistProcedure  _ansCdlCompParamPrim
        instParameters    (R model W L M )
        propMapping       (nil model lvsModel R r W w L l M m)
        componentName     sprintf( nil "%s" device->deviceName )
        termOrder         (PLUS MINUS)
        namePrefix        "R"
        modelName         ""
      )
      cdf->simInfo->auLvs = '( nil
        permuteRule       "(p PLUS MINUS)"
      )
      cdf->simInfo->spectre = '( nil
        propMapping             nil
        otherParameters         (model)
        instParameters          (r w l m)
        termOrder               (PLUS MINUS)
      )

      cdf->simInfo->spectreS = '( nil
        propMapping             nil
        netlistProcedure        ansSpectreSDevPrim
        otherParameters         (model)
        instParameters          (r w l m)
        termOrder               (PLUS MINUS)
        namePrefix              "R"
        componentName           model
      )

      ;;; Properties
      cdf->formInitProc              = "S130disablePcellChange"
      cdf->doneProc                  = ""
      cdf->buttonFieldWidth          = 340
      cdf->fieldHeight               = 35
      cdf->fieldWidth                = 350
      cdf->promptWidth               = 175
      cdf->modelLabelSet             = ""
      cdf->opPointLabelSet           = "i pwr id1"
      cdf->paramLabelSet             = ""
      cdf->instDisplayMode           = "instName"
      cdf->instNameType              = "schematic"
      cdf->termDisplayMode           = "netName"
      cdf->netNameType               = "schematic"

      cdfSaveCDF(cdf)

    );  let
  ); foreach device

);  let

/*==================================  EOF  ===================================*/
