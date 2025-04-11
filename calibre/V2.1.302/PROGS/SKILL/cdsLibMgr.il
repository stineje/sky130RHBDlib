let((cdsLibMgrFile)

  ;; Run in CIW to get names of all menus and items
  ;; lmgrQueryNamedObjects() 

  lmgrCreateMenu("skyMainMenu" '(("label" "SkyWater")))
  lmgrCreateMenuItem( "skyLibCnS" "simple" '(("label" "Check And Save on Entire Library")
    ("callback" ("swLibCnS"))))
  lmgrAddMenuItems("skyMainMenu" "" '("skyLibCnS"))
  lmgrCreateMenuItem( "skyLibTrigCBs" "simple" '(("label" "Trigger Callbacks on Entire Library")
    ("callback" ("swLibTrig"))))
  lmgrAddMenuItems("skyMainMenu" "" '("skyLibTrigCBs"))
  if( getShellEnvVar("PDK_DEV") == "t" then
    lmgrCreateMenuItem( "skyQADRCItem" "simple" '(("label" "QA Libs: DRC") ("callback" ("laQADRCGUI"))))
    lmgrCreateMenuItem( "skyQALVSItem" "simple" '(("label" "QA Libs: LVS") ("callback" ("laQALVSGUI"))))
    lmgrCreateMenuItem( "skyQAPcellItem" "simple" '(("label" "S130 QA: Pcell Verification") ("callback" ("laQAPcellGUI"))))
    lmgrCreateMenuItem( "skyQASimItem" "simple" '(("label" "S130 QA: Pcell Simulator") ("callback" ("laQASIMGUI"))))
    lmgrCreateMenu( "skyDevMenu" '(("label" "Developer QA")))
    lmgrAddMenuItems("skyDevMenu" "" '("skyQADRCItem"))
    lmgrAddMenuItems("skyDevMenu" "" '("skyQALVSItem"))
    lmgrAddMenuItems("skyDevMenu" "" '("skyQAPcellItem"))
    lmgrAddMenuItems("skyDevMenu" "" '("skyQASimItem"))
    lmgrCreateMenuItem( "skySep" "separator" '())
    lmgrAddMenuItems("skyMainMenu" "" '("skySep"))
    lmgrAddMenuItems("skyMainMenu" "" '("skyDevMenu"))

    lmgrCreateMenuItem( "LACopyFastButton" "simple" '(("label" "Copy Fast...") ("callback" ("LACopyFastGUI"))))
    lmgrInsertMenuItems("editRenameButton" "CV" '("LACopyFastButton"))
  ); if 
  lmgrAddMenuItems("menuBar" "" '("skyMainMenu"))
  
  ;; load other cdsLibMgr.il files
  cond(

    ;;(getShellEnvVar("CDS_WORKAREA")
    ;;  cdsLibMgrFile = strcat(getShellEnvVar("CDS_WORKAREA") "/cdsLibMgr.il")
    ;;  if(isFile(cdsLibMgrFile) then
    ;;    load(cdsLibMgrFile)
    ;;  )
    ;;)

    ;;(getShellEnvVar("CDS_SEARCHDIR")
    ;;  cdsLibMgrFile = strcat(getShellEnvVar("CDS_SEARCHDIR") "/cdsLibMgr.il")
    ;;  if(isFile(cdsLibMgrFile) then
    ;;    load(cdsLibMgrFile)
    ;;  )
    ;;)

    ;;(getShellEnvVar("HOME")
    ;;  cdsLibMgrFile = strcat(getShellEnvVar("HOME") "/cdsLibMgr.il")
    ;;  if(isFile(cdsLibMgrFile) then
    ;;    load(cdsLibMgrFile)
    ;;  )
    ;;)

    ;;(getShellEnvVar("CDS_PROJECT")
    ;;  cdsLibMgrFile = strcat(getShellEnvVar("CDS_PROJECT") "/cdsLibMgr.il")
    ;;  if(isFile(cdsLibMgrFile) then
    ;;    load(cdsLibMgrFile)
    ;;  )
    ;;)

    (getShellEnvVar("CDS_SITE")
      cdsLibMgrFile = strcat(getShellEnvVar("CDS_SITE") "/cdsLibMgr.il")
      if(isFile(cdsLibMgrFile) then
        load(cdsLibMgrFile)
      )
    )

    (getShellEnvVar("CDS_INST_DIR")
      cdsLibMgrFile = strcat(getShellEnvVar("$CDS_INST_DIR") "/share/local/cdsLibMgr.il")
      if(isFile(cdsLibMgrFile) then
        load(cdsLibMgrFile)
      )
    )

  ) ; cond 
); let
