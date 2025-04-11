/*==============================================================================
  File:         S130dioPcell.il
  Purpose:      Pcell code for layout and/or symbols, and cdf setup for diodes
                for Skywater S130 Pcells

  Created:      Mar 14, 2020  Madek Graham
  Description:  Pcell code to create diode devices
  
  Devices/views:  ddnw_sub / symbol auCdl auLvs spectre
                  ddnw_sub_v5 / symbol auCdl auLvs spectre
                  ddnw_sub_v12 / symbol auCdl auLvs spectre
                  ddnw_sub_v20 / symbol auCdl auLvs spectre
                  dipw_dnw / symbol auCdl auLvs spectre
                  dipw_dnw_v5 / symbol auCdl auLvs spectre
                  dipw_dnw_v12 / symbol auCdl auLvs spectre
                  dipw_dnw_v20 / symbol auCdl auLvs spectre

------------------------------------------------------------
  Modifications:

==============================================================================*/

/*==============================================================================

  This file only needs to be loaded once to create the pcells and cdf information
  for the dioDevices set within the S130techData.il file

==============================================================================*/

let( ( libName )

  libName = "S130"

  foreach( device welldioDevices

    printf("Creating device %s in %s library\n" device->deviceName libName )

    ;===========================================================
    ;***** Define Symbol Pcell *****
    ;===========================================================

    foreach( view list("symbol" "auCdl" "auLvs" "spectre")
      let( (cv modelLabel instLabel labelA labelM
            netm netp plus minus termP termM paramLabel)
      when( cv = dbOpenCellViewByType( ddGetObj(libName) device->deviceName view "schematicSymbol" "w" ) 

        dbReplaceProp(cv "instNamePrefix" "string" "D")

        ; bounding box and main labels
        ;-----------------------------
        dbCreateRect(cv list("instance" "drawing") list(-0.0625:-0.375 0.065:0.0))

        instLabel = dbCreateLabel( cv list("annotate" "drawing7") -0.0625:-0.046875 "[@instanceName]"
          "centerRight" "R0" "stick" 0.0625 )
        instLabel~>labelType = "NLPLabel"
        modelLabel = dbCreateLabel( cv list("text" "drawing") 0.078125:-0.1875 "[@model]"
          "upperCenter" "R90" "stick" 0.03125 )
        modelLabel~>labelType = "NLPLabel"

        labelA = dbCreateLabel( cv list("annotate" "drawing") -0.0625:-0.140625 "[@area:A=%]"
          "centerRight" "R0" "stick" 0.03125 )
        labelA~>labelType = "NLPLabel"
        labelM = dbCreateLabel(cv list("annotate" "drawing") -0.0625:-0.203125
          "[@m:M=%]" "centerRight" "R0" "stick" 0.03125)
        labelM->labelType = "NLPLabel"

        ; create nets and pins
        ;-----------------------------
        netp = dbMakeNet(cv "PLUS")
        dbCreateTerm(netp "PLUS" "inputOutput")
        if( rexMatchp("sub" device->deviceName) then 
          plus = dbCreatePolygon(cv list("pin" "drawing")
            list(-0.01875:0.01875 0:-0.01875 0.01875:0.01875) )
        else
          plus = dbCreateRect(cv list("pin" "drawing")
            list(-0.01875:-0.01875 0.01875:0.01875) )
        ); if device is sub
        dbMoveShape(plus cv list(0:-0.375 "R0"))
        dbCreatePin(netp plus)
        termP = dbCreateLabel( cv list("annotate" "drawing8") 0.0125:-0.375 "cdsTerm(\"PLUS\")"
          "upperRight" "R90" "stick" 0.01875 )
        termP~>labelType = "ILLabel"
        termP->parent = plus

        netm = dbMakeNet(cv "MINUS")
        dbCreateTerm(netm "MINUS"  "inputOutput")
        minus = dbCreateRect(cv list("pin" "drawing")
          list(-0.01875:-0.01875 0.01875:0.01875) )
        dbCreatePin(netm minus)
        termM = dbCreateLabel( cv list("annotate" "drawing8") 0.0125:0 "cdsTerm(\"MINUS\")"
          "upperLeft" "R90" "stick" 0.01875 )
        termM~>labelType = "ILLabel"
        termM->parent = minus

        cv~>portOrder = list("PLUS" "MINUS")

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

        ; main diode drawing
        ;-----------------------------
        dbCreateLine(cv list("device" "drawing") list(0.0:0.0 0.0:-0.15625) )
        dbCreateLine(cv list("device" "drawing") list(0.0:-0.25 0.0:-0.375) )
        if( device->hv then
          dbCreateLine(cv list("y9" "drawing") list(-0.0625:-0.15625 0.0625:-0.15625) )
          dbCreateLine(cv list("y9" "drawing")
            list(-0.0625:-0.25 0.0625:-0.25 0.0:-0.15625 -0.0625:-0.25) )
        else
          dbCreateLine(cv list("device" "drawing") list(-0.0625:-0.15625 0.0625:-0.15625) )
          dbCreateLine(cv list("device" "drawing")
            list(-0.0625:-0.25 0.0625:-0.25 0.0:-0.15625 -0.0625:-0.25) )
        ); if hv

        ; HV label for high voltage devices
        ;-----------------------------
        when( device->hv
          dbCreateLabel( cv list("device" "drawing") 0.0:-0.21875
            sprintf(nil "%dV" device->hv) "centerCenter" "R0" "stick" 0.01875 )
        )

        dbReplaceProp(cv "ignore" "boolean" t)

      dbSave(cv)
      dbClose(cv)
      ); when cv
      ); let
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
        ?name           "area"
        ?prompt         "Area (um^2)"
        ?type           "string"
        ?defValue       S130stringTruncateZeros(sprintf(nil "%f" (device->defW * device->defL) ))
        ?storeDefault   "yes"
        ?parseAsCEL     "yes"
        ?parseAsNumber  "yes"
        ?callback       strcat(device->paramCB "()")
      )
      cdfCreateParam( cdf
        ?name           "perim"
        ?prompt         "Perimeter (um)"
        ?type           "string"
        ?defValue       S130stringTruncateZeros(sprintf(nil "%.3f" (2*(device->defW + device->defL)) ))
        ?storeDefault   "yes"
        ?parseAsCEL     "yes"
        ?parseAsNumber  "yes"
        ?callback       strcat(device->paramCB "()")
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

      cdf->simInfo = list( nil)
      cdf->simInfo->auCdl = '( nil
        dollarEqualParams nil
        dollarParams      nil
        otherParameters   nil
        netlistProcedure  ansCdlSubcktCallExtended
        instParameters    (model m area pj)
        propMapping       (nil model lvsModel pj perim)
        componentName     nil
        termOrder         (PLUS MINUS)
        namePrefix        "D"
      )
      cdf->simInfo->auLvs = '( nil
        dollarEqualParams nil
        dollarParams      nil
        otherParameters   nil
        netlistProcedure  ansLvsCompParamPrim
        instParameters    (model m area pj )
        propMapping       (nil model lvsModel pj perim)
        termOrder         (PLUS MINUS)
        namePrefix        "D"
      )
      cdf->simInfo->spectre = '( nil
        propMapping             nil
        otherParameters         (model)
        instParameters          (m area perim)
        termOrder               (PLUS MINUS)
        namePrefix              "D"
        componentName           model
      )

      cdf->simInfo->spectreS = '( nil
        propMapping             nil
        netlistProcedure        ansSpectreSDevPrim
        otherParameters         (model)
        instParameters          (m area perim)
        termOrder               (PLUS MINUS)
        namePrefix              "D"
        componentName           model
      )

      ;;; Properties
      cdf->formInitProc              = "S130disablePcellChange"
      cdf->doneProc                  = ""
      cdf->buttonFieldWidth          = 340
      cdf->fieldHeight               = 35
      cdf->fieldWidth                = 350
      cdf->promptWidth               = 175
      cdf->modelLabelSet             = "is rs n"
      cdf->opPointLabelSet           = "id vd reg"
      cdf->paramLabelSet             = ""

      cdfSaveCDF(cdf)

    );  let
  ); foreach device

);  let

/*==================================  EOF  ===================================*/
