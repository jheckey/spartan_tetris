@echo off
rem  Vivado(TM)
rem  compile.bat: a Vivado-generated XSim simulation Script
rem  Copyright 1986-1999, 2001-2012 Xilinx, Inc. All Rights Reserved.

set PATH=$XILINX/lib/$PLATFORM:$XILINX/bin/$PLATFORM;/opt/Xilinx/14.3/ISE_DS/EDK/bin/lin64:/opt/Xilinx/14.3/ISE_DS/ISE/bin/lin64:/opt/Xilinx/14.3/ISE_DS/common/bin/lin64;/opt/Xilinx/14.3/ISE_DS/EDK/lib/lin64:/opt/Xilinx/14.3/ISE_DS/ISE/lib/lin64:/opt/Xilinx/14.3/ISE_DS/common/lib/lin64;/opt/Xilinx/Vivado/2012.3/bin;%PATH%
set XILINX_PLANAHEAD=/opt/Xilinx/14.3/ISE_DS/PlanAhead

xelab -m64 --incremental --debug typical --O2 --relax --mt auto -L work -L unisims_ver -L unimacro_ver -L xilinxcorelib_ver -L secureip --snapshot tb_behav --prj /home/jheckey/Dropbox/homework/ece253/spartan_tetris/vga/vga/vga.sim/sim_1/behav/tb.prj   work.tb   work.glbl
if errorlevel 1 (
   cmd /c exit /b %errorlevel%
)
