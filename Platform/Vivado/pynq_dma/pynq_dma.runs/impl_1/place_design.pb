
O
*Debug cores have already been implemented
153*	chipscopeZ16-240h px? 
Q
Command: %s
53*	vivadotcl2 
place_design2default:defaultZ4-113h px? 
?
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7z0202default:defaultZ17-347h px? 
?
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7z0202default:defaultZ17-349h px? 
P
Running DRC with %s threads
24*drc2
82default:defaultZ23-27h px? 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px? 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px? 
p
,Running DRC as a precondition to command %s
22*	vivadotcl2 
place_design2default:defaultZ4-22h px? 
P
Running DRC with %s threads
24*drc2
82default:defaultZ23-27h px? 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px? 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px? 
U

Starting %s Task
103*constraints2
Placer2default:defaultZ18-103h px? 
}
BMultithreading enabled for place_design using a maximum of %s CPUs12*	placeflow2
82default:defaultZ30-611h px? 
v

Phase %s%s
101*constraints2
1 2default:default2)
Placer Initialization2default:defaultZ18-101h px? 
?

Phase %s%s
101*constraints2
1.1 2default:default29
%Placer Initialization Netlist Sorting2default:defaultZ18-101h px? 
?
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:00.012default:default2
00:00:00.012default:default2
3341.4022default:default2
0.0002default:default2
32082default:default2
300402default:defaultZ17-722h px? 
Z
EPhase 1.1 Placer Initialization Netlist Sorting | Checksum: d2c710ed
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:00.01 ; elapsed = 00:00:00.04 . Memory (MB): peak = 3341.402 ; gain = 0.000 ; free physical = 3208 ; free virtual = 300402default:defaulth px? 
?
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:00.012default:default2
00:00:00.012default:default2
3341.4022default:default2
0.0002default:default2
32082default:default2
300402default:defaultZ17-722h px? 
?

Phase %s%s
101*constraints2
1.2 2default:default2F
2IO Placement/ Clock Placement/ Build Placer Device2default:defaultZ18-101h px? 
g
RPhase 1.2 IO Placement/ Clock Placement/ Build Placer Device | Checksum: edc657dd
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:02 ; elapsed = 00:00:01 . Memory (MB): peak = 3341.402 ; gain = 0.000 ; free physical = 3194 ; free virtual = 300252default:defaulth px? 
}

Phase %s%s
101*constraints2
1.3 2default:default2.
Build Placer Netlist Model2default:defaultZ18-101h px? 
O
:Phase 1.3 Build Placer Netlist Model | Checksum: bb180fe8
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:11 ; elapsed = 00:00:05 . Memory (MB): peak = 3341.402 ; gain = 0.000 ; free physical = 3168 ; free virtual = 300002default:defaulth px? 
z

Phase %s%s
101*constraints2
1.4 2default:default2+
Constrain Clocks/Macros2default:defaultZ18-101h px? 
L
7Phase 1.4 Constrain Clocks/Macros | Checksum: bb180fe8
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:11 ; elapsed = 00:00:05 . Memory (MB): peak = 3341.402 ; gain = 0.000 ; free physical = 3168 ; free virtual = 300002default:defaulth px? 
H
3Phase 1 Placer Initialization | Checksum: bb180fe8
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:11 ; elapsed = 00:00:05 . Memory (MB): peak = 3341.402 ; gain = 0.000 ; free physical = 3166 ; free virtual = 299982default:defaulth px? 
q

Phase %s%s
101*constraints2
2 2default:default2$
Global Placement2default:defaultZ18-101h px? 
p

Phase %s%s
101*constraints2
2.1 2default:default2!
Floorplanning2default:defaultZ18-101h px? 
C
.Phase 2.1 Floorplanning | Checksum: 13f0491dc
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:14 ; elapsed = 00:00:05 . Memory (MB): peak = 3341.402 ; gain = 0.000 ; free physical = 3133 ; free virtual = 299662default:defaulth px? 
x

Phase %s%s
101*constraints2
2.2 2default:default2)
Global Placement Core2default:defaultZ18-101h px? 
?

Phase %s%s
101*constraints2
2.2.1 2default:default20
Physical Synthesis In Placer2default:defaultZ18-101h px? 
?
FFound %s LUTNM shape to break, %s LUT instances to create LUTNM shape
553*physynth2
02default:default2
5932default:defaultZ32-1035h px? 
?
YBreak lutnm for timing: one critical %s, two critical %s, total %s, new lutff created %s
561*physynth2
02default:default2
02default:default2
02default:default2
02default:defaultZ32-1044h px? 
?
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
2272default:default2!
nets or cells2default:default2
02default:default2
cell2default:default2
2272default:default2
cells2default:default2
02default:default2
cell2default:defaultZ32-775h px? 
K
)No high fanout nets found in the design.
65*physynthZ32-65h px? 
?
$Optimized %s %s. Created %s new %s.
216*physynth2
02default:default2
net2default:default2
02default:default2
instance2default:defaultZ32-232h px? 
?
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px? 
j
FNo candidate cells for DSP register optimization found in the design.
274*physynthZ32-456h px? 
?
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
22default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px? 
i
DNo candidate cells found for Shift Register to Pipeline optimization564*physynthZ32-1123h px? 
?
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px? 
h
DNo candidate cells for SRL register optimization found in the design349*physynthZ32-677h px? 
?
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px? 
i
ENo candidate cells for BRAM register optimization found in the design297*physynthZ32-526h px? 
?
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px? 
j
FNo candidate cells for URAM register optimization found in the design
437*physynthZ32-846h px? 
?
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
22default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px? 
R
.No candidate nets found for HD net replication521*physynthZ32-949h px? 
?
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px? 
?
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:00.012default:default2
00:00:002default:default2
3341.4022default:default2
0.0002default:default2
31242default:default2
299592default:defaultZ17-722h px? 
B
-
Summary of Physical Synthesis Optimizations
*commonh px? 
B
-============================================
*commonh px? 


*commonh px? 


*commonh px? 
?
?-----------------------------------------------------------------------------------------------------------------------------------------------------------
*commonh px? 
?
?|  Optimization                                     |  Added Cells  |  Removed Cells  |  Optimized Cells/Nets  |  Dont Touch  |  Iterations  |  Elapsed   |
-----------------------------------------------------------------------------------------------------------------------------------------------------------
*commonh px? 
?
?|  LUT Combining                                    |            0  |            227  |                   227  |           0  |           1  |  00:00:00  |
|  Very High Fanout                                 |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  DSP Register                                     |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  Shift Register to Pipeline                       |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  Shift Register                                   |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  BRAM Register                                    |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  URAM Register                                    |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  Dynamic/Static Region Interface Net Replication  |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  Total                                            |            0  |            227  |                   227  |           0  |           8  |  00:00:01  |
-----------------------------------------------------------------------------------------------------------------------------------------------------------
*commonh px? 


*commonh px? 


*commonh px? 
T
?Phase 2.2.1 Physical Synthesis In Placer | Checksum: 28c820720
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:44 ; elapsed = 00:00:16 . Memory (MB): peak = 3341.402 ; gain = 0.000 ; free physical = 3122 ; free virtual = 299572default:defaulth px? 
K
6Phase 2.2 Global Placement Core | Checksum: 147fff26d
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:48 ; elapsed = 00:00:17 . Memory (MB): peak = 3341.402 ; gain = 0.000 ; free physical = 3117 ; free virtual = 299532default:defaulth px? 
D
/Phase 2 Global Placement | Checksum: 147fff26d
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:48 ; elapsed = 00:00:17 . Memory (MB): peak = 3341.402 ; gain = 0.000 ; free physical = 3128 ; free virtual = 299632default:defaulth px? 
q

Phase %s%s
101*constraints2
3 2default:default2$
Detail Placement2default:defaultZ18-101h px? 
}

Phase %s%s
101*constraints2
3.1 2default:default2.
Commit Multi Column Macros2default:defaultZ18-101h px? 
P
;Phase 3.1 Commit Multi Column Macros | Checksum: 1bd33ea1c
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:52 ; elapsed = 00:00:18 . Memory (MB): peak = 3341.402 ; gain = 0.000 ; free physical = 3125 ; free virtual = 299602default:defaulth px? 


Phase %s%s
101*constraints2
3.2 2default:default20
Commit Most Macros & LUTRAMs2default:defaultZ18-101h px? 
R
=Phase 3.2 Commit Most Macros & LUTRAMs | Checksum: 21979b500
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:57 ; elapsed = 00:00:19 . Memory (MB): peak = 3341.402 ; gain = 0.000 ; free physical = 3125 ; free virtual = 299602default:defaulth px? 
y

Phase %s%s
101*constraints2
3.3 2default:default2*
Area Swap Optimization2default:defaultZ18-101h px? 
L
7Phase 3.3 Area Swap Optimization | Checksum: 2389782ab
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:57 ; elapsed = 00:00:20 . Memory (MB): peak = 3341.402 ; gain = 0.000 ; free physical = 3125 ; free virtual = 299602default:defaulth px? 
?

Phase %s%s
101*constraints2
3.4 2default:default22
Pipeline Register Optimization2default:defaultZ18-101h px? 
T
?Phase 3.4 Pipeline Register Optimization | Checksum: 249c84745
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:57 ; elapsed = 00:00:20 . Memory (MB): peak = 3341.402 ; gain = 0.000 ; free physical = 3125 ; free virtual = 299602default:defaulth px? 
t

Phase %s%s
101*constraints2
3.5 2default:default2%
Fast Optimization2default:defaultZ18-101h px? 
G
2Phase 3.5 Fast Optimization | Checksum: 17323bdc3
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:01:02 ; elapsed = 00:00:21 . Memory (MB): peak = 3341.402 ; gain = 0.000 ; free physical = 3126 ; free virtual = 299612default:defaulth px? 


Phase %s%s
101*constraints2
3.6 2default:default20
Small Shape Detail Placement2default:defaultZ18-101h px? 
R
=Phase 3.6 Small Shape Detail Placement | Checksum: 1f551fd7b
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:01:09 ; elapsed = 00:00:27 . Memory (MB): peak = 3341.402 ; gain = 0.000 ; free physical = 3096 ; free virtual = 299322default:defaulth px? 
u

Phase %s%s
101*constraints2
3.7 2default:default2&
Re-assign LUT pins2default:defaultZ18-101h px? 
H
3Phase 3.7 Re-assign LUT pins | Checksum: 221e7429c
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:01:10 ; elapsed = 00:00:28 . Memory (MB): peak = 3341.402 ; gain = 0.000 ; free physical = 3097 ; free virtual = 299332default:defaulth px? 
?

Phase %s%s
101*constraints2
3.8 2default:default22
Pipeline Register Optimization2default:defaultZ18-101h px? 
T
?Phase 3.8 Pipeline Register Optimization | Checksum: 10f39448f
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:01:10 ; elapsed = 00:00:28 . Memory (MB): peak = 3341.402 ; gain = 0.000 ; free physical = 3097 ; free virtual = 299332default:defaulth px? 
t

Phase %s%s
101*constraints2
3.9 2default:default2%
Fast Optimization2default:defaultZ18-101h px? 
G
2Phase 3.9 Fast Optimization | Checksum: 154d4159a
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:01:18 ; elapsed = 00:00:30 . Memory (MB): peak = 3341.402 ; gain = 0.000 ; free physical = 3106 ; free virtual = 299422default:defaulth px? 
D
/Phase 3 Detail Placement | Checksum: 154d4159a
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:01:19 ; elapsed = 00:00:30 . Memory (MB): peak = 3341.402 ; gain = 0.000 ; free physical = 3106 ; free virtual = 299422default:defaulth px? 
?

Phase %s%s
101*constraints2
4 2default:default2<
(Post Placement Optimization and Clean-Up2default:defaultZ18-101h px? 
{

Phase %s%s
101*constraints2
4.1 2default:default2,
Post Commit Optimization2default:defaultZ18-101h px? 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px? 
?

Phase %s%s
101*constraints2
4.1.1 2default:default2/
Post Placement Optimization2default:defaultZ18-101h px? 
U
@Post Placement Optimization Initialization | Checksum: dc93a97c
*commonh px? 
u

Phase %s%s
101*constraints2
4.1.1.1 2default:default2"
BUFG Insertion2default:defaultZ18-101h px? 
a

Starting %s Task
103*constraints2&
Physical Synthesis2default:defaultZ18-103h px? 
?

Phase %s%s
101*constraints2
1 2default:default25
!Physical Synthesis Initialization2default:defaultZ18-101h px? 
?
EMultithreading enabled for phys_opt_design using a maximum of %s CPUs380*physynth2
82default:defaultZ32-721h px? 
?
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2default:default2
 2default:default2
-0.4872default:default2
-10.3342default:defaultZ32-619h px? 
T
?Phase 1 Physical Synthesis Initialization | Checksum: aa073dce
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:02 ; elapsed = 00:00:00.47 . Memory (MB): peak = 3341.402 ; gain = 0.000 ; free physical = 3088 ; free virtual = 299232default:defaulth px? 
?
PProcessed net %s, BUFG insertion was skipped due to placement/routing conflicts.32*	placeflow2P
<design_1_i/core_0/inst/regslice_both_in_data_V_data_V_U/E[0]2default:defaultZ46-33h px? 
?
?BUFG insertion identified %s candidate nets. Inserted BUFG: %s, Replicated BUFG Driver: %s, Skipped due to Placement/Routing Conflicts: %s, Skipped due to Timing Degradation: %s, Skipped due to Illegal Netlist: %s.43*	placeflow2
12default:default2
02default:default2
02default:default2
12default:default2
02default:default2
02default:defaultZ46-56h px? 
J
5Ending Physical Synthesis Task | Checksum: 10e06765d
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:02 ; elapsed = 00:00:00.60 . Memory (MB): peak = 3341.402 ; gain = 0.000 ; free physical = 3086 ; free virtual = 299222default:defaulth px? 
G
2Phase 4.1.1.1 BUFG Insertion | Checksum: dc93a97c
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:01:31 ; elapsed = 00:00:33 . Memory (MB): peak = 3341.402 ; gain = 0.000 ; free physical = 3087 ; free virtual = 299232default:defaulth px? 
?
hPost Placement Timing Summary WNS=%s. For the most accurate timing information please run report_timing.610*place2
0.5782default:defaultZ30-746h px? 
S
>Phase 4.1.1 Post Placement Optimization | Checksum: 15559a43b
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:01:33 ; elapsed = 00:00:35 . Memory (MB): peak = 3341.402 ; gain = 0.000 ; free physical = 3062 ; free virtual = 298972default:defaulth px? 
N
9Phase 4.1 Post Commit Optimization | Checksum: 15559a43b
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:01:34 ; elapsed = 00:00:36 . Memory (MB): peak = 3341.402 ; gain = 0.000 ; free physical = 3062 ; free virtual = 298972default:defaulth px? 
y

Phase %s%s
101*constraints2
4.2 2default:default2*
Post Placement Cleanup2default:defaultZ18-101h px? 
L
7Phase 4.2 Post Placement Cleanup | Checksum: 15559a43b
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:01:34 ; elapsed = 00:00:36 . Memory (MB): peak = 3341.402 ; gain = 0.000 ; free physical = 3062 ; free virtual = 298982default:defaulth px? 
s

Phase %s%s
101*constraints2
4.3 2default:default2$
Placer Reporting2default:defaultZ18-101h px? 
F
1Phase 4.3 Placer Reporting | Checksum: 15559a43b
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:01:34 ; elapsed = 00:00:36 . Memory (MB): peak = 3341.402 ; gain = 0.000 ; free physical = 3062 ; free virtual = 298982default:defaulth px? 
z

Phase %s%s
101*constraints2
4.4 2default:default2+
Final Placement Cleanup2default:defaultZ18-101h px? 
?
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:00.012default:default2
00:00:00.012default:default2
3341.4022default:default2
0.0002default:default2
30622default:default2
298982default:defaultZ17-722h px? 
M
8Phase 4.4 Final Placement Cleanup | Checksum: 192758e96
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:01:34 ; elapsed = 00:00:36 . Memory (MB): peak = 3341.402 ; gain = 0.000 ; free physical = 3062 ; free virtual = 298982default:defaulth px? 
\
GPhase 4 Post Placement Optimization and Clean-Up | Checksum: 192758e96
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:01:34 ; elapsed = 00:00:36 . Memory (MB): peak = 3341.402 ; gain = 0.000 ; free physical = 3063 ; free virtual = 298982default:defaulth px? 
=
(Ending Placer Task | Checksum: ebaafe26
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:01:34 ; elapsed = 00:00:36 . Memory (MB): peak = 3341.402 ; gain = 0.000 ; free physical = 3063 ; free virtual = 298982default:defaulth px? 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
952default:default2
32default:default2
02default:default2
02default:defaultZ4-41h px? 
^
%s completed successfully
29*	vivadotcl2 
place_design2default:defaultZ4-42h px? 
?
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2"
place_design: 2default:default2
00:01:372default:default2
00:00:382default:default2
3341.4022default:default2
0.0002default:default2
30972default:default2
299332default:defaultZ17-722h px? 
H
&Writing timing data to binary archive.266*timingZ38-480h px? 
D
Writing placer database...
1603*designutilsZ20-1893h px? 
=
Writing XDEF routing.
211*designutilsZ20-211h px? 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px? 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px? 
?
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2)
Write XDEF Complete: 2default:default2
00:00:042default:default2
00:00:012default:default2
3341.4022default:default2
0.0002default:default2
30142default:default2
299082default:defaultZ17-722h px? 
?
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2?
o/home/sumin/workspace/Embedded_sysarr/Platform/Vivado/pynq_dma/pynq_dma.runs/impl_1/design_1_wrapper_placed.dcp2default:defaultZ17-1381h px? 
k
%s4*runtcl2O
;Executing : report_io -file design_1_wrapper_io_placed.rpt
2default:defaulth px? 
?
?report_io: Time (s): cpu = 00:00:00.08 ; elapsed = 00:00:00.13 . Memory (MB): peak = 3341.402 ; gain = 0.000 ; free physical = 3026 ; free virtual = 29903
*commonh px? 
?
%s4*runtcl2?
xExecuting : report_utilization -file design_1_wrapper_utilization_placed.rpt -pb design_1_wrapper_utilization_placed.pb
2default:defaulth px? 
?
%s4*runtcl2l
XExecuting : report_control_sets -verbose -file design_1_wrapper_control_sets_placed.rpt
2default:defaulth px? 
?
?report_control_sets: Time (s): cpu = 00:00:00.15 ; elapsed = 00:00:00.20 . Memory (MB): peak = 3341.402 ; gain = 0.000 ; free physical = 3009 ; free virtual = 29885
*commonh px? 


End Record