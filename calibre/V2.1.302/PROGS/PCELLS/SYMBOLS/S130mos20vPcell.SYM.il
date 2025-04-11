/*==============================================================================
  File:         S130fet20vPcell.il
  Purpose:      Pcell code for symbols setup for 20v mosfet (DE)
                devices for Skywater S130 Pcells

  Created:      Aug 15, 2020  Madek Graham
  Description:  Pcell code to create the 20V mosfet (DE) devices
  
  Devices/views:  nmos_de_v20         / symbol auCdl auLvs spectre
                  nmos_de_nat_v20     / symbol auCdl auLvs spectre
                  nmos_de_zvt_v20     / symbol auCdl auLvs spectre
                  nmos_de_iso_v20     / symbol auCdl auLvs spectre
                  pmos_de_v20         / symbol auCdl auLvs spectre

------------------------------------------------------------
  Modifications:

==============================================================================*/

let( ( libName )

  libName = "S130"

  foreach( device fet20vDevices

    printf("Creating device %s in %s library\n" device->deviceName libName )

    ;===========================================================
    ;***** Define Symbol Pcell *****
    ;===========================================================

    foreach( view list("symbol" "auCdl" "auLvs" "spectre")
      pcDefinePCell( list( ddGetObj(libName) device->deviceName view "schematicSymbol" "w")
        ; formal parameters name value pairs
        (
          ( devInfo       "ilList"  device )
          ( model         "string"  device->modelName )
          ( fw            "float"   device->deffw )
          ( l             "float"   device->defl )
          ( nf            "int"     device->defnf )
          ( m             "int"     device->defm )
        )
        let( (cv modelLabel instLabel netd netg nets netb netsub g d s b sub
            termG termD termS termB termSub paramLabel
            xStart yStart labelSize labelM fwString lString )

        cv = pcCellView

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

        ; sub pin for iso devices
        when( rexMatchp("iso" devInfo->deviceName)
          netsub = dbMakeNet(cv "sub")
          dbCreateTerm(netsub "sub" "inputOutput")
          sub = dbCreatePolygon(cv list("pin" "drawing")
            list(-0.01875:0.01875 0:-0.01875 0.01875:0.01875) )
          dbMoveShape(sub cv list(0.0625:-0.1875 "R0"))
          dbCreatePin(netsub sub)
          termSub = dbCreateLabel( cv list("annotate" "drawing8") 0.055:-0.1875 "cdsTerm(\"sub\")"
            "lowerRight" "R0" "stick" 0.01875 )
          termSub~>labelType = "ILLabel"
          termSub->parent = sub
        ); when iso device

        ; s,d,b and arrows are p/n dependent
        if( rexMatchp("^pmos" devInfo->deviceName) then
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
        ); if pmos
        termS->parent = s
        termD->parent = d
        termB->parent = b

        ; s/d leads
        ;-----------------------------
        dbCreateLine(cv list("device" "drawing") list(0.25:0.1875 0.25:0.09375 0.15625:0.09375))
        dbCreateLine(cv list("device" "drawing") list(0.15625:-0.09375 0.25:-0.09375 0.25:-0.1875))

        ; channel (native or normal)
        ;-----------------------------
        if( rexMatchp("_nat" devInfo->deviceName) then
          dbCreateLine(cv list("device" "drawing") list(0.15625:-0.0625 0.15625:-0.09375) )
          dbCreateLine(cv list("device" "drawing") list(0.15625:0.03125 0.15625:-0.03125) )
          dbCreateLine(cv list("device" "drawing") list(0.15625:0.09375 0.15625:0.06250) )
        else
          dbCreateLine(cv list("device" "drawing") list(0.15625:0.09375 0.15625:-0.09375) )
        ); when native

        ; gate & hv goo
        ;-----------------------------
        ; gate drawing
        if( rexMatchp("_zvt" devInfo->deviceName) then
          dbCreateRect(cv list("device" "drawing1") list(0.09375:-0.09375 0.125:0.09375)) 
        else
          dbCreateRect(cv list("device" "drawing") list(0.09375:-0.09375 0.125:0.09375)) 
        ); if zvt
        ; gate wire (& bubble)
        if( rexMatchp("^pmos" devInfo->deviceName) then
          dbCreateLine(cv list("device" "drawing") list(0.0:0.0 0.0625:0.0))
          dbCreateEllipse(cv list("device" "drawing") list(0.0625:-0.015625 0.09375:0.015625))
        else
          dbCreateLine(cv list("device" "drawing") list(0.0:0.0 0.09375:0.0))
        )

        ; Voltage label
        ; vhv & uhv extra on drain
        dbCreateLabel(cv list("device" "label") 0.0625:-.15625
          sprintf(nil "%dV" devInfo->hv) "lowerCenter" "R0" "stick" 0.046875)
        if( rexMatchp("^pmos" devInfo->deviceName) then
          dbCreateLine(cv list("device" "drawing")
            list(0.15625:-0.078125 0.25:-0.078125 0.25:-0.09375))
        else
          dbCreateLine(cv list("device" "drawing")
            list(0.15625:0.078125 0.25:0.078125 0.25:0.09375))
        )

        ; non-fancy fw,l,nf,m label
        ;-----------------------------
        xStart = 0.275
        yStart = if( rexMatchp("^pmos" devInfo->deviceName) then -0.0525 else 0.115 )
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
      ); pcDefinePCell symbol
    ); foreach view

  ); foreach device

);  let

/*==================================  EOF  ===================================*/
