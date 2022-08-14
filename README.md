# Open Source Radation-Hardened Standard Cell Library

Completely open source system on chip design flow including radation hardened
standard cells for the open source SkyWater 130nm process.

This is currently a work in progress.

## Open Source EDA Tools

This design flow incorporates all open source tooling which allows anyone to go
from layout design, all the way through to place and route. This is only possible
due to the many people who have developed and continue to maintain these open
source tools. Below is a list of all the tools used in this project, and their
respective github repositories:

* [skywater-pdk](https://github.com/google/skywater-pdk): PDK
* [magic](https://github.com/RTimothyEdwards/magic): Layout, GDS, and LEF Generation
* [xschem](https://github.com/StefanSchippers/xschem): Schematic Generation
* [netgen](https://github.com/RTimothyEdwards/netgen): LVS
* [ngspice](https://github.com/ngspice/ngspice): SPICE Simulator (This repository
  hasn't been updated in 8 years. Better to download from their website
  [here](http://ngspice.sourceforge.net/)
* Liberty Generation: Still working on finding an open source option
* [OpenROAD-flow-scripts](https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts): Synthesis and PnR

## Installation

All the tools used in this repository are added as submodules. As of right now,
refer to each tools own installation guide. The end goal is to have a Makefile
that will build, install, and configure every tool to work with this repository.
Since most of the tools use a configuration file to setup paths, everything is
still functional if the template configuration files are copied to the right
directories. 

After installation of the tools has been done independantly, run the following:

```
git clone --recursive https://github.com/rjridle/OpenRadHardSCL.git
cd OpenRadHardSCL
cp .magicrc.template ~/.magicrc
cp .xschemrc.template ~/.xschem/xschemrc
```

**Hopefully** I haven't put in any absolute paths. If I have, that's my bad, go
ahead and fix that yourself and maybe let me know too. **Also hopefully**, all
the files needed for the SkyWater PDK are present and do not require going to
[skywater-pdk](https://github.com/google/skywater-pdk) to retrieve anything.
The decision not to make skywater-pdk a submodule and build it along with all
the other tools is because it includes several already design standard cell
libraries, and the installation is over 15G. All thats really needed from
skywater-pdk is the model files for the primitive devices. 

This is the current status of this project. Following are the things I'm hoping
to add here soon:

* Add more drive strengths for each cell.
* Improve PnR results. Current cell placement is not very good, likely due to
  improper lef generation of the library.
* Flesh out the Makefile so that it will generate the Liberty file, and get
  setup to run synthesis and PnR flow.
* Incorporate OpenROAD-Flow-Scripts to replace Synopsys Design Compiler and
  Calibre Innovus for synthesis and PnR.



