#!/usr/bin/perl

my @files = glob("*_1.fastq.gz");

foreach my $file(@files)
{
    print "\n Processing $file";
    my $last_index=rindex($file,"_");
    my $base=substr($file,0,$last_index);
    print "\t $base";
    my $command = "bsub -o /nfs/ma/home/shyama/outputs/fastq_filter_fixed_Natalja.out -M 10000 -R \'rusage[mem=10000]\' perl /nfs/ma/home/shyama/code/SYBARIS/Perl/fastq-filter-fixed.pl ".$file." ".$base."_2.fastq.gz > /nfs/ma/home/shyama/outputs/Natalja/log/".$base.".txt";
    system($command);
}
