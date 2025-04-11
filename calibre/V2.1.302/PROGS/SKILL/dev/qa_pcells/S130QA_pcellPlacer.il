/*==============================================================================
Function Name : S130QA_PcellPlacementForm()
Title         : S130 QA - Pcell Variation Instance Placer
Author        : Madek Graham
Date          : 09/09/2020
Revision      : 1.0
Description   : A script to be ran in a layout or schematic window, which will
                open a form with a set list of pcells from the S130 library.  It
                will then fill out the form with set parameters from the cells
                that can be varied.  It will then place all instances in the
                current window (after deleting everything in it) with iterations
                of all enabled parameters based on values entered.
Lint Score    : 
Procedures    : S130QA_PcellPlacementForm
                S130QAplacer_main
                S130QAplacer_updateForm
                S130QAplacer_createParamFields
                S130QAplacer_createMatrix
                S130QAplacer_calculatePlacements
                toggle_callback
                S130QAplacer_getCdfParams
                S130QAplacer_getParameterValues
                S130QAplacer_createLayPins
                S130QAplacer_wireUpInst
                S130QAplacer_mergeBBoxes
                S130QAplacer_help

Env Vars used : PDK_HOME (for updating callback script)

================================================================================
Modification history :


==============================================================================*/

unless( fboundp('CCSinvokeInstCdfCallbacks)
  loadi( strcat( getShellEnvVar("PDK_HOME") "/PROGS/SKILL/menu_tools/CCSinvokeCdfCallbacks.il"))
)

;----------------------------------------------------------------------
; Create main form
;----------------------------------------------------------------------
procedure( S130QA_PcellPlacementForm(@optional (winId getCurrentWindow()))
  let( (cellId formWidth paramFieldCoords cellList drcList lvsList
        info1 info2 info3 info4 info5 info6 libName testCellName
        verifType numPlacements spacing columns adjColumns baseFields
        S130QAplacer_form )

    cellId = geGetEditCellView(winId)

    ; set up the form coordinates for the params so they always line up
    ; first item is the starting Y coord, the following are the X coord
    ; for the 5 possible fields that will be on the form (x:width)
    ;--------------------------------------------------
    formWidth = 650
    ;paramFieldCoords = list( startY Iterate+Name Min Max Steps Choices)
    paramFieldCoords =  list( 145 10:220 230:100 340:100 450:100 230:370)

    ; Gather list of cells with layouts that have parameters to test
    ;--------------------------------------------------
    ; takes too long so just hard coding the cells
    ;layCells = setof( cell ddGetObj(libName)->cells (member("layout" cell~>views~>name) &&
    ;  cdfGetBaseCellCDF(cell)~>parameters && !rexMatchp("^[np][np][np]" cell->name)))~>name
    ;layCells = sort( layCells nil )
    drcList = list("cm3m4" "cm4m5" "dnsd_pw" "dnsd_pw_esd" "dnsd_pw_esd_v5"
      "dnsd_pw_lvt" "dnsd_pw_nat" "dnsd_pw_v5" "dpsd_nw" "dpsd_nw_esd" "dpsd_nw_esd_v5"
      "dpsd_nw_hvt" "dpsd_nw_lvt" "dpsd_nw_v5" "nmos" "nmos_de_v12" "nmos_esd_nat_v5"
      "nmos_esd_v5" "nmos_lvt" "nmos_nat_v3" "nmos_nat_v5" "nmos_v5" "pad_bond"
      "pad_microprobe" "pad_probe" "pmos" "pmos_de_v12" "pmos_esd_v5" "pmos_hvt" "pmos_lvt"
      "pmos_v5" "rndiff" "rndiff_v5" "rpdiff" "rpdiff_v5" "rpoly" "rpoly_hp" "rpoly_hp2K"
      "rpwell" "sealring")
    lvsList = list("cm3m4" "cm4m5" "dnsd_pw" "dnsd_pw_esd" "dnsd_pw_esd_v5"
      "dnsd_pw_lvt" "dnsd_pw_nat" "dnsd_pw_v5" "dpsd_nw" "dpsd_nw_esd" "dpsd_nw_esd_v5"
      "dpsd_nw_hvt" "dpsd_nw_lvt" "dpsd_nw_v5" "nmos" "nmos_de_v12" "nmos_esd_nat_v5"
      "nmos_esd_v5" "nmos_lvt" "nmos_nat_v3" "nmos_nat_v5" "nmos_v5" "pad_bond"
      "pad_microprobe" "pad_probe" "pmos" "pmos_de_v12" "pmos_esd_v5" "pmos_hvt" "pmos_lvt"
      "pmos_v5" "rndiff" "rndiff_v5" "rpdiff" "rpdiff_v5" "rpoly" "rpoly_hp" "rpoly_hp2K"
      "rpwell")
    cond( 
      ( cellId->cellViewType == "maskLayout"
        cellList = drcList
      )
      ( cellId->cellViewType == "schematic"
        cellList = lvsList
      )
      ( t
        cellList = list()
        error("The view you have open/focused is neither a schematic or layout")
      )
    ); cond

    info1 = hiCreateLabel( 
      ?name 'info1 
      ?justification  'center
      ?labelText "<div style='text-decoration: font-weight:bold;'>*** Library S130 Pcell testing ONLY. ***</div>"
    )
    info2 = hiCreateLabel( 
      ?name 'info2
      ?justification  'center
      ?labelText "<div style='color: #ff0000;'>*** ANY OBJECTS IN THE CURRENT VIEW WILL BE DELETED! ***</div>"
    )
    info3 = hiCreateLabel( 
      ?name 'info3 
      ?justification  'center
      ?labelText "To be used within a schematic or layout view. It will place instances of the"
    )
    info4 = hiCreateLabel( 
      ?name 'info4
      ?justification  'center
      ?labelText "chosen Pcell with a number of iterations based on the parameters you desire to vary."
    )
    info5 = hiCreateLabel( 
      ?name 'info5
      ?justification  'center
      ?labelText "<div style='color: #0000ff;'>Only Pcells with editable parameters that can be varied are available.</dif>"
    )
    info6 = hiCreateLabel( 
      ?name 'info6
      ?justification  'center
      ?labelText "<div style='text-decoration: font-weight:bold;color: #ff0000;'>*** Number of Placements > 5k may cause low memory/session crash or take forever ***</div>"
    )
    libName = hiCreateStringField(
      ?name       'libName
      ?prompt     "Library:"
      ?defValue   "S130"
      ?enabled    nil
      ?invisible  t
    )
    testCellName = hiCreateCyclicField(
      ?name     'testCellName
      ?prompt   "Test Pcell:"
      ?choices  cellList
      ?callback "{
                  S130QAplacer_updateForm( hiGetCurrentForm() paramFieldCoords )
                  S130QAplacer_calculatePlacements( hiGetCurrentForm() )
                }"
    )
    verifType = hiCreateRadioField(
      ?name     'verifType
      ?prompt   "For:"
      ?choices  list("DRC" "LVS")
      ?callback list( "hiGetCurrentForm()->cellList->choices = drcList"
                      "hiGetCurrentForm()->cellList->choices = lvsList" )
      ?invisible t
    )
    numPlacements = hiCreateIntField(
      ?name     'numPlacements
      ?prompt   "Number of Placements:"
      ?defValue 0
      ?editable nil
      ?callback "{unless( hiGetCurrentForm()->adjColumns->value
                  hiGetCurrentForm()->columns->value = ceiling( sqrt( hiGetCurrentForm()->numPlacements->value )) 
                )}"
    )
    spacing = hiCreateFloatField(
      ?name     'spacing
      ?prompt   "Spacing:"
      ?defValue if( cellId->cellViewType == "maskLayout" then 10.0 else 1.0)
      ?callback "{
                  S130Round(hiGetCurrentForm()->spacing->value 0.005)
                  unless( plusp(hiGetCurrentForm()->spacing->value)
                    warn(\"Placement spacing should be a positive value - setting to default value\")
                    hiGetCurrentForm()->spacing->value = hiGetCurrentForm()->spacing->defValue
                  )
                }"
    )
    columns = hiCreateIntField(
      ?name     'columns
      ?prompt   "Columns:"
      ?defValue 10
      ?editable nil
      ?callback "{
                  when( hiGetCurrentForm()->numPlacements->value > 0
                    unless( plusp(hiGetCurrentForm()->columns->value)
                      warn(\"Columns should be a positive value - setting to default value\")
                      hiGetCurrentForm()->columns->value = hiGetCurrentForm()->columns->defValue
                    )
                  )
                }"
    )
    adjColumns = hiCreateBooleanButton(
      ?name        'adjColumns
      ?buttonText  "Adjust # of columns"
      ?buttonLocation 'left
      ?defValue    nil
      ?callback "{
                  if( hiGetCurrentForm()->adjColumns->value then
                    hiGetCurrentForm()->columns->editable = t
                  else
                    hiGetCurrentForm()->columns->editable = nil
                    hiGetCurrentForm()->columns->value = ceiling( sqrt( hiGetCurrentForm()->numPlacements->value )) 
                  )
                }"
    )
    baseFields = list(
      list( info1           0:  5  formWidth:20 )
      list( info2           0: 20  formWidth:20 )
      list( info3           0: 35  formWidth:20 )
      list( info4           0: 50  formWidth:20 )
      list( info5           0: 70  formWidth:20 )
      list( info6           0: 90  formWidth:20 )
      list( libName         5:115  200: 30  50 )
      list( testCellName    5:115  200: 30  80 )
      list( verifType     265:115  200: 30  40 )
      list( numPlacements   5:145  210: 30 140 )
      list( spacing       225:145  100: 30  55 )
      list( columns       335:145  100: 30  55 )
      list( adjColumns    445:145   80: 30   0 )
    )

    ; Create main form
    ; ++++++++++++++++++++++++++++++++++++++++++++++++++
    S130QAplacer_form = hiCreateAppForm(
      ?name       'S130QAplacer_form
		  ?formTitle  "S130 QA: Pcell Placement Tool"
      ?fields     baseFields
      ?callback   "{
        S130QAplacer_main( hiGetCurrentForm()->libName->value hiGetCurrentForm()->testCellName->value
          S130QAplacer_getCdfParams( hiGetCurrentForm()->libName->value hiGetCurrentForm()->testCellName->value )
          hiGetCurrentForm()->columns->value hiGetCurrentForm()->spacing->value
          S130QAplacer_getParameterValues( hiGetCurrentForm() ) winId cellId )
        }"
      ?initialSize list( formWidth 900 )
      ?buttonLayout 'OKCancelApply
      ?help ""
    )

    ;help
    putprop( 'S130QAplacer_form "S130QAplacer_help()" 'hiHelpAction)

    S130QAplacer_updateForm( S130QAplacer_form paramFieldCoords )

    hiDisplayForm( S130QAplacer_form 50:100 )

  ); let
); procedure S130QA_PcellPlacementForm

; procedure S130QAplacer_main
;-----------------------------
procedure( S130QAplacer_main( libName testCellName cellAllParams cols cellSpacing formParams
           winId cellId )
  prog( ( cellX cellY col testCellId grid iKey inst iterRange iterStep iterSteps
        iterations labelH labelX labelY maxIter minIter paramList paramName rowId
        paramType paramIterValues placementGrid row cellLib cellName viewName viewType 
        rows iter stopTheMadness instances iterations iteration markers progBox )

    ; to help with memory issues
    ;sstatus(debugMode nil)
    ;sstatus(optimizeTailCall t)
    envSetVal("layout" "startLevel" 'int 0)
    envSetVal("layout" "stopLevel" 'int 0)
    gc()

    cellLib  = cellId->libName
    cellName = cellId->cellName
    viewName = cellId->viewName
    viewType = cellId->cellViewType

    when( viewType == "maskLayout"
      ; make sure things are on for us to grab/use
      leSetInstSelectable( t )
      leSetLayerValid(list("pwell" "pin") t)
      leSetLayerValid(list("pwell" "label") t)
      leSetLayerValid(list("nwell" "pin") t)
      leSetLayerValid(list("nwell" "label") t)
      leSetLayerValid(list("areaid" "substrateCut") t)
      leSetAllLayerVisible(t)
      leSetAllLayerSelectable(t)
    ); when

    ; delete anything in the cell for a clean slate
    dbReopen(cellId "w")

    grid = techGetMfgGridResolution(techGetTechFile(ddGetObj(libName)))

    ; testing
    

    ; get the master cellview and set variables for specific views
    ;-----------------------------
    case( cellId->cellViewType
      ("schematic"
        testCellId = dbOpenCellViewByType( ddGetObj(libName) testCellName "symbol" "" "r")
        placementGrid = 0.0625
        labelX = 2.0
        labelY = -1.0
        labelH = 0.25
      )
      ("maskLayout"
        testCellId = dbOpenCellViewByType( ddGetObj(libName) testCellName "layout" "" "r")
        placementGrid = 0.005
        labelX = 5.0
        labelY = -10.0
        labelH = 2.0
      )
    )

    printf("--- Start %s\n" getCurrentTime() )

    ; figure out steps for each parameter
    ;-----------------------------
    paramIterValues = makeTable('paramValuesTable)

    printf("Creating value(s) list for each parameters...\n" )
    foreach( test formParams
      paramName = nth(0 test)
      when( cellAllParams[paramName]
        case( nth(0 cellAllParams[paramName])
          ("float" 
            minIter = nth(2 test)
            maxIter = nth(3 test)
            iterSteps = if( nth(4 test)-2 > 0 then nth(4 test)-2 else 0 )
            iterRange = maxIter - minIter
            iterStep = round( (iterRange/(iterSteps+1))/grid )*grid
            paramIterValues[paramName] = list( minIter )
            when( iterSteps > 0
              for( i 1 iterSteps
                paramIterValues[paramName] = cons( minIter + i*iterStep paramIterValues[paramName] )
                i = i+1
              ); for i
            ); when iterSteps > 0
            paramIterValues[paramName] = cons( maxIter paramIterValues[paramName] )
            paramIterValues[paramName] = reverse(paramIterValues[paramName])
          )
          ("int"
            minIter = nth(2 test)
            maxIter = nth(3 test)
            iterSteps = if( nth(4 test)-2 > 0 then nth(4 test)-2 else 0 )
            iterRange = maxIter - minIter
            iterStep = int(iterRange/(iterSteps+1))
            paramIterValues[paramName] = list( minIter )
            when( iterSteps > 0
              for( i 1 iterSteps
                paramIterValues[paramName] = cons( minIter + i*iterStep paramIterValues[paramName] )
                i = i+1
              ); for i
            ); when iterSteps > 0
            paramIterValues[paramName] = cons( maxIter paramIterValues[paramName] )
            paramIterValues[paramName] = reverse(paramIterValues[paramName])
          )
          ("string" 
            minIter = evalstring(nth(2 test))
            maxIter = evalstring(nth(3 test))
            iterSteps = if( nth(4 test)-2 > 0 then nth(4 test)-2 else 0 )
            iterRange = maxIter - minIter
            iterStep = round( (iterRange/(iterSteps+1))/grid )*grid
            paramIterValues[paramName] = list( sprintf(nil "%L" minIter) )
            when( iterSteps > 0
              for( i 1 iterSteps
                paramIterValues[paramName] = cons( sprintf(nil "%L" minIter + i*iterStep) paramIterValues[paramName] )
                i = i+1
              ); for i
            ); when iterSteps > 0
            paramIterValues[paramName] = cons( sprintf(nil "%L" maxIter) paramIterValues[paramName] )
            paramIterValues[paramName] = reverse(paramIterValues[paramName])
          )
          ("boolean"
            paramIterValues[paramName] = list( "TRUE" "FALSE" )
          )
          ("cyclic"
            paramIterValues[paramName] = cddr(test)
          )
        )
      ); when
    ); foreach

    ; create the labels that show what params were used &&
    ; build the list of iterations
    ;-----------------------------
    dbCreateLabel( cellId list("text" "drawing") labelX:labelY "Parameters (name type [min max #steps || choices]):" "upperLeft" "R0" "stick" labelH)
    iterations = ncons(nil)
    printf("Creating matrix of parameters (speed based on number of iterations)...\n")
    foreach(param formParams
      iKey = car(param)
      labelY = labelY - 1.5*labelH
      dbCreateLabel( cellId list("text" "drawing") labelX:labelY sprintf(nil "  %L" param) "upperLeft" "R0" "stick" labelH)
      when( paramIterValues[iKey]
        printf("\tadding %L to the matrix...\n" iKey)
        iterations = S130QAplacer_createMatrix( iterations paramIterValues[iKey] )
      ); when param exists
    ); foreach param
    dbCreateLabel( cellId list("text" "drawing") labelX:labelY-1.5*labelH sprintf(nil "Number of placements: %d" length(iterations)) "upperLeft" "R0" "stick" labelH)

    ; Memory management
    ; turn the iterations into an array as they are much faster than lists
    iterations = listToVector(iterations)
    ; reallocate a variable and remove the big list from memory
    paramIterValues = length(iterations)

    col = row = 1
    cellX = cellY = 0.0

    ; create row cells to keep memory use down
    when( viewType == "maskLayout"
      printf("Deleting previously built row cells...\n")
      foreach( rowCell setof( view ddGetObj(cellLib cellName)->views
        rexMatchp("layout_row" view->name)) ddDeleteObj(rowCell)
      ); foreach row cell 
      rowId = dbOpenCellViewByType(cellLib cellName sprintf(nil "zzz_%s_row%d" viewName row) viewType "w")
    ); when layout

    ; place each iteration of the device - the memory hog
    ;-----------------------------
    printf("Placing cell %L with %d parameter iterations in %L...\n" testCellName paramIterValues cellId->cellName )

    stopTheMadness = nil
    rows = paramIterValues/cols
    when( mod(paramIterValues cols) > 0 rows = rows + 1 )

    hiDisplayProgressBox(
      ?name 'progBox
      ?banner "Pcell Placer Progress"
      ?text   sprintf(nil "Placing row %d of %d" row rows ) 
      ?callback "stopTheMadness = t"
      ?totalSteps rows
      ?autoClose nil
    )
    hiSetProgressButtonText(progBox "STOP!")

    iter = 0
    while( iter < paramIterValues

      ; memory free up ??
      foreach( bag dbGetOpenBags() dbPurgeBag(bag) )

      ; kill switch
      if( stopTheMadness then
        dbSave(rowId)
        iter = paramIterValues
      else

        ; set progress bar
        hiSetProgressAndText(progBox row sprintf(nil "Placing row %d of %d" row rows ) )

        iteration = iterations[iter]
        ; make a paramlist for the instance placed
        paramList = list()
        for( i 0 length(iteration)-1
          paramName = car(nth(i formParams))
          paramType = nth(0 cellAllParams[paramName])
          when( paramType == "cyclic" paramType = "string" )
          paramList = cons( list( paramName paramType nth(i iteration)) paramList )
          i = i+1
        ); for iteration
        paramList = reverse(paramList)

        ; need to set the calc methods for various cells so it only uses w/l
        cond(
          ; fixed sized mosfets
          ( rexMatchp("^[np]mos" testCellName) &&
            !(rexMatchp("mos_esd" testCellName) || rexMatchp("v20" testCellName)) 
            paramList = cons( list("useFixedWL" "boolean" nil) paramList )
          )
          ; mimcaps
          ( member(testCellName list("cm3m4" "cm4m5"))
            paramList = cons( list("calcMethod" "string" "Width & Length") paramList )
          )
          ; diff diodes
          ( rexMatchp("^d[np]sd" testCellName)
            paramList = cons( list("calcMethod" "string" "Width & Length") paramList )
          )
          ; pwell resistor
          ( testCellName == "rpwell"
            paramList = cons( list("rCalcMethod" "string" "Length") paramList )
          )
          ; poly & diff resistors
          ( testCellName == "rpoly" || rexMatchp("^rpoly_hp" testCellName) || rexMatchp("^r[np]diff" testCellName)
            paramList = cons( list("rCalcMethod" "string" "Segment Length") paramList )
          )
        ); cond

        dbSave(cellId)

        ; test
        ;printf("%L\n" paramList)
        ;printf("%s %L\n" testCellId->cellName paramList)

        if( viewType == "maskLayout" then
          inst = dbCreateExtParamInst( rowId testCellId sprintf(nil "I%d" iter) cellX:0 "R0" 1 paramList t)
          CCSinvokeInstCdfCallbacks(inst)
          ; create pins and labels
          S130QAplacer_createLayPins( rowId inst ?prefix inst->name )
          ; create a substrate iso rect over the inst for LVS
          dbCreateRect( rowId list("areaid" "substrateCut") 
            list( leftEdge(inst->bBox)-0.01:bottomEdge(inst->bBox)-0.01
            rightEdge(inst->bBox)+0.01:topEdge(inst->bBox)+0.01 ) )
          dbPurge(testCellId)
          testCellId = dbOpenCellViewByType( ddGetObj(libName) testCellName "layout" "" "r")
        else
          inst = dbCreateExtParamInst( cellId testCellId sprintf(nil "I%d" iter) cellX:cellY "R0" 1 paramList t)
          CCSinvokeInstCdfCallbacks(inst)
          S130QAplacer_wireUpInst( cellId inst )
          dbPurge(testCellId)
          testCellId = dbOpenCellViewByType( ddGetObj(libName) testCellName "symbol" "" "r")
        ); if view layout

        ; get new coords
        if( col < cols && iter != paramIterValues-1 then
          cellX = ceiling(xCoord(upperRight(inst->bBox))/placementGrid)*placementGrid + cellSpacing
          cellY = cellY
          col = col + 1
        else
          printf("...done with row %d of %d rows\n" row rows )
          if( viewType == "maskLayout" then
            dbSave(rowId)
            dbCreateInst( cellId rowId sprintf(nil "Irow%d" row) 0:cellY "R0" 1 )
            cellY = cellY + ceiling((yCoord(upperRight(rowId->bBox)) - yCoord(lowerLeft(rowId->bBox)))/
              placementGrid)*placementGrid + cellSpacing
            dbPurge(rowId)
            ; clean up the garbage
            gc()
            foreach( cv setof( dbs dbGetOpenCellViews()
              (dbs->cellName == cellName && dbs->viewName != viewName))
              dbPurge(cv)
            )
          else
            cellY = cellY + ceiling((yCoord(upperRight(inst->bBox)) - yCoord(lowerLeft(inst->bBox)))/
              placementGrid)*placementGrid + cellSpacing
          )
          dbSave(cellId)
          cellX = 0.0
          col = 1
          row = row + 1
          ; create the next row cell
          when( viewType == "maskLayout" && iter < paramIterValues-1
            rowId = dbOpenCellViewByType(cellLib cellName sprintf(nil "zzz_%s_row%d" viewName row) viewType "w")
          ); when layout
        ); if col < cols

        iter = iter + 1
      ); if stopTheMadness
    ); while iter

    hiCancelProgressBox( progBox )

    ; for memory reasons, even though local
    unbindVar(iterations)
    unbindVar(instances)

    case( viewType
      ( "maskLayout" 
        ; create the pins and labels for the row cells
        printf("Creating top level pins and labels...\n")
        foreach( inst cellId->instances
          S130QAplacer_createLayPins( cellId inst )
        ); foreach inst
      ); layout
      ( "schematic" 
        ; Run schematic check and Save
        printf("Check & Saving %s...\n" cellName)
        when(and( !dbIsConnCurrent(cellId) schCheck(cellId) )
          if(dbGetDatabaseType()=="CDBA" then
            markers = setof(lpp cellId~>lpps and(lpp~>layerName=="marker"
              member(lpp~>purpose '("error" "warning"))))
            foreach(type markers
              foreach(shape type~>shapes dbDeleteObject(shape))
            )
            t
          else
            markers = setof(marker cellId~>markers
              member(marker~>severity list("error" "warning")))
            foreach(type markers dbDeleteObject(type))
          t
          ); if CDBA
        ); when not current and schCheck
      ); schematic
    ); case

    dbSave(cellId)
    printf("Placement complete.\n")
    printf("--- Finish %s\n" getCurrentTime() )

    if( windowp(winId) then
      hiRaiseWindow(winId)
      hiZoomAbsoluteScale(winId 0.9)
    else
      hiRaiseWindow(hiGetCurrentWindow())
      hiZoomAbsoluteScale(hiGetCurrentWindow() 0.9)
    ); if winId

  ); prog
); procedure S130QAplacer_main

; procedure S130QAplacer_updateForm
;-----------------------------
procedure( S130QAplacer_updateForm( QAform paramFieldCoords )
  let( (libName testCellName cellAllParams paramList paramFields )

    libName  = QAform->libName->value
    testCellName = QAform->testCellName->value

    ; get param cdf info
    cellAllParams = S130QAplacer_getCdfParams( libName testCellName )

    ; remove existing param# fields from the form
    hiDeleteFields( QAform setof( pfield QAform->fieldList rexMatchp("^param[0-9]" sprintf(nil "%L" pfield))) )

    ; paramList is a list of lists with param, min, & max, or param, choices
    ; if the list has 3 length - float, 2 length - cyclic, 1 length - boolean
    cond(
      ; 12V de fet devices
      ( testCellName == "pmos_de_v12"
        paramList = list(
          list("l" evalstring(strcat(testCellName "->minL")) evalstring(strcat(testCellName "->maxL")))
          list("nf" 2 20)
          list("gateCnt" nth(2 cellAllParams["gateCnt"]))
          list("gateCntExt" 0.0 10.0)
          list("tapLeft")
          list("tapRight")
          list("tapTop")
          list("tapBottom")
        )
      )
      ( testCellName == "nmos_de_v12"
        paramList = list(
          list("fw" evalstring(strcat(testCellName "->minW")) evalstring(strcat(testCellName "->maxW")))
          list("l" evalstring(strcat(testCellName "->minL")) evalstring(strcat(testCellName "->maxL")))
          list("nf" 2 20)
          list("gateCnt" nth(2 cellAllParams["gateCnt"]))
          list("gateCntExt" 0.0 10.0)
          list("tapLeft")
          list("tapRight")
          list("tapTop")
          list("tapBottom")
        )
      )
      ; standard fets
      ( rexMatchp("^[np]mos" testCellName) && !rexMatchp("^[np]mos_de" testCellName)
        paramList = list(
          list("fw" evalstring(strcat(testCellName "->minW")) evalstring(strcat(testCellName "->maxW")))
          list("l" evalstring(strcat(testCellName "->minL")) evalstring(strcat(testCellName "->maxL")))
          list("nf" 1 100)
          list("fingerSP" evalstring(strcat(testCellName "->minFingerSP")) evalstring(strcat(testCellName "->maxFingerSP")))
          list("gateCnt" nth(2 cellAllParams["gateCnt"]))
          list("gateCntExt" 0.0 10.0)
          list("tapLeft")
          list("tapRight")
          list("tapTop")
          list("tapBottom")
        )
      )
      ; mimcaps
      ( member(testCellName list("cm3m4" "cm4m5"))
        paramList = list(
          list("w" evalstring(strcat(testCellName "->minW")) evalstring(strcat(testCellName "->maxW")))
          list("l" evalstring(strcat(testCellName "->minL")) evalstring(strcat(testCellName "->maxL")))
        )
      )
      ; diff diodes
      ( rexMatchp("^d[np]sd" testCellName)
        paramList = list(
          list("w" evalstring(strcat(testCellName "->minW")) evalstring(strcat(testCellName "->maxW")))
          list("l" evalstring(strcat(testCellName "->minL")) evalstring(strcat(testCellName "->maxL")))
          list("dioCont")
          list("tapLeft")
          list("tapRight")
          list("tapTop")
          list("tapBottom")
        )
      )
      ; poly resistor
      ( testCellName == "rpoly"
        paramList = list(
          list("rType" nth(2 cellAllParams["rType"]))
          list("segL" evalstring(strcat(testCellName "->minL")) evalstring(strcat(testCellName "->maxL")))
          list("segW" evalstring(strcat(testCellName "->minW")) evalstring(strcat(testCellName "->maxW")))
          list("segments" 1 50)
          list("segmentSP" evalstring(strcat(testCellName "->resLay->minSP")) 50.0)
          list("contRows" 1 10)
          list("metCont")
        )
      )
      ; poly hp resistors
      ; hard coded values - early pcell
      ( rexMatchp("^rpoly_hp" testCellName)
        paramList = list(
          list("rType" nth(2 cellAllParams["rType"]))
          list("segL" 5.0 evalstring(strcat(testCellName "->maxL")) )
          list("segW" 0.33 100)
          list("segments" 1 50)
          list("segmentSP" 0.21 2.0)
          list("contRows" 1 5)
          list("metCont")
          list("wellType" nth(2 cellAllParams["wellType"]))
          list("vType" nth(2 cellAllParams["vType"]))
          list("tapLeft")
          list("tapRight")
          list("tapTop")
          list("tapBottom")
        )
      )
      ; diff resistors
      ( rexMatchp("^r[np]diff" testCellName)
        paramList = list(
          list("rType" nth(2 cellAllParams["rType"]))
          list("segL" evalstring(strcat(testCellName "->minL")) evalstring(strcat(testCellName "->maxL")))
          list("segW" evalstring(strcat(testCellName "->minW")) evalstring(strcat(testCellName "->maxW")))
          list("segments" 1 50)
          list("segmentSP" evalstring(strcat(testCellName "->minSegSP")) evalstring(strcat(testCellName "->maxSegSP")) )
          list("contRows" 1 10)
          list("metCont")
          list("tapLeft")
          list("tapRight")
          list("tapTop")
          list("tapBottom")
        )
      )
      ; pwell resistor
      ( testCellName == "rpwell"
        paramList = list(
          ;list("w" evalstring(strcat(testCellName "->rules->minW")) evalstring(strcat(testCellName "->rules->maxW")))
          list("l" evalstring(strcat(testCellName "->rules->minL")) evalstring(strcat(testCellName "->rules->maxL")))
          list("nwTapCnt" nth(2 cellAllParams["nwTapCnt"]))
        )
      )
      ; sealring
      ( testCellName == "sealring"
        paramList = list(
          list("w" evalstring(strcat(testCellName "->minW")) evalstring(strcat(testCellName "->maxW")))
          list("l" evalstring(strcat(testCellName "->minW")) evalstring(strcat(testCellName "->maxW")))
          list("extraCut" 0.0 S130Round(evalstring(strcat(testCellName "->minW"))*0.25 0.005))
        )
      )
      ; pads
      ( testCellName == "pad_bond" || testCellName == "pad_microprobe"
        paramList = list(
          list("w" evalstring(strcat(testCellName "->minW")) evalstring(strcat(testCellName "->maxW")))
          list("l" evalstring(strcat(testCellName "->minW")) evalstring(strcat(testCellName "->maxW")))
        )
      )
      ( testCellName == "pad_probe"
        paramList = list(
          list("padSize" nth(2 cellAllParams["padSize"]))
        )
      )
    ); cond

    paramFields = S130QAplacer_createParamFields( paramList paramFieldCoords cellAllParams )

    hiAddFields( QAform paramFields )
    foreach( paramPrompt setof( pfield QAform->fieldList rexMatchp("^param[0-9]+Prompt" sprintf(nil "%L" pfield)))
      evalstring(strcat("QAform->" paramPrompt "->hiToolTip = \"Click to enable the iteration of this parameter\""))
    ); foreach paramPrompt
    ; set the first choice to be enabled and the tool tip for cyclic choices
    foreach( paramCyclic setof( pfield QAform->fieldList rexMatchp("^param[0-9]+Cyclic" sprintf(nil "%L" pfield)))
      evalstring(strcat("QAform->" paramCyclic "->"
        symbolToString(evalstring(strcat("car(QAform->" paramCyclic "->_toggleItems)")))
        "->value = t"))
      evalstring(strcat("QAform->" paramCyclic "->hiToolTip = \"Enable any that you want to apply\""))
    ); foreach paramCyclic

  ); let
); procedure S130QAplacer_updateForm

; procedure S130QAplacer_createParamFields
;-----------------------------
procedure( S130QAplacer_createParamFields( paramList paramFieldCoords cellAllParams )
  let( (paramNum paramFields yCoord promptX promptW minX minW
        maxX maxW stepX stepW cyclicX cyclicW paramPrompt
        paramName paramType paramCyclic paramMin paramMax paramSteps)

    paramNum = 1
    paramFields = list()
    yCoord = nth(0 paramFieldCoords)
    promptX = xCoord(nth(1 paramFieldCoords))
    promptW = yCoord(nth(1 paramFieldCoords))
    minX    = xCoord(nth(2 paramFieldCoords))
    minW    = yCoord(nth(2 paramFieldCoords))
    maxX    = xCoord(nth(3 paramFieldCoords))
    maxW    = yCoord(nth(3 paramFieldCoords))
    stepX   = xCoord(nth(4 paramFieldCoords))
    stepW   = yCoord(nth(4 paramFieldCoords))
    cyclicX = xCoord(nth(5 paramFieldCoords))
    cyclicW = yCoord(nth(5 paramFieldCoords))

    foreach( param paramList

      ; create the param enable boolean
      paramPrompt = hiCreateBooleanButton(
        ?name        stringToSymbol(sprintf(nil "param%dPrompt" paramNum))
        ?buttonText  nth(1 cellAllParams[nth(0 param)]) 
        ?buttonLocation 'left
        ?defValue    nil
        ?callback    "S130QAplacer_calculatePlacements( hiGetCurrentForm() )"
      )
      paramFields = append1( paramFields list(paramPrompt promptX:yCoord+paramNum*30 promptW:30 20) )
      ; create invisible field for the parameter name
      paramName =   hiCreateStringField(
        ?name       stringToSymbol(sprintf(nil "param%dName" paramNum))
        ?prompt     sprintf(nil "param%dName" paramNum)
        ?defValue   nth(0 param) 
        ?invisible  t
      )
      paramFields = append1( paramFields list(paramName promptX:yCoord+paramNum*30 promptW:30 20) )

      case( length(param)
        (1
          paramType =   hiCreateStringField(
            ?name       stringToSymbol(sprintf(nil "param%dType" paramNum))
            ?prompt     sprintf(nil "param%dType" paramNum)
            ?value      "boolean" 
            ?invisible  t
          )
          paramFields = append1( paramFields list(paramType promptX:yCoord+paramNum*30 promptW:30 20) )
        )
        (2
          paramType =   hiCreateStringField(
            ?name       stringToSymbol(sprintf(nil "param%dType" paramNum))
            ?prompt     sprintf(nil "param%dType" paramNum)
            ?value      "cyclic" 
            ?invisible  t
          )
          paramFields = append1( paramFields list(paramType promptX:yCoord+paramNum*30 promptW:30 20) )
          paramCyclic = hiCreateToggleField(
            ?name      stringToSymbol(sprintf(nil "param%dCyclic" paramNum))
            ;?choices   mapcar( 'ncons mapcar( 'stringToSymbol nth(2 cellAllParams[nth(0 param)])))
            ?choices   nth(2 cellAllParams[nth(0 param)])
            ?callback  list((getd 'toggle_callback))
          )
          paramFields = append1( paramFields list(paramCyclic cyclicX:yCoord+paramNum*30 cyclicW:30 0) )
        )
        (3
          case( nth(0 cellAllParams[nth(0 param)]) 
            ("float"
              paramType =   hiCreateStringField(
                ?name       stringToSymbol(sprintf(nil "param%dType" paramNum))
                ?prompt     sprintf(nil "param%dType" paramNum)
                ?value      "float" 
                ?invisible  t
              )
              paramFields = append1( paramFields list(paramType promptX:yCoord+paramNum*30 promptW:30 20) )
              paramMin = hiCreateFloatField(
                ?name     stringToSymbol(sprintf(nil "param%dMin" paramNum))
                ?prompt   "Min:"
                ?defValue nth(1 param)
                ?range    nth(1 param):nth(2 param)
              )
              paramMax = hiCreateFloatField(
                ?name     stringToSymbol(sprintf(nil "param%dMax" paramNum))
                ?prompt   "Max:"
                ?defValue nth(2 param)
                ?range    nth(1 param):nth(2 param)
              )
            )
            ("string"
              paramType =   hiCreateStringField(
                ?name       stringToSymbol(sprintf(nil "param%dType" paramNum))
                ?prompt     sprintf(nil "param%dType" paramNum)
                ?value      "string" 
                ?invisible  t
              )
              paramFields = append1( paramFields list(paramType promptX:yCoord+paramNum*30 promptW:30 20) )
              paramMin = hiCreateStringField(
                ?name     stringToSymbol(sprintf(nil "param%dMin" paramNum))
                ?prompt   "Min:"
                ?defValue sprintf(nil "%L" nth(1 param))
              )
              paramMax = hiCreateStringField(
                ?name     stringToSymbol(sprintf(nil "param%dMax" paramNum))
                ?prompt   "Max:"
                ?defValue sprintf(nil "%L" nth(2 param))
              )
            )
            ("int"
              paramType =   hiCreateStringField(
                ?name       stringToSymbol(sprintf(nil "param%dType" paramNum))
                ?prompt     sprintf(nil "param%dType" paramNum)
                ?value      "int" 
                ?invisible  t
              )
              paramFields = append1( paramFields list(paramType promptX:yCoord+paramNum*30 promptW:30 20) )
              paramMin = hiCreateIntField(
                ?name     stringToSymbol(sprintf(nil "param%dMin" paramNum))
                ?prompt   "Min:"
                ?defValue nth(1 param)
                ?range    nth(1 param):nth(2 param)
                ?callback    "S130QAplacer_calculatePlacements( hiGetCurrentForm() )"
              )
              paramMax = hiCreateIntField(
                ?name     stringToSymbol(sprintf(nil "param%dMax" paramNum))
                ?prompt   "Max:"
                ?defValue nth(2 param)
                ?range    nth(1 param):nth(2 param)
                ?callback    "S130QAplacer_calculatePlacements( hiGetCurrentForm() )"
              )
            )
          ); case paramtype
          paramSteps = hiCreateIntField(
            ?name     stringToSymbol(sprintf(nil "param%dSteps" paramNum))
            ?prompt   "Steps:"
            ?defValue 2
            ?range    2:500
            ?callback  "S130QAplacer_calculatePlacements( hiGetCurrentForm() )"
          )
          paramFields = append1( paramFields list(paramMin minX:yCoord+paramNum*30 minW:30 25) )
          paramFields = append1( paramFields list(paramMax maxX:yCoord+paramNum*30 maxW:30 25) )
          paramFields = append1( paramFields list(paramSteps stepX:yCoord+paramNum*30 stepW:30 40) )
        )
      ); case length(param)

      paramNum = paramNum + 1
    ); foreach param
    paramFields

  ); let
); procedure S130QAplacer_createParamFields

; procedure S130QAplacer_createMatrix
;   combines the lists to build all the iterations
;-----------------------------
procedure( S130QAplacer_createMatrix( list1 list2 )
  let( (matrix)
    matrix = list()
    foreach( item1 list1
      foreach( item2 list2
        unless( listp(item1) item1 = list(item1) )
        unless( listp(item2) item2 = list(item2) )
        unless( member(append(item1 item2) matrix)
          matrix = cons( append( item1 item2 ) matrix )
        ); unless
      ); foreach list2
    ); foreach list1
    reverse(matrix)
  ); let
); procedure S130QAplacer_createMatrix

; procedure S130QAplacer_calculatePlacements
;-----------------------------
procedure( S130QAplacer_calculatePlacements( QAform )
  let( (numParams numPlacements temp )
    numParams = length(setof( pfield QAform->fieldList rexMatchp("^param[0-9]+Name" sprintf(nil "%L" pfield))))
    numPlacements = 1
    for( i 1 numParams
      when( evalstring(sprintf(nil "QAform->param%dPrompt->value" i))
        cond(
          ; parameters with steps
          ( evalstring(sprintf(nil "QAform->param%dSteps" i))
            when( "int" == evalstring(sprintf(nil "QAform->param%dType->value" i))
              temp = evalstring(sprintf(nil "QAform->param%dSteps" i))
              when( temp->value > 1 +
                    abs(evalstring(sprintf(nil "QAform->param%dMax->value" i)) -
                    evalstring(sprintf(nil "QAform->param%dMin->value" i)))
                warn(strcat(
                  "The steps for integer type params need to be no more\n"
                  "than the difference between the min and max values."))
                printf("Changing step value for %s\n"
                  evalstring(sprintf(nil "QAform->param%dPrompt->prompt" i)))
                temp->value = 1 +
                    abs(evalstring(sprintf(nil "QAform->param%dMax->value" i)) -
                    evalstring(sprintf(nil "QAform->param%dMin->value" i)))
              ); when
            ); when integer param
            numPlacements = numPlacements * evalstring(sprintf(nil "QAform->param%dSteps->value" i))
          )
          ; cyclic parameters
          ( evalstring(sprintf(nil "QAform->param%dCyclic" i))
            numPlacements = numPlacements *
              length( setof( temp evalstring(sprintf(nil "hiGetCurrentForm()->param%dCyclic->value" i )) temp == t ))
          )
          ; boolean parameters
          ( t
            numPlacements = numPlacements * 2
          )
        ); cond
      ); when param is enabled
    ); for
    when( numPlacements == 1 numPlacements = 0 )
    QAform->numPlacements->value = numPlacements

  ); let
); procedure S130QAplacer_calculatePlacements

defun( toggle_callback (field scope item value "ogsg")
  S130QAplacer_calculatePlacements( hiGetCurrentForm() )
)

; procedure S130QAplacer_getCdfParams
;-----------------------------
procedure( S130QAplacer_getCdfParams( libName cellName )
  let( (cellAllParams choices tchoice paramType)
    cellAllParams = makeTable('allParamTable)
    foreach( param cdfGetBaseCellCDF(ddGetObj( libName cellName ))~>parameters
      ; need to fix any choices due to those that start with a number break toggle fields
      choices = list()
      foreach( choice param->choices
        tchoice = choice
        ; find any '.' as they mess up toggles too - change them to 'p'
        rexCompile("\\.")
        when( rexExecute(choice) tchoice = rexReplace(choice "p" 0) )
        choices = append1(choices list( concat("toggle" tchoice) choice ))
      ); foreach choice

      ; remove any leading or trailing spaces from the prompt
      rexCompile("^ *\\(.*[^ ]\\) *$")
      rexExecute(param->prompt)

      ; change radio types to be cyclic for code to handle them properly
      paramType = param->paramType
      when( paramType == "radio" paramType = "cyclic" )

      cellAllParams[param->name] = list( paramType rexSubstitute("\\1") choices )

    ); foreach param
    cellAllParams
  ); let
); procedure S130QAplacer_getCdfParams

; procedure S130QAplacer_getParameterValues
;-----------------------------
procedure( S130QAplacer_getParameterValues( QAform )
  let( (testParamList numParams)
    testParamList = list()
    numParams = length(setof( pfield QAform->fieldList rexMatchp("^param[0-9]+Name" sprintf(nil "%L" pfield))))
    for( i 1 numParams
      let( (param)
        when( evalstring(sprintf(nil "QAform->param%dPrompt->value" i))
          param = list( evalstring(sprintf(nil "QAform->param%dName->value" i))
                        evalstring(sprintf(nil "QAform->param%dType->value" i)) )
          cond(
            ; parameters with steps
            ( evalstring(sprintf(nil "QAform->param%dSteps" i))
              param = append1( param evalstring(sprintf(nil "QAform->param%dMin->value" i)))
              param = append1( param evalstring(sprintf(nil "QAform->param%dMax->value" i)))
              param = append1( param evalstring(sprintf(nil "QAform->param%dSteps->value" i)))
            )
            ; cyclic parameters
            ( evalstring(sprintf(nil "QAform->param%dCyclic" i))
              foreach( cparam evalstring(sprintf(nil "QAform->param%dCyclic->_toggleItems" i))
                when( evalstring(sprintf(nil "QAform->param%dCyclic->%s->value" i symbolToString(cparam)))
                  param = append1( param
                    evalstring(sprintf(nil "QAform->param%dCyclic->%s->prompt" i symbolToString(cparam))) )
                ); when cyclic param is enabled
              ); foreach cparam
            )
          ); cond
          testParamList = append1( testParamList param )
        ); when param is enabled
        i = i + 1
      ); let
    ); for
    testParamList
  ); let
); procedure S130QAplacer_getParameterValues

procedure( S130QAplacer_createLayPins(cv inst @key (prefix nil) (suffix nil))
  let(( newName newNet newTerm newFig newPin labelId )
   
    foreach( terminal inst~>master~>terminals
      newName = terminal->net->name

      when( prefix && stringp(prefix) sprintf(newName "%s_%s" prefix newName) )
      when( suffix && stringp(suffix) sprintf(newName "%s_%s" newName suffix) )

      unless( dbFindNetByName(cv newName) newNet = dbMakeNet(cv newName) )
      unless( dbFindTermByName(cv newName) newTerm = dbCreateTerm(newNet newName
        terminal->direction) )

      foreach( pin terminal~>pins
        newPin = nil
        foreach( fig pin~>figs || list(pin~>fig)
          unless( fig->objType == "path" || fig == nil
            newFig = dbCopyFig(fig cv inst~>transform)
            ;labelId = dbCopyFig(car(fig->children) cv inst~>transform)
            ;labelId->theLabel = newName
            labelId = dbCreateLabel( cv list(car(fig->lpp) "label")
              dbTransformPoint(car(fig->children)->xy inst->transform) newName car(fig->children)->justify
              car(fig->children)->orient "stick" car(fig->children)->height )
            leAttachFig(labelId newFig)
            if( newPin then
              dbAddFigToPin(newPin newFig)
            else
              newPin = dbCreatePin(newNet newFig nil newTerm)
              newPin~>accessDir = pin~>accessDir
            ); if newPin
          ); unless path due to rod paths with pin info on them
        ); foreach fig
      ); foreach pin

    ); foreach terminal
  ); let
); procedure S130QAplacer_createLayPins

procedure( S130QAplacer_wireUpInst( cv inst @key (termL 0.125) )
  prog( (iopin ipin opin numTerms termBbox maxY minY maxX minX top bot rht lft
    direction name point pin orient point2 )
    iopin  = dbOpenCellViewByType( "basic" "iopin" "symbolr" "" "r")
    ipin   = dbOpenCellViewByType( "basic" "ipin" "symbol" "" "r")
    opin   = dbOpenCellViewByType( "basic" "opin" "symbol" "" "r")

    numTerms = length(inst->master->terminals)
    termBbox = dbTransformBBox( car( nth( 0 inst->master->terminals )~>pins)~>fig~>bBox inst->transform )

    for( i 1 numTerms-1
      termBbox = S130QAplacer_mergeBBoxes( termBbox dbTransformBBox(
        car( nth( i inst->master->terminals )~>pins)~>fig~>bBox inst->transform ) )
    )

    maxY = max( yCoord( nth(0 termBbox)) yCoord( nth(1 termBbox) ) )
    minY = min( yCoord( nth(0 termBbox)) yCoord( nth(1 termBbox) ) )
    maxX = max( xCoord( nth(0 termBbox)) xCoord( nth(1 termBbox) ) )
    minX = min( xCoord( nth(0 termBbox)) xCoord( nth(1 termBbox) ) )
    top = maxY-0.05 
    bot = minY+0.05 
    rht = maxX-0.05 
    lft = minX+0.05 

    foreach( term inst->master->terminals
      direction = term->direction
      name = term->name
      point = centerBox( dbTransformBBox( car(term->pins)->fig->bBox inst->transform ) )

      case( direction
        ("inputOutput" pin = iopin )
        ("input"       pin = ipin )
        ("output"      pin = opin )
      ); case direction
      ; test
      ;printf( "%s : %s : %L : %s\n" name direction point pin )

      ; making each pin to be named instName_termName
      name = strcat(inst->name "_" name)

      when( yCoord(point) < bot && xCoord(point) < rht && xCoord(point) > lft
        orient = "R90"
        point2 = list( xCoord(point) yCoord(point) - termL)
        schCreateWire( cv "draw" nil list( point point2 ) 0.0625 0.0625 0 )
        schCreatePin( cv pin name direction nil point2 orient )
      ); when
      when( yCoord(point) > top && xCoord(point) < rht && xCoord(point) > lft
        orient = "R270"
        point2 = list( xCoord(point) yCoord(point) + termL)
        schCreateWire( cv "draw" nil list( point point2 ) 0.0625 0.0625 0 )
        schCreatePin( cv pin name direction nil point2 orient )
      ); when
      when( xCoord(point) < lft
        if( direction == "input" then orient = "R0" else orient = "MY")
        point2 = list( xCoord(point) - termL yCoord(point))
        schCreateWire( cv "draw" nil list( point point2 ) 0.0625 0.0625 0 )
        schCreatePin( cv pin name direction nil point2 orient )
      ); when
      when( xCoord(point) > rht
        if( direction == "output" then orient = "R0" else orient = "MY")
        point2 = list( xCoord(point) + termL yCoord(point))
        schCreateWire( cv "draw" nil list( point point2 ) 0.0625 0.0625 0 )
        schCreatePin( cv pin name direction nil point2 orient )
      ); when
    ); foreach term
  ); prog
); procedure S130QAplacer_wireUpInst

procedure( S130QAplacer_mergeBBoxes(bBox1 bBox2)
  let( (newBbox ll1 ur1 ll2 ur2 llX llY urX urY)
    cond(
      (! isBBox(bBox1) newBbox = bBox2 )
      (! isBBox(bBox2) newBbox = bBox1 )
      (t
        ll1 = car(bBox1)
        ur1 = cadr(bBox1)
        ll2 = car(bBox2)
        ur2 = cadr(bBox2)
        llX = if( car(ll1) >= car(ll2)   then car(ll2) else car(ll1))
        llY = if( cadr(ll1) >= cadr(ll2) then cadr(ll2) else cadr(ll1))
        urX = if( car(ur1) >= car(ur2)   then car(ur1) else car(ur2))
        urY = if( cadr(ur1) >= cadr(ur2) then cadr(ur1) else cadr(ur2))
        newBbox = list(list(llX llY) list(urX urY))
      )
    ); cond
    newBbox
  ); let
); procedure S130QAplacer_mergeBBoxes

; procedure S130QAplacer_help
;-----------------------------
procedure( S130QAplacer_help()

  hiDisplayAppDBox(
    ?name         'formHelp
    ?dboxBanner   "*** S130 QA Tool Help ***" 
    ?dboxText     strcat( 
      "====================================================================================================\n"
      "\n" 
      "CAUTION:  ANYTHING IN THE CELL WHICH THE TOOL WAS OPENED FROM WILL HAVE ALL OF IT'S\n"
      "          CONTENTS DELETED.\n" 
      "          HIGH NUMBER OF PLACEMENTS > 5K CAN TAKE A LONG TIME TO COMPLETE, AND COULD\n"
      "          ALSO CAUSE MEMORY ISSUES, EVEN CRASH YOUR CADENCE SESSION\n"
      "\n" 
      "====================================================================================================\n"
      "\n" 
      "This tool is to be ran in a layout or schematic window, which will open a form with\n"
      "a set list of pcells from the S130 library.  It will then fill out the form with\n"
      "set parameters from the test pcell that can be varied.\n"
      "\n"
      "When \"Ok\" or \"Apply\" is clicked, it will then place all instances\n"
      "in the current window (after deleting everything in it) with iterations of all\n"
      "enabled parameters based on values entered or selected.\n"
      "\n" 
      "----------------------------------------------------------------------------------------------------\n"
      "\n" 
      "Choose which pcell you would like to test from the \"Test Pcell\" pulldown\n"
      "The checkbox to the left of the parameter name enables or disables the use of the\n"
      "parameter to create variants for it.\n"
      "\n"
      "For parameters that values can be entered, there will be a min, max, and step field\n"
      "  to fill in\n"
      "For parameters that choices can be made (pulldowns & radio buttons), all choices will\n"
      "  be avaible to choose; check the box next to those you want to test\n"
      "For boolean parameters, there are no choices other than enabling it, which till toggle\n"
      "  them on and off in the variations\n"
      "\n"
      "====================================================================================================\n"
      "\n"
    )
    ?dialogType   3
    ?dialogStyle  'modeless
    ?buttonLayout 'UserDefined
    ?buttons      list("Thanks!")
  ); end hiDisplayAppDBox

); procedure S130QAplacer_help

/*==================================  EOF  ===================================*/
