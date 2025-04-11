SHELL:=csh

# Valid ARGS:
# -gui
# -extract
# -noexit
# -debug (gui + noexit)

#VARIANT:=12T
#TRACKS:=$(firstword $(subst _, ,${VARIANT}))

DESIGN=sky130_rhbd

DESIGN_DIR:=../../layout/$(DESIGN)/gds
FIRST_RESULT:=$(shell ls ${DESIGN_DIR}/*.gds | head -1)
LAST_RESULT:=$(shell ls ${DESIGN_DIR}/*.gds | tail -1)

FIRST_NO_EXT:=$(subst ../../layout/${DESIGN}/gds/,,$(basename ${FIRST_RESULT} .gds))
LAST_NO_EXT:=$(subst ../../layout/${DESIGN}/gds/,,$(basename ${LAST_RESULT} .gds))

.PHONY: do clean modify_lef

default: do modify_lef

do: clean
	setenv VARIANT ${VARIANT}; \
	setenv DESIGN ${DESIGN}; \
	setenv DESIGN_DIR ${DESIGN_DIR}; \
	setenv FIRST_RESULT ${FIRST_NO_EXT}; \
	setenv LAST_RESULT ${LAST_NO_EXT}; \
	./lef_gen $(ARGS); \
	sed -i "s/SITE layout ;/SITE unitrh ;/g" $(DESIGN).lef; \
	sed -i "s/SYMMETRY X Y ;/SYMMETRY X Y ;/g" $(DESIGN).lef; \
	sed -i "s/li ;/li ;/g" $(DESIGN).lef; \
	python3.6 extract_area_lef.py -d ./ -f $(DESIGN).lef

modify_lef:
	@/bin/sh -c 'LINE_NUMBER=$$(grep -n "pcell" $(DESIGN).lef | cut -d: -f1 | head -n 1); \
	echo "LINE_NUMBER: $$LINE_NUMBER"; \
	if [ -n "$$LINE_NUMBER" ]; then \
		sed -i "$$LINE_NUMBER,\$$ s/CLASS CORE/CLASS BLOCK/g" "$(DESIGN).lef"; \
	else \
		echo "pcell not found in $(DESIGN).lef"; \
	fi' \
	python ./adjust_lef.py

purge:
	@./clean_all
