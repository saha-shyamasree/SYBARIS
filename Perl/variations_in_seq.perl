#!/usr/bin/perl

=prod
this code replaces SNPs, and INDELs in protein coding sequence (obtained from DNA_to_protein_coding_seq_translation.perl) for each sample and translate that to
protein complement. reference annotation file (gff) is used to find the CDS within protein coding seq which contain both exons and introns.
=cut
use lib "/Users/saha/installed/lib/perl5/";
#use lib "/nfs/ma/home/shyama/installed_soft/lib/perl5/";
use lib "/Volumes/ma-home/shyama/code/SYBARIS/Perl/";
#use lib "/nfs/ma/home/shyama/code/SYBARIS/Perl/";
use Bio::Seq;
use VCFParser;
use VCFRecord;
use ProteinSeq;
use ProteinSeqParser;
use ProteinCodingSeq;
use ProteinCodingSeqParser;
use GFF;
use GFFParser;

my @files=("vcf/B07BNABXX_2_4.vcf","vcf/C023MABXX_3_8.vcf","vcf/D0ACKACXX_1_12.vcf","vcf/B07BNABXX_1_9.vcf","vcf/C023MABXX_5_2.vcf");#glob("vcf/"."*.vcf");

my %different_ref=(B07BNABXX_2_4=>"",C023MABXX_3_8=>"",D0ACKACXX_1_12=>"");

if(!(-d  "protein"))
{
    mkdir("protein");
}
=prod
my $parser=new VCFParser("/Volumes/ma-home/shyama/DATA/SYBARIS/data/vcf/C023MABXX_3_1.vcf");

$parser->read();
=cut

#my $PCSP=new ProteinCodingSeqParser("/Volumes/ma-home/shyama/DATA/SYBARIS/ReferenceGenome/aspgd/Aspergillus_fumigatus.protein.coding.fa");
#my $PCSP=new ProteinCodingSeqParser("/nfs/ma/home/shyama/DATA/SYBARIS/ReferenceGenome/aspgd/Aspergillus_fumigatus.protein.coding.fa");
my $PCSP=new ProteinCodingSeqParser("/Volumes/ma-home/shyama/DATA/SYBARIS/ReferenceGenome/proteinCoding/Aspergillus_fumigatus1163.CADRE.15.protein.coding.fa");
$PCSP->parse();

#my $PSP=new ProteinSeqParser("/Volumes/ma-home/shyama/DATA/SYBARIS/ReferenceGenome/protein/Aspergillus_fumigatus.CADRE.14.pep.all.fa");
my $PSP=new ProteinSeqParser("/Volumes/ma-home/shyama/DATA/SYBARIS/ReferenceGenome/protein/Aspergillus_fumigatusa1163.CADRE.15.pep.all.fa");
$PSP->parse();


my $GFFP=new GFFParser("/Volumes/ma-home/shyama/DATA/SYBARIS/gff/A_fumigatus_Af293_version_s03-m02-r08_features_with_chromosome_sequences.gff");
$GFFP->parse();
my $gArray=$GFFP->getGFF();
print "\n\n GFFP : no of: GFF:".@$gArray;

#$PCSP->printProteinCodingSeqArray();
my $pr=$PCSP->getProteinCodingSeq();
my @prs=@$pr;
my $rps=$PSP->getProteinSeq();
my @ps=@$rps;
if(@ps!=@prs)
{
    die("\nProtein Coding Seq and Protein Seq should have same number of entry.");
}

print "\ntest1\n";
for(my $i=0;$i<@files;$i++)
{
    my $temp_file_name=$files[$i];
    
    $temp_file_name=~s/vcf\///g;
    $temp_file_name=~s/\.vcf//g;
    
    
    print "\n File:".$temp_file_name;
    if(!(exists $different_ref{$temp_file_name}))
    {
        open(WRT,">","protein/".$temp_file_name.".fa");
        if($temp_file_name=~m/B07BNABXX_1_9/ || $temp_file_name=~m/C023MABXX_5_2/)
        {
            $files[$i]=~s/\.vcf/_AF293.vcf/g;
        }
        my $parser=new VCFParser($files[$i]);
        
        $parser->read();
        #$parser->getVCFRecordsByPosition(404129,2912751,"Chr1_A_fumigatus_Af293");
        #$parser->printVCFRecords();
        my $p_ind=0;
        foreach my $p(@prs)
        {
            my $variations=$parser->getVCFRecordsByPosition($p->getStart,$p->getEnd(),$p->getChr());
            if(@$variations>0)
            {
                #printVariations($variations);
                print "\nsMutation for ".$p->getProtein();
                my $mutation=relaceMutation($variations,$p,$GFFP);
                my $seq_obj = Bio::Seq->new(-seq => $mutation,-alphabet => 'dna' );
                if($p->getStrand()=~m/-1/)
                {
                    $seq_obj = $seq_obj->revcom();
                }
                my $seq_prot = $seq_obj->translate(-codontable_id => 4);
                print WRT mutationProtein($p,$seq_prot->seq());
            }
            else
            {
                print "\nNo Mutation for ".$p->getProtein();
                print WRT noMutationProtein($ps[$p_ind]);
            }
            $p_ind=$p_ind+1;
        }
        close(WRT);
    }
    
}

sub noMutationProtein
{
    my $prt=shift;
    my $str=$prt->getProtein()." chromosome:CADRE:".$prt->getChr().":".$prt->getStart().":".$prt->getEnd().":".$prt->getStrand()." gene:".$prt->getGene()." transcript:".$prt->getTranscript()."\n".$prt->getSeq()."\n";
    return $str;
}

sub mutationProtein
{
    my $prt=shift;
    my $protein=shift;
    my $str=$prt->getProtein()." chromosome:CADRE:".$prt->getChr().":".$prt->getStart().":".$prt->getEnd().":".$prt->getStrand()." gene:".$prt->getGene()." transcript:".$prt->getTranscript()."\n".$protein."\n";
    return $str;
}
sub printVariations
{
    my $variations=shift;
    for(my $i=0;$i<@$variations;$i++)
    {
        print "\ni:$i";
        print "\nPos:".$variations->[$i]->getPOS()." Ref:".$variations->[$i]->getRef()." Alt:".$variations->[$i]->getAlt();
    }
}

sub relaceMutation
{
    my $variations=shift;
    my $p=shift;
    my $gffp=shift;
    
    my $seq=$p->getSeq();
    my $start=$p->getStart();
    my $end=$p->getEnd();
    
    my $replaced_seq="";
    print "\nOriginal:\n".$seq;
    print "\nNo. of variations:".@$variations;
    for(my $i=0;$i<@$variations;$i++)
    {
        my $ref=$variations->[$i]->getRef();
        my $alt=$variations->[$i]->getAlt();
        if($alt=~m/,/g)
        {
            #dont process it for time being
        }
        else
        {
            my $back_nucl=0;
            my $length=0;
            print "\nPOS:".$variations->[$i]->getPOS();
            if($i>0)
            {
                #substr will be from [$i-1]->pos with length [$i]->pos-[$i-1]->pos-1
                $back_nucl=($variations->[$i-1]->getPOS())-$start+length($variations->[$i-1]->getRef());
                $length=($variations->[$i]->getPOS())-($variations->[$i-1]->getPOS())-1;
            }
            else
            {
                $length=($variations->[$i]->getPOS())-$start;
            }
            my $substr = substr($seq,$back_nucl,$length);
            print "\nSubSTR from $back_nucl with length $length :\n".$substr;
            $replaced_seq=$replaced_seq.$substr.$alt;
        }
    }
    my $substr = substr($seq,($variations->[$i-1]->getPOS()-$start+length($variations->[$i-1]->getRef())));
    print "\nSubSTR from ".$variations->[$i]->getPOS().":\n".$substr;
    $replaced_seq=$replaced_seq.$substr;
    
    print "\nStart:$start, End:$end";
    printVariations($variations);
    
    print "\nMutated:".$replaced_seq;
    my $CDSs=$gffp->getGFFByPosition($p->getStart(),$p->getEnd(),$p->getChr());
    
    print "\nNo of CDS:".@$CDSs;
    my $exon=getExon($replaced_seq,$CDSs,$p->getStart());
    print "\nEXON:\n$exon";
    return $exon;
}

sub getExon
{
    my $seq=shift;
    my $CDSs=shift;
    my $start=shift;
    
    my $exon="";
    print "\nin GetExon";
    for(my $i=0;$i<@$CDSs;$i++)
    {
        my $str=substr($seq,(($CDSs->[$i]->getStart())-$start),(($CDSs->[$i]->getEnd())-($CDSs->[$i]->getStart())+1));
        print "\n EXON, substr: $str";
        $exon=$exon.$str;
    }
    return $exon;
}
