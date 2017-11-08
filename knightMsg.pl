#!/usr/bin/perl

=head1 NAME

knightMsg.pl

=head1 SYNOPSIS

This script will take user input, convert it to a Straddling Checkerboard cipher, and apply a user selected key to encrypt the message. To decrypt message just enter in message and key. The pencil and paper version uses # symbols to denote the start and end of a sequence of numbers. This script is also compatible with the pencil and paper version of the cipher.

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

2017/11/08 - Started work on issue #20.
2017/11/03 - Key length check is now performed issue #17.
2017/10/28 - Issue #6 is now fixed and script handles numbers.
2017/10/23 - Fixed issue #15.
2015/12/02 - Fixed bug in cipherMsg subroutine.
2015/12/01 - Cleaned up script.
2014/06/05 - Finished work on the decryption function. Program is now functional.
2014/03/30 - Started work on the decryption portion of this script. Still a lot of work to do.
2014/03/03 - Reduced script size by converting the array into a hash.
2014/01/20 - First version of the script has been written. Next step will be to modify it so it'll also decrypt messages.

=head1 AUTHOR

C. Frishkorn

=cut

$main::VERSION = "1.81B";

use warnings;
use strict;

# Ask user to input message.
print "\nPLEASE ENTER MESSAGE: ";
my $inputMessage = <STDIN>;
chomp $inputMessage;

# Find the message length for key length checks.
my $msgLength = length $inputMessage;

if ($inputMessage =~ m/^\d/) {
	decipherMsg($inputMessage);
} else {
	cipherMsg($inputMessage);
}

# Encryption Sub-Routine.
sub cipherMsg
{
	# Take plain-text and cipher it into numbers only.
	my @preCipher = split(//, $inputMessage);
	@preCipher = map {lc} @preCipher;
	my %hashCipher = (
		a => "00", b => "20", c => "21", d => "22", e => "05", f => "23",
		g => "24", h => "25", i => "08", j => "26", k => "27", l => "28",
		m => "29", n => "04", o => "03", p => "60", q => "61", r => "09",
		s => "07", t => "01", u => "62", v => "63", w => "64", x => "65",
		y => "66", z => "67", " " => "68", "." => "68", "#" => "69"
	);
	my @postCipher;
	foreach my $preCipher (@preCipher) {
        # If message contains #, pad digits to obscure them. Otherwise push ciphered letters into array.
        if ($preCipher =~ m/\x23|\d/) {
		if ($preCipher =~ m/\x23/) {
			push (@postCipher, $hashCipher{$preCipher});
		} else {
			foreach my $iii (0..2) {
				push (@postCipher, '9', $preCipher);
				$msgLength++;
			}
		}
	} elsif ($preCipher = $hashCipher{$preCipher}) {
		push (@postCipher, $preCipher);
	} else {
		print "\nINVALID CHARACTER!\n";
		exit;
		}
	}
    
	# Split postCipher array into individual digits to make math operations easier.
	my $cmpCipher = join ('', @postCipher);
	my @cmpCipher = split(//, $cmpCipher);
	my @indCipher;
	foreach my $cmpCipher (@cmpCipher) {
		push (@indCipher, $cmpCipher);
	}
	print "\n";
	print ('              CIPHER: ', @indCipher);

	# Ask user to input a key.
	print "\n\nPLEASE ENTER THE KEY: ";
	my $key = <STDIN>;
	chomp $key;
	if ($key !~ m/^\d/) {
		print "\nINVALID KEY ENTERED, PLEASE USE ONLY DIGITS!\n";
		exit;
	}
	if (length $key != $msgLength * 2) {
		print "\nKEY LENGTH NEEDS TO BE EQUAL TO MESSAGE!\n";
		exit;
	}
	my @keyCipher = split(//, $key);

	# Math functions.
	my $firstShift;
	my @addCipher;
	while (defined($firstShift = shift(@keyCipher))) {
		my $secondShift = shift(@indCipher);
		my $math = $firstShift + $secondShift;
		if ($math >= 10) {
			$math = $math - 10;
			}
		push (@addCipher, $math);
	}

	# Print encrypted message then exit.
	print "\n";
	print ('             MESSAGE: ', @addCipher);
	print "\n\n";
	exit();
}

# Decryption Sub-Routine.
sub decipherMsg
{
	my @preKey = split(//, $inputMessage);
	
	# Ask user to input a key.
	print "\nPLEASE ENTER THE KEY: ";
	my $key = <STDIN>;
	chomp $key;
	if ($key !~ m/^\d/) {
		print "\nINVALID KEY ENTERED, PLEASE USE ONLY DIGITS!\n";
		exit;
	}
	if (length $key != $msgLength) {
		print "\nKEY LENGTH NEEDS TO BE EQUAL TO MESSAGE!\n";
		exit;
	}
	my @keyCipher = split(//, $key);

	# Math functions.
	my $firstShift;
	my @subCipher;
	while (defined($firstShift = shift(@keyCipher))) {
		my $secondShift = shift(@preKey);
		if ($secondShift < $firstShift) {
			$secondShift = $secondShift + 10;
		}
		my $math = $secondShift - $firstShift;
		push (@subCipher, $math);
	}
	# Merge single digit numbers to double digit numbers.
	my $combCipher = join ('', @subCipher);
	my $twoCipher = $combCipher;
	my @combCipher = ($twoCipher =~ m/.{2}/g);
	
	# Convert cipher to plain-text.
	my @postCipher;
	my %hashCipher = (
		"00" => "a", "20" => "b", "21" => "c", "22" => "d", "05" => "e", "23" => "f",
		"24" => "g", "25" => "h", "08" => "i", "26" => "j", "27" => "k", "28" => "l",
		"29" => "m", "04" => "n", "03" => "o", "60" => "p", "61" => "q", "09" => "r",
		"07" => "s", "01" => "t", "62" => "u", "63" => "v", "64" => "w", "65" => "x",
		"66" => "y", "67" => "z", "68" => ".", "69" => "#"
	);
	my $digitCount = 0;
	foreach my $combCipher (@combCipher) {
		# If $combCiper starts with a 9 treat as a number and remove padded digits.
		if ($combCipher =~ m/^9/ && $digitCount < 2) {
			delete $combCipher[0];
			$digitCount++;
		} elsif ($combCipher =~ m/^9/ && $digitCount > 1) {
			$combCipher = $combCipher - 90;
			push (@postCipher, $combCipher);
			$digitCount = 0;
		} else {
			push (@postCipher, $hashCipher{$combCipher});
		}
	}
	my $postCipher = join ('', @postCipher);
	
	# Print decrypted message then exit.
	print "\n";
	print ('       FINAL MESSAGE: ', uc $postCipher);
	print "\n\n";
	exit();
}
