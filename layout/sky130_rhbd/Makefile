.PHONY: clean extract purge 

DESIGN=*

default: extract

all: clean extract 

clean:
	-@rm -rf lvs_output
	-@rm -rf svdb
	-@rm *.log
	-@rm *.LOG

purge: clean
	-@rm -rf ./gds ./ngspice ./spice ./sim ./ext ./cif ./log ./*.gds ./*.lef ./klayout_script.py

extract: 
	python3 ext4mag.py --move --extract_ngspice --lef ${DESIGN} 

