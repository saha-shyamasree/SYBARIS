#!/usr/bin/perl

my $sam_path="/nfs/ma/home/shyama/installed_soft/samtools-0.1.18/";

my @files=glob("*.bam");
mkpath("unmapped");
mkpath("mapped");
foreach my $f(@files)
{
    my $last_ind=rindex($f,".");
    my $name=substr($f,0,$last_ind);
    print "\n $name";
    my $command="bsub -o /nfs/ma/home/shyama/outputs/SYBARIS/unmapped.txt \"".$sam_path."./samtools view -f4 ".$f." > unmapped/".$name.".sam\"";
    #print "\n $command";
    system($command);
    my $command="bsub -o /nfs/ma/home/shyama/outputs/SYBARIS/unmapped.txt \"".$sam_path."./samtools view -F4 ".$f." > mapped/".$name.".sam\"";
    #print "\n $command";
    system($command);
}