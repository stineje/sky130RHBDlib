#!/bin/bash
echo "Running sed script on spice files..."
sed -i -e 's/VPB/VDD/g' -e 's/VNB/GND/g' ../spice/*.spice
sed -i 's/ad=.* w=/w=/g' ../spice/*.spice
sed -i -e 's/w=600/w=3/g' -e 's/w=400/w=2/g' ../spice/*.spice
sed -i -e 's/l=30/l=0.15/g' ../spice/*.spice
sed -i 's/^.option scale=5000u//g' ../spice/*.spice
sed -i -e 's/sky130_fd_pr__nfet_01v8/nshort/g' -e 's/sky130_fd_pr__pfet_01v8/pshort/g' ../spice/*.spice
