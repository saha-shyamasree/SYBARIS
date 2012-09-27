#!/usr/bin/perl

use ProteinCodingSeq;

package ProteinCodingSeqParser;


sub new
{
    my $class=shift;
    my $self = {
                _fileName=>shift,
                _proteinCodingSeq=>[]
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
        if($line=~m/^\>/)
        {
            my @tags=split(/\s+/,$line);
            #tags are in folowing order protein_id, pep:known/unknown, feature:CADRE:feature_number:start:end:starnd gene:gene_id transcript:transcript_id
            my @chr_info=split(/:/,$tags[2]);
            my $nucl=<READ>;
            chomp($nucl);
            
            my $PCS=new ProteinCodingSeq($tags[0],$chr_info[2],$chr_info[3],$chr_info[4],$chr_info[5],substr($tags[3],5),substr($tags[4],11),$nucl);
            push(@records,$PCS);
        }
    }
    $self->{_proteinCodingSeq}=\@records;
}

sub getFileName
{
    my ($self)=@_;
    return $self->{_fileName};
}

sub getProteinCodingSeq
{
    my ($self)=@_;
    return $self->{_proteinCodingSeq};
}
sub printProteinCodingSeqArray
{
    my ($self) = @_;
    my $r=$self->{_proteinCodingSeq};
    my @records=@$r;
    for(my $i=0;$i<@records;$i++)
    {
        $records[$i]->printProteinCodingSeq();
    }
}
1;