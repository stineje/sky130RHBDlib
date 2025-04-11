/*==============================================================================
  File:         S130padPcell.il
  Purpose:      Pcell code for layout setup for the pads
                for Skywater S130 Pcell

  Created:      June 21, 2020  Madek Graham
  Description:  Pcell code to create pad devices
  
  Devices/views:  pad_bond / layout
                  pad_probe / layout
                  pad_microprobe / layout

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
        ( metalOL       "float"   max(designRules->pad->minBotMetOL designRules->pad->minTopMetOL) )
        ( padType       "string"  "I/O" )
      )

      let(( cv adj45 pt0x pt1x pt2x pt3x pt0y pt1y pt2y pt3y )

        cv = pcCellView
        dbReplaceProp(cv "instNamePrefix" "string" "PAD")

        ; figure out the points since all pads need 45 degree corners
        ; origin will always be the center of the pad

        ; create the pad
        if( devInfo->minLbevel then
          adj45 = ceiling(sqrt(0.5*expt(rules->pad->minLbevel 2))/grid)*grid
        else
          adj45 = ceiling(min(w l)*0.1/grid)*grid
        )
        pt0x = pt0y = 0.0
        pt1x = adj45 
        pt2x = w - adj45
        pt3x = w
        pt1y = adj45
        pt2y = l - adj45
        pt3y = l
        rodCreatePolygon(
          ?cvId   cv
          ?name   "pad"
          ?layer  devInfo->padLay->layer
          ?pts    list( pt1x:pt0y pt2x:pt0y pt3x:pt1y pt3x:pt2y pt2x:pt3y
                    pt1x:pt3y pt0x:pt2y pt0x:pt1y )
        )
        ; create pad type marking layer
        rodCreatePolygon(
          ?cvId   cv
          ?name   "padType"
          ?layer  case( padType
                    ("I/O"    list( "areaid" "pad_io" ) )
                    ("Power"  list( "areaid" "pad_pwr" ) )
                    ("Ground" list( "areaid" "pad_gnd" ) )
                  )
          ?fromObj  rodGetObj("pad" cv)
        )

        ; create length LVS marking layer
        rodCreateRect(
          ?cvId     cv
          ?name     "lvsLengthMrk"
          ?layer    list("areaid" "padLength")
          ?width    grid
          ?length   l
          ?origin   list(round(0.5*w/grid)*grid 0.0)
        )

        ; create marking layer if any
        when( devInfo->mrkLay
          rodCreatePolygon(
            ?cvId   cv
            ?name   "mrkLay"
            ?layer  devInfo->mrkLay
            ?pts    list( pt1x:pt0y pt2x:pt0y pt3x:pt1y pt3x:pt2y pt2x:pt3y
                      pt1x:pt3y pt0x:pt2y pt0x:pt1y )
          )
        ); when mrkLay

        ; create identifier label if any
        when( devInfo->label
          dbCreateLabel( cv list(devInfo->padLay->layer "label") rodGetObj("pad" cv)->centerCenter devInfo->label
            "centerCenter" "R0" "stick" min(0.5 min(w l)*0.01) )
        ); when label

        /*
        ; create the module cut layer
        modcutOL = rules->pad->minModcutOL
        pt0x = pt0y = -modcutOL
        pt1x = round((adj45 - 0.5*modcutOL)/grid)*grid
        pt2x = ceiling((w - adj45 + 0.5*modcutOL)/grid)*grid
        pt3x = w + modcutOL
        pt1y = round((adj45 - 0.5*modcutOL)/grid)*grid
        pt2y = ceiling((l - adj45 + 0.5*modcutOL)/grid)*grid
        pt3y = l + modcutOL
        rodCreatePolygon(
          ?cvId   cv
          ?name   "modCut"
          ?layer  list("areaid" "moduleCut")
          ?pts    list( pt1x:pt0y pt2x:pt0y pt3x:pt1y pt3x:pt2y pt2x:pt3y
                    pt1x:pt3y pt0x:pt2y pt0x:pt1y )
        )
        */

        ; create the top metal
        adj45 = round((adj45 - 0.5*metalOL)/grid)*grid
        pt0x = pt0y = -metalOL
        pt1x = adj45
        pt2x = w - adj45
        pt3x = w + metalOL
        pt1y = adj45
        pt2y = l - adj45
        pt3y = l + metalOL
        rodCreatePolygon(
          ?cvId   cv
          ?name   "topMet"
          ?layer  devInfo->topMetLay->layer
          ?pts    list( pt1x:pt0y pt2x:pt0y pt3x:pt1y pt3x:pt2y pt2x:pt3y
                    pt1x:pt3y pt0x:pt2y pt0x:pt1y )
        )

        ; create the bottom metal
        dbLayerAndNot( cv devInfo->botMetLay->layer list( rodGetObj("topMet" cv)->dbId )
          list( rodGetObj("pad" cv)->dbId ))

        ; create the vias
        ; create a keepout to ensure proper metal overlap for bot metal
        rodCreatePolygon(
          ?cvId   cv
          ?name   "keepOut"
          ?layer  list( "text" "drawing" )
          ?fromObj  rodGetObj("pad" cv)
          ?size     devInfo->botMetLay->minOLSviaU
        )
        rodFillWithRects(
          ?shapeId          rodGetObj("topMet" cv)->dbId
          ?keepOut          list( rodGetObj("keepOut" cv)->dbId->points )
          ?fillShapeLPP     list(devInfo->viaLay->layer devInfo->viaLay->purpose)
          ?fillShapeWidth   devInfo->viaLay->minW
          ?fillShapeLength  devInfo->viaLay->minW
          ?justification    "centerCenter"
          ?spaceX           devInfo->viaLay->minSP
          ?spaceY           devInfo->viaLay->minSP
          ?enclosureX       max(
                              devInfo->botMetLay->minOLSviaU
                              devInfo->topMetLay->minOLSviaL
                            )
          ?enclosureY       max(
                              devInfo->botMetLay->minOLSviaU
                              devInfo->topMetLay->minOLSviaL
                            )
          ?grid             grid
        )
        dbDeleteObject(rodGetObj("keepOut" cv)->dbId)

        ; create the pins
        rodCreatePolygon(
          ?cvId   cv
          ?name   "padPin"
          ?layer  list( devInfo->topMetLay->pinlayer devInfo->topMetLay->pinpurpose )
          ?pts    rodGetObj("pad" cv)->dbId->points
          ?netName  "PAD"
          ?termName "PAD"
          ?termIOType "inputOutput"
          ?pin      t
          ?pinLabel t
          ?pinLabelHeight 0.1*min(w l)
          ?pinLabelLayer  list( devInfo->topMetLay->layer "label")
          ?pinLabelFont   "stick"
          ?pinLabelJust "centerCenter"
        )

      ); let
    ); pcDefinePCell layout
    printf("  ...layout view created\n")

  ); foreach device

);  let

/*==================================  EOF  ===================================*/
