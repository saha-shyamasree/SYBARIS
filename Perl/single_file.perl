#!/usr/bin/perl

my $perl_code_path="/nfs/ma/home/shyama/code/SYBARIS/Perl/";
my $sam_path="/nfs/ma/home/shyama/installed_soft/samtools-0.1.18";
my $velvet_path="/nfs/ma/home/shyama/installed_soft/velvet_1.2.06";
my $path_bowtie2="/nfs/ma/home/shyama/installed_soft/bowtie2-2.0.0-beta6/bowtie2";

my %ref_files=('all'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/aspgd/A_fumigatus_Af293_version_s03-m02-r08_chromosomes.fasta",
                'B07BNABXX_2_4'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/aspgd/A_nidulans_FGSC_A4_version_s09-m01-r04_chromosomes.fasta",
                'C023MABXX_3_8'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/aspgd/A_nidulans_FGSC_A4_version_s09-m01-r04_chromosomes.fasta",
                'D0ACKACXX_1_12'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/aspgd/N_fischeri_NRRL_181_chromosomes.fasta",
                'B07BNABXX_1_9'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/aspgd/A_fumigatus_A1163_chromosomes.fasta",
                'C023MABXX_5_2'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/aspgd/A_fumigatus_A1163_chromosomes.fasta");

my %index_list=('all'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/aspgd/AF293/AF293",
                     'B07BNABXX_2_4'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/aspgd/F8226/F8226",
                     'C023MABXX_3_8'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/aspgd/F8226/F8226",
                     'D0ACKACXX_1_12'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/aspgd/F4S9A/F4S9A",
                     'B07BNABXX_1_9'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/aspgd/A1163/A1163",
                     'C023MABXX_5_2'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/aspgd/A1163/A1163");

my $in=shift;
pipeline($in);


sub error
{
    if ($? == -1) {
        print "failed to execute: $!\n";
    }
    elsif ($? & 127) {
        printf "child died with signal %d, %s coredump\n",
        ($? & 127), ($? & 128) ? 'with' : 'without';
    }
    else {
        printf "child exited with value %d\n", $? >> 8;
    }
}
sub fastqFilter
{
  my $base=shift;
  my $command="perl ".$perl_code_path."fastq-filter-fixed_shyama.pl ".$base."_1.fastq.gz ".$base."_2.fastq.gz";
  print "\nfastqFilter: $command";
  system($command);
}

sub alignment
{
    my $base=shift;
    
    my $index=$index_list{all};
    if($index_list{$base})
    {
        $index=$index_list{$base};
    }
    
    my $command=$path_bowtie2." -x ".$index." -1 ".$base."_1.fastq.gz -2 ".$base."_2.fastq.gz --un un-aligned/".$base.".fastq -S sam/".$base.".sam";
    print "\nalignment:$command";
    system($command);
    error();
    if($base=~m/B07BNABXX_1_9/ || $base=~m/C023MABXX_5_2/)
    {
        $index=$index_list{all};
        my $command=$path_bowtie2." -x ".$index." -1 ".$base."_1.fastq.gz -2 ".$base."_2.fastq.gz --un un-aligned/".$base."_AF293.fastq -S sam/".$base."_AF293.sam";
        print "\nalignment,1_9/5_2:$command";
        system($command);
        error();
    }
}

sub samToBam
{
    my $base=shift;
    my $com1=$sam_path."\/./samtools view -u -S sam/".$base.".sam -o bamFull/".$base.".bam";
    system($com1);
    error();
    if($base=~m/B07BNABXX_1_9/ || $base=~m/C023MABXX_5_2/)
    {
        $com1=$sam_path."\/./samtools view -u -S sam/".$base."_AF293.sam -o bamFull/".$base."_AF293.bam";
        system($com1);
        error();
    }
}

sub samToBam_no_wait
{
    my $base=shift;
    my $com1=$sam_path."\/./samtools view -u -S sam/".$base.".sam -o bamFull/".$base.".bam";
    system($com1);
    error();
    
    if($base=~m/B07BNABXX_1_9/ || $base=~m/C023MABXX_5_2/)
    {
        $com1=$sam_path."\/./samtools view -u -S sam/".$base."_AF293.sam -o bamFull/".$base."_AF293.bam";
        system($com1);
        error();
    }
}
sub separation
{
    my $base=shift;
    
    my $command=$sam_path."\/./samtools view -f4 -h bamFull/".$base.".bam > unmapped/".$base.".sam";
    #print "\nSeparation, Unmapped: $command";
    system($command);
    error();
    $command=$sam_path."\/./samtools view -F4 -h bamFull/".$base.".bam > mapped/".$base.".sam"; # 
    print "\nSeparation,Mapped: $command";
    system($command);
    error();
    if($base=~m/B07BNABXX_1_9/ || $base=~m/C023MABXX_5_2/)
    {
        $command=$sam_path."\/./samtools view -f4 -h bamFull/".$base."_AF293.bam > unmapped/".$base."_AF293.sam";
        #print "\nSeparation, Unmapped,1_9/5_2: $command";
        system($command);
        error();
        $command=$sam_path."\/./samtools view -F4 -h bamFull/".$base.".bam > mapped/".$base."_AF293.sam"; # 
        print "\nSeparation, Mapped, 1_9/5_2: $command";
        system($command);
        error();
    }
}


sub snpCall
{
    my $base=shift;
    
    my $refe=$ref_files{all};
    if($ref_files{$base})
    {
        $refe=$ref_files{$base};
    }
    print "\n Reference fasta :".$refe;
    #my $com1=$sam_path."\/./samtools view -u -S mapped/".$base.".sam -o bam/".$base.".bam";#  
    #system($com1);
    #error();
    #my $com2=$sam_path."\/./samtools sort bam/".$base.".bam sorted/".$base;#-w \'done(\"".$base."_bam\")\' 
    #print "\ncom2: ".$com2;
    #system($com2);
    #error();
    #my $com3=$sam_path."\/./samtools index sorted/".$base.".bam bam/".$base.".index";
    #system($com3);
    #print "\ncom3: ".$com3;
    #error();
    my $com4=$sam_path."\/./samtools mpileup -E -ugf ".$refe." sorted/".$base.".bam | ".$sam_path."\/bcftools/./bcftools view -bvcg - > bcf/".$base.".bcf";
    system($com4);
    print "\ncom4: ".$com4;
    error();
    #bcftools view .bcf | vcfutils.pl varFilter -D 500 -d 20 | ./filter.pl > .vcf
    my $com5=$sam_path."/bcftools\/./bcftools view bcf/".$base.".bcf | ".$sam_path."\/bcftools/vcfutils.pl varFilter -D 500 -d 20 | ".$perl_code_path."./filter.pl > vcf/".$base.".vcf";
    print "\n Command 5: $com5";
    system($com5);
    error();

    if($base=~m/B07BNABXX_1_9/ || $base=~m/C023MABXX_5_2/)
    {
        $refe=$ref_files{all};
        #my $com1="bsub -o /nfs/ma/home/shyama/outputs/SYBARIS/".$base."_bam_convert.txt -w \'done(\"".$base."_AF293_mapped\")\' -J ".$base."_AF293_bam \"".$sam_path."\/./samtools view -u -S mapped/".$base."_AF293.sam -o bam/".$base."_AF293.bam\""; #
        #system($com1);
        #error();
        #my $com2=$sam_path."\/./samtools sort bam/".$base."_AF293.bam sorted/".$base."_AF293";#-w \'done(\"".$base."_AF293_bam\")\' 
        #system($com2);
        #error();
        #my $com3=$sam_path."\/./samtools index sorted/".$base."_AF293.bam bam/".$base."_AF293.index";
        #system($com3);
        #error();
        my $com4=$sam_path."\/./samtools mpileup -E -ugf ".$refe." sorted/".$base."_AF293.bam | ".$sam_path."\/bcftools/./bcftools view -bvcg - > bcf/".$base."_AF293.bcf";
        system($com4);
        error();
        #bcftools view .bcf | vcfutils.pl varFilter -D 500 -d 20 | ./filter.pl > .vcf
        my $com4=$sam_path."\/bcftools/./bcftools view bcf/".$base."_AF293.bcf | ".$sam_path."\/bcftools/vcfutils.pl varFilter -D 500 -d 20 | ".$perl_code_path."./filter.pl > vcf/".$base."_AF293.vcf";
        system($com4);
        error();
    }

}

sub contigsCreation
{
    my $base=shift;
    if(!(-d "contigs/".$base))
    {
        mkdir "contigs/".$base;
    }
    my $command=$velvet_path."\/./velveth contigs/".$base."/ 21 -shortPaired -sam unmapped/".$base.".sam";
    system($command);
    error();
    my $command1=$velvet_path."\/./velvetg contigs/".$base."/ -cov_cutoff auto -exp_cov auto -min_contig_lgth 100";
    system($command1);
    error();
    if($base=~m/B07BNABXX_1_9/ || $base=~m/C023MABXX_5_2/)
    {
        if(!(-d "contigs/".$base."_AF293"))
        {
            mkdir "contigs/".$base."_AF293";
        }
        my $command=$velvet_path."\/./velveth contigs/".$base."_AF293/ 21 -shortPaired -sam unmapped/".$base."_AF293.sam";
        system($command);
        error();
        my $command1=$velvet_path."\/./velvetg contigs/".$base."_AF293/ -cov_cutoff auto -exp_cov auto -min_contig_lgth 100";
        system($command1);
        error();
    }
}

sub pipeline
{
    my $base=shift;
    $base=~s/_1\.fastq.gz//g;
    if(!(-d "bad"))
    {
      mkdir("bad");
    }

    if(!(-d "good"))
    {
      mkdir("good");
    }
    if(!(-d "sam"))
    {
        mkdir("sam");
    }
    
    if(!(-d "un-aligned"))
    {
        mkdir("un-aligned");
    }
    
    if(!(-d "bam"))
    {
        mkdir("bam");
    }
    
    if(!(-d "bamFull"))
    {
        mkdir("bamFull");
    }
    
    if(!(-d "sorted"))
    {
        mkdir("sorted");
    }
    
    if(!(-d "unmapped"))
    {
        mkdir("unmapped");
    }
    
    if(!(-d "mapped"))
    {
        mkdir("mapped");
    }
    
    if(!(-d "contigs"))
    {
        mkdir("contigs");
    }
    if(!(-d "bcf"))
    {
        mkdir("bcf");
    }
    if(!(-d "vcf"))
    {
        mkdir("vcf");
    }
    
    #fastq read filtering
    #fastqFilter($base);
    
    #alignment
    #alignment($base);

    #sam to bam convert for aligned data
    #samToBam_no_wait($base);
    #separating mapped and unmapped reads from bowtie2 output.
    #separation($base);
    
    
    #snp calling
    snpCall($base);
    #velvet call
    #contigsCreation($base);
    
}
