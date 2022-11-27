### SPICE Extraction 
##########################################################
# Options:                                               #
#   * scale off     : Doesn't work for some reason.      #
#   * extresist on  : Uses the .res.ext file to include. #
#                     resistances in the extracted SPICE #
#                     file.                              #
#                                                        #
#   * -F : Don't output nodes that are floating.         #
#   * -m : Conservative merging of devices (folded fets).#
#   * -f hspice : Outputs spice format.                  #
##########################################################
ext2spice scale off                                                             
ext2spice -F -m -f hspice
