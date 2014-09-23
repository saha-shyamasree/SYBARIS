package GTFParser;
use strict;
use warnings;
use GTF;

sub new {
    my $class = shift;
    my $self = {
            _fileName=>shift,
            _gtf=>[]
        };
    bless $self, $class;
    return $self;
}
sub parse
{
    my ($self)=@_;
    open(READ,"<",$self->{_fileName}) if defined($self->{_fileName}) or die("\nCould not open ".$self->{_fileName});
    my @records=();
    while((my $line=<READ>))
    {
        chomp($line);
        if($line!~m/^\#/)
        {
            #my @tags=split(/\s{2,}/,$line);
            my @tags=split(/\t/,$line);
            #tags are in folowing order feature(chr,scaff,contig),source,type(CDS,exon),start,end,score,strand,frame,attribute
            if($tags[1]=~m/protein_coding/)
            {

                if($tags[2]=~m/CDS/)
                {
                    my $gtf=new GTF($tags[0],$tags[1],$tags[2],$tags[3],$tags[4],$tags[5],$tags[6],$tags[7],$tags[8]);
                    push(@records,$gtf);
                }
            }
            else
            {
                if($tags[2]=~m/exonic_part/)
                {
                    my $gtf=new GTF($tags[0],$tags[1],$tags[2],$tags[3],$tags[4],$tags[5],$tags[6],$tags[7],$tags[8]);
                    push(@records,$gtf);
                }
            }
        }
    }
    $self->{_gtf}=\@records;
}
sub printGTF
{
    my ($self)=@_;
    my $arr_ref=$self->{_gtf};
    foreach my $k (@$arr_ref)
    {
        print "\nAttr:".$k->getAttribute();
        #exit();
    }
}
sub getGTF
{
    my ($self)=@_;
    return $self->{_gtf};
}

sub getGTFByPosition
{
    my ($self,$start,$end,$feat) = @_;
    my @rec=();
    my $r=$self->{_gtf};
    my @records=@$r;
    print "\nin GTFPARSER Start:$start, End:$end, Feature:$feat";
    #print "\n In by position".@records;
    
    for(my $i=0;$i<@records;$i++)
    {
        if(ref($records[$i]))
        {
            #print "\nFeature of this CDS:".($records[$i])->getFeat();
            if(($records[$i])->getFeat()=~m/\Q$feat\E/)
            {
                
                my $st=$records[$i]->getStart();
                my $ed=$records[$i]->getEnd();
                #print "\ndefined VCF record I:".$records[$i]->getFeat()."  pos:".$pos;
                if($start<=$st&&$ed<=$end)
                {
                    #print "\n Within Limit";
                    print "\nExon:start:".$records[$i]->getStart()."\tend:".$records[$i]->getEnd();
                    push @rec,$records[$i];
                }
            }
        }
        else
        {
            print "\n not ref :".$records[$i];
        }
    }
    #print "\n Within Limit:".@rec." variations";
    return \@rec;
}
sub overlapCheck
{
    my $start=shift;
    my $end=shift;
    my $st=shift;
    my $ed=shift;
    my $direction=shift;
    my $distance=shift;
}

sub getNearestExon
{
    my ($self,$start,$end,$feat) = @_;
    my @rec=();
    my $r=$self->{_gtf};
    my @records=@$r;
    print "\nin GTFPARSER Start:$start, End:$end, Feature:$feat";
    print "\nNumber of Exonic part:".@records;

    my $closeExon=new GTF("","","","","","","","","");
    #initialize direction to -2 as -1 will mean closest n left, 0 will mean overlapping and +1 will mean closest exon on right
    my $direction=-2;
    #distance should be >=0
    my $distance=-1;
    for(my $i=0;$i<@records;$i++)
    {
        if(ref($records[$i]))
        {
            #print "\nFeature of this exon:".($records[$i])->getFeat();
            
            if(($records[$i])->getFeat() eq "$feat")
            {
                
                my $st=$records[$i]->getStart();
                my $ed=$records[$i]->getEnd();
                if($st<=$ed)
                {
                   #on left
                    if($start>$ed)
                    {
                        print "\nChromosome match,left";
                        my $t_distance=$start-$ed;
                        if($distance==-1||$t_distance<$distance)
                        {
                            $direction=-1;
                            $distance=$t_distance;
                            $closeExon=$records[$i];
                        }
                    }
                    else
                    {
                        #overlap
                        if(($start<=$st&&$ed<=$end)||($start>=$st&&$ed>=$end)||($start<=$st&&$ed>=$end)||($start>=$st&&$ed<=$end))
                        {
                            print "\nChromosome match,overlap";
                            my $t_distance=0;
                            if($distance==-1||$t_distance<$distance)
                            {
                                $direction=0;
                                $distance=$t_distance;
                                $closeExon=$records[$i];
                            }
                        }
                        else
                        {
                            #on right
                            if($end<$st)
                            {
                                print "\nChromosome match,right";
                                my $t_distance=$st-$end;
                                if($distance==-1||$t_distance<$distance)
                                {
                                    $direction=-1;
                                    $distance=$t_distance;
                                    $closeExon=$records[$i];
                                }
                            }
                            else
                            {
                                die("\n CHeck Condition, start:".$start." end:".$end." st:".$st." ed:".$ed);
                            }
                        }
                    } 
                }
                else
                {
                    die("start is greater than end");
                }
                
            }
        }
    }
    return $closeExon;
}

1;
