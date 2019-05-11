#! /usr/bin/perl
$id='(2[0-5][0-5]|1\d\d|[1-9]\d|\d)';
   if( $#ARGV == 0 ) {
       if(@ARGV[0] =~ /^$id\.$id\.$id\.$id$/){
           print "Reconocido\n";
       }else{
          print "No Reconocido\n";
       }
   }
   elsif( @ARG > 0 ) {
      printf("Too many arguments supplied.\n");
   }
   else {
      printf("One argument expected.\n");
   }

