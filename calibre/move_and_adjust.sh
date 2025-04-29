#!/bin/bash

# Copies all files that match the ring_oscilator_mpr pattern and moves them here.
cp ${NETLIST_DIR}/* ./

# Replaces all instances of the sky130 models that are used in magic with the generic NMOS and PMOS_HVT variants.
sed -i "s/sky130_fd_pr__nfet_01v8_lvt/NMOS_LVT/" *.spice && sed -i "s/sky130_fd_pr__pfet_01v8_hvt/PMOS_HVT/" *.spice

sed -i "s/sky130_fd_pr__nfet_01v8/NMOS/" *.spice && sed -i "s/sky130_fd_pr__pfet_01v8/PMOS/" *.spice

# Appends the NMOS and PMOS_HVT definitions to the end of each .spice file.
sed -i '$i\.subckt NMOS d g s b\n.ends\n\n\.subckt NMOS_LVT d g s b\n.ends\n\n\.subckt PMOS d g s b\n.ends\n\n\.subckt PMOS_HVT d g s b\n.ends' *.spice

# Changes the file extension from .spice to .spi
for file in *.spice; do
    echo "Adjusting $file"
    mv $file ${file%.*}.spice
done

# Adjust the device names to MN and MP respectively for the transistors.
python3 device_name_adjust.py
