.PHONY: purge pex

DESIGN?=sky130_rhbd
export NETLIST_DIR?="../../layout/${DESIGN}/spice"
#export NETLIST_DIR?="../../layout/xschem/$1/spice"

default: pex

all: clean pex

purge:
	-@rm -rf ./output
	-@rm -rf ./calibre_rundir
	-@rm -rf *.spi
	-@rm -rf *rul* 
	-@rm -rf *probe*
	-@rm -rf *lvs*
	-@rm -rf *${DESIGN}*
	-@rm -rf svdb


pex: 
	-@./run_calibrePEX $(DESIGN)
	-@python3 ./add_m_to_NMOS.py
	-@mv -f output/ $(DESIGN)_output/
	-@sed -i 's|/calibre/output/|/calibre/$(DESIGN)_output/|g' $(DESIGN)_output/spice/*

spef:
	-@./run_calibrePEX_SPEF $(DESIGN)
	-@mv -f output/ $(DESIGN)_output_SPEF/
