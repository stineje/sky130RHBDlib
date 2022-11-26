create_rc_corner -name rc_typ -T 25
#------------------------------------------------
# Additional (unused) options ....
#------------------------------------------------
# -preRoute_res $vars(rc_typ,pre_route_res_factor)
# -preRoute_cap $vars(rc_typ,pre_route_cap_factor)
# -preRoute_clkres $vars(rc_typ,pre_route_clk_res_factor)
# -preRoute_clkcap $vars(rc_typ,pre_route_clk_cap_factor)
# -postRoute_res $vars(rc_typ,post_route_res_factor)
# -postRoute_cap $vars(rc_typ,post_route_cap_factor)
# -postRoute_res $vars(rc_typ,post_route_clk_res_factor)
# -postRoute_clkcap $vars(rc_typ,post_route_clk_cap_factor)
# -postRoute_xcap $vars(rc_typ,post_route_xcap_factor)
#------------------------------------------------
create_library_set -name libs_tt \
   -timing [list ../../char/techfiles//gf180mcu_9T_TT_3P3_25C.ccs.lib]
create_delay_corner -name corner_tt -library_set libs_tt -rc_corner rc_typ
create_constraint_mode -name setup_func_mode \
   -sdc_files [list /import/yukari1/lrburle/OSU_180/char/techfiles/gcd.sdc]
create_analysis_view -name hold_func \
   -constraint_mode setup_func_mode \
   -delay_corner corner_tt
create_analysis_view -name setup_func \
   -constraint_mode setup_func_mode \
   -delay_corner corner_tt

set_analysis_view -setup [list setup_func] -hold [list hold_func]

