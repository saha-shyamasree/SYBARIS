#!/usr/bin/perl

use GFF;

package GFFParser;


sub new
{
    my $class=shift;
    my $self = {
        _fileName=>shift,
        _gff=>[]
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
            my @tags=split(/\s+/,$line);
            #tags are in folowing order ref_seq,source,method/type,start,end,score,strand,phase,group
            $tags[0]=~s/Chr(\d).*/$1/;
            if($tags[2]=~m/CDS/)
            {
                my $gff=new GFF($tags[0],$tags[2],$tags[3],$tags[4],$tags[6]);
                push(@records,$gff);
            }
        }
    }
    $self->{_gff}=\@records;
}

sub getGFF
{
    my ($self)=@_;
    return $self->{_gff};
}


sub getGFFByPosition
{
    my ($self,$start,$end,$chr) = @_;
    my @rec=();
    my $r=$self->{_gff};
    my @records=@$r;
    print "\nin GFFPARSER Start:$start, End:$end, Chromosome:$chr";
    #print "\n In by position".@records;
    
    for(my $i=0;$i<@records;$i++)
    {
        if(ref($records[$i]))
        {
            print "\nChromosome of this CDS:".($records[$i])->getChr();
            if(($records[$i])->getChr()=~m/\Q$chr\E/)
            {
                
                my $st=$records[$i]->getStart();
                my $ed=$records[$i]->getEnd();
                #print "\ndefined VCF record I:".$records[$i]->getChr()."  pos:".$pos;
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
1;