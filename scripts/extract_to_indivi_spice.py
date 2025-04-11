import argparse
import os
import subprocess 
import sys

"""
usage: ext2indiv.py [-h] [-f FILE] [-d DIR] [-e EXTENSION]

This script is used to extract individual subcircuits from a spice deck.

optional arguments:
  -h, --help            show this help message and exit
  -f FILE, --file FILE  Top spice deck file.
  -d DIR, --dir DIR     Points to the output directory relative to the script.
                        (Default=./)
  -e EXTENSION, --extension EXTENSION
                        Sets the extension of the output spice files.
                        (Default=.spi)
"""

OG_STDOUT = sys.stdout

class ext2indiv:
	def __init__(self):
		self.args = self.commandLineParsing()
		self.top_spice = self.args.file

	def commandLineParsing(self):
		parser = argparse.ArgumentParser(description='This script is used to extract individual subcircuits from a spice deck.')
		parser.add_argument("-f", "--file", help="Top spice deck file.", type=str)
		parser.add_argument("-d", "--dir", help="Points to the output directory relative to the script. (Default=./)", type=str, default="./")
		parser.add_argument("-e", "--extension", help="Sets the extension of the output spice files. (Default=.spi)", type=str, default=".spi")
		parser.add_argument("-s", "--subcircuit", help="Inserts the subcircuit definitions at the end of the file for NMOS and PMOS devices. (Default=N)", action="store_true")
		parser.add_argument("-c", "--capitalize", help="Keeps the device names as capitalized (i.e. NMOS/PMOS_HVT)", action="store_true")

		return parser.parse_args()
	
	def checkDirExists(self):
		if (not os.path.isdir(self.args.dir)):
			os.mkdir(self.args.dir)
	
	def header(self, file):
		sys.stdout = file
		print('* Copyright 2022 Google LLC')
		print('*')
		print('* Licensed under the Apache License, Version 2.0 (the "License");')
		print('* you may not use this file except in compliance with the License.')
		print('* You may obtain a copy of the License at')
		print('*')
		print('*      http://www.apache.org/licenses/LICENSE-2.0')
		print('*')
		print('* Unless required by applicable law or agreed to in writing, software')
		print('* distributed under the License is distributed on an "AS IS" BASIS,')
		print('* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.')
		print('* See the License for the specific language governing permissions and')
		print('* limitations under the License.')
		print()
		print()

		sys.stdout = OG_STDOUT

	def parse(self):
		with open(self.top_spice, 'r') as f:
			lines = f.readlines()
			inckt = 0	

			for line in lines:
				if line.startswith('.subckt') and inckt is 0:
					out_file = open(self.args.dir + line.split(" ")[1] + self.args.extension, 'w')
					self.header(out_file)
					out_file.write(line)
					inckt = 1
					p_count = 0
					n_count = 0
				if inckt is 1 and len(line) > 2 and not line.startswith('.ends') and not line.startswith('.subckt') and not line.startswith('*'):
					line = line.strip()
					line_arr = line.split(" ")
					if ('PMOS' or 'pmos') in line:
						line = line.replace(line_arr[0], f"MP{p_count}")
						p_count += 1
					if ('NMOS' or 'nmos') in line:
						line = line.replace(line_arr[0], f"MN{n_count}")
						n_count += 1

					if not (line.endswith('M=1\n') or (' M=' in line)):
						line = line.replace('\n', '')
						line = line.strip()
						out_file.write(line + " M=1\n")
					else:
						out_file.write(line + "\n")
				if line.startswith('.ends'):
					out_file.write(line)
					inckt = 0
					if self.args.subcircuit:
						out_file.write('\n\n')
						out_file.write('.subckt NMOS d g s b\n')
						out_file.write('.ends\n\n')
						out_file.write('.subckt PMOS_HVT d g s b\n')
						out_file.write('.ends\n')
					out_file.close()

		if not self.args.capitalize:
			process = subprocess.run(["sed -i s/NMOS/nmos/g " + self.args.dir + "* && sed -i s/PMOS_HVT/pmos_hvt/g " + self.args.dir + "*" ], shell=True)

	def main(self):
		self.checkDirExists()
		self.parse()

if __name__ == "__main__":
	ext = ext2indiv()
	ext.main()