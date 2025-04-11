/* USAGE:

This SKILL code is capable of doing check and save on all schematics and
symbol views of a library. Load the code in CIW:

load "SWcheckAllSymAndSch.il"

RUn it on library mylib:
SWcheckAllSymAndSch("mylib")

The warning and error messages are thrown in check_log file in current working
directory and in CDS.log as well.

To check & save all schematics and symbols in "testlib" and remove markers:
SWcheckAllSymAndSch("testlib")

*/

procedure( SWcheckAllSymAndSch(libName @optional (deleteMarkers nil) "tg")
  let(((libId ddGetObj(libName)) cv markers lock_info locked myPort check
        symcheck schno symno warno)

    myPort = outfile( strcat("./check_save." libName ".log") )
    printf("\n\n\n****************************************************************\n")
    printf("* Check And Save Log created by script SWcheckAllSymAndSch.il *\n")
    printf("****************************************************************\n")
    printf("Processing library %L\n" libName)
    fprintf(myPort "****************************************************************\n")
    fprintf(myPort "* Check And Save Log created by script SWcheckAllSymAndSch.il *\n")
    fprintf(myPort "****************************************************************\n")
    fprintf(myPort "Processing library %L\n" libName)
    
    when( libId

      printf("\n\n****************************************************************\n")
      printf("* Processing All Schematics \n")
      printf("****************************************************************\n")
      fprintf(myPort "\n\n****************************************************************\n")
      fprintf(myPort "* Processing All Schematics \n")
      fprintf(myPort "****************************************************************\n")
      schno = 0
    
      foreach( cell sort(setof(sch libId~>cells member("schematic" sch~>views~>name))~>name nil)

        lock_info = parseString(geGetLockInfo(libName cell "schematic") ":| |\n")
        if( nth(0 lock_info) == "user" && nth(1 lock_info) != getShellEnvVar("USER") then
          locked = t
        else
          locked = nil
        )
        schno = schno + 1
        printf("(SCHEMATIC - %d) Evaluating Schematic %s/%s\n" schno libName cell)
        fprintf(myPort "(SCHEMATIC - %d) Evaluating Schematic %s/%s\n" schno libName cell)
        cv = dbOpenCellViewByType(libId cell "schematic" "" "r")
        getWarn()
        when( cv
          printf("\tChecking for updated instance symbols...\n")
          symcheck = nil
          foreach(hdr cv~>instHeaders
            when(hdr~>master~>modifiedCounter != hdr~>masterChangeCount
              symcheck = t
            ); when symbol is new
          ); foreach inst
          printf("\t")
          check = schCheck(cv)
          getWarn()
          when( !dbIsConnCurrent(cv) || cadr(check) != 0 || symcheck
            if( locked then
              warn("\tWARNING (Need to Check & Save) Locked by %s on %s\n" nth(1 lock_info) nth(3 lock_info))
              fprintf(myPort "\tWARNING (Need to Check & Save) Locked by %s on %s\n" nth(1 lock_info) nth(3 lock_info))
            else
              dbReopen(cv "a")
              getWarn()
              printf("\t(Need to Check & Save) Running Check & Save...\n")
              fprintf(myPort "\t(Need to Check & Save) Running Check & Save...\n")
              if(nth(1 check) != 0 then
                warno = 1
                foreach(message cv~>markers~>msg
                  printf("\t: WARNING (%d) : %L\n" warno message)
                  fprintf(myPort "\t: WARNING (%d) : %L\n" warno message)
                  warno = warno + 1
                )
              )
              if(dbGetDatabaseType()=="CDBA" then
                markers = setof(lpp cv~>lpps and(lpp~>layerName=="marker" member(lpp~>purpose '("error" "warning"))))
                foreach(type markers
                  foreach(shape type~>shapes
                    dbDeleteObject(shape)
                  )
                ); foreach marker type (error or warning)
                t
              else
                markers=setof(marker cv~>markers member(marker~>severity list("error" "warning")))
                foreach(type markers
                  ;; delete marker of that marker type
                  dbDeleteObject(type)
                ); foreach marker type (error or warning)
                t
              ); if CDBA
              dbSave(cv)
            ); if locked
          ); when not current
          dbPurge(cv)
        ); when cv
      ); foreach schematic cell
    
      printf("\n\n****************************************************************\n")
      printf("* Processing All Symbols \n")
      printf("****************************************************************\n")
      fprintf(myPort "\n\n****************************************************************\n")
      fprintf(myPort "* Processing All Symbols \n")
      fprintf(myPort "****************************************************************\n")
      symno = 0
    
      foreach( cell sort(setof(sym libId~>cells member("symbol" sym~>views~>name))~>name nil)

        lock_info = parseString(geGetLockInfo(libName cell "symbol") ":| |\n")
        if( nth(0 lock_info) == "user" && nth(1 lock_info) != getShellEnvVar("USER") then
          locked = t
        else
          locked = nil
        )
        symno = symno + 1
        printf("(SYMBOL - %d) Evaluating Schematic %s/%s\n" symno libName cell)
        fprintf(myPort "(SYMBOL - %d) Evaluating Schematic %s/%s\n" symno libName cell)
        cv = dbOpenCellViewByType(libId cell "symbol" "" "r")
        getWarn()
        when( cv
          printf("\t")
          check = schVIC(cv)
          getWarn()
          when( !dbIsConnCurrent(cv) || cadr(check) != 0
            if( locked then
              warn("\tWARNING (Need to Check & Save) Locked by %s on %s\n" nth(1 lock_info) nth(3 lock_info))
              fprintf(myPort "\tWARNING (Need to Check & Save) Locked by %s on %s\n" nth(1 lock_info) nth(3 lock_info))
            else
              dbReopen(cv "a")
              getWarn()
              printf("\t(Need to Check & Save) Running Check & Save...\n")
              fprintf(myPort "\t(Need to Check & Save) Running Check & Save...\n")
              if(nth(1 check) != 0 then
                warno = 1
                foreach(message cv~>markers~>msg
                  printf("\t: WARNING (%d) : %L\n" warno message)
                  fprintf(myPort "\t: WARNING (%d) : %L\n" warno message)
                  warno = warno + 1
                )
              )
              if(dbGetDatabaseType()=="CDBA" then
                markers = setof(lpp cv~>lpps and(lpp~>layerName=="marker" member(lpp~>purpose '("error" "warning"))))
                foreach(type markers
                  foreach(shape type~>shapes
                    dbDeleteObject(shape)
                  )
                ); foreach marker type (error or warning)
                t
              else
                markers=setof(marker cv~>markers member(marker~>severity list("error" "warning")))
                foreach(type markers
                  ;; delete marker of that marker type
                  dbDeleteObject(type)
                ); foreach marker type (error or warning)
                t
              ); if CDBA
              dbSave(cv)
            ); if locked
          ); when not current
          dbPurge(cv)
        ); when cv
      ); foreach symbol cell
    ); when libId

    printf("\n\n****************************************************************\n")
    printf("Processing library %L Done\n" libName)
    printf("****************************************************************\n\n")

    fprintf(myPort "\n\n****************************************************************\n")
    fprintf(myPort "\nProcessing library %L Done" libName)
    fprintf(myPort "****************************************************************\n\n")
    close(myPort)
  ); let
); procedure SWcheckAllSymAndSch

