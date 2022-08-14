SHELL:=csh
VARIANT:=18T_ms_rhbd

.PHONY: do clean purge

all: do

extract:
	@cd ../lib && make clean magic pex VARIANT=${VARIANT}

do:
	@cd ../lib && make clean magic VARIANT=${VARIANT}
	@cd abstract && make VARIANT=${VARIANT}
	cd techfiles && ./genArea.py ${VARIANT}
	@cd liberate && make purge do VARIANT=${VARIANT}
#	@cd liberate && make clean do CORNER=FS && make clean do ARGS=-ecsm CORNER=FS

clean:
	-@cd abstract && make clean
	-@cd liberate && make clean

purge:
	-@cd ../lib && make clean
	-@cd abstract && make clean
	-@cd liberate && make purge
