import os
import subprocess
import shutil
import glob
import traceback

#This script is used to run through the characterization process with synthesis and pnr done post
#characterization.
class OSU130RHBD:
	def __init__(self, PNR_FLAG=True):
		self.technology = 'OSU130_RHBD'

		self.vddName = 'VDD'
		self.gndName = 'GND'
		self.pnr_flag = PNR_FLAG

		# These options are used for the PNR portion of the flow.
		self.libFile = ["sky130_rhbd_tt_1P8_25C.ccs.lib"]
		self.abstFile = 'sky130_rhbd'

		self.fillList = ['FILL1']

	def synth(self):
		os.chdir(f'{self.scriptHome}/synth/scripts')

		make = subprocess.run(['make purge'], shell=True)

		out = open('synth.tcl', 'w')
  
		with open('synth.tcl.template', 'r') as f:
			lines = f.readlines()

			for line in lines:
				if 'HDL_TOP' in line:
					line = line.replace('HDL_TOP', self.hdl_top)
				if 'FREQ_TARGET' in line:
					line = line.replace('FREQ_TARGET', self.frequency)
				if 'CLK' in line:
					line = line.replace('CLK', 'clk')
				
				out.write(line)
					
		
		# Closes the synth.tcl file. This is needed in order to successfully run through synthesis
		# without failure. 
		out.close()

		# Changes directory to top level synthesis directory in preparation of running synthesis.
		os.chdir('../')

		out = open('.synopsys_dc.setup', 'w')

		with open('.synopsys_dc.setup.template', 'r') as f:
			lines = f.readlines()

			for line in lines:
				if 'LIBRARY_NAME' in line:
					line = line.replace('LIBRARY_NAME', 'sky130_rhbd')
				out.write(line)
			
		out.close()

		synth = subprocess.run(['make synth'], shell=True)

		os.makedirs(os.path.dirname(f'{self.scriptHome}/../output-files/{self.technology}/{self.hdl_top}/'), exist_ok=True)

		shutil.copy(f'./mapped/{self.hdl_top}.sdc', f'{self.scriptHome}/../output-files/{self.technology}/{self.hdl_top}/')
		shutil.copy(f'./mapped/{self.hdl_top}.vh', f'{self.scriptHome}/../output-files/{self.technology}/{self.hdl_top}/')
		shutil.copy(f'./synth.out', f'{self.scriptHome}/../output-files/{self.technology}/{self.hdl_top}/')

		for file in glob.glob(r'./reports/*.rep'):
			shutil.copy(file, f'{self.scriptHome}/../output-files/{self.technology}/{self.hdl_top}/{file.split("/")[-1]}')

		os.chdir(self.scriptHome)

	def pnr(self):
		os.chdir(f'{self.scriptHome}/pnr/')
		make = subprocess.run(['./clean_me.csh'], shell=True)

		out = open('setup.tcl', 'w')

		LIB_FILE_COPY = self.libFile.copy()
		
		with open('setup.tcl.template', 'r') as f:
			lines = f.readlines()

			for line in lines:
				if 'LIB_FILE' in line:
					line = line.replace('LIB_FILE', LIB_FILE_COPY.pop(0))
				if 'ABSTRACT_FILE' in line:
					line = line.replace('ABSTRACT_FILE', self.abstFile)
				if 'VDD_NAME' in line:
					line = line.replace('VDD_NAME', self.vddName)
				if 'GND_NAME' in line:
					line = line.replace('GND_NAME', self.gndName)
				if 'HDL_TOP' in line:
					line = line.replace('HDL_TOP', self.hdl_top)

				out.write(line)	

		out.close()

		out = open('innovus_config.tcl', 'w')

		with open('innovus_config.tcl.template', 'r') as f:
			lines = f.readlines()

			for line in lines:
				if 'FILL_CELLS' in line:
					line = line.replace('FILL_CELLS', " ".join(self.fillList))
				out.write(line)
		
		out.close()

		make = subprocess.run(['make'], shell=True)

		shutil.copy(f'./final.gds', f'{self.scriptHome}/../output-files/{self.technology}/{self.hdl_top}/{self.hdl_top}.gds')
		shutil.copy(f'./final.v', f'{self.scriptHome}/../output-files/{self.technology}/{self.hdl_top}/{self.hdl_top}.v')
		shutil.copy(f'./final.sdf', f'{self.scriptHome}/../output-files/{self.technology}/{self.hdl_top}/{self.hdl_top}.sdf')

		for file in glob.glob(r'./RPT/*signoff*'):
			shutil.copy(file, f'{self.scriptHome}/../output-files/{self.technology}/{self.hdl_top}/')
		for file in glob.glob(r'./RPT/*area*'):
			shutil.copy(file, f'{self.scriptHome}/../output-files/{self.technology}/{self.hdl_top}/')
		for file in glob.glob(r'./RPT/*main*'):
			shutil.copy(file, f'{self.scriptHome}/../output-files/{self.technology}/{self.hdl_top}/')

		try:
			shutil.copytree('./DBS/', f'{self.scriptHome}/../output-files/{self.technology}/{self.hdl_top}/DBS/')
		except FileNotFoundError:
			print('DBS not found')
		except Exception as e:
			print(f'Exception for DBS movement : {e}')
		
		gzip = subprocess.run([f'gzip -d {self.scriptHome}/../output-files/{self.technology}/{self.hdl_top}/*.gz'], shell=True)
		os.chdir(self.scriptHome + '/../')

	def main(self, hdl_top, frequency, cwd):
		self.hdl_top = hdl_top
		self.frequency = frequency
		self.scriptHome = cwd
		os.chdir(self.scriptHome)

		if(not os.path.exists(f'../output-files/{self.technology}/{hdl_top}/')):
			os.makedirs(f'../output-files/{self.technology}/{hdl_top}/')
			os.chdir(self.scriptHome + '/../')

		self.synth()

		if(self.pnr_flag):
			self.pnr()
		
		os.chdir(self.scriptHome + '/../')

if __name__ == '__main__':
	#Sets up the .lib and .db file names needed for PNR and Synthesis
	frequency = '500'
	hdl_top = 'fsm'

	flow = OSU130RHBD()
	working_directory = os.getcwd()

	flow.main(frequency=frequency, hdl_top=hdl_top, cwd=working_directory)
