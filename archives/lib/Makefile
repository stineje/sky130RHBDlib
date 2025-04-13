.PHONY: all magic xschem lvs

RUN_DIR=$(PWD)

defualt: magic

all: clean magic xschem lvs

magic: clean
	cd scripts && sh extract.sh
	
xschem: clean
	echo "(TODO) make xschem"
	#-@cd xschem && ./scripts/extract_all

lvs: magic xschem
	echo "Running LVS"
	mkdir -p ./lvs/magic
	mkdir -p ./lvs/xschem
	rm -r ./lvs/magic/*
	rm -r ./lvs/xschem/*
	rm -r ./lvs/*.out
	./scripts/runlvs.sh
	mv *.out ./lvs/
	grep -nri 'circuits match' lvs/*.out > lvs/lvs_report.log
	cat lvs/lvs_report.log

clean:
	rm -rf spice/*.spice
	rm -rf gds/*.gds
	rm -rf lef/sky130_fd_sc_rh.lef
	rm -rf magic/extraction/*
