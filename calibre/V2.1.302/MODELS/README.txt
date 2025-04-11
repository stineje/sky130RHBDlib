##########################################################################################

To set up the models Corners in the Cadence ADE:
   1. As usual, set the Simulation Files to the folder where the model files are.
   2. Next go to Model Libraries:
      a. Add either "models.scs" or "modular_models.scs":
            models.scs        : general models containing all the models for general users.
               For general users.
            modular_models.scs: alternative models, specific group(s) of models: 
               For advanced users only.
               Section "global" must be included
               Modular sections: "fet", "capacitors", "resistors", "bjt", and "diodes"
               WARNING: some models have external component in the subcircuit which requires 
                        additional section(s). For example, high voltage MOS may have a diode
                        which requires additional "diode" section.
      b. Add "parameters.scs" with the following groups: 
            FET        : tt, ff, ss, sf, fs:
            Resistors  : res_nom, res_low, res_high:
            Capacitors : cap_nom, cap_low, cap_high:
   3. Set the global design variables:
      a. corner_factor     : 1 = default, > 1 bigger specs window and vice versa
      b. process_mc_factor : 1 = default, process monte carlo multiplier, > 1 bigger standard deviation
      c. mismatch_factor   : 1 = default, mismatch multiplier,  > 1 bigger mismatch

##########################################################################################

Additional information:
   1. Models-versus-Specs-<flow>.html:
	The model simulation results for QA and comparing the E-test Specs (using the exact 
        test conditions. This report also allows designers to look up E-test name and their
        definitions to go through a data from a lot.
   2. Models-Matchings-<flow>.html:
	The model matching simulation results for QA
   3. Models-Process-MonteCarlo-<flow>.html:
	The model process Monte Carlo simulation results for QA
   4. Corner_Parameters.html:
	The model Corner parameters and section used in the models.
   5. There is a ".git" folder:
	User can use any GIT app to view the detailed changes from one models version to another.
