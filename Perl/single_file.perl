#!/usr/bin/perl

my $perl_code_path="/nfs/ma/home/shyama/code/SYBARIS/Perl/";
my $sam_path="/nfs/ma/home/shyama/installed_soft/samtools-0.1.18";
my $velvet_path="/nfs/ma/home/shyama/installed_soft/velvet_1.2.06";
my $path_bowtie2="/nfs/ma/home/shyama/installed_soft/bowtie2-2.0.0-beta6/bowtie2";
#my %ref_files=('all'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Alergenetica/reference/CladosporiumUM_ref/scaffolds1000_340seqs.fasta");
#my %index_list=('all'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Alergenetica/reference/CladosporiumUM_ref/index/cladosporium_um");

#my %ref_files=('all'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/aspgd/Aspergillus_fumigatus.CADRE.15.dna.toplevel.fa");
#my %index_list=('all'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/aspgd/AF293/AF293");
#my %ref_files=('all'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Alergenetica/reference/A.niger/DNA/Aspergillus_niger.CADRE.16.dna.toplevel.velvet.fa");
my %ref_files=('all'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Alergenetica/reference/A.niger/DNA/Aspergillus_niger.CADRE.16.dna.toplevel.fa");
my %index_list=('all'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Alergenetica/reference/A.niger/Index/A.niger.CADRE.16");

=prod
my %ref_files=('all'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/aspgd/Aspergillus_fumigatus.CADRE.15.dna.toplevel.fa",
                'B07BNABXX_2_4'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/aspgd/Aspergillus_nidulans.ASM14920v1.15.dna.toplevel.fa",
                'C023MABXX_3_8'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/aspgd/Aspergillus_nidulans.ASM14920v1.15.dna.toplevel.fa",
                'D0ACKACXX_1_12'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/aspgd/Neosartorya_fischeri.CADRE.15.dna.toplevel.fa",
                'B07BNABXX_1_9'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/aspgd/Aspergillus_fumigatusa1163.CADRE.15.dna.toplevel.fa",
                'C023MABXX_5_2'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/aspgd/Aspergillus_fumigatusa1163.CADRE.15.dna.toplevel.fa",
                '62MDMAAXX_1_5'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                '62MDMAAXX_1_7'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                '64JR6AAXX_5_7'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                '62MDMAAXX_3_7'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                '62MDMAAXX_3_8'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                '62MDMAAXX_4_4'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                '62MDMAAXX_4_5'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                '62MDMAAXX_4_6'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                '62MDMAAXX_5_1'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                '62MDMAAXX_5_2'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                '62MDMAAXX_5_3'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                '64JR6AAXX_7_6'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                '64JR6AAXX_7_7'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                '64JR6AAXX_7_8'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                '64JR6AAXX_8_10'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                '64JR6AAXX_8_11'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                '64JR6AAXX_8_12'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                '64JR6AAXX_8_9'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                'B07BNABXX_1_1'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                'B07BNABXX_1_3'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                'B07BNABXX_1_4'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                'B07BNABXX_1_6'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                'B07BNABXX_1_7'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                'B07BNABXX_1_8'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                'B07BNABXX_2_11'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                'B07BNABXX_2_5'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                'B07BNABXX_2_6'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                'B07BNABXX_2_7'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                'B07BNABXX_2_8'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                'B07BNABXX_3_10'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                'B07BNABXX_3_11'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                'B07BNABXX_3_2'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                'B07BNABXX_3_3'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                'B07BNABXX_3_4'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                'B07BNABXX_3_5'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                'B07BNABXX_3_6'=>"/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/Saccharomyces_cerevisiae.SacCer_Apr2011.15.dna.toplevel.fa",
                '64JR6AAXX_5_10','/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/C_albicans_SC5314_version_A21-s02-m03-r07_chromosomes.fasta',
                '64JR6AAXX_5_11','/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/C_albicans_SC5314_version_A21-s02-m03-r07_chromosomes.fasta',
                '64JR6AAXX_5_12','/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/C_albicans_SC5314_version_A21-s02-m03-r07_chromosomes.fasta',
                '64JR6AAXX_5_9','/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/C_albicans_SC5314_version_A21-s02-m03-r07_chromosomes.fasta',
                '64JR6AAXX_6_1','/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/C_albicans_SC5314_version_A21-s02-m03-r07_chromosomes.fasta',
                '64JR6AAXX_6_2','/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/C_albicans_SC5314_version_A21-s02-m03-r07_chromosomes.fasta',
                '64JR6AAXX_6_3','/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/C_albicans_SC5314_version_A21-s02-m03-r07_chromosomes.fasta',
                '64JR6AAXX_6_4','/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/C_albicans_SC5314_version_A21-s02-m03-r07_chromosomes.fasta',
                '64JR6AAXX_7_5','/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/C_albicans_SC5314_version_A21-s02-m03-r07_chromosomes.fasta',
                '62MDMAAXX_1_8','/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/C_albicans_SC5314_version_A21-s02-m03-r07_chromosomes.fasta',
                '62MDMAAXX_2_10','/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/C_albicans_SC5314_version_A21-s02-m03-r07_chromosomes.fasta',
                '62MDMAAXX_2_11','/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/C_albicans_SC5314_version_A21-s02-m03-r07_chromosomes.fasta',
                '62MDMAAXX_2_12','/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/C_albicans_SC5314_version_A21-s02-m03-r07_chromosomes.fasta',
                '62MDMAAXX_2_9','/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/C_albicans_SC5314_version_A21-s02-m03-r07_chromosomes.fasta',
                'B07BNABXX_3_1','/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/DNA/C_albicans_SC5314_version_A21-s02-m03-r07_chromosomes.fasta');


my %index_list=('all'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/aspgd/AF293/AF293",
                    'B07BNABXX_2_4'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/aspgd/F8226/F8226",
                    'C023MABXX_3_8'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/aspgd/F8226/F8226",
                    'D0ACKACXX_1_12'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/aspgd/F4S9A/F4S9A",
                    'B07BNABXX_1_9'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/aspgd/A1163/A1163",
                    'C023MABXX_5_2'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/aspgd/A1163/A1163",
                    '62MDMAAXX_1_5'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    '62MDMAAXX_1_7'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    '64JR6AAXX_5_7'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    '62MDMAAXX_3_7'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    '62MDMAAXX_3_8'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    '62MDMAAXX_4_4'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    '62MDMAAXX_4_5'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    '62MDMAAXX_4_6'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    '62MDMAAXX_5_1'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    '62MDMAAXX_5_2'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    '62MDMAAXX_5_3'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    '64JR6AAXX_7_6'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    '64JR6AAXX_7_7'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    '64JR6AAXX_7_8'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    '64JR6AAXX_8_10'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    '64JR6AAXX_8_11'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    '64JR6AAXX_8_12'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    '64JR6AAXX_8_9'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    'B07BNABXX_1_1'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    'B07BNABXX_1_3'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    'B07BNABXX_1_4'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    'B07BNABXX_1_6'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    'B07BNABXX_1_7'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    'B07BNABXX_1_8'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    'B07BNABXX_2_11'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    'B07BNABXX_2_5'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    'B07BNABXX_2_6'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    'B07BNABXX_2_7'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    'B07BNABXX_2_8'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    'B07BNABXX_3_10'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    'B07BNABXX_3_11'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    'B07BNABXX_3_2'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    'B07BNABXX_3_3'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    'B07BNABXX_3_4'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    'B07BNABXX_3_5'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    'B07BNABXX_3_6'=>"/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SacCer/SacCer",
                    '64JR6AAXX_5_10','/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SC5314/SC5314',
                    '64JR6AAXX_5_11','/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SC5314/SC5314',
                    '64JR6AAXX_5_12','/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SC5314/SC5314',
                    '64JR6AAXX_5_9','/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SC5314/SC5314',
                    '64JR6AAXX_6_1','/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SC5314/SC5314',
                    '64JR6AAXX_6_2','/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SC5314/SC5314',
                    '64JR6AAXX_6_3','/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SC5314/SC5314',
                    '64JR6AAXX_6_4','/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SC5314/SC5314',
                    '64JR6AAXX_7_5','/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SC5314/SC5314',
                    '62MDMAAXX_1_8','/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SC5314/SC5314',
                    '62MDMAAXX_2_10','/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SC5314/SC5314',
                    '62MDMAAXX_2_11','/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SC5314/SC5314',
                    '62MDMAAXX_2_12','/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SC5314/SC5314',
                    '62MDMAAXX_2_9','/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SC5314/SC5314',
                    'B07BNABXX_3_1','/nfs/ma/home/shyama/DATA/SYBARIS/Index/yeast/SC5314/SC5314');

=cut

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
    
    my $command=$path_bowtie2." -x ".$index." -1 good/".$base."_1.fastq.gz -2 good/".$base."_2.fastq.gz --un un-aligned/".$base.".fastq -S sam/".$base.".sam";
    print "\nalignment:$command \n";
    system($command);
    error();
=prod
this should be incorporated for future
    if(!(-d "sam/Filtered"))
    {
        mkdir "sam/Filtered";
    }
    my $command1="samtools view -S -F 268 -b -q 20 sam/".$base.".sam"." | samtools sort - sam/Filtered/".$base.".bam";
    system($command1);
=cut    
    error();
    
    if($base=~m/B07BNABXX_1_9/ || $base=~m/C023MABXX_5_2/)
    {
        $index=$index_list{all};
        my $command=$path_bowtie2." -x ".$index." -1 good/".$base."_1.fastq.gz -2 good/".$base."_2.fastq.gz --un un-aligned/".$base."_AF293.fastq -S sam/".$base."_AF293.sam";
        print "\nalignment,1_9/5_2:$command";
        system($command);
        error();
    }

}

sub alignmentToAssembly
{
    my $base=shift;
    if(!(-d "samContigsAlign"))
    {
        mkdir "samContigsAlign";
    }
    my $index="contigsAll/".$base."/index/index";
    my $command=$path_bowtie2." -x ".$index." -1 good/".$base."_1.fastq.gz -2 good/".$base."_2.fastq.gz -S samContigsAlign/".$base.".sam";
    print "\nalignment:$command \n";
    system($command);
    error();
}

sub alignmentAssemblyToReference
{
    my $base=shift;
    if(!(-d "samContigsAlignToRef"))
    {
        mkdir "samContigsAlignToRef";
    }
    my $index=$index_list{all};
    my $command=$path_bowtie2." -x ".$index." -f contigsAllReferenceGuided/".$base."/contigs.fa -S samContigsAlignToRef/".$base.".sam";
    print "\nalignment:$command \n";
    system($command);
    error();
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
        $command=$sam_path."\/./samtools view -F4 -h bamFull/".$base."_AF293.bam > mapped/".$base."_AF293.sam"; # 
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
    #print "\n\n";

    print "\n Reference fasta :".$refe;
    #my $com1=$sam_path."\/./samtools view -u -S sam/Filtered/".$base.".sam -o bam/".$base.".bam";#  
    #system($com1);
    #error();
    #my $com2=$sam_path."\/./samtools sort bam/".$base.".bam sorted/".$base;#-w \'done(\"".$base."_bam\")\' 
    #print "\ncom2: ".$com2;
    #system($com2);
    #error();
    #above code obsolute because it has already been sorted and filtered.
    my $com3=$sam_path."\/./samtools index sam/Filtered/".$base.".bam sam/Filtered/".$base.".bam.bai";
    system($com3);
    print "\ncom3: ".$com3;
    error();
    my $com4=$sam_path."\/./samtools mpileup -E -ugf ".$refe." sam/Filtered/".$base.".bam | ".$sam_path."\/bcftools/./bcftools view -bvcg - > sam/Filtered/bcf/".$base.".bcf";
    system($com4);
    print "\ncom4: ".$com4;
    error();
    #bcftools view .bcf | vcfutils.pl varFilter -D 500 -d 20 | ./filter.pl > .vcf
    my $com5=$sam_path."/bcftools\/./bcftools view sam/Filtered/bcf/".$base.".bcf | ".$sam_path."\/bcftools/vcfutils.pl varFilter -D 500 -d 20 | ".$perl_code_path."./filter.pl > sam/Filtered/vcf/".$base.".vcf";
    print "\n Command 5: $com5";
    system($com5);
    error();

    if($base=~m/B07BNABXX_1_9/ || $base=~m/C023MABXX_5_2/)
    {
        $refe=$ref_files{all};
        my $com1=$sam_path."\/./samtools view -u -S mapped/".$base."_AF293.sam -o bam/".$base."_AF293.bam"; #
        system($com1);
        error();
        my $com2=$sam_path."\/./samtools sort bam/".$base."_AF293.bam sorted/".$base."_AF293";#-w \'done(\"".$base."_AF293_bam\")\' 
        system($com2);
        error();
        my $com3=$sam_path."\/./samtools index sorted/".$base."_AF293.bam bam/".$base."_AF293.bam.bai";
        system($com3);
        error();
        my $com4=$sam_path."\/./samtools mpileup -E -ugf ".$refe." sorted/".$base."_AF293.bam | ".$sam_path."\/bcftools/./bcftools view -bvcg - > sam/Filtered/bcf/".$base."_AF293.bcf";
        system($com4);
        error();
        #bcftools view .bcf | vcfutils.pl varFilter -D 500 -d 20 | ./filter.pl > .vcf
        my $com5=$sam_path."\/bcftools/./bcftools view bcf/".$base."_AF293.bcf | ".$sam_path."\/bcftools/vcfutils.pl varFilter -D 500 -d 20 | ".$perl_code_path."./filter.pl > sam/Filtered/vcf/".$base."_AF293.vcf";
        system($com5);
        error();
    }

}


sub snpCallAll
{
    my $base=shift;
    
    
    if(!(-d "contigsAllMap/"))
    {
        mkdir "contigsAllMap/";
    }
    if(!(-d "contigsAllMap/bam"))
    {
        mkdir "contigsAllMap/bam";
    }
    
    if(!(-d "contigsAllMap/sorted"))
    {
        mkdir "contigsAllMap/sorted";
    }
    
    if(!(-d "contigsAllMap/bcf"))
    {
        mkdir "contigsAllMap/bcf";
    }
    
    if(!(-d "contigsAllMap/vcf"))
    {
        mkdir "contigsAllMap/vcf";
    }
    
    
    my $refe=$ref_files{all};
    if($ref_files{$base})
    {
        $refe=$ref_files{$base};
    }
    #print "\n\n";

    print "\n Reference fasta :".$refe;
    my $com1=$sam_path."\/./samtools view -u -S contigsAllMap/".$base.".sam -o contigsAllMap/bam/".$base.".bam"; 
    system($com1);
    error();
    my $com2=$sam_path."\/./samtools sort contigsAllMap/bam/".$base.".bam contigsAllMap/sorted/".$base;#-w \'done(\"".$base."_bam\")\' 
    print "\ncom2: ".$com2;
    system($com2);
    error();
    my $com3=$sam_path."\/./samtools index contigsAllMap/sorted/".$base.".bam contigsAllMap/bam/".$base.".index";
    system($com3);
    print "\ncom3: ".$com3;
    error();
    my $com4=$sam_path."\/./samtools mpileup -E -ugf ".$refe." contigsAllMap/sorted/".$base.".bam | ".$sam_path."\/bcftools/./bcftools view -bvcg - > contigsAllMap/bcf/".$base.".bcf";
    system($com4);
    print "\ncom4: ".$com4;
    error();
    #bcftools view .bcf | vcfutils.pl varFilter -D 500 -d 20 | ./filter.pl > .vcf
    my $com5=$sam_path."/bcftools\/./bcftools view contigsAllMap/bcf/".$base.".bcf | ".$sam_path."\/bcftools/vcfutils.pl varFilter -D 500 -d 20 | ".$perl_code_path."./filter.pl > contigsAllMap/vcf/".$base.".vcf";
    print "\n Command 5: $com5";
    system($com5);
    error();

}


sub snpCallAllMappedToContig
{
    my $base=shift;
    
    
    if(!(-d "samContigsAlign/"))
    {
        mkdir "contigsAllMap/";
    }
    if(!(-d "samContigsAlign/bam"))
    {
        mkdir "samContigsAlign/bam";
    }
    
    if(!(-d "samContigsAlign/sorted"))
    {
        mkdir "samContigsAlign/sorted";
    }
    
    if(!(-d "samContigsAlign/bcf"))
    {
        mkdir "samContigsAlign/bcf";
    }
    
    if(!(-d "samContigsAlign/vcf"))
    {
        mkdir "samContigsAlign/vcf";
    }
    
    
    my $refe="contigsAll/".$base."/contigs.fa";
    #print "\n\n";

    print "\n Reference fasta :".$refe;
    my $com1=$sam_path."\/./samtools view -u -S samContigsAlign/".$base.".sam -o samContigsAlign/bam/".$base.".bam"; 
    system($com1);
    error();
    my $com2=$sam_path."\/./samtools sort samContigsAlign/bam/".$base.".bam samContigsAlign/sorted/".$base;#-w \'done(\"".$base."_bam\")\' 
    print "\ncom2: ".$com2;
    system($com2);
    error();
    my $com3=$sam_path."\/./samtools index samContigsAlign/sorted/".$base.".bam samContigsAlign/bam/".$base.".index";
    system($com3);
    print "\ncom3: ".$com3;
    error();
    my $com4=$sam_path."\/./samtools mpileup -E -ugf ".$refe." samContigsAlign/sorted/".$base.".bam | ".$sam_path."\/bcftools/./bcftools view -bvcg - > samContigsAlign/bcf/".$base.".bcf";
    system($com4);
    print "\ncom4: ".$com4;
    error();
    #bcftools view .bcf | vcfutils.pl varFilter -D 500 -d 20 | ./filter.pl > .vcf
    my $com5=$sam_path."/bcftools\/./bcftools view samContigsAlign/bcf/".$base.".bcf | ".$sam_path."\/bcftools/vcfutils.pl varFilter -D 500 -d 20 | ".$perl_code_path."./filter.pl > samContigsAlign/vcf/".$base.".vcf";
    print "\n Command 5: $com5";
    system($com5);
    error();

}



sub snpCallContig
{
    my $base=shift;
    
    
    if(!(-d "samContigsAlign/"))
    {
        mkdir "samContigsAlign/";
    }
    if(!(-d "samContigsAlign/Filtered"))
    {
        mkdir "samContigsAlign/Filtered";
    }
    
    if(!(-d "samContigsAlign/Filtered/bcf"))
    {
        mkdir "samContigsAlign/Filtered/bcf";
    }
    
    if(!(-d "samContigsAlign/Filtered/vcf"))
    {
        mkdir "samContigsAlign/Filtered/vcf";
    }
    
    
    my $refe="contigsAll/".$base."/contigs.fa";
    #print "\n\n";

    
    my $com3=$sam_path."\/./samtools index samContigsAlign/Filtered/".$base.".bam samContigsAlign/Filtered/".$base.".index";
    system($com3);
    print "\ncom3: ".$com3;
    error();
    my $com4=$sam_path."\/./samtools mpileup -E -ugf ".$refe." samContigsAlign/Filtered/".$base.".bam | ".$sam_path."\/bcftools/./bcftools view -bvcg - > samContigsAlign/Filtered/bcf/".$base.".bcf";
    system($com4);
    print "\ncom4: ".$com4;
    error();
    #bcftools view .bcf | vcfutils.pl varFilter -D 500 -d 20 | ./filter.pl > .vcf
    my $com5=$sam_path."/bcftools\/./bcftools view samContigsAlign/Filtered/bcf/".$base.".bcf | ".$sam_path."\/bcftools/vcfutils.pl varFilter -D 500 -d 20 | ".$perl_code_path."./filter.pl > samContigsAlign/Filtered/vcf/".$base.".vcf";
    print "\n Command 5: $com5";
    system($com5);
    error();

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
    my $command1=$velvet_path."\/./velvetg contigs/".$base."/ -cov_cutoff auto -exp_cov auto -min_contig_lgth 600";
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

sub contigsCreationMapped
{
    my $base=shift;
    if(!(-d "contigsMapped/".$base))
    {
        mkdir "contigsMapped/".$base;
    }

    my $command=$velvet_path."\/./velveth contigsMapped/".$base."/ 21 -shortPaired -sam mapped/".$base.".sam";
    system($command);
    error();
    my $command1=$velvet_path."\/./velvetg contigsMapped/".$base."/ -cov_cutoff auto -exp_cov auto -min_contig_lgth 100";
    system($command1);
    error();

    if($base=~m/B07BNABXX_1_9/ || $base=~m/C023MABXX_5_2/)
    {
        if(!(-d "contigsMapped/".$base."_AF293"))
        {
            mkdir "contigsMapped/".$base."_AF293";
        }
        my $command=$velvet_path."\/./velveth contigsMapped/".$base."_AF293/ 21 -shortPaired -sam mapped/".$base."_AF293.sam";
        system($command);
        error();
        my $command1=$velvet_path."\/./velvetg contigsMapped/".$base."_AF293/ -cov_cutoff auto -exp_cov auto -min_contig_lgth 100";
        system($command1);
        error();
    }

}

sub contigsCreationAll
{
    my $base=shift;
    if(!(-d "contigsAll/"))
    {
        mkdir "contigsAll/";
    }
    
    if(!(-d "contigsAll/".$base))
    {
        mkdir "contigsAll/".$base;
    }
    if(!(-d "contigsAll/".$base."/index"))
    {
        mkdir "contigsAll/".$base."/index/";
    }
    my $command=$velvet_path."\/./velveth contigsAll/".$base."/ 21 -shortPaired -sam sam/".$base.".sam";
    system($command);
    error();
    my $command1=$velvet_path."\/./velvetg contigsAll/".$base."/ -cov_cutoff auto -exp_cov auto -min_contig_lgth 600";
    system($command1);
    my $command2="bowtie2-build contigsAll/".$base."/contigs.fa contigsAll/".$base."/index/index";
    system($command2);
    error();

    if($base=~m/B07BNABXX_1_9/ || $base=~m/C023MABXX_5_2/)
    {
        if(!(-d "contigsMapped/".$base."_AF293"))
        {
            mkdir "contigsMapped/".$base."_AF293";
        }
        my $command=$velvet_path."\/./velveth contigsAll/".$base."_AF293/ 21 -shortPaired -sam sam/".$base."_AF293.sam";
        system($command);
        error();
        my $command1=$velvet_path."\/./velvetg contigsAll/".$base."_AF293/ -cov_cutoff auto -exp_cov auto -min_contig_lgth 600";
        system($command1);
        error();
    }
    my $command_genome_file="grep \">\" contigsAll/C11CBACXX_6_7/contigs.fa | awk -F\'_\' \'{print $0 \"\t\" $4;}\' | sed s/\>//g > "."contigsAll/".$base."/".$base."genome"; #this is for coverage plot using bedtools
}

sub contigsCreationFilteredReadsReferenceGuided
{
    my $base=shift;
    my $refe=$ref_files{all};
    
    if(!(-d "contigsAllReferenceGuided/"))
    {
        mkdir "contigsAllReferenceGuided/";
    }
    
    if(!(-d "contigsAllReferenceGuided/".$base))
    {
        mkdir "contigsAllReferenceGuided/".$base;
    }
    if(!(-d "contigsAllReferenceGuided/".$base."/index"))
    {
        mkdir "contigsAllReferenceGuided/".$base."/index/";
    }
    
    my $command=$velvet_path."\/./velveth contigsAllReferenceGuided/".$base."/ 21 -reference ".$refe." -shortPaired -bam sam/Filtered/".$base.".bam";
    system($command);
    error();
    my $command1=$velvet_path."\/./velvetg contigsAllReferenceGuided/".$base."/ -cov_cutoff auto -exp_cov auto -min_contig_lgth 1500";
    system($command1);
    #my $command2="bowtie2-build contigsAllReferenceGuided/".$base."/contigs.fa contigsAllReferenceGuided/".$base."/index/index";
    #system($command2);
    error();
}

sub samFilteringReference
{
    my $base=shift;
    
    if(!(-d "sam/Filtered"))
    {
        mkdir "sam/Filtered";
    }
    my $command="samtools view -S -F 268 -b -q 20 sam/".$base.".sam"." | samtools sort - sam/Filtered/".$base;  #.".bam"
    system($command);
    error();
}

sub samFiltering
{
    my $base=shift;
    
    if(!(-d "samContigsAlign/Filtered"))
    {
        mkdir "samContigsAlign/Filtered";
    }
    my $command="samtools view -S -F 268 -b -q 20 samContigsAlign/".$base.".sam"." | samtools sort - samContigsAlign/Filtered/".$base; #.".bam"
    system($command);
    error();
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
    if(!(-d "sam/Filtered"))
    {
        mkdir("sam/Filtered");
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
    if(!(-d "sam/Filtered/bcf"))
    {
        mkdir("sam/Filtered/bcf");
    }
    if(!(-d "sam/Filtered/vcf"))
    {
        mkdir("sam/Filtered/vcf");
    }
    
    #fastq read filtering
    #fastqFilter($base);
    
    #alignment
    #alignment($base);
    #samFilteringReference($base);
    #sam to bam convert for aligned data
    #samToBam_no_wait($base);
    #separating mapped and unmapped reads from bowtie2 output.
    #separation($base);
    
    
    #snp calling
    snpCall($base);
    #snpCallAll($base);
    #velvet call
    #contigsCreation($base);
    #contigsCreationAll($base);
    #contigsCreationFilteredReadsReferenceGuided($base);
    alignmentAssemblyToReference($base);
    #alignmentToAssembly($base);
    #samFiltering($base);
    #snpCallAllMappedToContig($base);
    #snpCallContig($base);
}
