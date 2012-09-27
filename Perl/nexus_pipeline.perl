#!/usr/bin/perl



=prod
# this mandatory for all reference fasta file
./bowtie2-build /nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/aspgd/Aspergillus_nidulans.ASM14920v1.15.dna.toplevel.fa /nfs/ma/home/shyama/DATA/SYBARIS/Index/aspgd/F8226/F8226
./bowtie2-build /nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/aspgd/Neosartorya_fischeri.CADRE.15.dna.toplevel.fa /nfs/ma/home/shyama/DATA/SYBARIS/Index/aspgd/F4S9A/F4S9A
=cut
#my @in_files=(AF10,AF210,AF1163,B5852,B5854,B5856,B5859,B5863,B5866,B5868,B6069,B6074,B6078,B6079,B6081,F11628,F11698,F12865,F14946,F15767,F15861,F16867);
my @in_files=("B07BNABXX_2_4_1.fastq.gz","C023MABXX_3_8_1.fastq.gz","D0ACKACXX_1_12_1.fastq.gz","B07BNABXX_1_9_1.fastq.gz","C023MABXX_5_2_1.fastq.gz");
#my @in_files=("D0ACKACXX_1_5_1.fastq.gz","D0ACKACXX_1_11_1.fastq.gz","D0ACKACXX_1_3_1.fastq.gz","D0ACKACXX_1_6_1.fastq.gz","D0ACKACXX_1_2_1.fastq.gz","D0ACKACXX_1_7_1.fastq.gz");
#my @in_files=glob("*_1.fastq.gz");

foreach my $in(@in_files)
{
  $in=~s/_1\.fastq\.gz//;
    my $command="bsub -o /nfs/ma/home/shyama/outputs/SYBARIS/nexus_pipe_".$in.".out -M 10000 -R \'rusage[mem=10000]\' \"perl /nfs/ma/home/shyama/code/SYBARIS/Perl/single_file.perl ".$in."\"";
    print "\n $command";
    system($command);
}
#one single file will call all process programs for one pair. this code should sit on of that, so read all the files names and send to previously mentioned one.
