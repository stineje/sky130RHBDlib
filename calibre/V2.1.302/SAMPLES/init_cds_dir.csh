#!/usr/bin/csh

# requires PDK_HOME environment variable to be set
# example: setenv PDK_HOME /db/projects/skywater/s130/pdk_dev/Q1_04.01

if(! -d $PDK_HOME) then
   echo "Usage: $0 "
   echo "$0 error: PDK_HOME environment variable is not valid"
   exit 1
endif

## Check write permissions in current working directory
if(! -w $PWD ) then
   echo "$0 error: require write permissions to current working directory"
   exit 1
endif

## Update cds.lib file
set cds_lib=$PDK_HOME/SAMPLES/cds.lib
set tstmp=`date +"%Y-%m-%d.%H-%M-%S"`
if(-f $PWD/cds.lib && -w $PWD/cds.lib ) then
   mv $PWD/cds.lib $PWD/cds.lib.$tstmp
else
   echo "$0 error: unable to update cds.lib to $cds_lib"
   exit 1

endif
echo "INCLUDE $cds_lib" > $PWD/cds.lib

## Update .cdsinit file
set cds_init=$PDK_HOME/SAMPLES/.cdsinit

if(-f $PWD/.cdsinit && -w $PWD/.cdsinit ) then
   mv $PWD/.cdsinit $PWD/.cdsinit.$tstmp
else
   echo "$0 error: unable to update .cdsinit to $cds_lib"
   exit 1

endif

ln -s $cds_init .
