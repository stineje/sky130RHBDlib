/*==============================================================================
  File:         S130fet12vPcell.il
  Purpose:      Pcell code for cdf setup for 12v mosfet (DE)
                devices for Skywater S130 Pcells

  Created:      May 30, 2020  Madek Graham
  Description:  Pcell code to create the 12V mosfet (DE) devices
  
  Devices/views:  nmos_de_v12
                  pmos_de_v12

------------------------------------------------------------
  Modifications:
  - Jun 27, 2020 MSG
    Changed hvi layer to thkox to accomodate change in PDK
  - Jul 18, 2020 MSG
    Fixed top/bottom tap spacing to nwell for nmos devices
  - Sep 05, 2020 MSG
    Changed tap to default to bot, added fixed cdf params for w & l for discrete
    device sizes
  - Jun 05, 2021 MSG
    Changed s/d params to align with models (real values, not 0.0)

==============================================================================*/

let( ( libName )

  libName = "S130"

  ;; techData will be loaded in by the tech library's libInit.il

  foreach( device fet12vDevices

    printf("Creating device %s in %s library\n" device->deviceName libName )

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

      printf( "Generating CDF for %s\n" cellName )

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
        ?name           "useFixedWL"
        ?prompt         "Use Fixed W/L"
        ?type           "boolean"
        ?defValue       t
        ?storeDefault   "yes"
        ?display        "nil"
      )
      cdfCreateParam( cdf
        ?name           "fixedW"
        ?prompt         "Finger Width (um)"
        ?type           "cyclic"
        ?defValue       sprintf(nil "%L" device->defW)
        ?storeDefault   "yes"
        ?choices        mapcar( 'car setof( wl device->fixedWL evalstring(cadr(wl))==device->defL) )
        ?callback       sprintf( nil "%s('fixedW)" device->paramCB )
        ?display        "cdfgData->useFixedWL->value"
      )
      cdfCreateParam( cdf
        ?name           "fixedL"
        ?prompt         "Length (um)"
        ?type           "cyclic"
        ?defValue       sprintf(nil "%L" device->defL)
        ?storeDefault   "yes"
        ?choices        mapcar( 'cadr setof( wl device->fixedWL evalstring(car(wl))==device->defW) )
        ?callback       sprintf( nil "%s('fixedL)" device->paramCB )
        ?display        "cdfgData->useFixedWL->value"
      )
      cdfCreateParam( cdf
        ?name           "fw"
        ?prompt         "Finger Width (um)"
        ?type           "float"
        ?defValue       device->defW
        ?storeDefault   "yes"
        ?callback       sprintf( nil "%s('fw)" device->paramCB )
        ?display        "!cdfgData->useFixedWL->value"
      )
      cdfCreateParam( cdf
        ?name           "l"
        ?prompt         "Length (um)"
        ?type           "float"
        ?defValue       device->defL
        ?storeDefault   "yes"
        ?callback       sprintf( nil "%s('l)" device->paramCB )
        ?display        "!cdfgData->useFixedWL->value"
      )
      cdfCreateParam( cdf
        ?name           "nf"
        ?prompt         "Fingers"
        ?type           "int"
        ?defValue       2
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?callback       sprintf( nil "%s('nf)" device->paramCB )
      )
      cdfCreateParam( cdf
        ?name           "m"
        ?prompt         "Multiples"
        ?type           "int"
        ?defValue       1
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?callback       sprintf( nil "%s('m)" device->paramCB )
        ?display        "hiGetCurrentWindow()~>cellView~>cellViewType != \"maskLayout\""
      )
      cdfCreateParam( cdf
        ?name           "w"
        ?prompt         "Total Device Width (w*nf)"
        ?type           "float"
        ?defValue       device->defW * 2
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?editable       "nil"
      )
      cdfCreateParam( cdf
        ?name           "totalW"
        ?prompt         "Total Width (w*nf*m)"
        ?type           "float"
        ?defValue       device->defW * 2
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?editable       "nil"
        ?display        "hiGetCurrentWindow()~>cellView~>cellViewType != \"maskLayout\""
      )
      cdfCreateParam( cdf
        ?name           "gateOptions"
        ?prompt         "Show Gate Options"
        ?type           "boolean"
        ?defValue       nil
        ?storeDefault   "yes"
        ?display        "hiGetCurrentWindow()~>cellView~>cellViewType == \"maskLayout\""
      )
      cdfCreateParam( cdf
        ?name           "gateCnt"
        ?prompt         "  Gate Contacts"
        ?type           "cyclic"
        ?defValue       "none"
        ?choices        list("none" "Top" "Bottom" "Both")
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?display        "cdfgData->gateOptions->value && hiGetCurrentWindow()~>cellView~>cellViewType == \"maskLayout\""
      )
      cdfCreateParam( cdf
        ?name           "gateCntExt"
        ?prompt         "  Extend Gate Contact by"
        ?type           "float"
        ?defValue       0.0
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?callback       sprintf( nil "%s('gateCntExt)" device->paramCB )
        ?display        "cdfgData->gateOptions->value && cdfgData->gateCnt->value != \"none\" &&
                         hiGetCurrentWindow()~>cellView~>cellViewType == \"maskLayout\""
      )
      cdfCreateParam( cdf
        ?name           "as"
        ?prompt         "  Source Area (um^2)"
        ?type           "float"
        ?defValue       2*((designRules->licon1->minW + 2*designRules->licon1->minDcontSPpoly) * device->defW)
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?editable       "t"
        ?display        "nil"
      )
      cdfCreateParam( cdf
        ?name           "ad"
        ?prompt         "  Drain Area (um^2)"
        ?type           "float"
        ?defValue       (2*(device->rules->srcOLnwell + device->rules->srcDrnSP) +
                          device->rules->minDrnW + 2*device->rules->drnBevW) *
                          (device->defW + 2*device->rules->wellOLdrn)
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?editable       "t"
        ?display        "nil"
      )
      cdfCreateParam( cdf
        ?name           "ps"
        ?prompt         "  Source Perimeter (um)"
        ?type           "float"
        ?defValue       2*( 2*(designRules->licon1->minW + 2*designRules->licon1->minDcontSPpoly) +
                          device->defW )
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?editable       "t"
        ?display        "nil"
      )
      cdfCreateParam( cdf
        ?name           "pd"
        ?prompt         "  Drain Perimeter (um)"
        ?type           "float"
        ?defValue       2*( 2*(device->rules->srcOLnwell + device->rules->srcDrnSP) +
                          device->rules->minDrnW + 2*device->rules->drnBevW +
                          (device->defW + 2*device->rules->wellOLdrn))
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?editable       "t"
        ?display        "nil"
      )
      cdfCreateParam( cdf
        ?name           "nrs"
        ?prompt         "  Source Diff Squares"
        ?type           "float"
        ?defValue       ((0.5*designRules->licon1->minW + designRules->licon1->minDcontSPpoly) / device->defW ) / 2
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?editable       "t"
        ?display        "nil"
      )
      cdfCreateParam( cdf
        ?name           "nrd"
        ?prompt         "  Drain Diff Squares"
        ?type           "float"
        ?defValue       0.35 / (device->defW + 2*device->rules->wellOLdrn)
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?editable       "t"
        ?display        "nil"
      )
      cdfCreateParam( cdf
        ?name           "tapLeft"
        ?prompt         "Left Tap"
        ?type           "boolean"
        ?defValue       nil
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
        ?defValue       t
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
      ; params for callbacks & netlisting
      cdfCreateParam( cdf
        ?name           "tm"
        ?prompt         "Total # of gates (m*nf)"
        ?type           "int"
        ?defValue       2
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?editable       "nil"
        ?display        "nil"
      )
      cdfCreateParam( cdf
        ?name           "minW"
        ?prompt         "minimum width"
        ?type           "float"
        ?defValue       device->minW
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?display        "nil"
      )
      cdfCreateParam( cdf
        ?name           "maxW"
        ?prompt         "maximum width"
        ?type           "float"
        ?defValue       device->maxW
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?display        "nil"
      )
      cdfCreateParam( cdf
        ?name           "minL"
        ?prompt         "minimum length"
        ?type           "float"
        ?defValue       device->minL
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?display        "nil"
      )
      cdfCreateParam( cdf
        ?name           "maxL"
        ?prompt         "maximum length"
        ?type           "float"
        ?defValue       device->maxL
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?display        "nil"
      )
      ; needed for the models and stdlib imports
      cdfCreateParam( cdf
        ?name           "sa"
        ?prompt         "left diff overlap gate"
        ?type           "float"
        ?defValue       0.0
        ?storeDefault   "yes"
        ?display        "nil"
      )
      cdfCreateParam( cdf
        ?name           "sb"
        ?prompt         "right diff overlap gate"
        ?type           "float"
        ?defValue       0.0
        ?storeDefault   "yes"
        ?display        "nil"
      )
      cdfCreateParam( cdf
        ?name           "sd"
        ?prompt         "space between fingers"
        ?type           "float"
        ?defValue       0.0
        ?storeDefault   "yes"
        ?display        "nil"
      )

      cdf->simInfo = list( nil)
      cdf->simInfo->auCdl = '( nil
        dollarEqualParams nil
        dollarParams      nil
        otherParameters   nil
        netlistProcedure  _ansCdlCompParamPrim
        instParameters    (model W L M )
        propMapping       (nil model lvsModel W fw L l M tm)
        componentName     sprintf( nil "%s" device->deviceName )
        termOrder         (d g s b)
        namePrefix        "M"
        modelName         ""
      )
      cdf->simInfo->auLvs = '( nil
        dollarEqualParams nil
        dollarParams      nil
        otherParameters   nil
        netlistProcedure  _ansLvsCompParamPrim
        instParameters    (model W L M )
        propMapping       (nil model lvsModel W fw L l M tm)
        componentName     sprintf( nil "%s" device->deviceName )
        termOrder         (d g s b)
        namePrefix        "M"
        modelName         ""
      )
      cdf->simInfo->spectre = '( nil
        propMapping     nil
        otherParameters (model)
        instParameters  (nf w l m as ad ps pd nrd nrs sa sb sd)
        termOrder       (d g s b)
      )

      cdf->simInfo->spectreS = '( nil
        propMapping      nil
        netlistProcedure ansSpectreSDevPrim
        otherParameters  (model)
        instParameters   (nf w l m as ad ps pd nrd nrs sa sb sd)
        termOrder        (d g s b)
        namePrefix       "M"
        componentName    model
      )

      ;;; Properties
      cdf->formInitProc              = "S130disablePcellChange"
      cdf->doneProc                  = ""
      cdf->buttonFieldWidth          = 340
      cdf->fieldHeight               = 35
      cdf->fieldWidth                = 350
      cdf->promptWidth               = 175
      cdf->modelLabelSet             = "vfb phi eta"
      cdf->opPointLabelSet           = "id vgs vds gm"
      cdf->paramLabelSet             = ""
      cdf->instDisplayMode         = "instName"
      cdf->instNameType            = "schematic"
      cdf->termDisplayMode         = "netName"
      cdf->netNameType             = "schematic"

      cdfSaveCDF(cdf)

    );  let
  ); foreach device

);  let

/*==================================  EOF  ===================================*/
