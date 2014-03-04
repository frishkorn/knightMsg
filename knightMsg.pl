#!/usr/bin/perl

=head1 NAME

knightMsg.pl

=head1 SYNOPSIS

This script will take user input, convert it to a Straddling Checkerboard cipher, and apply a user selected key to encrypt the message.

=head1 OPTIONS

No options at this time.

=head1 EXAMPLES

Please enter MESSAGE: Hello

              CIPHER: 25528283

Please enter the KEY: 38282473

             MESSAGE: 53700656

=head1 DESCRIPTION

2014/03/03 - Reduced code size by converting the array into a hash.
2014/01/20 - First version of the script has been written. Next step will be to modify it so it'll also decrypt messages.

=head1 AUTHOR

C. Frishkorn

=cut

$main::VERSION = "1.1.108";

use warnings;
use strict;

# Ask user to input plain-text.
print "\nPlease enter MESSAGE: ";
my $inputMessage = <STDIN>;
chomp $inputMessage;
if ( $inputMessage =~ m/^\d/ ) {
	print "\nFunction to decrypt a message hasn't been added yet!\n";
	exit;
}

# Take plain-text and cipher it into numbers only. 
my @preCipher = split( //, $inputMessage );
@preCipher = map {lc} @preCipher;
my @postCipher;
my %hashCipher = (
	a => "0", b => "20", c => "21", d => "22", e => "5", f => "23",
	g => "24", h => "25", i => "8", j => "26", k => "27", l => "28",
	m => "29", n => "4", o => "3", p => "60", q => "61", r => "9",
	s => "7", t => "1", u => "62", v => "63", w => "64", x => "65",
	y => "66", z => "67", " " => "68", "." => "68", "#" => "69"
);
foreach my $preCipher ( @preCipher ) {
	if ( $preCipher =~ m/\d/ ) {
		foreach my $iii (0..2) {
			push ( @postCipher, $preCipher );
		}
	} elsif ( $preCipher = $hashCipher{$preCipher}) {
		push ( @postCipher, $preCipher );
	} else {
		print "\nInvalid character!\n";
		exit;
	}
}
my @indCipher;
my $cmpCipher = join ( '', @postCipher );
my @cmpCipher = split(//, $cmpCipher);
foreach my $cmpCipher ( @cmpCipher ) {
	push ( @indCipher, $cmpCipher );
}
print "\n";
print ( '              CIPHER: ', @indCipher );

# Ask user to input a key.
print "\n\nPlease enter the KEY: ";
my $key = <STDIN>;
chomp $key;
if ( $key !~ m/^\d/ ) {
	print "\nFunction to encrypt a message hasn't been added yet!\n";
	exit;
}
my @keyCipher = split(//, $key);

# Math functions.
my $firstShift;
my @addCipher;
while (defined($firstShift = shift(@keyCipher))) {
	my $secondShift = shift(@indCipher);
	my $math = $firstShift + $secondShift;
	if ( $math >= 10 ) {
		$math = $math - 10;
		}
	push ( @addCipher, $math );
}

# Print encrypted message then exit.
print "\n";
print ( '             MESSAGE: ', @addCipher );
print "\n\n";
exit;