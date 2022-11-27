#!/bin/bash

ngspice -b -r test_${1}.raw -o test_${1}.out test_${1}.sp
gaw test_${1}.raw
