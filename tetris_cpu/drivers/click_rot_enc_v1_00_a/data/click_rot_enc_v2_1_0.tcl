##############################################################################
## Filename:          /home/jheckey/Dropbox/homework/ece253/spartan_tetris/tetris_cpu/drivers/click_rot_enc_v1_00_a/data/click_rot_enc_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Sat Nov 30 11:22:31 2013 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "click_rot_enc" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" 
}
