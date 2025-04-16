import os
import shutil

from osu130rhbd import OSU130RHBD as f1 
from tex_table_gen import table

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
	hdl_top = ['fsm']
	frequency = ['500']
	working_directory = os.getcwd() 

	main(frequency, hdl_top, working_directory)
