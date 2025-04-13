#!/bin/bash
mkdir -p cells/pcells
mkdir -p ../magic/extraction
mkdir -p ../log
touch extract.log

cp -r ../magic/*.mag cells/
cp -r ../magic/pcells/* cells/pcells/

if [ $# -gt 0 ]
then
    FILES="cells/${1}.mag"
    echo "[INFO] Extracting 1 layout: $FILES"
else
    FILES=$(ls cells/*.mag)
    echo "[INFO] Extracting VARIANT layouts:\n $FILES"
    echo '# Standard Cell LEF generated in Magic' > tmp.lef
fi

### Loop through all magic files and extract
for i in ${FILES}; do
    export CELLNAME="$(basename $i .mag)"
    echo "[INFO] Extracting $CELLNAME ..."

    ### Generate GDS, LEF, and SPICE
    echo "gds; lef write" | magic -dnull -noconsole cells/${CELLNAME}.mag >> extract.log 2>&1

    mv cells/${CELLNAME}.mag cells/tmp.mag
    echo "source magic_flatten.tcl" | magic -dnull -noconsole cells/tmp.mag >> extract.log 2>&1

    echo "extract; ext2spice scale off; ext2spice -t# -t! -m" | magic -dnull -noconsole ${CELLNAME}.mag >> extract.log 2>&1

    mv ${CELLNAME}.mag ../magic/flattened/

    ### Concatenate the cells LEF to the tmp.lef
    cat ${CELLNAME}.lef >> tmp.lef
    mv ${CELLNAME}.lef ../lef/singles/

done

echo "[INFO] Extraction done"


echo "[INFO] Cleaning SPICE files..."
### Units in SPICE generate in absolute terms, so replace them with
### the units in micron. The widths can also generate incorrectly,
### so fix them manually.
sed -i 's/ad=.* w=3.*/w=3 l=0.15/g' *.spice
sed -i 's/ad=.* w=2.*/w=2 l=0.15 M=2/g' *.spice
sed -i 's/^.option scale.*//g' *.spice
sed -i -e 's/sky130_fd_pr__nfet_01v8/nshort/g' -e 's/sky130_fd_pr__pfet_01v8/pshort/g' *.spice


echo "[INFO] Removing redundant headers from LEF..."
### After all cell LEFs have been added to tmp.LEF, remove
### all redundant header info
sed -i -e "s/^VERSION.*//g" -e "s/.*NOWIREEXTENSIONATPIN.*//g" -e "s/.*DIVIDERCHAR.*//g" -e "s/.*BUSBITCHAR.*//g" -e "s/END LIBRARY.*//g" tmp.lef

### Add a single header back in
echo 'VERSION 5.7 ;' >> sky130_fd_sc_rh.lef
echo '  NOWIREEXTENSIONATPIN ON ;' >> sky130_fd_sc_rh.lef
echo '  DIVIDERCHAR "/" ;' >> sky130_fd_sc_rh.lef
echo '  BUSBITCHARS "[]" ;' >> sky130_fd_sc_rh.lef
cat tmp.lef >> sky130_fd_sc_rh.lef
echo 'END LIBRARY' >> sky130_fd_sc_rh.lef

echo "[INFO] Moving everything to proper directory..."
### Clean up
mv *.spice ../spice/
mv *.gds ../gds/
mv *.ext ../magic/extraction/
mv sky130_fd_sc_rh.lef ../lef/
echo "[LOG]"
mv --backup=numbered --suffix=.bak --verbose extract.log ../log/


## Final clean up
echo "[INFO] Doing final clean up..."
rm tmp.lef
rm -r cells
