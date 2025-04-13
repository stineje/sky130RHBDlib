To run netgen, please use the following nomenclature:
```bash
netgen -batch lvs "../spice/inv.spice inv" "../xschem/inv.spice inv" $PDK_ROOT/sky130A/libs.tech/netgen/setup.tcl inv.out
```

Or this can be accomplished by running the runNetgen.bash script:
```bash
./runNetlist.bash inv
```

Keep in mind that the above script utilizes the top-level name in place of the "inv" name shown above if other circuits are desired.
