#!/usr/bin/env wish
#--------------------------------------------
# Script to generate .mag files from .gds    
#--------------------------------------------
crashbackups stop
drc off
locking off
gds datestamp 1645210163
gds readonly true
gds drccheck false
gds flatten true
gds rescale false
tech unlock *
# Set the GDS input style to sky130(vendor).  This treats labels on the
# TXT purpose (5) as pins, which is unfortunately done in a lot of the
# vendor GDS files.
cif istyle sky130(vendor)
gds read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_pr/gds/sky130_fd_pr.gds
set devlist {sky130_fd_pr__rf_npn_05v5_W1p00L1p00 sky130_fd_pr__rf_npn_05v5_W1p00L2p00 sky130_fd_pr__rf_pnp_05v5_W0p68L0p68 sky130_fd_pr__rf_pnp_05v5_W3p40L3p40 sky130_fd_pr__rf_test_coil1 sky130_fd_pr__rf_test_coil2 sky130_fd_pr__rf_test_coil3 sky130_fd_pr__cap_vpp_11p5x11p7_m1m2m3m4_shieldl1m5 sky130_fd_pr__cap_vpp_11p5x11p7_m1m2_noshield sky130_fd_pr__cap_vpp_08p6x07p8_m1m2_shieldl1 sky130_fd_pr__cap_vpp_04p4x04p6_m1m2_shieldl1}
set topcell [lindex [cellname list top] 0]
foreach cellname $devlist {
    load $cellname
    property gencell $cellname
    property parameter m=1
    property library sky130
}
load $topcell
puts stdout "Writing all magic database files"
writeall force
puts stdout "Done."
quit -noprompt
