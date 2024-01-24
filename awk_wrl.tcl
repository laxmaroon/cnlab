BEGIN {
	Rcvdsize = 0
	Starttime = 400
	Stoptime = 0
}
{
	Event = $1
	Time = $2
	#Node_id = $3
	Pkt_size = $8
	Level = $4
	if(Level == "AGT" && Event == "s" && Pkt_size >= 512) {
		if (Time < Starttime) {
			Starttime = Time
		}
	}
	if (Level == "AGT" && Event == "r" && Pkt_size >= 512) {
		if(Time > Stoptime) {
			Stoptime = Time
		}
		Hdr_size = Pkt_size % 512
		Pkt_size -= Hdr_size
		Rcvdsize += Pkt_size
	}
	
}
END {
	printf("Average throughput = %.2f Mbps\nStart Time = %.2f\nStop Time = %.2f\n",(Rcvdsize/(Stoptime - Starttime))*(8/1e6), Starttime, Stoptime)
}BEGIN {
	Rcvdsize = 0
	Starttime = 400
	Stoptime = 0
}
{
	Event = $1
	Time = $2
	#Node_id = $3
	Pkt_size = $8
	Level = $4
	if(Level == "AGT" && Event == "s" && Pkt_size >= 512) {
		if (Time < Starttime) {
			Starttime = Time
		}
	}
	if (Level == "AGT" && Event == "r" && Pkt_size >= 512) {
		if(Time > Stoptime) {
			Stoptime = Time
		}
		Hdr_size = Pkt_size % 512
		Pkt_size -= Hdr_size
		Rcvdsize += Pkt_size
	}
	
}
END {
	printf("Average throughput = %.2f Mbps\nStart Time = %.2f\nStop Time = %.2f\n",(Rcvdsize/(Stoptime - Starttime))*(8/1e6), Starttime, Stoptime)
}