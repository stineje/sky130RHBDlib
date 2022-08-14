SHELL:=csh

PROD_PATH:="PATH_TO_PROD_REPO"
VARIANT:="18T_ms_rhbd"

.PHONY: all clean char push_prod

all: clean char

char:
	-@cd lib && make magic pex VARIANT=${VARIANT}
	-@cd char && make VARIANT=${VARIANT}

clean:
	-@cd char && make clean

push_prod:
	@mkdir -p $(PROD_PATH)
	@cp -r Makefile $(PROD_PATH)
	@cp -r sourceme $(PROD_PATH)
	@cp -r char $(PROD_PATH)
	@cp -r lib $(PROD_PATH)
	@cp -r outputs $(PROD_PATH)
	@mkdir -p $(PROD_PATH)/flow
	@cp -r flow/pnr $(PROD_PATH)/flow/pnr
	@cp -r flow/synth_snps $(PROD_PATH)/flow/synth_snps
	@rm -rf $(PROD_PATH)/flow/synth_snps/hdl/*
