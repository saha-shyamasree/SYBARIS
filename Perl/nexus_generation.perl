#!/usr/bin/perl

# something!

#use lib "/Volumes/ma-home/shyama/code/SYBARIS/Perl/";
use lib "/nfs/ma/home/shyama/code/SYBARIS/Perl/";
use lib "/nfs/ma/home/shyama/installed_soft/lib64/perl5/";
use ProteinSeqParser;
use ProteinSeq;
use NameMap;

my @files=glob("protein/*.fa");
my $ref_file="../../ReferenceGenome/protein/Aspergillus_fumigatus.CADRE.14.pep.all.fa";
my %parser_hash={};

my $mapObj=new NameMap("../../Mapping/AF293_JCVI_name_map.csv");
$mapObj->read();

my $temp_hash_ref=$mapObj->getMapHash();
my %names_mapping=%$temp_hash_ref;

=prod
foreach my $key(keys %names_mapping)
{
    print "\n $key: ".$names_mapping{$key};
}
print "\n Total:".%names_mapping;

(
'C023MABXX_4_1'=>'AF300',                                
'C023MABXX_3_7'=>'F21857',                               
'C023MABXX_3_6'=>'F21732',                               
'C023MABXX_3_5'=>'F21572',                               
'C023MABXX_3_4'=>'F20451',                               
'C023MABXX_3_3'=>'F18454',                               
'C023MABXX_3_2'=>'F18329',                               
'C023MABXX_3_1'=>'F17999',
'C023MABXX_5_2_AF293'=>'CEA10',
'B07BNABXX_1_9_AF293'=>'CEA10-2',                              
'B07BNABXX_2_1'=>'AF293_VKBR1',                          
'B07BNABXX_2_2'=>'AF293_VKBR3',                          
'B07BNABXX_2_3'=>'AF293_VKWH2',                          
'B07BNABXX_3_8'=>'AF300-2',                              
'D0ACKACXX_1_11'=>'F4S1B',                               
'D0ACKACXX_1_2'=>'F18304',                               
'D0ACKACXX_1_3'=>'F20063',                               
'D0ACKACXX_1_5'=>'CF098',                                
'D0ACKACXX_1_6'=>'CF337',                               
'D0ACKACXX_1_7'=>'JN10',                                 
'D0ACKACXX_1_8'=>'D17',                                  
'D0ACKACXX_1_9'=>'F20140',                               
'D0ACKACXX_2_1'=>'M128',                                 
'D0ACKACXX_2_10'=>'SF2S6',                                
'D0ACKACXX_2_13'=>'SF4S10',                               
'D0ACKACXX_2_14'=>'RSF2S8',                               
'D0ACKACXX_2_2'=>'AP65',                                 
'D0ACKACXX_2_3'=>'SF1S5',                                
'D0ACKACXX_2_4'=>'SF1S6',                                
'D0ACKACXX_2_6'=>'SF2S9',                                
'D0ACKACXX_2_7'=>'SF3S1',                                
'D0ACKACXX_2_8'=>'SF3S10',                               
'D0ACKACXX_1_1'=>'F18149'
);
=cut

my $ref_pcsp=new ProteinSeqParser($ref_file);
$ref_pcsp->parse();
my $ref_proteins=$ref_pcsp->getProteinSeq();
print "\n number of ref protein:".$ref_pcsp->getSeqSize();

for(my $i=0;$i<@files;$i++)
{
    my $pcsp=new ProteinSeqParser($files[$i]);
    $pcsp->parse();
    $parser_hash{$files[$i]}=$pcsp;
    if($i>0)
    {
        if(($parser_hash{$files[$i-1]}->{_seqSize})!=($parser_hash{$files[$i]}->{_seqSize}))
        {
            die("Number of protein different".$files[$i]);
        }
    }
}

#its here means all has same number of proteins
if(!(-d "NEXUS"))
{
    mkdir("NEXUS");
}


## this for creating binary nexus file

my $nexus_file="NEXUS/af293_name_binary.csv";
open(NEXUS,">",$nexus_file) or die("\nCould not open ".$nexus_file);
print NEXUS "Protein,Gene";
for(my $j=0;$j<@files;$j++)
{
    my $tt=$files[$j];
    $tt=~s/protein\///g;
    $tt=~s/\.fa//g;
    print NEXUS ",".$names_mapping{$tt};
}
print NEXUS "\n";
for(my $i=0;$i<@$ref_proteins;$i++)
{
    my $temp_p=$ref_proteins->[$i]->getProtein();
    $temp_p=~s/^>//g;
    print NEXUS $temp_p.",".$ref_proteins->[$i]->getGene();
    for(my $j=0;$j<@files;$j++)
    {
	my $seq=$parser_hash{$files[$j]}->getProteinSeqByIndex($i)->getSeq();
        $seq=~s/\*$//g;
	if($ref_proteins->[$i]->getSeq()=~m/\Q$seq/)
	{
	    print NEXUS ",1";
	}
	else
	{
	    print NEXUS ",0";
	}
    }
    print NEXUS "\n";
}

=prod
my $nexus_file="NEXUS/af293_name_sort.nex";
open(NEXUS,">",$nexus_file) or die("\nCould not open ".$nexus_file);
print NEXUS "#NEXUS\n\nBegin data;\nDimensions ntax=".@files." nchar=100;\nFormat datatype=protein gap=- interleave;\nMatrix\n";

for(my $i=0;$i<@$ref_proteins;$i++)
{
    my @af293 = split(/(.{100})/,$ref_proteins->[$i]->getSeq()); # this will contain empty elements in returning array
    @af293 = grep { $_ ne '' } @af293;
    my $max_size=@af293;
    my $max_ind=-1;
    my %split_hash=();
    for(my $j=0;$j<@files;$j++)
    {
	my $seq=$parser_hash{$files[$j]}->getProteinSeqByIndex($i)->getSeq();
        #print "\nSeq:".$seq;
        $seq=~s/\*$//g;
	my @arr = split(/(.{100})/,$seq);
        @arr = grep { $_ ne '' } @arr;
        if(@arr>$max_size)
        {
            $max_ind=$j;
        }
	#print "\nfile j:".$files[$j];
        $split_hash{$files[$j]}=\@arr;
    }
    #now we have splitted version for all files.
    writeNexus(\@af293,\%split_hash,$max_ind,NEXUS);
}

print NEXUS ";\nEnd;\n";
=cut
close(NEXUS);

sub removeEmpty
{
}
sub writeNexus
{
    my $af293=shift;
    my $split_hash=shift;
    my $max_ind=shift;
    my $fh=shift;
    
    print "\n File handler:".$fh;
    my $loop_runner=[];
    if($max_ind==-1)
    {
        $loop_runner=$af293;
    }
    else
    {
        $loop_runner=$split_hash->{$files->[$max_ind]};
    }

    for(my $i=0;$i<@$loop_runner;$i++)
    {
        my $str="";
        $str=$str."AF293\t".getStr($af293,$i)."\n";
	my $non_key=getStr($af293,$i);
	#print "\n non key:".$non_key;
	foreach my $key (sort {$names_mapping{$a} cmp $names_mapping{$b} } keys %names_mapping)
	{
	    #print "$value $names_mapping{$value}\n";
#	    my $stop_ind=index($key,".");
#	    my $start=8;
#	    my $length=$stop_ind-$start;
#            my $nk=substr($key,$start,$length);
	    my $nk="protein/".$key.".fa";
	    if(!$split_hash->{$nk})
	    {
		#print "\n non key:".$non_key;
		$str=$str.$names_mapping{$key}."\t".$non_key."\n";
	    }
	    else
	    {
		$str=$str.$names_mapping{$key}."\t".getStr($split_hash->{$nk},$i)."\n";
	    }
	    #$str=$str.$names_mapping{$key}."\t".getStr($split_hash->{$key},$i)."\n";
	}
        
        print $fh $str;
    }
}

sub getStr
{
    my $arr=shift;
    my $ind=shift;
    my $str="";
    if($ind<@$arr)
    {
        if(length($arr->[$ind])<100)
        {
	    my $size_arr=length($arr->[$ind]);
            #print "\nLess than size:".$size_arr;
            my $gap="-" x (100-$size_arr);
            $str=$arr->[$ind].$gap;
        }
        else
        {
            $str=$arr->[$ind];
        }
    }
    else
    {
        $str="-" x 100;
    }
    return $str;
}
