#!/usr/bin/perl

=head1 NAME

knightMsg.pl

=head1 SYNOPSIS

This script will take user input, convert it to a Straddling Checkerboard cipher, and apply a user selected key to encrypt the message. To decrypt message just enter in message and key.

=head1 OPTIONS

No options at this time.

=head1 EXAMPLES

PLEASE ENTER MESSAGE: Hello

              CIPHER: 2505282803

PLEASE ENTER THE KEY: 3828247373

             MESSAGE: 5323429176
			 
PLEASE ENTER MESSAGE: 5323429176

PLEASE ENTER THE KEY: 3828247373

       FINAL MESSAGE: HELLO

=head1 DESCRIPTION

2015/12/02 - Fixed bug in cipherMsg subroutine.
2015/12/01 - Cleaned up code.
2014/06/05 - Finished work on the decryption function. Program is now functional.
2014/03/30 - Started work on the decryption portion of this script. Still a lot of work to do.
2014/03/03 - Reduced code size by converting the array into a hash.
2014/01/20 - First version of the script has been written. Next step will be to modify it so it'll also decrypt messages.

=head1 AUTHOR

C. Frishkorn

=cut

$main::VERSION = "1.5B.000";

use warnings;
use strict;

sub cipherMsg( $ );
sub decipherMsg( $ );

# Ask user to input message.
print "\nPLEASE ENTER MESSAGE: ";
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
		a => "00", b => "20", c => "21", d => "22", e => "05", f => "23",
		g => "24", h => "25", i => "08", j => "26", k => "27", l => "28",
		m => "29", n => "04", o => "03", p => "60", q => "61", r => "09",
		s => "07", t => "01", u => "62", v => "63", w => "64", x => "65",
		y => "66", z => "67", " " => "68", "." => "68", "#" => "69"
	);
	foreach my $preCipher ( @preCipher ) {
        # If it matches a digit we first need to add a #, but only once. This helps the decryption routine know the difference between numbers and letters.
        if ( $preCipher =~ m/\d/ ) {
			foreach my $iii (0..3) {
				push ( @postCipher, $preCipher );
			}
		} elsif ( $preCipher = $hashCipher{$preCipher}) {
			push ( @postCipher, $preCipher );
		} else {
			print "\nINVALID CHARACTER!\n";
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
	print "\n\nPLEASE ENTER THE KEY: ";
	my $key = <STDIN>;
	chomp $key;
	if ( $key !~ m/^\d/ ) {
		print "\nINVALID KEY ENTERED, PLEASE USE ONLY DIGITS!\n";
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
	exit();
}

# Decryption Sub-Routine.
sub decipherMsg( $ )
{
	my @preKey = split( //, $inputMessage );
	
	# Ask user to input a key.
	print "\nPLEASE ENTER THE KEY: ";
	my $key = <STDIN>;
	chomp $key;
	if ( $key !~ m/^\d/ ) {
		print "\nINVALID KEY ENTERED, PLEASE USE ONLY DIGITS!\n";
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
		push ( @subCipher, $math );
	}
	# Merge single digit numbers to double digit numbers.
	my $combCipher = join ( '', @subCipher );
	my $twoCipher = $combCipher;
    my @combCipher = ( $twoCipher =~ m/.{2}/g );
		
	# Convert cipher to plain-text.
	my @postCipher;
	my %hashCipher = (
		"00" => "a", "20" => "b", "21" => "c", "22" => "d", "05" => "e", "23" => "f",
		"24" => "g", "25" => "h", "08" => "i", "26" => "j", "27" => "k", "28" => "l",
		"29" => "m", "04" => "n", "03" => "o", "60" => "p", "61" => "q", "09" => "r",
		"07" => "s", "01" => "t", "62" => "u", "63" => "v", "64" => "w", "65" => "x",
		"66" => "y", "67" => "z", "68" => ".", "69" => "#"
	);
	foreach my $combCipher ( @combCipher ) {
		if ( $combCipher = $hashCipher{$combCipher}) {
			push ( @postCipher, $combCipher );
		}
	}
	my $postCipher = join ( '', @postCipher );
	
	# Print decrypted message then exit.
	print "\n";
	print ( '       FINAL MESSAGE: ', uc $postCipher );
	print "\n\n";
	exit();
}
