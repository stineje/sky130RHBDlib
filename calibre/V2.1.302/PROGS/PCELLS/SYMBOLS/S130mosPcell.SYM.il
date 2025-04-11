/*==============================================================================
  File:         S130fetPcell.il
  Purpose:      Pcell code for symbols setup for mosfet (non-DE)
                devices for Skywater S130 Pcells

  Created:      Mar 25, 2020  Madek Graham
  Description:  Pcell code to create the mosfet (non-DE) devices
  
  Devices/views:  nmos            / symbol auCdl auLvs spectre
                  nmos_esd_nat_v5 / symbol auCdl auLvs spectre
                  nmos_esd_v5     / symbol auCdl auLvs spectre
                  nmos_lvt        / symbol auCdl auLvs spectre
                  nmos_nat_v3     / symbol auCdl auLvs spectre
                  nmos_nat_v5     / symbol auCdl auLvs spectre
                  nmos_v5         / symbol auCdl auLvs spectre
                  pmos            / symbol auCdl auLvs spectre
                  pmos_esd_v5     / symbol auCdl auLvs spectre
                  pmos_hvt        / symbol auCdl auLvs spectre
                  pmos_lvt        / symbol auCdl auLvs spectre
                  pmos_v5         / symbol auCdl auLvs spectre

------------------------------------------------------------
  Modifications:
  - Jun 27, 2020 MSG
    Changed hvi layer to thkox to accomodate change in PDK
  - Sep 05, 2020 MSG
    Changed tap to default to bot, added fixed cdf params for w & l for discrete
    device sizes
  - Jan 12, 2021 MSG
    Added abutment rules
    Changed cdsTerms on symbols so they are a bit off the pin
  - Feb 13, 2021 MSG
    Split file into 3 parts (cdf, sym, lay)

==============================================================================*/

let( ( libName )

  ;libName = "S130"
  libName = "pcell_dev"

  foreach( device fetDevices

    printf("Creating device %s symbols in %s library\n" device->deviceName libName )

    ;===========================================================
    ;***** Define Symbol Pcell *****
    ;===========================================================

    foreach( view list("symbol" "auCdl" "auLvs" "spectre")
      pcDefinePCell( list( ddGetObj(libName) device->deviceName view "schematicSymbol" "w")
        ; formal parameters name value pairs
        (
          ( devInfo       "ilList"  device )
          ( model         "string"  device->modelName )
          ( fw            "float"   device->defW ) ; finger width
          ( l             "float"   device->defL )
          ( nf            "int"     1 )
          ( m             "int"     1 )
        )

        let( (cv modelLabel instLabel netd netg nets netb g d s b
            termG termD termS termB paramLabel
            xStart yStart labelSize labelM fwString lString )

        cv = pcCellView

        ; devInfo->native ; boolean: nil, t
        ; devInfo->esd    ; boolean: nil, t
        ; devInfo->hv     ; int:  nil, 3, 5, 12, 20
        ; devInfo->vt     ; string:  nil, "low", "med", "high"

        ; bounding box and main labels
        ;-----------------------------
        dbCreateRect(cv list("instance" "drawing") list(0.0:-0.1875 0.2625:0.1875))
        modelLabel = dbCreateLabel( cv list("text" "drawing") 0.1875:0.24375 "[@model]"
          "centerRight" "R0" "stick" 0.05 )
        modelLabel~>labelType = "NLPLabel"
        instLabel = dbCreateLabel( cv list("annotate" "drawing7") 0.15625:0.1625 "[@instanceName]"
          "centerRight" "R0" "stick" 0.05 )
        instLabel~>labelType = "NLPLabel"

        ; create nets and pins
        ;-----------------------------
        netd = dbMakeNet(cv "d")
        netg = dbMakeNet(cv "g")
        nets = dbMakeNet(cv "s")
        netb = dbMakeNet(cv "b")
        dbCreateTerm(netd "d" "inputOutput")
        dbCreateTerm(netg "g" "input")
        dbCreateTerm(nets "s" "inputOutput")
        dbCreateTerm(netb "b" "inputOutput")
        g = dbCreateRect(cv list("pin" "drawing")
          list(-0.01875:-0.01875 0.01875:0.01875) )
        dbCreatePin(netg g)
        termG = dbCreateLabel( cv list("annotate" "drawing8") -0.02:0.0125 "cdsTerm(\"g\")"
          "lowerRight" "R0" "stick" 0.025 )
        termG~>labelType = "ILLabel"
        termG->parent = g

        ; s,d,b and arrows are p/n dependent
        if( devInfo->nwellLay then
          dbReplaceProp(cv "instNamePrefix" "string" "MP")
          d = dbCreateRect(cv list("pin" "drawing")
            list(0.23125:-0.20625 0.26875:-0.16875) )
          dbCreatePin(netd d)
          s = dbCreateRect(cv list("pin" "drawing")
            list(0.23125:0.16875 0.26875:0.20625) )
          dbCreatePin(nets s)
          b = dbCreatePolygon(cv list("pin" "drawing")
            list(0.23125:-0.01875+0.0625 0.2625:0.0625 0.23125:0.01875+0.0625) )
          dbCreatePin(netb b)
          ; src arrow
          dbCreatePolygon(cv list("device" "drawing1")
            list(0.19375:0.075 0.15625:0.09375 0.19375:0.1125) )
          ; pin cdsTerm labels
          termS = dbCreateLabel( cv list("annotate" "drawing8") 0.23125:0.22 "cdsTerm(\"s\")"
            "lowerLeft" "R90" "stick" 0.025 )
          termS~>labelType = "ILLabel"
          termD = dbCreateLabel( cv list("annotate" "drawing8") 0.23125:-0.22 "cdsTerm(\"d\")"
            "lowerRight" "R90" "stick" 0.025 )
          termD~>labelType = "ILLabel"
          termB = dbCreateLabel( cv list("annotate" "drawing8") 0.27:0.0625 "cdsTerm(\"b\")"
            "upperLeft" "R0" "stick" 0.025 )
          termB~>labelType = "ILLabel"
          paramLabel = dbCreateLabel( cv list("annotate" "drawing") 0.28125:-0.25 "cdsParam(1)"
            "lowerLeft" "R0" "stick" 0.03125 )
          paramLabel~>labelType = "ILLabel"
          paramLabel = dbCreateLabel( cv list("annotate" "drawing") 0.03125:-0.065 "cdsParam(2)"
            "centerRight" "R0" "stick" 0.03125 )
          paramLabel~>labelType = "ILLabel"
          paramLabel = dbCreateLabel( cv list("annotate" "drawing") 0.03125:0.065 "cdsParam(3)"
            "centerRight" "R0" "stick" 0.03125 )
          paramLabel~>labelType = "ILLabel"
          paramLabel = dbCreateLabel( cv list("annotate" "drawing") 0.28125:-0.3125 "cdsParam(4)"
            "lowerLeft" "R0" "stick" 0.03125 )
          paramLabel~>labelType = "ILLabel"
          paramLabel = dbCreateLabel( cv list("annotate" "drawing") 0.28125:-0.375 "cdsParam(5)"
            "lowerLeft" "R0" "stick" 0.03125 )
          paramLabel~>labelType = "ILLabel"
        else
          dbReplaceProp(cv "instNamePrefix" "string" "MN")
          s = dbCreateRect(cv list("pin" "drawing")
            list(0.23125:-0.20625 0.26875:-0.16875) )
          dbCreatePin(nets s)
          d = dbCreateRect(cv list("pin" "drawing")
            list(0.23125:0.16875 0.26875:0.20625) )
          dbCreatePin(netd d)
          b = dbCreatePolygon(cv list("pin" "drawing")
            list(0.2625:-0.01875-0.0625 0.23125:-0.0625 0.2625:0.01875-0.0625 ) )
          dbCreatePin(netb b)
          ; src arrow
          dbCreatePolygon(cv list("device" "drawing1")
            list(0.2125:-0.1125 0.25:-0.09375 0.2125:-0.075) )
          ; pin cdsTerm labels
          termD = dbCreateLabel( cv list("annotate" "drawing8") 0.23125:0.22 "cdsTerm(\"d\")"
            "lowerLeft" "R90" "stick" 0.025 )
          termD~>labelType = "ILLabel"
          termS = dbCreateLabel( cv list("annotate" "drawing8") 0.23125:-0.22 "cdsTerm(\"s\")"
            "lowerRight" "R90" "stick" 0.025 )
          termS~>labelType = "ILLabel"
          termB = dbCreateLabel( cv list("annotate" "drawing8") 0.27:-0.05 "cdsTerm(\"b\")"
            "lowerLeft" "R0" "stick" 0.025 )
          termB~>labelType = "ILLabel"
          paramLabel = dbCreateLabel( cv list("annotate" "drawing") 0.28125:0.25 "cdsParam(1)"
            "upperLeft" "R0" "stick" 0.03125 )
          paramLabel~>labelType = "ILLabel"
          paramLabel = dbCreateLabel( cv list("annotate" "drawing") 0.03125:0.065 "cdsParam(2)"
            "centerRight" "R0" "stick" 0.03125 )
          paramLabel~>labelType = "ILLabel"
          paramLabel = dbCreateLabel( cv list("annotate" "drawing") 0.03125:-0.065 "cdsParam(3)"
            "centerRight" "R0" "stick" 0.03125 )
          paramLabel~>labelType = "ILLabel"
          paramLabel = dbCreateLabel( cv list("annotate" "drawing") 0.28125:0.3125 "cdsParam(4)"
            "upperLeft" "R0" "stick" 0.03125 )
          paramLabel~>labelType = "ILLabel"
          paramLabel = dbCreateLabel( cv list("annotate" "drawing") 0.28125:0.375 "cdsParam(5)"
            "upperLeft" "R0" "stick" 0.03125 )
          paramLabel~>labelType = "ILLabel"
        ); if nwell
        termS->parent = s
        termD->parent = d
        termB->parent = b

        ; s/d leads
        ;-----------------------------
        dbCreateLine(cv list("device" "drawing") list(0.25:0.1875 0.25:0.09375 0.15625:0.09375))
        dbCreateLine(cv list("device" "drawing") list(0.15625:-0.09375 0.25:-0.09375 0.25:-0.1875))

        ; channel (native or normal)
        ;-----------------------------
        if( devInfo->native then
          dbCreateLine(cv list("device" "drawing") list(0.15625:-0.0625 0.15625:-0.09375) )
          dbCreateLine(cv list("device" "drawing") list(0.15625:0.03125 0.15625:-0.03125) )
          dbCreateLine(cv list("device" "drawing") list(0.15625:0.09375 0.15625:0.06250) )
        else
          dbCreateLine(cv list("device" "drawing") list(0.15625:0.09375 0.15625:-0.09375) )
        ); when native

        ; gate & hv goo
        ;-----------------------------
        cond(
          ( devInfo->hv
            ; gate drawing
            dbCreateRect(cv list("device" "drawing") list(0.09375:-0.09375 0.125:0.09375)) 
            ; gate wire (& bubble)
            if( devInfo->nwellLay then
              dbCreateLine(cv list("device" "drawing") list(0.0:0.0 0.0625:0.0))
              dbCreateEllipse(cv list("device" "drawing") list(0.0625:-0.015625 0.09375:0.015625))
            else
              dbCreateLine(cv list("device" "drawing") list(0.0:0.0 0.09375:0.0))
            )

            ; Voltage label
            when( devInfo->hv > 5
              ; vhv & uhv extra on drain
              dbCreateLabel(cv list("device" "label") 0.0625:-.15625
                sprintf(nil "%dV" devInfo->hv) "lowerCenter" "R0" "stick" 0.046875)
              if( devInfo->nwellLay then
                dbCreateLine(cv list("device" "drawing")
                  list(0.15625:-0.078125 0.25:-0.078125 0.25:-0.09375))
                when( devInfo->hv == 20
                  dbCreateRect(cv list("device" "drawing1") list(0.09375:-0.09375 0.125:0)) 
                ); when hv = 20
              else
                dbCreateLine(cv list("device" "drawing")
                  list(0.15625:0.078125 0.25:0.078125 0.25:0.09375))
                when( devInfo->hv == 20
                  dbCreateRect(cv list("device" "drawing1") list(0.09375:0 0.125:0.09375)) 
                ); when hv = 20
              )
            ); when > 5V
          )
          (t
            ; gate drawing
            dbCreateLine(cv list("device" "drawing") list(0.125:0.09375 0.125:-0.09375))
            ; gate wire (& bubble)
            if( devInfo->nwellLay then
              dbCreateLine(cv list("device" "drawing") list(0.0:0.0 0.09375:0.0))
              dbCreateEllipse(cv list("device" "drawing") list(0.09375:-0.015625 0.125:0.015625))
            else
              dbCreateLine(cv list("device" "drawing") list(0.0:0.0 0.125:0.0))
            )
          )
        )

        ; vt
        ;-----------------------------
        case( devInfo->vt
          ( "low"
            dbCreateLabel(cv list("device" "label")
              0.09375:-0.15625 "Low Vt" "lowerCenter" "R0" "stick" 0.03125)
          )
          ( "med"
            dbCreateLabel(cv list("device" "label")
              0.09375:-0.15625 "Med Vt" "lowerCenter" "R0" "stick" 0.03125)
          )
          ( "high"
            dbCreateLabel(cv list("device" "label")
              0.09375:-0.15625 "High Vt" "lowerCenter" "R0" "stick" 0.03125)
          )
        )

        ; lightning bolt (ESD devices)
        ;-----------------------------
        when( devInfo->esd
          dbCreatePolygon(cv list("device" "drawing1")
            list(0.05625:-0.08750 0.08125:-0.08750 0.06250:-0.11250 0.08125:-0.11250
            0.03750:-0.16875 0.05000:-0.12500 0.03125:-0.12500) )
        ); when esd

        ; non-fancy fw,l,nf,m label
        ;-----------------------------
        xStart = 0.275
        yStart = if( devInfo->nwellLay then -0.0525 else 0.115 )
        fwString = S130TruncateZeros(fw)
        lString = S130TruncateZeros(l)
        labelSize = dbCreateLabel(cv list("annotate" "drawing") xStart:yStart
          if( nf > 1 then
            sprintf( nil "%d*%s/%s" nf fwString lString )
          else
            sprintf( nil "%s/%s" fwString lString )
          )
          "centerLeft" "R0" "stick" 0.03125
        )
        labelSize->isDrafted = t
        labelM = dbCreateLabel(cv list("annotate" "drawing") xStart:yStart-0.0625
          sprintf( nil "M=%d" m ) "centerLeft" "R0" "stick" 0.03125 )
        labelM->isDrafted = t

        ); let
      ); pcDefinePCell layout
    ); foreach view

  ); foreach device
);  let

/*==================================  EOF  ===================================*/
