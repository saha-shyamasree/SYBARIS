#!/usr/bin/perl


my @in_files=glob("*_1.fastq.gz");


foreach my $in(@in_files)
{
  $in=~s/_1\.fastq\.gz//;
    my $command="bsub -o /nfs/ma/home/shyama/outputs/SYBARIS/nexus_pipe_".$in.".out -M 10000 -R \'rusage[mem=10000]\' \"perl /nfs/ma/home/shyama/code/SYBARIS/Perl/single_file.perl ".$in."\"";
    print "\n $command";
    system($command);
}
#one single file will call all process programs for one pair. this code should sit on of that, so read all the files names and send to previously mentioned one.
