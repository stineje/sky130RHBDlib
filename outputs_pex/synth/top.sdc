###################################################################

# Created by write_sdc on Wed Nov 13 13:22:58 2024

###################################################################
set sdc_version 2.1

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_wire_load_mode top
set_driving_cell -lib_cell TMRDFFQX1 -pin Q [get_ports tck]
set_driving_cell -lib_cell TMRDFFQX1 -pin Q [get_ports tdi]
set_driving_cell -lib_cell TMRDFFQX1 -pin Q [get_ports tms]
set_driving_cell -lib_cell TMRDFFQX1 -pin Q [get_ports trst]
set_driving_cell -lib_cell TMRDFFQX1 -pin Q [get_ports sysclk]
set_driving_cell -lib_cell TMRDFFQX1 -pin Q [get_ports sys_reset]
set_load -pin_load 0.0403555 [get_ports tdo]
set_load -pin_load 0.0403555 [get_ports success]
set_load -pin_load 0.0403555 [get_ports fail]
set_max_fanout 6 [get_ports tck]
set_max_fanout 6 [get_ports tdi]
set_max_fanout 6 [get_ports tms]
set_max_fanout 6 [get_ports trst]
set_max_fanout 6 [get_ports sysclk]
set_max_fanout 6 [get_ports sys_reset]
create_clock -name vclk  -period 2  -waveform {0 1}
set_input_delay -clock vclk  -max 0  [get_ports tck]
set_input_delay -clock vclk  -max 0  [get_ports tdi]
set_input_delay -clock vclk  -max 0  [get_ports tms]
set_input_delay -clock vclk  -max 0  [get_ports trst]
set_input_delay -clock vclk  -max 0  [get_ports sysclk]
set_input_delay -clock vclk  -max 0  [get_ports sys_reset]
set_output_delay -clock vclk  -max 0  [get_ports tdo]
set_output_delay -clock vclk  -max 0  [get_ports success]
set_output_delay -clock vclk  -max 0  [get_ports fail]
