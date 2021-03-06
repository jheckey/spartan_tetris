# 
# Synthesis run script generated by Vivado
# 

namespace eval rt {
    variable rc
}
set rt::rc [catch {
  uplevel #0 {
    source $::env(HRT_TCL_PATH)/rtSynthPrep.tcl
    set rt::cmdEcho 0
    rt::set_parameter writeXmsg true
    if { [ info exists ::env(RT_TMP) ] } {
      file delete -force $::env(RT_TMP)
      file mkdir $::env(RT_TMP)
    }

    rt::delete_design

    set rt::partid xc7vx485tffg1157-1

    set ::env(BUILTIN_SYNTH) true
    source $::env(SYNTH_COMMON)/common.tcl

    rt::read_verilog {
    /home/jheckey/Dropbox/homework/ece253/spartan_tetris/vga/vga.v
    /home/jheckey/Dropbox/homework/ece253/spartan_tetris/vga/siggen.v
    /home/jheckey/Dropbox/homework/ece253/spartan_tetris/vga/tb.v
  }
    rt::set_parameter usePostFindUniquification false
    set rt::top tb
    set rt::reportTiming false
    rt::set_parameter elaborateOnly false
    rt::set_parameter elaborateRtl false
    rt::set_parameter eliminateRedundantBitOperator true
    rt::set_parameter writeBlackboxInterface true
    rt::set_parameter merge_flipflops true
    rt::run_synthesis -module $rt::top

    set rt::flowresult [ source $::env(SYNTH_COMMON)/flow.tcl ]
    if { $rt::flowresult == 1 } { return -code error }

    if { [ info exists ::env(RT_TMP) ] } {
      file delete -force $::env(RT_TMP)
    }


    source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  } ; #end uplevel
} rt::result]

if { $rt::rc } {
  return -code "error" $rt::result
}
