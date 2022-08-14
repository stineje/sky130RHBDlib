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
# Special options passed to magic for GDS import of the I/O library cells.
# This line flattens all the cells containing "__example_" in the name,
# which includes all contacts and primitive devices.  This prevents the
# primitive devices from being split across the hierarchy, which causes
# magic to misinterpret the device type.
gds flatglob *__example_*
cif istyle sky130(vendor)
gds read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/gds/sky130_ef_io.gds
gds read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/gds/sky130_fd_io.gds
gds read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/gds/sky130_ef_io__analog.gds
gds read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/gds/sky130_ef_io__bare_pad.gds
gds read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/gds/sky130_ef_io__disconnect_vccd_slice_5um.gds
gds read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/gds/sky130_ef_io__connect_vcchib_vccd_and_vswitch_vddio_slice_20um.gds
gds read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/gds/sky130_ef_io__gpiov2_pad_wrapped.gds
gds read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/gds/sky130_ef_io__disconnect_vdda_slice_5um.gds
puts stdout "Annotating cells from LEF"
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vssd_hvc.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vssd_lvc.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__top_ground_lvc_wpad.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vdda_lvc.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__top_power_lvc_wpad.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vdda_hvc.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_gpiov2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__top_gpio_ovtv2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vccd_hvc.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__top_xres4v2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__corner_bus_overlay.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vccd_lvc.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vssa_hvc.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__top_power_hvc_wpad.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vddio_hvc.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vssio_hvc.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__top_ground_hvc_wpad.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vssa_lvc.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vddio_lvc.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__top_gpiov2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vssio_lvc.lef
puts stdout "Annotating cells from CDL/SPICE"
catch {readspice /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/cdl/sky130_ef_io.cdl}
puts stdout "Writing all magic database files"
writeall force
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vssd_hvc.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vssd_lvc.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__top_ground_lvc_wpad.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vdda_lvc.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__top_power_lvc_wpad.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vdda_hvc.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_gpiov2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__top_gpio_ovtv2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vccd_hvc.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__top_xres4v2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__corner_bus_overlay.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vccd_lvc.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vssa_hvc.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__top_power_hvc_wpad.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vddio_hvc.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vssio_hvc.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__top_ground_hvc_wpad.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vssa_lvc.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vddio_lvc.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__top_gpiov2.lef
lef read /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vssio_lvc.lef
if {[cellname list exists sky130_fd_io__overlay_vssd_hvc] != 0} {
   load sky130_fd_io__overlay_vssd_hvc
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vssd_hvc -hide
}
if {[cellname list exists sky130_fd_io__overlay_vssd_lvc] != 0} {
   load sky130_fd_io__overlay_vssd_lvc
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vssd_lvc -hide
}
if {[cellname list exists sky130_fd_io__top_ground_lvc_wpad] != 0} {
   load sky130_fd_io__top_ground_lvc_wpad
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__top_ground_lvc_wpad -hide
}
if {[cellname list exists sky130_fd_io__overlay_vdda_lvc] != 0} {
   load sky130_fd_io__overlay_vdda_lvc
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vdda_lvc -hide
}
if {[cellname list exists sky130_fd_io__top_power_lvc_wpad] != 0} {
   load sky130_fd_io__top_power_lvc_wpad
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__top_power_lvc_wpad -hide
}
if {[cellname list exists sky130_fd_io__overlay_vdda_hvc] != 0} {
   load sky130_fd_io__overlay_vdda_hvc
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vdda_hvc -hide
}
if {[cellname list exists sky130_fd_io__overlay_gpiov2] != 0} {
   load sky130_fd_io__overlay_gpiov2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_gpiov2 -hide
}
if {[cellname list exists sky130_fd_io__top_gpio_ovtv2] != 0} {
   load sky130_fd_io__top_gpio_ovtv2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__top_gpio_ovtv2 -hide
}
if {[cellname list exists sky130_fd_io__overlay_vccd_hvc] != 0} {
   load sky130_fd_io__overlay_vccd_hvc
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vccd_hvc -hide
}
if {[cellname list exists sky130_fd_io__top_xres4v2] != 0} {
   load sky130_fd_io__top_xres4v2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__top_xres4v2 -hide
}
if {[cellname list exists sky130_fd_io__corner_bus_overlay] != 0} {
   load sky130_fd_io__corner_bus_overlay
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__corner_bus_overlay -hide
}
if {[cellname list exists sky130_fd_io__overlay_vccd_lvc] != 0} {
   load sky130_fd_io__overlay_vccd_lvc
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vccd_lvc -hide
}
if {[cellname list exists sky130_fd_io__overlay_vssa_hvc] != 0} {
   load sky130_fd_io__overlay_vssa_hvc
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vssa_hvc -hide
}
if {[cellname list exists sky130_fd_io__top_power_hvc_wpad] != 0} {
   load sky130_fd_io__top_power_hvc_wpad
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__top_power_hvc_wpad -hide
}
if {[cellname list exists sky130_fd_io__overlay_vddio_hvc] != 0} {
   load sky130_fd_io__overlay_vddio_hvc
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vddio_hvc -hide
}
if {[cellname list exists sky130_fd_io__overlay_vssio_hvc] != 0} {
   load sky130_fd_io__overlay_vssio_hvc
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vssio_hvc -hide
}
if {[cellname list exists sky130_fd_io__top_ground_hvc_wpad] != 0} {
   load sky130_fd_io__top_ground_hvc_wpad
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__top_ground_hvc_wpad -hide
}
if {[cellname list exists sky130_fd_io__overlay_vssa_lvc] != 0} {
   load sky130_fd_io__overlay_vssa_lvc
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vssa_lvc -hide
}
if {[cellname list exists sky130_fd_io__overlay_vddio_lvc] != 0} {
   load sky130_fd_io__overlay_vddio_lvc
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vddio_lvc -hide
}
if {[cellname list exists sky130_fd_io__top_gpiov2] != 0} {
   load sky130_fd_io__top_gpiov2
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__top_gpiov2 -hide
}
if {[cellname list exists sky130_fd_io__overlay_vssio_lvc] != 0} {
   load sky130_fd_io__overlay_vssio_lvc
   lef write /home/rjridle/open_pdks/sky130/sky130A/libs.ref/sky130_fd_io/lef/sky130_fd_io__overlay_vssio_lvc -hide
}
puts stdout "Done."
quit -noprompt
