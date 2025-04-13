set rundir $env(PWD) 
set corner $env(CORNER)
set variant $env(VARIANT)
set area_file_path $env(AREA_FILE_PATH)

set outputfile $env(FILE_NAME) 
#set outputfile "sky130_rhbd.ccs"

### Define temperature and default voltage ###
set_operating_condition -voltage $env(VLTG) -temp $env(TEMP)

## Load template information for each cell ##
source ${rundir}/TEMPLATE/template_example.tcl

#set_var extsim_model_include $rundir/MODELS/include.sp
#define_leafcell -extsim_model -type nmos -pin_position {0 1 2 3} nshort
#define_leafcell -extsim_model -type pmos -pin_position {0 1 2 3} pshort

set_var parse_ignore_duplicate_subckt 1
#set_var voltage_map 1
#set_var pin_based_power 0
#set_var subtract_hidden_power 2
#set_var subtract_hidden_power_use_default 3
#set_var power_subtract_leakage 3

#set_var power_info 2
#set_var power_info_filename "power.log"


## Load Spice models and subckts ##
set spicefiles "$rundir/MODELS/include.scs"
foreach cell $cells {
    lappend spicefiles ${rundir}/NETLIST/${cell}.spi
}

read_spice -format spectre $spicefiles

# VTH0 variation
define_variation -type systematic  {snvth0  0.1} snvth0
define_variation -type random      {rnvth0  0.1} rnvth0

# Settings for the level-shifters:
# set_vdd vpb 1.8
set_vdd VDD 1.8
set_gnd GND 0.0
# set_gnd vnb 0.0

# set_vdd -attributes {related_bias_pin vpb direction input voltage_name VDD} VDD 1.8
# set_vdd -type nwell -attributes {physical_connection device_layer direction input voltage_name vpb} vpb 1.8
# set_gnd -attributes {related_bias_pin vnb direction input voltage_name VSS} VSS 0
# set_gnd -type pwell -attributes {physical_connection device_layer direction input voltage_name vnb} vnb 0

# Floating pins should be set to 0.0V with this line. Must be done before char_library in accordance
# to the manual on page 821. 
set_var floating_node_initialize_mode 1

##run variation ##
char_library $env(ARGS) -cells ${cells} -auto_index -auto_max_capacitance -thread 32

write_library -user_data ${area_file_path}/area_data.lib -overwrite $env(ARGS) $outputfile
#write_library -overwrite $env(ARGS) $outputfile

write_ldb ${rundir}/LDB/$outputfile.ldb

write_verilog ${rundir}/VERILOG/$outputfile.v

#write_template test.tcl

write_datasheet -format html -dir ${rundir}/DATASHEET/$outputfile $outputfile
write_datasheet -format ps -dir ${rundir}/DATASHEET/$outputfile $outputfile
set tmp1 ${rundir}/DATASHEET/$outputfile/$outputfile.ps
set tmp2 ${rundir}/DATASHEET/$outputfile/$outputfile.pdf
exec csh -c "cd ${rundir}/DATASHEET/$outputfile && setenv TEMP `pwd` && ps2pdf $tmp1 $tmp2 && mv *.pdf ../ && mv *.ps ../"
