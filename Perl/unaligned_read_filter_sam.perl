#!/usr/bin/perl
use File::Basename;

sub unaligned
{
	my $file=shift;

	open(READ,"<",$file) or die("Could not open $file");
	my %hash=();
	while((my line=<READ>))
	{
		chomp($line);	
	}
}

my ($sam_path,$fastq_path)=@_;
my @files=glob($path."*.sam");

foreach my $file(@files)
{
	my $name=basename($file,(sam));
	my $unaligned_read_hash=unaligned($file);
}
