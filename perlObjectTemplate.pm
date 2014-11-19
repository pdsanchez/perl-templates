###
### CLASE 
###
### Importar la clase: "use NombreDelFichero" sin el .pm
### use perlObjectTemplate;
###
################################################################################

#!/usr/bin/perl
package perlObjectTemplate;

use strict;
use warnings;

use Benchmark;

use Data::Dumper;
$Data::Dumper::Indent = 1;
$Data::Dumper::Sortkeys = 1;

use constant TRUE  => 1;
use constant FALSE => 0;

$| = 1; # autoflush

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


	my $t0 = new Benchmark;	#tomar tiempos
	
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

	my $dift = timediff(new Benchmark, $t0);	#Duracion
	print "   - Benchmark: ".timestr($dift)."\n";
	
	
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


1; 
