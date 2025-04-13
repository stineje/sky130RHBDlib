.PHONY: extract purge move

DESIGN=*sky130_rhbd*

default: extract

all: clean extract

purge:
	-@rm -rf spice/

extract: 
	python3 extspice.py --move ${DESIGN}

move:
	-@mkdir spice
	-@mv *.spice spice/
