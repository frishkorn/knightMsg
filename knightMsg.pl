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

2014/01/20 - First version of the script has been written. Next step will be to modify it so it'll also decrypt messages.

=head1 AUTHOR

C. Frishkorn

=cut

$main::VERSION = "1.0";

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
my @preCipher = split(//, $inputMessage);
my @postCipher;
foreach my $preCipher ( @preCipher ) {
	if          ( $preCipher =~ s/a/0/i ) {
		push ( @postCipher, $preCipher );
		} elsif ( $preCipher =~ s/b/20/i ) {
		push ( @postCipher, $preCipher );
		} elsif ( $preCipher =~ s/c/21/i ) {
		push ( @postCipher, $preCipher );
		} elsif ( $preCipher =~ s/d/22/i ) {
		push ( @postCipher, $preCipher );
		} elsif ( $preCipher =~ s/e/5/i ) {
		push ( @postCipher, $preCipher );
		} elsif ( $preCipher =~ s/f/23/i ) {
		push ( @postCipher, $preCipher );
		} elsif ( $preCipher =~ s/g/24/i ) {
		push ( @postCipher, $preCipher );
		} elsif ( $preCipher =~ s/h/25/i ) {
		push ( @postCipher, $preCipher );
		} elsif ( $preCipher =~ s/i/8/i ) {
		push ( @postCipher, $preCipher );
		} elsif ( $preCipher =~ s/j/26/i ) {
		push ( @postCipher, $preCipher );
		} elsif ( $preCipher =~ s/k/27/i ) {
		push ( @postCipher, $preCipher );
		} elsif ( $preCipher =~ s/l/28/i ) {
		push ( @postCipher, $preCipher );
		} elsif ( $preCipher =~ s/m/29/i ) {
		push ( @postCipher, $preCipher );
		} elsif ( $preCipher =~ s/n/4/i ) {
		push ( @postCipher, $preCipher );
		} elsif ( $preCipher =~ s/o/3/i ) {
		push ( @postCipher, $preCipher );
		} elsif ( $preCipher =~ s/p/60/i ) {
		push ( @postCipher, $preCipher );
		} elsif ( $preCipher =~ s/q/61/i ) {
		push ( @postCipher, $preCipher );
		} elsif ( $preCipher =~ s/r/9/i ) {
		push ( @postCipher, $preCipher );
		} elsif ( $preCipher =~ s/s/7/i ) {
		push ( @postCipher, $preCipher );
		} elsif ( $preCipher =~ s/t/1/i ) {
		push ( @postCipher, $preCipher );
		} elsif ( $preCipher =~ s/u/62/i ) {
		push ( @postCipher, $preCipher );
		} elsif ( $preCipher =~ s/v/63/i ) {
		push ( @postCipher, $preCipher );
		} elsif ( $preCipher =~ s/w/64/i ) {
		push ( @postCipher, $preCipher );
		} elsif ( $preCipher =~ s/x/65/i ) {
		push ( @postCipher, $preCipher );
		} elsif ( $preCipher =~ s/y/66/i ) {
		push ( @postCipher, $preCipher );
		} elsif ( $preCipher =~ s/z/67/i ) {
		push ( @postCipher, $preCipher );
		} elsif ( $preCipher =~ s/\./68/ ) {
		push ( @postCipher, $preCipher );
		} elsif ( $preCipher =~ s/\s/68/ ) {
		push ( @postCipher, $preCipher );
		} elsif ( $preCipher =~ s/#/69/ ) {
		push ( @postCipher, $preCipher );
		} elsif ( $preCipher =~ m/\d/ ) {
		push ( @postCipher, $preCipher );
		push ( @postCipher, $preCipher );
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

# Print encrypted message.
print "\n";
print ( '             MESSAGE: ', @addCipher );
print "\n\n";
