#prog6
set val(chan) Channel/WirelessChannel
set val(prop) Propagation/TwoRayGround
set val(netif) Phy/WirelessPhy
set val(mac) Mac/802_11
set val(ifq) Queue/DropTail/PriQueue
set val(ll) LL
set val(ant) Antenna/OmniAntenna
set val(x) 500
set val(y) 500
set val(ifqlen) 50
set val(nn) 2
set val(stop) 20.0
set val(rp) DSDV

set ns [new Simulator]
set tf [open p1.tr w]
set nf [open p1.nam w]
$ns trace-all $tf
$ns namtrace-all-wireless $nf $val(x) $val(y)

set prop [new $val(prop)]
set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)

create-god $val(nn)

$ns node-config -adhocRouting $val(rp) \
                -channelType $val(chan) \
                -propType $val(prop) \
                -phyType $val(netif) \
                -macType $val(mac) \
                -ifqType $val(ifq) \
                -llType $val(ll) \
                -antType $val(ant) \
                -ifqLen $val(ifqlen) \
                -topoInstance $topo \
                -agentTrace ON \
                -routerTrace ON \
                -macTrace ON

for {set i 0} {$i < $val(nn)} {incr i} {
set node_($i) [$ns node]
$node_($i) random-motion 0
}

for {set i 0} {$i < $val(nn)} {incr i} {
$ns initial_node_pos $node_($i) 40
}

$ns at 1.1 "$node_(0) setdest 310.0 10.0 20.0"
$ns at 1.1 "$node_(1) setdest 10.0 310.0 20.0"

set tcp0 [new Agent/TCP]
set sink0 [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp0
$ns attach-agent $node_(1) $sink0
$ns connect $tcp0 $sink0
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0

$ns at 1.0 "$ftp0 start"
$ns at 18.0 "$ftp0 stop"

for {set i 0} {$i < $val(nn)} {incr i} {
$ns at $val(stop) "$node_($i) reset"
}
$ns at $val(stop) "puts \"NS EXITING..\";$ns halt"

puts "starting simulation"
$ns run
.
.
.
.

#prog7

set val(chan) Channel/WirelessChannel
set val(prop) Propagation/TwoRayGround
set val(netif) Phy/WirelessPhy
set val(mac) Mac/802_11
set val(ifq) Queue/DropTail/PriQueue
set val(ll) LL
set val(ant) Antenna/OmniAntenna
set val(x) 500
set val(y) 400
set val(ifqlen) 50
set val(nn) 3
set val(stop) 60.0
set val(rp) AODV
set ns_ [new Simulator]
set tracefd [open prog7.tr w]
$ns_ trace-all $tracefd
set namtrace [open prog7.nam w]
$ns_ namtrace-all-wireless $namtrace $val(x) $val(y)
set prop [new $val(prop)]
set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)

create-god $val(nn)

$ns_ node-config -adhocRouting $val(rp) \
-llType $val(ll) \
-macType $val(mac) \
-ifqType $val(ifq) \
-ifqLen $val(ifqlen) \
-antType $val(ant) \
-propType $val(prop) \
-phyType $val(netif) \
-channelType $val(chan) \
-topoInstance $topo \
-agentTrace ON \
-routerTrace ON \
-macTrace ON

for {set i 0} {$i < $val(nn) } {incr i} {
set node_($i) [$ns_ node]
$node_($i) random-motion 0
}

$node_(0) set x_ 5.0
$node_(0) set y_ 5.0
$node_(0) set z_ 0.0

$node_(1) set x_ 490.0
$node_(1) set y_ 285.0
$node_(1) set z_ 0.0

$node_(2) set x_ 150.0
$node_(2) set y_ 240.0
$node_(2) set x_ 0.0
for {set i 0} {$i < $val(nn) } {incr i} {
$ns_ initial_node_pos $node_($i) 220
}
$ns_ at 0.0 "$node_(0) setdest 450.0 285.0 30.0"
$ns_ at 0.0 "$node_(1) setdest 200.0 285.0 30.0"
$ns_ at 0.0 "$node_(2) setdest 1.0 285.0 30.0"

$ns_ at 25.0 "$node_(0) setdest 300.0 285.0 10.0"
$ns_ at 25.0 "$node_(2) setdest 100.0 285.0 10.0"

$ns_ at 40.0 "$node_(0) setdest 490.0 285.0 5.0"
$ns_ at 40.0 "$node_(2) setdest 1.0 285.0 5.0"

set tcp0 [new Agent/TCP]
set sink0 [new Agent/TCPSink]
$ns_ attach-agent $node_(0) $tcp0
$ns_ attach-agent $node_(2) $sink0
$ns_ connect $tcp0 $sink0
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ns_ at 10.0 "$ftp0 start"

for {set i 0} {$i < $val(nn)} {incr i} {
$ns_ at $val(stop) "$node_($i) reset";
}
$ns_ at $val(stop) "puts \"NS EXITING...\"; $ns_ halt"
puts "Starting Simulation..."
$ns_ run
.
.
.
.
.
.
#prog8

set val(chan) Channel/WirelessChannel
set val(prop) Propagation/TwoRayGround
set val(netif) Phy/WirelessPhy
set val(mac) Mac/802_11
set val(ifq) Queue/DropTail/PriQueue
set val(ll) LL
set val(ant) Antenna/OmniAntenna
set val(x) 500
set val(y) 500
set val(ifqlen) 50
set val(nn) 25
set val(stop) 60.0
set val(rp) AODV

# A folder named ns-allinone-2.35 must be there in your working directory. If not, you can download it from sourceforge and extract it in the /home/student directory.

#type the command
# > cd ns-allinone-2.35/ns-2.35/indep-utils/cmu-scen-gen
# > ls
# now from the list of files, you should be able to see a file called cbrgen.tcl
# > ns cbrgen.tcl
# this would show you the parameters that you will need to specify, as given below
# usage: cbrgen.tcl [-type cbr|tcp] [-nn nodes] [-seed seed] [-mc connections] [-rate rate]
# > ns cbrgen.tcl -type tcp -nn 25 -seed 1 -mc 10 -rate 10 > static
# > ls
# You should be able to see a file named static created.
# > cd setdest
# > setdest
# This gives some parameters to be set, as given below
# usage:
# <original 1999 CMU version (version 1)>
# setdest        -v <1> -n <nodes> -p <pause time> -M <max speed>
#                -t <simulation time> -x <max X> -y <max Y>
# and you can ignore the rest
# > setdest -v 1 -n 25 -p 10 -M 10 -t 100 -x 500 -y 500 > mobile
# > ls
# file named mobile will be created

# after this there are 2 ways to execute. Follow whichever you think is easier

# Copy the static, mobile and the file which has the 8th program and paste them in the same folder.

# Then you can specify below two lines in the program
set val(sc) "mobile"
set val(cp) "static"

# In the second method, after creating files, you do not need to move anything
# Specify the complete path in place of their names, like
# set val(sc) "/home/student/Desktop/ns-allinone-2.35/ns-2.35/indep-utils/cmu-scen-gen/setdest/mobile"
# set val(cp) "/home/student/Desktop/ns-allinone-2.35/ns-2.35/indep-utils/cmu-scen-gen/static"

set ns_ [new Simulator]
set tracefd [open static_mob.tr w]
$ns_ trace-all $tracefd
set namtrace [open static_mob.nam w]
$ns_ namtrace-all-wireless $namtrace $val(x) $val(y)
set prop [new $val(prop)]
set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)

# this line is required for mobile nodes. Type it out as is. period.
set god_ [create-god $val(nn)]

$ns_ node-config -adhocRouting $val(rp) \
-llType $val(ll) \
-macType $val(mac) \
-ifqType $val(ifq) \
-ifqLen $val(ifqlen) \
-antType $val(ant) \
-propType $val(prop) \
-phyType $val(netif) \
-channelType $val(chan) \
-topoInstance $topo \
-agentTrace ON \
-routerTrace ON \
-macTrace ON

for {set i 0} {$i < $val(nn)} {incr i} {
  set node_($i) [$ns_ node]
  $node_($i) random-motion 0
}

for {set i 0} {$i < $val(nn) } {incr i} {
set xx [expr rand()*500]
set yy [expr rand()*500]
$node_($i) set X_ $xx
$node_($i) set Y_ $yy
}

for {set i 0} {$i < $val(nn)} {incr i} {
  $ns_ initial_node_pos $node_($i) 40
}


#comment one source file at a time
puts "loading scenario file.... -mobility"
#source $val(sc)
puts "loading connection file... -traffic"
source $val(cp)

#simulation termination
for {set i 0} {$i < $val(nn)} {incr i} {
    $ns_ at $val(stop) "$node_($i) reset";
}

$ns_ at $val(stop) "puts \"NS EXITING ..\"; $ns_ halt"
puts "Starting simulation..."
# exec nam must be typed out here and not on the console.
exec nam static_mob.nam &
$ns_ run
# that's all, ns program8.tcl
.
.
.
.
.
.
.
#prog9

set val(chan) Channel/WirelessChannel
set val(prop) Propagation/TwoRayGround
set val(netif) Phy/WirelessPhy
set val(mac) Mac/802_11
#set val(ifq) Queue/DropTail/PriQueue
set val(ifq) CMUPriQueue
set val(ll) LL
set val(ant) Antenna/OmniAntenna
set val(x) 700
set val(y) 700
set val(ifqlen) 50
set val(nn) 6
set val(stop) 60.0
set val(rp) DSR
set ns_ [new Simulator]
set tracefd [open 004.tr w]
$ns_ trace-all $tracefd
set namtrace [open 004.nam w]
$ns_ namtrace-all-wireless $namtrace $val(x) $val(y)
set prop [new $val(prop)]
set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)
set god_ [create-god $val(nn)]
#Node Configuration
$ns_ node-config -adhocRouting $val(rp) \
-llType $val(ll) \
-macType $val(mac) \
-ifqType $val(ifq) \
-ifqLen $val(ifqlen) \
-antType $val(ant) \
-propType $val(prop) \
-phyType $val(netif) \
-channelType $val(chan) \
-topoInstance $topo \
-agentTrace ON \
-routerTrace ON \
-macTrace ON
#Creating Nodes
for {set i 0} {$i < $val(nn) } {incr i} {
set node_($i) [$ns_ node]
$node_($i) random-motion 0
}
#Initial Positions of Nodes
$node_(0) set X_ 150.0
$node_(0) set Y_ 300.0
$node_(0) set Z_ 0.0
$node_(1) set X_ 300.0
$node_(1) set Y_ 500.0
$node_(1) set Z_ 0.0
$node_(2) set X_ 500.0
$node_(2) set Y_ 500.0
$node_(2) set Z_ 0.0
$node_(3) set X_ 300.0
$node_(3) set Y_ 100.0
$node_(3) set Z_ 0.0
$node_(4) set X_ 500.0
$node_(4) set Y_ 100.0
$node_(4) set Z_ 0.0
$node_(5) set X_ 650.0
$node_(5) set Y_ 300.0
$node_(5) set Z_ 0.0
for {set i 0} {$i < $val(nn)} {incr i} {
$ns_ initial_node_pos $node_($i) 40
}
#Topology Design
$ns_ at 1.0 "$node_(0) setdest 160.0 300.0 2.0"
$ns_ at 1.0 "$node_(1) setdest 310.0 150.0 2.0"
$ns_ at 1.0 "$node_(2) setdest 490.0 490.0 2.0"
$ns_ at 1.0 "$node_(3) setdest 300.0 120.0 2.0"
$ns_ at 1.0 "$node_(4) setdest 510.0 90.0 2.0"
$ns_ at 1.0 "$node_(5) setdest 640.0 290.0 2.0"
$ns_ at 4.0 "$node_(3) setdest 300.0 500.0 5.0"
#Generating Traffic
set tcp0 [new Agent/TCP]
set sink0 [new Agent/TCPSink]
$ns_ attach-agent $node_(0) $tcp0
$ns_ attach-agent $node_(5) $sink0
$ns_ connect $tcp0 $sink0
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ns_ at 5.0 "$ftp0 start"
$ns_ at 60.0 "$ftp0 stop"
#Simulation Termination
for {set i 0} {$i < $val(nn) } {incr i} {
$ns_ at $val(stop) "$node_($i) reset";
}
$ns_ at $val(stop) "puts \"NS EXITING...\" ; $ns_ halt"
puts "Starting Simulation..."
$ns_ run
.
.
.
.
.
.
.
#prog10

set val(chan) Channel/WirelessChannel
set val(prop) Propagation/TwoRayGround
set val(netif) Phy/WirelessPhy
set val(mac) Mac/802_11
set val(ifq) Queue/DropTail/PriQueue
set val(ll) LL
set val(ant) Antenna/OmniAntenna
set val(x) 500
set val(y) 500
set val(ifqlen) 50
set val(nn) 5
set val(stop) 50.0
set val(rp) AODV

set ns_ [new Simulator]
set tracefd [open prog10.tr w]
$ns_ trace-all $tracefd
set namtrace [open prog10.nam w]
$ns_ namtrace-all-wireless $namtrace $val(x) $val(y)
set prop [new $val(prop)]
set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)
create-god $val(nn)

$ns_ node-config -adhocRouting $val(rp) \
-llType $val(ll) \
-macType $val(mac) \
-ifqType $val(ifq) \
-ifqLen $val(ifqlen) \
-antType $val(ant) \
-propType $val(prop) \
-phyType $val(netif) \
-channelType $val(chan) \
-topoInstance $topo \
-agentTrace ON \
-routerTrace ON \
-macTrace ON \
-IncomingErrProc "uniformErr" \
-OutgoingErrProc "uniformErr"
proc uniformErr {} {
set err [new ErrorModel]
$err unit pkt
$err set rate_ 0.01
return $err
}

for {set i 0} {$i < $val(nn) } {incr i} {
set node_($i) [$ns_ node]
$node_($i) random-motion 0
}

for {set i 0} {$i < $val(nn)} {incr i} {
$ns_ initial_node_pos $node_($i) 40
}

$ns_ at 1.0 "$node_(0) setdest 10.0 10.0 50.0"
$ns_ at 1.0 "$node_(1) setdest 10.0 100.0 50.0"
$ns_ at 1.0 "$node_(4) setdest 50.0 50.0 50.0"
$ns_ at 1.0 "$node_(2) setdest 100.0 100.0 50.0"
$ns_ at 1.0 "$node_(3) setdest 100.0 10.0 50.0"

set tcp0 [new Agent/TCP]
set sink0 [new Agent/TCPSink]
$ns_ attach-agent $node_(0) $tcp0
$ns_ attach-agent $node_(2) $sink0
$ns_ connect $tcp0 $sink0
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ns_ at 1.0 "$ftp0 start"
$ns_ at 50.0 "$ftp0 stop"
set tcp1 [new Agent/TCP]
set sink1 [new Agent/TCPSink]
$ns_ attach-agent $node_(1) $tcp1
$ns_ attach-agent $node_(2) $sink1
$ns_ connect $tcp1 $sink1
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ns_ at 1.0 "$ftp1 start"
$ns_ at 50.0 "$ftp1 stop"

for {set i 0} {$i < $val(nn) } {incr i} {
$ns_ at $val(stop) "$node_($i) reset";
}
$ns_ at $val(stop) "puts \"NS EXITING...\" ; $ns_ halt"
puts "Starting Simulation..."
$ns_ run