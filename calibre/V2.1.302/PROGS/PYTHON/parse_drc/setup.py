# -*- coding: utf-8 -*-

# A very simple setup script to create a single executable
#
# hello.py is a very simple 'Hello, world' type script which also displays the
# environment in which the script runs
#
# Run the build process by running the command 'python setup.py build'
#
# If everything works well you should find a subdirectory in the build
# subdirectory that contains the files needed to run the script without Python
#      description='Parses Spectre assertions.',

from cx_Freeze import setup, Executable

executables = [ Executable('parse_drc.py') ]

setup(name='parse_drc',
      version='0.1',
      executables=executables)
