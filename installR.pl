#!/usr/bin/perl
use Data::Dumper;
use Carp;
use Time::HiRes qw(time sleep);
use Getopt::Long;

$usage = <<EOS;
$0 cmd options
	valid commands:
		installr
		installirkernel	
	options:
EOS

GetOptions(
	'stringparam=s' => \$options{stringparam},
	'booleanparam' => \$options{booleanparam}
	);

confess $usage
	if !@ARGV;

$command = shift;

if($command eq 'installirkernel')
{
	$cmd =<<EOS;
apt-get install -y libcurl4-openssl-dev
R -e "install.packages(c('curl','httr','repr','pbdZMQ','devtools'))" &&\\ 
R -e "devtools::install_github('IRkernel/IRdisplay')" &&\\
R -e "devtools::install_github('IRkernel/IRkernel')" &&\\
R -e "IRkernel::installspec()"
EOS
	execute($cmd);

}
elsif($command eq 'installr')
{
	$cmd =<<EOS;
wget -qO- http://cran.r-project.org/src/base/R-3/R-3.2.5.tar.gz |tar -zvx -C ./ && cd R-3.2.5 && ./configure --with-x=no && make && make install 
EOS
	execute($cmd);

}
else
{
	confess $usage;
}

sub execute
{
	my $cmd = shift;
	open $f, "$cmd |";
	print
		while <$f>;
}

