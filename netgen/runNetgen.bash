#!/bin/bash

netgen -batch lvs "../layout/ngspice/$1.spice $1" "../layout/xschem/spice/$1.spice $1" $PDK_ROOT/sky130A/libs.tech/netgen/sky130A_setup.tcl $1.out