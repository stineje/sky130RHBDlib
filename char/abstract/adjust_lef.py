import glob

def listDir():
    return glob.glob("*.lef")

def strMatch(data):
    for element in data:
        if 'sky130' in element:
            return element

def elementIsANumber(data):
	for element in data:
		try:
			float(element)
			print(f'Element is a number: {element}')
			return float(element)
		except ValueError:
			continue

def adjustFile(files):
	for file in files:
		print('Adjusting file: ' + file)
		with open(file, 'r') as f:
			lines = f.readlines()
			lines_adjusted = []

			for index, line in enumerate(lines):
				if 'FOREIGN' in line:
					match = strMatch(line.split(" "))
					line = f'  FOREIGN {match} ;\n'
					number_cmp = 0
				elif 'ANTENNADIFFAREA' in line and not 'PORT' in line:
					diff = True
					number = elementIsANumber(line.split(" "))					
					if float(number) > float(number_cmp):
						number_cmp = number
					continue
				elif 'PORT' in line and diff:
					line = f"    ANTENNADIFFAREA {float(number)} ;\n"
					diff = False
					lines_adjusted.append(line)
					number_cmp = 0
					line = '    PORT\n'
				elif 'ANTENNAMODEL' in line and not 'PORT' in line:
					continue
				elif 'ANTENNAGATEAREA' in line and not 'PORT' in line:
					oxide = True
					number = elementIsANumber(line.split(" "))					
					if float(number) > float(number_cmp):
						number_cmp = number
					continue
				elif 'ANTENNAMAXAREACAR' in line or 'ANTENNAMAXSIDEAREACAR' in line or 'ANTENNAMAXCUTCAR' in line: 
					continue
				elif 'PORT' in line and oxide:
					line = f"    ANTENNAGATEAREA {float(number)} ;\n"
					oxide = False
					lines_adjusted.append(line)
					number_cmp = 0
					line = '    PORT\n'

				#lines[index] = line
				lines_adjusted.append(line) 

		with open(file, 'w') as f:
			f.writelines(lines_adjusted)

if __name__ == '__main__':
	adjustFile(listDir())
