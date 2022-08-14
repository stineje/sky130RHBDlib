VPATH:=make
LOG:=./LOG
RUN_DIR:=$(shell pwd)
SHELL:=bash

.DEFAULT: all
.PHONY: all do run clean purge

CORNER:=TT
TEMP:=25
VLTG:=1.8
ARGS:=-ccs
VARIANT:=18T_ms

USER:=$(shell whoami)
USER_MAIL:=$(shell echo `ldapsearch -x -LL "(uid=$(USER))" mail | sed -n "s/^mail: //p"`)
export

define \n


endef

ALL_CNR = TT \
		FF \
		SS \
		FS \
		SF

setup:
	@mkdir -p $(VPATH) $(LOG) NETLIST LIBRARY LDB DATASHEET VERILOG
	@cp ../../skywater/s8pdk/V1.3.0/MODELS/spice/* MODELS/
	@cp ../../lib/output/$(VARIANT)/spice/* NETLIST/
	@cd NETLIST && sed -i '/^.subckt/s/VDD\|GND//g' `ls *spice | sed -e '/pex/d' | sed -e '/pxi/d'` && sed -i "/ PROBETYPE=1/d" `ls *spice | sed -e '/pex/d' | sed -e '/pxi/d'` && sed -i "/NWDIODE/d" `ls *spice | sed -e '/pex/d' | sed -e '/pxi/d'`
	@cd MODELS && sh ../sedSpice
	@ls NETLIST/*spice | sed -e '/pex/d' | sed -e '/pxi/d' | sed ':a;N;$$!ba;s/\n/ /g' | sed "`../techfiles/special_cells -libchar`" | sed 's/.spice\|NETLIST\///g' > celllist
	@touch $(VPATH)/$@

all:
	@for i in $(ALL_CNR); do \
		echo "Generating corner $$i"; \
		$(MAKE) -f $(lastword $(MAKEFILE_LIST)) do CORNER=$$i; \
	done

run: setup
	export CORNER=$(CORNER); \
	export TEMP=$(TEMP); \
	export VLTG=$(VLTG); \
	export ARGS=$(ARGS); \
	export VARIANT=$(VARIANT); \
	export NAME=`SCRIPTS/getname.tcl`; \
	printf "*\n.LIB 'models.sp' $(CORNER)" > MODELS/include.sp; \
	liberate --trio char.tcl |& tee LOG/$$NAME.log; \
	lc_shell -no_log -f SCRIPTS/lib_to_db.tcl
ifndef NO_MAIL
	@echo "" | mail -s "Lib extraction finished for $(CORNER) $(TEMP) $(VLTG) $(ARGS) on `uname -n`" $(USER_MAIL)
endif

do: run
	@cp *.lib ../../outputs/
	@cp *.db ../../outputs/
	@cp -r DATASHEET ../../outputs/
	@cp -r VERILOG ../../outputs/
	@mv *.lib LIBRARY/
	@mv *.db LIBRARY/

clean:
	-@rm -f MODELS/*.pm3
	-@rm -f MODELS/*.cor
	-@rm -f MODELS/*.ai
	-@rm -f MODELS/*.va
	-@rm -f MODELS/*.mod
	-@rm -f MODELS/fixed_layout_*
	-@rm -f MODELS/readme
	-@rm -f MODELS/models.all
	-@rm -f MODELS/include.sp
	-@rm -f NETLIST/*
	-@rm -rf $(VPATH)
	-@rm -rf altos*
	-@rm -rf celllist

purge: clean
	-@rm -rf $(LOG)
	-@rm -rf LIBRARY
	-@rm -rf LDB
	-@rm -rf DATASHEET
	-@rm -rf VERILOG
	-@rm -rf NETLIST
