#/usr/bin/perl

my %total=();
#my $contig_length_file="/nfs/ma/home/shyama/DATA/SYBARIS/Alergenetica/data/Cladosporium/rerun_cladosporium_um/contigsAll/C11CBACXX_6_7/C11CBACXX_6_7.genome";

#my $contig_length_file="/nfs/ma/home/shyama/DATA/SYBARIS/data/referenceIntervalFiles/Aspergillus_fumigatusa1163.CADRE.15.dna.toplevel.genome";
my $contig_length_file="/nfs/ma/home/shyama/DATA/SYBARIS/Alergenetica/reference/A.niger/DNA/Aspergillus_niger.CADRE.16.dna.toplevel.genome";

open(READ,"<",$contig_length_file) or die("\n Could not open $contig_length_file");

while(<READ>)
{
    chomp($_);
    my @key_value=split(/\t/,$_);
    if(@key_value==2)
    {
        $total{$key_value[0]}=$key_value[1];
    }
    else
    {
        die("\n should have two part:".$_);
    }
}

#my $interval_file="/nfs/ma/home/shyama/DATA/SYBARIS/Alergenetica/data/Cladosporium/rerun_cladosporium_um/contigsAll/C11CBACXX_6_7/C11CBACXX_6_7.bed";  #"/nfs/ma/home/shyama/DATA/SYBARIS/Alergenetica/intervals_sorted.bed"

#my $interval_file="/nfs/ma/home/shyama/DATA/SYBARIS/data/referenceIntervalFiles/Aspergillus_fumigatusa1163.CADRE.15.dna.toplevel_interval.bed";  #"/nfs/ma/home/shyama/DATA/SYBARIS/Alergenetica/intervals_sorted.bed"

my $interval_file="/nfs/ma/home/shyama/DATA/SYBARIS/Alergenetica/reference/A.niger/DNA/Aspergillus_niger.CADRE.16.dna.toplevel_interval.bed";


open(WRITE,">",$interval_file) or die("could not open file");

#print WRITE "track name=coords description=\"Chromosome coordinates list\"\n";

foreach $key (sort (keys %total))
{

    for(my $i=0;$i<$total{$key};$i=$i+1000)
    {
        if(($i+1000)<$total{$key})
        {
            print WRITE $key."\t".$i."\t".($i+1000)."\n";
        }
        else
        {
            print WRITE $key."\t".$i."\t".$total{$key}."\n";
        }   
    }

}