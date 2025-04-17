.PHONY: clean move run purge

DESIGN=fsm

export LIBRARY_NAME?=sky130_rhbd
export HDL_TOP?='[fsm]'
export FREQENCY?='[500]'

default: run

clean:
	-@cd flow && make clean && cd - 
	-@rm *.txt

purge: clean
	-@cd flow && make purge && cd -
	-@rm -rf output-files

run:
	-@cd flow && make | tee ../out.txt && cd -  
