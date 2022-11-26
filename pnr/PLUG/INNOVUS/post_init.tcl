####################################################################################
#                             POST-INIT PLUG-IN
####################################################################################
#
# This plug-in script is called after design import from the run_init.tcl script.
#
# --------------------------------------------------------------------------------
# Can be used for various floorplan related tasks, like:
#              - Die/core boundary
#              - placement of hard macros/blocks
#              - power domain size and clearence surrounding to it
#              - Placement and routing blockages in the floorplan
#              - IO ring creation
#              - PSO planning
# --------------------------------------------------------------------------------
# Specifically, this example includes tasks related to the LP/CPF foundation flow 
# including power domain modification and power shut-off planning. The examples 
# included here operate based on variables (vars array) defined in the 
# OVERLAY/lp_config.tcl file
#
if {[info exists vars(cpf_file)]} {

# --------------------------------------------------------------------------------
# Modify power domains
# --------------------------------------------------------------------------------
# The 'modify_power_domains' procedure is included with the foundation flows
# to help automate power domain modification.  To enable this, please set the
# appropriate variables in the lp_config.tcl and uncomment the following command
#

#	ff_modify_power_domains
    
# --------------------------------------------------------------------------------
# Power switch insertion
# --------------------------------------------------------------------------------
# The 'add_power_switches' procedure is included with the foundation flows
# to cover common power switch insertion scenarios.  To use, set the appropriate
# variables in the lp_config.tcl file and uncomment the following command.
# --------------------------------------------------------------------------------
# NOTE: This procedure  will NOT COVER THE ALL THE OPTIONS in addPowerSwitch
# For more complicated scenarios, please manually add the addPowerSwitch command
# here with the necessary options.
# --------------------------------------------------------------------------------

#	ff_add_power_switches

}

# Floorplan (from long time ago in a galaxy far, far away)
floorplan -r 1.0 0.55 10 10 10 10

# Make VDD/VSS power connectors
globalNetConnect GND -type pgpin -pin GND -inst * 
globalNetConnect VDD -type pgpin -pin VDD -inst * 
# Not sure I need this
#globalNetConnect VDD –type tiehi
#globalNetConnect VSS –type tielo

# Add Ring
setAddRingMode -ring_target default -extend_over_row 0 -ignore_rows 0 -avoid_short 0 -skip_crossing_trunks none -stacked_via_top_layer M2 -stacked_via_bottom_layer M1 -via_using_exact_crossover_size 1 -orthogonal_only true -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape }
addRing -nets {VDD GND} -type core_rings -follow core -layer {top M1 bottom M1 left M2 right M2} -width {top 1.6 bottom 1.6 left 1.6 right 1.6} -spacing {top 1.00 bottom 1.00 left 1.00 right 1.00} -offset {top 1.00 bottom 1.00 left 1.00 right 1.00} -center 0 -extend_corner {} -threshold 0 -jog_distance 0 -snap_wire_center_to_grid None
#
## Connect to power
setSrouteMode -viaConnectToShape { noshape }
sroute -connect { blockPin padPin padRing corePin floatingStripe } -layerChangeRange { M5(5) M1(1) } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } -allowJogging 1 -crossoverViaLayerRange { M1(1) M5(5) } -nets { VDD GND} -allowLayerChange 1 -blockPin useLef -targetViaLayerRange { M1(1) M5(5) }
#
