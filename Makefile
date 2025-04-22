.PHONY: extract lvs pex spef abstract liberate flow purge
SHELL:=/usr/bin/bash
RUN_DIR:=$(shell pwd)

DESIGN=sky130_rhbd
PATTERN=*

# Primarily used in the synth/pnr flows.
export LIBRARY_NAME?=$(DESIGN)
export HDL_TOP?='[fsm,fsm_test]'
export FREQUENCY?='[750,500]'

# Power rail names.
VDD=VDD
GND=GND

default: extract

all: extract lvs pex abstract liberate 

extract: 
	cd layout/${DESIGN}/ && python3 ext4mag.py --move --lef --extract_ngspice ${PATTERN} && cd -; \
	cd layout/xschem/${DESIGN} && python3 extspice.py --move ${PATTERN}.sch && cd -; \
	mkdir -p ${LIBRARY_NAME}/gds; \
	mkdir -p ${LIBRARY_NAME}/lef; \
	cp layout/${DESIGN}/merged.gds $(RUN_DIR)/${LIBRARY_NAME}/gds/${DESIGN}.gds; \
	cp layout/${DESIGN}/gds/* $(RUN_DIR)/${LIBRARY_NAME}/gds/; \
	cp layout/${DESIGN}/merged.lef $(RUN_DIR)/${LIBRARY_NAME}/lef/${DESIGN}.lef

lvs:
	mkdir -p ${LIBRARY_NAME}/lvs; \
	cd netgen; \
	${MAKE} -f Makefile lvs DESIGN=${DESIGN}; \
	cp -f ${DESIGN}_lvs/*.report $(RUN_DIR)/${LIBRARY_NAME}/lvs/; \
	cd - 

pex:
	mkdir -p ${LIBRARY_NAME}/pex; \
	mkdir -p calibre/${DESIGN}; \
	cd calibre/${DESIGN}; \
	cp ../move_and_adjust.sh ../device_name_adjust.py ./; \
	./move_and_adjust.sh ${DESIGN}; \
	cd ../; \
	./run_calibrePEX ${DESIGN}; \
	python3 ./add_m_to_NMOS.py; \
	mv -f output/ ${DESIGN}_output/; \
	sed -i 's|/calibre/output/|/calibre/${DESIGN}_output/|g' ${DESIGN}_output/spice/*; \
	cp -f ${DESIGN}_output/spice/*.spice $(RUN_DIR)/${LIBRARY_NAME}/pex/; \
	cp -f ${DESIGN}_output/spice/*.spi $(RUN_DIR)/${LIBRARY_NAME}/pex/; \
	cd ../

spef:
	mkdir -p ${LIBRARY_NAME}/spef; \
	cd calibre; \
	./run_calibrePEX_SPEF ${DESIGN}; \
	mv -f output/ ${DESIGN}_output_SPEF/; \
	cp -f ${DESIGN}_output_SPEF/spef/*.spef $(RUN_DIR)/${LIBRARY_NAME}/spef/; \
	cd -

abstract:
	mkdir -p ${LIBRARY_NAME}/lef; \
	cd char/abstract; \
	export VDD=${VDD}; \
	export GND=${GND}; \
	${MAKE} -f Makefile DESIGN=${DESIGN}; \
	cp -f *.lef $(RUN_DIR)/${LIBRARY_NAME}/lef/; \
	cd -

liberate:
	mkdir -p ${LIBRARY_NAME}/{lib,db}; \
	cd char/liberate; \
	${MAKE} -f Makefile run DESIGN=${DESIGN}; \
	cp -rf *.lib DATASHEET/ VERILOG/ LOG/ $(RUN_DIR)/${LIBRARY_NAME}/lib/; \
	cp -rf *.db $(RUN_DIR)/${LIBRARY_NAME}/db/; \
	cd -

flow:
	cd flow/ && ${MAKE} -f Makefile && cd -; \

purge:
	cd layout/${DESIGN} && ${MAKE} -f Makefile purge && cd -; \
	cd layout/xschem/${DESIGN} && ${MAKE} -f Makefile purge DESIGN=${DESIGN} && cd -; \
	cd layout/xschem/${DESIGN} && ${MAKE} -f Makefile purge DESIGN=${DESIGN} && cd -; \
	cd netgen && ${MAKE} -f Makefile purge DESIGN=${DESIGN} && cd -; \
	cd calibre && ${MAKE} -f Makefile purge DESIGN=${DESIGN} && cd -; \
	cd char/abstract && ${MAKE} -f Makefile purge DESIGN=${DESIGN} && cd -; \
	cd char/liberate && ${MAKE} -f Makefile purge DESIGN=${DESIGN} && cd -; \
	cd flow/ && ${MAKE} -f Makefile purge && cd -
