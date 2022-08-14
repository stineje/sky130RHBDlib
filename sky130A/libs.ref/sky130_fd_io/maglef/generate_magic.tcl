#!/usr/bin/env wish
#--------------------------------------------
# Script to generate .mag files from .lef    
#--------------------------------------------
tech unlock *
lef datestamp 1645210163
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_ef_io.lef
puts stdout "Annotating cells from CDL/SPICE"
catch {readspice /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/cdl/sky130_ef_io.cdl}
load sky130_fd_io__corner_bus_overlay
writeall force
puts stdout "Done."
quit -noprompt
