package GTF;
use strict;
use warnings;

sub new {
    my $class = shift;
    my $self = {
        _feat=>shift,
        _source=>shift,
        _type=>shift,
        _start=>shift,
        _end=>shift,
        _score=>shift,
        _strand=>shift,
        _frame=>shift,
        _attribute=>shift
    };
    bless $self, $class;
    return $self;
}

sub setFeat
{
    my ($self,$c) = @_;
    $self->{_feat} = $c if defined($c);
}

sub setStart
{
    my ($self,$c) = @_;
    $self->{_start} = $c if defined($c);
}

sub setEnd
{
    my ($self,$c) = @_;
    $self->{_end} = $c if defined($c);
}


sub setScore
{
    my ($self,$c) = @_;
    $self->{_score} = $c if defined($c);
}

sub setStrand
{
    my ($self,$c) = @_;
    $self->{_strand} = $c if defined($c);
}


sub setFrame
{
    my ($self,$c) = @_;
    $self->{_frame} = $c if defined($c);
}


sub setAttribute
{
    my ($self,$c) = @_;
    $self->{_attribute} = $c if defined($c);
}

sub getType
{
    my ($self) = @_;
    return $self->{_type};
}

sub getSource
{
    my ($self) = @_;
    return $self->{_source};
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

sub getScore
{
    my ($self) = @_;
    return $self->{_score};
}

sub getStrand
{
    my ($self) = @_;
    return $self->{_strand};
}

sub getFrame
{
    my ($self) = @_;
    return $self->{_frame};
}

sub getAttribute
{
    my ($self) = @_;
    return $self->{_attribute};
}

1;
