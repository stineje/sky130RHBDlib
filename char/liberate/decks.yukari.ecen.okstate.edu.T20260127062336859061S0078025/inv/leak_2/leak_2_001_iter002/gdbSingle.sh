#!/bin/csh -f


setenv SKI_STANDALONE_MODE 1

# Turn on 'SKI_DEBUG_MSG' to show verbose messages.
# setenv SKI_DEBUG_MSG 0x10000000

# Use 'SKI_SAVE_WAVEFORMS' to save all waveforms of simulations.
# setenv SKI_SAVE_WAVEFORMS 2

setenv SKI_DEBUG_NETLIST sim.sp

setenv ALTOSHOME /import/programs/cadence/LIBERATE/current

set mmsim_path=/import/programs/cadence/LIBERATE/current/tools.lnx86
setenv LD_LIBRARY_PATH ${mmsim_path}/python/64bit/lib:${mmsim_path}/TPtools/openssl/lib/64bit:${mmsim_path}/TPtools/grpc/lib64:${mmsim_path}/jsoncpp/lib/64bit:${mmsim_path}/tcltk-8.6.8/lib/64bit:${mmsim_path}/lib/64bit:${mmsim_path}/inca/lib/64bit:${mmsim_path}/mdl/lib/64bit:${mmsim_path}/mmsim/lib/64bit:${mmsim_path}/spectre/lib/64bit:${mmsim_path}/fmc/lib/64bit:${mmsim_path}/dfII/lib/64bit:${LD_LIBRARY_PATH}


gdb --args /import/programs/cadence/LIBERATE/current/tools.lnx86/spectre/bin/64bit/spectre/programs/cadence/LIBERATE/current/bin/spectre -64 -plugin /import/programs/cadence/LIBERATE/current/lib/lnx86_64_2.6/libSki.so +multiple -cp -ss +l sim.lis -f sst2 +lqt 0 
