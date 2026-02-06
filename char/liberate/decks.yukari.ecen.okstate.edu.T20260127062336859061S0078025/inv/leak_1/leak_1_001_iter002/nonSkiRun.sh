#!/bin/csh -f


setenv ALTOSHOME /import/programs/cadence/LIBERATE/current

set mmsim_path=/import/programs/cadence/LIBERATE/current/tools.lnx86
setenv LD_LIBRARY_PATH ${mmsim_path}/python/64bit/lib:${mmsim_path}/TPtools/openssl/lib/64bit:${mmsim_path}/TPtools/grpc/lib64:${mmsim_path}/jsoncpp/lib/64bit:${mmsim_path}/tcltk-8.6.8/lib/64bit:${mmsim_path}/lib/64bit:${mmsim_path}/inca/lib/64bit:${mmsim_path}/mdl/lib/64bit:${mmsim_path}/mmsim/lib/64bit:${mmsim_path}/spectre/lib/64bit:${mmsim_path}/fmc/lib/64bit:${mmsim_path}/dfII/lib/64bit:${LD_LIBRARY_PATH}


/import/programs/cadence/LIBERATE/current/bin/spectre -64 +multiple -cp -ss -l -f nutascii +lqt 0 /import/yukari1/lrburle/sky130RHBDlib/char/liberate/decks.yukari.ecen.okstate.edu.T20260127062336859061S0078025/inv/leak_1/leak_1_001_iter002/sim.sp
