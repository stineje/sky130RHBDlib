#
#  ####    ####   #    #
# #    #  #       #    #
# #    #   ####   #    #
# #    #       #  #    #
# #    #  #    #  #    #
#  ####    ####    ####
#
# OSU Synopsys Setup Script
#
#

set VERSION=M-2016.12
set SYNOPSYS=/import/comet1/SNPS/$VERSION

#============= Aliases =================
alias prepend 'if (-d \!:2) if ("$\!:1" \!~ *"\!:2"*) setenv \!:1 "\!:2":${\!:1}'
alias extend  'if (-d \!:2) if ("$\!:1" \!~ *"\!:2"*) setenv \!:1 ${\!:1}:\!:2'
#=======================================

######################################
# Synopsys Tool Setup                #
######################################

setenv LM_LICENSE_FILE 27020@avatar.ecen.okstate.edu
setenv CLS_CSD_COMPATIBILITY_LOCKING NO
setenv SKIP_CDS_DIALOG

# Synthesis Tools, includes DesignVision (DesignCompiler), etc
setenv SYN ${SYNOPSYS}/syn
extend PATH $SYN/bin

# Primetime
setenv PT ${SYNOPSYS}/pts
extend PATH $PT/bin

# ICC
setenv ICC ${SYNOPSYS}/icc
extend PATH $ICC/bin

# MW
setenv MW ${SYNOPSYS}/mw
extend PATH $MW/bin/linux64
extend LD_LIBRARY_PATH $MW/lib

# Primerail
setenv PRIMERAIL ${SYNOPSYS}/primerail
extend PATH $PRIMERAIL/bin

# Library Compiler
setenv LC ${SYNOPSYS}/lc
extend PATH $LC/bin

unalias prepend
unalias extend

echo "synopsys DC/LC/PTS/ICC/HSPICE tools are ready to use"
echo "  modify script to add/delete tools, as needed."

