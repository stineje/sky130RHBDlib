procedure(laQADRCGUI(laMenuName laLib laCell laView laFile laCat)
  let((maxCoord centerCoord laLibName laLibNameLayout laCatName laCatNameLayout laRunType 
       laRunTypeLayout laCalibreRule laCalibreRuleButton laCalibreRuleLayout laPvsTechLib 
       laPvsTechLibButton laPvsTechLibLayout laPvsTech laPvsTechLayout laPvsRuleSet 
       laPvsRuleSetLayout laOutDir laOutButton laOutLayout laTopLayout lib) 

    ;; Center popups on screen
    maxCoord = hiGetMaxScreenCoords()
    centerCoord = list(xCoord(maxCoord)/2 yCoord(maxCoord)/2)
    hiSetDBoxDefaultLocation(centerCoord)
    hiSetFormPosition(centerCoord)

    if( (laLib == nil || laLib == "") then
      lib = nth(0 ddGetLibList())->name
    else
      lib = laLib 
    ); if
    
    laLibName =          hiCreateCyclicField( ?name 'libName
                                              ?prompt "Library Name"
                                              ?choices sort(mapcar(lambda(x car(x)->name) ddGetLibList()) nil)
                                              ?defValue lib
                                              ?callback "laUpdateCatList(qaDRC->libName->value qaDRC)")
    laLibNameLayout = hiCreateHorizontalBoxLayout('libNameLayout
                                                  ?items list(laLibName list('stretch_item 1)))
    laCatName =          hiCreateCyclicField( ?name 'catName
                                              ?choices laGetCatList(lib) 
                                              ?prompt "Category To Process")
    laCatNameLayout = hiCreateHorizontalBoxLayout('catNameLayout
                                                  ?items list(laCatName list('stretch_item 1)))
    laRunType =          hiCreateCyclicField( ?name 'runType
                                              ?choices list("calibre" "pvs") 
                                              ?callback 'laRunTypeCB
                                              ?prompt "Run Type")
    laRunTypeLayout = hiCreateHorizontalBoxLayout('runTypeLayout
                                                  ?items list(laRunType list('stretch_item 1)))
    laCalibreRule =      hiCreateStringField( ?name 'calibreRule
                                              ?prompt "Rule File"
                                              ?defValue strcat(getShellEnvVar("PDK_HOME") "/PV/Calibre/DRC/calibre_drc.rul") 
                                              ?editable t)
    laCalibreRuleButton =      hiCreateButton(?name 'calibreRuleButton
                                              ?buttonText "Select" 
                                              ?callback "laUpdateCalibreRule(qaDRC)")
    laCalibreRuleLayout = hiCreateHorizontalBoxLayout('calibreRuleLayout
                                                      ?items list(list(laCalibreRule 'stretch 1) laCalibreRuleButton))
    laPvsTechLib =      hiCreateStringField( ?name 'pvsTechLib
                                             ?prompt "Tech Lib File"
                                             ?defValue strcat(getWorkingDir() "/pvtech.lib") 
                                             ?callback "laUpdatePvsTable(qaDRC) laInitPvsFields(qaDRC)"
                                             ?editable t)
    laPvsTechLibButton =      hiCreateButton(?name 'pvsTechLibButton
                                             ?buttonText "Select" 
                                             ?callback "laUpdatePvsTechLib(qaDRC)")
    laPvsTechLibLayout = hiCreateHorizontalBoxLayout('pvsTechLibLayout
                                                     ?items list(list(laPvsTechLib 'stretch 1) laPvsTechLibButton)
                                                     ?invisible t)
    laPvsTech =          hiCreateCyclicField( ?name 'pvsTech
                                              ?choices list("") 
                                              ?callback "laUpdatePvsRuleSet(qaDRC)"
                                              ?prompt "Tech")
    laPvsTechLayout = hiCreateHorizontalBoxLayout('pvsTechLayout
                                                  ?items list(laPvsTech list('stretch_item 1))
                                                  ?invisible t)
    laPvsRuleSet =       hiCreateCyclicField( ?name 'pvsRuleSet
                                              ?choices list("") 
                                              ?prompt "Rule Set")
    laPvsRuleSetLayout = hiCreateHorizontalBoxLayout('pvsRuleSetLayout
                                                     ?items list(laPvsRuleSet list('stretch_item 1))
                                                     ?invisible t)
    laOutDir =           hiCreateStringField( ?name 'outDir
                                              ?prompt "Output Directory"
                                              ?defValue strcat("/sim/" getShellEnvVar("USER") "/qa_run")
                                              ?editable t)
    laOutButton =              hiCreateButton(?name 'outButton
                                              ?buttonText "Select" 
                                              ?callback "laUpdateOutDir(qaDRC)")
    laOutLayout = hiCreateHorizontalBoxLayout('outLayout
                                              ?items list(list(laOutDir 'stretch 1) laOutButton))
    laTopLayout =   hiCreateVerticalBoxLayout('topLayout
                                              ?items list(laLibNameLayout laCatNameLayout laRunTypeLayout laCalibreRuleLayout 
                                                          laPvsTechLibLayout laPvsTechLayout laPvsRuleSetLayout laOutLayout list('stretch_item 0)))
    hiCreateLayoutForm('qaDRC
                       "QA DRC"
                       laTopLayout 
                       ?unmapAfterCB t 
                       ?minSize 560:160
                       ?buttonLayout 'OKCancelApply
                       ?callback "laQADRC(qaDRC qaDRC->libName->value qaDRC->catName->value qaDRC->runType->value qaDRC->calibreRule->value qaDRC->pvsTechLib->value qaDRC->pvsTech->value qaDRC->pvsRuleSet->value qaDRC->outDir->value)")

    hiDisplayForm( qaDRC )
    hiSetFieldMinSize(qaDRC 'libName ?promptWidth 120)
    hiSetFieldMinSize(qaDRC 'catName ?promptWidth 120)
    hiSetFieldMinSize(qaDRC 'runType ?promptWidth 120)
    hiSetFieldMinSize(qaDRC 'calibreRule ?widgetWidth 350 ?promptWidth 120)
    hiSetFieldMinSize(qaDRC 'pvsTechLib ?widgetWidth 350 ?promptWidth 120)
    hiSetFieldMinSize(qaDRC 'pvsTech ?promptWidth 120)
    hiSetFieldMinSize(qaDRC 'pvsRuleSet ?promptWidth 120)
    hiSetFieldMinSize(qaDRC 'outDir ?widgetWidth 350 ?promptWidth 120)
    laUpdatePvsTable(qaDRC) 
    laInitPvsFields(qaDRC)
    t
  ); let
); procedure

procedure(laGetCatList(laLib)
  let((cats rtn)
    cats = ddCatGetLibCats(ddGetObj(laLib))
    if( cats == nil then
      rtn = list(" ") 
    else
      rtn = sort(cats nil)
    ); if 
    rtn
  ); let
); procedure

procedure(laUpdateCatList(laLib laForm)
  let((cats)
    cats = laGetCatList(laLib)
    laForm->catName->choices = cats 
    laForm->catName->value = nth(0 cats)
  ); let
); procedure

procedure(laUpdateOutDir(laForm)
  let((rtn)
    ;;workDir = laForm->outDir->value 
    ;;if( workDir == "" then
    ;;  workDir = "."
    ;;); if
    ;;rtn = hiGetExistingDirectory(?workingDir workDir)
    rtn = hiGetExistingDirectory(?workingDir ".")
    if( rtn then
      laForm->outDir->value = nth(0 rtn)
    ); if
  ); let
); procedure

procedure(laUpdateCalibreRule(laForm)
  let((rtn)
    ;;workDir = buildString(reverse(cdr(reverse(parseString(laForm->calibreRule->value "/")))) "/")
    ;;if( workDir == "" then
    ;;  workDir = "."
    ;;); if
    ;;rtn = hiGetExistingFile(?workingDir workDir)
    rtn = hiGetExistingFile(?workingDir ".")
    if( rtn then
      laForm->calibreRule->value = strcat(nth(0 rtn) "/" nth(1 rtn))
    ); if
  ); let
); procedure

procedure(laUpdatePvsTechLib(laForm)
  let((rtn)
    ;;workDir = buildString(reverse(cdr(reverse(parseString(laForm->pvsTechLib->value "/")))) "/")
    ;;if( workDir == "" then
    ;;  workDir = "."
    ;;); if
    ;;rtn = hiGetExistingFile(?workingDir workDir)
    rtn = hiGetExistingFile(?workingDir ".")
    if( rtn then
      laForm->pvsTechLib->value = strcat(nth(0 rtn) "/" nth(1 rtn))
    ); if
  ); let
); procedure

procedure(laUpdatePvsTable(laForm)
  let((pvtechScript tmpFile fh line tech ruleset pvsTechTable)
    pvtechScript = strcat(getShellEnvVar("PDK_HOME") "/PROGS/BASH/get_pvs_tech.sh")
    tmpFile = makeTempFileName("/tmp/qa_drc")

    system(strcat(pvtechScript " " laForm->pvsTechLib->value " " tmpFile))

    pvsTechTable = makeTable("pvsTechTable")

    fh = infile(tmpFile)

    while( not(isPortAtEOF(fh))
      line = mapcar('symbolToString lineread(fh))
      if( line != nil then
        tech = car(line)
        ruleset = cdr(line)

        if( setof(x ruleset (x == "default")) == nil then
          ruleset = cons("default" ruleset)
        ); if

        ruleset = sort(ruleset nil)
        
        pvsTechTable[tech] = ruleset
      ); if
    ); while

    laForm->pvsTechTable = pvsTechTable

    close(fh)

    system(strcat("rm -f " tmpFile))

  ); let
); procedure

procedure(laInitPvsFields(laForm)
  let((tech tech_val ruleset ruleset_val)
    if( laForm->pvsTechTable->? != nil then
      tech = sort(laForm->pvsTechTable->? nil)
      tech_val = nth(0 tech)
      laForm->pvsTech->choices = tech 
      laForm->pvsTech->value = tech_val 

      ruleset = laForm->pvsTechTable[tech_val] 
      ruleset_val = nth(0 ruleset)
      laForm->pvsRuleSet->choices = ruleset 
      laForm->pvsRuleSet->value = ruleset_val
    else
      laForm->pvsTech->choices = list("") 
      laForm->pvsTech->value = "" 
      laForm->pvsRuleSet->choices = list("") 
      laForm->pvsRuleSet->value = "" 
    ); if
  ); let
); procedure 

procedure(laUpdatePvsRuleSet(laForm)
  let((ruleset ruleset_val)
    if( laForm->pvsTechTable->? != nil then
      ruleset = laForm->pvsTechTable[laForm->pvsTech->value]
      ruleset_val = nth(0 ruleset)
      laForm->pvsRuleSet->choices = ruleset 
      laForm->pvsRuleSet->value = ruleset_val
    else
      laForm->pvsRuleSet->choices = list("") 
      laForm->pvsRuleSet->value = "" 
    ); if
  ); let
); procedure 

procedure(laRunTypeCB(laField laScope laItem)
  let(()
    if( laItem == "calibre" then
      laScope->pvsTechLibLayout->invisible = t 
      laScope->pvsTechLayout->invisible = t
      laScope->pvsRuleSetLayout->invisible = t 
      laScope->calibreRuleLayout->invisible = nil 
    else
      if( laItem == "pvs" then
        laScope->calibreRuleLayout->invisible = t
        laScope->pvsTechLibLayout->invisible = nil 
        laScope->pvsTechLayout->invisible = nil 
        laScope->pvsRuleSetLayout->invisible = nil 
      ); if
    ); if
  ); let
); procedure

procedure(laOpenFile(laFile)
  let((runCmd)
    if( ((editor == "vi") || (editor == "vim") || (editor == nil)) then
      runCmd = "xterm -e vi"
    else
      runCmd = editor
    ); end if
    system(strcat( runCmd " " laFile " &" ))
  ); let
); procedure

procedure(laQADRC(laForm laLibName laCatName laRunType laCalibreRule laPvsTechLib laPvsTech laPvsRuleSet laOutDir)
  let(()

    if( isDir(laOutDir) && (remove(".." remove("." getDirFiles(laOutDir))) != nil) then
      hiDisplayAppDBox(?name 'dirCheck 
                       ?dboxBanner "Warning" 
                       ?dboxText strcat("The directory\n" laOutDir "\nis not empty.\nAre you sure you want to overwrite it?")
                       ?callback list("laQADirWarnCB(laForm \"OK\" laLibName laCatName laRunType laCalibreRule laPvsTechLib laPvsTech laPvsRuleSet laOutDir)" "laQADirWarnCB(laForm \"Cancel\" laLibName laCatName laRunType laCalibreRule laPvsTechLib laPvsTech laPvsRuleSet laOutDir)")
                       ?dialogType hicWarningDialog 
                       ?dialogStyle 'modal
                       ?buttonLayout 'UserDefined 
                       ?buttons list("OK" "Cancel") 
                       ?defaultButton 2)
    else
      if( parseString(laOutDir) == nil then
        hiDisplayAppDBox(?name 'dirCheckEmpty 
                         ?dboxBanner "Warning" 
                         ?dboxText "The directory field is empty."
                         ?callback list("laQADirWarnCB(laForm \"Cancel\" laLibName laCatName laRunType laCalibreRule laPvsTechLib laPvsTech laPvsRuleSet laOutDir)")
                         ?dialogType hicWarningDialog 
                         ?dialogStyle 'modal
                         ?buttonLayout 'UserDefined 
                         ?buttons list("Cancel") 
                         ?defaultButton 1)
      else
        hiFormUnmap(laForm)
  
        laQARun(laLibName laCatName laRunType laCalibreRule laPvsTechLib laPvsTech laPvsRuleSet laOutDir t)

        hiSetCallbackStatus(laForm t)
      ); if
    ); if

  ); let
); procedure

procedure(laQADirWarnCB(laForm laButton laLibName laCatName laRunType laCalibreRule laPvsTechLib laPvsTech laPvsRuleSet laOutDir)
  let(()
    if( laButton == "OK" then
      hiFormUnmap(laForm)

      system(strcat("rm -rf " laOutDir "/* " laOutDir "/.* > /dev/null 2>&1"))
 
      laQARun(laLibName laCatName laRunType laCalibreRule laPvsTechLib laPvsTech laPvsRuleSet laOutDir t)

      hiSetCallbackStatus(laForm t)
    else
      hiSetCallbackStatus(laForm nil)
    ); if
  ); let
); procedure

procedure(laGetDRCErrors(laLib laCell laView)
  let((cv errorTable shape prop bBox loc rule res tfId mfgGrid)

    cv = dbOpenCellViewByType(laLib laCell laView "maskLayout" "r")
    errorTable = makeTable("errorTable")

    tfId = techGetTechFile(cv)
    mfgGrid = techGetMfgGridResolution(tfId)
    errorTable["_RESOLUTION"] = mfgGrid

    foreach( shape cv->shapes
      if( (shape->layerName == "annotate") && (shape->purpose == "drawing") then
        foreach( prop shape->prop
          if( prop->name == "drcError" then
            bBox = shape->bBox
            loc = centerBox(bBox)
            rule = prop->value

            if( leftEdge(bBox) > 0.0 then
              res = "PASS"
            else
              res = "FAIL"
            ); if

            if( errorTable[rule] != 'unbound then
              errorTable[rule] = cons(list(bBox res) errorTable[rule])
            else
              errorTable[rule] = list(list(bBox res))
            ); if
          ); if
        ); foreach
      ); if
    ); foreach

    errorTable
  ); let
); procedure

procedure(laQACancel(laVal)
  let(()
    if( laCurStep != (laTotalCells+1) then 
      printf("%s\n" "Cancelling QA Run")
      laProgressCancel = laVal 
    ); if
  ); let
); procedure

procedure(laQARun(laLibName laCatName laRunType laCalibreRule laPvsTechLib laPvsTech laPvsRuleSet laOutDir laGui)
  let((cat c cells totalCells cellFile fh errorTable workDir cdsFile gdsFile strmFile 
       resFile sumFile ruleFile defFile logFile scriptFile logParseFile outParseFile parseScript
       summaryScript finalSumFile)

    ;; Globals for progress gui: laTotalCells, laCurStep, laProgressCancel 

    parseScript = strcat(getShellEnvVar("PDK_HOME") "/PROGS/PYTHON/bin/parse_drc")
    summaryScript = strcat(getShellEnvVar("PDK_HOME") "/PROGS/BASH/qa_drc_get_res.sh")

    cat = ddCatOpen(ddGetObj(laLibName) laCatName "r")
    ddCatRefresh(cat)
    cells = list()
    foreach( val ddCatGetCatMembers(cat)
      if( nth(1 val) == "cell" then
        cells = xcons(cells nth(0 val))
      ); if
    ); foreach
    cells = reverse(cells)
    ddCatClose(cat)

    if( isDir(laOutDir) == nil then
      createDir(laOutDir)
    ); if

    if( laGui then
      laTotalCells = length(cells)
      totalCells = laTotalCells

      hiDisplayProgressBox(?name 'progBox
                           ?banner "QA DRC Progress"
                           ?text "Running QA DRC"
                           ?callback "laQACancel(t)"
                           ?totalSteps totalCells
                           ?autoClose nil)
    ); if

    system("sleep 1")

    laProgressCancel = nil

    if( laGui then
      laCurStep = 1 
      hiSetProgress(progBox 0)
    ); if

    foreach( c cells
      if( laProgressCancel == nil then
        if( laGui then
          hiSetProgressText(progBox c)
        ); if

        errorTable = laGetDRCErrors(laLibName c "layout")

        workDir = strcat(laOutDir "/" c)
        createDir(workDir)

        cdsFile = strcat(workDir "/" c ".cds.results")
        writeTable(cdsFile errorTable)

        gdsFile = strcat(workDir "/" c ".gds") 
        strmFile = strcat(workDir "/strmOut.log") 
        system(strcat("strmout -library '" laLibName "' -strmFile '" gdsFile "' -techLib 'S130' -topCell '" c "' -view 'layout' -logFile '" strmFile "' > /dev/null 2>&1"))

        resFile = strcat(workDir "/" c ".drc.results") 
        sumFile = strcat(workDir "/" c ".drc.summary") 
        ruleFile = strcat(workDir "/" c ".rule") 
        defFile = strcat(workDir "/" c ".def") 
        logFile = strcat(workDir "/" c ".drc.log") 
        scriptFile = strcat(workDir "/run") 
        logParseFile = strcat(workDir "/parse.log") 
        outParseFile = strcat(workDir "/parse.results") 
        fh = outfile(ruleFile "w") 
        if( laRunType == "calibre" then
          fprintf(fh strcat("LAYOUT PATH  \"" gdsFile "\"\n"))
          fprintf(fh strcat("LAYOUT PRIMARY \"" c "\"\n"))
          fprintf(fh "LAYOUT SYSTEM GDSII\n\n")
          fprintf(fh strcat("DRC RESULTS DATABASE \"" resFile "\" ASCII\n\n"))
          ;; May need if default changes
          ;;fprintf(fh "DRC CELL NAME NO\n")
          fprintf(fh strcat("DRC SUMMARY REPORT \"" sumFile "\" REPLACE\n\n"))
          fprintf(fh strcat("INCLUDE \"" laCalibreRule "\"\n"))
        else
          if( laRunType == "pvs" then
            fprintf(fh strcat("technology \"" laPvsTech "\" -ruleSet \"" laPvsRuleSet "\" -techLib \"" laPvsTechLib "\";\n"))
          ); if
        ); if
        drain(fh)
        close(fh)

        fh = outfile(scriptFile "w") 
        fprintf(fh "#!/usr/bin/bash\n\n")
        if( laRunType == "calibre" then
          fprintf(fh strcat("calibre -drc " ruleFile " &> " logFile "\n"))
        else
          if( laRunType == "pvs" then
            fprintf(fh strcat("pvs -drc -gds " gdsFile " -top_cell " c " -run_dir " workDir " -ascrdb " resFile " -log " logFile " " ruleFile "\n"))
          ); if
        ); if
        fprintf(fh strcat(parseScript " -i " resFile " -j " cdsFile " -o " outParseFile " -t " laRunType " &> " logParseFile "\n"))
        drain(fh)
        close(fh)
        system(strcat("chmod 775 " scriptFile))
        system(scriptFile)

        if( laGui then
          hiSetProgress(progBox laCurStep)

          laCurStep = laCurStep + 1
        ); if

      else
        if( laGui then
          hiSetProgressText(progBox "Terminating")
          hiSetProgress(progBox laTotalCells)
        ); if 
      ); if 
    ); foreach

    ;; collate results into summary
    if( laGui then
      hiSetProgressText(progBox "Collating Results")
    ); if 
    finalSumFile = strcat(laOutDir "/" "results.summary") 
    system(strcat(summaryScript " " laOutDir " " finalSumFile))

    if( laGui then
      hiSetProgressText(progBox "Complete")
     
      laOpenFile(finalSumFile)

      laTotalCells = 'unbound
      laCurStep = 'unbound
    ); if 

    laProgressCancel = 'unbound

  ); let
); procedure
