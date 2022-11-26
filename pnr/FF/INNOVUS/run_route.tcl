####################################################################
# Innovus Foundation Flow Code Generator, Wed Nov 16 13:37:24 CST 2022
# Version : 17.10-p003_1
####################################################################

if {[file exists FF/vars.tcl]} {
   source FF/vars.tcl
}
foreach file $vars(config_files) {
   source $file
}

source FF/procs.tcl
ff_procs::system_info
setDistributeHost -local
setMultiCpuUsage -localCpu 1

if {$vars(restore_design)} { restoreDesign DBS/place.enc.dat gcd }

um::enable_metrics -on
puts "<FF> Plugin -> always_source_tcl"

#-------------------------------------------------------------
set vars(step) route
set vars(route,start_time) [clock seconds]
um::push_snapshot_stack
#-------------------------------------------------------------

######################################################################
# Variables affecting this step:
#---------------------------------------------------------------------
# - vars(enable_cppr)
# - vars(track_opt)
# - vars(enable_si_aware)
# - vars(litho_driven_routing)
######################################################################
# Additional variables for this step:
#---------------------------------------------------------------------
# - vars(multi_cut_effort)
# - vars(antenna_diode)
######################################################################
# The active analysis views are controlled by the following variables:
#---------------------------------------------------------------------
# - vars(route,active_setup_views)
# - vars(route,active_hold_views)
#
######################################################################
# set_analysis_view -setup $vars(route,active_setup_views) -hold $vars(route,active_hold_views)
#
setAnalysisMode -cppr both
setDelayCalMode -siAware true -engine aae

setNanoRouteMode -routeWithLithoDriven false
setFillerMode -core "gf180mcu_osu_sc_9T_fill_2 fill16 gf180mcu_osu_sc_9T_fill_1 fill8 gf180mcu_osu_sc_9T_fill_16 fill4 fill2 gf180mcu_osu_sc_9T_fill_4 gf180mcu_osu_sc_9T_fill_8 fill1" \
   -corePrefix FILL
addFiller
Puts "<FF> RUNNING GLOBAL/DETAIL ROUTING ..."
puts "<FF> Plugin -> pre_route_tcl"
routeDesign
setExtractRCMode -engine postRoute
puts "<FF> Plugin -> post_route_tcl"
#-------------------------------------------------------------

um::pop_snapshot_stack
create_snapshot -name route -categories design
report_metric -file RPT/metrics.html -format html
saveDesign DBS/route.enc -compress
saveNetlist DBS/LEC/route.v.gz
if {[info exists env(VPATH)]} {exec /bin/touch $env(VPATH)/route}
ff_procs::report_time
puts "<FF> Plugin -> final_always_source_tcl"

if {![info exists vars(single)]} {
   exit 0
}

