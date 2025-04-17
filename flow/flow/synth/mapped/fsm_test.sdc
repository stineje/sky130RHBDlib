###################################################################

# Created by write_sdc on Thu Apr 17 12:17:37 2025

###################################################################
set sdc_version 2.1

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_wire_load_mode top
set_driving_cell -lib_cell TMRDFFQX1 -pin Q [get_ports reset]
set_driving_cell -lib_cell TMRDFFQX1 -pin Q [get_ports a]
set_load -pin_load 0.0403555 [get_ports y]
set_max_fanout 6 [get_ports reset]
set_max_fanout 6 [get_ports a]
create_clock [get_ports clk]  -period 2  -waveform {0 1}
set_clock_uncertainty 0.2  [get_clocks clk]
set_propagated_clock [get_clocks clk]
set_input_delay -clock clk  -max 0  [get_ports reset]
set_input_delay -clock clk  -max 0  [get_ports a]
set_output_delay -clock clk  -max 0  [get_ports y]
