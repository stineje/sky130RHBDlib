#extract do all
#
#ext2sim labels on
##ext2sim cthresh 0.0001
##ext2sim merge conservative
#ext2sim -F
#
#extresist tolerance 1
##extresist all
#
#ext2spice scale off
##ext2spice cthresh 0.0001
#ext2spice extresist on
#ext2spice -F -f hspice
####################

##########################################
#extract all
#
#ext2sim labels on
#ext2sim cthresh 0.0001
#ext2sim -F
##ext2sim -R -C -o tmp.sim
#
#extresist tolerance 10
#extresist
##########################################
# Quit and run\
# cat tut8r.ext tut8r.res.ext
# tut8r.2.ext

ext2spice scale off                                                             
ext2spice extresist on                                                          
ext2spice cthresh 0.0001                                                        
ext2spice -F -m -f spice3                                                       
###############################################                                 
                                                                                
gds                                                                             
lef writeall
