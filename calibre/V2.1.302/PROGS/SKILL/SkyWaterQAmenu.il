
unless( setq( pdkHome getShellEnvVar("PDK_HOME"))
  error( "PDK_HOME environment variable not set\n")
)
;unless( setq( metStack getShellEnvVar("METAL_STACK"))
;  error( "METAL_STACK environment variable not set\n")
;)

when( and( isCallable('hiGraphicMode) hiGraphicMode() )
  ciwMenuInit()
)

;===============================================================================
; Load all needed skill code
;===============================================================================
info( "----------------------------------------\n")
info( "Loading SkyWater Skill Code\n")
info( "----------------------------------------\n")

; Model Selection
;loadi( strcat( getShellEnvVar("PDK_HOME") "/MODELS/V3.0.1/SPECTRE/SKILL/skywater_menu.il"))
;loadi( strcat( getShellEnvVar("PDK_HOME") "/MODELS/SPECTRE/SKILL/skywater_menu.il"))

; Trigger Callbacks
loadi( strcat( getShellEnvVar("PDK_HOME") "/PROGS/SKILL/menu_tools/CCSinvokeCdfCallbacks.il"))

; Check & Save
;loadi( strcat( getShellEnvVar("PDK_HOME") "/PROGS/SKILL/menu_tools/CCScheckAllSymAndSch.il"))
loadi( strcat( getShellEnvVar("PDK_HOME") "/PROGS/SKILL/menu_tools/SWcheckAllSymAndSch.il"))

; QA developer tools
if( getShellEnvVar("PDK_DEV") == "t" then
  loadi( strcat( getShellEnvVar("PDK_HOME") "/PROGS/SKILL/dev/qa_sims/S130QA_pcellSimulator.il"))
  loadi( strcat( getShellEnvVar("PDK_HOME") "/PROGS/SKILL/dev/qa_pcells/S130QA_pcellPlacer.il"))
  loadi( strcat( getShellEnvVar("PDK_HOME") "/PROGS/SKILL/dev/qa_pcells/S130QA_pcellVerifier.il"))
  loadi( strcat( getShellEnvVar("PDK_HOME") "/PROGS/SKILL/dev/qa_drc/laQADRC.il"))
  loadi( strcat( getShellEnvVar("PDK_HOME") "/PROGS/SKILL/dev/qa_lvs/laQALVS.il"))
  loadi( strcat( getShellEnvVar("PDK_HOME") "/PROGS/SKILL/dev/LACopyFastGUI.il"))
); if

;===============================================================================
; Create Menus Items
;===============================================================================

; generic separator
swSeparator = hiCreateSeparatorMenuItem( ?name 'swSeparator )

;------------------- 
; Trigger Callbacks
;------------------- 
swTriggerCBsWarning1 = hiCreateLabel( 
  ?name 'swTriggerCBsWarning1 
  ?labelText "<div style='color: #ff0000;'>** USE WITH CAUTION **</div>"
  ?justification  'center
)
swTriggerCBsWarning2 = hiCreateLabel( 
  ?name 'swTriggerCBsWarning2 
  ?labelText "<div style='color: #ff0000;'>This can alter your currently placed Pcells</div>"
  ?justification  'center
)
swSelInstTriggerCallbacks = hiCreateAppForm(
	?name `swSelInstTriggerCallbacks
	?formTitle "Trigger Callbacks on Selected Instances"
	?fields list(
    list( swTriggerCBsWarning1 0: 5 350:20 )
    list( swTriggerCBsWarning2 0:25 350:20 )
  )
	?callback "foreach( inst setof( i geGetSelSet() i->objType == \"inst\")
    CCSinvokeInstCdfCallbacks( inst ?callInitProc t ?useInstCDF t))"
  ?initialSize list( 350 80 )
)
swSelInstTrigCBsMenu = hiCreateMenuItem(
  ?name 	'swSelInstTrigCBsMenu
	?itemText "Trigger Callbacks on Selected Instances"
  ?callback	"hiDisplayForm(swSelInstTriggerCallbacks)"
)
swAllInstTriggerCallbacks = hiCreateAppForm(
	?name `swAllInstTriggerCallbacks
	?formTitle "Trigger Callbacks on All Instances"
	?fields list(
    list( swTriggerCBsWarning1 0: 5 350:20 )
    list( swTriggerCBsWarning2 0:25 350:20 )
  )
	?callback "CCSinvokeCdfCallbacks(geGetEditCellView(getCurrentWindow()) ?callInitProc t ?useInstCDF t )"
  ?initialSize list( 350 80 )
)
swAllInstTrigCBsMenu = hiCreateMenuItem(
  ?name 	'swAllInstTrigCBsMenu
	?itemText "Trigger Callbacks on All Instances"
  ?callback	"hiDisplayForm(swAllInstTriggerCallbacks)"
)
procedure( swLibTrig(@rest args)
  projLibs = hiCreateCyclicField(
    ?name 'projLibs
    ?prompt "Library:"
    ?choices sort(setof( lib ddGetLibList()
      (lib->cells && !rexMatchp(car(getInstallPath()) lib->readpath)) )~>name nil)
  )
  swLibTriggerCallbacks = hiCreateAppForm(
    ?name `swLibTriggerCallbacks
    ?formTitle "Trigger Callbacks on Entire Library"
    ?fields list(
      list( swTriggerCBsWarning1 0: 5 350:20 )
      list( swTriggerCBsWarning2 0:25 350:20 )
      list( projLibs             5:55 300:30 55 )
    )
    ?callback "swCdfCallbackEntireLib(hiGetCurrentForm()->projLibs->value)"
    ?initialSize list( 350 120 )
  )
  hiDisplayForm(swLibTriggerCallbacks)
)
swLibTrigCBsMenu = hiCreateMenuItem(
  ?name 	'swLibTrigCBsMenu
	?itemText "Trigger Callbacks on Entire Library"
  ?callback	"swLibTrig()"
)

;------------------- 
; Check & Save
;------------------- 
procedure( swLibCnS(@rest args)
  projLibs = hiCreateCyclicField(
    ?name 'projLibs
    ?prompt "Library:"
    ?choices sort(setof( lib ddGetLibList()
      (lib->cells && !rexMatchp(car(getInstallPath()) lib->readpath)) )~>name nil)
  )
  swLibCheckAndSave = hiCreateAppForm(
    ?name `swLibCheckAndSave
    ?formTitle "Check And Save on Entire Library"
    ?fields list( list(projLibs 5:5 300:30 55) )
    ?callback "SWcheckAllSymAndSch(hiGetCurrentForm()->projLibs->value t)"
    ?initialSize list( 350 60 )
  )
  hiDisplayForm(swLibCheckAndSave)
)
swLibCnSMenu = hiCreateMenuItem(
  ?name 	'swLibCnSMenu
  ?itemText	"Check And Save on Entire Library"
  ?callback	"swLibCnS()"
)

;------------------- 
; Documentation/About
;------------------- 
procedure( swOpenPDFdoc(pdfFile @optional (docsDir strcat(getShellEnvVar("PDK_HOME") "/DOC")) )
  let( (pdfViewer pdfCmd)
    pdfViewer = getShellEnvVar("PDFVIEWER")
    unless( pdfViewer
      pdfViewer = "/usr/bin/evince"
    ); unless
    pdfCmd = sprintf(nil "%s %s/%s &" pdfViewer docsDir pdfFile )
    shell(pdfCmd)
    t
  ); let
); proc

let( (S130PDKdocsDir S130PdfDocs)
  S130PDKdocsDir = strcat(getShellEnvVar("PDK_HOME") "/DOC")
  S130PdfDocs = sort(setof( file getDirFiles(S130PDKdocsDir) rexMatchp("pdf$" file)) nil)

  S130DocMenuItems = list()
  if( length(S130PdfDocs) > 0 then
    foreach( pdf S130PdfDocs
      let( (baseName swDocMenu)
        rexCompile("\\.pdf")
        baseName = rexReplace(pdf "" 0)
        rexCompile("_")
        swDocMenu = hiCreateMenuItem(
          ?name     stringToSymbol(strcat("swDoc" baseName "Menu"))
          ?itemText rexReplace(baseName " " 0)
          ?callback sprintf(nil "swOpenPDFdoc(%L)" pdf)
        )
        S130DocMenuItems = append1( S130DocMenuItems swDocMenu )
      ); let
    ); foreach pdf
  else
    swDocMenu = hiCreateMenuItem(
      ?name     'swDocNoMenu
      ?itemText "No Documents Available"
    )
    S130DocMenuItems = append1( S130DocMenuItems swDocMenu )
  ); if pdfs exist
); let

hiCreatePulldownMenu(
  'swDocMenu
  "PDK Documents"
  S130DocMenuItems
)
swDocMenuAdd = hiCreateSliderMenuItem(
  ?name     'swDocMenuAdd
  ?itemText "PDK Documents"
  ?subMenu  swDocMenu
)

;------------------- 
; Q & A
;------------------- 
swQADRCItem = hiCreateMenuItem(
  ?name 'swQADRCItem
  ?itemText "QA Libs: DRC"
  ?callback "laQADRCGUI(nil \"QA_S130_DRC\" nil nil nil nil)"
)
swQALVSItem = hiCreateMenuItem(
  ?name 'swQALVSItem
  ?itemText "QA Libs: LVS"
  ?callback "laQALVSGUI()"
)
swQAPcellsItem = hiCreateMenuItem(
  ?name 'swQAPcellsItem
  ?itemText "S130 QA: Pcell Placer"
  ?callback "S130QA_PcellPlacementForm()"
)
swQAPcellVerifItem = hiCreateMenuItem(
  ?name 'swQAPcellVerifItem
  ?itemText "S130 QA: Pcell Verification"
  ?callback "S130QA_pcellVerif()"
)
swQAPcellSimItem = hiCreateMenuItem(
  ?name 'swQAPcellSimItem
  ?itemText "S130 QA: Pcell Simulator"
  ?callback "S130QA_pcellSim()"
)
hiCreatePulldownMenu(
  'swQAMenu
  "Developer QA"
  list( swQADRCItem swQALVSItem swQAPcellVerifItem swQAPcellSimItem )
)
swQAMenuAdd = hiCreateSliderMenuItem(
  ?name     'swQAMenuAdd
  ?itemText "Developer QA"
  ?subMenu  swQAMenu
)

;===============================================================================
; Create Menus
;===============================================================================

;------------------- 
; Schematic SkyWater Menu
;------------------- 
hiCreatePulldownMenu(
	'swSchPulldownMenu
	"SkyWater"
	list(
		swSelInstTrigCBsMenu
		swAllInstTrigCBsMenu
	)
)
when( getShellEnvVar("PDK_DEV") == "t" 
  hiAddMenuItem( swSchPulldownMenu swSeparator )
  hiAddMenuItem( swSchPulldownMenu swQAPcellsItem )
)
procedure( swSchMenu(args)
  hiInsertBannerMenu( hiGetCurrentWindow() swSchPulldownMenu 20)
)

;; Trigger for adding to Schematic windows
deRegUserTriggers("schematic" nil nil 'swSchMenu)
deRegUserTriggers("schematicXL" nil nil 'swSchMenu)

;------------------- 
; Layout SkyWater Menu
;------------------- 
hiCreatePulldownMenu(
	'swLayPulldownMenu
	"SkyWater"
	list(
		swSelInstTrigCBsMenu
		swAllInstTrigCBsMenu
	)
)
when( getShellEnvVar("PDK_DEV") == "t" 
  hiAddMenuItem( swLayPulldownMenu swSeparator )
  hiAddMenuItem( swLayPulldownMenu swQAPcellsItem )
)
procedure( swLayMenu(args)
	hiInsertBannerMenu( hiGetCurrentWindow() swLayPulldownMenu 20)
)
;; Trigger for adding to Layout windows
deRegUserTriggers("maskLayout" nil nil 'swLayMenu)
deRegUserTriggers("maskLayoutXL" nil nil 'swLayMenu)

;------------------- 
; CIW SkyWater Menu
;------------------- 
swCiwPulldownMenu = hiCreatePulldownMenu(
	'swCiwPulldownMenu
	"SkyWater"
	list(
		swLibCnSMenu
    swLibTrigCBsMenu
	)
)

when( getShellEnvVar("PDK_DEV") == "t" 
  hiAddMenuItem( swCiwPulldownMenu swSeparator )
  hiAddMenuItem( swCiwPulldownMenu swQAMenuAdd )
)

; add the document/about menu
hiAddMenuItem( swCiwPulldownMenu hiCreateSeparatorMenuItem( ?name 'swSep ) )
hiAddMenuItem( swCiwPulldownMenu swDocMenuAdd )

hiInsertBannerMenu( window(1) swCiwPulldownMenu
  (length (hiGetBannerMenus window(1)))
)

;------------------- 
; ADE SkyWater Menu
;------------------- 
swADEModelGui = hiCreateMenuItem(
  ?name 	'swADEModelGui
  ?itemText	"Open Model GUI"
  ?callback	"ADE_modelGUI()"
)
hiCreatePulldownMenu(
  'swAdePulldownMenu
   "SkyWater"
   list( swADEModelGui )
)
procedure( swADEPostInstallTrigger(args)
  hiInsertBannerMenu(
    hiGetCurrentWindow()~>sevSession~>window
    swAdePulldownMenu
    length( hiGetBannerMenus( hiGetCurrentWindow()~>sevSession~>window))
  )
); procedure

deRegUserTriggers( "analogArtist-schematic" nil nil 'swADEPostInstallTrigger)
deRegUserTriggers( "adexl" nil nil 'swADEPostInstallTrigger)
deRegUserTriggers( "maestro" nil nil 'swADEPostInstallTrigger)
deRegUserTriggers( "explorer" nil nil 'swADEPostInstallTrigger)
; needed for ADE L
;envSetVal("asimenv.startup" "sessInitTrigFunc" 'string  "swADEPostInstallTrigger")

