#!/usr/bin/perl

#use warnings;

open(READ,"<","/Volumes/ma-home-1/shyama/outputs/SYBARIS/R/AF293/gap_penalty/noHitContigsByCoverage.csv") or die("Could not open file");

my $prev_file="";
my %contig_hash=();
my @node_array=();
#my @all=<READ>;
while(<READ>)
{
    chomp;
    my $line=$_;
    #print $line."\n";
    #my $line = $_;
    if($line=~ m/^serial/)
    {
        print "header\n";
    }
    else
    {
        #print "in else\n";
        my @tokens=split(",",$_);
        #print $tokens[2];
        unless($prev_file)
        {
            print "prev file empty:".$tokens[1]."\n";
            $prev_file=$tokens[1];
            print "after assign :".$prev_file;
        }
        if($tokens[1] ne $prev_file && $prev_file ne "")
        {
            @{$contig_hash{$prev_file}}=@node_array;
            print "\n".$tokens[1]." is equal to ".$prev_file."size of node array".@node_array."\t from hash:".@{$contig_hash{$prev_file}};
            $prev_file=$tokens[1];
            @node_array=();
        }
        #print "\nsize of node array".@node_array;
        push(@node_array,$tokens[2]);
    }
}
$contig_hash{$prev_file}=\@node_array;
print "\n".$tokens[1]." is equal to ".$prev_file."size of node array".@node_array."\t from hash:".@{$contig_hash{$prev_file}};
close(READ);

foreach my $key (keys %contig_hash)
{
    my @arr=@{$contig_hash{$key}};
    print "\n key:".$key.",size:".@arr;
}
my $path="/Volumes/ma-home-1/SYBARIS/WGS-AF293/D0A-unaligned/";


foreach my $key (keys %contig_hash)
{
    my @array=@{$contig_hash{$key}};
    print "\n no hit for this file".$key.":".@array;
    my $file = $path.$key."/contigs.fa";
    open(READ,"<",$file) or die("Could not open:".$file);
    my $out_path = "/Volumes/ma-home-1/shyama/outputs/SYBARIS/Perl/AF293/gap_penalty/".$key;
    if(!(-d $out_file))
    {
        mkdir($out_path);
    }
    my $out_file=$out_path."/contigs.fa";
    open(WRT,">",$out_file) or die("Could not create ".$out_file);
    my $found_flag=0;
    while (my $line=<READ>)
    {
        chomp $line;
                
        if($line=~ m/^>/)
        {
            $line=~s/\>//g;
            #print "\n line:".$line;

            if ( grep( /\Q$line/, @array ) ) {
                print "\nfound it".$line;
                print WRT ">".$line."\n";
                $found_flag=1;
            }
            else
            {
                $found_flag=0;
            }
        }
        else
        {
            if($found_flag==1)
            {
                print WRT $line."\n";
            }
        }
    }
    close(WRT);
    close(READ);
}