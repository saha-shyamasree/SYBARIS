#!/usr/bin/perl

package ProteinCodingSeq;

sub new
{
    my $class = shift;
    my $self = {
                _protein=>shift,
                _feat=>shift,
                _start=>shift,
                _end=>shift,
                _strand=>shift,
                _gene=>shift,
                _transcript=>shift,
                _seq=>shift
    };
    bless $self, $class;
    return $self;
}

sub setProtein
{
    my ($self,$p) = @_;
    $self->{_protein} = $p if defined($p);
}

sub setFeat
{
    my ($self,$c) = @_;
    $self->{_feat} = $c if defined($c);
}

sub setStart
{
    my ($self,$s) = @_;
    $self->{_start} = $s if defined($s);
}

sub setEnd
{
    my ($self,$e) = @_;
    $self->{_end} = $e if defined($e);
}

sub setStrand
{
    my ($self,$s) = @_;
    $self->{_strand} = $s if defined($s);
}

sub setGene
{
    my ($self,$g) = @_;
    $self->{_gene} = $g if defined($g);
}

sub setTranscript
{
    my ($self,$t) = @_;
    $self->{_transcript} = $t if defined($t);
}

sub setSeq
{
    my ($self,$s) = @_;
    $self->{_seq} = $s if defined($s);
}




sub getProtein
{
    my ($self) = @_;
    return $self->{_protein};
}

sub getFeat
{
    my ($self) = @_;
    return $self->{_feat};
}

sub getStart
{
    my ($self) = @_;
    return $self->{_start};
}

sub getEnd
{
    my ($self) = @_;
    return $self->{_end};
}

sub getStrand
{
    my ($self) = @_;
    return $self->{_strand};
}

sub getGene
{
    my ($self) = @_;
    return $self->{_gene};
}

sub getTranscript
{
    my ($self) = @_;
    return $self->{_transcript};
}

sub getSeq
{
    my ($self) = @_;
    return $self->{_seq};
}


sub printProtein
{
    my ($self) = @_;
    print $self->{_protein};
}

sub printFeat
{
    my ($self) = @_;
    print $self->{_feat};
}

sub printStart
{
    my ($self) = @_;
    print $self->{_start};
}

sub printEnd
{
    my ($self) = @_;
    print $self->{_end};
}

sub printStrand
{
    my ($self) = @_;
    print $self->{_strand};
}

sub printGene
{
    my ($self) = @_;
    print $self->{_gene};
}

sub printTranscript
{
    my ($self) = @_;
    print $self->{_transcript};
}

sub printSeq
{
    my ($self) = @_;
    print $self->{_seq};
}



sub printProteinCodingSeq
{
    my ($self) = @_;
    print "\nProtein Id:";
    $self->printProtein();
    print "\tFeature:";
    $self->printFeat();
    print "\tStart:";
    $self->printStart();
    print "\tEnd:";
    $self->printEnd();
    print "\tStrand:";
    $self->printStrand();
    print "\tGene Id:";
    $self->printGene();
    print "\tTrancript Id:";
    $self->printTranscript();
    print "\nSequence:";
    $self->printSeq();
}

1;