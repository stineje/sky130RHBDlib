# Liberate Template Example Tcl File - Sept 2008

set lowSlew 0.14
set highSlew 0.86

# Set the maximum output transition time allowed
set_var max_transition 1e-8

set fp [open "celllist"]
set cells [regexp -all -inline {\S+} [read $fp]]
#set cells "INVX1"

close $fp

define_template -type delay \
        -index_1        {0.1000 0.5000 1.2000 3.0000 4.0000 5.0000} \
        -index_2        {0.0600 0.2400 0.4800 0.9000 1.2000 1.8000} \
        delay_template

define_template -type power \
        -index_1        {0.1000 0.5000 1.2000 3.0000 4.0000 5.0000} \
        -index_2        {0.0600 0.2400 0.4800 0.9000 1.2000 1.8000} \
        power_template

define_template -type constraint \
        -index_1  {0.1  2.50  5.00} \
        -index_2  {0.1  0.90  1.80} \
        constraint_template

set inputs  {A B C} 
set outputs {Y Q QN} 
set clocks  {CLK}
set asyncs  {RN SN}

define_cell \
        -input $inputs  -output $outputs  -clock $clocks  -async $asyncs \
        -constraint  constraint_template    \
        -delay       delay_template \
        -power       power_template \
        $cells

#set_constraint_criteria -cells {DFFSX1 DFFRX1 DFFX1 DFFNX1} -delay_degrade 0.5
#set constraint_search_bound_estimation_mode 3
#set constraint_search_bound 20
