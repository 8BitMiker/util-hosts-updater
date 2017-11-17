#!/usr/bin/perl -l

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ PRAGMAS

use strict;
use warnings;
use Data::Dumper;
$|++;

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ DOX

# Used to do some fast acting mods to /etc/hosts
# Useage:
# ./hosts_updater.pl 0 | sudo bash

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ VARS

my $use = qq~./${0} 0 | sudo bash~;
my $db = [];
my $n = 0;
my $choice;
my $output;
my $cmd;

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ INIT

# Get DB
READ:
{
	while (<DATA>)
	{
		
		do{++$n; next} if m`^~{4,}`;
		$$db[$n] .= ${_};
		
	}
}

# print Dumper $db; # Debug

# Write DB
WRITE:
{
	
	die qq~Need Arguments!\n0 = Being good\n1 = Being naughty!\nEXAMPLE: ${use}\n~ 
		if @ARGV != 1;	
	
	die qq~Argument needs to be a 0 or 1\n~ 
		if $ARGV[0] and ($ARGV[0] !~ m~^0|1$~);
	
	$choice = shift @ARGV;

	do { $output .= $$db[$_] } for (0..$choice);

	$cmd = qq`sudo echo "${output}" > /etc/hosts`;
	print $cmd;
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ DB

__END__
##
# Host Database
#
# localhost is used to configure the loopback interface
# when the system is booting.  Do not change this entry.
##
127.0.0.1	localhost
255.255.255.255	broadcasthost
::1             localhost
~~~~~~~~~~
127.0.0.1	facebook.com
127.0.0.1	http://www.facebook.com
127.0.0.1	https://www.facebook.com
127.0.0.1	facebook.com
127.0.0.1	www.facebook.com
127.0.0.1	okcupid.com
127.0.0.1	www.okcupid.com
127.0.0.1	http://www.okcupid.com
127.0.0.1	https://www.okcupid.com