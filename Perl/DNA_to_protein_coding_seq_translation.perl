#!/usr/bin/perl
=prod
This piece of code read the protein reference file and whole genome sequence (DNA seq). And extract Nucleotide for each protein from the reference genome. It is enough to run this code for each reference once. In variation_in_seq.perl we protein coding DNA seq for each protein and then replace variations to get strain specific protein compliments.
=cut

my $protein_ref_path="/Volumes/ma-home/shyama/DATA/SYBARIS/ReferenceGenome/protein/Aspergillus_nidulans.ASM14920v1.15.pep.all.fa";
#my $DNA_ref_path="/Volumes/ma-home/shyama/DATA/SYBARIS/ReferenceGenome/aspgd/A_fumigatus_Af293_version_s03-m02-r08_chromosomes.fasta";
my $DNA_ref_path="/Volumes/ma-home/shyama/DATA/SYBARIS/ReferenceGenome/aspgd/Aspergillus_nidulans.ASM14920v1.15.dna.toplevel.fa";
my $protein_coding_path="/Volumes/ma-home/shyama/DATA/SYBARIS/ReferenceGenome/proteinCoding/Aspergillus_nidulans.ASM14920v1.15.protein.coding.fa";

=prod
my $protein_ref_path="/Volumes/ma-home/shyama/DATA/SYBARIS/ReferenceGenome/protein/Aspergillus_fumigatusa1163.CADRE.14.pep.all.fa";
my $DNA_ref_path="/Volumes/ma-home/shyama/DATA/SYBARIS/ReferenceGenome/aspgd/A_fumigatus_A1163_chromosomes.fasta.fai";

my $protein_coding_path="/Volumes/ma-home/shyama/DATA/SYBARIS/ReferenceGenome/aspgd/Aspergillus_fumigatus.protein.coding.fa";
=cut


open(DNA,"<",$DNA_ref_path) or die("Could not open ".$DNA_ref_path);

my %seq_hash=();
my $ind="";
while((my $line=<DNA>))
{
    chomp($line);
    if($line=~m/^\>/)
    {
        #print "\n".$line;       
        #push(@seq_array,"");
        $line=~s/\>(\w+)? (.*)?/$1/g;
        #print "\n line:$line";
        #if($ind ne "")
        #{
        #    print "\nPrevious : $ind \n".$seq_hash{$ind};
        #}
        $seq_hash{$line}="";
        $ind=$line;
        #print "\n Size Of Array:".@(keys %seq_hash);
    }
    else
    {
        #$line=~s/\n|\s//g;
        if($ind ne "")
        {
            $seq_hash{$ind}=$seq_hash{$ind}.$line;
        }
        #$seq_array[$ind]=$seq_array[$ind].$line;
    }
}
close(DNA);

#my %base=();
#foreach my $key(keys %seq_array)
#{
#    #my @nucleotide=split('',@seq_array[$i]);
#    print "\n Size of feature ".$key." ".length($seq_hash{$key});
#    $base{$key}=$seq_hash{$key};
#}

open(PRT,"<",$protein_ref_path) or die("Could not open ".$protein_ref_path);

open(PRTWRT,">",$protein_coding_path) or die ("Could not create : $protein_coding_path");

while((my $line=<PRT>))
{
    chomp($line);
    if($line=~m/^\>/)
    {
        print PRTWRT $line."\n";
        my @tags=split(/\s+/,$line);
        #tags are in folowing order protein_id, pep:known/unknown, chromosome:CADRE:chr_number:start:end:starnd gene:gene_id transcript:transcript_id
        my @chr_info=split(/:/,$tags[2]);
        my $seq="";
=prod
        if($chr_info[2]=~m/^I$/)
        {
            $seq=getNucleotide($base[0],$chr_info[3],$chr_info[4]) if(defined($chr_info[3]) and defined($chr_info[4]));
        }
        elsif($chr_info[2]=~m/^II$/)
        {
            $seq=getNucleotide($base[1],$chr_info[3],$chr_info[4]) if(defined($chr_info[3]) and defined($chr_info[4]));
        }
        elsif($chr_info[2]=~m/^III$/)
        {
            $seq=getNucleotide($base[2],$chr_info[3],$chr_info[4]) if(defined($chr_info[3]) and defined($chr_info[4]));
        }
        elsif($chr_info[2]=~m/^IV$/)
        {
            $seq=getNucleotide($base[3],$chr_info[3],$chr_info[4]) if(defined($chr_info[3]) and defined($chr_info[4]));
        }
        elsif($chr_info[2]=~m/^V$/)
        {
            $seq=getNucleotide($base[4],$chr_info[3],$chr_info[4]) if(defined($chr_info[3]) and defined($chr_info[4]));
        }
        elsif($chr_info[2]=~m/^VI$/)
        {
            $seq=getNucleotide($base[5],$chr_info[3],$chr_info[4]) if(defined($chr_info[3]) and defined($chr_info[4]));
        }
        elsif($chr_info[2]=~m/^VII$/)
        {
            $seq=getNucleotide($base[6],$chr_info[3],$chr_info[4]) if(defined($chr_info[3]) and defined($chr_info[4]));
        }
        elsif($chr_info[2]=~m/^VIII$/)
        {
            $seq=getNucleotide($base[7],$chr_info[3],$chr_info[4]) if(defined($chr_info[3]) and defined($chr_info[4]));
        }
=cut
        $seq=getNucleotide($seq_hash{$chr_info[2]},$chr_info[3],$chr_info[4]) if(defined($chr_info[3]) and defined($chr_info[4]));
        print PRTWRT $seq."\n";
    }
}
close(PRTWRT);
close(PRT);



sub getNucleotide
{
    my $chr_seq=shift;
    my $start=shift;
    my $end=shift;
    
    return substr($chr_seq,$start-1,(($end-$start)+1));
}
