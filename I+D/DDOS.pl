#NOPOS{\ / : * ? " < > | }
#! /usr/bin/perl
$unidad='[a-zA-Z]';
$Black='[^/][^\(\\\)]';
$loco='[^(\\)/:\*?"<>\|]';
$Definitiva='[\\\/\:\*\?\"\<\>\|]';
print "Ingrese la dirección \n";
my $dir=<stdin>;  
print $dir;
if($dir =~ /^$unidad\:((\\\"$Black+\"$)|(\\$loco+))*$/){
      print "Reconocido\n";
}else{
      print "NoReconocido\n";
}  
#c:\Windows\System32\Dri/vers\etc\hosts.pete
#c:\Windows\System32\"Dri v/ers"\etc\hosts.pete

