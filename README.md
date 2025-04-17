# Open Source Radation-Hardened Standard Cell Library

Open-source system on chip design flow including radation hardened standard
cells for the open source SkyWater 130nm process. Commercial tools were utilized
to provide parasitic extraction (PEX), characterization, sythnthesis and
Place-And-Route (P&R) flows. However, the files found in the `sky130_rhbd` directory found at the top of this repo provides all of the necessary files needed to interface with the open-source synthesis and P&R flow. More information is found below.

This is currently a work in progress.

<pre>
Ryan Ridley, Zach Wilson, Landon Burleson, and James E. Stine, Jr.
james.stine@okstate.edu 
Oklahoma State University
School of Electrical and Computer Engineering
VLSI Computer Architecture Research Group
</pre>

## Open Source EDA Tools

This design flow incorporates some open source tools which allows anyone to go
from layout design, all the way through to place and route. This is only possible
due to the many people who have developed and continue to maintain these open
source tools. Below is a list of all the tools used in this project, and their
respective github repositories:

- [skywater-pdk](https://github.com/google/skywater-pdk): PDK
- [magic](https://github.com/RTimothyEdwards/magic): Layout, GDS, and LEF Generation
- [xschem](https://github.com/StefanSchippers/xschem): Schematic Generation
- [netgen](https://github.com/RTimothyEdwards/netgen): LVS
- [ngspice](https://github.com/ngspice/ngspice): SPICE Simulator (This repository
  hasn't been updated in 8 years. Better to download from their website
  [here](http://ngspice.sourceforge.net/)
- [OpenROAD-flow-scripts](https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts): Synthesis and PnR

## Installation

All the tools used in this repository are added as submodules. As of right now,
refer to each tools own installation guide. The end goal is to have a Makefile
that will build, install, and configure every tool to work with this repository.
Since most of the tools use a configuration file to setup paths, everything is
still functional if the template configuration files are copied to the right
directories.

After installation of the tools has been done independantly, run the following:

```
git clone --recursive https://github.com/stineje/sky130RHLib.git
cd sky130RHLib
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

- Add more drive strengths for each cell.


## Using the Top-Level Makefile

If you would like to run through the synthesis or P&R flows, you may choose to execute the following command:

```bash
make flow
```

> [!NOTE]
> You will want to adjust the following parameters found at the top of the `Makefile`
>
> ```bash
> # Primarily used in the synth/pnr flows.
> export LIBRARY_NAME?=$(DESIGN)
> export HDL_TOP?='[fsm,fsm_test]'
> export FREQUENCY?='[750,500]'
> ```
>
> You will want to also place any designs you wish to run through synthesis and P&R in the `flow/hdl/` directory.

### make extract

```bash
make extract
```

This command will extract all necessary files from the magic layout files found in the `layout/sky130_rhbd` directory. These files are used throughout the rest of the tool flows.

### make pex

`pex` is the command used to extract all RC parasitics from the `GDS` layouts and outputs the results to `SPICE` netlists. These netlists are inputted into `liberate` to characterize all of the standard cells found in the libary.

```bash
make pex
```

> [!NOTE]
> In order to run the `pex` flow, you will need to have all of the magic files extracted from the `make extract` command.

### make abstract

`abstract` will extract all standard cells into a Library Exchange Format (LEF) to house all of the pin and metal layer information.

```bash
make abstract
```

> [!NOTE]
> In order to run the `abstract` flow, you will need to have all of the magic files extracted from the `make extract` command.

### make liberate

The `liberate` command takes the `PEX` spice netlists and uses this information to characterize all of the standard cells in the libary. This includes all timing, power, and area of the cells.

```bash
make liberate
```

> [!NOTE]
> In order to run the `liberate` flow, you will need the `pex` and `abstract` commands executed prior to a characterization run.

### make all

To execute all flows sequentially, I recommend using the following command:

```bash
make extract pex abstract liberate flow
```

This command will extract all of the required files for the `pex`, `liberate`,
and `flow` work flows. As of the time of writing, unless development or
modifications to the cells are made, the only Makefile commands needed is the
`make flow` command.
