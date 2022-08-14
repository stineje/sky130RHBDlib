#!/bin/bash

sed -i -e 's/u / /g' -e 's/15u/15/g' -e 's/=0p/=0/g' -e 's/fF/f/g' spice/*.spice
