import os
import shutil
import re

from osu130rhbd import OSU130RHBD as f1 
from tex_table_gen import table

def parseEnviron(key : str):
	print(f'{key} : is active.')
	array = []
	var = os.getenv(key)

	# Replace all unncessary characters with an empty character. Helpful for turning the input variables into an array.
	var = re.sub(r'[\[\]\'\"\s]', '', var)
	
	# Turns the values into an array.
	for s in var.split(','):
		array.append(str(s))
	
	return array

def main(frequency, hdl_top, working_directory):
	flow1 = f1(PNR_FLAG=True)

	tex_table = table(['OSU130_RHBD'], 'OSU', [''], hdl_top)

	for freq, top in zip(frequency, hdl_top):
		flow1.main(top, freq, working_directory)
	
	os.chdir(working_directory)
	
	tex_table.main()

	shutil.move('table.tex', f'../output-files/OSU130_RHBD/')
	shutil.move('table.pdf', f'../output-files/OSU130_RHBD/')
	shutil.move('table.log', f'../output-files/OSU130_RHBD/')
	shutil.move('table.png', f'../output-files/OSU130_RHBD/')
	shutil.move('table.aux', f'../output-files/OSU130_RHBD/')

if __name__ == '__main__':
	# Selects the values based on environment variables or manual input.
	hdl_top = ['fsm'] if os.getenv('HDL_TOP') == None else parseEnviron('HDL_TOP')
	frequency = ['500'] if os.getenv('FREQUENCY') == None else parseEnviron('FREQUENCY')

	working_directory = os.getcwd() 

	main(frequency, hdl_top, working_directory)
