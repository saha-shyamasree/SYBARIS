#!/usr/bin/perl

use ProteinSeq;

package ProteinSeqParser;


sub new
{
    my $class=shift;
    my $self = {
        _fileName=>shift,
        _proteinCodingSeq=>[],
        _seqSize=>0
    };
    
    bless $self, $class;
    return $self;
}

sub parse
{
    my ($self)=@_;
    open(READ,"<",$self->{_fileName}) if defined($self->{_fileName}) or die("\nCould not open ".$self->{_fileName});
    print "\nParsing ".$self->{_fileName};
    my @records=();
    while((my $line=<READ>))
    {
        chomp($line);
        if($line=~m/^\>/)
        {
            my @tags=split(/\s+/,$line);
            #tags are in folowing order protein_id, pep:known/unknown(optional), feature:CADRE:feature_number:start:end:starnd gene:gene_id transcript:transcript_id
            my $no_of_tags=@tags;
            my @chr_info=split(/:/,$tags[$no_of_tags-2-1]);
            #my $nucl=<READ>;
            #chomp($nucl);
            
            my $PCS=new ProteinSeq($tags[0],$chr_info[2],$chr_info[3],$chr_info[4],$chr_info[5],substr($tags[$no_of_tags-1-1],5),substr($tags[$no_of_tags-1],11),"");
            push(@records,$PCS);
        }
        else
        {
            my $last=pop(@records);
            my $last_seq=$last->getSeq();
            $last_seq=$last_seq.$line;
            $last->setSeq($last_seq);
            push(@records,$last);
        }
    }
    
    $self->{_seqSize}=scalar @records;
    $self->{_proteinCodingSeq}=\@records;
    print "\nTotal Protein:".$self->{_seqSize};
}
sub parseOld
{
    my ($self)=@_;
    open(READ,"<",$self->{_fileName}) if defined($self->{_fileName}) or die("\nCould not open ".$self->{_fileName});
    print "\nParsing ".$self->{_fileName};
    my @records=();
    while((my $line=<READ>))
    {
        chomp($line);
        if($line=~m/^\>/)
        {
            my @tags=split(/\s+/,$line);
            #tags are in folowing order protein_id, pep:known/unknown(optional), chromosome:CADRE:chr_number:start:end:starnd gene:gene_id transcript:transcript_id
            my $no_of_tags=@tags;
            my @chr_info=split(/:/,$tags[$no_of_tags-2-1]);
            my $ch="";
            if($chr_info[2]=~m/^I$|^1$/)
            {
                $ch="1";
            }
            elsif($chr_info[2]=~m/^II$|^2$/)
            {
                $ch="2";
            }
            elsif($chr_info[2]=~m/^III$|^3$/)
            {
                $ch="3";
            }
            elsif($chr_info[2]=~m/^IV$|^4$/)
            {
                $ch="4";
            }
            elsif($chr_info[2]=~m/^V$|^5$/)
            {
                $ch="5";
            }
            elsif($chr_info[2]=~m/^VI$|^6$/)
            {
                $ch="6";
            }
            elsif($chr_info[2]=~m/^VII$|^7$/)
            {
                $ch="7";
            }
            elsif($chr_info[2]=~m/^VIII$|^8$/)
            {
                $ch="8";
            }
            #my $nucl=<READ>;
            #chomp($nucl);
            
            my $PCS=new ProteinSeq($tags[0],$ch,$chr_info[3],$chr_info[4],$chr_info[5],substr($tags[$no_of_tags-1-1],5),substr($tags[$no_of_tags-1],11),"");
            push(@records,$PCS);
        }
        else
        {
            my $last=pop(@records);
            my $last_seq=$last->getSeq();
            $last_seq=$last_seq.$line;
            $last->setSeq($last_seq);
            push(@records,$last);
        }
    }
    
    $self->{_seqSize}=scalar @records;
    $self->{_proteinCodingSeq}=\@records;
    print "\nTotal Protein:".$self->{_seqSize};
}

sub getFileName
{
    my ($self)=@_;
    return $self->{_fileName};
}

sub getSeqSize
{
    my ($self)=@_;
    return $self->{_seqSize};
}


sub getProteinSeq
{
    my ($self)=@_;
    return $self->{_proteinCodingSeq};
}

sub getProteinSeqByIndex
{
    my ($self,$ind)=@_;
    return ($self->{_proteinCodingSeq})->[$ind];
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