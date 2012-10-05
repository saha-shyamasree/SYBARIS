#!/usr/bin/perl

use VCFRecord;

package VCFParser;

sub new
{
    my $class = shift;
    my $self = {
                _fileName=>shift,
                _records=>[]
            };
    bless $self, $class;
    return $self;
}

sub setFileName
{
    my ($self, $fileName) = @_;
    $self->{_fileName}=$fileName if defined($fileName);
}

sub getVCFRecords
{
    my ($self) = @_;
    
    my $r=$self->{_records};
    my @records=@$r;
    return \@records;
}

sub getVCFRecordsByPosition
{
    my ($self,$start,$end,$chr) = @_;
    my @rec=();
    my $r=$self->{_records};
    my @records=@$r;
    #print "\nStart:$start, End:$end, Chromosome:$chr";
    #print "\n In by position".@records;
    
    for(my $i=0;$i<@records;$i++)
    {
        if(ref($records[$i]))
        {
            
            if(($records[$i])->getFeat()=~m/\Q$chr\E/)
            {
                
                my $pos=$records[$i]->getPOS();
                #print "\ndefined VCF record I:".$records[$i]->getChr()."  pos:".$pos;
                if($start<=$pos&&$pos<=$end)
                {
                    #print "\n Within Limit";
                    push @rec,$records[$i];
                }
                else
                {
                    if($pos>$end)
                    {
                        last;
                    }
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

sub read
{
    my ($self) = @_;
    open(VCF,"<",$self->{_fileName}) if defined($self->{_fileName}) or die("Could not open ".$self->{_fileName});
    my @records=();
    while((my $line=<VCF>))
    {
        if($line!~m/^\#/)
        {
            my @fields=split(/\t/,$line);
            #$fields[0]=~s/Chr(\d).*/$1/g;
            #print "\nChromosome:".$fields[0];
            my $rec=new VCFRecord(@fields);
            push @records, $rec;
            #print "\n Number of fields: ".@fields;
        }
    }
    print "\n Number of variation:".@records;
    $self->{_records}=\@records;
    close(VCF)
}

sub printVCFRecords
{
    my ($self) = @_;
    
    my $r=$self->{_records};
    my @records=@$r;
    
    foreach my $rec (@records)
    {
        $rec->printVCF();
    }
}

1;