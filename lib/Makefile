.PHONY: all magic xschem lvs

RUN_DIR=$(PWD)

all: clean magic xschem lvs

magic: clean
	mkdir -p magic/spice
	mkdir -p magic/gds
	cd scripts && ./extract
	
xschem: clean
	echo "(TODO) make xschem"
	#-@cd xschem && ./scripts/extract_all

lvs: magic xschem
	echo "Running LVS"
	mkdir -p ./lvs/magic
	mkdir -p ./lvs/xschem
	rm -f ./lvs/magic/*
	rm -f ./lvs/xschem/*
	rm -f ./lvs/*.out
	./scripts/runlvs.sh
	mv *.out ./lvs/
	grep -nri 'circuits match' lvs/*.out > lvs/lvs_report.log
	cat lvs/lvs_report.log

clean:
	rm -f magic/spice/*
	rm -f magic/gds/*
	rm -f magic/*.ext
	rm -f magic/pcells/*.ext
