###
### http://perldoc.perl.org/perlop.html
###
################################################################################

#!/usr/bin/perl

use strict;
use warnings;

use Benchmark;

use Data::Dumper;
$Data::Dumper::Indent = 1;
$Data::Dumper::Sortkeys = 1;

use constant TRUE  => 1;
use constant FALSE => 0;

$| = 1; # autoflush

my $t0 = Benchmark->new;

# TODO Codigo

my $t1 = Benchmark->new;
my $td = timediff($t1, $t0);
print "   - Benchmark: ".timestr($td)."\n";


################################################################################
### FUNCIONES
################################################################################

sub getFiles {
	my ($dir) = @_;
	
	opendir (DIR, $dir) or die $!;
	while (my $filename = readdir(DIR)) {
		my $file = "$dir/$filename";
		if (-f $file && $filename=~/^(.+)\.html$/) {
			# TODO Codigo
		}
	}
	closedir DIR;
}

sub parseFile {
	my ($file) = @_;
	
	open (IN, $file) or die $!;
	while (my $line = <IN>) {
		chomp ($line);
		my @reg = split(/\t/, $line);
		
		# TODO Codigo
	}
	close IN;
}

exit 0;
