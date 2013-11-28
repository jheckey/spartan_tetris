##############################################################################
## Filename:          /home/jheckey/Dropbox/homework/ece253/spartan_tetris/tetris_cpu/drivers/tetris_vga_v1_00_a/data/tetris_vga_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Sat Nov 23 12:11:38 2013 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "tetris_vga" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" 
}
