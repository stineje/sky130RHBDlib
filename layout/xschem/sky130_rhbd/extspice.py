import subprocess
import traceback
import shutil
import os
import argparse

class extspice():
	def __init__(self):
		self.files = os.listdir()
		self.commandLineParser()

		first_hit = False
		directory = ''

        # Cycles through the files inputted on the command line. 
		for arg in self.args.files:
			if ('.sch' in arg) and (not first_hit):
				self.schemlist = []
				self.schemlist.append(arg.split('/')[-1])
				directory = arg.split('/')[:-1]
				first_hit = True
			if ('.sch' in arg) and (first_hit):
				self.schemlist.append(arg.split('/')[-1])
		
		if self.args.files == []:
			self.schemlist = self.files.copy()
		
		if len(self.schemlist) == 0:
			print('No schematic files found.')
			exit()

		self.schemlist.sort()

		# Removes duplicates from the list of cells.
		self.schemlist = list(set(self.schemlist))

		# Joins the directory back together into a string. 
		if directory != '':
			directory = "/".join(directory)
		else:
			directory = self.args.directory

		for i, cell in enumerate(self.schemlist):
			if (directory != ''):
				self.schemlist[i] = directory + '/' + cell
			else:
				self.schemlist[i] = self.args.directory + cell

	def commandLineParser(self):
		parser = argparse.ArgumentParser(description='Extracts spice files from xschem schematics.')
		parser.add_argument('files', metavar='files', type=str, nargs='*', help='Schematic files to extract spice from.') 
		parser.add_argument('-m', '--move', action='store_true', help='Moves extracted spice files to the spice directory.')
		parser.add_argument('-d', '--directory', type=str, help='Directory of the input schematic files.', default='./')

		self.args = parser.parse_args()

	def moveFiles(self):
		names = ['.spice']
		files = os.listdir()

		for f in files:
			for s in names:
				if s in f and '.swp' not in f:
					if not os.path.exists(s.split(".")[1]):
						os.mkdir(s.split(".")[1])
					shutil.move(f'./{f}', f'./{s.split(".")[1]}/{f}')
	
	def runXschem(self):
		for f in self.files:
			if '.sch' in f and '.swp' not in f:
				print(f'Current schematic file: {f}')
				try:
					print(f'Extracting spice from {f.split(".")[0]}.')
					subout = subprocess.Popen([f'xschem -n -o . ./{f} -q'], shell=True) 
					subout.wait()
				except Exception:
					print(traceback.print_exc())

if __name__ == '__main__':
	extspice = extspice()

	if(len(extspice.args.files) > 0):
		extspice.files = extspice.args.files

	extspice.runXschem()

	if extspice.args.move:
		extspice.moveFiles()
