.PHONY: flow clean purge

export LIBRARY_NAME?=sky130_rhbd

default: flow 

flow:
	-@python3 top.py | tee log.txt
	-@cat ../output-files/OSU130_RHBD/table.tex

clean:
	-@rm -rf output-files
	-@rm -f log.txt
	-@rm -f out.txt
	-@rm -f *.png
	-@rm table.aux table.log table.pdf table.tex

purge: clean
	-@cd synth/ && make clean && cd -
	-@cd pnr/ && make clean && ./clean_me.csh && cd -
