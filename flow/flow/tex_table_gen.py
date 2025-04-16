import os
import sys
import subprocess

class table:
	def __init__(self, technologies, inst, tracks, designs):
		self.technologies = technologies
		self.inst = inst
		self.tracks = tracks
		self.designs = designs 

	def power(self, path, design):
		print(f'Power file located here: {path}/{design}_power.rep')
		with open(f'{path}/{design}_power.rep', 'r') as f:
			lines = f.readlines()
			line_found = False
			line_increment = 0

			for line in lines:
				if (line_increment < 2) and line_found:
					line_increment += 1
				if 'Hierarchy' in line:
					line_found = True
				if line_found and f'{design}' in line and line_increment == 2:
					self.power_units = line.split(' ')[-1]
					return line.split(' ')[-2]

			self.power_units = lines[-2].split(' ')[-1]
			return lines[-2].split(" ")[-2]

	def timing(self, path, design):
		print(f'Timing file located here: {path}/{design}_timing.rep')
		with open(f'{path}/{design}_timing.rep', 'r') as f:
			lines = f.readlines()

			for line in lines:
				if 'slack' in line:
					return line.split(' ')[-1]

	def area(self, path, design):
		print(f'Area file located here: {path}/{design}_area.rep')
		with open(f'{path}/{design}_area.rep', 'r') as f:
			lines = f.readlines()

			hierarchy_flag = False

			for line in lines:
				if 'Hierarchical cell' in line:
					hierarchy_flag = True
				if (f'{design}' in line) and hierarchy_flag:
					for ele in line.split(' ')[1:]:
						if len(ele) > 0:
							return ele

	def stdcells(self, path, design):
		print(f'Standard Cell file located here: {path}/{design}_area.rep')
		with open(f'{path}/{design}_area.rep', 'r') as f:
			lines = f.readlines()

			for line in lines:
				if 'Number of cells:' in line:
					return line.split(':')[1]

	def main(self):

		print('Generating Latex Table...')
		print(f'Using the following parameters: \n\tInstances: {str(self.inst)}\n\tTracks: {str(self.tracks)}\n\tDesigns: {str(self.designs)} \n\tPath: {str(os.getcwd())}')

		std_out = sys.stdout

		with open('table.tex', 'w') as f:
			sys.stdout = f

			print('\\documentclass{standalone}')
			print('')
			print('\\begin{document}')
			print('')
			print('\\begin{tabular}{|c|c|c|c|c|c|c|c|c|}')
			print('    \\hline')
			print('    \\textbf{} & \\multicolumn{' + str(4*len(self.technologies)) + '}{{|c|}}{{\\textbf{{Synthesis Results}}}} \\\\')

			print('    \\cline{2-' + str(4*len(self.technologies) + 1) + '}')

			print('    \\textbf{{}} ', end=" ")

			for index, tech in enumerate(self.technologies):
				self.technologies[index] = tech.replace('_', '\_')
				print(f'& \\multicolumn{{4}}{{|c|}}{{\\textbf{{{self.technologies[index]}}}}}', end = "")

			print('\\\\')

			print('    \\cline{2-' + str(4*len(self.technologies) + 1) + '} ')

			print('	\\textbf{Design}', end="")

			for index, tech in enumerate(self.technologies):
				print(' & \\textbf{\\textit{Power (POWER_UNITS)}} & \\textbf{\\textit{Timing (ns)}} & \\textbf{\\textit{Area ($\\mu$m$^2$)}} & \\textbf{\\textit{\\# Std Cells}}', end="")

			print('\\\\ \\hline')

			for tech in self.technologies:
				for design in self.designs:
					design_print = design.replace('_', '\_')

					tech = tech.replace('\\', '')

					print(f'    {design_print}', end=" ")

					sys.stdout = std_out

					try:
						power = self.power(f'../output-files/{tech}/{design}', design)
					except:
						print('Issue with grabbing power information for ' + design)
					try:
						timing = self.timing(f'../output-files/{tech}/{design}', design)
					except:
						print('Issue with grabbing timing information for ' + design)
					try:
						area = self.area(f'../output-files/{tech}/{design}', design)
					except:
						print('Issue with grabbing area information for ' + design)
					try:
						std_cells = self.stdcells(f'../output-files/{tech}/{design}', design)
					except:
						print('Issue with grabbing standard cells information for ' + design)

					# Remove any unwanted characters
					try:
						power = power.replace("\n", "")
					except:
						power = "0"
						print('String issues for power.')
					try:
						timing = timing.replace("\n", "")
					except:
						timing = "0"
						print('String issues for timing.')
					try:
						area = area.replace("\n", "")
					except:
						area = "0"
						print('String issues for area')
					try:
						std_cells = std_cells.replace("\n", "")
						std_cells = std_cells.replace(" ", "")
					except:
						std_cells = "0"
						print('String issues for standard cells.')


					# Format the values to 3 decimal places and add commas
					power = "{:,.3f}".format(float(power))
					timing = "{:,.3f}".format(float(timing))
					area = "{:,.3f}".format(float(area))
					std_cells = "{:,}".format(int(std_cells))

					# Print to the table in LaTeX format
					sys.stdout = f
					print(f'& {power} & {timing} & {area} & {std_cells}', end=" ")
					
					print('\\\\ \\hline')
			
			print('\\end{tabular}')
			print('\\end{document}')

		sys.stdout = std_out

		# Adjust the power units. 
		with open('table.tex', 'r+') as f:
			lines = f.readlines()
			f.seek(0)

			for line in lines:
				if 'POWER_UNITS' in line:
					line = line.replace("POWER_UNITS", self.power_units.replace("\n", ""))
				
				f.write(line)
			
			f.truncate()

		table_out = subprocess.run(['pdflatex table.tex'], shell=True)
		table_png_out = subprocess.run(['pdftoppm -r 300 -png table.pdf >table.png'], shell=True)

if __name__ == '__main__':
	tex_table = table(['OSU130_RHBD'], 'OSU', [''], ['fsm'])
	tex_table.main()
