###################################################################

# Created by write_sdc on Mon Mar 10 10:52:22 2025

###################################################################
set sdc_version 2.1

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_wire_load_mode top
set_driving_cell -lib_cell TMRDFFQX1 -pin Q [get_ports reset]
set_driving_cell -lib_cell TMRDFFQX1 -pin Q [get_ports start]
set_driving_cell -lib_cell TMRDFFQX1 -pin Q [get_ports error]
set_driving_cell -lib_cell TMRDFFQX1 -pin Q [get_ports op_type]
set_load -pin_load 0.0403555 [get_ports done]
set_load -pin_load 0.0403555 [get_ports load_rega]
set_load -pin_load 0.0403555 [get_ports load_regb]
set_load -pin_load 0.0403555 [get_ports load_regc]
set_load -pin_load 0.0403555 [get_ports load_regd]
set_load -pin_load 0.0403555 [get_ports load_regr]
set_load -pin_load 0.0403555 [get_ports load_regs]
set_load -pin_load 0.0403555 [get_ports {sel_muxa[2]}]
set_load -pin_load 0.0403555 [get_ports {sel_muxa[1]}]
set_load -pin_load 0.0403555 [get_ports {sel_muxa[0]}]
set_load -pin_load 0.0403555 [get_ports {sel_muxb[2]}]
set_load -pin_load 0.0403555 [get_ports {sel_muxb[1]}]
set_load -pin_load 0.0403555 [get_ports {sel_muxb[0]}]
set_load -pin_load 0.0403555 [get_ports sel_muxr]
set_max_fanout 6 [get_ports reset]
set_max_fanout 6 [get_ports start]
set_max_fanout 6 [get_ports error]
set_max_fanout 6 [get_ports op_type]
create_clock [get_ports clk]  -period 2  -waveform {0 1}
set_clock_uncertainty 0.2  [get_clocks clk]
set_propagated_clock [get_clocks clk]
set_input_delay -clock clk  -max 0  [get_ports reset]
set_input_delay -clock clk  -max 0  [get_ports start]
set_input_delay -clock clk  -max 0  [get_ports error]
set_input_delay -clock clk  -max 0  [get_ports op_type]
set_output_delay -clock clk  -max 0  [get_ports done]
set_output_delay -clock clk  -max 0  [get_ports load_rega]
set_output_delay -clock clk  -max 0  [get_ports load_regb]
set_output_delay -clock clk  -max 0  [get_ports load_regc]
set_output_delay -clock clk  -max 0  [get_ports load_regd]
set_output_delay -clock clk  -max 0  [get_ports load_regr]
set_output_delay -clock clk  -max 0  [get_ports load_regs]
set_output_delay -clock clk  -max 0  [get_ports {sel_muxa[2]}]
set_output_delay -clock clk  -max 0  [get_ports {sel_muxa[1]}]
set_output_delay -clock clk  -max 0  [get_ports {sel_muxa[0]}]
set_output_delay -clock clk  -max 0  [get_ports {sel_muxb[2]}]
set_output_delay -clock clk  -max 0  [get_ports {sel_muxb[1]}]
set_output_delay -clock clk  -max 0  [get_ports {sel_muxb[0]}]
set_output_delay -clock clk  -max 0  [get_ports sel_muxr]
