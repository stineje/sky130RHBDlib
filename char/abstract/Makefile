SHELL:=csh

# Valid ARGS:
# -gui
# -extract
# -noexit
# -debug (gui + noexit)

VARIANT:=12T_hs
TRACKS:=$(firstword $(subst _, ,${VARIANT}))

.PHONY: do clean

do:
	@sed -i 's/18T_ms/${VARIANT}/g' lef_gen
	@sed -i 's/18T_ms/${VARIANT}/g' abstract_SKILL_script
	@sed -i 's/18T/${TRACKS}/g' abstract_SKILL_script
	@./clean_all
	@setenv VARIANT ${VARIANT}; \
	./lef_gen $(ARGS)
	@sed -i 's/${VARIANT}/18T_ms/g' lef_gen
	@sed -i 's/${VARIANT}/18T_ms/g' abstract_SKILL_script
	@sed -i 's/${TRACKS}/18T/g' abstract_SKILL_script

clean:
	@./clean_all
