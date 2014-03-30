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

2014/03/30 - Started work on the decryption portion of this script. Still a lot of work to do.
2014/03/03 - Reduced code size by converting the array into a hash.
2014/01/20 - First version of the script has been written. Next step will be to modify it so it'll also decrypt messages.

=head1 AUTHOR

C. Frishkorn

=cut

$main::VERSION = "1.2.167";

use warnings;
use strict;
use Data::Dumper;

sub cipherMsg( $ );
sub decipherMsg( $ );

# Ask user to input plain-text.
print "\nPlease enter MESSAGE: ";
my $inputMessage = <STDIN>;
chomp $inputMessage;
if ( $inputMessage =~ m/^\d/ ) {
	decipherMsg( $inputMessage );
	} else {
		cipherMsg( $inputMessage );
}

# Encryption Sub-Routine.
sub cipherMsg( $ )
{
	# Take plain-text and cipher it into numbers only.
	my @preCipher = split( //, $inputMessage );
	@preCipher = map {lc} @preCipher;
	my @postCipher;
	my %hashCipher = (
		a => "00", b => "20", c => "21", d => "22", e => "5", f => "23", ### a => "00" is a workaround. Perl doesn't play nice with the single 0, gets lost at @postCipher line 73.
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
			print Dumper( \@postCipher );
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
		print "\nInvalid key entered, please use only digits!\n";
		exit;
	}
	my @keyCipher = split( //, $key );

	# Math functions.
	my $firstShift;
	my @addCipher;
	while ( defined( $firstShift = shift( @keyCipher ))) {
		my $secondShift = shift( @indCipher );
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
}

# Decryption Sub-Routine.
sub decipherMsg( $ )
{
	my @preKey = split( //, $inputMessage );
	
	# Ask user to input a key.
	print "\nPlease enter the KEY: ";
	my $key = <STDIN>;
	chomp $key;
	if ( $key !~ m/^\d/ ) {
		print "\nInvalid key entered, please use only digits!\n";
		exit;
	}
	my @keyCipher = split( //, $key );

	# Math functions.
	my $firstShift;
	my @subCipher;
	while ( defined( $firstShift = shift( @keyCipher ))) {
		my $secondShift = shift( @preKey );
		if ( $secondShift < $firstShift ) {
			$secondShift = $secondShift + 10;
		}
		my $math = $secondShift - $firstShift;
		push (@subCipher, $math );
	}
		
	# Convert cipher to plain-text.
	### TODO: FIND A WAY TO PAIR 2'S AND 6'S. MAY NEED TO DO THIS FOR 0'S BECAUSE OF THE 0 HASH PROBLEM IN THE ENCRYPT FUNCTION.
	###
	print Dumper( \@subCipher ); ### DEBUGGING: SHOW CIPHER BEFORE CONVERSION
	my @postCipher;
	my %hashCipher = (
		00 => "a", 20 => "b", 21 => "c", 22 => "d", 5 => "e", 23 => "f",
		24 => "g", 25 => "h", 8 => "i", 26 => "j", 27 => "k", 28 => "l",
		29 => "m", 4 => "n", 3 => "o", 60 => "p", 61 => "q", 9 => "r",
		7 => "s", 1 => "t", 62 => "u", 63 => "v", 64 => "w", 65 => "x",
		66 => "y", 67 => "z", 68 => ".", 69 => "#"
	);
	foreach my $subCipher ( @subCipher ) {
		if ( $subCipher = $hashCipher{$subCipher}) {
			push ( @postCipher, $subCipher );
		}
	}
	# Print decrypted message then exit.
	print Dumper( \@postCipher ); ### DEBUGGING: SHOW MESSAGE AFTER CIPHER HAS BEEN CONVERTED.
}