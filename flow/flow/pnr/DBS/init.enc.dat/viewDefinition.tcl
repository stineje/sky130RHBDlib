if {![namespace exists ::IMEX]} { namespace eval ::IMEX {} }
set ::IMEX::dataVar [file dirname [file normalize [info script]]]
set ::IMEX::libVar ${::IMEX::dataVar}/libs

create_library_set -name libs_tt\
   -timing\
    [list ${::IMEX::libVar}/mmmc/sky130_rhbd_tt_1P8_25C.ccs.lib]
create_rc_corner -name rc_typ\
   -preRoute_res 1\
   -postRoute_res 1\
   -preRoute_cap 1\
   -postRoute_cap 1\
   -postRoute_xcap 1\
   -preRoute_clkres 0\
   -preRoute_clkcap 0\
   -T 25
create_delay_corner -name corner_tt\
   -library_set libs_tt\
   -rc_corner rc_typ
create_constraint_mode -name setup_func_mode\
   -sdc_files\
    [list ${::IMEX::libVar}/mmmc/riscvsingle.sdc]
create_analysis_view -name hold_func -constraint_mode setup_func_mode -delay_corner corner_tt
create_analysis_view -name setup_func -constraint_mode setup_func_mode -delay_corner corner_tt
set_analysis_view -setup [list setup_func] -hold [list hold_func]
