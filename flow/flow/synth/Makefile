#  
#  Oklahoma State University
#  Makefile for synthesis
# 
NAME := synth

default:
	@echo "Basic synthesis procedure for OSU"
	@echo " adapt Makefile to your liking..."
	@echo

synth:
	@echo "DC Synthesis"
	@mkdir -p reports mapped unmapped
	dc_shell-xg-t -64bit -f scripts/$(NAME).tcl | tee $(NAME).out

purge:
	rm -rf alib-52 WORK mapped unmapped reports analyzed $(NAME).out
	rm -f default.svf
	rm -f command.log
	rm -f filenames*.log
	rm -f *Synopsys_stack_trace*
	rm -f *.swp
	rm -f *.nfs*
