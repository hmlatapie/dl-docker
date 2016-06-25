#!/usr/bin/perl
use Data::Dumper;
use Carp;
use Time::HiRes qw(time sleep);
use Getopt::Long;

$usage = <<EOS;
$0 cmd options
	valid commands:
		run X
			where X = 
				d01
					dl-docker container
				d02
					jupyter/datascience-notebook

	options:
EOS

GetOptions(
	'stringparam=s' => \$options{stringparam},
	'booleanparam' => \$options{booleanparam}
	);

confess $usage
	if !@ARGV;

$command = shift;

if($command eq 'run')
{
	$container = shift;
	confess $usage
		if !$container;

	if($container eq 'd01')
	{
		$cn = 'dl-docker01';
	$cmd =<<EOS;
docker rm -f $cn
nvidia-docker run -it -d --name $cn -p 8888:8888 -p 6006:6006 -v /home/hmlatapie/dev/dl-docker:/root/sharedfolder hmlatapie/dl-docker /bin/bash -c /root/sharedfolder/run_daemons
EOS
	}
	elsif($container eq 'd02')
	{
		$cn = 'jupyter_datascience01';
	$cmd =<<EOS;
docker rm -f $cn
nvidia-docker run -it -d --name $cn -p 8888:8888 -v /home/hmlatapie/dev/dl-docker:/home/jovyan/work/sharedfolder jupyter/datascience-notebook start-notebook.sh --NotebookApp.base_url=/dl-docker01
EOS
	}
	else
	{
		confess "bad container name: $container";
	}
	open $f, "$cmd |";
	print
		while <$f>;
}
else
{
	confess $usage;
}

