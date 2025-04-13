#!/usr/bin/tclsh
puts "sky130_fd_sc_rh_$env(CORNER)_[string map {. P} $env(VLTG)]_$env(TEMP)C[string map {- . " " ""} $env(ARGS)]"
