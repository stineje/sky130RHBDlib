/*==============================================================================
  File:         S130padPcell.il
  Purpose:      Pcell code for symbols setup for the pads
                for Skywater S130 Pcell

  Created:      June 21, 2020  Madek Graham
  Description:  Pcell code to create pad devices
  
  Devices/views:  pad_bond / symbol auCdl auLvs
                  pad_probe / symbol auCdl auLvs
                  pad_microprobe / symbol auCdl auLvs

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
    ;***** Define Symbol Pcell *****
    ;===========================================================

    foreach( view list("symbol" "auCdl" "auLvs")
      let( (cv instLabel labelT labelM netp pad termP sizeFactor)
        when( cv = dbOpenCellViewByType( ddGetObj(libName) device->deviceName view "schematicSymbol" "w" ) 

          case( device->deviceName
            ("pad_bond"       
              dbReplaceProp(cv "instNamePrefix" "string" "PAD")
              sizeFactor = 0.0
            )
            ("pad_probe"      
              dbReplaceProp(cv "instNamePrefix" "string" "PROBE")
              sizeFactor = 0.0625
            )
            ("pad_microprobe" 
              dbReplaceProp(cv "instNamePrefix" "string" "MPROBE")
              sizeFactor = 0.125
            )
          ); end case

          ; only need this for auCdl and auLvs, not for simulation
          dbReplaceProp(cv "nlIgnore" "string" "ams hspiceD spectre spectreS verilog vhdl")

          ; pad drawing and main labels
          ;-----------------------------
          dbCreateRect(cv list("instance" "drawing") list(-0.375+sizeFactor:-0.5+sizeFactor
            0.375-sizeFactor:0.375-sizeFactor))
          dbCreateRect(cv list("device" "drawing")  list(-0.375+sizeFactor:-0.375+sizeFactor
            0.375-sizeFactor:0.375-sizeFactor))
          dbCreateRect(cv list("device" "drawing2") list(-0.25+sizeFactor:-0.25+sizeFactor
            0.25-sizeFactor:0.25-sizeFactor))
          dbCreateLine(cv list("device" "drawing2") list(-0.25+sizeFactor:-0.25+sizeFactor
            0.25-sizeFactor:0.25-sizeFactor))
          dbCreateLine(cv list("device" "drawing2") list(-0.25+sizeFactor:0.25-sizeFactor
            0.25-sizeFactor:-0.25+sizeFactor))
          dbCreateLine(cv list("device" "drawing") list(0:-0.375+sizeFactor 0:-0.5+sizeFactor))

          instLabel = dbCreateLabel( cv list("annotate" "drawing7") 0:0.40625-sizeFactor
            "[@instanceName]" "lowerCenter" "R0" "stick" 0.0625 )
          instLabel~>labelType = "NLPLabel"

          labelT = dbCreateLabel(cv list("text" "drawing") 0:0.3125-sizeFactor
            "[@lvsModel:%]" "centerCenter" "R0" "stick" 0.05625-0.2*sizeFactor)
          labelT->labelType = "NLPLabel"
          labelM = dbCreateLabel(cv list("annotate" "drawing") 0:-0.3125+sizeFactor
            "[@m:M=%]" "centerCenter" "R0" "stick" 0.03125)
          labelM->labelType = "NLPLabel"

          ; create net and pin
          ;-----------------------------
          netp = dbMakeNet(cv "PAD")
          dbCreateTerm(netp "PAD" "inputOutput")
          pad = dbCreateRect(cv list("pin" "drawing")
              list(-0.01875:-0.01875 0.01875:0.01875) )
          dbMoveShape(pad cv list(0:-0.5+sizeFactor "R0"))
          dbCreatePin(netp pad)
          termP = dbCreateLabel( cv list("annotate" "drawing8") 0.0125+sizeFactor:-0.48125+sizeFactor
            "cdsTerm(\"PAD\")" "lowerLeft" "R0" "stick" 0.01875 )
          termP~>labelType = "ILLabel"
          termP->parent = pad

          dbSave(cv)
          dbClose(cv)
        ); when cv
      ); let
      printf("  ...%s view created\n" view )
    ); foreach view

  ); foreach device

);  let

/*==================================  EOF  ===================================*/
