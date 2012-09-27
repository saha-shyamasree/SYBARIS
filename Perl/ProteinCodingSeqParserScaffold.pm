#!/usr/bin/perl

use ProteinCodingSeqScaffold;

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
            #tags are in folowing order protein_id, pep:known/unknown, chromosome:CADRE:chr_number:start:end:starnd gene:gene_id transcript:transcript_id
            my @scf_info=split(/:/,$tags[2]);
            my $nucl=<READ>;
            chomp($nucl);
            
            my $PCS=new ProteinCodingSeqScaffold($tags[0],$scf_info[2],$scf_info[3],$scf_info[4],$scf_info[5],substr($tags[3],5),substr($tags[4],11),$nucl);
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