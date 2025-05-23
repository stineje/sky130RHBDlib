.PHONY: clean move run purge
SHELL:=/usr/bin/bash

export LIBRARY_NAME?=sky130_rhbd
export HDL_TOP?='[riscv,riscvsingle]'
export FREQUENCY?='[800,800]'
export HDL_DIRECTORY?='[pipelined/,single/]'

default: run

clean:
	-@cd flow && make clean && cd - 
	-@rm *.txt

purge: clean
	-@cd flow && make purge && cd -
	-@rm -rf output-files

run:
	-@cd flow && make | tee ../out.txt && cd -  
