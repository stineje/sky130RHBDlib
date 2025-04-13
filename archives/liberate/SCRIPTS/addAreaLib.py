import os
import sys
import subprocess
import shutil
import logging
import traceback


def read_lef(path):
    try:
        f = open(path, 'r')
    except IOError:
        print("[ERROR] Cannot open lef file {}".format(path))
        sys.exit(1)
    else:
        with f:
            lines = f.readlines() 
            for line in lines: 
                if 'FOREIGN' in line:  
                    line = line.split(" ") 
                    cell = str(line[3]) 
                if 'SIZE' in line: 
                    line = line.split(" ") 
                    area[cell] = (float(line[3]) * float(line[5])) 


def write_lib(path):
    try:
        f = open(path, 'r+')
    except IOError:
        print("[ERROR] Cannot open lib file {}".format(path))
        sys.exit(1)
    else:
        with f:
            lines = f.readlines() 
            f.seek(0) #Sets the first line as the current location of the file ready to overwrite.   
            for line in lines: 
                if ' cell ' in line:  
                    tmp = line.split(" ") 
                    cell = str(tmp[3].replace("(", "").replace(")", "")) 
                if 'area' in line: 
                        line = line.replace("area : 0;", f'area : {area.get(cell):.8f};') 
                 
                f.write(line) 


if __name__ == '__main__':

    area = {} 

    if (len(sys.argv) == 2):
        lef_file = sys.argv[1]
        print("LEF file: {}".format(lef_file))
        print("Reading LEF...\n")
        read_lef(lef_file)
        print("LEF file read\narea:\n-------------------------")
        for x in area:
            print("  {}: {}".format(x, area.get(x)))
        print("-------------------------")
    elif (len(sys.argv) == 3):
        lef_file = sys.argv[1]
        lib_file = sys.argv[2]
        print("LEF file {}".format(lef_file))
        print("Reading LEF file...")
        read_lef(lef_file)
        print("LIB file {}".format(lib_file))
        print("Writing area to LIB...")
        write_lib(lib_file)
        print("done")
    else:
        print("[ERROR] Incorrect arguements")
        print("[USAGE] python addAreaLib [path/to/lef/mylef.lef] [./path/to/lib/mylib.lib]")
        sys.exit(1)

