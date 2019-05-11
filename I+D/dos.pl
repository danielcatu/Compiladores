use strict;
print "Ingrese la dirección \n";
my $dir=<stdin>;
if($dir=~/^([a-zA-Z])\:([\/|\/]+[a-zA-Z0-9,;ñáíúéóÁÍÚÉÓ!@%&#()'-{}~]{1,8}).[a-zA-Z]{1,3}+$/){
print "Correcto \n";
}else{
print "Incorrecto";
}
