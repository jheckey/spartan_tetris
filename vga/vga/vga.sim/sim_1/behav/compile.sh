#!/bin/sh
# Vivado(TM)
# compile.sh: Vivado-generated Script for launching XSim application
# Copyright 1986-1999, 2001-2012 Xilinx, Inc. All Rights Reserved.
# 
if [ -z "$PATH" ]; then
  PATH=$XILINX/lib/$PLATFORM:$XILINX/bin/$PLATFORM:/opt/Xilinx/14.3/ISE_DS/EDK/bin/lin64:/opt/Xilinx/14.3/ISE_DS/ISE/bin/lin64:/opt/Xilinx/14.3/ISE_DS/common/bin/lin64
else
  PATH=$XILINX/lib/$PLATFORM:$XILINX/bin/$PLATFORM:/opt/Xilinx/14.3/ISE_DS/EDK/bin/lin64:/opt/Xilinx/14.3/ISE_DS/ISE/bin/lin64:/opt/Xilinx/14.3/ISE_DS/common/bin/lin64:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=$XILINX/lib/$PLATFORM:/opt/Xilinx/14.3/ISE_DS/EDK/lib/lin64:/opt/Xilinx/14.3/ISE_DS/ISE/lib/lin64:/opt/Xilinx/14.3/ISE_DS/common/lib/lin64
else
  LD_LIBRARY_PATH=$XILINX/lib/$PLATFORM:/opt/Xilinx/14.3/ISE_DS/EDK/lib/lin64:/opt/Xilinx/14.3/ISE_DS/ISE/lib/lin64:/opt/Xilinx/14.3/ISE_DS/common/lib/lin64:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

#
# Setup env for Xilinx simulation libraries
#
XILINX_PLANAHEAD=/opt/Xilinx/14.3/ISE_DS/PlanAhead
export XILINX_PLANAHEAD
ExecStep()
{
   "$@"
   RETVAL=$?
   if [ $RETVAL -ne 0 ]
   then
       exit $RETVAL
   fi
}

ExecStep xelab -m64 --incremental --debug typical --O2 --relax --mt auto -L work -L unisims_ver -L unimacro_ver -L xilinxcorelib_ver -L secureip --snapshot tb_behav --prj /home/jheckey/Dropbox/homework/ece253/spartan_tetris/vga/vga/vga.sim/sim_1/behav/tb.prj   work.tb   work.glbl
