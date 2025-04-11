/*==============================================================================
  File:         S130fet20vPcell.il
  Purpose:      Pcell code for cdf setup for 20v mosfet (DE)
                devices for Skywater S130 Pcells

  Created:      Aug 15, 2020  Madek Graham
  Description:  Pcell code to create the 20V mosfet (DE) devices
  
  Devices/views:  nmos_de_v20
                  nmos_de_nat_v20
                  nmos_de_zvt_v20
                  nmos_de_iso_v20
                  pmos_de_v20

------------------------------------------------------------
  Modifications:
  - Jun 06, 2021 Madek Graham
    Added real values for s/d params; currently fixed values due to fixed layouts
    Added pdnw and adnw for the nmos_de_iso_v20 device to be insync with the model

==============================================================================*/

let( ( libName )

  libName = "S130"

  ;; techData will be loaded in by the tech library's libInit.il

  foreach( device fet20vDevices

    printf("Creating device %s in %s library\n" device->deviceName libName )

    ;===========================================================
    ;***** CDF definition *****
    ;===========================================================

    let( ( cellName cellId cdf fw ps pd as ad nrs nrd pdnw adnw )

      cellName = device->deviceName

      unless( cellId = ddGetObj( libName cellName )
        error( "Could not get cell object Lib: %s, Cell:%s" libName cellName )
      ); unless

      when( cdf = cdfGetBaseCellCDF( cellId )
        cdfDeleteCDF( cdf )
      ); when
      cdf = cdfCreateBaseCellCDF( cellId )

      printf( "Generating CDF for %s\n" cellName )

      ; s/d params are hard values until these devices become continuous
      ; currently the layouts are fixed
      fw = device->deffw
      case( cellName
        ( "nmos_de_v20"
          ps = 2*(fw + 2*0.29)    ; nf * (fw + 2* src diff ext from gate)
          pd = 2*(38.0 + 7.75)    ; dnwell over drain perim
          as = 2*(fw * 0.29)      ; nf * (fw * src diff ext from gate)
          ad = 38.0 * 7.75        ; dnwell over drain area
          nrs = (0.145 / fw) / 2  ; (gate to mid src cont / fw) / nf
          nrd = 0.35 / fw         ; sti depth / fw
        )
        ( "nmos_de_nat_v20"
          ps = 2*(fw + 2*0.29)    ; nf * (fw + 2* src diff ext from gate)
          pd = 2*(38.0 + 7.75)    ; dnwell over drain perim
          as = 2*(fw * 0.29)      ; nf * (fw * src diff ext from gate)
          ad = 38.0 * 7.75        ; dnwell over drain area
          nrs = (0.145 / fw) / 2  ; (gate to mid src cont / fw) / nf
          nrd = 0.35 / fw         ; sti depth / fw
        )
        ( "nmos_de_zvt_v20"
          ps = 2*(fw + 2*0.29)    ; nf * (fw + 2* src diff ext from gate)
          pd = 2*(36.0 + 5.75)    ; dnwell over drain perim
          as = 2*(fw * 0.29)      ; nf * (fw * src diff ext from gate)
          ad = 36.0 * 5.75        ; dnwell over drain area
          nrs = (0.145 / fw) / 2  ; (gate to mid src cont / fw) / nf
          nrd = 0.35 / fw         ; sti depth / fw
        )
        ( "nmos_de_iso_v20"
          ps = 2*(fw + 2*0.63)    ; nf * (fw + 2* src diff ext from gate)
          pd = 2*2*(34.0 + 4.38)  ; pwbm hole perim
          as = 2*(fw * 0.63)      ; nf * (fw * src diff ext from gate)
          ad = 2*(34.0 * 4.38)    ; pwbm hole area
          nrs = (0.145 / fw) / 2  ; (gate to mid src cont / fw) / nf
          nrd = (0.35 / fw) / 2   ; sti depth / fw
          pdnw = 2*(fw + 1.6)     ; nwell over drain perim
          adnw = fw * 1.6         ; nwell over drain area
        )
        ( "pmos_de_v20"
          ps = 2*(fw + 2*0.29)    ; nf * (fw + 2* src diff ext from gate)
          pd = 2*(35.0 + 4.75)    ; pwde over drain perim
          as = 2*(fw * 0.29)      ; nf * (fw * src diff ext from gate)
          ad = 35.0 * 4.75        ; pwde over drain area
          nrs = (0.145 / fw) / 2  ; (gate to mid src cont / fw) / nf
          nrd = 0.35 / fw         ; sti depth / fw
        )
      )
      ; ensure all values are floating numbers and not super long (nrd/nrs)
      ps = float(ps)
      pd = float(pd)
      as = float(as)
      ad = float(ad)
      nrs = float(round2(nrs*1e6)/1e6)
      nrd = float(round2(nrd*1e6)/1e6)

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
        ?name           "fw"
        ?prompt         "Finger Width (um)"
        ?type           "float"
        ?defValue       device->deffw
        ?storeDefault   "yes"
        ?callback       sprintf( nil "%s('fw)" device->paramCB )
        ?editable       "nil"
      )
      cdfCreateParam( cdf
        ?name           "l"
        ?prompt         "Length (um)"
        ?type           "float"
        ?defValue       device->defl
        ?storeDefault   "yes"
        ?editable       "nil"
      )
      cdfCreateParam( cdf
        ?name           "nf"
        ?prompt         "Fingers"
        ?type           "int"
        ?defValue       2
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?callback       sprintf( nil "%s('nf)" device->paramCB )
        ?editable       "nil"
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
        ?defValue       device->deffw * device->defnf
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?editable       "nil"
      )
      cdfCreateParam( cdf
        ?name           "totalW"
        ?prompt         "Total Width (w*nf*m)"
        ?type           "float"
        ?defValue       device->deffw * device->defnf * device->defm
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?editable       "nil"
      )
/* to come later when a proper pcell is created
      cdfCreateParam( cdf
        ?name           "gateCnt"
        ?prompt         "Gate Contacts"
        ?type           "cyclic"
        ?defValue       "Top"
        ?choices        list("none" "Top" "Bottom" "Both")
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?display        "cdfgData->gateOptions->value && hiGetCurrentWindow()~>cellView~>cellViewType == \"maskLayout\""
      )
*/
      cdfCreateParam( cdf
        ?name           "ps"
        ?prompt         "  Source Perimeter (um)"
        ?type           "float"
        ?defValue       ps || 0.0
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?editable       "nil"
        ?display        "nil"
      )
      cdfCreateParam( cdf
        ?name           "pd"
        ?prompt         "  Drain Perimeter (um)"
        ?type           "float"
        ?defValue       pd || 0.0
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?editable       "nil"
        ?display        "nil"
      )
      cdfCreateParam( cdf
        ?name           "as"
        ?prompt         "  Source Area (um^2)"
        ?type           "float"
        ?defValue       as || 0.0
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?editable       "nil"
        ?display        "nil"
      )
      cdfCreateParam( cdf
        ?name           "ad"
        ?prompt         "  Drain Area (um^2)"
        ?type           "float"
        ?defValue       ad || 0.0
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?editable       "nil"
        ?display        "nil"
      )
      cdfCreateParam( cdf
        ?name           "nrs"
        ?prompt         "  Source Diff Squares"
        ?type           "float"
        ?defValue       nrs || 0.0
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?editable       "nil"
        ?display        "nil"
      )
      cdfCreateParam( cdf
        ?name           "nrd"
        ?prompt         "  Drain Diff Squares"
        ?type           "float"
        ?defValue       nrd || 0.0
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?editable       "nil"
        ?display        "nil"
      )
      when( rexMatchp("_iso" device->deviceName)
        cdfCreateParam( cdf
          ?name           "pdnw"
          ?prompt         "  Nwell Drain Perimeter (um)"
          ?type           "float"
          ?defValue       pdnw || 0.0
          ?storeDefault   "yes"
          ?parseAsCEL     "no"
          ?editable       "nil"
          ?display        "nil"
        )
        cdfCreateParam( cdf
          ?name           "adnw"
          ?prompt         "  Nwell Drain Area (um^2)"
          ?type           "float"
          ?defValue       adnw || 0.0
          ?storeDefault   "yes"
          ?parseAsCEL     "no"
          ?editable       "nil"
          ?display        "nil"
        )
      ); when iso device
/* to come later when a proper pcell is created
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
*/
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
        ?name           "minfw"
        ?prompt         "minimum finger width"
        ?type           "float"
        ?defValue       device->minfw
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?display        "nil"
      )
      cdfCreateParam( cdf
        ?name           "maxfw"
        ?prompt         "maximum finger width"
        ?type           "float"
        ?defValue       device->maxfw
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?display        "nil"
      )
      cdfCreateParam( cdf
        ?name           "minl"
        ?prompt         "minimum finger length"
        ?type           "float"
        ?defValue       device->minl
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?display        "nil"
      )
      cdfCreateParam( cdf
        ?name           "maxl"
        ?prompt         "maximum finger length"
        ?type           "float"
        ?defValue       device->maxl
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?display        "nil"
      )
      cdfCreateParam( cdf
        ?name           "minnf"
        ?prompt         "minimum number of fingers"
        ?type           "float"
        ?defValue       device->minnf
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?display        "nil"
      )
      cdfCreateParam( cdf
        ?name           "maxnf"
        ?prompt         "maximum number of fingers"
        ?type           "float"
        ?defValue       device->maxnf
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?display        "nil"
      )
      cdfCreateParam( cdf
        ?name           "minm"
        ?prompt         "minimum multiples"
        ?type           "float"
        ?defValue       device->minm
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?display        "nil"
      )
      cdfCreateParam( cdf
        ?name           "maxm"
        ?prompt         "maximum multiples"
        ?type           "float"
        ?defValue       device->maxm
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
        modelName         ""
      )
        ;namePrefix        "M"
        ;termOrder         (d g s b)
      cdf->simInfo->auLvs = '( nil
        dollarEqualParams nil
        dollarParams      nil
        otherParameters   nil
        netlistProcedure  _ansLvsCompParamPrim
        instParameters    (model W L M )
        propMapping       (nil model lvsModel W fw L l M tm)
        componentName     sprintf( nil "%s" device->deviceName )
        modelName         ""
      )
        ;namePrefix        "M"
        ;termOrder         (d g s b)
      cdf->simInfo->spectre = '( nil
        propMapping     nil
        otherParameters (model)
        namePrefix       "X"
      )
        ;termOrder       (d g s b)

      cdf->simInfo->spectreS = '( nil
        propMapping      nil
        netlistProcedure ansSpectreSDevPrim
        otherParameters  (model)
        componentName    model
        namePrefix       "X"
      )
        ;termOrder        (d g s b)
      if( rexMatchp("_iso" device->deviceName) then
        cdf->simInfo->auCdl->termOrder = '(d g s b sub)
        cdf->simInfo->auLvs->termOrder = '(d g s b sub)
        cdf->simInfo->spectre->termOrder = '(d g s b sub)
        cdf->simInfo->spectreS->termOrder = '(d g s b sub)
        cdf->simInfo->spectre->instParameters = '(nf w l m as ad ps pd nrd nrs pdnw adnw sa sb sd)
        cdf->simInfo->spectreS->instParameters = '(nf w l m as ad ps pd nrd nrs pdnw adnw sa sb sd)
        cdf->simInfo->auCdl->namePrefix = "X"
        cdf->simInfo->auLvs->namePrefix = "X"
      else
        cdf->simInfo->auCdl->termOrder = '(d g s b)
        cdf->simInfo->auLvs->termOrder = '(d g s b)
        cdf->simInfo->spectre->termOrder = '(d g s b)
        cdf->simInfo->spectreS->termOrder = '(d g s b)
        cdf->simInfo->spectre->instParameters = '(nf w l m as ad ps pd nrd nrs sa sb sd)
        cdf->simInfo->spectreS->instParameters = '(nf w l m as ad ps pd nrd nrs sa sb sd)
        cdf->simInfo->auCdl->namePrefix = "M"
        cdf->simInfo->auLvs->namePrefix = "M"
      )

      ;;; Properties
      cdf->formInitProc            = "S130disablePcellChange"
      cdf->doneProc                = ""
      cdf->buttonFieldWidth        = 340
      cdf->fieldHeight             = 35
      cdf->fieldWidth              = 350
      cdf->promptWidth             = 175
      cdf->paramEvaluate           = "t nil nil nil nil"
      cdf->paramDisplayMode        = "parameter"
      cdf->instDisplayMode         = "instName"
      cdf->instNameType            = "schematic"
      cdf->termDisplayMode         = "netName"
      cdf->netNameType             = "schematic"
      cdf->modelLabelSet           = "vfb phi eta"
      cdf->opPointLabelSet         = "id vgs vds gm"
      cdf->paramLabelSet           = ""

      cdfSaveCDF(cdf)

    );  let
  ); foreach device

);  let

/*==================================  EOF  ===================================*/
