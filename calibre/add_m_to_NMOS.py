import glob
import sys

def listDir():
    return glob.glob("./output/spice/*.spi")

def adjustFile(files):
	for file in files:
		print('Adjusting file: ' + file)
		with open(file, 'r') as f:
			lines = f.readlines()
			# The wait variable will signal that the next line is the line to be used to append the
			# m=1 parameter.
			wait = False

			for index, line in enumerate(lines):
				if 'NMOS ' in line and not line.endswith('\\\n'):
					line = line.replace('\n', '')
					line += ' m=1\n'
					print(f'NMOS adjusted on line {index}')
				elif 'NMOS ' in line and line.endswith('\\\n'):
					wait = True
				elif wait:
					line = line.replace('\n', '')
					line += ' m=1\n'
					print(f'NMOS adjusted on line {index}')
					wait = False

				lines[index] = line

		with open(file, 'w') as f:
			f.writelines(lines)

if __name__ == '__main__':
	adjustFile(listDir())
