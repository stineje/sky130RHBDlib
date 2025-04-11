/*==============================================================================
  File:         S130padPcell.il
  Purpose:      Pcell code for cdf setup for the pads
                for Skywater S130 Pcell

  Created:      June 21, 2020  Madek Graham
  Description:  Pcell code to create pad devices
  
  Devices/views:  pad_bond
                  pad_probe
                  pad_microprobe

------------------------------------------------------------
  Modifications:
  - Nov 2, 2020  MSG
    Added marker layers for I/O, Power, or Ground pad type, as well as new CDF
      parameter to flag the pad type.

==============================================================================*/

/*==============================================================================

  This file only needs to be loaded once to create the pcells and cdf information
  for the dioDevices set within the S130techData.il file

==============================================================================*/

let( ( libName )

  libName = "S130"

  foreach( device padDevices

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

      tfId = techGetTechFile(cellId)

      cdfCreateParam( cdf
        ?name           "model"
        ?prompt         "Model Name"
        ?type           "string"
        ?defValue       device->modelName
        ?storeDefault   "yes"
        ?parseAsCEL     "yes"
        ?editable       "nil"
        ?display        "nil"
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
      when( device->label == "e-test"
        cdfCreateParam( cdf
          ?name           "padSize"
          ?prompt         "Size"
          ?type           "radio"
          ?defValue       sprintf(nil "%g" device->minW)
          ?storeDefault   "yes"
          ?choices        list(sprintf(nil "%g" device->minW) sprintf(nil "%g" device->maxW))
          ?callback       "cdfgData->w->value = cdfgData->l->value = cdfParseFloatString(cdfgData->padSize->value)"
        )
      ); when etest pad
      cdfCreateParam( cdf
        ?name           "w"
        ?prompt         "Width (um)"
        ?type           "float"
        ?defValue       device->defW
        ?storeDefault   "yes"
        ?callback       strcat(device->paramCB "('w)")
        ?editable       "if( cdfgData->padSize then nil else t)"
      )
      cdfCreateParam( cdf
        ?name           "l"
        ?prompt         "Height (um)"
        ?type           "float"
        ?defValue       device->defL
        ?storeDefault   "yes"
        ?callback       strcat(device->paramCB "('l)")
        ?editable       "if( cdfgData->padSize then nil else t)"
      )
      cdfCreateParam( cdf
        ?name           "m"
        ?prompt         "Multiples"
        ?type           "int"
        ?defValue       1
        ?storeDefault   "yes"
        ?callback       strcat(device->paramCB "('m)")
        ?display        "hiGetCurrentWindow()~>cellView~>cellViewType != \"maskLayout\""
      )
      cdfCreateParam( cdf
        ?name           "metalOL"
        ?prompt         "Metal Overlap Pad"
        ?type           "float"
        ?defValue       device->minTopMetOL
        ?storeDefault   "yes"
        ?callback       strcat(device->paramCB "('metalOL)")
        ?display        "hiGetCurrentWindow()~>cellView~>cellViewType == \"maskLayout\""
      )
      cdfCreateParam( cdf
        ?name           "padType"
        ?prompt         "Type"
        ?type           "radio"
        ?defValue       "I/O"
        ?storeDefault   "yes"
        ?choices        list("I/O" "Power" "Ground")
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
        ?name           "minTopMetOL"
        ?prompt         "minimum Top Metal overlap"
        ?type           "float"
        ?defValue       device->minTopMetOL
        ?storeDefault   "yes"
        ?parseAsCEL     "no"
        ?display        "nil"
      )

      cdf->simInfo = list( nil)
      cdf->simInfo->auCdl = '( nil
        dollarEqualParams nil
        dollarParams      nil
        otherParameters   nil
        netlistProcedure  ansCdlSubcktCallExtended
        instParameters    (model m w l)
        propMapping       (nil model lvsModel)
        componentName     nil
        termOrder         (PAD)
        namePrefix        "X"
      )
      cdf->simInfo->auLvs = '( nil
        dollarEqualParams nil
        dollarParams      nil
        otherParameters   nil
        netlistProcedure  ansLvsCompParamPrim
        instParameters    (model m w l )
        propMapping       (nil model lvsModel)
        termOrder         (PAD)
        namePrefix        "X"
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
      cdf->instDisplayMode           = "instName"
      cdf->instNameType              = "schematic"
      cdf->termDisplayMode           = "netName"
      cdf->netNameType               = "schematic"

      cdfSaveCDF(cdf)

    );  let
  ); foreach device

);  let

/*==================================  EOF  ===================================*/
