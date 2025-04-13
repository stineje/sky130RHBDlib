# SDF extraction
write_sdf final.sdf
write_sdf -abstracted_model final_gls.sdf

# Save Netlist
saveNetlist -excludeLeafCell final.v

# Adding in metal fill.
setMetalFill -layer {li met1 met2 met3 met4 met5 rdl} -iterationName step1 -gapSpacing 0.140 -minWidth 1 -decrement 0.050 -minLength 2 -maxWidth 5 -maxLength 20 -activeSpacing 0.8 -windowSize 100 100 -windowStep 50 50 -minDensity 15 -maxDensity 60 -preferredDensity 20 -diagOffset 0.5 0.5
addMetalFill
# verifyMetalDensity

# Run DRC and Connection checks
verifyGeometry
verifyConnectivity -type all -noAntenna
verify_drc
verifyMetalDensity

#set_global report_timing_format {hpin cell slew delay arrival}
set_global report_timing_format {instance arc cell net fanout load slew delay incr_delay arrival required}
report_timing -net -max_paths 500 > $vars(rpt_dir)/timing.rpt
report_timing -net -max_paths 10 -nworst 1 > $vars(rpt_dir)/timing.critical.rpt
report_area > $vars(rpt_dir)/area.rpt

# Output GDSII
streamOut final.gds -mapFile streamOut.map -stripes 1 -units 1000 -mode ALL
#streamOut final_merged.gds -units 2000 -mode ALL -merge ../../../../lib/9t/gds/*
streamOut final_merged.gds -units 2000 -mode ALL -merge ../outputs_pex/sky130_rhbd/gds/*
defOut -floorplan -routing final.def
