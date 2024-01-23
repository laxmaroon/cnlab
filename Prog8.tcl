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