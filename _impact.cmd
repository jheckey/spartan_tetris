setMode -bs
setMode -bs
setMode -bs
setMode -bs
setCable -port auto
Identify -inferir 
identifyMPM 
assignFile -p 1 -file "/home/jheckey/Dropbox/homework/ece253/spartan_tetris/tetris_cpu/implementation/system.bit"
assignFile -p 2 -file "/home/jheckey/Dropbox/homework/ece253/spartan_tetris/tetris_cpu/implementation/tetris.mcs"
setAttribute -position 2 -attr packageName -value ""
ReadIdcode -p 2 
Program -p 2 -e -v -loadfpga 
setMode -pff
setMode -pff
addConfigDevice  -name "spi_tetris" -path "/home/jheckey/Dropbox/homework/ece253/spartan_tetris/tetris_cpu/implementation/"
setSubmode -pffspi
setAttribute -configdevice -attr multibootBpiType -value ""
addDesign -version 0 -name "0"
setMode -pff
addDeviceChain -index 0
setMode -pff
addDeviceChain -index 0
setAttribute -configdevice -attr compressed -value "FALSE"
setAttribute -configdevice -attr compressed -value "FALSE"
setAttribute -configdevice -attr autoSize -value "FALSE"
setAttribute -configdevice -attr fileFormat -value "mcs"
setAttribute -configdevice -attr fillValue -value "FF"
setAttribute -configdevice -attr swapBit -value "FALSE"
setAttribute -configdevice -attr dir -value "UP"
setAttribute -configdevice -attr multiboot -value "FALSE"
setAttribute -configdevice -attr multiboot -value "FALSE"
setAttribute -configdevice -attr spiSelected -value "TRUE"
setAttribute -configdevice -attr spiSelected -value "TRUE"
addPromDevice -p 1 -size 2048 -name 2M
setMode -pff
setMode -pff
setMode -pff
setMode -pff
addDeviceChain -index 0
setMode -pff
addDeviceChain -index 0
setSubmode -pffspi
setMode -pff
setAttribute -design -attr name -value "0000"
addDevice -p 1 -file "/home/jheckey/Dropbox/homework/ece253/spartan_tetris/tetris_cpu/implementation/system.bit"
setMode -pff
setSubmode -pffspi
generate
setCurrentDesign -version 0
setMode -bs
setMode -bs
setMode -bs
attachflash -position 1 -spi "M25P16"
assignfiletoattachedflash -position 1 -file "/home/jheckey/Dropbox/homework/ece253/spartan_tetris/tetris_cpu/implementation/spi_tetris.mcs"
setMode -pff
setMode -pff
setMode -pff
setMode -bs
setMode -bs
setMode -bs
setCable -port auto
Program -p 1 -dataWidth 1 -spionly -e -v -loadfpga 
setMode -bs
setMode -bs
setMode -ss
setMode -sm
setMode -hw140
setMode -spi
setMode -acecf
setMode -acempm
setMode -pff
setMode -bs
saveProjectFile -file "/home/jheckey/Dropbox/homework/ece253/spartan_tetris/tetris_cpu/implementation/tetris.ipf"
setMode -bs
setMode -pff
setMode -bs
deleteDevice -position 1
deleteDevice -position 1
deleteDevice -position 1
setMode -bs
setMode -ss
setMode -sm
setMode -hw140
setMode -spi
setMode -acecf
setMode -acempm
setMode -pff
deletePromDevice -position 1
setCurrentDesign -version 0
deleteDevice -position 1
deleteDesign -version 0
setCurrentDesign -version -1
