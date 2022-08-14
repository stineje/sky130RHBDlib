onbreak {resume}

# create library
if [file exists work] {
    vdel -all
}
vlib work

## compile source files
vlog test_random_tb.sv

# start and run simulation
vsim -voptargs=+acc work.tb

view list
view wave

add wave -noupdate -divider -height 32 "Testbench"
add wave -binary -color #1aff00 /tb/clk
add wave -binary -color gold    /tb/d
add wave -binary -color gold    /tb/current_sequence

-- Set Wave Output Items
TreeUpdate [SetDefaultTree]
WaveRestoreZoom {0 ps} {75 ns}
configure wave -namecolwidth 200
configure wave -valuecolwidth 200 
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 5
configure wave -childrowmargin 2

-- Run the Simulation
run 9999999ns

