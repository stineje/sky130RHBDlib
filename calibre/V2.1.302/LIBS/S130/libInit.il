unless( getShellEnvVar("libFlag")
    setShellEnvVar("libFlag=S130")

    info("..................... Initializing ......................\n\n")
    
    ;; load display.drf if does not exist in local workarea
    println("loading display file display.drf from S130 library")
    when( (! isFile("./display.drf"))
        displayFile = strcat(getShellEnvVar("PDK_HOME") "/LIBS/S130/display.drf")
        when( isFile(displayFile)
            if( errset(drLoadDrf(displayFile nil)) then
                info("Found display.drf\n")
               ; info("Loading %s \n\n" 
               ; strcat(getShellEnvVar("METAL_STACK") " display.drf"))
            else
                info("Failed to find display.drf\n\n")
            )
        ) 
    )
    
    
    ;; Set up snap grid
    envSetVal("layout" "xSnapSpacing" 'float 0.005)
    envSetVal("layout" "ySnapSpacing" 'float 0.005)


    ;; Set up the model files
    if( isContextLoaded("schView") then
      foreach( sim list( 'ams 'spectre )
        asiSetEnvOptionVal(asiGetTool(sim) "includePath"
          strcat( getShellEnvVar("PDK_HOME") "/MODELS/common/spectre"))
        asiSetEnvOptionVal(asiGetTool(sim) "modelFiles"
          list(
            list("models.all.scs" "tt")
            list("#;models.scs" "")
            list("#;parameters.scs" "fet_tt")
            list("#;parameters.scs" "res_nom")
            list("#;parameters.scs" "cap_nom")
          )
        )
      )
    )
    
    
    ;; Enable Layout XL generation from source number of fingers
    envSetVal("layoutXL" "mfactorNames" 'string "mult")
    
    
    ;; Remove default scale settings from ADE Options for simulation
    envSetVal("spectre.opts" "scale" 'string "")
    envSetVal("spectre.opts" "scalem" 'string "")
    
    
    ;; load SkyWater pull-down menu
    printf("Loading custom Skywater pulldown menu\n")
    load(strcat(getShellEnvVar("PDK_HOME") "/PROGS/SKILL/SkyWater.il"))


    info("\n")
    info("................ Initialization Complete ................\n\n")
)
myFileLocation=simplifyFilename(which(get_filename(piport)))

myList=reverse(parseString(myFileLocation "/"))

libName=cadr(myList)

printf("The file being loaded is %L\n" myFileLocation)

printf("The file being loaded from Library %L\n" libName)

;; Must be loaded outside of initialization as auCdl and Stream export acts outside of
;; the current Cadence session, and these are needed for those to succeed
;; load SkyWater Pcell techData and Callbacks
println("Loading Skywater's Pcell technical data & callbacks")
load(strcat(getShellEnvVar("PDK_HOME") "/PROGS/PCELLS/S130techData.il"))
load(strcat(getShellEnvVar("PDK_HOME") "/PROGS/PCELLS/S130pcellCBs.il"))

println("Exiting libInit.il")
