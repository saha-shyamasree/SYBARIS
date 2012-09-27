#!/usr/bin/perl

package GFF;

sub new
{
    my $class = shift;
    my $self = {
        _chr=>shift,
        _method=>shift,
        _start=>shift,
        _end=>shift,
        _strand=>shift,
    };
    bless $self, $class;
    return $self;
}

sub setChr
{
    my ($self,$c) = @_;
    $self->{_chr} = $c if defined($c);
}

sub setMethod
{
    my ($self,$c) = @_;
    $self->{_method} = $c if defined($c);
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

sub setStrand
{
    my ($self,$c) = @_;
    $self->{_strand} = $c if defined($c);
}

sub getChr
{
    my ($self) = @_;
    return $self->{_chr};
}

sub getMethod
{
    my ($self) = @_;
    return $self->{_method};
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
1;