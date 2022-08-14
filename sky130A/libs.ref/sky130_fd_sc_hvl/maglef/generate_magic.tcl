#!/usr/bin/env wish
#--------------------------------------------
# Script to generate .mag files from .lef    
#--------------------------------------------
tech unlock *
lef datestamp 1645210163
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/lef/sky130_fd_sc_hvl.lef
puts stdout "Annotating cells from CDL/SPICE"
catch {readspice /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hvl/cdl/sky130_fd_sc_hvl.cdl}
load sky130_fd_sc_hvl__a21o_1
writeall force
puts stdout "Done."
quit -noprompt
