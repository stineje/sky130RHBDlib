/*************************************************************************
* DISCLAIMER: The following code is provided for Cadence customers       *
* to use at their own risk. The code may require modification to         *
* satisfy the requirements of any user. The code and any modifications   *
* to the code may not be compatible with current or future versions of   *
* Cadence products. THE CODE IS PROVIDED "AS IS" AND WITH NO WARRANTIES, *
* INCLUDING WITHOUT LIMITATION ANY EXPRESS WARRANTIES OR IMPLIED         *
* WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR USE.         *
*************************************************************************/

/* USAGE:

This SKILL code is capable of doing check and save on all schematics and
symbol views of a library. Load the code in CIW:

load "CCScheckAllSymAndSch.il"

RUn it on library mylib:
CCScheckAllSymAndSch("mylib")

The warning and error messages are thrown in check_log file in current working
directory and in CDS.log as well.

To check & save all schematics and symbols in "testlib" and remove markers:
CCScheckAllSymAndSch("testlib" t)

*/

procedure(CCScheckAllSymAndSch(libName @optional (deleteMarkers nil) "tg")
 let(((libId ddGetObj(libName)) cv markers check_result checked_saved lock_info myPort schno symno warno)
 myPort = outfile( "./check_save.log" )
 printf("\n\n\n****************************************************************\n")
 printf("* Check And Save Log created by script CCScheckAllSymAndSch.il *\n")
 printf("****************************************************************\n")
 printf("Processing library %L\n" libName)
 fprintf(myPort "****************************************************************\n")
 fprintf(myPort "* Check And Save Log created by script CCScheckAllSymAndSch.il *\n")
 fprintf(myPort "****************************************************************\n")
 fprintf(myPort "Processing library %L\n" libName)

 when(libId
 printf("\n\n****************************************************************\n")
 printf("* Processing All Schematics \n")
 printf("****************************************************************\n")
 fprintf(myPort "\n\n****************************************************************\n")
 fprintf(myPort "* Processing All Schematics \n")
 fprintf(myPort "****************************************************************\n")
 schno = 0
 
foreach(cell setof(sch libId~>cells member("schematic" sch~>views~>name))
 cv = dbOpenCellViewByType(libId cell~>name "schematic" "" "a")
 lock_info = geGetLockInfo( libName cell~>name "schematic" )
 checked_saved = !dbIsConnCurrent(cv)
 check_result = schCheck(cv)

 	if(and(checked_saved == nil or(check_result == nil cadr(check_result) == 0)) then
	 ;printf("Running Check & Save on Schematic %s/%s\t: " libName cell~>name)
	 ;printf("(Already Checked & Saved) Locked by %s\n" lock_info)
	 else
	 schno = schno + 1
	 printf("(SCHEMATIC - %d) Running Check & Save on Schematic %s/%s\t:\n " schno libName cell~>name)
	 fprintf(myPort "(SCHEMATIC - %d) Running Check & Save on Schematic %s/%s\t:\n " schno libName cell~>name)
	 printf("\t (Need to Check & Save) Locked by %s\n" lock_info)
	 fprintf(myPort "\t (Need to Check & Save) Locked by %s\n" lock_info)
 
		when(!dbIsConnCurrent(cv)
		 dbReopen(cv "a")

			 when(and(schCheck(cv) deleteMarkers)
			 printf("\t Cell \"%s\" \"%s\" \"schematic\" needs extracting\n" libName cell~>name)
			 fprintf(myPort "\t Cell \"%s\" \"%s\" \"schematic\" needs extracting\n" libName cell~>name)
			
			if(dbGetDatabaseType()=="CDBA"
			then
			markers = setof(lpp cv~>lpps and(lpp~>layerName=="marker" member(lpp~>purpose '("error" "warning"))))
				 foreach(type markers
					 foreach(shape type~>shapes
					 dbDeleteObject(shape)
						 )
 					)
				t
			else
			markers=setof(marker cv~>markers member(marker~>severity list("error" "warning")))
    			foreach(type markers
	      	;; delete marker of that marker type
      		dbDeleteObject(type)
	    			); foreach marker type (error or warning)
			t
			)
			)
			 dbSave(cv)
			 ) ; when

 	if(nth(1 schCheck(cv)) != 0 then
 	warno = 0
 		foreach(message cv~>markers~>msg
		 printf("\t: WARNING (%d) : %L\n" warno message)
		 fprintf(myPort "\t: WARNING (%d) : %L\n" warno message)
		 warno = warno + 1
 			)
 		)
	 )
 )

 printf("\n\n****************************************************************\n")
 printf("* Processing All Symbols \n")
 printf("****************************************************************\n")
 fprintf(myPort "\n\n****************************************************************\n")
 fprintf(myPort "* Processing All Symbols \n")
 fprintf(myPort "****************************************************************\n")
 symno = 0
 foreach(cell setof(sch libId~>cells member("symbol" sch~>views~>name))
 cv = dbOpenCellViewByType(libId cell~>name "symbol" "" "r")
 lock_info = geGetLockInfo( libName cell~>name "symbol" )
 checked_saved = !dbIsConnCurrent(cv)
 check_result = schVIC(cv)

 if(and(checked_saved == t or(check_result == nil nth(1 check_result) == 0)) then
 ;printf("Running Check & Save on Symbol %s/%s\t: " libName cell~>name)
 ;printf("(Already Checked & Saved) Locked by %s \n" lock_info)
 else

 if(and(checked_saved == t nth(1 check_result) != 0) then
 symno = symno + 1
 printf("(SYMBOL - %d) Running Check & Save on Symbol %s/%s\t: \n" symno libName cell~>name)
 fprintf(myPort "(SYMBOL - %d) Running Check & Save on Symbol %s/%s\t: \n" symno libName cell~>name)
 printf("\t (Already Checked & Saved with WARNINGS) Locked by %s \n" lock_info)
 fprintf(myPort "\t (Already Checked & Saved with WARNINGS) Locked by %s \n" lock_info)
	 if(nth(1 schVIC(cv)) != 0 then
 	warno = 0
	 foreach(message cv~>markers~>msg
	 printf("\t: WARNING (%d) : %L\n" warno message)
	 fprintf(myPort "\t: WARNING (%d) : %L\n" warno message)
 	warno = warno + 1
 			)
 		)
 else
 symno = symno + 1
 printf("(SYMBOL - %d) Running Check & Save on Symbol %s/%s\t: \n" symno libName cell~>name)
 fprintf(myPort "(SYMBOL - %d) Running Check & Save on Symbol %s/%s\t: \n" symno libName cell~>name)
 printf("\t (Need to Check & Save) Locked by %s \n" lock_info)
 fprintf(myPort "\t (Need to Check & Save) Locked by %s \n" lock_info)

	 when(!dbIsConnCurrent(cv)
	 dbReopen(cv "a")
		 when(and(check_result deleteMarkers)
		 printf("\t Cell \"%s\" \"%s\" \"symbol\" needs extracting\n" libName cell~>name)
		 fprintf(myPort "\t Cell \"%s\" \"%s\" \"symbol\" needs extracting\n" libName cell~>name)
			if(dbGetDatabaseType()=="CDBA"
			then
		 	markers = setof(lpp cv~>lpps and(lpp~>layerName=="marker" member(lpp~>purpose '("error" "warning"))))
			foreach(type markers
				 foreach(shape type~>shapes
					 dbDeleteObject(shape)
 					)
 				)
			t
			else
			 markers=setof(marker cv~>markers member(marker~>severity list("error" "warning")))
    			foreach(type markers
      		;; delete marker of that marker type
      		dbDeleteObject(type)
    				) ; foreach marker type (error or warning)
    			t
			)
			)
 		dbSave(cv)
		 )
 	)
 )
 )
 )
 printf("\n\n****************************************************************\n")
 printf("Processing library %L Done\n" libName)
 printf("****************************************************************\n\n")

 fprintf(myPort "\n\n****************************************************************\n")
 fprintf(myPort "\nProcessing library %L Done" libName)
 fprintf(myPort "****************************************************************\n\n")
 close(myPort)
	)
)
