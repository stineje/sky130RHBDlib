procedure( PVSPreFormTrigger( runtype presetFile winId )

  let( (cv
        tmpName
        f)

    ;------------------------------------
    ;Get cellview information from window
    ;------------------------------------
    cv = winId~>cellView

    ;------------------------------
    ;Create a temporary preset file
    ;------------------------------
    tmpName = makeTempFileName( strcat( getTempDir() "/pvsXXXXXX") )
    f = outfile( tmpName )

    ;--------------------------------------------------------------------------- 
    ;Create the pertinent information for the PVS DRC or LVS Run Submission Form
    ;---------------------------------------------------------------------------
    fprintf(f "[ pvsgui.Run%s ]\n" runtype )
    if( runtype == "DRC"
    then
       fprintf(f "PvsConfigInput \"$PDK_HOME/PV/PVS/DRC/pvs_drcGuiConfig\" \n" )
       fprintf(f "PvsConfigOn \"TRUE\" \n" )
       fprintf(f "ReportLimit \"ALL\" \n" )
       fprintf(f "RunDir \"pvsrun_dir/drc\" \n" )
    );if
    if( runtype == "LVS"
    then
       fprintf(f "CreateQRCInput \"TRUE\" \n" )
       fprintf(f "PvsConfigInput \"$PDK_HOME/PV/PVS/LVS/pvs_lvsGuiConfig\" \n" )
       fprintf(f "PvsConfigOn \"TRUE\" \n" )
       fprintf(f "QRCDataDir \"svdb\" \n" )
       fprintf(f "RunDir \"pvsrun_dir/lvs\" \n" )
    );if
    fprintf(f "TechnologyLibPath \"$PDK_HOME/PV/PVS/pvtech.lib\" \n" )
    fprintf(f "TechnologyName \"s130\" \n" )
    fprintf(f "TechnologyRuleSet \"default\" \n" )

    ;-------------------------------
    ;Close the temporary preset file
    ;-------------------------------
    close(f)

    ;------------------------------
    ;Return name of the preset file
    ;------------------------------
    tmpName

  );let

);procedure