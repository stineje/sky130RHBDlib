#!/usr/bin/bash

#$1 top level dir of qa drc results
#$2 output summary file 

field_width=15
error_text=ERROR

# Find max width of run names
max_width=0

for dpath in `find $1 -mindepth 1 -maxdepth 1 -type d`; do 

  dlength=$(echo $dpath | awk '{n=split($1,arr,"/"); print length(arr[n])}')

  if [ $dlength -gt $max_width ]; then
    max_width=$dlength
  fi

done

if [ $field_width -gt $max_width ]; then
  max_width=$field_width
fi
let max_width=$max_width+4

# Generate summary

printf "%-${max_width}s%-${field_width}s%-${field_width}s%-${field_width}s%-${field_width}s%-${field_width}s%-${field_width}s\n" '' 'Unmatched CDS' 'PASS Matched' 'Unmatched DRC' 'Matched DRC' 'Total CDS' 'Total DRC' > $2
printf "%-${max_width}s%-${field_width}s%-${field_width}s%-${field_width}s%-${field_width}s%-${field_width}s%-${field_width}s\n" 'Cell Name' 'Annotations' 'DRC Violations' 'Violations' 'Violations' 'Annotations' 'Violations' >> $2
printf "%-${max_width}s%-${field_width}s%-${field_width}s%-${field_width}s%-${field_width}s%-${field_width}s%-${field_width}s\n" '' '(BAD)' '(BAD)' '(BAD)' '(GOOD)' '(INFO)' '(INFO)' >> $2

for dpath in `find $1 -mindepth 1 -maxdepth 1 -type d | sort`; do 

  dname=$(echo $dpath | awk '{n=split($1,arr,"/"); print arr[n]}')

  # if file exists
  if [ -f $dpath/parse.log ]; then
    # if file not empty 
    if [ -s $dpath/parse.log ]; then
      res_vals=($error_text $error_text $error_text $error_text $error_text $error_text)
    else
      if [ -f $dpath/parse.results ]; then
        res_vals=($(tail -1 $dpath/parse.results | awk '{split($1,arr,":")} END { for (i = 1; i <= length(arr); i++) {print arr[i]}}'))
      else
        res_vals=($error_text $error_text $error_text $error_text $error_text $error_text)
      fi
    fi
  else
    res_vals=($error_text $error_text $error_text $error_text $error_text $error_text)
  fi

  printf "%-${max_width}s%-${field_width}s%-${field_width}s%-${field_width}s%-${field_width}s%-${field_width}s%-${field_width}s\n" $dname ${res_vals[0]} ${res_vals[1]} ${res_vals[2]} ${res_vals[3]} ${res_vals[4]} ${res_vals[5]} >> $2

done
