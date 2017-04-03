#! /usr/bin/perl
use strict;
use warnings;
use stefans_libs::root;
use Test::More tests => 7;
use stefans_libs::flexible_data_structures::data_table;

use FindBin;
my $plugin_path = "$FindBin::Bin";

my ( $value, @values, $exp, );

my $exec = $plugin_path . "/../scratchbord/convertR_S3_To_S4.pl";
unless ( -d "$plugin_path/data/output/" ) {
	system("mkdir -p $plugin_path/data/output/");
}
ok( -f $exec, 'the script has been found' );

## create a fake R function
open( OUT, ">../scratchbord/test.R" ) or die $!;
print OUT "functionTest <- function ( x,  A='testA', B='testB', C=1 ) {\n"
  . "print ( paste ( x, A, B ) )\n}\n"
  . "\nfunctionTest2 <- function ( x ) {\nprint(x)\n}\n";
close(OUT);

my $cmd   = "perl $exec " 
#. " -debug"
;
my $start = time;
system($cmd );
my $duration = time - $start;
print "Execution time: $duration s\n";

ok( -f "../scratchbord/outpath/test.R", "the intermediate file exists" );
if ( -f "../scratchbord/outpath/test.R" ) {
	open( IN, "<../scratchbord/outpath/test.R" ) or die $!;
	@values = map { chomp; $_; } <IN>;
	close(IN);

	#die "\$exp = ".root->print_perl_var_def(\@values ).";\n";
	$exp = [
		'#\' @name functionTest',
		'#\' @aliases functionTest,NGScollation-method',
		'#\' @rdname functionTest-methods',
		'#\' @docType methods',
		'#\' @description ',
		'#\' @param x  TEXT MISSING',
		'#\' @param A  TEXT MISSING default=\'testA\'',
		'#\' @param B  TEXT MISSING default=\'testB\'',
		'#\' @param C  TEXT MISSING default=1',
		'#\' @title description of function functionTest',
		'#\' @export ',
		'setGeneric(\'functionTest\', ## Name',
'	function ( x,  A=\'testA\', B=\'testB\', C=1 ) { ## Argumente der generischen Funktion',
'		standardGeneric(\'functionTest\') ## der Aufruf von standardGeneric sorgt für das Dispatching',
		'	}',
		')',
		'',
		'setMethod(\'functionTest\', signature = c (\'NGScollation\'),',
		'	definition = function ( x,  A=\'testA\', B=\'testB\', C=1 ) {',
		'print ( paste ( x, A, B ) )',
		'} )',
		'#\' @name functionTest2',
		'#\' @aliases functionTest2,NGScollation-method',
		'#\' @rdname functionTest2-methods',
		'#\' @docType methods',
		'#\' @description ',
		'#\' @param x  TEXT MISSING',
		'#\' @title description of function functionTest2',
		'#\' @export ',
		'setGeneric(\'functionTest2\', ## Name',
		'	function ( x ) { ## Argumente der generischen Funktion',
'		standardGeneric(\'functionTest2\') ## der Aufruf von standardGeneric sorgt für das Dispatching',
		'	}',
		')',
		'',
		'setMethod(\'functionTest2\', signature = c (\'NGScollation\'),',
		'	definition = function ( x ) {',
		'print(x)',
		'} )'
	];

	is_deeply( \@values, $exp, "the intermediate file structure" );
	unlink("../scratchbord/outpath/test.R");
	unlink("../scratchbord/outpath/test.R.log");
}

ok( -f "../R/functionTest.R",  "the final file #1 exists" );
ok( -f "../R/functionTest2.R", "the final file #2 exists" );

if ( -f "../R/functionTest.R" ) {
	open( IN, "<../R/functionTest.R" ) or die $!;
	@values = map { chomp; $_; } <IN>;
	close(IN);

	#print "\$exp = " . root->print_perl_var_def( \@values ) . ";\n";
	$exp = [
		'#\' @name functionTest',
		'#\' @aliases functionTest,NGScollation-method',
		'#\' @rdname functionTest-methods',
		'#\' @docType methods',
		'#\' @description ',
		'#\' @param x  TEXT MISSING',
		'#\' @param A  TEXT MISSING default=\'testA\'',
		'#\' @param B  TEXT MISSING default=\'testB\'',
		'#\' @param C  TEXT MISSING default=1',
		'#\' @title description of function functionTest',
		'#\' @export ',
		'setGeneric(\'functionTest\', ## Name',
'	function ( x,  A=\'testA\', B=\'testB\', C=1 ) { ## Argumente der generischen Funktion',
'		standardGeneric(\'functionTest\') ## der Aufruf von standardGeneric sorgt für das Dispatching',
		'	}',
		')',
		'',
		'setMethod(\'functionTest\', signature = c (\'NGScollation\'),',
		'	definition = function ( x,  A=\'testA\', B=\'testB\', C=1 ) {',
		'print ( paste ( x, A, B ) )',
		'} )'
	];

	is_deeply( \@values, $exp, "the final file #1 file structure" );
	unlink("../R/functionTest.R");
	unlink("../R/functionTest.R.log");
}

if ( -f "../R/functionTest2.R" ) {
	open( IN, "<../R/functionTest2.R" ) or die $!;
	@values = map { chomp; $_; } <IN>;
	close(IN);

	#print "\$exp = " . root->print_perl_var_def( \@values ) . ";\n";
	$exp = [
		'#\' @name functionTest2',
		'#\' @aliases functionTest2,NGScollation-method',
		'#\' @rdname functionTest2-methods',
		'#\' @docType methods',
		'#\' @description ',
		'#\' @param x  TEXT MISSING',
		'#\' @title description of function functionTest2',
		'#\' @export ',
		'setGeneric(\'functionTest2\', ## Name',
'	function ( x ) { ## Argumente der generischen Funktion',
'		standardGeneric(\'functionTest2\') ## der Aufruf von standardGeneric sorgt für das Dispatching',
		'	}',
		')',
		'',
		'setMethod(\'functionTest2\', signature = c (\'NGScollation\'),',
		'	definition = function ( x ) {',
		'print(x)',
		'} )'
	];

	is_deeply( \@values, $exp, "the final file #2 file structure" );
	unlink("../R/functionTest2.R");
	unlink("../R/functionTest2.R.log");
}

unlink("../scratchbord/test.R");

#print "\$exp = ".root->print_perl_var_def($value ).";\n";
