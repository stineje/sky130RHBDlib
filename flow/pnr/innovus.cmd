#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Thu Apr 10 15:19:45 2025                
#                                                     
#######################################################

#@(#)CDS: Innovus v21.16-s078_1 (64bit) 12/07/2022 12:07 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: NanoRoute 21.16-s078_1 NR221206-1807/21_16-UB (database version 18.20.600) {superthreading v2.17}
#@(#)CDS: AAE 21.16-s035 (64bit) 12/07/2022 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: CTE 21.16-s024_1 () Dec  5 2022 05:41:45 ( )
#@(#)CDS: SYNTECH 21.16-s009_1 () Nov  9 2022 03:47:50 ( )
#@(#)CDS: CPE v21.16-s066
#@(#)CDS: IQuantus/TQuantus 21.1.1-s939 (64bit) Wed Nov 9 09:34:24 PST 2022 (Linux 3.10.0-693.el7.x86_64)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
getVersion
win
restoreDesign -noTiming DBS/signoff.enc.dat/ fsm
win
zoomBox 4.84400 34.72200 67.77800 90.88100
pan -2.12300 42.28500
panCenter 17.82200 81.57500
zoomBox -19.44600 40.26500 67.66100 117.99500
zoomBox -29.67400 35.77900 72.80500 127.22600
pan 24.85600 26.50800
setLayerPreference violation -isVisible 1
violationBrowser -all -no_display_false -displayByLayer
violationBrowserClose
zoomBox -27.43400 -20.72800 114.40600 105.84300
pan -1.84000 12.59300
panCenter 51.67300 57.27500
pan -5.51900 7.71800
