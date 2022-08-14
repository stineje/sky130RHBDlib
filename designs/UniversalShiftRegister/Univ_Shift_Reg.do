# Title:    Univ_Shift_Reg.do
# Author:   ryan.ridley@okstate.edu
# Date:     
# Modified: 
# Purpose:  .do file script to simulate Univ_Shift_Reg_tb.sv

onbreak {resume}

# create library
if [file exists work] {
    vdel -all
}
vlib work

## compile source files
vlog Univ_Shift_Reg.sv Univ_Shift_Reg_tb.sv 

# start and run simulation
vsim -voptargs=+acc work.tb

view list
view wave

add wave -noupdate -divider -height 32 "Testbench"
add wave -binary -color blue /tb/d_vec
add wave -binary -color blue /tb/ctrl_vec
add wave -binary -color gold /tb/q_vec

add wave -binary -color orange /tb/clk
add wave -binary -color orange /tb/reset

add wave -noupdate -divider -height 32 "Univ_Shift_Reg"
add wave -binary -color blue /tb/dut/d
add wave -binary -color blue /tb/dut/ctrl

add wave -binary -color green /tb/dut/r_next
add wave -binary -color green /tb/dut/r_reg

add wave -binary -color gold /tb/dut/q

add wave -binary -color orange /tb/dut/clk
add wave -binary -color orange /tb/dut/reset

-- Set Wave Output Items
TreeUpdate [SetDefaultTree]
WaveRestoreZoom {0 ps} {75 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 150 
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 5
configure wave -childrowmargin 2

-- Run the Simulation
run 99999999ns

