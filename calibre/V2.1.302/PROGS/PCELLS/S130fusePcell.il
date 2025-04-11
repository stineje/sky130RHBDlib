/*==============================================================================
  File:         S130fusePcell.il
  Purpose:      Pcell code for layout and symbols, and cdf setup for metal fuses
                for Skywater S130 Pcells

  Created:      Nov 07, 2020  Madek Graham
  Description:  Pcell code to create the fuse_mX devices
  
  Devices/views:  fuse_m4 / layout symbol auCdl auLvs spectre

------------------------------------------------------------
  Modifications:

==============================================================================*/

/*==============================================================================

  This file only needs to be loaded once to create the pcells and cdf information
  for the mResDevices set within the S130techData.il file

==============================================================================*/

let( ( libName )

  libName = "S130"

  foreach( device fuseDevices

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
        ( w             "float"   device->defW )
        ( l             "float"   device->defL )
        ( shieldOpt     "string"  "none" )
        ( shieldW       "float"   designRules->fuse->shieldMinW )
        ( shieldL       "float"   designRules->fuse->shieldMinL )
        ( shieldSP      "float"   designRules->fuse->shieldMinSP )
      )

      let(( cv termW )

        cv = pcCellView
        termW = rules->fuse->termW

        ; create the metal
        ;-----------------------------
        rodCreateRect(
          ?cvId     cv
          ?name     "metal"
          ?layer    devInfo->fuseLay->layer
          ?width    w
          ?length   l + 2*termW
          ?origin   0:0
        )
        rodCreateRect(
          ?cvId     cv
          ?name     "mark"
          ?layer    devInfo->mrkLay
          ?width    w
          ?length   l
          ?origin   0:termW
        )
        rodCreateRect(
          ?cvId     cv
          ?name     "target"
          ?layer    devInfo->targetLay
          ?width    grid*2
          ?length   grid*2
        )
        rodAlign(
          ?alignObj     rodGetObj("target" cv)
          ?alignHandle  "centerCenter"
          ?refObj       rodGetObj("metal" cv)
          ?refHandle    "centerCenter"
        )

        ; create the pins
        ;-----------------------------
        rodCreateRect(
          ?cvId     cv
          ?name     "plusPin"
          ?layer    list( devInfo->fuseLay->pinlayer devInfo->fuseLay->pinpurpose )
          ?width    w
          ?length   termW
          ?netName  "PLUS"
          ?termName "PLUS"
          ?termIOType "inputOutput"
          ?pin      t
          ?pinLabel t
          ?pinLabelHeight round( (0.5*termW/length("PLUS"))/grid)*grid
          ?pinLabelLayer  list( devInfo->fuseLay->layer "label" )
          ?pinLabelFont   "stick"
          ?pinLabelOrient "R90"
        )
        rodAlign(
          ?alignObj     rodGetObj("plusPin" cv )
          ?alignHandle  "upperLeft"
          ?refObj       rodGetObj("mark" cv )
          ?refHandle    "lowerLeft"
        )
        rodCreateRect(
          ?cvId     cv
          ?name     "minusPin"
          ?layer    list( devInfo->fuseLay->pinlayer devInfo->fuseLay->pinpurpose )
          ?width    w
          ?length   termW
          ?netName  "MINUS"
          ?termName "MINUS"
          ?termIOType "inputOutput"
          ?pin      t
          ?pinLabel t
          ?pinLabelHeight round( (0.5*termW/length("MINUS"))/grid)*grid
          ?pinLabelLayer  list( devInfo->fuseLay->layer "label" )
          ?pinLabelFont   "stick"
          ?pinLabelOrient "R90"
        )
        rodAlign(
          ?alignObj     rodGetObj("minusPin" cv )
          ?alignHandle  "lowerLeft"
          ?refObj       rodGetObj("mark" cv )
          ?refHandle    "upperLeft"
        )

        ; create the shield(s)
        ;-----------------------------
        case( shieldOpt
          ("both"
            rodCreateRect(
              ?cvId     cv
              ?name     "leftShield"
              ?layer    devInfo->fuseLay->layer
              ?width    shieldW
              ?length   shieldL
            )
            rodAlign(
              ?alignObj     rodGetObj("leftShield" cv)
              ?alignHandle  "centerCenter"
              ?refObj       rodGetObj("metal" cv)
              ?refHandle    "centerCenter"
              ?xSep         -(0.5*(w + shieldW) + shieldSP)
            )
            rodCreateRect(
              ?cvId     cv
              ?name     "rightShield"
              ?layer    devInfo->fuseLay->layer
              ?width    shieldW
              ?length   shieldL
            )
            rodAlign(
              ?alignObj     rodGetObj("rightShield" cv)
              ?alignHandle  "centerCenter"
              ?refObj       rodGetObj("metal" cv)
              ?refHandle    "centerCenter"
              ?xSep         0.5*(w + shieldW) + shieldSP
            )
          )
          ("left" 
            rodCreateRect(
              ?cvId     cv
              ?name     "leftShield"
              ?layer    devInfo->fuseLay->layer
              ?width    shieldW
              ?length   shieldL
            )
            rodAlign(
              ?alignObj     rodGetObj("leftShield" cv)
              ?alignHandle  "centerCenter"
              ?refObj       rodGetObj("metal" cv)
              ?refHandle    "centerCenter"
              ?xSep         -(0.5*(w + shieldW) + shieldSP)
            )
          )
          ("right" 
            rodCreateRect(
              ?cvId     cv
              ?name     "rightShield"
              ?layer    devInfo->fuseLay->layer
              ?width    shieldW
              ?length   shieldL
            )
            rodAlign(
              ?alignObj     rodGetObj("rightShield" cv)
              ?alignHandle  "centerCenter"
              ?refObj       rodGetObj("metal" cv)
              ?refHandle    "centerCenter"
              ?xSep         0.5*(w + shieldW) + shieldSP
            )
          )
        ); case shieldOpt

      ); let
    ); pcDefinePCell layout

    ;===========================================================
    ;***** Define Symbol Pcell *****
    ;===========================================================

    foreach( view list("symbol" "auCdl" "auLvs" "spectre" "hspiceD")
      pcDefinePCell( list( ddGetObj(libName) device->deviceName view "schematicSymbol" "w")
        ; formal parameters name value pairs
        (
          ( model         "string"  device->modelName )
        )

        let( (cv modelLabel instLabel
            netm netp plus minus termP termM paramLabel )

        cv = pcCellView

        dbReplaceProp(cv "instNamePrefix" "string" "FUSE")

        ; bounding box and main labels
        ;-----------------------------
        dbCreateRect(cv list("instance" "drawing") list(-0.0625:-0.375 0.0625:0.0))
        modelLabel = dbCreateLabel( cv list("text" "drawing") -0.0625:0.015625 "[@model]"
          "centerRight" "R0" "stick" 0.03125 )
        modelLabel~>labelType = "NLPLabel"
        instLabel = dbCreateLabel( cv list("annotate" "drawing7") -0.0625:-0.046875 "[@instanceName]"
          "centerRight" "R0" "stick" 0.0625 )
        instLabel~>labelType = "NLPLabel"

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

        paramLabel = dbCreateLabel( cv list("annotate" "drawing") 0.0625:-0.09375 "cdsParam(1)"
          "lowerLeft" "R0" "stick" 0.03125 )
        paramLabel~>labelType = "ILLabel"
        paramLabel = dbCreateLabel( cv list("annotate" "drawing") 0.0625:-0.15625 "cdsParam(2)"
          "lowerLeft" "R0" "stick" 0.03125 )
        paramLabel~>labelType = "ILLabel"
        paramLabel = dbCreateLabel( cv list("annotate" "drawing") 0.0625:-0.21875 "cdsParam(3)"
          "lowerLeft" "R0" "stick" 0.03125 )
        paramLabel~>labelType = "ILLabel"
        paramLabel = dbCreateLabel( cv list("annotate" "drawing") 0.0625:-0.28125 "cdsParam(4)"
          "lowerLeft" "R0" "stick" 0.03125 )
        paramLabel~>labelType = "ILLabel"

        ; fuse drawings
        ;-----------------------------
        dbCreateLine(cv list("device" "drawing") list(0.0: 0.0 0.0:-0.09375) )
        dbCreateLine(cv list("device" "drawing") list(0.0:-0.28125 0.0:-0.375) )
        dbCreateArc(cv list("device" "drawing") list(-0.046875:-0.1875 0.046875:-0.09375)
          list(-0.046875:-0.1875 0.0:-0.09375) )
        dbCreateArc(cv list("device" "drawing") list(-0.046875:-0.28125 0.046875:-0.1875)
          list(0.0:-0.28125 0.046875:-0.1875) )

        ); let
      ); pcDefinePCell symbols
    ); foreach view

    ;===========================================================
    ;***** CDF definition *****
    ;===========================================================

    let( ( cellName cellId cdf )

      cellName = device->deviceName

      unless( cellId = ddGetObj( libName cellName )
        error( "Could not get cell object Lib: %s, Cell:%s" libName cellName )
      ); unless

      when( cdf = cdfGetBaseCellCDF( cellId )
        cdfDeleteCDF( cdf )
      ); when
      cdf = cdfCreateBaseCellCDF( cellId )

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
        ?name           "w"
        ?prompt         "Width (um)"
        ?type           "float"
        ?defValue       device->defW
        ?storeDefault   "yes"
        ;?editable       "cdfgData->rCalcMethod->value == \"R & W\""
        ?editable       "nil"
        ?callback       strcat(device->paramCB "()")
      )
      cdfCreateParam( cdf
        ?name           "l"
        ?prompt         "Length (um)"
        ?type           "float"
        ?defValue       device->defL
        ?storeDefault   "yes"
        ?callback       strcat(device->paramCB "()")
        ;?editable       "cdfgData->rCalcMethod->value == \"W & L\""
        ?editable       "nil"
      )
      cdfCreateParam( cdf
        ?name           "m"
        ?prompt         "Multiples"
        ?type           "int"
        ?defValue       1
        ?storeDefault   "yes"
        ?callback       strcat(device->paramCB "()")
        ;?display        "hiGetCurrentWindow()~>cellView~>cellViewType != \"maskLayout\""
        ?display        "nil"
      )
      cdfCreateParam( cdf
        ?name           "shieldOpt"
        ?prompt         "Shield(s)"
        ?type           "cyclic"
        ?defValue       "none"
        ?storeDefault   "yes"
        ?choices        list("none" "left" "right" "both")
      )
      cdfCreateParam( cdf
        ?name           "shieldW"
        ?prompt         "Shield Width (um)"
        ?type           "float"
        ?defValue       designRules->fuse->shieldMinW
        ?storeDefault   "yes"
        ?editable       "nil"
        ;?display        "cdfgData->shieldOpt->value != \"none\""
        ?display        "nil"
        ?callback       strcat(device->paramCB "()")
      )
      cdfCreateParam( cdf
        ?name           "shieldL"
        ?prompt         "Shield Length (um)"
        ?type           "float"
        ?defValue       designRules->fuse->shieldMinL
        ?storeDefault   "yes"
        ?editable       "nil"
        ;?display        "cdfgData->shieldOpt->value != \"none\""
        ?display        "nil"
        ?callback       strcat(device->paramCB "()")
      )
      cdfCreateParam( cdf
        ?name           "shieldSP"
        ?prompt         "Shield Spacing (um)"
        ?type           "float"
        ?defValue       designRules->fuse->shieldMinSP
        ?storeDefault   "yes"
        ?display        "cdfgData->shieldOpt->value != \"none\""
        ?callback       strcat(device->paramCB "()")
      )
      cdfCreateParam( cdf
        ?name           "rCalcMethod"
        ?prompt         "Calculate By"
        ?type           "cyclic"
        ?defValue       "W & L"
        ?storeDefault   "yes"
        ?choices        list("R & W" "W & L")
        ?display        "nil"
      )
      cdfCreateParam( cdf
        ?name           "r"
        ?prompt         "Resistance"
        ?type           "string"
        ;?units          "resistance"
        ?defValue       sprintf( nil "%.4f" device->fuseLay->sheetRho * device->defL / 
          device->defW )
        ;?editable       "cdfgData->rCalcMethod->value == \"R & W\""
        ?editable       "nil"
        ?storeDefault   "yes"
        ?parseAsCEL     "yes"
        ?parseAsNumber  "yes"
        ?callback       strcat(device->paramCB "()")
      )
      cdfCreateParam( cdf
        ?name           "rsh"
        ?prompt         "Sheet Rho"
        ?type           "float"
        ?defValue       device->fuseLay->sheetRho
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
      cdf->simInfo->hspiceD = '( nil
        propMapping             nil
        otherParameters         (model)
        instParameters          (r w l m)
        termOrder               (PLUS MINUS)
        namePrefix              "R"
      )
      cdf->simInfo->spectre = '( nil
        propMapping             nil
        otherParameters         (model)
        instParameters          (r w l m)
        termOrder               (PLUS MINUS)
        namePrefix              "R"
      )
      cdf->simInfo->spectreS = '( nil
        propMapping             nil
        otherParameters         (model)
        instParameters          (r w l m)
        termOrder               (PLUS MINUS)
        namePrefix              "R"
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
