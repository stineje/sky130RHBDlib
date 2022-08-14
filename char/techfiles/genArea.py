#!/usr/bin/python3
import sys

try:
    VARIANT=sys.argv[1]
except:
    print("Need to pass in variant info as command-line argument")
    exit()



lefName = "../../outputs/sky130_osu_sc_"+VARIANT+".lef"

f = open(lefName,"r")
lefFile = f.read()
macroList = lefFile.split("MACRO")

nameList = []
#7.2 is height
widthList = []
multEleven = []

heightList = []
areaList = []

#Lists to keep track of the cells that are wrong
originBad = []
multBad = []


def stringToInt(x):
    res=0
    ctr=0
    flag=1
    for a in x:
        if a=='.':
            ctr=1
            continue
        if flag:
            res=10*res+int(a)
        else:
            res=float(res)+int(a)*(10**(2-ctr))
        if ctr:
            ctr+=1
        if ctr>2:
            flag=0
    return res

#Parse the LEF for important info
for i in range(1,len(macroList)):
    # Lines to calculate the area and log the width and height as well as log 
    # if the width is a multiple of 11
    nameList.append(macroList[i].split("\n")[0].strip())
    sizeLine = macroList[i].split("SIZE")[1].split("\n")[0].split(" ")
    widthList.append(stringToInt(sizeLine[1]))
    heightList.append(stringToInt(sizeLine[3]))
    areaList.append(widthList[i-1] * heightList[i-1])

    if( (widthList[i-1] % 11) == 0):
        multEleven.append("yes")
    else:
        multEleven.append("no")

    
    #Lines to check the origin
    originLine = macroList[i].split("ORIGIN")[1].split("\n")[0].split(" ")

    if(float(originLine[1]) != 0 or float(originLine[2]) != 0):
        print(nameList[i-1] + " Origin not 0 0")
        originBad.append(nameList[i-1])


#A bit of a bad way to do this but
#This gets the footprint and accounts
#for cells that start with X
footprintList = []
for name in nameList:
    footprintList.append("_".join(name.split('_')[:-1]))

#Print to screen which cells are not a multiple of 11
for name,width,height,area,mult11 in zip(nameList,widthList,heightList,areaList,multEleven):
    if(mult11 is "no"):
        print("______________________________________________________________")
        print("Cell " + name + " does not have a size that is a multiple of 11")
        print("Name | Width | Height | Area")
        print(name,str(width/100),str(height/100),str(area/10000))
        print("______________________________________________________________")
        multBad.append(name)

#Report which cells are incorrect to the log

#Incorrect Origin Reporting
writeReport = open("../../outputs/cellRules.log","w+")
if(len(originBad) > 0):
    writeReport.write("The following cells do not have an origin of 0 0\n")
    writeReport.write("_____________________________________________________\n")
    for name in originBad:
        writeReport.write(name + "\n")
    writeReport.write("\n\n\n")
#Incorrect Width reporting
if(len(multBad)>0):
    writeReport.write("The following cells do not have a width that is a multiple of 11\n")
    writeReport.write("_____________________________________________________\n")
    for name in multBad:
        writeReport.write(name + "\n")
if(len(originBad) == 0 and len(multBad) == 0):
    print("ALL IS GOOD HAVE A TOTORO")
    writeReport.write("All is good :)")
    writeReport.write(TOTORO)
    print(TOTORO)



#Write areaData and footprint to file. Uncomment lines in for loop to add other things
writeF = open("../../outputs/"+VARIANT+"_areaData.lib", "w+")

writeF.write("library (sky130_osu_sc_"+VARIANT+") {\n")

for name,width,height,area,mult11,footprint in zip(nameList,widthList,heightList,areaList,multEleven,footprintList):
    writeF.write("\n\ncell(" + name + ") {")
    #writeF.write("\nwidth : " + str(width/100))
    #writeF.write("\nheight : " + str(height/100))
    writeF.write("\narea : " + str(area/10000) + ";")
    writeF.write("\ncell_footprint : " + footprint + ";") 
    #writeF.write("SizeCorrect : " + str(mult11))
    writeF.write("\n}")
writeF.write("\n}")
