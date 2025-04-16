VPATH:=make
LOG:=./LOG
RUN_DIR:=$(shell pwd)
SHELL:=/bin/bash

DESIGN:=sky130_rhbd

.DEFAULT: all
.PHONY: all do run clean purge

PREFIX:=TMR_
CORNER:=tt
TEMP:=25
VLTG:=1.8
ARGS:=-ccs
VARIANT:=
NETLIST_PATH:=../../calibre/output/spice
MODELS_PATH:=../../models
AREA_FILE_PATH:=../abstract
LIBRARY_NAME?=$(DESIGN)
OUTPUT_FILE_PATH:=../../$(LIBRARY_NAME)

USER:=$(shell whoami)
USER_MAIL:=$(shell echo `ldapsearch -x -LL "(uid=$(USER))" mail | sed -n "s/^mail: //p"`)
export

define \n

endef

ALL_CNR = tt \
		ff \
		ss \
		fs \
		sf

setup:
	@mkdir -p $(VPATH) $(LOG) NETLIST LIBRARY LDB DATASHEET VERILOG MODELS
	@cp $(MODELS_PATH)/*.scs MODELS/
	@cp $(NETLIST_PATH)/*.spi NETLIST/
	@ls NETLIST/*.spi | sed 's/.spi\|NETLIST\///g' > celllist
	@touch $(VPATH)/$@

all:
	@for i in $(ALL_CNR); do \
		$(MAKE) -f $(lastword $(MAKEFILE_LIST)) do CORNER=$$i TEMP=25 VLTG=1.8; \
	done 

	@for i in $(ALL_CNR); do \
		$(MAKE) -f $(lastword $(MAKEFILE_LIST)) do CORNER=$$i TEMP=-40 VLTG=1.95; \
	done 

	@for i in $(ALL_CNR); do \
		$(MAKE) -f $(lastword $(MAKEFILE_LIST)) do CORNER=$$i TEMP=100 VLTG=1.40; \
	done 

run: setup
	export CORNER=$(CORNER); \
	export TEMP=$(TEMP); \
	export VLTG=$(VLTG); \
	export ARGS=$(ARGS); \
	export VARIANT=$(VARIANT); \
	export AREA_FILE_PATH=$(AREA_FILE_PATH); \
	export FILE_NAME=`SCRIPTS/getname.tcl`; \
	printf "*\ninclude \"$(RUN_DIR)/MODELS/models.scs\"\ninclude \"$(RUN_DIR)/MODELS/parameters.scs\" section=fet_$(CORNER)\ninclude \"$(RUN_DIR)/MODELS/modular_models.scs\" section=global\ninclude \"$(RUN_DIR)/MODELS/parameters.scs\" section=res_nom\ninclude \"$(RUN_DIR)/MODELS/parameters.scs\" section=cap_nom" > MODELS/include.scs; \
	liberate --trio char.tcl |& tee LOG/$$FILE_NAME.log; \
	lc_shell -no_log -f SCRIPTS/lib_to_db.tcl
	mkdir -p $(RUN_DIR)/$(OUTPUT_FILE_PATH)
	cp -rf *.lib *.db DATASHEET/ VERILOG/ LOG/ $(RUN_DIR)/$(OUTPUT_FILE_PATH)

do: run
	@mkdir -p $(RUN_DIR)/$(OUTPUT_FILE_PATH)/lib/$(CORNER) 
	@cp *.lib $(RUN_DIR)/$(OUTPUT_FILE_PATH)/lib/$(CORNER)
	@cp *.db $(RUN_DIR)/$(OUTPUT_FILE_PATH)/lib/$(CORNER)
	@cp -r DATASHEET $(RUN_DIR)/$(OUTPUT_FILE_PATH)/lib/$(CORNER)
	@cp -r VERILOG $(RUN_DIR)/$(OUTPUT_FILE_PATH)/lib/$(CORNER)
	@mv *.lib ./LIBRARY/
	@mv *.db ./LIBRARY/

clean:
	-@rm -f MODELS/*.pm3
	-@rm -f MODELS/*.cor
	-@rm -f MODELS/*.ai
	-@rm -f MODELS/*.va
	-@rm -f MODELS/*.mod
	-@rm -f MODELS/fixed_layout_*
	-@rm -f MODELS/*.scs
	-@rm -f NETLIST/*
	-@rm -rf $(VPATH)
	-@rm -rf altos*
	-@rm -rf celllist
	-@rm -rf *.db 
	-@rm -rf *.lib 

purge: clean
	-@rm -rf $(LOG)
	-@rm -rf LIBRARY
	-@rm -rf LDB
	-@rm -rf DATASHEET
	-@rm -rf VERILOG
	-@rm -rf NETLIST
