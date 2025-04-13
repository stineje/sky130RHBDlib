VPATH:=make
LOG:=./LOG
RUN_DIR:=$(shell pwd)
SHELL:=bash
REPO_PATH:=/home/rjridle/sky130RHBDlib
LIBRARY_PATH:=$(REPO_PATH)/lib
MODEL_PATH:=$(REPO_PATH)/char/s8_models
NETLIST_PATH:=$(LIBRARY_PATH)/spice

.DEFAULT: all
.PHONY: all do run clean purge

CORNER:=TT
TEMP:=25
VLTG:=1.8
ARGS:=-ccs
NAME:=sky130_fd_sc_rh_$(CORNER)_1P8_$(TEMP)C.ccs

#VARIANT:=18T_ms/

USER:=$(shell whoami)
USER_MAIL:=$(shell echo `ldapsearch -x -LL "(uid=$(USER))" mail | sed -n "s/^mail: //p"`)
#NO_MAIL:=true

ALL_CNR = TT \
		FF \
		SS \
		FS \
		SF

CELLS:=AND2X1 \
	   DFFRNQNX1 \
	   NAND2X1 \
	   TMRDFFRNQNX1 \
	   AND3X1 \
	   DFFRNQX1 \
	   NAND3X1 \
	   TMRDFFRNQX1 \
	   AO3X1 \
	   NOR2X1 \
	   TMRDFFSNQX1 \
	   AOA4X1 \
	   DFFSNQNX1 \
	   OR2X1 \
	   TMRDFFSNRNQNX1 \
	   AOAI4X1 \
	   DFFSNQX1 \
	   TMRDFFSNRNQX1 \
	   AOI3X1 \
	   DFFSNRNQNX1 \
	   TIEHI \
	   VOTER3X1 \
	   BUFX1 \
	   DFFSNRNQX1 \
	   TIELO \
	   VOTERN3X1 \
	   DFFQNX1 \
	   INVX1 \
	   TMRDFFQNX1 \
	   XNOR2X1 \
	   DFFQX1 \
	   MUX2X1 \
	   TMRDFFQX1 \
	   XOR2X1

setup: 
	echo "[MAKE] Running setup"
	@mkdir -p $(VPATH) $(LOG) NETLIST LIBRARY LDB DATASHEET VERILOG
	#@cp -r $(MODEL_PATH)/* MODELS/
	#@echo "Running sedModels..."
	#@cd MODELS && sh ../SCRIPTS/sedModels
	@cp -r $(NETLIST_PATH)/*.spice NETLIST/
	@echo "Running sedSpice..."
	@cd NETLIST && sh ../SCRIPTS/sedSpice
	@echo "Generating celllist..."
	@ls NETLIST/*.spice  | sed 's/.spice\|NETLIST\///g' > celllist
	@touch $(VPATH)/$@


all:
	@for i in $(ALL_CNR); do \
		echo "Generating corner $$i"; \
		$(MAKE) -f $(lastword $(MAKEFILE_LIST)) do CORNER=$$i; \
	done

single:
	@for i in $(CELLS); do \
		echo "Running $$i" ; \
		sed -i "s/^set cells.*/set cells \"$$i\"/g" TEMPLATE/template_example.tcl; \
		$(MAKE) -f $(lastword $(MAKEFILE_LIST)) run; \
	done

run: setup
	export CORNER=$(CORNER); \
	export TEMP=$(TEMP); \
	export VLTG=$(VLTG); \
	export ARGS=$(ARGS); \
	export VARIANT=$(VARIANT); \
	export NAME=$(NAME); \
	printf "*\n.LIB 'models.sp' $(CORNER)" > MODELS/include.sp; \
	liberate --trio char.tcl |& tee LOG/$$NAME.log; \
	lc_shell -no_log -f SCRIPTS/lib_to_db.tcl
	@mv --backup=numbered *.lib LIBRARY/
	@mv --backup=numbered *.db LIBRARY/
	@mv --backup=numbered *.log LOG/
	#@python3 SCRIPTS/addAreaLib.py $(LIBRARY_PATH)/lef/sky130_fd_sc_rh.lef $(RUN_DIR)/LIBRARY/$(NAME).lib
ifndef NO_MAIL
	@echo "" | mail -s "Lib extraction finished for $(CORNER) $(TEMP) $(VLTG) $(ARGS) on `uname -n`" $(USER_MAIL)
endif

do: run
	@mkdir -p $(LIBRARY_PATH)/liberty/
	@cp *.lib $(LIBRARY_PATH)/liberty/
	@cp *.db $(LIBRARY_PATH)/liberty/
	@cp -r DATASHEET ../../liberty/
	@cp -r VERILOG ../../liberty/
	@mv *.lib LIBRARY/
	@mv *.db LIBRARY/

clean:
	#-@rm -f MODELS/*.pm3 
	#-@rm -f MODELS/*.cor 
	#-@rm -f MODELS/*.ai 
	#-@rm -f MODELS/*.va 
	#-@rm -f MODELS/*.mod 
	#-@rm -f MODELS/fixed_layout_* 
	#-@rm -f MODELS/readme 
	#-@rm -f MODELS/models.all 
	#-@rm -f MODELS/include.sp
	-@rm -f NETLIST/*
	-@rm -rf $(VPATH)
	-@rm -rf altos*
	-@rm -rf celllist
	-@rm -rf *.log


purge: clean
	-@rm -rf $(LOG)
	-@rm -rf LIBRARY
	-@rm -rf MODELS
	-@rm -rf LDB
	-@rm -rf DATASHEET
	-@rm -rf VERILOG
	-@rm -rf NETLIST

