/*==============================================================================

  File:         S130lvsQA.il
  Purpose:      GUI to run LVS on cells within a specified category in the
                QA_S130_LVS library, & create a report if they run as expected.

  Created:      Jun 12, 2020  Madek Graham
  Description:  This will create a form that works in conjuction with the LVS
                QA library.  It will grab all the cells in a choosen category
                that have both layout and schematic views, then runs the
                desired LVS verification on them.  A report will be created
                and displayed once all the LVS runs are complete, giving a
                summary of which cells "passed" (pass ones should pass, and
                *_fail cells should fail, thus passing).

------------------------------------------------------------
  Modifications:
  - Jul 7, 2020 MSG
    Added pvs functionality

==============================================================================*/

;----------------------------------------------------------------------
; FOR Adding to library manager
;----------------------------------------------------------------------
procedure( laQALVSGUI(@rest args)
  S130lvsQAform()
)

;-----------------------------
; Main Form
;-----------------------------
procedure( S130lvsQAform()
  let( (allData libs libCats catCells defLib defCat defCalRules defPvsRules defRunDir
        library category runType ruleFile ruleBrowseBtn runDir runDirBrowseBtn
        overwriteRD qaLVS_form )

    envSetVal("ui" "raiseCIWonWarning" 'boolean t)

    printf( "****  Starting QA LVS  ****\n" )
    printf( "QA LVS: Gathering list of libraries\n" )

    libs = sort( setof( lib ddGetLibList()~>name !ddGetCombineValue(ddGetObj(lib))) nil)
    defLib = car(member("QA_S130_LVS" libs)) || car(libs)
    allData = qaLVS_getData(defLib)
    libCats = nth(0 allData)
    catCells = nth(1 allData)

    defCat = car(libCats[defLib])
    defCalRules = strcat( getShellEnvVar("PDK_HOME") "/PV/Calibre/LVS/calibre_lvs.rul")
    defPvsRules = strcat( getShellEnvVar("PDK_HOME") "/PV/PVS/LVS/pvs_lvs.rul")
    defRunDir = strcat( "/sim/" getShellEnvVar("USER") "/LVS_QA_run")
    unless( isDir(defRunDir)
      unless( createDirHier(defRunDir)
        defRunDir = strcat( getWorkingDir() "/LVS_QA_run" )
      ); unless they can't create the defRunDir
    ); unless defRunDir doesn't exist

    ; form fields
    library = hiCreateCyclicField(
      ?name       'library
      ?prompt     "Library Name"
      ?defValue   defLib
      ?choices    libs
      ?callback   "{allData = qaLVS_getData(hiGetCurrentForm()->library->value libCats catCells)
                    libCats = nth(0 allData)  catCells = nth(1 allData)
                    hiGetCurrentForm()->category->choices = libCats[hiGetCurrentForm()->library->value]
                    hiGetCurrentForm()->category->value = car(libCats[hiGetCurrentForm()->library->value])}"
    )
    category = hiCreateCyclicField(
      ?name       'category
      ?prompt     "Category To Process"
      ?defValue   defCat
      ?choices    libCats[defLib]
    )
    runType = hiCreateRadioField(
      ?name       'runType
      ?prompt     "Run Type"
      ?defValue   "Calibre"
      ?choices    list("Calibre" "PVS")
      ?callback   list(
                    strcat("hiGetCurrentForm()->ruleFile->value = \"" defCalRules "\"")
                    strcat("hiGetCurrentForm()->ruleFile->value = \"" defPvsRules "\"")
                  )
    )
    ruleFile = hiCreateStringField(
      ?name     'ruleFile
      ?prompt   "Rule File"
      ?defValue defCalRules
      ?callback "{unless( isFile(hiGetCurrentForm()->ruleFile->value)
                    warn(\"The rule file %s doesn't exist.  Try again\" 
                      hiGetCurrentForm()->ruleFile->value)
                )}"
    )
    ruleBrowseBtn = hiCreateFormButton(
      ?name 'ruleBrowseBtn
      ?buttonText "..."
      ?callback "ddsFileBrowseCB( hiGetCurrentForm()
        'ruleFile \"*\" 'existingFile \"Find the LVS Rules File\")"
    )
    runDir = hiCreateStringField(
      ?name     'runDir
      ?prompt   "Root Output Directory"
      ?value    defRunDir
      ?callback "{ if( isDir(hiGetCurrentForm()->runDir->value) then
                    unless( isWritable(hiGetCurrentForm()->runDir->value)
                      warn(\"You don't have permission to write to %s\"
                        hiGetCurrentForm()->runDir->value))
                  else
                    unless( isWritable( strcat( hiGetCurrentForm()->runDir->value \"/..\" ))
                      warn(\"You don't have permission to create %s\"
                        hiGetCurrentForm()->runDir->value)
                  ))
                }"
    )
    runDirBrowseBtn = hiCreateFormButton(
      ?name 'runDirBrowseBtn
      ?buttonText "..."
      ?callback "ddsFileBrowseCB( hiGetCurrentForm()
        'runDir \"*\" 'directoryOnly \"Choose the Output Directory\")"
    )
    overwriteRD = hiCreateBooleanButton(
      ?name           'overwriteRD
      ?buttonText     "<div style='color: #ff0000;'>Overwrite existing data</div>"
      ?defValue       t
      ?buttonLocation 'left
    )

    ; Create main form
    ; ++++++++++++++++++++++++++++++++++++++++++++++++++
    qaLVS_form = hiCreateAppForm(
      ?name       'qaLVS_form
      ?formTitle  "QA LVS"
      ?fields list(
                list( library          10:  5  740: 30  150 )
                list( category         10: 35  740: 30  150 )
                list( runType          10: 65  740: 30  150 )
                list( ruleFile         10: 95  690: 30  150 )
                list( ruleBrowseBtn   705: 98   30: 25   30 )
                list( runDir           10:125  690: 30  150 )
                list( runDirBrowseBtn 705:128   30: 25   30 )
                list( overwriteRD     490:155  250: 30   20 )
      )
      ?initialSize t
      ?help ""
      ?buttonLayout 'OKCancelDefApply
      ?callback   "qaLVS_Main(
                    hiGetCurrentForm()->library->value
                    hiGetCurrentForm()->category->value
                    catCells[ strcat(hiGetCurrentForm()->library->value \":\" hiGetCurrentForm()->category->value) ]
                    hiGetCurrentForm()->runType->value
                    hiGetCurrentForm()->ruleFile->value
                    hiGetCurrentForm()->runDir->value
                    hiGetCurrentForm()->overwriteRD->value
                    )"
    ); qaLVS_form

    ; tool tips for form items
    ; qaLVS_form->[field]->hiToolTip   = "tip here"
    qaLVS_form->library->hiToolTip = "Choose a Library to run LVS on a specified category"
    qaLVS_form->category->hiToolTip = "Choose a Category to run LVS on all the cells within it"
    qaLVS_form->runType->hiToolTip = "Choose which tool to use for LVS"
    qaLVS_form->ruleFile->hiToolTip = "Enter the LVS rule file"
    qaLVS_form->ruleBrowseBtn->hiToolTip = "Click to select the LVS rule file"
    qaLVS_form->runDir->hiToolTip = strcat("Enter the directory where the\nLVS outputs will be placed;\n"
                                            "each cell in it's own directory")
    qaLVS_form->runDirBrowseBtn->hiToolTip = "Click to select the Output directory"

    ; help
    putprop( 'qaLVS_form "qaLVS_formHelp()" 'hiHelpAction)

    hiDisplayForm( 'qaLVS_form 30:50 )

  ); let
); procedure S130lvsQAform

;-----------------------------
; Main
;-----------------------------
procedure( qaLVS_Main(library cat cellList runType ruleFile runDir overwriteRD )
  let( (cellRunDir pvsRulesFile lvsStatus lvsErrors temp lvsResultsFile lvsResultsPort)

    lvsStatus = makeTable('lvsStatusTable)
    lvsErrors = makeTable('lvsErrorsTable)

    foreach( cell cellList
      cellRunDir = strcat( runDir "/" cell )
      when( isDir(cellRunDir) && overwriteRD
        system(strcat("rm -rf " cellRunDir))
      ); when cellRunDir exists
      if( isDir(cellRunDir) then
        warn("QA LVS: %L exists;\n  LVS for cell %L not being ran" cellRunDir cell )
        lvsStatus[cell] = "DID NOT RUN"
      else
        unless( createDirHier(cellRunDir)
          error("QA LVS: Unable to create run directory %L" cellRunDir)
        )

        qaLVS_createCDL(library cell cellRunDir)
        qaLVS_createGDS(library cell cellRunDir)

        printf("QA LVS: Running %s LVS on %s\n" runType cell)
        printf("QA LVS:   If you desire to see the LVS transcript, view %s/lvs.log\n" cellRunDir)
        case( runType
          ("Calibre"
            qaLVS_createCALheader(cell cellRunDir ruleFile)
            system( strcat("cd " cellRunDir "; calibre -lvs -flatten -ixf -nxf -wait 5 cal.header.rul > " cellRunDir "/lvs.log"))
          )
          ("PVS"
            system( strcat("cd " cellRunDir "; pvs -lvs -gds " cell ".gds -top_cell " cell " -source_cdl "
              cell ".cdl -log pvsrun.log -source_top_cell " cell " " ruleFile " > " cellRunDir "/lvs.log"))
          )
        ); case runType
        temp = qaLVS_getResults( cell cellRunDir runType )
        lvsStatus[cell] = nth(0 temp)
        if( nth(1 temp) then
          lvsErrors[cell] = buildString(nth(1 temp) ", ")
        else
          lvsErrors[cell] = ""
        ); when errors
        printf("QA LVS: Result for %s:  %s\n" cell lvsStatus[cell])
      ); if cellRunDir exists
    ); foreach cell


    ; create the report
    lvsResultsFile = sprintf(nil "%s/QALVS_%s.%s.report" getWorkingDir() library cat)
    printf("QA LVS: all LVS runs complete, creating report %s\n" lvsResultsFile )
    lvsResultsPort = outfile(lvsResultsFile)
    fprintf(lvsResultsPort "=======================================================\n")
    fprintf(lvsResultsPort "Report created on %s\n" getCurrentTime())
    fprintf(lvsResultsPort "=======================================================\n")
    fprintf(lvsResultsPort "LIBRARY:  %s\n" library)
    fprintf(lvsResultsPort "CATEGORY: %s\n" cat)
    fprintf(lvsResultsPort "LVS TOOL: %s\n" runType)
    fprintf(lvsResultsPort "RUN DIR:  %s\n" runDir)
    fprintf(lvsResultsPort "=======================================================\n")
    fprintf(lvsResultsPort "%-60s  %-10s  %s\n" " Cell" " Results" " Errors" )
    fprintf(lvsResultsPort "%-60s  %-10s  %s\n" "--------------------" "---------" "--------------------" )
    foreach( cell cellList
      fprintf(lvsResultsPort "%-60s  %-10s  %s\n" cell lvsStatus[cell] lvsErrors[cell] )
    ); foreach cell
    close(lvsResultsPort)
    shell(strcat("gnome-terminal -- vim -R " lvsResultsFile ))

  ); let
); procedure qaLVS_Main

;-----------------------------
; Get Categories & Cells in Categories
;-----------------------------
procedure( qaLVS_getData(lib @optional (libCats makeTable('libCatsTable))
  (catCells makeTable('catCellsTable)))
  prog( (catFiles libPath cat libCat catPort nextLine
        cellLine cellName)
    printf( "QA LVS: Gathering categories & cell lists for library %s\n" lib )
    libPath = ddGetObj(lib)->readpath
    libCats[lib] = list()
    catFiles = setof(file getDirFiles(libPath) rexMatchp("Cat$" file))
    if( catFiles then
      foreach( catFile catFiles
        if( rexMatchp( "TopCat$" catFile ) then
          cat = "Everything"
        else
          cat = nth(0 parseString(catFile "."))
        ); if top category
        libCat = strcat(lib ":" cat)
        libCats[lib] = append1(libCats[lib] cat)
        catCells[libCat] = list()
        if( rexMatchp( "TopCat$" catFile ) then
          catCells[libCat] = ddGetObj(lib)->cells~>name
        else
          catPort = infile(strcat(libPath "/" catFile))
          when( catPort 
            while( gets( nextLine catPort ) 
              rexCompile("^\\(.*\\) type=\\\"cell\\\"")
              when( rexExecute(nextLine)
                cellLine = rexSubstitute("\\1")
                cellName = car(last(parseString(cellLine "/")))
                when( ddGetObj(lib cellName "schematic") &&  ddGetObj(lib cellName "layout")
                  catCells[libCat] = append1(catCells[libCat] cellName)
                )
              ); when cell
            ); while catPort 
            close( catPort ) 
          ); when catPort
        ); if top category
        catCells[libCat] = sort( catCells[libCat] nil )
      ); foreach catFile
    else
      cat = "Everything"
      libCat = strcat(lib ":" cat)
      libCats[lib] = append1(libCats[lib] cat)
      catCells[libCat] = list()
      catCells[libCat] = ddGetObj(lib)->cells~>name
    ); if no cats exist
    libCats[lib] = sort( libCats[lib] nil )
    libCats[lib] = append1( remd("Everything" libCats[lib]) "Everything" )
    return( list( libCats catCells ))
  ); prog
); procedure qaLVS_getData

;-----------------------------
; Create CDL
;-----------------------------
procedure( qaLVS_createCDL( library cellName verifDir )
  prog( ( cdloutTemplateFile cdloutTemplatePort cdlCid )

    ; create cdl
    ; ++++++++++++++++++++++++++++++++++++++++++++++++++
    ; create cdlout template file
    cdloutTemplateFile = strcat( verifDir "/cdlout." cellName ".template")
    cdloutTemplatePort = outfile( cdloutTemplateFile )
    fprintf( cdloutTemplatePort 
"simLibName = \"%s\"\n
simCellName = \"%s\"\n
simViewName = \"schematic\"\n
simSimulator = \"auCdl\"\n
simNotIncremental = 'nil\n
simReNetlistAll = 't\n
simViewList = '(\"auCdl\" \"schematic\")\n
simStopList = '(\"auCdl\")\n
hnlNetlistFileName = \"%s.cdl\"\n
resistorModel = \"\"\n
shortRES = 0.0\n
preserveRES = 't\n
checkRESVAL = 't\n
checkRESSIZE = 'nil\n
preserveCAP = 't\n
checkCAPVAL = 't\n
checkCAPAREA = 'nil\n
checkCAPPERI = 'nil\n
preserveDIO = 't\n
checkDIOAREA = 't\n
checkDIOPERI = 't\n
simPrintInhConnAttributes = 'nil\n
checkScale = \"micron\"\n
checkLDD = 'nil\n
pinMAP = 'nil\n
shrinkFACTOR = 0.0\n
displayPININFO = 't\n
preserveALL = 't\n
setEQUIV = \"\"\n
incFILE = \"\"\n
auCdlDefNetlistProc = \"ansCdlSubcktCall\"\n
simRunDir = \".\"\n" 
      library cellName cellName
    )
    close( cdloutTemplatePort )

    if( isFile( "si.env" ) then sh( "rm -f si.env" ) )
    if( isFile( ".running" ) then sh( "rm -f .running" ) )
    sh( strcat( "ln -s " cdloutTemplateFile " si.env" ) )  

    ; export CDL
    printf( "QA LVS: Exporting CDL file for %s" cellName )
    printf( "..." )
    unless( cdlCid = ipcBatchProcess( "si -batch -command netlist" "" strcat( verifDir "/" cellName ".cdlOut.log") )
      warn( "QA LVS: ** ERROR:  %s CDL export failed.\n" cellName )
    ); end unless cdlCid
    ipcWaitForProcess( cdlCid )
    ipcWait( cdlCid )
    printf( "completed\n" )
    sh( strcat( "mv -f " cellName ".cdl " verifDir ) )  

  ); end prog
); end procedure qaLVS_createCDL

;-----------------------------
; Create GDS
;-----------------------------
procedure( qaLVS_createGDS( library cellName verifDir )
  prog( ( gdsoutTemplateFile gdsoutTemplatePort gdsCid temp )

    ; create gds
    ; ++++++++++++++++++++++++++++++++++++++++++++++++++
    gdsoutTemplateFile = strcat( verifDir "/strmout." cellName ".template")
    gdsoutTemplatePort = outfile( gdsoutTemplateFile )
    fprintf( gdsoutTemplatePort 
"runDir                             \"%s\"\n
library                            \"%s\"\n
topCell                            \"%s\"\n
view                               \"layout\"\n
strmFile                           \"%s.gds\"\n
logFile                            \"%s.strmOut.log\"\n
strmTextNS                         \"cdba\"\n
case                               \"preserve\"\n
#cellListFile                       \"\"\n
#cellMap                            \"\"\n
#cellNamePrefix                     \"\"\n
#cellNameSuffix                     \"\"\n
convertDot                         \"node\"\n
convertPcellPin                    \"geometry\"\n
#convertPin                         \"geometryAndText\"\n
#fontMap                            \"\"\n
#hierDepth                          \"32767\"\n
labelCase                          \"preserve\"\n
#labelDepth                         \"1\"\n
labelMap                           \"\"\n
#maxVertices                        \"200\"\n
#noInfo                             \"\"\n
#noOutputUnplacedInst\n
#noWarn                             \"\"\n
#objectMap                          \"\"\n
outputDir                          \"%s\"\n
#pinAttNum                          \"\"\n
#propMap                            \"\"\n
#refLibList                         \"\"\n
#strmVersion                        \"5\"\n
#subMasterSeparator                 \"_CDNS_\"\n
summaryFile                        \"%s.strmOut.summary\"\n
#techLib                            \"\"\n
#userSkillFile                      \"\"\n
#viaMap                             \"\"\n
#warnToErr                          \"\"\n"
      verifDir library cellName cellName cellName verifDir cellName
    )
    close( gdsoutTemplatePort )

    ; export GDS
    temp = strcat( "strmout -templateFile " gdsoutTemplateFile )
    printf("QA LVS: Exporting GDS file for %s" cellName )
    printf( "..." )
    unless( gdsCid = ipcBatchProcess( temp "" strcat( verifDir "/" cellName ".strmOut.log") )
      warn( "QA LVS: ** ERROR:  %s GDS export failed.\n" cellName )
    ); end unless gdsCid
    ipcWaitForProcess( gdsCid )
    ;printf( "(process %L)... " gdsCid )
    ipcWait( gdsCid )
    printf( "completed.\n" )

  ); end prog
); end procedure qaLVS_createGDS

;-----------------------------
; Create Calibre Header file
;-----------------------------
procedure( qaLVS_createCALheader( cellName verifDir calLVSdeck)
  let( (ruleFile rulePort)
    ruleFile = sprintf(nil "%s/cal.header.rul" verifDir )
    rulePort = outfile(ruleFile)
    fprintf( rulePort
"// +++ CUSTOMIZATION SETTINGS START +++\n
\n
#undefine \"SKIP_CHECK_DNWELL_DIODE_PARAMETERS\"\n
\n
// +++ CUSTOMIZATION SETTINGS END +++\n
\n
LAYOUT PATH  \"%s.gds\"\n
LAYOUT PRIMARY \"%s\"\n
LAYOUT SYSTEM GDSII\n
\n
SOURCE PATH \"%s.cdl\"\n
SOURCE PRIMARY \"%s\"\n
SOURCE SYSTEM SPICE\n
\n
MASK SVDB DIRECTORY \"svdb\" QUERY XRC CCI NOPINLOC IXF NXF SLPH\n
\n
LVS REPORT \"%s.lvs.report\"\n
\n
LVS REPORT OPTION NONE\n
LVS FILTER UNUSED OPTION NONE SOURCE\n
LVS FILTER UNUSED OPTION NONE LAYOUT\n
LVS REPORT MAXIMUM 50\n
\n
LVS RECOGNIZE GATES NONE\n
\n
LVS ABORT ON SOFTCHK NO\n
LVS ABORT ON SUPPLY ERROR YES\n
LVS IGNORE PORTS NO\n
LVS SHOW SEED PROMOTIONS NO\n
LVS SHOW SEED PROMOTIONS MAXIMUM 50\n
\n
LVS ISOLATE SHORTS NO\n
\n
VIRTUAL CONNECT COLON NO\n
VIRTUAL CONNECT REPORT YES UNSATISFIED\n
VIRTUAL CONNECT REPORT MAXIMUM ALL\n
VIRTUAL CONNECT NAME ?\n
\n
LVS EXECUTE ERC YES\n
ERC RESULTS DATABASE \"%s.erc.results\"\n
ERC SUMMARY REPORT \"%s.erc.summary\" REPLACE HIER\n
ERC CELL NAME YES CELL SPACE XFORM\n
ERC MAXIMUM RESULTS 1000\n
ERC MAXIMUM VERTEX 4096\n
\n
DRC ICSTATION YES\n
\n
INCLUDE \"%s\"\n"
    cellName cellName cellName cellName cellName cellName
    cellName calLVSdeck )

    close(rulePort)

  ); let
); procedure qaLVS_createCALheader

;-----------------------------
; Get LVS Match results
;-----------------------------
procedure( qaLVS_getResults( cellName verifDir runType )
  let( (resultsFile passCmd passResult failCmd failResult noRunCmd noRunResult
        lvsStatus resultsPort nextLine lvsError lvsErrors )

    lvsStatus = "N/A"
    lvsErrors = list()

    case( runType
      ("Calibre"
        resultsFile = strcat(verifDir "/" cellName ".lvs.report")
        if( isFile(resultsFile) then
          passCmd = sprintf(nil "grep -c '#     CORRECT     #' %s" resultsFile)
          passResult = evalstring(qaLVS_unixCmd(passCmd)) 
          failCmd = sprintf(nil "grep -c '#     INCORRECT     #' %s" resultsFile)
          failResult = evalstring(qaLVS_unixCmd(failCmd)) 
          noRunCmd = sprintf(nil "grep -c '#     NOT COMPARED     #' %s" resultsFile)
          noRunResult = evalstring(qaLVS_unixCmd(noRunCmd)) 
          if( noRunResult > 0 then
            lvsStatus = "** NOT COMPARED **"
          else
            cond(
              ( rexMatchp("_pass$" cellName) && passResult > 0 lvsStatus = "PASS" )
              ( rexMatchp("_pass$" cellName) && failResult > 0 lvsStatus = "FAIL" )
              ( rexMatchp("_fail$" cellName) && passResult > 0 lvsStatus = "FAIL" )
              ( rexMatchp("_fail$" cellName) && failResult > 0 lvsStatus = "PASS" )
              ( passResult > 0 lvsStatus = "CORRECT" )
              ( failResult > 0 lvsStatus = "INCORRECT" )
            ); cond
              resultsPort = infile(resultsFile)
              when( resultsPort 
                while( gets( nextLine resultsPort ) 
                  rexCompile("Error: +\\(.*\\) errors.")
                  when( rexExecute(nextLine)
                    lvsError = rexSubstitute("\\1")
                    unless( member(lvsError lvsErrors)
                      lvsErrors = append1(lvsErrors lvsError)
                    )
                  ); when error found
                ); while resultsPort 
                close( resultsPort ) 
              ); when resultsPort
          ); if noRunResult
        else
          lvsStatus = "** FAILED TO RUN **"
        ); if resultsFile
      )
      ("PVS"
        resultsFile = strcat(verifDir "/" cellName ".lvsrpt.cls")
        if( isFile(resultsFile) then
          passCmd = sprintf(nil "grep -c 'Run Result *: *MATCH' %s" resultsFile)
          passResult = evalstring( qaLVS_unixCmd(passCmd) ) 
          failCmd = sprintf(nil "grep -c 'Run Result *: *MISMATCH' %s" resultsFile)
          failResult = evalstring( qaLVS_unixCmd(failCmd) ) 
          cond(
            ( rexMatchp("_pass$" cellName) && passResult > 0 lvsStatus = "PASS" )
            ( rexMatchp("_pass$" cellName) && failResult > 0 lvsStatus = "FAIL" )
            ( rexMatchp("_fail$" cellName) && passResult > 0 lvsStatus = "FAIL" )
            ( rexMatchp("_fail$" cellName) && failResult > 0 lvsStatus = "PASS" )
            ( passResult > 0 lvsStatus = "MATCH" )
            ( failResult > 0 lvsStatus = "MISMATCH" )
          ); cond
          resultsPort = infile(resultsFile)
          when( resultsPort 
            while( gets( nextLine resultsPort ) 
              rexCompile("# *\\(.*\\) MISMATCHES")
              when( rexExecute(nextLine)
                lvsError = rexSubstitute("\\1")
                unless( member(lvsError lvsErrors)
                  lvsErrors = append1(lvsErrors lvsError)
                )
              ); when error found
            ); while resultsPort 
            close( resultsPort ) 
          ); when resultsPort
        else
          lvsStatus = "** FAILED TO RUN **"
        ); if resultFile
      )
    ); case runType

    list( lvsStatus lvsErrors )

  ); let
); procedure qaLVS_getResults

;-----------------------------
; Run UNIX command and return results
;-----------------------------
procedure( qaLVS_unixCmd( cmd )
  prog( (id out results)
    id = ipcBeginProcess(cmd)
    ipcWaitForProcess(id)
    out = ipcReadProcess(id 10)
    results = car(parseString(out "\n"))
    ipcKillProcess(id)
    return(results)
  ); prog
); procedure qaLVS_unixCmd

; qaLVS_formHelp
;----------------------------------------------------------------------
procedure( qaLVS_formHelp()

  hiDisplayAppDBox(
    ?name         'formHelp
    ?dboxBanner   "*** QA LVS Help ***" 
    ?dboxText     strcat( 
      "====================================================================================================\n"
      "\n"
      "This tool will run LVS on the cells within the library and category of your choosing then report back\n"
      "if the cells named \"*_pass\" and those named \"*_fail\" had the expected results.  If so, they will\n"
      "be listed as \"PASSED\".\n"
      "ex.\n"
      "If a pass cell has a clean lvs, it will report as passed.\n"
      "If a fail cell has a clean lvs, it will report as failed since it is not supposed to be clean.\n"
      "\n" 
      "====================================================================================================\n"
      "If none of this makes sense, just hit Cancel and slowly walk away, never to open this GUI again.\n"
      "\n"
    )
    ?dialogType   3
    ?dialogStyle  'modeless
    ?buttonLayout 'UserDefined
    ?buttons      list("Thanks!")
  ); end hiDisplayAppDBox
); end procedure qaLVS_formHelp

/*----------------------------------  EOF  -----------------------------------*/
