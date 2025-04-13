onbreak {resume}

# create library
if [file exists work] {
    vdel -all
}
vlib work

## compile source files
vlog Half_Adder.sv Full_Adder.sv Adder.sv Adder_tb.sv

# start and run simulation
vsim -voptargs=+acc work.tb

view list
view wave

add wave -noupdate -divider -height 32 "Testbench"
add wave -binary -color gold    /tb/a
add wave -binary -color gold    /tb/b
add wave -binary -color gold    /tb/y

add wave -noupdate -divider -height 32 "Sequence Detector"
add wave -binary -color gold    /tb/a
add wave -binary -color gold    /tb/b
add wave -binary -color gold    /tb/y

-- Set Wave Output Items
TreeUpdate [SetDefaultTree]
WaveRestoreZoom {0 ps} {75 ns}
configure wave -namecolwidth 100
configure wave -valuecolwidth 100 
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 5
configure wave -childrowmargin 2

-- Run the Simulation
run 9999999999ns

