###
###
###
######################################################################################################
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


my $t0 = new Benchmark;	#tomar tiempos

# TODO Codigo

# Usar clase embebida
my $obj = NombreClase->new("rutafichero", 18);


my $dift = timediff(new Benchmark, $t0);	#Duracion
print "   - Benchmark: ".timestr($dift)."\n";


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


################################################################################
### CLASE EMBEBIDA
################################################################################

package NombreClase;

sub new {
	my $this = shift;
	my $class = ref($this) || $this;
	my $self = {};

	# ALTERNATIVA
	# my $self = { @_, };
	# $self recibe los parametros (Ej: NombreClase->new(-texto => "hola");	)
	# Ahora $self contiene como key "-texto": $self->{-texto}
	
	my ($file, $value) = @_;
	
	$self->{ATT1} = $value;
	$self->{ATT2} = ();
	
	open(IN, $file) or die "Cannot open $file";
	
	while (my $line = <IN>) {
		next if ($line =~ /^#/);
		chomp $line;
		
		my @reg = split /\t/, $line;
		if (@reg > 0) {
			my $r1 = $reg[0];
			my $r2 = $reg[1];
		
			$self->{ATT2}{$r1}{$r2}++;
		}
	}
	close(IN);
	
	
	bless $self, $class;
	return ($self);
}  

### NOMBRE:  getAtt1()
### ENTRADA: String. El atributo1
### SALIDA:  String con el atributo1
sub getAtt1 {
	my $self = shift;
	
	return $self->{ATT1};
}

### NOMBRE:  setAtt1()
### ENTRADA: String. El nuevo atributo1
sub setAtt1 {
	my $self = shift;
	my ($val) = @_;
	
	$self->{ATT1} = $val;
}

### NOMBRE:  getAtt2()
### ENTRADA: String. La clave del hash
### SALIDA:  Hash con los datos
sub getAtt2 {
	my $self = shift;
	my ($key) = @_;
	
	return $self->{ATT2}{$key};
}

### NOMBRE:  setAtt1()
### ENTRADA: String. El nuevo atributo1
sub setAtt2 {
	my $self = shift;
	my ($key, $val) = @_;
	
	$self->{ATT2}{$key} = $val;
}

### NOMBRE:  addAtt2()
### ENTRADA: String. 
sub addContextWord {
	my $self = shift;
	my ($key, $val) = @_;

	$self->{ATT2}{$key} = $val;
}

sub destroy  {
	my $self = shift;
	delete ($self->{ATT1});
	delete ($self->{ATT2});
}


exit 0; 
