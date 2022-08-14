#!/bin/sh
if [ $# -gt 0 ]
then
    CELL=$1
    cp ./magic/spice/${CELL}.spice ./lvs/magic/
    cp ./xschem/${CELL}.spice ./lvs/xschem/
    MAGIC_SPICE_FILE="./lvs/magic/{${CELL}.spice"
    XSCHEM_SPICE_FILE="./lvs/xschem/${CELL}.spice"
    echo "${CELL} LVS: Magic(${MAGIC_SPICE_FILE}) vs. XSCHEM(${XSCHEM_SPICE_FILE})"
    sed -i "/^.subckt $CELL.*VDD.* GND.*$/! s/.subckt $CELL.*$/& VDD GND/" ${XSCHEM_SPICE_FILE}
    sed -i "s/L=0.15/L=0.15u/g" ${XSCHEM_SPICE_FILE}
    sed -i "s/W=3/W=3u/g" ${XSCHEM_SPICE_FILE}
    sed -i "s/W=2/W=2u/g" ${XSCHEM_SPICE_FILE}
    sed -i "s/^C.*$//g" ${MAGIC_SPICE_FILE}
    ./scripts/runlvs_single.sh ${MAGIC_SPICE_FILE} ${XSCHEM_SPICE_FILE} 
else
    cp ./magic/spice/*.spice ./lvs/magic/
    cp ./xschem/*.spice ./lvs/xschem/
    CELL_FILES=$(ls ./lvs/magic/*)
    echo "Running LVS on whole library:\n${CELL_FILES}"
fi

for file in ${CELL_FILES}; do
    CELL_NAME=$(basename "${file}" .spice)
    MAGIC_SPICE_FILE="./lvs/magic/${CELL_NAME}.spice"
    XSCHEM_SPICE_FILE="./lvs/xschem/${CELL_NAME}.spice"
    echo "${CELL} LVS: Magic(${MAGIC_SPICE_FILE}) vs. XSCHEM(${XSCHEM_SPICE_FILE})"
    sed -i "/^.subckt $CELL.*VDD.* GND.*$/! s/.subckt $CELL.*$/& VDD GND/" ${XSCHEM_SPICE_FILE}
    sed -i "s/L=0.15/L=0.15u/g" ${XSCHEM_SPICE_FILE}
    sed -i "s/W=3/W=3u/g" ${XSCHEM_SPICE_FILE}
    sed -i "s/W=2/W=2u/g" ${XSCHEM_SPICE_FILE}
    sed -i "s/^C.*$//g" ${MAGIC_SPICE_FILE}
    ./scripts/runlvs_single.sh ${MAGIC_SPICE_FILE} ${XSCHEM_SPICE_FILE} 
    echo "\n\n"
done

