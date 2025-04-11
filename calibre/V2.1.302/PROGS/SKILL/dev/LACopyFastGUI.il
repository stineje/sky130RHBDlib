procedure(LACopyFastGUI(laMenuName laLib laCell laView laFile laCat)
  let((maxCoord centerCoord isCell
       laFromFrame laFromLibName laFromCellName laFromViewName 
       laToFrame laToLibName laToCellName laToViewName laNote laNote2
       laTopLayout)

    ;; Center popups on screen
    maxCoord = hiGetMaxScreenCoords()
    centerCoord = list(xCoord(maxCoord)/2 yCoord(maxCoord)/2)
    hiSetDBoxDefaultLocation(centerCoord)
    hiSetFormPosition(centerCoord)

    if( (laView == nil || laView == "") then
      isCell = t 
      view = ""
    else
      isCell = nil 
      view = laView 
    ); if


    laFromFrame =           hiCreateFrameField( ?name 'fromFrame
                                                ?labelText "From")

    laFromLibName =        hiCreateCyclicField( ?name 'fromLibName
                                                ?prompt "Lib"
                                                ?choices sort(mapcar(lambda(x car(x)->name) ddGetLibList()) nil)
                                                ?defValue laLib
                                                ?enabled nil)

    laFromCellName =       hiCreateStringField( ?name 'fromCellName
                                                ?prompt "Cell"
                                                ?defValue laCell 
                                                ?editable nil)

    laFromViewName =       hiCreateStringField( ?name 'fromViewName
                                                ?prompt "View"
                                                ?defValue view
                                                ?editable nil
                                                ?invisible isCell)

    laToFrame =             hiCreateFrameField( ?name 'toFrame
                                                ?labelText "To")

    laToLibName =          hiCreateCyclicField( ?name 'toLibName
                                                ?prompt "Lib"
                                                ?choices sort(mapcar(lambda(x car(x)->name) ddGetLibList()) nil)
                                                ?defValue laLib)

    laToCellName =         hiCreateStringField( ?name 'toCellName
                                                ?prompt "Cell"
                                                ?defValue laCell)

    laToViewName =         hiCreateStringField( ?name 'toViewName
                                                ?prompt "View"
                                                ?defValue view
                                                ?invisible isCell)

    laNote =                hiCreateFrameField( ?name 'note
                                                ?labelText "NOTE: This will ssh to linear-asics-002 and perform the copy.")

    laNote2 =               hiCreateLabel( ?name 'note2
                                           ?labelText "Local libs cannot be copied from/to.")

    hiCreateAppForm( ?name 'LACopyFastForm
                     ?formTitle "Copy Fast"
                     ?fields list( list(laFromFrame       10:0 500:4*30 40)
                                   list(laFromLibName     20:10 480:30 40)
                                   list(laFromCellName    20:40 480:30 40)
                                   list(laFromViewName    20:70 480:30 40)
                                   list(laToFrame         10:120 500:4*30 40)
                                   list(laToLibName       20:130 480:30 40)
                                   list(laToCellName      20:160 480:30 40)
                                   list(laToViewName      20:190 480:30 40)
                                   list(laNote            10:250 500:2*30 40)
                                   list(laNote2           20:270 480:30 40))
                     ?initialSize 520:520
                     ?dontBlock t
                     ?unmapAfterCB t
                     ?buttonLayout 'OKCancel
                     ?callback "LACopyFast(LACopyFastForm->fromLibName->value LACopyFastForm->fromCellName->value LACopyFastForm->fromViewName->value
                                           LACopyFastForm->toLibName->value LACopyFastForm->toCellName->value LACopyFastForm->toViewName->value)")

    hiDisplayForm( LACopyFastForm )

  ); let
); procedure

procedure(LACopyFast(laFromLibName laFromCellName laFromViewName laToLibName laToCellName laToViewName)
  let((fromObj toObj toLibPath toPath cid)
    if( (laFromLibName == laToLibName) && (laFromCellName == laToCellName) && (laFromViewName == laToViewName) then
      hiDisplayAppDBox(?name 'LAWarnSame
                       ?dboxBanner "Warning"
                       ?dboxText "The From and To fields are the same."
                       ?dialogType hicWarningDialog
                       ?dialogStyle 'modal
                       ?buttonLayout 'UserDefined
                       ?buttons list("Cancel")
                       ?defaultButton 1)
    else
      fromObj = ddGetObj(laFromLibName laFromCellName laFromViewName)
      toObj = ddGetObj(laToLibName laToCellName laToViewName)
      if( toObj != nil then
        hiDisplayAppDBox(?name 'LAWarnExists
                         ?dboxBanner "Warning"
                         ?dboxText "The To cell or view exists."
                         ?dialogType hicWarningDialog
                         ?dialogStyle 'modal
                         ?buttonLayout 'UserDefined
                         ?buttons list("Cancel")
                         ?defaultButton 1)
      else
        toLibPath = ddGetObj(laToLibName)->readPath
        if( laToViewName == "" then
          toPath = strcat(toLibPath "/" laToCellName)
        else
          toPath = strcat(toLibPath "/" laToCellName "/" laToViewName)
        ); if

        cid = ipcBeginProcess(strcat("unset LD_LIBRARY_PATH; ssh -tt linear-asics-002 'cp -r " fromObj->readPath " " toPath "'"))
        ipcWait(cid)

        ddUpdateLibList()

      ); if
    ); if
  ); let
); procedure
