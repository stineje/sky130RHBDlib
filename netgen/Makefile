.PHONY: lvs purge 

DESIGN=sky130_rhbd

default: lvs

all: purge lvs 

purge:
	-@rm -rf lvs/

lvs: 
	python3 extlvs.py --move -s ../layout/xschem/${DESIGN}/spice/ -l ../layout/${DESIGN}/ngspice/ 
	rm -rf ${DESIGN}_lvs
	mv -f lvs/ ${DESIGN}_lvs/
