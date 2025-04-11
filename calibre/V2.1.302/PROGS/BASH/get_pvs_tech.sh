#!/usr/bin/bash

# $1 pvtech.lib file
# $2 output file 

if [ -f $2 ]; then
  rm -f $2
  touch $2
else
  touch $2
fi

if [ -f $1 ]; then

  tech=($(awk '/^[ \t]*DEFINE/ { print $2 }' $1))
  tpath=($(awk '/^[ \t]*DEFINE/ { print $3 }' $1))
  tlen=$(awk '/^[ \t]*DEFINE/ { cnt++ } END { print cnt }' $1)

  for i in `seq 0 $(($tlen-1))`; do

    tpath_expanded=`echo ${tpath[i]}/techRuleSets | envsubst`

    if [ -f ${tpath_expanded} ]; then
      runsets=($(awk -F\" '/^[ \t]*[pP][vV][sS][rR][uU][lL][eE][sS][eE][tT]\([ \t]*"[a-zA-Z0-9_]+"/ {print $2}' ${tpath_expanded}))
      echo ${tech[i]} ${runsets[*]} >> $2 
    fi
  done

fi
