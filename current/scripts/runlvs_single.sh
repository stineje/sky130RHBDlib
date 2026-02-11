#!/bin/sh
CELL=$(basename "$1" .spice)

netgen-lvs -noc << EOF
lvs "$1 $CELL" "$2 $CELL" ./scripts/sky130A_setup.tcl $CELL.out
quit
EOF
