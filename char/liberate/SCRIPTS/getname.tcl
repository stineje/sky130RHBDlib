#!/usr/bin/tclsh
puts "sky130_osu_sc_$env(VARIANT)_$env(CORNER)_[string map {. P} $env(VLTG)]_$env(TEMP)C[string map {- . " " ""} $env(ARGS)]"
