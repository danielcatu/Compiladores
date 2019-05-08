#! /usr/bin/perl
   if( $#ARGV == 0 ) {
       $a=@ARGV[0];
       if(@ARGV[0] =~ m/^([0-1][0-9][0-9]|2[0-5][0-5]).([0-1][0-9][0-9]|2[0-5][0-5]).([0-1][0-9][0-9]|2[0-5][0-5])$/i){
           print "Reconocido\n";
       }
   }
   elsif( @ARG > 0 ) {
      printf("Too many arguments supplied.\n");
   }
   else {
      printf("One argument expected.\n");
   }

