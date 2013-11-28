
?
Feature available: %s
81*common2
ImplementationZ17-81
:
Feature available: %s
81*common2
	SynthesisZ17-81
{
+Loading parts and site information from %s
36*device27
5/opt/Xilinx/14.3/ISE_DS/PlanAhead/data/parts/arch.xmlZ21-36
à
!Parsing RTL primitives file [%s]
14*netlist2M
K/opt/Xilinx/14.3/ISE_DS/PlanAhead/data/parts/xilinx/rtl/prims/rtl_prims.xmlZ29-14
ë
*Finished parsing RTL primitives file [%s]
11*netlist2M
K/opt/Xilinx/14.3/ISE_DS/PlanAhead/data/parts/xilinx/rtl/prims/rtl_prims.xmlZ29-11
/

Starting synthesis...

3*	vivadotclZ4-3
s
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2
	xc7vx485tZ17-347
c
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2
	xc7vx485tZ17-349
c
WUsing Xilinx IP in: /opt/Xilinx/14.3/ISE_DS/ISE/coregen/ip/xilinx/primary/com/xilinx/ip*common


*common
É
%s*synth2t
rstarting synthesize : Time (s): cpu = 00:00:10 ; elapsed = 00:00:10 . Memory (MB): peak = 171.988 ; gain = 60.723

É
synthesizing module '%s'638*oasys2
tb2A
=/home/jheckey/Dropbox/homework/ece253/spartan_tetris/vga/tb.v2
28@Z8-638
Ö
synthesizing module '%s'638*oasys2
vga2B
>/home/jheckey/Dropbox/homework/ece253/spartan_tetris/vga/vga.v2
28@Z8-638
ú
%done synthesizing module '%s' (%s#%s)256*oasys2
vga2
12
32B
>/home/jheckey/Dropbox/homework/ece253/spartan_tetris/vga/vga.v2
28@Z8-256
ã
synthesizing module '%s'638*oasys2
siggen2E
A/home/jheckey/Dropbox/homework/ece253/spartan_tetris/vga/siggen.v2
28@Z8-638
¢
%done synthesizing module '%s' (%s#%s)256*oasys2
siggen2
22
32E
A/home/jheckey/Dropbox/homework/ece253/spartan_tetris/vga/siggen.v2
28@Z8-256
è
+always block has no event control specified85*oasys2A
=/home/jheckey/Dropbox/homework/ece253/spartan_tetris/vga/tb.v2
538@Z8-85
∑
.merging register '%s' into '%s' in module '%s'3423*oasys2
	clear_reg2

enable_reg2
tb2A
=/home/jheckey/Dropbox/homework/ece253/spartan_tetris/vga/tb.v2
458@Z8-3845
ö
%done synthesizing module '%s' (%s#%s)256*oasys2
tb2
32
32A
=/home/jheckey/Dropbox/homework/ece253/spartan_tetris/vga/tb.v2
28@Z8-256
Ñ
%s*synth2u
sfinished synthesize : Time (s): cpu = 00:00:22 ; elapsed = 00:00:23 . Memory (MB): peak = 462.340 ; gain = 351.074



*common
]
Q---------------------------------------------------------------------------------*common


*common
/
#Loading Part and Timing Information*common


*common
]
Q---------------------------------------------------------------------------------*common


*common
,
 Loading part: xc7vx485tffg1157-1*common


*common
ñ
Loading clock regions from %s
13*device2_
]/opt/Xilinx/14.3/ISE_DS/PlanAhead/data/parts/xilinx/virtex7/virtex7/xc7vx485t/ClockRegion.xmlZ21-13
ó
Loading clock buffers from %s
11*device2`
^/opt/Xilinx/14.3/ISE_DS/PlanAhead/data/parts/xilinx/virtex7/virtex7/xc7vx485t/ClockBuffers.xmlZ21-11
í
&Loading clock placement rules from %s
318*place2R
P/opt/Xilinx/14.3/ISE_DS/PlanAhead/data/parts/xilinx/virtex7/ClockPlacerRules.xmlZ30-318
ê
)Loading package pin functions from %s...
17*device2N
L/opt/Xilinx/14.3/ISE_DS/PlanAhead/data/parts/xilinx/virtex7/PinFunctions.xmlZ21-17
î
Loading package from %s
16*device2c
a/opt/Xilinx/14.3/ISE_DS/PlanAhead/data/parts/xilinx/virtex7/virtex7/xc7vx485t/ffg1157/Package.xmlZ21-16
Ö
Loading io standards from %s
15*device2O
M/opt/Xilinx/14.3/ISE_DS/PlanAhead/data/./parts/xilinx/virtex7/IOStandards.xmlZ21-15
ë
+Loading device configuration modes from %s
14*device2M
K/opt/Xilinx/14.3/ISE_DS/PlanAhead/data/parts/xilinx/virtex7/ConfigModes.xmlZ21-14
å
/Loading list of drcs for the architecture : %s
17*drc2G
E/opt/Xilinx/14.3/ISE_DS/PlanAhead/data/./parts/xilinx/virtex7/drc.xmlZ23-17
}
%s*synth2n
lPart Resources:
DSPs: 2800 (col length:140)
BRAMs: 2060 (col length: RAMB8 0 RAMB16 0 RAMB18 140 RAMB36 70)

]
Q---------------------------------------------------------------------------------*common


*common
ü
%s*synth2è
åFinished Loading Part and Timing Information : Time (s): cpu = 00:00:37 ; elapsed = 00:00:37 . Memory (MB): peak = 610.488 ; gain = 499.223

]
Q---------------------------------------------------------------------------------*common


*common


*common
&
No constraint files found.*common


*common


*common
]
Q---------------------------------------------------------------------------------*common


*common
%
RTL Component Statistics *common


*common
]
Q---------------------------------------------------------------------------------*common


*common
0
%s*synth2!
Detailed RTL Component Info : 


%s*synth2
+---Adders : 

?
%s*synth20
.	   2 Input     32 Bit       Adders := 1     

?
%s*synth20
.	   2 Input     11 Bit       Adders := 2     

?
%s*synth20
.	   2 Input     10 Bit       Adders := 2     

"
%s*synth2
+---Registers : 

?
%s*synth20
.	               48 Bit    Registers := 2     

?
%s*synth20
.	               32 Bit    Registers := 1     

?
%s*synth20
.	               11 Bit    Registers := 2     

?
%s*synth20
.	               10 Bit    Registers := 1     

?
%s*synth20
.	                1 Bit    Registers := 6     


%s*synth2
+---Muxes : 

?
%s*synth20
.	   2 Input     32 Bit        Muxes := 1     

?
%s*synth20
.	   2 Input      1 Bit        Muxes := 7     



*common
]
Q---------------------------------------------------------------------------------*common


*common
.
"Finished RTL Component Statistics *common


*common
]
Q---------------------------------------------------------------------------------*common


*common


*common
]
Q---------------------------------------------------------------------------------*common


*common
-
!Start Cross Boundary Optimization*common


*common
]
Q---------------------------------------------------------------------------------*common


*common
É
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[0] 2
reg__8Z8-3332
É
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[1] 2
reg__8Z8-3332
É
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[2] 2
reg__8Z8-3332
É
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[3] 2
reg__8Z8-3332
É
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[4] 2
reg__8Z8-3332
É
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[5] 2
reg__8Z8-3332
É
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[6] 2
reg__8Z8-3332
É
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[7] 2
reg__8Z8-3332
É
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[8] 2
reg__8Z8-3332
É
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[9] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[10] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[11] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[12] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[13] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[14] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[15] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[16] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[17] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[18] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[19] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[20] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[21] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[22] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[23] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[24] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[25] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[26] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[27] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[28] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[29] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[30] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[31] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[32] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[33] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[34] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[35] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[36] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[37] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[38] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[39] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[40] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[41] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[42] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[43] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[44] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[45] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[46] 2
reg__8Z8-3332
Ñ
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\siggen1/pixels_reg[47] 2
reg__8Z8-3332
]
Q---------------------------------------------------------------------------------*common


*common
ó
%s*synth2á
ÑFinished Cross Boundary Optimization : Time (s): cpu = 00:00:37 ; elapsed = 00:00:37 . Memory (MB): peak = 611.520 ; gain = 500.254

]
Q---------------------------------------------------------------------------------*common


*common


*common


*common
]
Q---------------------------------------------------------------------------------*common


*common
#
Start Area Optimization*common


*common
]
Q---------------------------------------------------------------------------------*common


*common
m
6propagating constant %s across sequential element (%s)3333*oasys2
02
\vga1/buffer_reg[45] Z8-3333
b
6propagating constant %s across sequential element (%s)3333*oasys2
02

enable_regZ8-3333
m
6propagating constant %s across sequential element (%s)3333*oasys2
02
\vga1/buffer_reg[45] Z8-3333
m
6propagating constant %s across sequential element (%s)3333*oasys2
02
\vga1/buffer_reg[45] Z8-3333
m
6propagating constant %s across sequential element (%s)3333*oasys2
02
\vga1/buffer_reg[45] Z8-3333
m
6propagating constant %s across sequential element (%s)3333*oasys2
02
\vga1/buffer_reg[45] Z8-3333
m
6propagating constant %s across sequential element (%s)3333*oasys2
02
\vga1/buffer_reg[45] Z8-3333
m
6propagating constant %s across sequential element (%s)3333*oasys2
02
\vga1/buffer_reg[45] Z8-3333
m
6propagating constant %s across sequential element (%s)3333*oasys2
02
\vga1/buffer_reg[45] Z8-3333
m
6propagating constant %s across sequential element (%s)3333*oasys2
02
\vga1/buffer_reg[45] Z8-3333
m
6propagating constant %s across sequential element (%s)3333*oasys2
02
\vga1/buffer_reg[45] Z8-3333
m
6propagating constant %s across sequential element (%s)3333*oasys2
02
\vga1/buffer_reg[45] Z8-3333
m
6propagating constant %s across sequential element (%s)3333*oasys2
02
\vga1/buffer_reg[45] Z8-3333
m
6propagating constant %s across sequential element (%s)3333*oasys2
02
\vga1/buffer_reg[45] Z8-3333
m
6propagating constant %s across sequential element (%s)3333*oasys2
02
\vga1/buffer_reg[45] Z8-3333
m
6propagating constant %s across sequential element (%s)3333*oasys2
02
\vga1/buffer_reg[45] Z8-3333
m
6propagating constant %s across sequential element (%s)3333*oasys2
02
\vga1/buffer_reg[45] Z8-3333
x
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\vga1/vga_B_reg 2
tbZ8-3332
Ø
ÅMessage '%s' appears more than %s times and has been disabled. User can change this message limit to see more message instances.
14*common2
Synth 8-33322
50Z17-14
|
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\vga1/buffer_reg[0] 2
tbZ8-3332
&
No constraint files found.*common


*common
]
Q---------------------------------------------------------------------------------*common


*common
ã
%s*synth2|
zFinished Area Optimization : Time (s): cpu = 00:00:37 ; elapsed = 00:00:37 . Memory (MB): peak = 633.574 ; gain = 522.309

]
Q---------------------------------------------------------------------------------*common


*common


*common


*common
]
Q---------------------------------------------------------------------------------*common


*common
%
Start Timing Optimization*common


*common
]
Q---------------------------------------------------------------------------------*common


*common
&
No constraint files found.*common


*common
]
Q---------------------------------------------------------------------------------*common


*common
ç
%s*synth2~
|Finished Timing Optimization : Time (s): cpu = 00:00:37 ; elapsed = 00:00:37 . Memory (MB): peak = 633.574 ; gain = 522.309

]
Q---------------------------------------------------------------------------------*common


*common


*common


*common
]
Q---------------------------------------------------------------------------------*common


*common
$
Start Technology Mapping*common


*common
]
Q---------------------------------------------------------------------------------*common


*common
]
Q---------------------------------------------------------------------------------*common


*common
å
%s*synth2}
{Finished Technology Mapping : Time (s): cpu = 00:00:37 ; elapsed = 00:00:37 . Memory (MB): peak = 633.574 ; gain = 522.309

]
Q---------------------------------------------------------------------------------*common


*common


*common


*common
]
Q---------------------------------------------------------------------------------*common


*common

Start IO Insertion*common


*common
]
Q---------------------------------------------------------------------------------*common


*common


*common
]
Q---------------------------------------------------------------------------------*common


*common
0
$Start Flattening Before IO Insertion*common


*common
]
Q---------------------------------------------------------------------------------*common


*common


*common
]
Q---------------------------------------------------------------------------------*common


*common
3
'Finished Flattening Before IO Insertion*common


*common
]
Q---------------------------------------------------------------------------------*common


*common


*common
]
Q---------------------------------------------------------------------------------*common


*common
!
Final Netlist Cleanup*common


*common
]
Q---------------------------------------------------------------------------------*common


*common


*common
]
Q---------------------------------------------------------------------------------*common


*common
*
Finished Final Netlist Cleanup*common


*common
]
Q---------------------------------------------------------------------------------*common


*common