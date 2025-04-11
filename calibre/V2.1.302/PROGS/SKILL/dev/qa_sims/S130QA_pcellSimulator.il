/*==============================================================================
Function Name : S130QA_pcellSim()
Title         : S130 QA - Pcell Simulator
Author        : Madek Graham
Date          : 10/30/2020
Revision      : 1.0
Description   : This QA tool will simulate with spectre the preset ocean scripts
                in the testbench library under the chosen cell types testbench
                views.
Procedures    : S130QA_pcellSim
                S130QA_pcellSimGetToggles
                S130QA_pcellSimMain
                S130QA_pcellSimDevice
                S130QA_pcSimCreateSubckt
                S130QA_pcSimWireUpInst
                S130QA_pcSimMergeBBoxes
                S130QA_pcellSimCheckTemps
                S130QA_pcellSimHelp
                laQASIMGUI
Env Vars used : NONE

================================================================================
Modification history :

==============================================================================*/

;----------------------------------------------------------------------
; FOR Adding to library manager
;----------------------------------------------------------------------
procedure( laQASIMGUI(@rest args)
  S130QA_pcellSim()
)

;-----------------------------
; Root Procedure & Build Form
;-----------------------------
procedure( S130QA_pcellSim( @optional (pdkLib "S130") (tbLib "QA_S130_PCELL_SIMS") )
  let( (allCellNames capCells dioCells nmosCells pmosCells npnCells pnpCells
        resCells defSimDir defTempList defCornersList info1 info2 info3 info4 info5
        simDir simDirBrowse corners cornersList temps tempList allCells cellType
        singleCell S130QA_simForm )

    ; done all weird like due to cadence bug of not processing things in order
    println( "=======================================================")
    println( "QAsim: Starting the QA simulation tool...")
    unless( ddGetObj(pdkLib)
      error("%s library is not in your list of libraries\n" pdkLib)
    )
    println( "QAsim: Gathering device lists...")
    unless( ddGetObj(tbLib)
      error("%s library is not in your list of libraries\n" tbLib)
    )

    ; gather the list of cell names from the pdkLib
    ; takes too long so just hard coding it
    ;allCellNames = sort(setof( cell ddGetObj(pdkLib)->cells member("symbol" cell->views~>name))~>name nil)
    ;allCellNames = sort(setof( cell allCellNames (!rexMatchp("^pad" cell ) && !rexMatchp("^d[di]" cell) &&
    ;  !rexMatchp("^pres" cell) && !rexMatchp("^pcap" cell) && !rexMatchp("^icecap" cell) &&
    ;  !rexMatchp("^d.*esd" cell) && !rexMatchp("^rm" cell) )) nil)
    allCellNames = list("cm3m4" "cm4m5" "dnsd_pw" "dnsd_pw_lvt" "dnsd_pw_nat"
      "dnsd_pw_v5" "dpsd_nw" "dpsd_nw_hvt" "dpsd_nw_lvt" "dpsd_nw_v5"
      "nmos" "nmos_de_iso_v20" "nmos_de_nat_v20" "nmos_de_v12" "nmos_de_v20"
      "nmos_de_zvt_v20" "nmos_esd_nat_v5" "nmos_esd" "nmos_esd_v5" "nmos_lvt"
      "nmos_nat_v3" "nmos_nat_v5" "nmos_v5" "npn_1x1" "npn_1x1_v5" "npn_1x2"
      "pmos" "pmos_de_v12" "pmos_de_v20" "pmos_esd_v5" "pmos_hvt"
      "pmos_lvt" "pmos_v5" "pnp" "pnp_5x" "rndiff"
      "rndiff_v5" "rpdiff" "rpdiff_v5" "rpoly" "rpoly_hp"
      "rpoly_hp2K" "rpwell"
    )
    capCells  = sort(setof( cell allCellNames rexMatchp("^cm" cell )) nil)
    dioCells  = sort(setof( cell allCellNames rexMatchp("^d[np]sd" cell )) nil)
    nmosCells = sort(setof( cell allCellNames rexMatchp("^nmos" cell )) nil)
    pmosCells = sort(setof( cell allCellNames rexMatchp("^pmos" cell )) nil)
    npnCells  = sort(setof( cell allCellNames rexMatchp("^npn" cell )) nil)
    pnpCells  = sort(setof( cell allCellNames rexMatchp("^pnp" cell )) nil)
    resCells  = sort(setof( cell allCellNames rexMatchp("^r" cell )) nil)

    ; default root sim dir
    if( isDir(strcat("/sim/" getLogin())) then
      defSimDir = strcat("/sim/" getLogin() "/QAsims")
    else
      defSimDir = "./QAsims"
    ); if dir

    ; set tempList & cornersList
    defCornersList = cornersList = list( "tt" "ff" "ss" "fs" "sf" )
          ; name       fet      res       cap
    ;  list("typ"      "fet_tt" "res_nom"  "cap_nom")
    ;  list("fast"     "fet_ff" "res_low"  "cap_low")
    ;  list("slow"     "fet_ss" "res_high" "cap_high")
    ;  list("fastslow" "fet_fs" "res_low"  "cap_high")
    ;  list("slowfast" "fet_sf" "res_high" "cap_low")
    ;)
    defTempList = "-40 25 150" 
    tempList = list(-40 25 150) 

    info1 = hiCreateLabel( 
      ?name 'info1 
      ?justification  'center
      ?labelText strcat("<div style='color: #0000ff;'>*** Library " pdkLib " Pcell simulation QA ***</div>")
    )
    info2 = hiCreateLabel( 
      ?name 'info2 
      ?justification  'center
      ?labelText "This will run simulations on the device(s) chosen below.  It will place an instance with"
    )
    info3 = hiCreateLabel( 
      ?name 'info3
      ?justification  'center
      ?labelText strcat( "default values in the device type's subckt schematic in the " tbLib " library, then")
    )
    info4 = hiCreateLabel( 
      ?name 'info4
      ?justification  'center
      ?labelText strcat("run the ocean script(s) in the device type's testbench also in the " tbLib ".")
    )
    info5 = hiCreateLabel( 
      ?name 'info5
      ?justification  'center
      ?labelText "Run choices are either All devices, all devices of a specific type, or a single device."
    )
    simDir = hiCreateStringField(
      ?name     'simDir
      ?prompt   "Root Sim Directory:"
      ?defValue defSimDir
      ?callback "{if( isDir(hiGetCurrentForm()->simDir->value) then
                    unless( isWritable(hiGetCurrentForm()->simDir->value)
                      warn(\"You don't have permission to write to %s\"
                        hiGetCurrentForm()->simDir->value))
                  else
                    unless( isWritable( strcat( hiGetCurrentForm()->simDir->value \"/..\" ))
                      warn(\"You don't have permission to create %s\"
                        hiGetCurrentForm()->simDir->value)
                  ))
                }"
    )
    simDirBrowse = hiCreateFormButton(
      ?name 'simDirBrowse
      ?buttonText "..."
      ?callback "ddsFileBrowseCB( hiGetCurrentForm()
        'simDir \"*\" 'directoryOnly \"Root Simulation Directory\")"
    )
    corners = hiCreateToggleField(
      ?name     'corners
      ?prompt   "Corner(s):"
      ?choices  mapcar('list mapcar('stringToSymbol defCornersList) defCornersList)
      ?defValue list(t t t t t)
      ?callback list("cornersList = S130QA_pcellSimGetToggles( hiGetCurrentForm()->corners->value
                        mapcar('stringToSymbol defCornersList))
                    ")
      /*
      ?choices  mapcar( 'list mapcar('stringToSymbol mapcar('car defCornersList))
                mapcar('car defCornersList) )
      ?defValue mapcar('stringp mapcar('car defCornersList) )
      ?callback list("{let((corns) foreach( corner S130QA_pcellSimGetToggles( hiGetCurrentForm()->corners->value
                        mapcar( 'list mapcar('stringToSymbol mapcar('car defCornersList))))
                        corns = cons( assoc(corner defCornersList) corns)) cornersList = reverse(corns))
                    }")
      */
    )
    temps = hiCreateStringField(
      ?name 'temps
      ?prompt "Temperature(s):"
      ?defValue defTempList
      ?callback "{unless( S130QA_pcellSimCheckTemps(hiGetCurrentForm())
                    hiGetCurrentForm()->temps->value = defTempList
                  )
                  tempList = mapcar('int mapcar('cdfParseFloatString parseString(hiGetCurrentForm()->temps->value)))
                }"
    )
    allCells = hiCreateBooleanButton(
      ?name           'allCells
      ?buttonText     "Simulate ALL devices"
      ?defValue       t
      ?buttonLocation 'left
      ?callback       "{if( hiGetCurrentForm()->allCells->value then
                          hiGetCurrentForm()->cellType->enabled   = nil
                          hiGetCurrentForm()->singleCell->enabled = nil
                        else
                          hiGetCurrentForm()->cellType->enabled   = t
                          if( hiGetCurrentForm()->cellType->value == \"single device\" then
                            hiGetCurrentForm()->singleCell->enabled = t
                          else
                            hiGetCurrentForm()->singleCell->enabled = nil
                          )
                        )
                      }"
    )
    cellType = hiCreateRadioField(
      ?name     'cellType
      ?prompt   "Device Types:"
      ?defValue "nmos"
      ?choices  list( "nmos" "pmos" "caps" "diodes" "resistors" "npn" "pnp" "single device" )
      ?enabled  nil
      ?callback list("if( hiGetCurrentForm()->cellType->value == \"single device\" then
                    hiGetCurrentForm()->singleCell->enabled = t
                  else
                    hiGetCurrentForm()->singleCell->enabled = nil
                  )")
    )
    singleCell = hiCreateCyclicField(
      ?name     'singleCell
      ?prompt   "Device:"
      ?defValue car(allCellNames)
      ?choices  allCellNames
      ?enabled  nil
    )

    ; Create main form
    ; ++++++++++++++++++++++++++++++++++++++++++++++++++
    S130QA_simForm = hiCreateAppForm(
      ?name       'S130QA_simForm
      ?formTitle  strcat( pdkLib " QA: Pcell Simulation Tool")
      ?fields     list(
        list( info1             0: 15  680: 20 )
        list( info2             0: 35  680: 20 )
        list( info3             0: 50  680: 20 )
        list( info4             0: 65  680: 20 )
        list( info5             0: 80  680: 20 )

        list( simDir           15:130  615: 30  130 )
        list( simDirBrowse    635:130   30: 25   30 )
        list( corners          15:160  400: 30   70 )
        list( temps            15:190  400: 30  105 )
        list( allCells         15:220  400: 30   20 )
        list( cellType         15:250  400: 30   95 )
        list( singleCell       55:280  400: 30   60 )
      )
      ?initialSize list( 680 360 )
      ?callback  "{
        if( blankstrp(hiGetCurrentForm()->simDir->value) then
          warn(\"Please provide a simulation directory\n\")
        else
          S130QA_pcellSimMain( pdkLib tbLib 
            cond(
              ( hiGetCurrentForm()->singleCell->enabled
                list( hiGetCurrentForm()->singleCell->value )
              )
              ( hiGetCurrentForm()->cellType->enabled
                case( hiGetCurrentForm()->cellType->value
                  ( \"nmos\"      nmosCells )
                  ( \"pmos\"      pmosCells )
                  ( \"caps\"      capCells )
                  ( \"diodes\"    dioCells )
                  ( \"resistors\" resCells )
                  ( \"npn\"       npnCells )
                  ( \"pnp\"       pnpCells )
                )
              )
              ( t allCellNames )
            )
            hiGetCurrentForm()->simDir->value tempList cornersList 
          )
        )}"
      ?buttonLayout 'ApplyCancelDef
      ?help ""
    )

    S130QA_simForm->corners->hiToolTip = "Choose which corner(s) to run\n(defaults to \"tt\" if none picked"
    S130QA_simForm->temps->hiToolTip = "Enter temperatures separated by spaces"

    ;help
    putprop( 'S130QA_simForm "S130QA_pcellSimHelp()" 'hiHelpAction)

    hiDisplayForm( S130QA_simForm 50:100 )

  ); let
); procedure S130QA_pcellSim

;-----------------------------
; Toggle callback
;-----------------------------
procedure( S130QA_pcellSimGetToggles( togValues togChoices )
  let( ( (count 0) choices )
    count = 0
    foreach( value togValues
      when( value
        choices = cons( symbolToString(nth( count togChoices )) choices )
      ); when value
      count++
    ); foreach
    unless( choices
      choices = list( symbolToString(car(togChoices)) )
    );unless
    reverse( choices )
  );let
); procedure S130QA_pcellSimGetToggles

;-----------------------------
; Main Program
;-----------------------------
procedure( S130QA_pcellSimMain( pdkLib tbLib cellList simDir tempList cornersList ) 
  prog( (progBox stopTheMadness)
    ; make sure you can create the simDir
    unless( isDir(simDir)
      unless( createDirHier(simDir)
        warn("QA SIM: Can't create %s, please try again\n" simDir )
        return()
      ); unless they can't create the simDir
    ); unless simDir exists

    ; progress bar
    stopTheMadness = nil
    when( length(cellList) > 1
      hiDisplayProgressBox(
        ?name 'progBox
        ?banner "QA Sim Cell"
        ?text   sprintf(nil "Simulating %s" car(cellList) ) 
        ?callback "stopTheMadness = t"
        ?totalSteps length(cellList)
        ?autoClose nil
        ?location     list(30 350)
      )
      hiSetProgressButtonText(progBox "STOP!")
    ); when

    ; run the sims
    foreach( cell cellList
      ; kill switch
      if( stopTheMadness then
        return(t)
      else
        when( length(cellList) > 1
          hiSetProgressAndText(progBox lindex(cellList cell)-1 sprintf(nil "Simulating %s" cell ) )
        )
        S130QA_pcellSimDevice( pdkLib cell tempList cornersList tbLib simDir )
        when( length(cellList) > 1
          hiSetProgress(progBox lindex(cellList cell))
        )
      ); if user stops the sims
    )
    system("sleep 3")
    when( length(cellList) > 1 hiCancelProgressBox( progBox ) )

    ; finished messages
    hiDisplayAppDBox(
      ?name         'finishedMsg
      ?dboxBanner   "*** QA Simulation Complete ***" 
      ?dboxText     strcat( 
        "All simulations complete.\n\n"
        "  Please review the graphs\n"
        "  and data files.\n\n"
      )
      ?dialogType   2
      ?dialogStyle  'modeless
      ?buttonLayout 'UserDefined
      ?buttons      list("Enjoy!")
      ?location     list(50 550)
    ); hiDisplayAppDBox
    printf( "=======================================================\n" )
    printf( "QAsim: Your sims are now complete.\n" )
    printf( "=======================================================\n" )

  ); prog
); procedure S130QA_pcellSimMain

;-----------------------------
; S130QA_pcellSimDevice
;-----------------------------
procedure( S130QA_pcellSimDevice( cellLib cellName @optional (tempList list(25))
  (cornersList list("tt"))
  (tbLib "QA_S130_PCELL_SIMS") (simDir strcat("/sim/" getLogin() "/simulation"))
  (simType "spectre") (params list()) )
  prog( (cvInst numTerms tbCell cvTB origSimDir markers tbPath )

    unless( cvInst = dbOpenCellViewByType(ddGetObj(cellLib) cellName "symbol")
      warn( "QAsim: %s/%s cell does not exist.  Try again.\n" cellLib cellName )
      return()
    ); unless cell exists
    
    ; determine the testbench cell name
    numTerms = sprintf(nil "%d" length(cvInst->terminals))
    cond(
      (rexMatchp( "^nmos" cellName ) tbCell = strcat( "nmos"  numTerms "_Testbench" ))
      (rexMatchp( "^pmos" cellName ) tbCell = strcat( "pmos"  numTerms "_Testbench" ))
      (rexMatchp( "^npn"  cellName ) tbCell = strcat( "npn"   numTerms "_Testbench" ))
      (rexMatchp( "^pnp"  cellName ) tbCell = strcat( "pnp"   numTerms "_Testbench" ))
      (rexMatchp( "^c"    cellName ) tbCell = strcat( "cap"   numTerms "_Testbench" ))
      (rexMatchp( "^d"    cellName ) tbCell = strcat( "diode" numTerms "_Testbench" ))
      (rexMatchp( "^r"    cellName ) tbCell = strcat( "res"   numTerms "_Testbench" ))
    ); cond

    unless( cvTB = dbOpenCellViewByType(tbLib tbCell "schematic" "" "a")
      warn( "QAsim: %s/%s can't be opened.\n" tbLib tbCell )
      return()
    ); unless testbench view can't be opened

    printf( "QAsim: Working with %L based on base cell %L\n" tbCell cellName )

    ; create the subckt
    S130QA_pcSimCreateSubckt( tbLib cellLib cellName params )

    when( schCheck(cvTB)
      markers = setof(lpp cvTB~>lpps and(lpp~>layerName=="marker"
        member(lpp~>purpose '("error" "warning"))))
      foreach(type markers
        foreach(shape type~>shapes dbDeleteObject(shape))
      )
      t
    ); when schCheck
    dbSave( cvTB )

    ; get current simDir (to set back later) and set simDir
    origSimDir = envGetVal( "asimenv.startup" "projectDir" )
    envSetVal( "asimenv.startup" "projectDir" 'string simDir)

    ; create sim netlist
    printf( "QAsim: Creating netlist...\n" )
    simulator( stringToSymbol(simType) )
    design( tbLib tbCell "schematic" )
    createNetlist(?display nil)

    ; get sim files under the testbench
    tbPath = ddGetObj( tbLib tbCell )->readpath

    foreach( simFile setof( file getDirFiles(tbPath) rexMatchp("^sim_" file))
      printf( "QAsim: Running %s simulation...\n" simFile )
      loadi(strcat(tbPath "/" simFile "/text.txt"))
    ); foreach sim file

    ; reset the simDir back to original
    envSetVal( "asimenv.startup" "projectDir" 'string origSimDir)

  ); prog
); procedure S130QA_pcellSimDevice

;-----------------------------
; Create Subcircuit
;-----------------------------
procedure( S130QA_pcSimCreateSubckt( tbLib cellLib cellName @optional (params list()) )
  prog( (cvInst numTerms subCell cvSub inst markers)
    
    unless( cvInst = dbOpenCellViewByType(ddGetObj(cellLib) cellName "symbol")
      warn( "QAsim: %s/%s cell does not exist.  Try again.\n" cellLib cellName )
      return()
    ); unless cell exists

    ; determine the subckt cell name
    numTerms = sprintf(nil "%d" length(cvInst->terminals))
    cond(
      (rexMatchp( "^nmos" cellName ) subCell = strcat( "nmos"  numTerms "_subckt" ))
      (rexMatchp( "^pmos" cellName ) subCell = strcat( "pmos"  numTerms "_subckt" ))
      (rexMatchp( "^npn"  cellName ) subCell = strcat( "npn"   numTerms "_subckt" ))
      (rexMatchp( "^pnp"  cellName ) subCell = strcat( "pnp"   numTerms "_subckt" ))
      (rexMatchp( "^c"    cellName ) subCell = strcat( "cap"   numTerms "_subckt" ))
      (rexMatchp( "^d"    cellName ) subCell = strcat( "diode" numTerms "_subckt" ))
      (rexMatchp( "^r"    cellName ) subCell = strcat( "res"   numTerms "_subckt" ))
    ); cond

    ; test
    ;printf( "sub: %s/%s  i: %s/%s\n" tbLib subCell cellLib cellName )

    unless( cvSub = dbOpenCellViewByType(ddGetObj(tbLib) subCell "schematic" "schematic" "w")
      warn( "QAsim: %s/%s can't be created.\n" tbLib subCell )
      return()
    ); unless subckt view can't be created

    printf( "QAsim: Placing instance of %L in %s/%s cell\n" cellName tbLib subCell )

    if( params then
      inst = dbCreateExtParamInst( cvSub cvInst nil 0:0 "R0" 1 params t)
    else
      inst = dbCreateInst( cvSub cvInst nil 0:0 "R0" 1 )
    ); if params

    S130QA_pcSimWireUpInst( cvSub inst )
    when( schCheck(cvSub)
      markers = setof(lpp cvSub~>lpps and(lpp~>layerName=="marker"
        member(lpp~>purpose '("error" "warning"))))
      foreach(type markers
        foreach(shape type~>shapes dbDeleteObject(shape))
      )
      t
    ); when schCheck
    dbSave( cvSub )
    dbPurge( cvSub )
    dbClose( cvInst )

  ); prog
); procedure S130QA_pcSimCreateSubckt

;-----------------------------
; Wire up Instance
;-----------------------------
procedure( S130QA_pcSimWireUpInst( cv inst @key (termL 0.125) )
  prog( (iopin ipin opin numTerms termBbox maxY minY maxX minX top bot rht lft
    direction point pin orient point2 )
    iopin  = dbOpenCellViewByType( "basic" "iopin" "symbolr" "" "r")
    ipin   = dbOpenCellViewByType( "basic" "ipin" "symbol" "" "r")
    opin   = dbOpenCellViewByType( "basic" "opin" "symbol" "" "r")

    numTerms = length(inst->master->terminals)
    termBbox = dbTransformBBox( car( nth( 0 inst->master->terminals )~>pins)~>fig~>bBox inst->transform )

    for( i 1 numTerms-1
      termBbox = S130QA_pcSimMergeBBoxes( termBbox dbTransformBBox(
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
      point = centerBox( dbTransformBBox( car(term->pins)->fig->bBox inst->transform ) )

      case( direction
        ("inputOutput" pin = iopin )
        ("input"       pin = ipin )
        ("output"      pin = opin )
      ); case direction

      cond(
        ; bottom pins
        ( yCoord(point) < bot && xCoord(point) < rht && xCoord(point) > lft
          orient = "R90"
          point2 = list( xCoord(point) yCoord(point) - termL)
          schCreateWire( cv "draw" nil list( point point2 ) 0.0625 0.0625 0 )
          schCreatePin( cv pin term->name direction nil point2 orient )
        )
        ; top pins
        ( yCoord(point) > top && xCoord(point) < rht && xCoord(point) > lft
          orient = "R270"
          point2 = list( xCoord(point) yCoord(point) + termL)
          schCreateWire( cv "draw" nil list( point point2 ) 0.0625 0.0625 0 )
          schCreatePin( cv pin term->name direction nil point2 orient )
        )
        ; left pins
        ( xCoord(point) < lft
          if( direction == "input" then orient = "R0" else orient = "MY")
          point2 = list( xCoord(point) - termL yCoord(point))
          schCreateWire( cv "draw" nil list( point point2 ) 0.0625 0.0625 0 )
          schCreatePin( cv pin term->name direction nil point2 orient )
        )
        ; right pins
        ( xCoord(point) > rht
          if( direction == "output" then orient = "R0" else orient = "MY")
          point2 = list( xCoord(point) + termL yCoord(point))
          schCreateWire( cv "draw" nil list( point point2 ) 0.0625 0.0625 0 )
          schCreatePin( cv pin term->name direction nil point2 orient )
        )
      ); cond
    ); foreach term
  ); prog
); procedure S130QA_pcSimWireUpInst

procedure( S130QA_pcSimMergeBBoxes(bBox1 bBox2)
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
); procedure S130QA_pcSimMergeBBoxes

;-----------------------------
; procedure S130QA_pcellSimCheckTemps
;-----------------------------
procedure( S130QA_pcellSimCheckTemps(QAform)
  let( (temps (result t))
    temps = QAform->temps->value
    if( listp(temps) then
      foreach( temp temps
        unless( integerp(temp)
          result = nil
        ); unless temp is int
      ); foreach temp
    else
      if( stringp(temps) then
        unless( integerp(evalstring(temps))
          result = nil
        ); unless temps is int
      else
        result = nil
      ); if string temps
    ); if list temps
    unless( result
      warn("QAsim: Temperatures must be a list of integers!\nResetting to defaults\n")
    ); unless temp is int
    result
  ); let
); procedure S130QA_pcellSimCheckTemps

;-----------------------------
; procedure S130QA_pcellSimHelp
;-----------------------------
procedure( S130QA_pcellSimHelp()

  hiDisplayAppDBox(
    ?name         'formHelp
    ?dboxBanner   "*** S130 QA Pcell Simulator Tool Help ***" 
    ?dboxText     strcat( 
      "====================================================================================================\n"
      "\n" 
      "This QA tool will simulate with spectre the preset ocean scripts in the testbench\n"
      "  library under the chosen cell types testbench views.\n"
      "Based on your input, it will replace the instance in the testbench library's cell\n"
      "  type's subckt schematic with the default device placement, then will run the\n"
      "  simulation on the testbench which has the subcircuit instantiated.\n"
      "Plot windows will open per cell/sim.  Within each window, subwindows will be created\n"
      "  with plots for each temperature you give that includes waves plotted for each corner.\n"
      "A csv data file, \"qasimdata.dat\", containing the sim data for all corners and temps\n"
      "  will be created under the folder:\n"
      "  [rootSimDir]/[cellType]_Testbench/[cellName]/spectre/schematic\n"
      "\n" 
      "----------------------------------------------------------------------------------------------------\n"
      "\n" 
      "Description of Inputs:\n"
      "  Root Sim Directory - where to run and output all sim data\n"
      "    * Folders will be created under this for each cell type testbench,\n"
      "      cell name, and corner_temp with the simulation results\n"
      "  Corner(s) - turn on/off desired corners to run.  If nothing is selected\n"
      "    then it will default to run typ corner\n"
      "  Temperature(s) - enter the temps (must be integers) you want to simulate,\n"
      "    separated by spaces.\n"
      "  Simulate ALL - turn on to simulate all devices\n"
      "  Device Types - choose to run all devices of a specific type, or select \"single device\"\n"
      "    to run one specific device\n"
      "  Device - choose the single device to run sims on\n"
      "\n" 
      "====================================================================================================\n"
      "\n"
    )
    ?dialogType   3
    ?dialogStyle  'modeless
    ?buttonLayout 'UserDefined
    ?buttons      list("Thanks!")
  ); end hiDisplayAppDBox

); procedure S130QA_pcellSimHelp
