#!/bin/sh
rm -f final.gds
rm -f final_merged.gds
rm -f final.v
rm -rf make
make clean
rm -rf LOG DBS RPT
rm -rf innovus.cmd*
rm -rf innovus.log*
rm -rf checkDesign
rm -rf timingReports
rm -rf mult_pad_via_layer*
rm -f *.sdf
rm -f *.log
rm -f *gls*
rm -rf *rc_typ.spef*
rm -f *rc_*
rm -f *.def
rm -f *.spef
rm -f *.lef
rm -f streamOut.map
rm -f out.txt
rm -rf ./FF
