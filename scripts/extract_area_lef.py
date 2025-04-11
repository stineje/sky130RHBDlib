import argparse
import os

"""_summary_
usage: extract_area_lef.py [-h] [-f FILE] [-d DIR]

This script is used to extract area for each macro from a top lef file.

optional arguments:
-h, --help            show this help message and exit
-f FILE, --file FILE  Top Lef file.
-d DIR, --dir DIR     Points to the output directory relative to the script.
						(Default=./)
"""

class ext_area_lef:
	def __init__(self):
		self.scriptHome = os.getcwd()
		self.args = self.commandLineParsing()

	def commandLineParsing(self):
		parser = argparse.ArgumentParser(description='This script is used to extract area for each macro from a top lef file.')
		parser.add_argument("-f", "--file", help="Top Lef file.", type=str)
		parser.add_argument("-d", "--dir", help="Points to the output directory relative to the script. (Default=./)", type=str, default="./")

		return parser.parse_args()

	def addAreaLib(self):
		area = {}

		with open(self.args.file, 'r') as f:
			lines = f.readlines()
			for line in lines:
				if 'FOREIGN' in line: 
					line = line.split(" ")
					cell = str(line[3])
				if 'SIZE' in line:
					line = line.split(" ")
					area[cell] = (float(line[3]) * float(line[5]))

		with open(f'{self.args.dir}area_data.lib', 'w') as f:
			f.write(f'library (mult_int2_1v8) \u007b\n')

			for key in area:
				f.write(f'\n\ncell({key}) \u007b')
				f.write(f'\narea : {area[key]};')
				f.write(f'\n\u007d')

			f.write(f'\n\u007d')

		os.chdir(self.scriptHome)

if __name__ == "__main__":
	ext_area_lef().addAreaLib()