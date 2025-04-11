import glob


def listDir():
    return glob.glob("./*.spi")

def adjustFile(files):
	for file in files:
		with open(file, 'r') as f:
			lines = f.readlines()
			n_number = 0
			p_number = 0

			for index, line in enumerate(lines):
				if '.subckt' in line:
					name = line.split(' ')[1]
					print(f'Reached subckt {name}')
				elif 'NMOS' in line:
					pattern = line.split(' ')[0]
					line = line.replace(pattern, f'MN{n_number}')
					print(f'Adjusting line number {index} in {file} subckt {name}.')
					n_number += 1
				elif 'PMOS' in line:
					pattern = line.split(' ')[0]
					line = line.replace(pattern, f'MP{p_number}')
					print(f'Adjusting line number {index} in {file} subckt {name}.')
					p_number += 1
				elif '.ends' in line:
					print(f'End of subckt {name}')
					n_number = 0
					p_number = 0
				
				lines[index] = line

		with open(file, 'w') as f:
			f.writelines(lines)

if __name__ == '__main__':
	adjustFile(listDir())