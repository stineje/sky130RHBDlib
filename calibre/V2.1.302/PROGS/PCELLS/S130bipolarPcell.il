/*==============================================================================
  File:         S130bipolarPcell.il
  Purpose:      Pcell code for symbols and cdf setup for bipolars
                for Skywater S130 Pcells (layouts are fixed so no pcell needed)

  Created:      Apr 23, 2020  Madek Graham
  Description:  Pcell code to create bipolar devices
  
  Devices/views:  npn_1x1    / symbol auCdl auLvs spectre
                  npn_1x1_v5 / symbol auCdl auLvs spectre
                  npn_1x2    / symbol auCdl auLvs spectre
                  pnp        / symbol auCdl auLvs spectre
                  pnp_5x     / symbol auCdl auLvs spectre

------------------------------------------------------------
  Modifications:

==============================================================================*/

/*==============================================================================

  This file only needs to be loaded once to create the pcells and cdf information
  for the bipolarDevices set within the S130techData.il file

==============================================================================*/

let( ( libName )

  libName = "S130"

  foreach( device bipolarDevices

    printf("Creating device %s in %s library\n" device->deviceName libName )

    ; layouts are fixed so no code needed for them

    ;===========================================================
    ;***** Define Symbol Pcell *****
    ;===========================================================

    foreach( view list("symbol" "auCdl" "auLvs" "spectre")
      let( (cv modelLabel instLabel labelM netC netE netB netb col emit base body
        termC termE termB termb paramLabel)
      when( cv = dbOpenCellViewByType( ddGetObj(libName) device->deviceName view "schematicSymbol" "w" ) 

        dbReplaceProp(cv "instNamePrefix" "string" "Q")

        ; bounding box and main labels
        ;-----------------------------
        dbCreateRect(cv list("instance" "drawing") list(0.0:-0.1875 0.25:0.1875))
        modelLabel = dbCreateLabel( cv list("text" "drawing") 0.21875:0.21875 "[@model]"
          "centerRight" "R0" "stick" 0.03125 )
        modelLabel~>labelType = "NLPLabel"
        instLabel = dbCreateLabel( cv list("annotate" "drawing7") 0.21875:0.1625 "[@instanceName]"
          "centerRight" "R0" "stick" 0.03125 )
        instLabel~>labelType = "NLPLabel"


        ; create nets and pins
        ;-----------------------------
        netC = dbMakeNet(cv "C")
        netB = dbMakeNet(cv "B")
        netE = dbMakeNet(cv "E")
        dbCreateTerm(netC "C" "inputOutput")
        dbCreateTerm(netB "B" "input")
        dbCreateTerm(netE "E" "inputOutput")
        if( rexMatchp("pnp" device->deviceName) then
          ; create an extra terminal that is tied to net "C" to eliminate CDL export errors
          dbCreateTerm(netC "sub" "inputOutput")
        )

        base = dbCreateRect(cv list("pin" "drawing")
          list(-0.01875:-0.01875 0.01875:0.01875) )
        dbCreatePin(netB base)
        termB = dbCreateLabel( cv list("annotate" "drawing8") 0:0.0125 "cdsTerm(\"B\")"
          "lowerRight" "R0" "stick" 0.01875 )
        termB~>labelType = "ILLabel"
        termB->parent = base

        ; c,e,body and arrows are p/n dependent
        if( rexMatchp("pnp" device->deviceName) then
          col = dbCreatePolygon(cv list("pin" "drawing")
            list( 0.23125:-0.16875 0.25:-0.20625 0.26875:-0.16875) )
          dbCreatePin(netC col)
          emit = dbCreateRect(cv list("pin" "drawing")
            list(0.23125:0.16875 0.26875:0.20625) )
          dbCreatePin(netE emit)
          ; pin cdsTerm labels
          termE = dbCreateLabel( cv list("annotate" "drawing8") 0.2425:0.1875 "cdsTerm(\"E\")"
            "lowerLeft" "R90" "stick" 0.01875 )
          termE~>labelType = "ILLabel"
          termC = dbCreateLabel( cv list("annotate" "drawing8") 0.2425:-0.1875 "cdsTerm(\"C\")"
            "lowerRight" "R90" "stick" 0.01875 )
          termC~>labelType = "ILLabel"

          labelM = dbCreateLabel(cv list("annotate" "drawing") 0.275:-0.0625 "[@m:M=%]"
            "centerLeft" "R0" "stick" 0.03125)
          labelM->labelType = "NLPLabel"
          paramLabel = dbCreateLabel( cv list("annotate" "drawing") 0.275:-0.125 "cdsParam(1)"
            "centerLeft" "R0" "stick" 0.03125 )
          paramLabel~>labelType = "ILLabel"
          paramLabel = dbCreateLabel( cv list("annotate" "drawing") 0.275:-0.1875 "cdsParam(2)"
            "centerLeft" "R0" "stick" 0.03125 )
          paramLabel~>labelType = "ILLabel"
          paramLabel = dbCreateLabel( cv list("annotate" "drawing") 0.275:-0.25 "cdsParam(3)"
            "centerLeft" "R0" "stick" 0.03125 )
          paramLabel~>labelType = "ILLabel"
          cv~>portOrder = list("C" "B" "E")
          ; emit arrow
          dbCreatePolygon(cv list("device" "drawing1")
            list(0.125:0.04375 0.1625:0.09375 0.1875:0.04375) )
        else
          emit = dbCreateRect(cv list("pin" "drawing")
            list(0.23125:-0.20625 0.26875:-0.16875) )
          dbCreatePin(netE emit)
          col = dbCreateRect(cv list("pin" "drawing")
            list(0.23125:0.16875 0.26875:0.20625) )
          dbCreatePin(netC col)
          netb = dbMakeNet(cv "body")
          dbCreateTerm(netb "body" "inputOutput")
          body = dbCreatePolygon(cv list("pin" "drawing")
            list(0.2625:-0.01875-0.0625 0.23125:-0.0625 0.2625:0.01875-0.0625 ) )
          dbCreatePin(netb body)

          ; pin cdsTerm labels
          termC = dbCreateLabel( cv list("annotate" "drawing8") 0.2425:0.1875 "cdsTerm(\"C\")"
            "lowerLeft" "R90" "stick" 0.01875 )
          termC~>labelType = "ILLabel"
          termE = dbCreateLabel( cv list("annotate" "drawing8") 0.2425:-0.1875 "cdsTerm(\"E\")"
            "lowerRight" "R90" "stick" 0.01875 )
          termE~>labelType = "ILLabel"
          termb = dbCreateLabel( cv list("annotate" "drawing8") 0.25:-0.05 "cdsTerm(\"body\")"
            "lowerLeft" "R0" "stick" 0.01875 )
          termb~>labelType = "ILLabel"
          termb->parent = body

          labelM = dbCreateLabel(cv list("annotate" "drawing") 0.275:0.0625 "[@m:M=%]"
            "centerLeft" "R0" "stick" 0.03125)
          labelM->labelType = "NLPLabel"
          paramLabel = dbCreateLabel( cv list("annotate" "drawing") 0.275:0.125 "cdsParam(1)"
            "centerLeft" "R0" "stick" 0.03125 )
          paramLabel~>labelType = "ILLabel"
          paramLabel = dbCreateLabel( cv list("annotate" "drawing") 0.275:0.1875 "cdsParam(2)"
            "centerLeft" "R0" "stick" 0.03125 )
          paramLabel~>labelType = "ILLabel"
          paramLabel = dbCreateLabel( cv list("annotate" "drawing") 0.275:0.25 "cdsParam(3)"
            "centerLeft" "R0" "stick" 0.03125 )
          paramLabel~>labelType = "ILLabel"
          cv~>portOrder = list("C" "B" "E" "body")
          ; emit arrow
          dbCreatePolygon(cv list("device" "drawing1")
            list(0.25:-0.10625 0.2125:-0.05625 0.1875:-0.10625))
        ); if pnp
        termE->parent = emit
        termC->parent = col
        ; c/e leads
        dbCreateLine(cv list("device" "drawing") list(0.25:0.1875 0.25:0.10625
          0.125:0.04375 0.125:-0.04375 0.25:-0.10625 0.25:-0.1875))

        ; base
        ;-----------------------------
        if( device->hv then
          ; gate drawing
          dbCreateRect(cv list("device" "drawing") list(0.09375:-0.09375 0.125:0.09375))
          ; gate wire
          dbCreateLine(cv list("device" "drawing") list(0.0:0.0 0.09375:0.0))
        else
          ; gate drawing
          dbCreateLine(cv list("device" "drawing") list(0.125:0.125 0.125:-0.125))
          ; gate wire
          dbCreateLine(cv list("device" "drawing") list(0.0:0.0 0.125:0.0))
        ); if hv

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
      ; fixed layout, so fixed area/perim.  npn_1x1_v5 has octogon emitter
      cdfCreateParam( cdf
        ?name           "area"
        ?prompt         "Area (um^2)"
        ?type           "string"
        ?defValue       if( device->deviceName == "npn_1x1_v5" then
                          "1.97247"
                        else
                          S130stringTruncateZeros(sprintf(nil "%f" (device->defW * device->defL) ))
                        )
        ?editable       "nil"
        ?storeDefault   "yes"
        ?parseAsCEL     "yes"
        ?parseAsNumber  "yes"
      )
      cdfCreateParam( cdf
        ?name           "perim"
        ?prompt         "Perimeter (um)"
        ?type           "string"
        ?defValue       if( device->deviceName == "npn_1x1_v5" then
                          "5.12718"
                        else
                          S130stringTruncateZeros(sprintf(nil "%.3f" (2*device->defW + 2*device->defL) ))
                        )
        ?editable       "nil"
        ?storeDefault   "yes"
        ?parseAsCEL     "yes"
        ?parseAsNumber  "yes"
      )
      cdfCreateParam( cdf
        ?name           "w"
        ?prompt         "Width (um)"
        ?type           "float"
        ?defValue       device->defW
        ?storeDefault   "yes"
        ?display        "nil"
      )
      cdfCreateParam( cdf
        ?name           "l"
        ?prompt         "Length (um)"
        ?type           "float"
        ?defValue       device->defL
        ?storeDefault   "yes"
        ?display        "nil"
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
        instParameters    (model m area p )
        propMapping       (nil model lvsModel p perim)
        componentName     nil
        termOrder         (C B E body)
        namePrefix        "Q"
      )
      when( rexMatchp("pnp" device->deviceName)
        cdf->simInfo->auCdl->termOrder = '(C B E C)
      )
      cdf->simInfo->auLvs = '( nil
      )
      when( rexMatchp("pnp" device->deviceName)
        cdf->simInfo->auLvs->termOrder = '(C B E C)
      )
      cdf->simInfo->spectre = '( nil
        propMapping             nil
        otherParameters         (model)
        instParameters          (m)
        termOrder               (C B E body)
        namePrefix              "Q"
        componentName           model
      )
      when( rexMatchp("pnp" device->deviceName)
        cdf->simInfo->spectre->termOrder = '(C B E C)
      )

      cdf->simInfo->spectreS = '( nil
        propMapping             nil
        netlistProcedure        ansSpectreSDevPrim
        otherParameters         (model)
        instParameters          (m)
        termOrder               (C B E body)
        namePrefix              "Q"
        componentName           model
      )
      when( rexMatchp("pnp" device->deviceName)
        cdf->simInfo->spectreS->termOrder = '(C B E C)
      )

      ;;; Properties
      cdf->formInitProc              = "S130disablePcellChange"
      cdf->doneProc                  = ""
      cdf->buttonFieldWidth          = 340
      cdf->fieldHeight               = 35
      cdf->fieldWidth                = 350
      cdf->promptWidth               = 175
      cdf->modelLabelSet             = ""
      cdf->opPointLabelSet           = "betadc ic Vce"
      cdf->paramLabelSet             = "Vbe Vce"

      cdfSaveCDF(cdf)

    );  let
  ); foreach device

);  let

/*==================================  EOF  ===================================*/
