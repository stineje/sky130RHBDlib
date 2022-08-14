#!/usr/bin/env wish
#---------------------------------------------
# Script to generate SPICE library from GDS   
#---------------------------------------------
drc off
locking off
gds readonly true
gds flatten true
gds rescale false
tech unlock *
# Set the GDS input style to sky130(vendor).  This treats labels on the
# TXT purpose (5) as pins, which is unfortunately done in a lot of the
# vendor GDS files.
cif istyle sky130(vendor)
gds read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/gds/sky130_ef_sc_hd__decap_12.gds
gds read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/gds/sky130_ef_sc_hd__fakediode_2.gds
gds read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/gds/sky130_ef_sc_hd__fill_4.gds
gds read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/gds/sky130_ef_sc_hd__fill_8.gds
gds read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/gds/sky130_ef_sc_hd__fill_12.gds
gds read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/gds/sky130_fd_sc_hd__a2111o_1.gds
gds read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/gds/sky130_fd_sc_hd__a2111oi_0.gds
gds read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/gds/sky130_fd_sc_hd__buf_16.gds
gds read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/gds/sky130_fd_sc_hd__clkdlybuf4s15_1.gds
gds read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/gds/sky130_fd_sc_hd__clkdlybuf4s18_1.gds
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_ef_sc_hd__decap_12.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_ef_sc_hd__fakediode_2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_ef_sc_hd__fill_8.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/lef/sky130_ef_sc_hd__fill_12.lef
load /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_sc_hd/gds/sky130_ef_sc_hd__decap_12
ext2spice lvs
ext2spice subcircuit top on
foreach cell [cellname list top] {
    load $cell
    puts stdout "Extracting cell $cell"
    extract all
    ext2spice
}
puts stdout "Done."
quit -noprompt
